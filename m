Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EC9F44424AC
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Nov 2021 01:23:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232599AbhKBAZg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 1 Nov 2021 20:25:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49766 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232167AbhKBAZS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Nov 2021 20:25:18 -0400
Received: from mail-pl1-x64a.google.com (mail-pl1-x64a.google.com [IPv6:2607:f8b0:4864:20::64a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 43D42C061766
        for <linux-kernel@vger.kernel.org>; Mon,  1 Nov 2021 17:22:37 -0700 (PDT)
Received: by mail-pl1-x64a.google.com with SMTP id v18-20020a170902e8d200b00141df2da949so1899183plg.10
        for <linux-kernel@vger.kernel.org>; Mon, 01 Nov 2021 17:22:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=q8+WFsVbgm29AAf/AGwas77W0K8xwgbmPl1Tstb7QWc=;
        b=b7OJ80GPH2oQgQ9tb2V+6/eW0GWKJVLr1PWxB8v4wFAwbzrU4pUgP2cI0Riz7azO5G
         Z+6rcFj7+griGUkir/2Gug4bGdUYN2p9f39RS0Ie9f5uSe6HaSA/mFLmkPgf2GQpbG0d
         5Uj2XEj05Mj2qzm0yYL9Dk4pz0EAn5W63XS6fNeOr6NTWCR/dHkpIRmXhIJtQkan6y6X
         /fqFwxj9iuYkiqbKxdWhd3ZvXyHvUTgQJa4OqwCSyt0QI4PWOnfljN5xnAgMSEk27aTJ
         kZ/8kU5lGgkp1PHOP2Rmza2Vvq/QL7beU+QmLk/l2Gi6o3hXyrVojRzFmnd0YUwtPd1I
         W03Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=q8+WFsVbgm29AAf/AGwas77W0K8xwgbmPl1Tstb7QWc=;
        b=vMaKwQec23eLR6/2S8gXcQ5CS91Hg4rkVEhlqWJKkefv14uFBaBVWxFmIvZBix4ziu
         noIKkQK8q6gTHbPIQElnU7qFVqgDTq1rGyCFgbzs6BPFlEOqnnuxn30WNs8XQxo23APC
         y2ObRJMpJbqE2lqzAKmKbgOZWCuhgtPgdokniNy8OKybx3zs4cvkMVU9b4qzRYJNrLkw
         bIk6aL9T2+cGVx+WF2E5dTZQZ//DCfRB8C+Hdo54vx+MEr74k/YpS1YqeZTG85qrEwPK
         xO3RvJwYMZeT0bcIrUrqX3BIseVoxsYY+Yscb7zvBtcbGP7qbFF3HeuBGq9tlv9Mt9uh
         R8SQ==
X-Gm-Message-State: AOAM53236+KDVS/qjoDUCtGtMc++O4DaWlrnMu0FBtH0mBB+Sj3MITuR
        gqouSt4+pMhYK4+RpELMWiA0hQQz5V30
X-Google-Smtp-Source: ABdhPJwek5nlon1tiWB/vxBvYaoxxIt+RqFeK0GQlOxIF29WacF2NwA+ysmja9uIeRDDlLhNWR7SRXVq/jT7
X-Received: from rananta-virt.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:1bcc])
 (user=rananta job=sendgmr) by 2002:a17:90a:4a82:: with SMTP id
 f2mr2615207pjh.236.1635812556766; Mon, 01 Nov 2021 17:22:36 -0700 (PDT)
Date:   Tue,  2 Nov 2021 00:22:01 +0000
In-Reply-To: <20211102002203.1046069-1-rananta@google.com>
Message-Id: <20211102002203.1046069-7-rananta@google.com>
Mime-Version: 1.0
References: <20211102002203.1046069-1-rananta@google.com>
X-Mailer: git-send-email 2.33.1.1089.g2158813163f-goog
Subject: [RFC PATCH 6/8] tools: Import the firmware registers
From:   Raghavendra Rao Ananta <rananta@google.com>
To:     Marc Zyngier <maz@kernel.org>, Andrew Jones <drjones@redhat.com>,
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

Import the firmware definitions for the firmware registers,
KVM_REG_ARM_STD, KVM_REG_ARM_STD_HYP, and KVM_REG_ARM_VENDOR_HYP.

Signed-off-by: Raghavendra Rao Ananta <rananta@google.com>

---
 tools/arch/arm64/include/uapi/asm/kvm.h | 18 ++++++++++++++++++
 1 file changed, 18 insertions(+)

diff --git a/tools/arch/arm64/include/uapi/asm/kvm.h b/tools/arch/arm64/include/uapi/asm/kvm.h
index b3edde68bc3e..a1d0e8e69eed 100644
--- a/tools/arch/arm64/include/uapi/asm/kvm.h
+++ b/tools/arch/arm64/include/uapi/asm/kvm.h
@@ -281,6 +281,24 @@ struct kvm_arm_copy_mte_tags {
 #define KVM_REG_ARM_SMCCC_ARCH_WORKAROUND_2_NOT_REQUIRED	3
 #define KVM_REG_ARM_SMCCC_ARCH_WORKAROUND_2_ENABLED     	(1U << 4)
 
+#define KVM_REG_ARM_STD			KVM_REG_ARM_FW_REG(3)
+enum kvm_reg_arm_std_bmap {
+	KVM_REG_ARM_STD_TRNG_V1_0,
+	KVM_REG_ARM_STD_BMAP_MAX,
+};
+
+#define KVM_REG_ARM_STD_HYP		KVM_REG_ARM_FW_REG(4)
+enum kvm_reg_arm_std_hyp_bmap {
+	KVM_REG_ARM_STD_HYP_PV_TIME_ST,
+	KVM_REG_ARM_STD_HYP_BMAP_MAX,
+};
+
+#define KVM_REG_ARM_VENDOR_HYP		KVM_REG_ARM_FW_REG(5)
+enum kvm_reg_arm_vendor_hyp_bmap {
+	KVM_REG_ARM_VENDOR_HYP_PTP,
+	KVM_REG_ARM_VENDOR_HYP_BMAP_MAX,
+};
+
 /* SVE registers */
 #define KVM_REG_ARM64_SVE		(0x15 << KVM_REG_ARM_COPROC_SHIFT)
 
-- 
2.33.1.1089.g2158813163f-goog

