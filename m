Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 595BC368597
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Apr 2021 19:11:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238140AbhDVRL1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 22 Apr 2021 13:11:27 -0400
Received: from mail-mw2nam10on2087.outbound.protection.outlook.com ([40.107.94.87]:47585
        "EHLO NAM10-MW2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S236684AbhDVRLZ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Apr 2021 13:11:25 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=UKZG9hnuri8MOb4eHZHEgGafZ38y2ua1w6LHP4ku26t+keUNqMEndANhtdlF38pASogbE3l417WL3RJeWrmal2ETt0+5jnHw9SXF3csOvEcjr90dMIUIAEqJb9t28p8c0mT44vamOqafh4OjrdjThDbwo3tV/CyIbWVck3I6+TrHQ31jikwdwpcAX6nl7BXQwD4fi5YaIELY7pQS2zwibn29g9Bn9qCRcxNBBKcjDvIY8nA1X4LP6WcNMIdXru4Vxlbx4btIGyfH8N2GRH/6Z9ApF6yJVZrHIkVZp5vmSddNcRnrbc9mIoJV2Lv0KfI3Pv9AhH3I6JnuxdrtyMckdQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=svWTyMah9A5ED4smAbI9SSWQgTHnSIxc5+1e8mR3LX0=;
 b=GfHO2j69e/WkRh9cIw+hXTLwDNOa0J+f9jHeo/YWMRoQgs4J6ZH6HH9bgOzsawXZFYjsak85CqI0D+hPcYK3/N81vcg13L3IV0F9bPGRT9gnuef663WPWKH0vL5FrO8/YLNcd39y28yOEoh8U0GqVTTyEX2zOQAGAmcuNOP5DvIN32B4crK6MgVnep3u6IEu+MQq5PVtP/FASQ8NudkB8Kf9sHVoaV1DppT8sy3PxMMRr6KUsFxvu6x0nQJEL1sNoR2m5V1qPWSGYO7rW8r1TikVp4bo+/smQdD0OaXtsIR+dAZjCvnzrC9YwcokjVqDFFg4nXxcLWqZFoNWfV5QLA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=none sp=none pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=svWTyMah9A5ED4smAbI9SSWQgTHnSIxc5+1e8mR3LX0=;
 b=10wISQxBorHuHGzeaH7IB8n77ofx3LUapahHZXTK7N4JQUMORqzdAW/w4iWboWpU2vF+s+AOxgAsBSxa/T39esV/rwPaR94blI6RrmrQjQec0B9uyZrwc+tTpXZ5PC+ouZF4WkKcHU+pbEtD9VTU0z8hKTNb+LNQ4n6Eb6yTX0s=
Received: from DM5PR21CA0064.namprd21.prod.outlook.com (2603:10b6:3:129::26)
 by MWHPR12MB1568.namprd12.prod.outlook.com (2603:10b6:301:e::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4042.16; Thu, 22 Apr
 2021 17:10:48 +0000
Received: from DM6NAM11FT016.eop-nam11.prod.protection.outlook.com
 (2603:10b6:3:129:cafe::84) by DM5PR21CA0064.outlook.office365.com
 (2603:10b6:3:129::26) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4087.10 via Frontend
 Transport; Thu, 22 Apr 2021 17:10:47 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com;
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DM6NAM11FT016.mail.protection.outlook.com (10.13.173.139) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.4065.21 via Frontend Transport; Thu, 22 Apr 2021 17:10:47 +0000
Received: from rsaripalli-Inspiron-5676.amd.com (10.180.168.240) by
 SATLEXMB04.amd.com (10.181.40.145) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2242.4; Thu, 22 Apr 2021 12:10:45 -0500
From:   Ramakrishna Saripalli <rsaripal@amd.com>
To:     <linux-kernel@vger.kernel.org>, <x86@kernel.org>,
        <tglx@linutronix.de>, <mingo@redhat.com>, <bp@alien8.de>,
        <hpa@zytor.com>
CC:     <bsd@redhat.com>, <rsaripal@amd.com>
Subject: [v2 0/1] Introduce support for PSF control.
Date:   Thu, 22 Apr 2021 12:10:12 -0500
Message-ID: <20210422171013.50207-1-rsaripal@amd.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 2c15ef5f-9111-4dba-5d7c-08d905b19279
X-MS-TrafficTypeDiagnostic: MWHPR12MB1568:
X-Microsoft-Antispam-PRVS: <MWHPR12MB15684FCA14A100E2F4CD1DC09B469@MWHPR12MB1568.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:10000;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: quo+qwUSj9jtqM2pjP4l3musGyHYGlS7CqbAjBiBbwoynwNkYgDRw7F3mXwmdm+5B9WZCykeZuFF6oALsmgRpZIUia60t1L4wOMauVG9bryv28asIVp2lZkETT/jvfqNQo2q6i/J3DK+/Pgc9fMbF46clPL7ly7OduDSc68fcQwQhJIinjlYg49WLoHl6bsurEzJ/bcy2P4nYQIEVOr61DpQGGp1qUCuk3gwcD2GMYQuIwzG1SoxQV2iksDw6cS3hezP8OgBVpQ85j3Dyq/p6HIVbysIZw6SoNinrzUkyJi5Q0Oe/dVGus5/Yh+Tbw14PXI6xuE/8PMKsmT068qdeh58jW75Asoxc6POPWXs0pBkaVa93b1BICOqUuTqQDazm+2VSXkl8I8uLeuzdWDbxQ4iTP+2M5RS63UUNhfUWc7e06NVMbgJALEqBkVYpb1QVQ26YUYdX48K97h5tlh94cJ8Ls424bs9Oq8z0XF32ThefXzUsXTo5zfzqKHyXToU8Dx/uLredU+RGlvfh1X/Zbk4oWic8KKpeWH/pX31BJ9SdCl2zJnmPejl+xdYiIAKGj3BWY3eNv985ZyY2Cbg0V0cO6U64YHlkP9rjLvmMb3q4chID9ZghO7KwcJh6hqgcsVjtZEvS4PKrQuS7JXx5dsq1ONt5j/vVccp18HCbXK4U6mYgmobhKejT7iQcBo9ueTY8hjlwMx/by/59L2B7gtiQogqrZMeQfa8jBiYP8i8oCsNg4YqZ/tk4IDDMxA+mNrLCf6ccUHl/C9mpqaoIA==
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(4636009)(39860400002)(376002)(396003)(136003)(346002)(36840700001)(46966006)(36860700001)(82310400003)(81166007)(1076003)(16526019)(82740400003)(186003)(110136005)(966005)(70206006)(36756003)(70586007)(6666004)(4326008)(7696005)(8676002)(478600001)(26005)(356005)(5660300002)(2616005)(83380400001)(8936002)(336012)(2906002)(426003)(316002)(47076005)(54906003)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Apr 2021 17:10:47.3384
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 2c15ef5f-9111-4dba-5d7c-08d905b19279
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT016.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR12MB1568
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Ramakrishna Saripalli <rk.saripalli@amd.com>

Predictive Store Forwarding:
AMD Zen3 processors feature a new technology called
Predictive Store Forwarding (PSF).

https://www.amd.com/system/files/documents/security-analysis-predictive-store-forwarding.pdf

PSF is a hardware-based micro-architectural optimization designed
to improve the performance of code execution by predicting address
dependencies between loads and stores.

How PSF works:

It is very common for a CPU to execute a load instruction to an address
that was recently written by a store. Modern CPUs implement a technique
known as Store-To-Load-Forwarding (STLF) to improve performance in such
cases. With STLF, data from the store is forwarded directly to the load
without having to wait for it to be written to memory. In a typical CPU,
STLF occurs after the address of both the load and store are calculated
and determined to match.

PSF expands on this by speculating on the relationship between loads and
stores without waiting for the address calculation to complete. With PSF,
the CPU learns over time the relationship between loads and stores.
If STLF typically occurs between a particular store and load, the CPU will
remember this.

In typical code, PSF provides a performance benefit by speculating on
the load result and allowing later instructions to begin execution
sooner than they otherwise would be able to.

Causes of Incorrect PSF:

Incorrect PSF predictions can occur due to two reasons.

First, it is possible that the store/load pair had a dependency for a
while but later stops having a dependency.  This can occur if the address
of either the store or load changes during the execution of the program.

The second source of incorrect PSF predictions can occur if there is an
alias in the PSF predictor structure.  The PSF predictor tracks
store-load pairs based on portions of their RIP. It is possible that a
store-load pair which does have a dependency may alias in the predictor
with another store-load pair which does not.

This can result in incorrect speculation when the second store/load pair
is executed.

Security Analysis:

Previous research has shown that when CPUs speculate on non-architectural
paths it can lead to the potential of side channel attacks.
In particular, programs that implement isolation, also known as
‘sandboxing’, entirely in software may need to be concerned with incorrect
CPU speculation as they can occur due to bad PSF predictions.

Because PSF speculation is limited to the current program context,
the impact of bad PSF speculation is very similar to that of
Speculative Store Bypass (Spectre v4)

Predictive Store Forwarding controls:
There are two hardware control bits which influence the PSF feature:
- MSR 48h bit 2 – Speculative Store Bypass (SSBD)
- MSR 48h bit 7 – Predictive Store Forwarding Disable (PSFD)

The PSF feature is disabled if either of these bits are set.  These bits
are controllable on a per-thread basis in an SMT system. By default, both
SSBD and PSFD are 0 meaning that the speculation features are enabled.

While the SSBD bit disables PSF and speculative store bypass, PSFD only
disables PSF.

PSFD may be desirable for software which is concerned with the
speculative behavior of PSF but desires a smaller performance impact than
setting SSBD.

Support for PSFD is indicated in CPUID Fn8000_0008 EBX[28].
All processors that support PSF will also support PSFD.

Ramakrishna Saripalli (1):
  x86/cpufeatures: Implement Predictive Store Forwarding control.

 .../admin-guide/kernel-parameters.txt         |  5 +++++
 arch/x86/include/asm/cpufeatures.h            |  1 +
 arch/x86/include/asm/msr-index.h              |  2 ++
 arch/x86/kernel/cpu/amd.c                     | 19 +++++++++++++++++++
 4 files changed, 27 insertions(+)


base-commit: 0e16f466004d7f04296b9676a712a32a12367d1f
-- 
2.25.1

