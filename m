Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A62C9368598
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Apr 2021 19:11:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238528AbhDVRL2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 22 Apr 2021 13:11:28 -0400
Received: from mail-mw2nam12on2063.outbound.protection.outlook.com ([40.107.244.63]:3329
        "EHLO NAM12-MW2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S238182AbhDVRL0 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Apr 2021 13:11:26 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=DwFUx+SG40lwKmUy3Hs6BxudhjR5r/Q3N9APpVhsDtPtOKMIyYobG0LZvF+/18KNwZeVmIFv2FsjlbHhACYW6Uuupr5FZjsAK62kSqJ3wOH1BiToI+DuhFEHJ0Pn3cJTatnevNvPy9qsVA576BfsnBTJHc4Tt5vqJbk3LRPuWUMzWoblHWTYZpak+NFUC2p8I/lFo+ORODyD7J9X7MsjwLGO6/yzL17obzdhcM7pJjvB+YJxyZq4fE5gUgy/31M9Q1cVfuRwwZ9FJrwY0ME5FzqEup0NUXJ9LrvNpe33fdD4jLNFIpo2Et5nicciyzld9fEGrqsDqs4V2U9fzzhyCA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=guNrckxUu65gKlRNhAvIbb0/vcPsc/3KWIWfojxdbwE=;
 b=dHvlzAj6Ckzp8yDAMMwNSBeeOWczDN1dhQ0SUE6gmijYkQTOTuJNTGVlDd2ly7SDdg5ytA3Sog8h04/r6CFAvR3Wp23rH1HVikcwhNeSlxz5pdcXsa8H6oFp2YX0cdL/KxQd/mQgbIxXEjNx93RqQqOqk5/7yupnX90c8v/2nOHdXT2Wjn4dTV4KBa9q7eZXvh/gtsmVqFYLb6InaMNMCzbRxmmeefW+hnf03IKitTCyjHaB4Q7Qs7aoZ7E563c5Mo9Np4XG9mrRMoHhuS/YUZUSllS32641siegG1SqXJyHLhAbpcdr5mwULrmt1+uB0b5axKd11S15Qwj66AoRjQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=none sp=none pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=guNrckxUu65gKlRNhAvIbb0/vcPsc/3KWIWfojxdbwE=;
 b=Jish2RSZqaEyGa/bEjnUy55FGwaNn4tU55sqcFnVTY4BEl767zPubRAFCgclhGDxpr4qj0k/9FEiByTCkTaYFvhp9cNqhCfJUvPj5Vp7ukjjf2Vf7Dm8nqSnXnUC0GpLsYwQ+HRnh9aMoLXbqc3VlEBPIzSD5RfBuA44Ca9QrGg=
Received: from DM5PR21CA0062.namprd21.prod.outlook.com (2603:10b6:3:129::24)
 by DM6PR12MB4090.namprd12.prod.outlook.com (2603:10b6:5:217::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4065.23; Thu, 22 Apr
 2021 17:10:48 +0000
Received: from DM6NAM11FT016.eop-nam11.prod.protection.outlook.com
 (2603:10b6:3:129:cafe::f5) by DM5PR21CA0062.outlook.office365.com
 (2603:10b6:3:129::24) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4087.16 via Frontend
 Transport; Thu, 22 Apr 2021 17:10:48 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com;
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DM6NAM11FT016.mail.protection.outlook.com (10.13.173.139) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.4065.21 via Frontend Transport; Thu, 22 Apr 2021 17:10:48 +0000
Received: from rsaripalli-Inspiron-5676.amd.com (10.180.168.240) by
 SATLEXMB04.amd.com (10.181.40.145) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2242.4; Thu, 22 Apr 2021 12:10:45 -0500
From:   Ramakrishna Saripalli <rsaripal@amd.com>
To:     <linux-kernel@vger.kernel.org>, <x86@kernel.org>,
        <tglx@linutronix.de>, <mingo@redhat.com>, <bp@alien8.de>,
        <hpa@zytor.com>, Jonathan Corbet <corbet@lwn.net>
CC:     <bsd@redhat.com>, <rsaripal@amd.com>
Subject: [v2 1/1] x86/cpufeatures: Implement Predictive Store Forwarding control.
Date:   Thu, 22 Apr 2021 12:10:13 -0500
Message-ID: <20210422171013.50207-2-rsaripal@amd.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210422171013.50207-1-rsaripal@amd.com>
References: <20210422171013.50207-1-rsaripal@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 361498b3-ad6b-4c0d-38dd-08d905b1931e
X-MS-TrafficTypeDiagnostic: DM6PR12MB4090:
X-Microsoft-Antispam-PRVS: <DM6PR12MB40909DD023F7EA0767F9F0749B469@DM6PR12MB4090.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:2733;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 5RuoqLAd9IMJ6hW1IjeoNiDCNQwVEH6q20UiN9j8SxWqVBKH01uDdBH2vY0P7IVALQ3u8JuTCbg4RVulGdSLG2KN8jlRGv6/enljFYDObdkBW0dWxMRLaQOL1PAiVLj9bSHugmcW9bFPgv+n5DH5jtwg1fncn5o1C+yLYRbMf8FEAzJXctlsMI8NeK+JKyOQ7Mp6ga05BuZ0MH2r3X2iHZKoCnPCnb2NkPUN/KNFYDBJIrD+gb9muC6E47Ab5ceNiudna+0w1FckFUN7C/ab4DyHbr0MiCfYQQ9UWkVXsRMt0aXNTWlgLvKfK3NGZc/Z4oltDl5c2a86JTBXB78KEF8zjwrWhBuaPu3mYczQB32zPPy0/3+A8sWdKNGicxbIkB7XssRnIiUbwFRB3xM16cIJaP3R9w99IkEwGjHvIu2Ic0xlttyjSWeHzjSJiKJrUcxcxvm5M0QprY+0i8I3Hzn7WMf/5C9VQI2LHfrNH1a00Ee00im2cWEEv55vE75pZH4RHtjyLT/UracAAM540xe48+6tRuMMaRoZUJPUq/7Bk4I9NqjG4h7AdiW1C3adUwCSTUJlfB4LuCOOFLcDKlILRNcSsgVmupuQ0iuwPLpGLLxI/rM+F5+NXW5wvxP0DAaFUSNlA3/4qSRZ7bA4njhawU/6EzzXP8Gx76hgZgURYWNCfsy4aPLgml2ts/ua
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(4636009)(376002)(396003)(136003)(39860400002)(346002)(36840700001)(46966006)(54906003)(110136005)(6666004)(36860700001)(7696005)(4326008)(36756003)(2906002)(316002)(82310400003)(70586007)(70206006)(478600001)(8676002)(8936002)(81166007)(47076005)(26005)(426003)(336012)(186003)(16526019)(82740400003)(2616005)(5660300002)(356005)(83380400001)(1076003)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Apr 2021 17:10:48.4188
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 361498b3-ad6b-4c0d-38dd-08d905b1931e
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT016.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4090
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

ChangeLogs:
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
 arch/x86/kernel/cpu/amd.c                     | 19 +++++++++++++++++++
 4 files changed, 27 insertions(+)

diff --git a/Documentation/admin-guide/kernel-parameters.txt b/Documentation/admin-guide/kernel-parameters.txt
index 04545725f187..58f6bd02385b 100644
--- a/Documentation/admin-guide/kernel-parameters.txt
+++ b/Documentation/admin-guide/kernel-parameters.txt
@@ -3940,6 +3940,11 @@
 			Format: {"off"}
 			Disable Hardware Transactional Memory
 
+	predict_store_fwd	[X86] This option controls PSF mitigation
+			off - Turns on PSF mitigation.
+			on  - Turns off PSF mitigation.
+			default : on.
+
 	preempt=	[KNL]
 			Select preemption mode if you have CONFIG_PREEMPT_DYNAMIC
 			none - Limited to cond_resched() calls
diff --git a/arch/x86/include/asm/cpufeatures.h b/arch/x86/include/asm/cpufeatures.h
index cc96e26d69f7..078f46022293 100644
--- a/arch/x86/include/asm/cpufeatures.h
+++ b/arch/x86/include/asm/cpufeatures.h
@@ -309,6 +309,7 @@
 #define X86_FEATURE_AMD_SSBD		(13*32+24) /* "" Speculative Store Bypass Disable */
 #define X86_FEATURE_VIRT_SSBD		(13*32+25) /* Virtualized Speculative Store Bypass Disable */
 #define X86_FEATURE_AMD_SSB_NO		(13*32+26) /* "" Speculative Store Bypass is fixed in hardware. */
+#define X86_FEATURE_PSFD		(13*32+28) /* Predictive Store Forward Disable */
 
 /* Thermal and Power Management Leaf, CPUID level 0x00000006 (EAX), word 14 */
 #define X86_FEATURE_DTHERM		(14*32+ 0) /* Digital Thermal Sensor */
diff --git a/arch/x86/include/asm/msr-index.h b/arch/x86/include/asm/msr-index.h
index 546d6ecf0a35..f569918c8754 100644
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
index 347a956f71ca..88aac52eeb1b 100644
--- a/arch/x86/kernel/cpu/amd.c
+++ b/arch/x86/kernel/cpu/amd.c
@@ -1170,3 +1170,22 @@ void set_dr_addr_mask(unsigned long mask, int dr)
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

