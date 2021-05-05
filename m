Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6CEB1374878
	for <lists+linux-kernel@lfdr.de>; Wed,  5 May 2021 21:09:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235305AbhEETKk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 5 May 2021 15:10:40 -0400
Received: from mail-bn8nam12on2045.outbound.protection.outlook.com ([40.107.237.45]:5760
        "EHLO NAM12-BN8-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S231422AbhEETKi (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 May 2021 15:10:38 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Av2fYa36KAOM+EQguW1PPutDSh7KFGinG6aVq3iIA0TV0iiIh5lwpFMUx+IG6WaC9QUzDxVwO2XAq8RPTmN8DDWJ/To9PNoueXCKlFGBZdRwIcfdeD8tx52R4D01B3gnFK7/nVT0NTJyJm385l2A8rRpEuMsBBUvFC2Q/k5gdH1o+h+P4sB9Jg/4xVrx6HBCimFKR2WTQpDkuCFcIYFzh8K4qwYXYvV30TpYbx9LxNRXjbMmJf0NUhvGtiTKsMCSzSeC3f6CHPH2JcosHmXD19S6PnEY8LLZHcWcdFBJAXVA2j9s+CcVNfZ1OTX2bhWMjNN4lZPkmv0puWczTtxBEQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=a9budMCsju52IgiyNJnJNSyAnAhKxV8vGyD+wN1O9Dg=;
 b=LCqj+DL6hOfDE+hRn0kWBrMEJ9UP/tHg2V4PGOgO0GJEemN++2O1mmre6p0YPeqioq92peXacKP2oBesVmkwUmvKWV0P8Wpb/snAZ4JxmSSVQTauyOInjuoWQ6uZiAULFtK/m1eV21t5i5z12Dk89IJ4l9FWgfBK855RQAbDDV15VA3SjiN3GFcvVgx+l1Ph7dwk46GtJXqC2NL412ScajHQH3EVkVZxRB6xwFOFaDBi+4rFGW1fcwX42OvDuBDkb0m3qpjG+Znwqzl6dfLxTQxl2Fz8QHXPzH+LwdvncbMZGMEu9+Ke19padM493TAfktiomNES85jIjT3UhLgeww==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=none sp=none pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=a9budMCsju52IgiyNJnJNSyAnAhKxV8vGyD+wN1O9Dg=;
 b=wN8l32RvpSM1zPCZ7RESaTDqb449bTyeJsWAYqkRYKnIed5Ynkat1VXHfjcR02gtW9LevcpizcOkpgAA8+UDlD7BtSBZOYBV36O2DNu4gyDB1JIoTL3P3dT5rPWbcnLZO4m3lnK7NlYzZqwN0iwiTFc+lx+LTvZ66eFRRBVtROY=
Received: from BN9PR03CA0046.namprd03.prod.outlook.com (2603:10b6:408:fb::21)
 by MN2PR12MB3967.namprd12.prod.outlook.com (2603:10b6:208:16c::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4108.26; Wed, 5 May
 2021 19:09:35 +0000
Received: from BN8NAM11FT006.eop-nam11.prod.protection.outlook.com
 (2603:10b6:408:fb:cafe::d0) by BN9PR03CA0046.outlook.office365.com
 (2603:10b6:408:fb::21) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4108.25 via Frontend
 Transport; Wed, 5 May 2021 19:09:35 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com;
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN8NAM11FT006.mail.protection.outlook.com (10.13.177.21) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.4108.25 via Frontend Transport; Wed, 5 May 2021 19:09:35 +0000
Received: from rsaripalli-Inspiron-5676.amd.com (10.180.168.240) by
 SATLEXMB04.amd.com (10.181.40.145) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2242.4; Wed, 5 May 2021 14:09:34 -0500
From:   Ramakrishna Saripalli <rsaripal@amd.com>
To:     <linux-kernel@vger.kernel.org>, <x86@kernel.org>,
        <tglx@linutronix.de>, <mingo@redhat.com>, <bp@alien8.de>,
        <hpa@zytor.com>
CC:     <bsd@redhat.com>, <rsaripal@amd.com>
Subject: [PATCH v5 0/1] Introduce support for PSF control.
Date:   Wed, 5 May 2021 14:09:22 -0500
Message-ID: <20210505190923.276051-1-rsaripal@amd.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 86f469a1-87c9-411d-c4b9-08d90ff952b2
X-MS-TrafficTypeDiagnostic: MN2PR12MB3967:
X-Microsoft-Antispam-PRVS: <MN2PR12MB396766DFB0EBB914103A6B7A9B599@MN2PR12MB3967.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:10000;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: y9QQ/szV9m1bCde2Wb0jMQ0XYAFX2Ch2Kk8C3Kv5Q+AtzDMSBef16z5GXEhqpjG+2EMRVWIEwrVksMEh3h2dM92nIORm52/+RZANy5wwO4q46hjm5wI/sIHD46Oq2fBkMPS4OQww0bd0j3JXCVgXWVn74ROOTCU7DEXslc0HS5SLKtnxMNCQrbGFvCNUTrzGtgAGuw4ZVcdVx0N2FrjFawq+42CzvTlx8oJA5sX7Jue3HW+PG5n0vcx7mGA8Tucmri95EZPywZBsynWtXCZ1TX7+ikjuKq9qF3pxB6AJxpKdqF5K5uuJIf86BTlzA6umfIq5LPuXM89DSsxMKP1o8FfchSXjhhSJYndD1dzyGgAyhz8YjD24lgnvCnE+cqUnRa7E1gnQdU6KYYwT04c7GN3RkSnO1TeIZcsRwWTbFNj8vEMsoVHqhFUuY5Rt/qMH1h5Pb7ljqOijhtOnjr0IRf9PQxczKnQ5QtAyaSBJaFy4mjLfsyRyGAkVDJl1lCRZ/lSmEehwr31sapi0Bsj/qZb0CxI2L4UFoXVW4CWgkajnZ0qe4FabLBGNySvTktk+4+JJXp+g4n7B7CKPlUTQR6q7UOUYj2nXRn6ZkCzuaaRq+Jfdge3JPGuJpK0zJP43R5m6SR5XZAwLlS397Qt93p6O/6QpFVp0Z4dI27jWpzMnapY5lHQXqiuCsmW6xGq8MpZZETcBUb6MV8tvBOJsNFaeBHwrKAXzBy+yj2QCoFnQ43U2LzaHFJURLoOsxzvk2Gi2Gr6hKAm+D6pg2zrg1A==
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(4636009)(346002)(376002)(136003)(39850400004)(396003)(46966006)(36840700001)(4326008)(47076005)(6666004)(82310400003)(336012)(966005)(2906002)(70586007)(26005)(36860700001)(5660300002)(70206006)(186003)(2616005)(16526019)(81166007)(110136005)(356005)(1076003)(83380400001)(316002)(426003)(36756003)(7696005)(54906003)(478600001)(8936002)(82740400003)(8676002)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 May 2021 19:09:35.7906
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 86f469a1-87c9-411d-c4b9-08d90ff952b2
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT006.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB3967
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

Testing notes:
- Tested on Milan processor with the following kernel parameters
    - [spec_control_bypass_disable = {off,on}] with 
       [predict_spec_fwd={off,on}]
      and verified SPEC_CTRL_MSR value (0x48) on all CPUs is the same
      and reflects the kernel parameters

      Modified kernel to not set STIBP unconditionally (Bit 1) and 
      verified the SPEC_CTRL_MSR with the same kernel parameters
      
      Disabled all features that write to MSR_IA32_SPEC_CTRL and toggled
      predict_store_fwd. Verified MSR_IA32_SPEC_CTRL and x86_spec_ctrl_base
      are set properly

- Tested on Rome systems (PSF feature is not supported)
    Verified SPEC_CTRL_MSR MSR value on all logical CPUs.

ChangeLogs:
    V5->V4:
          Replaced rdmsrl and wrmsrl for setting SPEC_CTRL_PSFD with 
             a single call to msr_set_bit.
          Removed temporary variable to read and write the MSR
    V4->V3:
     	  Write to MSR_IA32_SPEC_CTRL properly
     	     Read MSR, modify PSFD bit based on kernel parameter and
     	     write back to MSR.
     	     
	     Changes made in psf_cmdline() and check_bugs().
    V3->V2:
          Set the X86_FEATURE_SPEC_CTRL_MSR cap in boot cpu caps.
          Fix kernel documentation for the kernel parameter.
          Rename PSF to a control instead of mitigation.

    V1->V2:
        - Smashed multiple commits into one commit.
        - Rename PSF to a control instead of mitigation.

    V1:
        - Initial patchset.
        - Kernel parameter controls enable and disable of PSF.



Ramakrishna Saripalli (1):
  x86/cpufeatures: Implement Predictive Store Forwarding control.

 .../admin-guide/kernel-parameters.txt         |  5 +++++
 arch/x86/include/asm/cpufeatures.h            |  1 +
 arch/x86/include/asm/msr-index.h              |  2 ++
 arch/x86/kernel/cpu/amd.c                     | 19 +++++++++++++++++++
 arch/x86/kernel/cpu/bugs.c                    |  6 +++++-
 5 files changed, 32 insertions(+), 1 deletion(-)


base-commit: 0e16f466004d7f04296b9676a712a32a12367d1f
-- 
2.25.1

