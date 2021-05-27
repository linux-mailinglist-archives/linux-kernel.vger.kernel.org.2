Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 35517392E54
	for <lists+linux-kernel@lfdr.de>; Thu, 27 May 2021 14:51:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235865AbhE0Mx0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 27 May 2021 08:53:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54190 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235843AbhE0MxR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 May 2021 08:53:17 -0400
Received: from mail-ed1-x54a.google.com (mail-ed1-x54a.google.com [IPv6:2a00:1450:4864:20::54a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AAFCCC061574
        for <linux-kernel@vger.kernel.org>; Thu, 27 May 2021 05:51:42 -0700 (PDT)
Received: by mail-ed1-x54a.google.com with SMTP id d8-20020a0564020008b0290387d38e3ce0so276026edu.1
        for <linux-kernel@vger.kernel.org>; Thu, 27 May 2021 05:51:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=VHJDxJbB4/0UaCkiYnMDocZA1owly4T7PndnhH3Iyu4=;
        b=UDif3Yk+PyirPGKgjwApMLsdwDDazlqNcaTddUUJiaL8CggB5IbFz5NLz+d9ZujoSo
         u8Xf/rgSYRCQD/oc+W4sOqrYqYmC7x+K1DQXP5vUh+EOiMm4BxzGCJSf8fx6PwAhXcbd
         gkhGM3OrqR+90yiYgmUu67RympC5WD928YRa28W+0oQBp+e6/VqCIhcc66fRffxi6sQI
         /XS5VRbW4WYDR9dWTO9BYGzExAT4Vp5kecespCA9X0qN9QfbAMuPf0L98P+j58hrFH6X
         0Ls9N20YBcgJclgF+UnbQYPzKM6w7Xo3sh1Hc0vmcrCcAhVhNUuAGLR2l5w+KWYa7hWi
         e7OA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=VHJDxJbB4/0UaCkiYnMDocZA1owly4T7PndnhH3Iyu4=;
        b=pnCbEFHhCzAWlVfieX5MkyYScvVBwVXQkoDkMjgPJb5xVZWSR0QjG6eScrkaAjWGwD
         7tTnCsaa0imQQMnoAOSFUgnj3gwRKw5uKkN/7VOr5XRAX5TZLZtOQo8Hmv50tCgXMFB5
         QXtuISl8O3iQNBLVIm7qIqT206PpFy3+oJvfbKzKvZn4TUC5DiBCtJCvUq15+XHliJSA
         W9d4TT3twOlmGkokTsD5+PWRVTfR0/jNuRvMuj2gTRnzKfo1OJgxq1XUsFRklFW/U4Ck
         loscwicVWc/2SozlcBdm0YCZzQK319MHq0Jq8TutbmzUM5yf+oC8r91XVA6pGj8IAMbM
         kwpg==
X-Gm-Message-State: AOAM532lnKP3f3//vR7qGhdnGhkQv4scAR0uc0/AZdR8U9wHfbHmjcca
        GPVRaaAobsvkKDM6iVzxmu1vrO3DRF7u
X-Google-Smtp-Source: ABdhPJzJ2BtVqbgXgWjGsYBVJOsLAqvofOY6EixOvHYix2dY7OIUQXm2cfj8F2j3qMKF+qpDs8y5eIV8ZZje
X-Received: from r2d2-qp.c.googlers.com ([fda3:e722:ac3:10:28:9cb1:c0a8:1652])
 (user=qperret job=sendgmr) by 2002:a05:6402:50cd:: with SMTP id
 h13mr3939968edb.111.1622119901220; Thu, 27 May 2021 05:51:41 -0700 (PDT)
Date:   Thu, 27 May 2021 12:51:29 +0000
In-Reply-To: <20210527125134.2116404-1-qperret@google.com>
Message-Id: <20210527125134.2116404-3-qperret@google.com>
Mime-Version: 1.0
References: <20210527125134.2116404-1-qperret@google.com>
X-Mailer: git-send-email 2.31.1.818.g46aad6cb9e-goog
Subject: [PATCH 2/7] KVM: arm64: Use refcount at hyp to check page availability
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
index 04573bf35441..7ee882f36767 100644
--- a/arch/arm64/kvm/hyp/nvhe/page_alloc.c
+++ b/arch/arm64/kvm/hyp/nvhe/page_alloc.c
@@ -55,7 +55,7 @@ static struct hyp_page *__find_buddy_avail(struct hyp_pool *pool,
 {
 	struct hyp_page *buddy = __find_buddy_nocheck(pool, p, order);
 
-	if (!buddy || buddy->order != order || list_empty(&buddy->node))
+	if (!buddy || buddy->order != order || buddy->refcount)
 		return NULL;
 
 	return buddy;
@@ -116,14 +116,19 @@ static struct hyp_page *__hyp_extract_page(struct hyp_pool *pool,
 	return p;
 }
 
+static void __hyp_put_page(struct hyp_pool *pool, struct hyp_page *p)
+{
+	if (hyp_page_ref_dec_and_test(p))
+		__hyp_attach_page(pool, p);
+}
+
 void hyp_put_page(void *addr)
 {
 	struct hyp_page *p = hyp_virt_to_page(addr);
 	struct hyp_pool *pool = hyp_page_to_pool(p);
 
 	hyp_spin_lock(&pool->lock);
-	if (hyp_page_ref_dec_and_test(p))
-		__hyp_attach_page(pool, p);
+	__hyp_put_page(pool, p);
 	hyp_spin_unlock(&pool->lock);
 }
 
@@ -178,15 +183,16 @@ int hyp_pool_init(struct hyp_pool *pool, u64 pfn, unsigned int nr_pages,
 
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
2.31.1.818.g46aad6cb9e-goog

