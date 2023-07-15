const { expect } = require("chai");

describe("Registration", function () {
  let registration;
  let owner;
  let user1;
  let user2;

  beforeEach(async function () {
    const Registration = await ethers.getContractFactory("Registration");
    [owner, user1, user2] = await ethers.getSigners();

    registration = await Registration.deploy();
    await registration.deployed();
  });

  it("should register a complaint", async function () {
    const complaint = "This is a test complaint";

    await registration.connect(user1).register(complaint);
    const user1Complaint = await registration.getComplaints(1);

    expect(user1Complaint.complaint).to.equal(complaint);
    expect(user1Complaint.user).to.equal(user1.address);
    expect(user1Complaint.resolved).to.equal(false);
  });

  it("should resolve a complaint", async function () {
    const complaint = "This is a test complaint";

    await registration.connect(user1).register(complaint);
    await registration.connect(owner).resolved(1);
    const user1Complaint = await registration.getComplaints(1);

    expect(user1Complaint.resolved).to.equal(true);
  });
});