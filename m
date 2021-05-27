Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 84419392E50
	for <lists+linux-kernel@lfdr.de>; Thu, 27 May 2021 14:51:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235874AbhE0MxW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 27 May 2021 08:53:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54176 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235811AbhE0MxN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 May 2021 08:53:13 -0400
Received: from mail-wr1-x44a.google.com (mail-wr1-x44a.google.com [IPv6:2a00:1450:4864:20::44a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 12463C061574
        for <linux-kernel@vger.kernel.org>; Thu, 27 May 2021 05:51:40 -0700 (PDT)
Received: by mail-wr1-x44a.google.com with SMTP id h104-20020adf90710000b029010de8455a3aso1700530wrh.12
        for <linux-kernel@vger.kernel.org>; Thu, 27 May 2021 05:51:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=59ZrbnR57dXVmexXuU0iZx85Sibct5xhty4f3jqzmUk=;
        b=jVHXS3bvMibkBWS+bH3WSLubeEwo4y03J+vRbsZSsVjoLuBFta5X2GtmfPD5/3Z7QY
         TA8LUPhrubLg14KwptPsqTA0fyIxxEiMv2j6qPoea7xGJBviUgOJS8LKfAtQ6LRg4xiZ
         vNH4I54lKLKr8niplcjTAZf0ZeEFp4WpohPKu/ocRKYxchgP0pLtq8yCHW0wOP4GUgyk
         /wmQI3jlJLAHjRBTEUFDiGi2tu3nCsJijS3psLbSR0F2aqlmeNBMjDWodcEhaMfXQ52i
         HA4j1aHPpJE4izPecyVmlmp71jx2oZWHOQWqJWSClhiCwre/jt9wfMAJdPwgoSBHyx7U
         Go4Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=59ZrbnR57dXVmexXuU0iZx85Sibct5xhty4f3jqzmUk=;
        b=hdpAz0UkUeXDm0KozV+nA181Qb0ZMTG5mKBQjxGRtqSLi0obSi7i12np8M1x6diXHO
         I0kH9m3stgfICt1HAbE6nSICkF5MyDUPrEnhmovyDEJgV8daHreLAGVmvpBQatSidNog
         XR6KYshYZ7+DEXTulhX9G3CoVLmvWL1iYP4/mBei9LdWLa/WYnCJtQ3JrIrFGtam1+zi
         gvzkWBWiiV6vyRisK5BmNNchR0oIscYxp40XpkmVGSBj6OGYUjhckbNV8+w5fop0VyOD
         Ov4e6GvgGpxwsn+NfxB+vbaWMB/8fMNliAxN2rLigcHYwP92gKvc/lPW4+5OS6WwGosh
         c9RA==
X-Gm-Message-State: AOAM531CSV+007cJTAdv4Foog0BXHEIMRHcHMHnWIAjVONwNJ23BwI26
        LvGnPOC0W2iGTeBCk9OMW/2+JVd6XnXT
X-Google-Smtp-Source: ABdhPJx3hDj3fqzQNROoGJzyF8S2ksFUOMHLT2ocwl3Ym1DkFjpNtt3AG2ucCS5H6j++RJ8/UzZ53q5BHRH4
X-Received: from r2d2-qp.c.googlers.com ([fda3:e722:ac3:10:28:9cb1:c0a8:1652])
 (user=qperret job=sendgmr) by 2002:a05:600c:ad3:: with SMTP id
 c19mr8297036wmr.66.1622119898658; Thu, 27 May 2021 05:51:38 -0700 (PDT)
Date:   Thu, 27 May 2021 12:51:28 +0000
In-Reply-To: <20210527125134.2116404-1-qperret@google.com>
Message-Id: <20210527125134.2116404-2-qperret@google.com>
Mime-Version: 1.0
References: <20210527125134.2116404-1-qperret@google.com>
X-Mailer: git-send-email 2.31.1.818.g46aad6cb9e-goog
Subject: [PATCH 1/7] KVM: arm64: Move hyp_pool locking out of refcount helpers
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

The hyp_page refcount helpers currently rely on the hyp_pool lock for
serialization. However, this means the refcounts can't be changed from
the buddy allocator core as it already holds the lock, which means pages
have to go through odd transient states.

For example, when a page is freed, its refcount is set to 0, and the
lock is transiently released before the page can be attached to a free
list in the buddy tree. This is currently harmless as the allocator
checks the list node of each page to see if it is available for
allocation or not, but it means the page refcount can't be trusted to
represent the state of the page even if the pool lock is held.

In order to fix this, remove the pool locking from the refcount helpers,
and move all the logic to the buddy allocator. This will simplify the
removal of the list node from struct hyp_page in a later patch.

Signed-off-by: Quentin Perret <qperret@google.com>
---
 arch/arm64/kvm/hyp/include/nvhe/gfp.h | 21 ++-------------------
 arch/arm64/kvm/hyp/nvhe/page_alloc.c  | 19 ++++++++-----------
 2 files changed, 10 insertions(+), 30 deletions(-)

diff --git a/arch/arm64/kvm/hyp/include/nvhe/gfp.h b/arch/arm64/kvm/hyp/include/nvhe/gfp.h
index 18a4494337bd..aada4d97de49 100644
--- a/arch/arm64/kvm/hyp/include/nvhe/gfp.h
+++ b/arch/arm64/kvm/hyp/include/nvhe/gfp.h
@@ -24,37 +24,20 @@ struct hyp_pool {
 
 static inline void hyp_page_ref_inc(struct hyp_page *p)
 {
-	struct hyp_pool *pool = hyp_page_to_pool(p);
-
-	hyp_spin_lock(&pool->lock);
 	p->refcount++;
-	hyp_spin_unlock(&pool->lock);
 }
 
 static inline int hyp_page_ref_dec_and_test(struct hyp_page *p)
 {
-	struct hyp_pool *pool = hyp_page_to_pool(p);
-	int ret;
-
-	hyp_spin_lock(&pool->lock);
 	p->refcount--;
-	ret = (p->refcount == 0);
-	hyp_spin_unlock(&pool->lock);
-
-	return ret;
+	return (p->refcount == 0);
 }
 
 static inline void hyp_set_page_refcounted(struct hyp_page *p)
 {
-	struct hyp_pool *pool = hyp_page_to_pool(p);
-
-	hyp_spin_lock(&pool->lock);
-	if (p->refcount) {
-		hyp_spin_unlock(&pool->lock);
+	if (p->refcount)
 		BUG();
-	}
 	p->refcount = 1;
-	hyp_spin_unlock(&pool->lock);
 }
 
 /* Allocation */
diff --git a/arch/arm64/kvm/hyp/nvhe/page_alloc.c b/arch/arm64/kvm/hyp/nvhe/page_alloc.c
index 237e03bf0cb1..04573bf35441 100644
--- a/arch/arm64/kvm/hyp/nvhe/page_alloc.c
+++ b/arch/arm64/kvm/hyp/nvhe/page_alloc.c
@@ -93,15 +93,6 @@ static void __hyp_attach_page(struct hyp_pool *pool,
 	list_add_tail(&p->node, &pool->free_area[order]);
 }
 
-static void hyp_attach_page(struct hyp_page *p)
-{
-	struct hyp_pool *pool = hyp_page_to_pool(p);
-
-	hyp_spin_lock(&pool->lock);
-	__hyp_attach_page(pool, p);
-	hyp_spin_unlock(&pool->lock);
-}
-
 static struct hyp_page *__hyp_extract_page(struct hyp_pool *pool,
 					   struct hyp_page *p,
 					   unsigned int order)
@@ -128,16 +119,22 @@ static struct hyp_page *__hyp_extract_page(struct hyp_pool *pool,
 void hyp_put_page(void *addr)
 {
 	struct hyp_page *p = hyp_virt_to_page(addr);
+	struct hyp_pool *pool = hyp_page_to_pool(p);
 
+	hyp_spin_lock(&pool->lock);
 	if (hyp_page_ref_dec_and_test(p))
-		hyp_attach_page(p);
+		__hyp_attach_page(pool, p);
+	hyp_spin_unlock(&pool->lock);
 }
 
 void hyp_get_page(void *addr)
 {
 	struct hyp_page *p = hyp_virt_to_page(addr);
+	struct hyp_pool *pool = hyp_page_to_pool(p);
 
+	hyp_spin_lock(&pool->lock);
 	hyp_page_ref_inc(p);
+	hyp_spin_unlock(&pool->lock);
 }
 
 void *hyp_alloc_pages(struct hyp_pool *pool, unsigned int order)
@@ -159,8 +156,8 @@ void *hyp_alloc_pages(struct hyp_pool *pool, unsigned int order)
 	p = list_first_entry(&pool->free_area[i], struct hyp_page, node);
 	p = __hyp_extract_page(pool, p, order);
 
-	hyp_spin_unlock(&pool->lock);
 	hyp_set_page_refcounted(p);
+	hyp_spin_unlock(&pool->lock);
 
 	return hyp_page_to_virt(p);
 }
-- 
2.31.1.818.g46aad6cb9e-goog

