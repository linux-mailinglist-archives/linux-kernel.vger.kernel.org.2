Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BE3DB36FB59
	for <lists+linux-kernel@lfdr.de>; Fri, 30 Apr 2021 15:18:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232521AbhD3NSn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 30 Apr 2021 09:18:43 -0400
Received: from mail-mw2nam10on2050.outbound.protection.outlook.com ([40.107.94.50]:4801
        "EHLO NAM10-MW2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S230020AbhD3NSk (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 30 Apr 2021 09:18:40 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ZZn1oJ9UGoHJYseoMe48o9eoZWb+cEkvwgP7vGb3XXchy4+IXOFc+UlObpiDRm8f/KvJen1v/70TAz06lUZpBo5P8Jj3MaW2DY+bUDOGjSRUqWy7eg/oBPgSYiCf7V9VmQgdMoadsJddCZdGd2E5+/FWHZx1bksuCqnmFbUaHySE4A2dYngDw0n8R4xl7OxNIsdPlSArtMinmO84DLBisyouyO6x9JzhLn373PlgXPqIzOxhqlmazRfwD45Zab5f3PXpu8IC8uCtYcbsEx01PxGfeTmG1lpG4NI3s9IB7uGi488uRALXPabrFAvMN9DtqTY227lYEmAmJIWL/kzKPg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6ON826/gjn8culU+UKBZviD+dCPf6g80sBMW9WQMjDA=;
 b=F3bwztO5ioocBjpNuL7WrKE/+DjZC1Lod7eSDScHtl9fsfcP5mh60dbzss3BlIhXZWX3ASjcjhBbE7NeYmLzticu7D5QNb+A3iUHKiMvbiB3826joevQM49eVcvC/yWnSRnPySw5VZiopEis9GvrBzdQZ5StcLKDpLmwpoWaQbE4qbY9rzkNFQhkouO/+M/h+l5rKtjVU3FOk8KTJ42dNRvzBP/9AVRCIt+Yecd4sMesDeL+v6JJ6kp0BQabppWVXsbEAoXotnVL5qmPRrASH1nBhyFF4bkwJ/0luoV54mq+24gFLYAx5j2RkM1Luspmho6I/7WXTqILunKSRmJuGw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=none sp=none pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6ON826/gjn8culU+UKBZviD+dCPf6g80sBMW9WQMjDA=;
 b=DzYZsyO3i9rFlsCNxZMlPypyWIlWMcBUzVvaTqNa6n84Mp5cm3vYeY6Bng60rxzOebWnkYV+SuiyZYdbJIAAUy9odZGueknaK/cZep0xCFIrjWZd/MLrEvMcFIofl2d5b4GLQVpbAU+9LHBLrpiGV59tR8fMhlkZgHeHdzIB9nA=
Received: from MW2PR2101CA0021.namprd21.prod.outlook.com (2603:10b6:302:1::34)
 by DM6PR12MB3770.namprd12.prod.outlook.com (2603:10b6:5:1c4::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4065.21; Fri, 30 Apr
 2021 13:17:49 +0000
Received: from CO1NAM11FT043.eop-nam11.prod.protection.outlook.com
 (2603:10b6:302:1:cafe::fe) by MW2PR2101CA0021.outlook.office365.com
 (2603:10b6:302:1::34) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4108.1 via Frontend
 Transport; Fri, 30 Apr 2021 13:17:49 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com;
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1NAM11FT043.mail.protection.outlook.com (10.13.174.193) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.4087.27 via Frontend Transport; Fri, 30 Apr 2021 13:17:49 +0000
Received: from rsaripalli-Inspiron-5676.amd.com (10.180.168.240) by
 SATLEXMB04.amd.com (10.181.40.145) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2242.4; Fri, 30 Apr 2021 08:17:46 -0500
From:   Ramakrishna Saripalli <rsaripal@amd.com>
To:     <linux-kernel@vger.kernel.org>, <x86@kernel.org>,
        <tglx@linutronix.de>, <mingo@redhat.com>, <bp@alien8.de>,
        <hpa@zytor.com>, Jonathan Corbet <corbet@lwn.net>
CC:     <bsd@redhat.com>, <rsaripal@amd.com>
Subject: [PATCH v4 1/1] x86/cpufeatures: Implement Predictive Store Forwarding control.
Date:   Fri, 30 Apr 2021 08:17:33 -0500
Message-ID: <20210430131733.192414-2-rsaripal@amd.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210430131733.192414-1-rsaripal@amd.com>
References: <20210430131733.192414-1-rsaripal@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 5f166961-a677-41ba-4f56-08d90bda5a36
X-MS-TrafficTypeDiagnostic: DM6PR12MB3770:
X-Microsoft-Antispam-PRVS: <DM6PR12MB3770D43E62632B2128C4F7F89B5E9@DM6PR12MB3770.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:9508;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: vp/gXdndk+bHlymaJyVb0/sE5XbwQ0ZuprRsgSsk2F+eCLHAqvm340WizH+YthiN1gxbSekFUxlkE5ajiIc6aXM5ecx1kxxE2nkbnpV0wfj0OrvnuY5F0LFkZmByS3e6ls0sHpSlUdD0JpgF1UBDigeRQXMfegmFsqMx/L0TDNxvfbV1aDBTbTBYddW+TnbYBUCvUz5r44+Sy1K/nY7oBGPn39Na0uhAmFRLVZ3r2hzIZ2Bkuj/MicmiRAsEYnppkQ/QK08oLjaQD7Hccd31IbLcQqQyK4/9W7qU7fZzVSCBznQJt4KxiQhDX2MlzmouiKCF4qmszaBhY4ESiFTU3cxndxtGbso2iVQVwCoIzXdrnM+5O0I43sJmc4oqMTcG41RikRo7CcDOqpmnhcUf+FM7jgfFPLllbt4dinzJSERygfwG2bg92YehKicckbljNc0847UdzrIyQLkzZbFfZTQIa1OvlT62l5k1sBaIuf3e1B5soaPVQu3tqnkVaA7b8bh5noC6Qk0EpfzpEYP5fJwIJyzbyqFfNTNLzHpQ0dt5+RLNiPo85J16myRHFKHmYrDvbTpe7+vEL4UhQTTplUK9CwVAkrZXF6PMv/P+YOo0epbnf9of8OrOUlTOU4AIDFlDZqqwCxkpiudZXEDrcGYpGshAbij11645itX6Bl+aqUeQ9acLO+TIyw21jANv
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(4636009)(136003)(346002)(396003)(376002)(39860400002)(36840700001)(46966006)(7696005)(26005)(336012)(356005)(426003)(5660300002)(6666004)(478600001)(186003)(2616005)(2906002)(8936002)(8676002)(83380400001)(16526019)(82310400003)(81166007)(70206006)(1076003)(316002)(36860700001)(70586007)(4326008)(47076005)(82740400003)(54906003)(36756003)(110136005)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Apr 2021 13:17:49.2321
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 5f166961-a677-41ba-4f56-08d90bda5a36
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT043.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB3770
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

Signed-off-by: Ramakrishna Saripalli<rk.saripalli@amd.com>
---
 .../admin-guide/kernel-parameters.txt         |  5 ++++
 arch/x86/include/asm/cpufeatures.h            |  1 +
 arch/x86/include/asm/msr-index.h              |  2 ++
 arch/x86/kernel/cpu/amd.c                     | 23 +++++++++++++++++++
 arch/x86/kernel/cpu/bugs.c                    |  6 ++++-
 5 files changed, 36 insertions(+), 1 deletion(-)

diff --git a/Documentation/admin-guide/kernel-parameters.txt b/Documentation/admin-guide/kernel-parameters.txt
index 04545725f187..a4dd08bb0d3a 100644
--- a/Documentation/admin-guide/kernel-parameters.txt
+++ b/Documentation/admin-guide/kernel-parameters.txt
@@ -3940,6 +3940,11 @@
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
index 347a956f71ca..3fdaec8090b6 100644
--- a/arch/x86/kernel/cpu/amd.c
+++ b/arch/x86/kernel/cpu/amd.c
@@ -1170,3 +1170,26 @@ void set_dr_addr_mask(unsigned long mask, int dr)
 		break;
 	}
 }
+
+static int __init psf_cmdline(char *str)
+{
+	u64 tmp = 0;
+
+	if (!boot_cpu_has(X86_FEATURE_PSFD))
+		return 0;
+
+	if (!str)
+		return -EINVAL;
+
+	if (!strcmp(str, "off")) {
+		set_cpu_cap(&boot_cpu_data, X86_FEATURE_MSR_SPEC_CTRL);
+		rdmsrl(MSR_IA32_SPEC_CTRL, tmp);
+		tmp |= SPEC_CTRL_PSFD;
+		x86_spec_ctrl_base |= tmp;
+		wrmsrl(MSR_IA32_SPEC_CTRL, x86_spec_ctrl_base);
+	}
+
+	return 0;
+}
+
+early_param("predict_store_fwd", psf_cmdline);
diff --git a/arch/x86/kernel/cpu/bugs.c b/arch/x86/kernel/cpu/bugs.c
index d41b70fe4918..536136e0daa3 100644
--- a/arch/x86/kernel/cpu/bugs.c
+++ b/arch/x86/kernel/cpu/bugs.c
@@ -78,6 +78,8 @@ EXPORT_SYMBOL_GPL(mds_idle_clear);
 
 void __init check_bugs(void)
 {
+	u64 tmp = 0;
+
 	identify_boot_cpu();
 
 	/*
@@ -97,7 +99,9 @@ void __init check_bugs(void)
 	 * init code as it is not enumerated and depends on the family.
 	 */
 	if (boot_cpu_has(X86_FEATURE_MSR_SPEC_CTRL))
-		rdmsrl(MSR_IA32_SPEC_CTRL, x86_spec_ctrl_base);
+		rdmsrl(MSR_IA32_SPEC_CTRL, tmp);
+
+	x86_spec_ctrl_base |= tmp;
 
 	/* Allow STIBP in MSR_SPEC_CTRL if supported */
 	if (boot_cpu_has(X86_FEATURE_STIBP))
-- 
2.25.1

