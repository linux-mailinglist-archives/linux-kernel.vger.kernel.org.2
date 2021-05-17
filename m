Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 96387386CBB
	for <lists+linux-kernel@lfdr.de>; Tue, 18 May 2021 00:01:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343521AbhEQWCw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 17 May 2021 18:02:52 -0400
Received: from mail-dm6nam11on2050.outbound.protection.outlook.com ([40.107.223.50]:42081
        "EHLO NAM11-DM6-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S238780AbhEQWCn (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 May 2021 18:02:43 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=dx5GDAd7cm14czLveBP3mqRFGMSWv05Atp2aizw9mBKP+BkeeRPZjdhFshZQ/NKjZZ05zwQSuy2sxxSzaRAJXkUuDvL1zzU3hZRmeC4+SQU7fkaXgboPO42qTmyM5ljNlPFfxV6BnSwrZ3ibM/k6l97Iw/trrSEE9xw9GI8q9XZ/s0pfGrJHoQwLMATA1JlL4jPTzmNroAIZbvy7Qcggusz0HsYNOSOBeaGl6Azm473VIdtq5zMtMvehL1C11fpCVBBEAb4CqehuPmAfsrl/m0O2KChwBXvBdgbwFaguykon4El0mO5pPSAg/4uwwqm5kKoxLf/0DUikW6r2DH0rBA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=NvEr3+aKeaoPh1E/15qQB7R87IjnM14shbS35y8lPP0=;
 b=Gdi8J5a1idKeJQM3HzdH5xTZ2ieCffWF0Oq+7KRgIWYbW/FQqL+38x6Gb1VZU5varIoQRMPnT4i5A39yp4AVoS/H0x0MAHnFEHaTDLDAb+KwoCtzpKdqwEyW8YVTkGJsxiFdI6zUZN4H3whtVwbq2C9ncUS1Y/RyB+GuYnp3gcwObtREmG+RNmd8N3gW4krO7tXYYl4R3/9trGThxHdCfFZry3VwZxwwX6Ad66OZRovxETwVMeXTXd82uzfHqQleHtPz16FzZowSzbTva6OwebuBfIi3Um4UJ2nGHDfO2P32VnQ+4MglYzVCne1Q9Sn/jLXs/Bq/SMT3ScDnSnKGnw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=none sp=none pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=NvEr3+aKeaoPh1E/15qQB7R87IjnM14shbS35y8lPP0=;
 b=v9Q1yobeu4gZcBQGhrtQJbhru1LHOovT7GweTl6CFSmaRQ4t+qmzmI94PRyvVYPY5W/lctD7xmVnbG2Q7kGRVEIxqTavNqFu0+aX6OIuCTnb70BF5VvS3GlNda163tsa0gXpGW6ESYchhAoT7EIKxYVbmP1Ukl/wfM/iCnpNRHw=
Received: from DM5PR06CA0059.namprd06.prod.outlook.com (2603:10b6:3:37::21) by
 DM6PR12MB4812.namprd12.prod.outlook.com (2603:10b6:5:1ff::24) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4129.28; Mon, 17 May 2021 22:01:24 +0000
Received: from DM6NAM11FT003.eop-nam11.prod.protection.outlook.com
 (2603:10b6:3:37:cafe::8e) by DM5PR06CA0059.outlook.office365.com
 (2603:10b6:3:37::21) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4108.24 via Frontend
 Transport; Mon, 17 May 2021 22:01:24 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com;
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DM6NAM11FT003.mail.protection.outlook.com (10.13.173.162) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.4129.25 via Frontend Transport; Mon, 17 May 2021 22:01:24 +0000
Received: from rsaripalli-Inspiron-5676.amd.com (10.180.168.240) by
 SATLEXMB04.amd.com (10.181.40.145) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2242.4; Mon, 17 May 2021 17:01:22 -0500
From:   Ramakrishna Saripalli <rsaripal@amd.com>
To:     <linux-kernel@vger.kernel.org>, <x86@kernel.org>,
        <tglx@linutronix.de>, <mingo@redhat.com>, <bp@alien8.de>,
        <hpa@zytor.com>
CC:     <bsd@redhat.com>, <rsaripal@amd.com>
Subject: [v6 0/1] Introduce support for PSF control.
Date:   Mon, 17 May 2021 17:00:57 -0500
Message-ID: <20210517220059.6452-1-rsaripal@amd.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 7b8812c1-2537-4a78-9731-08d9197f5053
X-MS-TrafficTypeDiagnostic: DM6PR12MB4812:
X-Microsoft-Antispam-PRVS: <DM6PR12MB4812BC1EA9053DE7A2F27EF99B2D9@DM6PR12MB4812.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:8273;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: FHM+uFIEpTcfNfAzwqZPRzqZY+0RQVBdn4kC1GVoX3swE9yVtatZr4S1Qv4TvMRge6zbDw6FO6/g5ilJSqkcS7sgErHxUZO8E0qeuukx3TrIizjOACgQnqsAOPBe3HnoV3c2yem62pGxyxjbcU952mF6/y/nRY33yLGcIHFzXeh/kKwvRBD+khqNYOaimbW9cRJAx9yHfif66wAGqOAKeZkbFshscrXN6Cr7GS4qNoaMgEwBwCBaDlicMSMMRqpr5Cfe7ptpZpZbNm/Lb/3sJpfy3ET061Fe9tPEQb+G+Vz07qSa8DnULggtWyUT9kfoXF7UMVUybx8UhC/J9KeCdDCmLfGvNdgDvOQS++DzOk66PpZu+qmRw9SCvkFgpjN8v529+PO1/SId4Ln/8m1bJKUWt4R8rzJMr4/py/V1DoSt7FJKPRfh3YMFG+sA5ej5gRg48/FXgaD4Q74F1fgYGCjOXkuHXghjALMcfgKX5oosdcipZnhdz/elZcIDejCQddgH4QNHcLWbnmbWfb4qK0VYwylIAktwuYGy0A63sf+KloBLQoKp84+n+UqVAmL3EJI/CBsCsVAa6l4wR1pMKg+Za+J93su5LPNRvSQAqWZb1NH17C+eM61Fs2obzNQ1MMXbbfkrcOSsXuZF6Tzw3XrrqQoOKhEx3na8jRDIBf4J7u5cXsnHt/Bg6FX6Q74FT4+s4uwdAOs2i7gwzdV3P+pEbQYsACyqIgM5F3MIQFE0nKktBztbPnk7GAPOIZdhZJt/Niqw5Wew3P8RdBOmj5vkJ5F2O+hZsX4cfiuF3QguRwmlch3T/x/2Iy7cjTnH
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(4636009)(376002)(396003)(346002)(136003)(39860400002)(36840700001)(46966006)(2616005)(5660300002)(186003)(6666004)(966005)(316002)(110136005)(336012)(54906003)(4326008)(426003)(47076005)(16526019)(82310400003)(8676002)(1076003)(478600001)(81166007)(83380400001)(2906002)(8936002)(356005)(70206006)(26005)(36756003)(36860700001)(70586007)(7696005)(82740400003)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 May 2021 22:01:24.7812
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 7b8812c1-2537-4a78-9731-08d9197f5053
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT003.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4812
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

ChangeLogs:
    V6->V5:
    	  Moved PSF control code to arch/x86/kernel/cpu/bugs.c
    	      PSF mitigation is similar to spec_control_bypass mitigation.
    	  PSF mitigation has only ON and OFF controls.
    	  Kernel parameter changed to predictive_store_fwd_disable.
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
  x86/bugs: Implement mitigation for Predictive Store Forwarding

 .../admin-guide/kernel-parameters.txt         |  5 +
 arch/x86/include/asm/cpufeatures.h            |  1 +
 arch/x86/include/asm/msr-index.h              |  2 +
 arch/x86/include/asm/nospec-branch.h          |  6 ++
 arch/x86/kernel/cpu/bugs.c                    | 94 +++++++++++++++++++
 5 files changed, 108 insertions(+)


base-commit: 0e16f466004d7f04296b9676a712a32a12367d1f
-- 
2.25.1

