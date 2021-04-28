Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A536136DCA4
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Apr 2021 18:04:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239272AbhD1QFA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 28 Apr 2021 12:05:00 -0400
Received: from mail-dm6nam12on2073.outbound.protection.outlook.com ([40.107.243.73]:11137
        "EHLO NAM12-DM6-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S229891AbhD1QEx (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Apr 2021 12:04:53 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=aUWwTtcH890a3tUS4QZHHFBuE/TwZ2lW030iBtYjWnVK0rDtmUO/e1jqw07SLRVEPjyz3XziHNiAuxFhYsi1aGLpziprNrY8zg0Jo3uPfnPBb6VTmw3u9nYhz5UFYROiP2oez4qbDidr2UKpSE8dNT5mslq6CtAHzHhxbftNAJVlzhxD20IUEI7XrOhmuL+pp8Y6j1TZ1Cj5c+Xp1F9jw/cZ+kYfNP6ySHIJBvxJSLT1rB1lsnjNOh7MGBzaP8HctJQnbDzLIdEK3X9rBykTBmAbAYnBuHBBHGdpmu2t1lnjQW98sL7NZ3/VqLYf9AmRC/uf8vVx4BNDpjnrOwb+lg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3Iclmt9qon/OcYzyS8B58DEZTCyKqqgllAA17fm/L0E=;
 b=ldEuPxghSeG8Mb81EghmbSaorqhWHmlRMm6JtI4Tne8sCsA+rdhhhaORfe4tUd2GaLv2I0lvL1puRYU4qx4X8y1QgHLI5zW0/3YoQmYfr1fmGSqfhyxQSBYt4Wwf97NDEjh9CgqHQ07jtdwvP6QepEOhf3jhaVOzsSxXMGFw2yF2jUrSFIVnpD4iTmp0DgzL9hkDSc2HAOyRLtjHlfkLJOCdbw/S3Qhjq25eV610dqxFpirtS+TJsbekNB/UahajckzSljQKiOCX0J93fRVmGSUQQNQ88imhQvQEuoEp83/Bh1eGpL9O3ElRlLV7G+tAmE+yfjM5K42zHUmqAVANyg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=none sp=none pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3Iclmt9qon/OcYzyS8B58DEZTCyKqqgllAA17fm/L0E=;
 b=228kic7uIaikwLOFCKrGZP+Vrg91Qp8x962gtoyQGh7dxuFpQUAVmOoC66y144Z2cQdsLv7Rlsg821zrgwW27a84SnGWaCLh515rrd8R/sjQtcHt21/6CgTLxx8W5GbyTavFkYs/v6m+xRR980mRvaahr/hEzwZo5Amq5CqW7cg=
Received: from BN1PR10CA0013.namprd10.prod.outlook.com (2603:10b6:408:e0::18)
 by BYAPR12MB4631.namprd12.prod.outlook.com (2603:10b6:a03:10d::24) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4065.23; Wed, 28 Apr
 2021 16:04:06 +0000
Received: from BN8NAM11FT041.eop-nam11.prod.protection.outlook.com
 (2603:10b6:408:e0:cafe::dd) by BN1PR10CA0013.outlook.office365.com
 (2603:10b6:408:e0::18) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4087.27 via Frontend
 Transport; Wed, 28 Apr 2021 16:04:05 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com;
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN8NAM11FT041.mail.protection.outlook.com (10.13.177.18) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.4065.21 via Frontend Transport; Wed, 28 Apr 2021 16:04:05 +0000
Received: from rsaripalli-Inspiron-5676.amd.com (10.180.168.240) by
 SATLEXMB04.amd.com (10.181.40.145) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2242.4; Wed, 28 Apr 2021 11:04:03 -0500
From:   Ramakrishna Saripalli <rsaripal@amd.com>
To:     <linux-kernel@vger.kernel.org>, <x86@kernel.org>,
        <tglx@linutronix.de>, <mingo@redhat.com>, <bp@alien8.de>,
        <hpa@zytor.com>, Jonathan Corbet <corbet@lwn.net>
CC:     <bsd@redhat.com>, <rsaripal@amd.com>
Subject: [v3 1/1] x86/cpufeatures: Implement Predictive Store Forwarding control.
Date:   Wed, 28 Apr 2021 11:03:49 -0500
Message-ID: <20210428160349.158774-2-rsaripal@amd.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210428160349.158774-1-rsaripal@amd.com>
References: <20210428160349.158774-1-rsaripal@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 98d0d3d7-41af-456f-f9d6-08d90a5f3fb3
X-MS-TrafficTypeDiagnostic: BYAPR12MB4631:
X-Microsoft-Antispam-PRVS: <BYAPR12MB46314FFD02E6EECECAF362B69B409@BYAPR12MB4631.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:2733;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: +lAaG9+xHy8SLF9Ii6C496fFDzhQ8b988qQ9rXGntw//Eiu8XNAaGNmDRyKDi9CDGbPgxSV/UbDKQzZXfwFH7exDszKShEa0vgL1U2GvA4FKCW331wrwdb+Y6UQumRoB4La+5JIu4xc6jYDzF26+3vgTa7SUGjMu1cd40cSRrtNb+0d7RHhtmkL708ECIbIzLLsm3cNFi7eEjTe7B1+RJtbRv9NzLAEpPXk1/yYcTKyguIRRu2JpGW5eXlJAVnNiJukeEkDeR1n5H6RKmNjxIJqX2c1FbrvCPFiXGN2zUy69zJXNHogUwiS7JzkiagHQ1GZrCfJC1FEawUwVGQVPwnXxLwtkEOSbof5ZtzCUqt0adbyghc9F5Ex/w5CuijQRq+lzBnN5N+/ogw3ywjJQFo/Bt7JSq4OBaNfou2c4W6mG3o+YWGLCGH5Zno92MZrq/2/EfvkQl/OYaSwUwbt7Chuu9unjRaaCf54EA+N0pU0q7cI5SflFLHpF+MVFrKKD6lFLGelvIlOSVw6OdmNVf4CBZkGCUPGWnzk5c449DqUTsztzJQwm1/9RH0Zg+Tgu8UkC9V9cXld+SpSIBugpF1fnSxgToqrzPqKZhKc3FemMvB2nlAVXCCYTSlSeH1a80LaYMM96WoySSdqSiFAPB7a/K4kwjvRfnY8xPQFQz+adxUQ0TmU6a6Drx9DEaClo
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(4636009)(46966006)(36840700001)(1076003)(83380400001)(82310400003)(5660300002)(2906002)(47076005)(498600001)(6666004)(336012)(70206006)(36860700001)(426003)(70586007)(81166007)(2616005)(16526019)(8936002)(36756003)(110136005)(8676002)(54906003)(356005)(7696005)(26005)(4326008)(186003)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Apr 2021 16:04:05.6126
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 98d0d3d7-41af-456f-f9d6-08d90a5f3fb3
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT041.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR12MB4631
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Ramakrishna Saripalli <rk.saripalli@amd.com>

Certain AMD processors feature a new technology called Predictive Store
Forwarding (PSF).

PSF is a micro-architectural optimization designed to improve the
performance of code execution by predicting dependencies between
loads and stores.

Incorrect PSF predictions can occur due to two reasons.

- It is possible that the load/store pair may have had dependency for
  a while but the dependency has stopped because the address in the
  load/store pair has changed.

- Second source of incorrect PSF prediction can occur because of an alias
  in the PSF predictor structure stored in the microarchitectural state.
  PSF predictor tracks load/store pair based on portions of instruction
  pointer. It is possible that a load/store pair which does have a
  dependency may be aliased by another load/store pair which does not have
  the same dependency. This can result in incorrect speculation.

  Software may be able to detect this aliasing and perform side-channel
  attacks.

All CPUs that implement PSF provide one bit to disable this feature.
If the bit to disable this feature is available, it means that the CPU
implements PSF feature and is therefore vulnerable to PSF risks.

The bits that are introduced

X86_FEATURE_PSFD: CPUID_Fn80000008_EBX[28] ("PSF disable")
	If this bit is 1, CPU implements PSF and PSF control
	via SPEC_CTRL_MSR is supported in the CPU.

All AMD processors that support PSF implement a bit in
SPEC_CTRL MSR (0x48) to disable or enable Predictive Store
Forwarding.

PSF control introduces a new kernel parameter called
	predict_store_fwd.

Kernel parameter predict_store_fwd has the following values

- off. This value is used to disable PSF on all CPUs.

- on. This value is used to enable PSF on all CPUs.
        This is also the default setting.
---
ChangeLogs:
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
====================
Signed-off-by: Ramakrishna Saripalli<rk.saripalli@amd.com>
---
 .../admin-guide/kernel-parameters.txt         |  5 +++++
 arch/x86/include/asm/cpufeatures.h            |  1 +
 arch/x86/include/asm/msr-index.h              |  2 ++
 arch/x86/kernel/cpu/amd.c                     | 20 +++++++++++++++++++
 4 files changed, 28 insertions(+)

diff --git a/Documentation/admin-guide/kernel-parameters.txt b/Documentation/admin-guide/kernel-parameters.txt
index de27d5a4d994..0576e8a8d033 100644
--- a/Documentation/admin-guide/kernel-parameters.txt
+++ b/Documentation/admin-guide/kernel-parameters.txt
@@ -3950,6 +3950,11 @@
 			Format: {"off"}
 			Disable Hardware Transactional Memory
 
+	predict_store_fwd=	[X86] This option controls PSF.
+			off - Turns off PSF.
+			on  - Turns on PSF.
+			default : on.
+
 	preempt=	[KNL]
 			Select preemption mode if you have CONFIG_PREEMPT_DYNAMIC
 			none - Limited to cond_resched() calls
diff --git a/arch/x86/include/asm/cpufeatures.h b/arch/x86/include/asm/cpufeatures.h
index 3c94316169a3..e36e6bf2f18b 100644
--- a/arch/x86/include/asm/cpufeatures.h
+++ b/arch/x86/include/asm/cpufeatures.h
@@ -313,6 +313,7 @@
 #define X86_FEATURE_AMD_SSBD		(13*32+24) /* "" Speculative Store Bypass Disable */
 #define X86_FEATURE_VIRT_SSBD		(13*32+25) /* Virtualized Speculative Store Bypass Disable */
 #define X86_FEATURE_AMD_SSB_NO		(13*32+26) /* "" Speculative Store Bypass is fixed in hardware. */
+#define X86_FEATURE_PSFD		(13*32+28) /* Predictive Store Forward Disable */
 
 /* Thermal and Power Management Leaf, CPUID level 0x00000006 (EAX), word 14 */
 #define X86_FEATURE_DTHERM		(14*32+ 0) /* Digital Thermal Sensor */
diff --git a/arch/x86/include/asm/msr-index.h b/arch/x86/include/asm/msr-index.h
index 742d89a00721..21f0c3fc1b2c 100644
--- a/arch/x86/include/asm/msr-index.h
+++ b/arch/x86/include/asm/msr-index.h
@@ -51,6 +51,8 @@
 #define SPEC_CTRL_STIBP			BIT(SPEC_CTRL_STIBP_SHIFT)	/* STIBP mask */
 #define SPEC_CTRL_SSBD_SHIFT		2	   /* Speculative Store Bypass Disable bit */
 #define SPEC_CTRL_SSBD			BIT(SPEC_CTRL_SSBD_SHIFT)	/* Speculative Store Bypass Disable */
+#define SPEC_CTRL_PSFD_SHIFT		7
+#define SPEC_CTRL_PSFD			BIT(SPEC_CTRL_PSFD_SHIFT)	/* Predictive Store Forwarding Disable */
 
 #define MSR_IA32_PRED_CMD		0x00000049 /* Prediction Command */
 #define PRED_CMD_IBPB			BIT(0)	   /* Indirect Branch Prediction Barrier */
diff --git a/arch/x86/kernel/cpu/amd.c b/arch/x86/kernel/cpu/amd.c
index 2d11384dc9ab..c9b6ba3ea431 100644
--- a/arch/x86/kernel/cpu/amd.c
+++ b/arch/x86/kernel/cpu/amd.c
@@ -1165,3 +1165,23 @@ void set_dr_addr_mask(unsigned long mask, int dr)
 		break;
 	}
 }
+
+static int __init psf_cmdline(char *str)
+{
+	if (!boot_cpu_has(X86_FEATURE_PSFD))
+		return 0;
+
+	if (!str)
+		return -EINVAL;
+
+	if (!strcmp(str, "off")) {
+		set_cpu_cap(&boot_cpu_data, X86_FEATURE_MSR_SPEC_CTRL);
+		x86_spec_ctrl_base |= SPEC_CTRL_PSFD;
+		wrmsrl(MSR_IA32_SPEC_CTRL, x86_spec_ctrl_base);
+		setup_clear_cpu_cap(X86_FEATURE_PSFD);
+	}
+
+	return 0;
+}
+
+early_param("predict_store_fwd", psf_cmdline);
-- 
2.25.1

