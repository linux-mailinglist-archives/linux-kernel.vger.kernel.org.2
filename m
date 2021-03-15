Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A01F533BF05
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Mar 2021 15:53:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241657AbhCOOxG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 15 Mar 2021 10:53:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52434 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237237AbhCOOgu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 Mar 2021 10:36:50 -0400
Received: from mail-qv1-xf49.google.com (mail-qv1-xf49.google.com [IPv6:2607:f8b0:4864:20::f49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D6B23C0613F0
        for <linux-kernel@vger.kernel.org>; Mon, 15 Mar 2021 07:36:42 -0700 (PDT)
Received: by mail-qv1-xf49.google.com with SMTP id d15so23049359qvn.16
        for <linux-kernel@vger.kernel.org>; Mon, 15 Mar 2021 07:36:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=N5s0/RbCYhUO0g3Zm7KUzHx7P+K05LDC1HPuvdfEh+U=;
        b=Zsr83XwouEaIFsOmKQebxP45mo30AcyU+79WfY13WWpqz/30q9YdfnTxkyZhfj4VMZ
         5N/PN65sKtqHEJ0F7UO0XwE1vmkX7WtfR826THltDl1QzGmODdsxznZTxGJxLzAu/yzG
         y9RwL/puLSAhwnVRhvMKPNlJawAso9JrVyO4xGrNIXpLUR6kLrUXrcYr49cGvE61PFPf
         FZePHK8+5oT3IAIqvVyfnn5LOye9zY9F3xBDEwVULgG+wtjmJJ9jFJlhz3Nr+lQOKnpP
         t27x2C0hTSaHAYrMf2x4MjJFG86zg9sHfStokpDLnSewSGscu7pYDrp+0JNAcI0xlpwV
         nGtw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=N5s0/RbCYhUO0g3Zm7KUzHx7P+K05LDC1HPuvdfEh+U=;
        b=oCtu1HJiJLRCSc+7e4YmWRwcvolhFo+t6vY7kBvdghePLaDTVTePeIpUTqE8IA1WIU
         qDtrPvLNK4BwpdGbOrQJ4HN9sstALQLo9JDuVWtoe3yIctftA+KVdeMvWoQ9cdgEiqw1
         x7OVAC4rAy9V3tN+ToPSmC9WfPqFDCNL2lNNyICbwIORfCtfnJ8w0FoUEumys5IgoUoB
         3g1dTJgThrLol5E13dTGPkPwX2ZF3pjkMh2QqtcLAhOckQexZ6/s6T9QPHlKdzZ5yM1i
         cNHzZmYbJLsaMIG0nBRWnulGn2EYSVvHiG//ddLFZ501/78d876+s01b7AKK3lB65mxi
         RYqw==
X-Gm-Message-State: AOAM531yTf+++qrajgN79dfeNRM2oG0IEJhCEoVXtA0Q8Mk1pAOCAoJK
        WD8/uAB6JtsHaja1ZJ1fcIAICqmCO5yw
X-Google-Smtp-Source: ABdhPJwsW3+UISmJa1GuCOTEPA/v4H+6KrK3TX2T8OvR6HABWCt5lvp9HyL96vdBHaY+aTq+PjSpuKjXnCOH
X-Received: from r2d2-qp.c.googlers.com ([fda3:e722:ac3:10:28:9cb1:c0a8:1652])
 (user=qperret job=sendgmr) by 2002:ad4:472d:: with SMTP id
 l13mr11032486qvz.17.1615819002072; Mon, 15 Mar 2021 07:36:42 -0700 (PDT)
Date:   Mon, 15 Mar 2021 14:35:30 +0000
In-Reply-To: <20210315143536.214621-1-qperret@google.com>
Message-Id: <20210315143536.214621-31-qperret@google.com>
Mime-Version: 1.0
References: <20210315143536.214621-1-qperret@google.com>
X-Mailer: git-send-email 2.31.0.rc2.261.g7f71774620-goog
Subject: [PATCH v5 30/36] KVM: arm64: Refactor the *_map_set_prot_attr() helpers
From:   Quentin Perret <qperret@google.com>
To:     catalin.marinas@arm.com, will@kernel.org, maz@kernel.org,
        james.morse@arm.com, julien.thierry.kdev@gmail.com,
        suzuki.poulose@arm.com
Cc:     android-kvm@google.com, seanjc@google.com, mate.toth-pal@arm.com,
        linux-kernel@vger.kernel.org, robh+dt@kernel.org,
        linux-arm-kernel@lists.infradead.org, kernel-team@android.com,
        kvmarm@lists.cs.columbia.edu, tabba@google.com, ardb@kernel.org,
        mark.rutland@arm.com, dbrazdil@google.com, qperret@google.com
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In order to ease their re-use in other code paths, refactor the
*_map_set_prot_attr() helpers to not depend on a map_data struct.
No functional change intended.

Acked-by: Will Deacon <will@kernel.org>
Signed-off-by: Quentin Perret <qperret@google.com>
---
 arch/arm64/kvm/hyp/pgtable.c | 16 ++++++++--------
 1 file changed, 8 insertions(+), 8 deletions(-)

diff --git a/arch/arm64/kvm/hyp/pgtable.c b/arch/arm64/kvm/hyp/pgtable.c
index bd44e84dedc4..a5347d78293f 100644
--- a/arch/arm64/kvm/hyp/pgtable.c
+++ b/arch/arm64/kvm/hyp/pgtable.c
@@ -324,8 +324,7 @@ struct hyp_map_data {
 	struct kvm_pgtable_mm_ops	*mm_ops;
 };
 
-static int hyp_map_set_prot_attr(enum kvm_pgtable_prot prot,
-				 struct hyp_map_data *data)
+static int hyp_set_prot_attr(enum kvm_pgtable_prot prot, kvm_pte_t *ptep)
 {
 	bool device = prot & KVM_PGTABLE_PROT_DEVICE;
 	u32 mtype = device ? MT_DEVICE_nGnRE : MT_NORMAL;
@@ -350,7 +349,8 @@ static int hyp_map_set_prot_attr(enum kvm_pgtable_prot prot,
 	attr |= FIELD_PREP(KVM_PTE_LEAF_ATTR_LO_S1_AP, ap);
 	attr |= FIELD_PREP(KVM_PTE_LEAF_ATTR_LO_S1_SH, sh);
 	attr |= KVM_PTE_LEAF_ATTR_LO_S1_AF;
-	data->attr = attr;
+	*ptep = attr;
+
 	return 0;
 }
 
@@ -407,7 +407,7 @@ int kvm_pgtable_hyp_map(struct kvm_pgtable *pgt, u64 addr, u64 size, u64 phys,
 		.arg	= &map_data,
 	};
 
-	ret = hyp_map_set_prot_attr(prot, &map_data);
+	ret = hyp_set_prot_attr(prot, &map_data.attr);
 	if (ret)
 		return ret;
 
@@ -500,8 +500,7 @@ u64 kvm_get_vtcr(u64 mmfr0, u64 mmfr1, u32 phys_shift)
 	return vtcr;
 }
 
-static int stage2_map_set_prot_attr(enum kvm_pgtable_prot prot,
-				    struct stage2_map_data *data)
+static int stage2_set_prot_attr(enum kvm_pgtable_prot prot, kvm_pte_t *ptep)
 {
 	bool device = prot & KVM_PGTABLE_PROT_DEVICE;
 	kvm_pte_t attr = device ? PAGE_S2_MEMATTR(DEVICE_nGnRE) :
@@ -521,7 +520,8 @@ static int stage2_map_set_prot_attr(enum kvm_pgtable_prot prot,
 
 	attr |= FIELD_PREP(KVM_PTE_LEAF_ATTR_LO_S2_SH, sh);
 	attr |= KVM_PTE_LEAF_ATTR_LO_S2_AF;
-	data->attr = attr;
+	*ptep = attr;
+
 	return 0;
 }
 
@@ -741,7 +741,7 @@ int kvm_pgtable_stage2_map(struct kvm_pgtable *pgt, u64 addr, u64 size,
 		.arg		= &map_data,
 	};
 
-	ret = stage2_map_set_prot_attr(prot, &map_data);
+	ret = stage2_set_prot_attr(prot, &map_data.attr);
 	if (ret)
 		return ret;
 
-- 
2.31.0.rc2.261.g7f71774620-goog

