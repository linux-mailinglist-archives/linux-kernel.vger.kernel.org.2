Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B35BD398574
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Jun 2021 11:44:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232171AbhFBJpp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 2 Jun 2021 05:45:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58476 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232133AbhFBJpl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Jun 2021 05:45:41 -0400
Received: from mail-qv1-xf4a.google.com (mail-qv1-xf4a.google.com [IPv6:2607:f8b0:4864:20::f4a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E5F51C061574
        for <linux-kernel@vger.kernel.org>; Wed,  2 Jun 2021 02:43:56 -0700 (PDT)
Received: by mail-qv1-xf4a.google.com with SMTP id k12-20020a0cfd6c0000b029020df9543019so1267823qvs.14
        for <linux-kernel@vger.kernel.org>; Wed, 02 Jun 2021 02:43:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=iZUQk8fIlBvRNxDOUvgxujyUIWimZaPXfaVXd2+o6PY=;
        b=VLEyklUT17eTyvASVE7D7VJJlhe5fAE1d9RgPZBqibyIBB6t1KdUSjsMDHUTzawsYb
         kX7dTP9UCIcEy4saEDT8A1ACHMYxFaTwbasSzUy9XUR/Y2LxVJc9AKyM8VvhpSZRZ3NL
         MxZ1AY2eP2/bBpheP6r59nKkqlZ/ZGdBOqYGu8KXHl7lSkugmxTEnm+8Wu68jUWSVkJL
         0xrNW3CgzLjbiR2UH+ZZSedoZtMHG+8aASS7O0TbNhnJBXFav94x+bAlSa4Vz6cWhaK6
         egWJUSMlQpeb1mS5RVmlTwu/ULC5Aw0INHSbGNgFhYW0WNgXxCvaRJ0qlrTHoPcNIdkK
         Jcnw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=iZUQk8fIlBvRNxDOUvgxujyUIWimZaPXfaVXd2+o6PY=;
        b=BsAZ/XaH6qJfjjvegrk+3HNv1B1aA06K9p+h5ZA1WOa++kslZq6DeWvUV/CviZCMpp
         Nt0rfWwjcQJbWfYbH82Nnooyvz2YV5L38iaDkicHliDEKSXmrwhCgw4gCGCPKA+npoRl
         vMoCCfE1y6MfMh2zPQazhiY5BBzVK6oMigRomhrzqDqyiyMRyZzOL3Oa6URDbLoX3RzK
         pV/JTpcAaAPFPFfJsNx2O7lS6zsNK6cpQGMr0sUiuqLucFPi96r4Hm1LfvN0gqX2Tcko
         YNDdTiTdK11hdl5MOeAf8fPQ5PMG8Kgb2FH9qXefCSA1bYYJdmZksUnpLgVPw1pkks+/
         dFSg==
X-Gm-Message-State: AOAM531OzWxvt+cvbRl2ELMFBaw8Hk6LlNxk7MIdFwyhQJrYVebhtUtR
        0ae2icbjfmW7G8ZmNDZBObUAuT4Rpg/9
X-Google-Smtp-Source: ABdhPJw5u97rh4yWHjSnTxNGWaGWtM7mSfMb+qJ6Mxm9lPPMCbPzQl92O3It3Tn7cZ0dBOcajFXTAP9JCzwj
X-Received: from r2d2-qp.c.googlers.com ([fda3:e722:ac3:cc00:28:9cb1:c0a8:1652])
 (user=qperret job=sendgmr) by 2002:a05:6214:c88:: with SMTP id
 r8mr6671320qvr.58.1622627036015; Wed, 02 Jun 2021 02:43:56 -0700 (PDT)
Date:   Wed,  2 Jun 2021 09:43:42 +0000
In-Reply-To: <20210602094347.3730846-1-qperret@google.com>
Message-Id: <20210602094347.3730846-3-qperret@google.com>
Mime-Version: 1.0
References: <20210602094347.3730846-1-qperret@google.com>
X-Mailer: git-send-email 2.32.0.rc0.204.g9fa02ecfa5-goog
Subject: [PATCH v2 2/7] KVM: arm64: Use refcount at hyp to check page availability
From:   Quentin Perret <qperret@google.com>
To:     maz@kernel.org, will@kernel.org, james.morse@arm.com,
        alexandru.elisei@arm.com, catalin.marinas@arm.com,
        suzuki.poulose@arm.com
Cc:     linux-arm-kernel@lists.infradead.org, kvmarm@lists.cs.columbia.edu,
        kernel-team@android.com, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The hyp buddy allocator currently checks the struct hyp_page list node
to see if a page is available for allocation or not when trying to
coalesce memory. Now that decrementing the refcount and attaching to
the buddy tree is done in the same critical section, we can rely on the
refcount of the buddy page to be in sync, which allows to replace the
list node check by a refcount check. This will ease removing the list
node from struct hyp_page later on.

Signed-off-by: Quentin Perret <qperret@google.com>
---
 arch/arm64/kvm/hyp/nvhe/page_alloc.c | 16 +++++++++++-----
 1 file changed, 11 insertions(+), 5 deletions(-)

diff --git a/arch/arm64/kvm/hyp/nvhe/page_alloc.c b/arch/arm64/kvm/hyp/nvhe/page_alloc.c
index d666f4789e31..2602577daa00 100644
--- a/arch/arm64/kvm/hyp/nvhe/page_alloc.c
+++ b/arch/arm64/kvm/hyp/nvhe/page_alloc.c
@@ -55,7 +55,7 @@ static struct hyp_page *__find_buddy_avail(struct hyp_pool *pool,
 {
 	struct hyp_page *buddy = __find_buddy_nocheck(pool, p, order);
 
-	if (!buddy || buddy->order != order || list_empty(&buddy->node))
+	if (!buddy || buddy->order != order || buddy->refcount)
 		return NULL;
 
 	return buddy;
@@ -133,6 +133,12 @@ static inline void hyp_set_page_refcounted(struct hyp_page *p)
 	p->refcount = 1;
 }
 
+static void __hyp_put_page(struct hyp_pool *pool, struct hyp_page *p)
+{
+	if (hyp_page_ref_dec_and_test(p))
+		__hyp_attach_page(pool, p);
+}
+
 /*
  * Changes to the buddy tree and page refcounts must be done with the hyp_pool
  * lock held. If a refcount change requires an update to the buddy tree (e.g.
@@ -146,8 +152,7 @@ void hyp_put_page(void *addr)
 	struct hyp_pool *pool = hyp_page_to_pool(p);
 
 	hyp_spin_lock(&pool->lock);
-	if (hyp_page_ref_dec_and_test(p))
-		__hyp_attach_page(pool, p);
+	__hyp_put_page(pool, p);
 	hyp_spin_unlock(&pool->lock);
 }
 
@@ -202,15 +207,16 @@ int hyp_pool_init(struct hyp_pool *pool, u64 pfn, unsigned int nr_pages,
 
 	/* Init the vmemmap portion */
 	p = hyp_phys_to_page(phys);
-	memset(p, 0, sizeof(*p) * nr_pages);
 	for (i = 0; i < nr_pages; i++) {
 		p[i].pool = pool;
+		p[i].order = 0;
 		INIT_LIST_HEAD(&p[i].node);
+		hyp_set_page_refcounted(&p[i]);
 	}
 
 	/* Attach the unused pages to the buddy tree */
 	for (i = reserved_pages; i < nr_pages; i++)
-		__hyp_attach_page(pool, &p[i]);
+		__hyp_put_page(pool, &p[i]);
 
 	return 0;
 }
-- 
2.32.0.rc0.204.g9fa02ecfa5-goog

