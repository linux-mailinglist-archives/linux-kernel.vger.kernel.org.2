Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 594C030CAE5
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Feb 2021 20:06:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239445AbhBBTEH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 2 Feb 2021 14:04:07 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57552 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239175AbhBBTBY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 Feb 2021 14:01:24 -0500
Received: from mail-pj1-x104a.google.com (mail-pj1-x104a.google.com [IPv6:2607:f8b0:4864:20::104a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8955DC061225
        for <linux-kernel@vger.kernel.org>; Tue,  2 Feb 2021 10:58:05 -0800 (PST)
Received: by mail-pj1-x104a.google.com with SMTP id a22so2799409pjs.2
        for <linux-kernel@vger.kernel.org>; Tue, 02 Feb 2021 10:58:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=sender:date:in-reply-to:message-id:mime-version:references:subject
         :from:to:cc;
        bh=TvzNxZEmeauTq2Q8+NC26kwWaevzAKsfhvaBGBmdGZw=;
        b=T+DimJrwM2NuQebN6GQIVbIHXPhvE6MCkly0TwLwZfbQAzn865KoEtBuZzk4JO3R1v
         pkgXztB7dyVKmSGuyYfBNMzHE6JbhBjNKjHfFnkxuO/LBRg8BQ4pmpxd0RjE6ZR+jOUw
         OTxW/3s9L2DcmM6t60b5OZZm26CfiQ97p0RLtZIOLom5oz7QW+MKJh3UDiV5P66CfoBH
         end2v+qmW3oic7P1yvm0YYujO6S29t9glJYKRRYHX11iNNEHXG8m8Ij6l5k9EPVd1bj+
         rUA9Yaq3tfSpD2e0a6z1SWatxGFl53QN1fL/D3uATKsvN62XdSxngWdyGsvO2cAeERZs
         UOVA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=TvzNxZEmeauTq2Q8+NC26kwWaevzAKsfhvaBGBmdGZw=;
        b=bku3+SEJyWmBiJt+jQuztLVkEQLAI70ZqDUz+eg3qXn3Grc1VBljs+Z8RTtssgIpvl
         3I7dqHlr0WNdU5wkUcQD8CNMxmL5WQOZPdnWFx9Qpkxeb3LF7fZ1LKBFoWWwTKvDE1yE
         f+nfI6uCW/b34TNB4U2ieTbbJnOp4FFTdLXIUtu2oYpjssiq0LadSIjYRMpMHTkomZ8k
         qubhbtQT2MHojxNDUUs+kyEYUCx/YwodZ3i+9bR3gqVTSEOWTPRvLIVtp9r6JtxcYM49
         iGmLW2PeIbfNdmvG6j7OKWtjV0tYRnI5mq/SyUMp1R+Jf4Uy/e+8ceXvV0m+iPMpPZkx
         QAjQ==
X-Gm-Message-State: AOAM530QS4gtIuWTuIhzA3udwx8jsIcxYcppFn+EhmcldDzGKk0Ql0fm
        1ZIvO3BtcYq8m8z0IUQgQIuVoHLBCch/Z1a1JHB/meqmESyCFFt1RqB9sgpky+6esu4ZNqbGWkC
        +esYjbgBks2/dG19cBEXnWaXsINzRSa965vb/xEPaRvg1XO1Xz6quwhAkk2PI0GBUwaYadXuN
X-Google-Smtp-Source: ABdhPJxAoifktld/mM+14GeUwIjNAf6XLVqMicqaxaKI0BFtXVEKCZdf91ZkAToJ7z7NNV1jwuaH7UXFTYdR
Sender: "bgardon via sendgmr" <bgardon@bgardon.sea.corp.google.com>
X-Received: from bgardon.sea.corp.google.com ([2620:15c:100:202:9090:561:5a98:6d47])
 (user=bgardon job=sendgmr) by 2002:a63:703:: with SMTP id 3mr23018613pgh.272.1612292285011;
 Tue, 02 Feb 2021 10:58:05 -0800 (PST)
Date:   Tue,  2 Feb 2021 10:57:21 -0800
In-Reply-To: <20210202185734.1680553-1-bgardon@google.com>
Message-Id: <20210202185734.1680553-16-bgardon@google.com>
Mime-Version: 1.0
References: <20210202185734.1680553-1-bgardon@google.com>
X-Mailer: git-send-email 2.30.0.365.g02bc693789-goog
Subject: [PATCH v2 15/28] KVM: x86/mmu: Skip no-op changes in TDP MMU functions
From:   Ben Gardon <bgardon@google.com>
To:     linux-kernel@vger.kernel.org, kvm@vger.kernel.org
Cc:     Paolo Bonzini <pbonzini@redhat.com>, Peter Xu <peterx@redhat.com>,
        Sean Christopherson <seanjc@google.com>,
        Peter Shier <pshier@google.com>,
        Peter Feiner <pfeiner@google.com>,
        Junaid Shahid <junaids@google.com>,
        Jim Mattson <jmattson@google.com>,
        Yulei Zhang <yulei.kernel@gmail.com>,
        Wanpeng Li <kernellwp@gmail.com>,
        Vitaly Kuznetsov <vkuznets@redhat.com>,
        Xiao Guangrong <xiaoguangrong.eric@gmail.com>,
        Ben Gardon <bgardon@google.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Skip setting SPTEs if no change is expected.

Reviewed-by: Peter Feiner <pfeiner@google.com>
Signed-off-by: Ben Gardon <bgardon@google.com>

---

v1 -> v2
- Merged no-op checks into exiting old_spte check

 arch/x86/kvm/mmu/tdp_mmu.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/arch/x86/kvm/mmu/tdp_mmu.c b/arch/x86/kvm/mmu/tdp_mmu.c
index c8a1149cb229..aeb05f626b55 100644
--- a/arch/x86/kvm/mmu/tdp_mmu.c
+++ b/arch/x86/kvm/mmu/tdp_mmu.c
@@ -888,7 +888,8 @@ static bool wrprot_gfn_range(struct kvm *kvm, struct kvm_mmu_page *root,
 			continue;
 
 		if (!is_shadow_present_pte(iter.old_spte) ||
-		    !is_last_spte(iter.old_spte, iter.level))
+		    !is_last_spte(iter.old_spte, iter.level) ||
+		    !(iter.old_spte & PT_WRITABLE_MASK))
 			continue;
 
 		new_spte = iter.old_spte & ~PT_WRITABLE_MASK;
@@ -1065,7 +1066,8 @@ static bool set_dirty_gfn_range(struct kvm *kvm, struct kvm_mmu_page *root,
 		if (tdp_mmu_iter_cond_resched(kvm, &iter, false))
 			continue;
 
-		if (!is_shadow_present_pte(iter.old_spte))
+		if (!is_shadow_present_pte(iter.old_spte) ||
+		    iter.old_spte & shadow_dirty_mask)
 			continue;
 
 		new_spte = iter.old_spte | shadow_dirty_mask;
-- 
2.30.0.365.g02bc693789-goog

