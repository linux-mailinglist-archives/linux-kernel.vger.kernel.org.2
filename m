Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CD932336BC7
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Mar 2021 06:57:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229871AbhCKF44 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 11 Mar 2021 00:56:56 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33986 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229812AbhCKF4Y (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 11 Mar 2021 00:56:24 -0500
Received: from mail-pf1-x42f.google.com (mail-pf1-x42f.google.com [IPv6:2607:f8b0:4864:20::42f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 052FCC061574
        for <linux-kernel@vger.kernel.org>; Wed, 10 Mar 2021 21:56:24 -0800 (PST)
Received: by mail-pf1-x42f.google.com with SMTP id j12so13659195pfj.12
        for <linux-kernel@vger.kernel.org>; Wed, 10 Mar 2021 21:56:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=yJ6Pl8QgifadwfIXaa4NP4BZgjS0vadvYmpwZmuwkkk=;
        b=hwuzbPlcBfwq1+hstCB+gQzlay6IauvYpbDDnT09v2bz4UP4aBhG0JAQAA8/6Abbsx
         uhVPHYxk+ZwRrsuI6ctUxQsECDppJzeV+UwjtVTMBTBRtJsLmZGjD0X18VxvcBVe96//
         gZYVew1yux4yDHcp6vy9R4tDITPwFMCLvOFeu6qk2TRuELyuGc+Vk4eo88t6RMO1O70W
         3IZbbv/hmqjGFPgtdSkN5+3470X8u4ljSRuyX8XpNfPUv9Auo50X+6YBa9r4sWGCpi8g
         SWvxP2cnd/WwiIjrVAlm2IZRVGLch917LAzvi0wLHXfgynHuf0zVC9Yl/rWVhlHph+5N
         zeNg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=yJ6Pl8QgifadwfIXaa4NP4BZgjS0vadvYmpwZmuwkkk=;
        b=T6GsDF61wikRpnEyQYm1haiXalufz4UFR/n571jSnJ9ipsI2t86zDTI49z75eIFJKR
         yKhGhk4tQfCT10Z51LiZ2paESSMLj5wMCnD4fpBISlTGQ1gaFaxQNryaI4oINhQvyW4f
         KOxPcvJeS0ezz2w4lvGlnesB6Lo95b814vTF6LIHuSonOD9r7QCQgVs1M2OHt0MabIM7
         DuL9hUkl8jHkOy72IBNrYS6JnOTRf9eIOjusiTOY1rmAyW2hnZ6r/FMwg43hLj3FhmMs
         0rbkLb6dEvAORYBkoQLwXLnT/xqKZiJuA3UTwzkxV98G5qeKuWD42iJi8Fk6uHJejQoV
         rbCw==
X-Gm-Message-State: AOAM5326RHzIDg1zqyyQVxzjGux4LaPl4wErztD7DSNa961+D+L5Y/wb
        O1NT8FfsyAD2Km+IxMi8fE0=
X-Google-Smtp-Source: ABdhPJy6Z2oKCwiM/qJEc5mJBJyjZNkVynLEh3xDp//sx94oaahUvVNpo6mGLukXWE52HUDRWETL2A==
X-Received: by 2002:aa7:956d:0:b029:1f1:5ba6:2a58 with SMTP id x13-20020aa7956d0000b02901f15ba62a58mr6381996pfq.63.1615442183475;
        Wed, 10 Mar 2021 21:56:23 -0800 (PST)
Received: from localhost.localdomain ([122.10.161.207])
        by smtp.gmail.com with ESMTPSA id k10sm1138982pfk.49.2021.03.10.21.56.21
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 10 Mar 2021 21:56:23 -0800 (PST)
From:   Yejune Deng <yejune.deng@gmail.com>
To:     akpm@linux-foundation.org, walken@google.com, hannes@cmpxchg.org,
        louhongxiang@huawei.com, linmiaohe@huawei.com, shakeelb@google.com,
        yejune.deng@gmail.com
Cc:     linux-kernel@vger.kernel.org, linux-mm@kvack.org
Subject: [PATCH] mm/rmap: convert anon_vma.refcount from atomic_t to refcount_t
Date:   Thu, 11 Mar 2021 13:56:15 +0800
Message-Id: <20210311055615.4461-1-yejune.deng@gmail.com>
X-Mailer: git-send-email 2.29.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

refcount_t type should be used instead of atomic_t when the variable
is used as a reference counter. This is because the implementation of
refcount_t can prevent overflows and detect possible use-after-free.

Signed-off-by: Yejune Deng <yejune.deng@gmail.com>
---
 include/linux/rmap.h |  7 ++++---
 mm/rmap.c            | 14 +++++++-------
 2 files changed, 11 insertions(+), 10 deletions(-)

diff --git a/include/linux/rmap.h b/include/linux/rmap.h
index def5c62c93b3..0d6dfea7afa6 100644
--- a/include/linux/rmap.h
+++ b/include/linux/rmap.h
@@ -11,6 +11,7 @@
 #include <linux/rwsem.h>
 #include <linux/memcontrol.h>
 #include <linux/highmem.h>
+#include <linux/refcount.h>
 
 /*
  * The anon_vma heads a list of private "related" vmas, to scan if
@@ -36,7 +37,7 @@ struct anon_vma {
 	 * the reference is responsible for clearing up the
 	 * anon_vma if they are the last user on release
 	 */
-	atomic_t refcount;
+	refcount_t refcount;
 
 	/*
 	 * Count of child anon_vmas and VMAs which points to this anon_vma.
@@ -103,14 +104,14 @@ enum ttu_flags {
 #ifdef CONFIG_MMU
 static inline void get_anon_vma(struct anon_vma *anon_vma)
 {
-	atomic_inc(&anon_vma->refcount);
+	refcount_inc(&anon_vma->refcount);
 }
 
 void __put_anon_vma(struct anon_vma *anon_vma);
 
 static inline void put_anon_vma(struct anon_vma *anon_vma)
 {
-	if (atomic_dec_and_test(&anon_vma->refcount))
+	if (refcount_dec_and_test(&anon_vma->refcount))
 		__put_anon_vma(anon_vma);
 }
 
diff --git a/mm/rmap.c b/mm/rmap.c
index b0fc27e77d6d..6aea12f3ac5c 100644
--- a/mm/rmap.c
+++ b/mm/rmap.c
@@ -88,7 +88,7 @@ static inline struct anon_vma *anon_vma_alloc(void)
 
 	anon_vma = kmem_cache_alloc(anon_vma_cachep, GFP_KERNEL);
 	if (anon_vma) {
-		atomic_set(&anon_vma->refcount, 1);
+		refcount_set(&anon_vma->refcount, 1);
 		anon_vma->degree = 1;	/* Reference for first vma */
 		anon_vma->parent = anon_vma;
 		/*
@@ -103,7 +103,7 @@ static inline struct anon_vma *anon_vma_alloc(void)
 
 static inline void anon_vma_free(struct anon_vma *anon_vma)
 {
-	VM_BUG_ON(atomic_read(&anon_vma->refcount));
+	VM_BUG_ON(refcount_read(&anon_vma->refcount));
 
 	/*
 	 * Synchronize against page_lock_anon_vma_read() such that
@@ -445,7 +445,7 @@ static void anon_vma_ctor(void *data)
 	struct anon_vma *anon_vma = data;
 
 	init_rwsem(&anon_vma->rwsem);
-	atomic_set(&anon_vma->refcount, 0);
+	refcount_set(&anon_vma->refcount, 0);
 	anon_vma->rb_root = RB_ROOT_CACHED;
 }
 
@@ -495,7 +495,7 @@ struct anon_vma *page_get_anon_vma(struct page *page)
 		goto out;
 
 	anon_vma = (struct anon_vma *) (anon_mapping - PAGE_MAPPING_ANON);
-	if (!atomic_inc_not_zero(&anon_vma->refcount)) {
+	if (!refcount_inc_not_zero(&anon_vma->refcount)) {
 		anon_vma = NULL;
 		goto out;
 	}
@@ -554,7 +554,7 @@ struct anon_vma *page_lock_anon_vma_read(struct page *page)
 	}
 
 	/* trylock failed, we got to sleep */
-	if (!atomic_inc_not_zero(&anon_vma->refcount)) {
+	if (!refcount_inc_not_zero(&anon_vma->refcount)) {
 		anon_vma = NULL;
 		goto out;
 	}
@@ -569,7 +569,7 @@ struct anon_vma *page_lock_anon_vma_read(struct page *page)
 	rcu_read_unlock();
 	anon_vma_lock_read(anon_vma);
 
-	if (atomic_dec_and_test(&anon_vma->refcount)) {
+	if (refcount_dec_and_test(&anon_vma->refcount)) {
 		/*
 		 * Oops, we held the last refcount, release the lock
 		 * and bail -- can't simply use put_anon_vma() because
@@ -1810,7 +1810,7 @@ void __put_anon_vma(struct anon_vma *anon_vma)
 	struct anon_vma *root = anon_vma->root;
 
 	anon_vma_free(anon_vma);
-	if (root != anon_vma && atomic_dec_and_test(&root->refcount))
+	if (root != anon_vma && refcount_dec_and_test(&root->refcount))
 		anon_vma_free(root);
 }
 
-- 
2.29.0

