Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 047D83DA43D
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Jul 2021 15:29:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237798AbhG2N3F (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 29 Jul 2021 09:29:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46290 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237726AbhG2N2w (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Jul 2021 09:28:52 -0400
Received: from mail-qk1-x74a.google.com (mail-qk1-x74a.google.com [IPv6:2607:f8b0:4864:20::74a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1274CC06179F
        for <linux-kernel@vger.kernel.org>; Thu, 29 Jul 2021 06:28:49 -0700 (PDT)
Received: by mail-qk1-x74a.google.com with SMTP id bm25-20020a05620a1999b02903a9c3f8b89fso3857947qkb.2
        for <linux-kernel@vger.kernel.org>; Thu, 29 Jul 2021 06:28:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=K2yJYY4AwV+vn/rNuC2tG6Gq9ljpo+CbL9CfXBwYhKs=;
        b=QOeabQvhK+pjySXM7mdcCBpwBPGxHA2Aapue3mH3nglJQ48pdBSi1Gn+iql4C+ZGom
         yxB9Fd0YJyOA5p4oPp5VddH6E/ae1UId3M3sSiQLeXVEXTAyT8WEuAcHH4S3tIGW4GL7
         7wL1UZpRFNTcYPQ5V4zS3cIm55suJij7Ous/EuOVId5PU1TniXtP5Aqb0dVNxvTPxtlj
         KiaaQa51mTF7lD9V2qlqCFAKM3pn6tq7MWusSXIEem4MarzZ67Wycb9NnvuHlTS06wLf
         E0b4JNz5c1tJLmgcdHVU3XSzLEhKhe3NqjOJO2gPG+nEK+YdR7Kj2Kw1hj8Xb/tq07w5
         5N5A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=K2yJYY4AwV+vn/rNuC2tG6Gq9ljpo+CbL9CfXBwYhKs=;
        b=okpp9EY1c17Y24c90EjmYkKhrCgtETrsuhWBgDH8li5fCtqZoy6mZA0spylSTtvT/d
         zuw+tWcW+6UyfSCgDKyHkmIgYYAizlZmIvpKVCJDw1HnMp8FfLyKqIKSxLL6XFa6AIng
         KFJ5tBPpdN4WBdkWG3XidxZAzh6YyERgXh+OtEAtIvmobRNZGTMmWlaNMDBTe8fqGnTI
         R3Iq4lI+1FFfKqat1Hx2aTrcc4+HyjFGzwCq7zBXhOlnew4hzThfN+vDO/WXoDc18mxl
         LrGTR8Mk46JgFRd0YMRQ5qNfXjJ/W/z0nncGrXm7xVh5qVOmP/eBeiqxI9mY34DNhW6B
         S+Xg==
X-Gm-Message-State: AOAM533axrCMv6B36mArhqYnAjfffIRk4L2heJaVQ4FChnMTSAwVdp/M
        xdOvrY9XcI09HOII4t9Q1ulGWCC7NgpD
X-Google-Smtp-Source: ABdhPJxz1R05cTjKGeAzbyffgsjdEJ6FuTW+MEeZoslgi5BQPfW/okp9D2w7vU3mDjPYNqOPOTSTUIW1Zb/l
X-Received: from luke.lon.corp.google.com ([2a00:79e0:d:210:293a:bc89:7514:5218])
 (user=qperret job=sendgmr) by 2002:a05:6214:10c8:: with SMTP id
 r8mr5270070qvs.28.1627565328196; Thu, 29 Jul 2021 06:28:48 -0700 (PDT)
Date:   Thu, 29 Jul 2021 14:28:08 +0100
In-Reply-To: <20210729132818.4091769-1-qperret@google.com>
Message-Id: <20210729132818.4091769-12-qperret@google.com>
Mime-Version: 1.0
References: <20210729132818.4091769-1-qperret@google.com>
X-Mailer: git-send-email 2.32.0.432.gabb21c7263-goog
Subject: [PATCH v3 11/21] KVM: arm64: Allow populating software bits
From:   Quentin Perret <qperret@google.com>
To:     maz@kernel.org, james.morse@arm.com, alexandru.elisei@arm.com,
        suzuki.poulose@arm.com, catalin.marinas@arm.com, will@kernel.org
Cc:     linux-arm-kernel@lists.infradead.org, kvmarm@lists.cs.columbia.edu,
        linux-kernel@vger.kernel.org, ardb@kernel.org, qwandor@google.com,
        tabba@google.com, dbrazdil@google.com, kernel-team@android.com,
        Quentin Perret <qperret@google.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Introduce infrastructure allowing to manipulate software bits in stage-1
and stage-2 page-tables using additional entries in the kvm_pgtable_prot
enum.

This is heavily inspired by Marc's implementation of a similar feature
in the NV patch series, but adapted to allow stage-1 changes as well:

  https://lore.kernel.org/kvmarm/20210510165920.1913477-56-maz@kernel.org/

Suggested-by: Marc Zyngier <maz@kernel.org>
Signed-off-by: Quentin Perret <qperret@google.com>
---
 arch/arm64/include/asm/kvm_pgtable.h | 12 +++++++++++-
 arch/arm64/kvm/hyp/pgtable.c         |  5 +++++
 2 files changed, 16 insertions(+), 1 deletion(-)

diff --git a/arch/arm64/include/asm/kvm_pgtable.h b/arch/arm64/include/asm/kvm_pgtable.h
index ba7dcade2798..d5ca9b6ce241 100644
--- a/arch/arm64/include/asm/kvm_pgtable.h
+++ b/arch/arm64/include/asm/kvm_pgtable.h
@@ -121,6 +121,10 @@ enum kvm_pgtable_stage2_flags {
  * @KVM_PGTABLE_PROT_W:		Write permission.
  * @KVM_PGTABLE_PROT_R:		Read permission.
  * @KVM_PGTABLE_PROT_DEVICE:	Device attributes.
+ * @KVM_PGTABLE_PROT_SW0:	Software bit 0.
+ * @KVM_PGTABLE_PROT_SW1:	Software bit 1.
+ * @KVM_PGTABLE_PROT_SW2:	Software bit 2.
+ * @KVM_PGTABLE_PROT_SW3:	Software bit 3.
  */
 enum kvm_pgtable_prot {
 	KVM_PGTABLE_PROT_X			= BIT(0),
@@ -128,6 +132,11 @@ enum kvm_pgtable_prot {
 	KVM_PGTABLE_PROT_R			= BIT(2),
 
 	KVM_PGTABLE_PROT_DEVICE			= BIT(3),
+
+	KVM_PGTABLE_PROT_SW0			= BIT(55),
+	KVM_PGTABLE_PROT_SW1			= BIT(56),
+	KVM_PGTABLE_PROT_SW2			= BIT(57),
+	KVM_PGTABLE_PROT_SW3			= BIT(58),
 };
 
 #define KVM_PGTABLE_PROT_RW	(KVM_PGTABLE_PROT_R | KVM_PGTABLE_PROT_W)
@@ -419,7 +428,8 @@ kvm_pte_t kvm_pgtable_stage2_mkold(struct kvm_pgtable *pgt, u64 addr);
  * If there is a valid, leaf page-table entry used to translate @addr, then
  * relax the permissions in that entry according to the read, write and
  * execute permissions specified by @prot. No permissions are removed, and
- * TLB invalidation is performed after updating the entry.
+ * TLB invalidation is performed after updating the entry. Software bits cannot
+ * be set or cleared using kvm_pgtable_stage2_relax_perms().
  *
  * Return: 0 on success, negative error code on failure.
  */
diff --git a/arch/arm64/kvm/hyp/pgtable.c b/arch/arm64/kvm/hyp/pgtable.c
index bcc02e6e0f62..1915489bb127 100644
--- a/arch/arm64/kvm/hyp/pgtable.c
+++ b/arch/arm64/kvm/hyp/pgtable.c
@@ -357,6 +357,7 @@ static int hyp_set_prot_attr(enum kvm_pgtable_prot prot, kvm_pte_t *ptep)
 	attr |= FIELD_PREP(KVM_PTE_LEAF_ATTR_LO_S1_AP, ap);
 	attr |= FIELD_PREP(KVM_PTE_LEAF_ATTR_LO_S1_SH, sh);
 	attr |= KVM_PTE_LEAF_ATTR_LO_S1_AF;
+	attr |= prot & KVM_PTE_LEAF_ATTR_HI_SW;
 	*ptep = attr;
 
 	return 0;
@@ -558,6 +559,7 @@ static int stage2_set_prot_attr(struct kvm_pgtable *pgt, enum kvm_pgtable_prot p
 
 	attr |= FIELD_PREP(KVM_PTE_LEAF_ATTR_LO_S2_SH, sh);
 	attr |= KVM_PTE_LEAF_ATTR_LO_S2_AF;
+	attr |= prot & KVM_PTE_LEAF_ATTR_HI_SW;
 	*ptep = attr;
 
 	return 0;
@@ -1025,6 +1027,9 @@ int kvm_pgtable_stage2_relax_perms(struct kvm_pgtable *pgt, u64 addr,
 	u32 level;
 	kvm_pte_t set = 0, clr = 0;
 
+	if (prot & KVM_PTE_LEAF_ATTR_HI_SW)
+		return -EINVAL;
+
 	if (prot & KVM_PGTABLE_PROT_R)
 		set |= KVM_PTE_LEAF_ATTR_LO_S2_S2AP_R;
 
-- 
2.32.0.432.gabb21c7263-goog

