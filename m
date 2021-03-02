Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DE26532A8FD
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Mar 2021 19:09:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1580471AbhCBSDn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 2 Mar 2021 13:03:43 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49892 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1578600AbhCBPZZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 Mar 2021 10:25:25 -0500
Received: from mail-wr1-x449.google.com (mail-wr1-x449.google.com [IPv6:2a00:1450:4864:20::449])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4B3E9C0698CF
        for <linux-kernel@vger.kernel.org>; Tue,  2 Mar 2021 07:01:09 -0800 (PST)
Received: by mail-wr1-x449.google.com with SMTP id g2so4338446wrx.20
        for <linux-kernel@vger.kernel.org>; Tue, 02 Mar 2021 07:01:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=sender:date:in-reply-to:message-id:mime-version:references:subject
         :from:to:cc;
        bh=MUiu5cL4XJy7bcbjb67w8AVccQ6swyc7cTqk7H/pito=;
        b=V2tQz8JIPctM0p8zJgSN56SE2f+sjG4GB6ZR55LMQiswnxYtR/ePVhbwO/o8W66G0b
         PbHVynwDMo4m5hQTkVbwHPUN6c0PkFKQE/sf5DH5nMyM0tggxmbD3FPQjbi6a0POeCz+
         jh+2Nsxcsol/OZxoAVv6MqFZjCqNUXiv4O8MXjSVu9i+FDKGBgulOa9tkVjyrYK5Z9Bd
         Nq67f+OAletST31RgOjWXRR0vHMxg7CzWFcXeOoLWmi9Q4vWw9Jmfj0fTHu7FSTjC0o5
         F2L8XjgbG6jShJL/W0Af7NMKKMKboklNsvT6OliD+fo6afqsvX1EexCiNHhJOW3b0KIF
         4qmA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=MUiu5cL4XJy7bcbjb67w8AVccQ6swyc7cTqk7H/pito=;
        b=I5canhULxGP0vExjT2qxrUAb0zFpeNDNLlPc541LbcuuR583OoC1qJDit9kc2fOf1N
         ua8jS1EeMo69ZkvaaHrCdbjUyFSArbMW6uVfuhOuArKX6T4PvlsxT73e5yUV1lRbwO/9
         ZJGT4R13NkkIdfbxtRn2MJuKC2r3qvIPe+ngBNLge3cXsRswLHx8109lwXLXRFgJRU6F
         psHezcV4Y5CYxbriCg7SefhPgR+iIbTuqkUztws6pi3i/v2ippI3j70c9KZF4yRzDQy6
         /g41bap8Fv+TihWHBwjbkP29M/tgkkCCQA1vTrXubUNfPoJwQsdtW1E+Fe9doxiZ6wrG
         OGMA==
X-Gm-Message-State: AOAM530LjDxXxi8itOjeYMIOi1Mxydqxii/l3wj9Jk7Zse/lkQ1JVfp5
        F3JFWD6e3Ys9fXOT7ccZeoGQgHVLhobI
X-Google-Smtp-Source: ABdhPJz9F9KFBBfsTkBPKASwdRvs8WkwjMfKCJcm0vk7lvPEyGjjf4UWYBSGhgGbD6PbV21B/moA66tRIrG2
Sender: "qperret via sendgmr" <qperret@r2d2-qp.c.googlers.com>
X-Received: from r2d2-qp.c.googlers.com ([fda3:e722:ac3:10:28:9cb1:c0a8:1652])
 (user=qperret job=sendgmr) by 2002:a7b:c18e:: with SMTP id
 y14mr495903wmi.1.1614697267665; Tue, 02 Mar 2021 07:01:07 -0800 (PST)
Date:   Tue,  2 Mar 2021 14:59:57 +0000
In-Reply-To: <20210302150002.3685113-1-qperret@google.com>
Message-Id: <20210302150002.3685113-28-qperret@google.com>
Mime-Version: 1.0
References: <20210302150002.3685113-1-qperret@google.com>
X-Mailer: git-send-email 2.30.1.766.gb4fecdf3b7-goog
Subject: [PATCH v3 27/32] KVM: arm64: Refactor stage2_map_set_prot_attr()
From:   Quentin Perret <qperret@google.com>
To:     catalin.marinas@arm.com, will@kernel.org, maz@kernel.org,
        james.morse@arm.com, julien.thierry.kdev@gmail.com,
        suzuki.poulose@arm.com
Cc:     android-kvm@google.com, linux-kernel@vger.kernel.org,
        kernel-team@android.com, kvmarm@lists.cs.columbia.edu,
        linux-arm-kernel@lists.infradead.org, tabba@google.com,
        mark.rutland@arm.com, dbrazdil@google.com, mate.toth-pal@arm.com,
        seanjc@google.com, qperret@google.com, robh+dt@kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In order to ease its re-use in other code paths, refactor
stage2_map_set_prot_attr() to not depend on a stage2_map_data struct.
No functional change intended.

Signed-off-by: Quentin Perret <qperret@google.com>
---
 arch/arm64/kvm/hyp/pgtable.c | 19 ++++++++-----------
 1 file changed, 8 insertions(+), 11 deletions(-)

diff --git a/arch/arm64/kvm/hyp/pgtable.c b/arch/arm64/kvm/hyp/pgtable.c
index 8e7059fcfd40..8aa01a9e2603 100644
--- a/arch/arm64/kvm/hyp/pgtable.c
+++ b/arch/arm64/kvm/hyp/pgtable.c
@@ -494,8 +494,7 @@ u64 kvm_get_vtcr(u64 mmfr0, u64 mmfr1, u32 phys_shift)
 	return vtcr;
 }
 
-static int stage2_map_set_prot_attr(enum kvm_pgtable_prot prot,
-				    struct stage2_map_data *data)
+static kvm_pte_t stage2_get_prot_attr(enum kvm_pgtable_prot prot)
 {
 	bool device = prot & KVM_PGTABLE_PROT_DEVICE;
 	kvm_pte_t attr = device ? PAGE_S2_MEMATTR(DEVICE_nGnRE) :
@@ -504,15 +503,15 @@ static int stage2_map_set_prot_attr(enum kvm_pgtable_prot prot,
 
 	if (prot & KVM_PGTABLE_PROT_NONE) {
 		if (prot != KVM_PGTABLE_PROT_NONE)
-			return -EINVAL;
+			return 0;
 		attr |= KVM_PTE_LEAF_SW_BIT_PROT_NONE;
-		goto out;
+		return attr;
 	}
 
 	if (!(prot & KVM_PGTABLE_PROT_X))
 		attr |= KVM_PTE_LEAF_ATTR_HI_S2_XN;
 	else if (device)
-		return -EINVAL;
+		return 0;
 
 	if (prot & KVM_PGTABLE_PROT_R)
 		attr |= KVM_PTE_LEAF_ATTR_LO_S2_S2AP_R;
@@ -523,9 +522,7 @@ static int stage2_map_set_prot_attr(enum kvm_pgtable_prot prot,
 	attr |= FIELD_PREP(KVM_PTE_LEAF_ATTR_LO_S2_SH, sh);
 	attr |= KVM_PTE_LEAF_ATTR_LO_S2_AF;
 
-out:
-	data->attr = attr;
-	return 0;
+	return attr;
 }
 
 static int stage2_map_walker_try_leaf(u64 addr, u64 end, u32 level,
@@ -708,9 +705,9 @@ int kvm_pgtable_stage2_map(struct kvm_pgtable *pgt, u64 addr, u64 size,
 		.arg		= &map_data,
 	};
 
-	ret = stage2_map_set_prot_attr(prot, &map_data);
-	if (ret)
-		return ret;
+	map_data.attr = stage2_get_prot_attr(prot);
+	if (!map_data.attr)
+		return -EINVAL;
 
 	ret = kvm_pgtable_walk(pgt, addr, size, &walker);
 	dsb(ishst);
-- 
2.30.1.766.gb4fecdf3b7-goog

