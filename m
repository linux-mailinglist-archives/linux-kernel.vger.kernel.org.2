Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 981F53147E6
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Feb 2021 06:08:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230075AbhBIFIa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 9 Feb 2021 00:08:30 -0500
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:22860 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229763AbhBIFGI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 Feb 2021 00:06:08 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1612847081;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=bHgjEwSUdOEp0qoIJfnsI3SMQkTf6kiWa4qcZ+kaqGg=;
        b=iStz6yI/0nk7dxaEEmCy+ZcyOA4CVgC19IIXeRNmi20QRBr7ARnzDQJVobLap3wmq+Qkag
        qSaCjrV9FaMSHxrFMxocnD+RBmnJEN90idl9zbMM/+XN63AN8tx/sHM73s4R2cLOeAdL59
        SDMPR5J6FoXRzjGi1i51taogtgOrJbc=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-278-qJNIsH0_MxWYELh_Qg-Quw-1; Tue, 09 Feb 2021 00:04:39 -0500
X-MC-Unique: qJNIsH0_MxWYELh_Qg-Quw-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com [10.5.11.14])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 8693D36492;
        Tue,  9 Feb 2021 05:04:37 +0000 (UTC)
Received: from gshan.redhat.com (vpn2-54-26.bne.redhat.com [10.64.54.26])
        by smtp.corp.redhat.com (Postfix) with ESMTP id AB78D5D9CD;
        Tue,  9 Feb 2021 05:04:34 +0000 (UTC)
From:   Gavin Shan <gshan@redhat.com>
To:     kvmarm@lists.cs.columbia.edu
Cc:     linux-kernel@vger.kernel.org, pbonzini@redhat.com, maz@kernel.org,
        james.morse@arm.com, Jonathan.Cameron@huawei.com,
        mark.rutland@arm.com, will@kernel.org, shan.gavin@gmail.com
Subject: [PATCH v2 05/17] arm64: Probe for the presence of KVM hypervisor services during boot
Date:   Tue,  9 Feb 2021 13:03:51 +0800
Message-Id: <20210209050403.103143-6-gshan@redhat.com>
In-Reply-To: <20210209050403.103143-1-gshan@redhat.com>
References: <20210209050403.103143-1-gshan@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Will Deacon <will@kernel.org>

Although the SMCCC specification provides some limited functionality for
describing the presence of hypervisor and firmware services, this is
generally applicable only to functions designated as "Arm Architecture
Service Functions" and no portable discovery mechanism is provided for
standard hypervisor services, despite having a designated range of
function identifiers reserved by the specification.

In an attempt to avoid the need for additional firmware changes every
time a new function is added, introduce a UID to identify the service
provider as being compatible with KVM. Once this has been established,
additional services can be discovered via a feature bitmap.

Signed-off-by: Will Deacon <will@kernel.org>
Signed-off-by: Gavin Shan <gshan@redhat.com>
---
 arch/arm64/include/asm/hypervisor.h | 11 ++++++++++
 arch/arm64/kernel/setup.c           | 32 +++++++++++++++++++++++++++++
 include/linux/arm-smccc.h           | 25 ++++++++++++++++++++++
 3 files changed, 68 insertions(+)

diff --git a/arch/arm64/include/asm/hypervisor.h b/arch/arm64/include/asm/hypervisor.h
index f9cc1d021791..91e4bd890819 100644
--- a/arch/arm64/include/asm/hypervisor.h
+++ b/arch/arm64/include/asm/hypervisor.h
@@ -2,6 +2,17 @@
 #ifndef _ASM_ARM64_HYPERVISOR_H
 #define _ASM_ARM64_HYPERVISOR_H
 
+#include <linux/arm-smccc.h>
 #include <asm/xen/hypervisor.h>
 
+static inline bool kvm_arm_hyp_service_available(u32 func_id)
+{
+	extern DECLARE_BITMAP(__kvm_arm_hyp_services, ARM_SMCCC_KVM_NUM_FUNCS);
+
+	if (func_id >= ARM_SMCCC_KVM_NUM_FUNCS)
+		return -EINVAL;
+
+	return test_bit(func_id, __kvm_arm_hyp_services);
+}
+
 #endif
diff --git a/arch/arm64/kernel/setup.c b/arch/arm64/kernel/setup.c
index c18aacde8bb0..8cbb99d80869 100644
--- a/arch/arm64/kernel/setup.c
+++ b/arch/arm64/kernel/setup.c
@@ -7,6 +7,7 @@
  */
 
 #include <linux/acpi.h>
+#include <linux/arm-smccc.h>
 #include <linux/export.h>
 #include <linux/kernel.h>
 #include <linux/stddef.h>
@@ -275,12 +276,42 @@ static int __init reserve_memblock_reserved_regions(void)
 arch_initcall(reserve_memblock_reserved_regions);
 
 u64 __cpu_logical_map[NR_CPUS] = { [0 ... NR_CPUS-1] = INVALID_HWID };
+DECLARE_BITMAP(__kvm_arm_hyp_services, ARM_SMCCC_KVM_NUM_FUNCS) = { };
 
 u64 cpu_logical_map(unsigned int cpu)
 {
 	return __cpu_logical_map[cpu];
 }
 
+static void __init kvm_init_hyp_services(void)
+{
+	struct arm_smccc_res res;
+	int i;
+
+	arm_smccc_1_1_invoke(ARM_SMCCC_VENDOR_HYP_CALL_UID_FUNC_ID, &res);
+	if (res.a0 != ARM_SMCCC_VENDOR_HYP_UID_KVM_REG_0 ||
+	    res.a1 != ARM_SMCCC_VENDOR_HYP_UID_KVM_REG_1 ||
+	    res.a2 != ARM_SMCCC_VENDOR_HYP_UID_KVM_REG_2 ||
+	    res.a3 != ARM_SMCCC_VENDOR_HYP_UID_KVM_REG_3)
+		return;
+
+	memset(&res, 0, sizeof(res));
+	arm_smccc_1_1_invoke(ARM_SMCCC_VENDOR_HYP_KVM_FEATURES_FUNC_ID, &res);
+	for (i = 0; i < 32; ++i) {
+		if (res.a0 & (i))
+			set_bit(i + (32 * 0), __kvm_arm_hyp_services);
+		if (res.a1 & (i))
+			set_bit(i + (32 * 1), __kvm_arm_hyp_services);
+		if (res.a2 & (i))
+			set_bit(i + (32 * 2), __kvm_arm_hyp_services);
+		if (res.a3 & (i))
+			set_bit(i + (32 * 3), __kvm_arm_hyp_services);
+	}
+
+	pr_info("KVM hypervisor services detected (0x%08lx 0x%08lx 0x%08lx 0x%08lx)\n",
+		res.a3, res.a2, res.a1, res.a0);
+}
+
 void __init __no_sanitize_address setup_arch(char **cmdline_p)
 {
 	init_mm.start_code = (unsigned long) _stext;
@@ -353,6 +384,7 @@ void __init __no_sanitize_address setup_arch(char **cmdline_p)
 	else
 		psci_acpi_init();
 
+	kvm_init_hyp_services();
 	init_bootcpu_ops();
 	smp_init_cpus();
 	smp_build_mpidr_hash();
diff --git a/include/linux/arm-smccc.h b/include/linux/arm-smccc.h
index f860645f6512..7eb816241697 100644
--- a/include/linux/arm-smccc.h
+++ b/include/linux/arm-smccc.h
@@ -55,6 +55,8 @@
 #define ARM_SMCCC_OWNER_TRUSTED_OS	50
 #define ARM_SMCCC_OWNER_TRUSTED_OS_END	63
 
+#define ARM_SMCCC_FUNC_QUERY_CALL_UID	0xff01
+
 #define ARM_SMCCC_QUIRK_NONE		0
 #define ARM_SMCCC_QUIRK_QCOM_A6		1 /* Save/restore register a6 */
 
@@ -102,6 +104,29 @@
 			   ARM_SMCCC_OWNER_STANDARD_HYP,	\
 			   0x21)
 
+#define ARM_SMCCC_VENDOR_HYP_CALL_UID_FUNC_ID			\
+	ARM_SMCCC_CALL_VAL(ARM_SMCCC_FAST_CALL,			\
+			   ARM_SMCCC_SMC_32,			\
+			   ARM_SMCCC_OWNER_VENDOR_HYP,		\
+			   ARM_SMCCC_FUNC_QUERY_CALL_UID)
+
+/* KVM UID value: 28b46fb6-2ec5-11e9-a9ca-4b564d003a74 */
+#define ARM_SMCCC_VENDOR_HYP_UID_KVM_REG_0	0xb66fb428U
+#define ARM_SMCCC_VENDOR_HYP_UID_KVM_REG_1	0xe911c52eU
+#define ARM_SMCCC_VENDOR_HYP_UID_KVM_REG_2	0x564bcaa9U
+#define ARM_SMCCC_VENDOR_HYP_UID_KVM_REG_3	0x743a004dU
+
+/* KVM "vendor specific" services */
+#define ARM_SMCCC_KVM_FUNC_FEATURES		0
+#define ARM_SMCCC_KVM_FUNC_FEATURES_2		127
+#define ARM_SMCCC_KVM_NUM_FUNCS			128
+
+#define ARM_SMCCC_VENDOR_HYP_KVM_FEATURES_FUNC_ID		\
+	ARM_SMCCC_CALL_VAL(ARM_SMCCC_FAST_CALL,			\
+			   ARM_SMCCC_SMC_32,			\
+			   ARM_SMCCC_OWNER_VENDOR_HYP,		\
+			   ARM_SMCCC_KVM_FUNC_FEATURES)
+
 /*
  * Return codes defined in ARM DEN 0070A
  * ARM DEN 0070A is now merged/consolidated into ARM DEN 0028 C
-- 
2.23.0

