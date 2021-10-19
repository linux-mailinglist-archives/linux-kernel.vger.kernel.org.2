Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6481643359B
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Oct 2021 14:13:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235625AbhJSMPk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 19 Oct 2021 08:15:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33238 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235588AbhJSMPb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Oct 2021 08:15:31 -0400
Received: from mail-wm1-x34a.google.com (mail-wm1-x34a.google.com [IPv6:2a00:1450:4864:20::34a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 80180C061769
        for <linux-kernel@vger.kernel.org>; Tue, 19 Oct 2021 05:13:17 -0700 (PDT)
Received: by mail-wm1-x34a.google.com with SMTP id v10-20020a1cf70a000000b00318203a6bd1so1072497wmh.6
        for <linux-kernel@vger.kernel.org>; Tue, 19 Oct 2021 05:13:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=++xVX7cq9dri2+SFZW5WIc0fF/Kl7wWBtgdSK2pMHEw=;
        b=YfeNcGEPdATddU+z3YnUUEeQ58+n/htJaUr7pcFV0pLA8xf8N3BummwMBtbl3EkXsd
         5k5yC2YGf2i6gvmE+RzgT0nkae5+wdy/qpTCYJ2RFzC+k0trTK9gggZpZpt8KAEIh0Fa
         ewhY3rYjID7F6W3V0jeBklt1ck6TqnAD2uCqaZ2EjRpP12OowyDJSEC/xSOu6LMRgjju
         4IcUs8iFs92golKvI4zYNg+BTy+L8nK5+HfpFxA9z/rdh4Gg4waWf2oAdnC8KUoxp8N9
         LhGqQkkyjCCBEo5f856TkfoeG0dIh52NHjH5Jedm2jt+9zDWLyDLl2hgbw60pjmTfn+n
         0NYA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=++xVX7cq9dri2+SFZW5WIc0fF/Kl7wWBtgdSK2pMHEw=;
        b=ur9NVxMKNuySkzdcSkwfK0LxQa5Wh128k0SBtBMNZfZiF9XINWH5yQDiDF5A7fzzvj
         NXrHDnt9NTXyjUdjzg+5bWTEnaR1NsHhp600+1o++3vabHC5iPm7R/+XBveeaKQgjBBD
         04YWR6bywSJfLMh2Tks3zN2mQAhXC9+wCeza1Mpq2ZuUA+MUtEP0wsFCCxXuEtFOAxtk
         7qo7NZFDinLgGKIbddQhvsS+BX4nVVNSYI/xxmESuQ90y9OIl8w6kVESZbzD5IJY2nyG
         rrJpr12ldv2kjRdz4ZGpeU5cPFoMrYKz/u5o2Ijoz7TsAtkSvhkpsWpVArJSLLKVir9Y
         U4QA==
X-Gm-Message-State: AOAM533a1l+kbGO/q69sKt/lV3rOC8mYzTVrI9TrJBSXW6NHAy56rOGw
        S761UIYynYb6yyI/lH9uwgDQM/IsI2i4
X-Google-Smtp-Source: ABdhPJyUp2THf2vqTs2t6aOxbzWJ1ZyfKwGpN2QbKlKxK+/isqHvkyIyOmDTVZPJdG4S62oIcZFlzqHeLYBK
X-Received: from luke.lon.corp.google.com ([2a00:79e0:d:210:59ca:401f:83a8:de6d])
 (user=qperret job=sendgmr) by 2002:adf:b1d4:: with SMTP id
 r20mr43489909wra.308.1634645596136; Tue, 19 Oct 2021 05:13:16 -0700 (PDT)
Date:   Tue, 19 Oct 2021 13:12:53 +0100
In-Reply-To: <20211019121304.2732332-1-qperret@google.com>
Message-Id: <20211019121304.2732332-5-qperret@google.com>
Mime-Version: 1.0
References: <20211019121304.2732332-1-qperret@google.com>
X-Mailer: git-send-email 2.33.0.1079.g6e70778dc9-goog
Subject: [PATCH v2 04/15] KVM: arm64: Fixup hyp stage-1 refcount
From:   Quentin Perret <qperret@google.com>
To:     Marc Zyngier <maz@kernel.org>, James Morse <james.morse@arm.com>,
        Alexandru Elisei <alexandru.elisei@arm.com>,
        Suzuki K Poulose <suzuki.poulose@arm.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>, Fuad Tabba <tabba@google.com>,
        David Brazdil <dbrazdil@google.com>,
        Andrew Walbran <qwandor@google.com>
Cc:     linux-arm-kernel@lists.infradead.org, kvmarm@lists.cs.columbia.edu,
        linux-kernel@vger.kernel.org, kernel-team@android.com,
        qperret@google.com
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In nVHE-protected mode, the hyp stage-1 page-table refcount is broken
due to the lack of refcount support in the early allocator. Fix-up the
refcount in the finalize walker, once the 'hyp_vmemmap' is up and running.

Signed-off-by: Quentin Perret <qperret@google.com>
---
 arch/arm64/kvm/hyp/nvhe/setup.c | 31 +++++++++++++++++++++----------
 1 file changed, 21 insertions(+), 10 deletions(-)

diff --git a/arch/arm64/kvm/hyp/nvhe/setup.c b/arch/arm64/kvm/hyp/nvhe/setup.c
index 862c7b514e20..9e5c92237a51 100644
--- a/arch/arm64/kvm/hyp/nvhe/setup.c
+++ b/arch/arm64/kvm/hyp/nvhe/setup.c
@@ -167,12 +167,22 @@ static int finalize_host_mappings_walker(u64 addr, u64 end, u32 level,
 {
 	enum kvm_pgtable_prot prot;
 	enum pkvm_page_state state;
+	struct kvm_pgtable_mm_ops *mm_ops = arg;
 	kvm_pte_t pte = *ptep;
 	phys_addr_t phys;
 
 	if (!kvm_pte_valid(pte))
 		return 0;
 
+	/*
+	 * Fix-up the refcount for the page-table pages as the early allocator
+	 * was unable to access the hyp_vmemmap and so the buddy allocator has
+	 * initialised the refcount to '1'.
+	 */
+	mm_ops->get_page(ptep);
+	if (flag != KVM_PGTABLE_WALK_LEAF)
+		return 0;
+
 	if (level != (KVM_PGTABLE_MAX_LEVELS - 1))
 		return -EINVAL;
 
@@ -205,7 +215,8 @@ static int finalize_host_mappings(void)
 {
 	struct kvm_pgtable_walker walker = {
 		.cb	= finalize_host_mappings_walker,
-		.flags	= KVM_PGTABLE_WALK_LEAF,
+		.flags	= KVM_PGTABLE_WALK_LEAF | KVM_PGTABLE_WALK_TABLE_POST,
+		.arg	= pkvm_pgtable.mm_ops,
 	};
 
 	return kvm_pgtable_walk(&pkvm_pgtable, 0, BIT(pkvm_pgtable.ia_bits), &walker);
@@ -230,19 +241,19 @@ void __noreturn __pkvm_init_finalise(void)
 	if (ret)
 		goto out;
 
-	ret = finalize_host_mappings();
-	if (ret)
-		goto out;
-
 	pkvm_pgtable_mm_ops = (struct kvm_pgtable_mm_ops) {
-		.zalloc_page = hyp_zalloc_hyp_page,
-		.phys_to_virt = hyp_phys_to_virt,
-		.virt_to_phys = hyp_virt_to_phys,
-		.get_page = hpool_get_page,
-		.put_page = hpool_put_page,
+		.zalloc_page	= hyp_zalloc_hyp_page,
+		.phys_to_virt	= hyp_phys_to_virt,
+		.virt_to_phys	= hyp_virt_to_phys,
+		.get_page	= hpool_get_page,
+		.put_page	= hpool_put_page,
 	};
 	pkvm_pgtable.mm_ops = &pkvm_pgtable_mm_ops;
 
+	ret = finalize_host_mappings();
+	if (ret)
+		goto out;
+
 out:
 	/*
 	 * We tail-called to here from handle___pkvm_init() and will not return,
-- 
2.33.0.1079.g6e70778dc9-goog

