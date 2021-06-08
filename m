Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 46AB639F57D
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Jun 2021 13:46:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232152AbhFHLsZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 8 Jun 2021 07:48:25 -0400
Received: from mail-wr1-f74.google.com ([209.85.221.74]:41726 "EHLO
        mail-wr1-f74.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232081AbhFHLsX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Jun 2021 07:48:23 -0400
Received: by mail-wr1-f74.google.com with SMTP id l13-20020adfe9cd0000b0290119a0645c8fso6355438wrn.8
        for <linux-kernel@vger.kernel.org>; Tue, 08 Jun 2021 04:46:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=LthYGSx9khubk0Q8iirSxhsMo2f7JJJGJq7fjYN5P38=;
        b=f2wQRB2jWBShQeudJb2Rmut+KMQOsZgySbE+sTH8oSLU6gFAIffflC/ma+62ucmDoj
         7XeuFCB9mACIijeZC4zq5Dfd3nwANdrfG/dzHB+CtvH2bVxNlVc1M71oEMRwwolxuLvw
         /h35q0ZqMfz7SEVEqlZy8xEj8AA3AXvglFwvD4blk7ugoBTvGGwuwtrr2Zue/YXZ2Aor
         c69B6hM/6XZP8KvobS1YTao33E7DXN4ioJi3ViVlj58EeiDQOgIgbJ0eE8PplqWKTd2w
         LAHZepXukg8vmCGKkzLFL8TIohz3WkwjeeLJpDa+CZafFq2XWMPVRriusB39/NMuV/GE
         uVhA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=LthYGSx9khubk0Q8iirSxhsMo2f7JJJGJq7fjYN5P38=;
        b=lvLlEv/xVy3578P+qsgSjn0t60ttn98EUgpHcuqZ9Agmwj9+7MIZ/8unHMcu25TjAc
         UEEWwP4slH8nfEkySGalTeY5XWgDeUJL2fRmceeHo1cH7lajRTXtcUfVwS1nzc0ty2wG
         XYAentbxKlLxsCGvmKeAV6F1TDDYg8uJzQW8JNgQRD9N5195bN5mAmhy38l3SjhKmX9F
         r6UGgUTg/+wrG1NrSYGLimB576wTWANPPVG4XQFy1tKFNAJcLoh31YzOj3MGUlPICGYd
         mzPB8QFgHArPqLiY5q4BIA3XoMzize/GmZRTqfnamX9xUeJuFYa9fet9zrQAQl0JX2u5
         tJKg==
X-Gm-Message-State: AOAM533/YukpXdvu85PTPBMl4jpDtonv8I56QFZylFUj61SCFCY+k9yr
        I5R7pgfcCvtsbuwb8PswxcN3DQjwWB+V
X-Google-Smtp-Source: ABdhPJxAu10Zi5a8GAxfgrCM5/ofdSfnO2007lyftbaojQBH+mzj7bMUM0GJxPqdZ4Q2zSw6PtaVyeR6V8I9
X-Received: from r2d2-qp.c.googlers.com ([fda3:e722:ac3:cc00:28:9cb1:c0a8:1652])
 (user=qperret job=sendgmr) by 2002:a05:600c:1910:: with SMTP id
 j16mr21226843wmq.39.1623152729448; Tue, 08 Jun 2021 04:45:29 -0700 (PDT)
Date:   Tue,  8 Jun 2021 11:45:13 +0000
In-Reply-To: <20210608114518.748712-1-qperret@google.com>
Message-Id: <20210608114518.748712-3-qperret@google.com>
Mime-Version: 1.0
References: <20210608114518.748712-1-qperret@google.com>
X-Mailer: git-send-email 2.32.0.rc1.229.g3e70b5a671-goog
Subject: [PATCH v3 2/7] KVM: arm64: Use refcount at hyp to check page availability
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
2.32.0.rc1.229.g3e70b5a671-goog

