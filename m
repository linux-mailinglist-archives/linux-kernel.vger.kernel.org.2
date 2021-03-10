Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CCFC2334627
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Mar 2021 19:01:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233989AbhCJR7b (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 10 Mar 2021 12:59:31 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48942 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233825AbhCJR67 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 Mar 2021 12:58:59 -0500
Received: from mail-qt1-x84a.google.com (mail-qt1-x84a.google.com [IPv6:2607:f8b0:4864:20::84a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8741EC061760
        for <linux-kernel@vger.kernel.org>; Wed, 10 Mar 2021 09:58:59 -0800 (PST)
Received: by mail-qt1-x84a.google.com with SMTP id 16so13557101qtw.1
        for <linux-kernel@vger.kernel.org>; Wed, 10 Mar 2021 09:58:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=6iNTe0mF+hjFWLgudHI/zWSf2clb7t9N+GDYgm7EigU=;
        b=uaCdrsKfFSgEFJjwltC9RmF59Ae7yc016S997ZvqjUKBgk8suIeUI8tNo9lXnjVcFu
         2TLmSeOAjSDRESJ/NLQB7NEcltJ8lm7/1lgfPzBhrxE0X30r58dk52bDkKiWrJ0U/ly4
         RFLMCW7FhB3lzNXpvkxGbEEWw2VsVX/v89kRWom2NPXRitUUuaSEtxub5xzCfAQj/QEv
         ipn9/xy2+PZHU7mfi6Eelvf9mWH+vr113PBdfw6Sxgv9/ZaPo0n+ZxYF95KSUq8n96zJ
         1xkQHpOlRKYCDEukUW/4tZsL1k+hh9mrB1hZ/5M5eDoytop/zTSDu4VEhsAUZqUHU6W7
         SHUQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=6iNTe0mF+hjFWLgudHI/zWSf2clb7t9N+GDYgm7EigU=;
        b=nl7omQSs9BCBrp3FPvpWdPNjp4Y/ZYm9vpGv+8ODl/CsXUlppvZKfCXy3VLtRnTjYD
         YV3Co9ymcFrEnzJML7n+KyT0ymERsUlduDvvSP4sGbt/xH8pV+E4Al/gtBuwGMynfZj2
         hmLgp/jAU56Q7VpNahLQBQZVts7OmmGa/lWliHskXzi2mY3yJ3ZPYmTSUUcW4p5mIKA9
         fZWCMU+rJ4GXzOxdoTacYBjCoJTU2kmCqrF7pOv3moVYstVy0m4carnxnQz5d+SLlQY4
         YdB8AgW2ycaifLLeqbeD5xPDh/NQrTVUPxZHarimAEfm2tG8AkmYk7Xw0JIsemTzOBU9
         8oiw==
X-Gm-Message-State: AOAM531b5N9p3tH8aQxOc1Aq+JFwHuHn5QiaySZvcoCDnmJq+zY1YfuC
        eQN5aGGSPnjx14sPSCpHHi67CCnsHtzv
X-Google-Smtp-Source: ABdhPJyDfHqUWFaXueHB0jBN/4Y6pf8dWGEZxgcpIy7CVo3fvkDLvVm5LW+MkE2AJvNQ0cA1KndyOwMjPQzd
X-Received: from r2d2-qp.c.googlers.com ([fda3:e722:ac3:10:28:9cb1:c0a8:1652])
 (user=qperret job=sendgmr) by 2002:a0c:f092:: with SMTP id
 g18mr4249565qvk.11.1615399138690; Wed, 10 Mar 2021 09:58:58 -0800 (PST)
Date:   Wed, 10 Mar 2021 17:57:46 +0000
In-Reply-To: <20210310175751.3320106-1-qperret@google.com>
Message-Id: <20210310175751.3320106-30-qperret@google.com>
Mime-Version: 1.0
References: <20210310175751.3320106-1-qperret@google.com>
X-Mailer: git-send-email 2.30.1.766.gb4fecdf3b7-goog
Subject: [PATCH v4 29/34] KVM: arm64: Refactor stage2_map_set_prot_attr()
From:   Quentin Perret <qperret@google.com>
To:     catalin.marinas@arm.com, will@kernel.org, maz@kernel.org,
        james.morse@arm.com, julien.thierry.kdev@gmail.com,
        suzuki.poulose@arm.com
Cc:     android-kvm@google.com, linux-kernel@vger.kernel.org,
        kernel-team@android.com, kvmarm@lists.cs.columbia.edu,
        linux-arm-kernel@lists.infradead.org, tabba@google.com,
        mark.rutland@arm.com, dbrazdil@google.com, mate.toth-pal@arm.com,
        seanjc@google.com, qperret@google.com, robh+dt@kernel.org,
        ardb@kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In order to ease its re-use in other code paths, refactor
stage2_map_set_prot_attr() to not depend on a stage2_map_data struct.
No functional change intended.

Signed-off-by: Quentin Perret <qperret@google.com>
---
 arch/arm64/kvm/hyp/pgtable.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/arch/arm64/kvm/hyp/pgtable.c b/arch/arm64/kvm/hyp/pgtable.c
index e4670b639726..c16e0306dd9a 100644
--- a/arch/arm64/kvm/hyp/pgtable.c
+++ b/arch/arm64/kvm/hyp/pgtable.c
@@ -489,8 +489,7 @@ u64 kvm_get_vtcr(u64 mmfr0, u64 mmfr1, u32 phys_shift)
 	return vtcr;
 }
 
-static int stage2_map_set_prot_attr(enum kvm_pgtable_prot prot,
-				    struct stage2_map_data *data)
+static int stage2_set_prot_attr(enum kvm_pgtable_prot prot, kvm_pte_t *ptep)
 {
 	bool device = prot & KVM_PGTABLE_PROT_DEVICE;
 	kvm_pte_t attr = device ? PAGE_S2_MEMATTR(DEVICE_nGnRE) :
@@ -510,7 +509,8 @@ static int stage2_map_set_prot_attr(enum kvm_pgtable_prot prot,
 
 	attr |= FIELD_PREP(KVM_PTE_LEAF_ATTR_LO_S2_SH, sh);
 	attr |= KVM_PTE_LEAF_ATTR_LO_S2_AF;
-	data->attr = attr;
+	*ptep = attr;
+
 	return 0;
 }
 
@@ -728,7 +728,7 @@ int kvm_pgtable_stage2_map(struct kvm_pgtable *pgt, u64 addr, u64 size,
 		.arg		= &map_data,
 	};
 
-	ret = stage2_map_set_prot_attr(prot, &map_data);
+	ret = stage2_set_prot_attr(prot, &map_data.attr);
 	if (ret)
 		return ret;
 
-- 
2.30.1.766.gb4fecdf3b7-goog

