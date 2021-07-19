Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8A7333CCC9C
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Jul 2021 05:24:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234277AbhGSD1g (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 18 Jul 2021 23:27:36 -0400
Received: from zg8tmty1ljiyny4xntqumjca.icoremail.net ([165.227.154.27]:35509
        "HELO zg8tmty1ljiyny4xntqumjca.icoremail.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with SMTP id S233720AbhGSD1e (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 18 Jul 2021 23:27:34 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=fudan.edu.cn; s=dkim; h=Received:From:To:Cc:Subject:Date:
        Message-Id; bh=wtyXOI8Xeg1njRS/Jj/QURbJxTQaAnEiQuxKi8api50=; b=2
        S26ybWLUwuFXerTQbU81d2QIYVdpEYHS3UMPmx9FPfK2svh0F7NbpfF0xoOMPK0a
        NZRUl47+mv2CgMGeWEy7HFZwJxj+EDa3yUjl+GMuEUwR+cKr6nltYCRId672P3K2
        9xJuiBA/B3X12pyy/j44le9+nVmbKlbvZEaPkYeyCg=
Received: from localhost.localdomain (unknown [10.162.86.133])
        by app2 (Coremail) with SMTP id XQUFCgA3_GpT8PRgxCDnBA--.250S3;
        Mon, 19 Jul 2021 11:24:04 +0800 (CST)
From:   Xiyu Yang <xiyuyang19@fudan.edu.cn>
To:     Andrew Morton <akpm@linux-foundation.org>,
        Alistair Popple <apopple@nvidia.com>,
        Yang Shi <shy828301@gmail.com>,
        Shakeel Butt <shakeelb@google.com>,
        Hugh Dickins <hughd@google.com>,
        Xiyu Yang <xiyuyang19@fudan.edu.cn>,
        Miaohe Lin <linmiaohe@huawei.com>,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org
Cc:     yuanxzhang@fudan.edu.cn, Xin Tan <tanxin.ctf@gmail.com>
Subject: [PATCH] mm/rmap: Convert from atomic_t to refcount_t on anon_vma->refcount
Date:   Mon, 19 Jul 2021 11:23:35 +0800
Message-Id: <1626665029-49104-1-git-send-email-xiyuyang19@fudan.edu.cn>
X-Mailer: git-send-email 2.7.4
X-CM-TRANSID: XQUFCgA3_GpT8PRgxCDnBA--.250S3
X-Coremail-Antispam: 1UD129KBjvJXoWxAFWkXrWUJr4DJrykWry5XFb_yoWrGrW3pF
        yktr4DXFWrXr1fA34DAw4DuryUXw15Zw4rZ3y5Gw1rAr9xtw4rJw10yF9Iy3yUJ34xJr13
        Zr4Uu39Iyr1qqFJanT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
        9KBjDU0xBIdaVrnRJUUU9K14x267AKxVW8JVW5JwAFc2x0x2IEx4CE42xK8VAvwI8IcIk0
        rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2ocxC64kIII0Yj41l84x0c7CEw4AK67xGY2AK02
        1l84ACjcxK6xIIjxv20xvE14v26w1j6s0DM28EF7xvwVC0I7IYx2IY6xkF7I0E14v26r4U
        JVWxJr1l84ACjcxK6I8E87Iv67AKxVW0oVCq3wA2z4x0Y4vEx4A2jsIEc7CjxVAFwI0_Gc
        CE3s1lnxkEFVAIw20F6cxK64vIFxWle2I262IYc4CY6c8Ij28IcVAaY2xG8wAqx4xG64xv
        F2IEw4CE5I8CrVC2j2WlYx0E2Ix0cI8IcVAFwI0_Jr0_Jr4lYx0Ex4A2jsIE14v26r1j6r
        4UMcvjeVCFs4IE7xkEbVWUJVW8JwACjcxG0xvY0x0EwIxGrwACjI8F5VA0II8E6IAqYI8I
        648v4I1lFIxGxcIEc7CjxVA2Y2ka0xkIwI1lc2xSY4AK6svPMxAIw28IcxkI7VAKI48JMx
        C20s026xCaFVCjc4AY6r1j6r4UMI8I3I0E5I8CrVAFwI0_Jr0_Jr4lx2IqxVCjr7xvwVAF
        wI0_JrI_JrWlx4CE17CEb7AF67AKxVWUtVW8ZwCIc40Y0x0EwIxGrwCI42IY6xIIjxv20x
        vE14v26r1j6r1xMIIF0xvE2Ix0cI8IcVCY1x0267AKxVW8JVWxJwCI42IY6xAIw20EY4v2
        0xvaj40_WFyUJVCq3wCI42IY6I8E87Iv67AKxVWUJVW8JwCI42IY6I8E87Iv6xkF7I0E14
        v26r4j6r4UJbIYCTnIWIevJa73UjIFyTuYvjfUOlksUUUUU
X-CM-SenderInfo: irzsiiysuqikmy6i3vldqovvfxof0/
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

refcount_t type and corresponding API can protect refcounters from
accidental underflow and overflow and further use-after-free situations.

Signed-off-by: Xiyu Yang <xiyuyang19@fudan.edu.cn>
Signed-off-by: Xin Tan <tanxin.ctf@gmail.com>
---
 include/linux/rmap.h |  8 +++++---
 mm/rmap.c            | 14 +++++++-------
 2 files changed, 12 insertions(+), 10 deletions(-)

diff --git a/include/linux/rmap.h b/include/linux/rmap.h
index c976cc6de257..38151efe1a59 100644
--- a/include/linux/rmap.h
+++ b/include/linux/rmap.h
@@ -12,6 +12,8 @@
 #include <linux/memcontrol.h>
 #include <linux/highmem.h>
 
+#include <linux/refcount.h>
+
 /*
  * The anon_vma heads a list of private "related" vmas, to scan if
  * an anonymous page pointing to this anon_vma needs to be unmapped:
@@ -36,7 +38,7 @@ struct anon_vma {
 	 * the reference is responsible for clearing up the
 	 * anon_vma if they are the last user on release
 	 */
-	atomic_t refcount;
+	refcount_t refcount;
 
 	/*
 	 * Count of child anon_vmas and VMAs which points to this anon_vma.
@@ -100,14 +102,14 @@ enum ttu_flags {
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
index b9eb5c12f3fe..7badd786e095 100644
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
@@ -2221,7 +2221,7 @@ void __put_anon_vma(struct anon_vma *anon_vma)
 	struct anon_vma *root = anon_vma->root;
 
 	anon_vma_free(anon_vma);
-	if (root != anon_vma && atomic_dec_and_test(&root->refcount))
+	if (root != anon_vma && refcount_dec_and_test(&root->refcount))
 		anon_vma_free(root);
 }
 
-- 
2.7.4

