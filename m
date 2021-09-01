Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 57C253FE4A5
	for <lists+linux-kernel@lfdr.de>; Wed,  1 Sep 2021 23:14:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343918AbhIAVP3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 1 Sep 2021 17:15:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39764 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245517AbhIAVPX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Sep 2021 17:15:23 -0400
Received: from mail-yb1-xb4a.google.com (mail-yb1-xb4a.google.com [IPv6:2607:f8b0:4864:20::b4a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2F198C061757
        for <linux-kernel@vger.kernel.org>; Wed,  1 Sep 2021 14:14:26 -0700 (PDT)
Received: by mail-yb1-xb4a.google.com with SMTP id w8-20020a259188000000b0059bf0bed21fso818586ybl.18
        for <linux-kernel@vger.kernel.org>; Wed, 01 Sep 2021 14:14:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=NynU0VsFkQhJQXqud91+TUp51z++5EuhmTtoJ8VM9vA=;
        b=qxxM6e/f9pWYsiuH2KBdjm/QJz59IOabtX0q2PBaontEeisBXxrqs2rUX+tExYWnQC
         +BfAxtddJnpKm2BqubT6De6arWo1cO9OCTfcEPhKVHvuI6f3jqj8AIVjs7jYgobkIm0T
         6qHQEztZlWua/EDfjcGSetqRERlMqLhCV81u4U3FYVuuFwWqPvnI3TLlvSTa5OQiCcT0
         kWayz4MmD832Owoowm0OulpTJTXnIx0JBJD/WMInIQuMCbsWafNlF/rcFoTGXQjbhKVM
         lFW7WJdx7p7jLw5vZmElbvDunRWvOCyQCKNFC0lfyBT5cU7FMaIO3SRTvnPI3AY0zLmq
         Yl5Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=NynU0VsFkQhJQXqud91+TUp51z++5EuhmTtoJ8VM9vA=;
        b=TnP6d+xxFLzdVRIibyT+Oi5VESlJy53wpL5jC+0fdGITAHc7kMHR/S1lXbiP0sIIf/
         9mlRYZ9CdTgXKZMuhzkztggHT9cotZkqrdyUDfk4bvsji6yqX2IemI1Kuypi8vEYk/4A
         emqo1O9O2axqh6crUxG5Nj8k/ORuZbY6bQEc3BHTVFKa4k1wQTFb5VG4gM7W52mhJBiy
         P1GQU8AoI47xxPKhQ+Muab3nts09wPG6p+dpCWdezvmEECiBuniOpsf+sxKTkBsZnRkY
         XB+vpM8MjoTrjhSdHUKEQM/57b+noCiemjGWtpoQ9+csKTXRGCvhJSJ51KVrdqgJHOtK
         YaXg==
X-Gm-Message-State: AOAM532F/tW+kp+wTYaobCW3xNbteOaNxxJS4/4kDJj1O006nicV7Qxy
        +So7Edc15mYAbjSKD2w3fN4vHmLCbEEP
X-Google-Smtp-Source: ABdhPJwzoSNSMY4AoIgePcfbWrmdrKkF0HMq2vl5cRhEhWI4zgAXPrcPYKV3maPtzwS1olSJmbGt1RseS5bc
X-Received: from rananta-virt.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:1bcc])
 (user=rananta job=sendgmr) by 2002:a05:6902:1008:: with SMTP id
 w8mr2179650ybt.183.1630530865464; Wed, 01 Sep 2021 14:14:25 -0700 (PDT)
Date:   Wed,  1 Sep 2021 21:14:02 +0000
In-Reply-To: <20210901211412.4171835-1-rananta@google.com>
Message-Id: <20210901211412.4171835-3-rananta@google.com>
Mime-Version: 1.0
References: <20210901211412.4171835-1-rananta@google.com>
X-Mailer: git-send-email 2.33.0.153.gba50c8fa24-goog
Subject: [PATCH v3 02/12] KVM: arm64: selftests: Add write_sysreg_s and read_sysreg_s
From:   Raghavendra Rao Ananta <rananta@google.com>
To:     Paolo Bonzini <pbonzini@redhat.com>, Marc Zyngier <maz@kernel.org>,
        James Morse <james.morse@arm.com>,
        Alexandru Elisei <alexandru.elisei@arm.com>,
        Suzuki K Poulose <suzuki.poulose@arm.com>
Cc:     Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>, Peter Shier <pshier@google.com>,
        Ricardo Koller <ricarkol@google.com>,
        Oliver Upton <oupton@google.com>,
        Reiji Watanabe <reijiw@google.com>,
        Jing Zhang <jingzhangos@google.com>,
        Raghavendra Rao Anata <rananta@google.com>,
        linux-arm-kernel@lists.infradead.org, kvmarm@lists.cs.columbia.edu,
        linux-kernel@vger.kernel.org, kvm@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

For register names that are unsupported by the assembler or the ones
without architectural names, add the macros write_sysreg_s and
read_sysreg_s to support them.

The functionality is derived from kvm-unit-tests and kernel's
arch/arm64/include/asm/sysreg.h.

Signed-off-by: Raghavendra Rao Ananta <rananta@google.com>
---
 .../selftests/kvm/include/aarch64/processor.h | 61 +++++++++++++++++++
 1 file changed, 61 insertions(+)

diff --git a/tools/testing/selftests/kvm/include/aarch64/processor.h b/tools/testing/selftests/kvm/include/aarch64/processor.h
index 3cbaf5c1e26b..082cc97ad8d3 100644
--- a/tools/testing/selftests/kvm/include/aarch64/processor.h
+++ b/tools/testing/selftests/kvm/include/aarch64/processor.h
@@ -118,6 +118,67 @@ void vm_install_exception_handler(struct kvm_vm *vm,
 void vm_install_sync_handler(struct kvm_vm *vm,
 		int vector, int ec, handler_fn handler);
 
+/*
+ * ARMv8 ARM reserves the following encoding for system registers:
+ * (Ref: ARMv8 ARM, Section: "System instruction class encoding overview",
+ *  C5.2, version:ARM DDI 0487A.f)
+ *	[20-19] : Op0
+ *	[18-16] : Op1
+ *	[15-12] : CRn
+ *	[11-8]  : CRm
+ *	[7-5]   : Op2
+ */
+#define Op0_shift	19
+#define Op0_mask	0x3
+#define Op1_shift	16
+#define Op1_mask	0x7
+#define CRn_shift	12
+#define CRn_mask	0xf
+#define CRm_shift	8
+#define CRm_mask	0xf
+#define Op2_shift	5
+#define Op2_mask	0x7
+
+/*
+ * When accessed from guests, the ARM64_SYS_REG() doesn't work since it
+ * generates a different encoding for additional KVM processing, and is
+ * only suitable for userspace to access the register via ioctls.
+ * Hence, define a 'pure' sys_reg() here to generate the encodings as per spec.
+ */
+#define sys_reg(op0, op1, crn, crm, op2) \
+	(((op0) << Op0_shift) | ((op1) << Op1_shift) | \
+	 ((crn) << CRn_shift) | ((crm) << CRm_shift) | \
+	 ((op2) << Op2_shift))
+
+asm(
+"	.irp	num,0,1,2,3,4,5,6,7,8,9,10,11,12,13,14,15,16,17,18,19,20,21,22,23,24,25,26,27,28,29,30\n"
+"	.equ	.L__reg_num_x\\num, \\num\n"
+"	.endr\n"
+"	.equ	.L__reg_num_xzr, 31\n"
+"\n"
+"	.macro	mrs_s, rt, sreg\n"
+"	.inst	0xd5200000|(\\sreg)|(.L__reg_num_\\rt)\n"
+"	.endm\n"
+"\n"
+"	.macro	msr_s, sreg, rt\n"
+"	.inst	0xd5000000|(\\sreg)|(.L__reg_num_\\rt)\n"
+"	.endm\n"
+);
+
+/*
+ * read_sysreg_s() and write_sysreg_s()'s 'reg' has to be encoded via sys_reg()
+ */
+#define read_sysreg_s(reg) ({						\
+	u64 __val;							\
+	asm volatile("mrs_s %0, "__stringify(reg) : "=r" (__val));	\
+	__val;								\
+})
+
+#define write_sysreg_s(reg, val) do {					\
+	u64 __val = (u64)val;						\
+	asm volatile("msr_s "__stringify(reg) ", %x0" : : "rZ" (__val));\
+} while (0)
+
 #define write_sysreg(reg, val)						  \
 ({									  \
 	u64 __val = (u64)(val);						  \
-- 
2.33.0.153.gba50c8fa24-goog

