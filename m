Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3E5913CCDBE
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Jul 2021 08:01:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234606AbhGSGD2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 19 Jul 2021 02:03:28 -0400
Received: from zg8tmty1ljiyny4xntqumjca.icoremail.net ([165.227.154.27]:35794
        "HELO zg8tmty1ljiyny4xntqumjca.icoremail.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with SMTP id S229916AbhGSGD0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Jul 2021 02:03:26 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=fudan.edu.cn; s=dkim; h=Received:From:To:Cc:Subject:Date:
        Message-Id; bh=L3fGInUdPUsxdzuEYFBYnROR1kVtg2RLwc+sUqkyDwY=; b=k
        a5GxKAXP1J2+wmFp0qYlwjiiF0N7bww/U1A5+Br7Xfzd0MrG7MLgM0f2Lw+A+xwf
        GV/BvAs0JqHYThYngFQ16pwWgZeWHTiFv/6W7esEIy+NVREevnppZ3uxXVghRDUQ
        Zgzohbl6DOFheeh05T+HHqrCCuG0yRZlkFB1W+b1oQ=
Received: from localhost.localdomain (unknown [10.162.86.133])
        by app2 (Coremail) with SMTP id XQUFCgAn32j4FPVgnkfoBA--.1815S3;
        Mon, 19 Jul 2021 14:00:24 +0800 (CST)
From:   Xiyu Yang <xiyuyang19@fudan.edu.cn>
To:     David Howells <dhowells@redhat.com>, linux-cachefs@redhat.com,
        linux-kernel@vger.kernel.org
Cc:     yuanxzhang@fudan.edu.cn, Xiyu Yang <xiyuyang19@fudan.edu.cn>,
        Xin Tan <tanxin.ctf@gmail.com>
Subject: [PATCH] fscache: Convert from atomic_t to refcount_t on fscache_cache_tag->usage
Date:   Mon, 19 Jul 2021 14:00:20 +0800
Message-Id: <1626674421-55948-1-git-send-email-xiyuyang19@fudan.edu.cn>
X-Mailer: git-send-email 2.7.4
X-CM-TRANSID: XQUFCgAn32j4FPVgnkfoBA--.1815S3
X-Coremail-Antispam: 1UD129KBjvJXoW7Wry3tF17ZrWxKFWfGw4xCrg_yoW5JFW3pa
        9rCr1xCFW8Zr17Ar4rXw4jkr1rX34DJ3W7X34xZw4ruw4agr4UXws7CF1YvF93u3yIyay3
        ZF45Kwn8Cws8Xr7anT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
        9KBjDU0xBIdaVrnRJUUUvS14x267AKxVW8JVW5JwAFc2x0x2IEx4CE42xK8VAvwI8IcIk0
        rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2ocxC64kIII0Yj41l84x0c7CEw4AK67xGY2AK02
        1l84ACjcxK6xIIjxv20xvE14v26w1j6s0DM28EF7xvwVC0I7IYx2IY6xkF7I0E14v26r4U
        JVWxJr1l84ACjcxK6I8E87Iv67AKxVW0oVCq3wA2z4x0Y4vEx4A2jsIEc7CjxVAFwI0_Gc
        CE3s1lnxkEFVAIw20F6cxK64vIFxWle2I262IYc4CY6c8Ij28IcVAaY2xG8wAqx4xG64xv
        F2IEw4CE5I8CrVC2j2WlYx0E2Ix0cI8IcVAFwI0_JF0_Jw1lYx0Ex4A2jsIE14v26r1j6r
        4UMcvjeVCFs4IE7xkEbVWUJVW8JwACjcxG0xvY0x0EwIxGrwACjI8F5VA0II8E6IAqYI8I
        648v4I1lc2xSY4AK6svPMxAIw28IcxkI7VAKI48JMxC20s026xCaFVCjc4AY6r1j6r4UMI
        8I3I0E5I8CrVAFwI0_Jr0_Jr4lx2IqxVCjr7xvwVAFwI0_JrI_JrWlx4CE17CEb7AF67AK
        xVWUAVWUtwCIc40Y0x0EwIxGrwCI42IY6xIIjxv20xvE14v26r1j6r1xMIIF0xvE2Ix0cI
        8IcVCY1x0267AKxVW8JVWxJwCI42IY6xAIw20EY4v20xvaj40_Gr0_Zr1lIxAIcVC2z280
        aVAFwI0_Jr0_Gr1lIxAIcVC2z280aVCY1x0267AKxVW8JVW8JrUvcSsGvfC2KfnxnUUI43
        ZEXa7VUbX18DUUUUU==
X-CM-SenderInfo: irzsiiysuqikmy6i3vldqovvfxof0/
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

refcount_t type and corresponding API can protect refcounters from
accidental underflow and overflow and further use-after-free situations.

Signed-off-by: Xiyu Yang <xiyuyang19@fudan.edu.cn>
Signed-off-by: Xin Tan <tanxin.ctf@gmail.com>
---
 fs/fscache/cache.c            | 8 ++++----
 include/linux/fscache-cache.h | 3 ++-
 2 files changed, 6 insertions(+), 5 deletions(-)

diff --git a/fs/fscache/cache.c b/fs/fscache/cache.c
index fcc136361415..a17faaae3668 100644
--- a/fs/fscache/cache.c
+++ b/fs/fscache/cache.c
@@ -29,7 +29,7 @@ struct fscache_cache_tag *__fscache_lookup_cache_tag(const char *name)
 
 	list_for_each_entry(tag, &fscache_cache_tag_list, link) {
 		if (strcmp(tag->name, name) == 0) {
-			atomic_inc(&tag->usage);
+			refcount_inc(&tag->usage);
 			up_read(&fscache_addremove_sem);
 			return tag;
 		}
@@ -43,7 +43,7 @@ struct fscache_cache_tag *__fscache_lookup_cache_tag(const char *name)
 		/* return a dummy tag if out of memory */
 		return ERR_PTR(-ENOMEM);
 
-	atomic_set(&xtag->usage, 1);
+	refcount_set(&xtag->usage, 1);
 	strcpy(xtag->name, name);
 
 	/* write lock, search again and add if still not present */
@@ -51,7 +51,7 @@ struct fscache_cache_tag *__fscache_lookup_cache_tag(const char *name)
 
 	list_for_each_entry(tag, &fscache_cache_tag_list, link) {
 		if (strcmp(tag->name, name) == 0) {
-			atomic_inc(&tag->usage);
+			refcount_inc(&tag->usage);
 			up_write(&fscache_addremove_sem);
 			kfree(xtag);
 			return tag;
@@ -71,7 +71,7 @@ void __fscache_release_cache_tag(struct fscache_cache_tag *tag)
 	if (tag != ERR_PTR(-ENOMEM)) {
 		down_write(&fscache_addremove_sem);
 
-		if (atomic_dec_and_test(&tag->usage))
+		if (refcount_dec_and_test(&tag->usage))
 			list_del_init(&tag->link);
 		else
 			tag = NULL;
diff --git a/include/linux/fscache-cache.h b/include/linux/fscache-cache.h
index 3235ddbdcc09..d3c609cfd762 100644
--- a/include/linux/fscache-cache.h
+++ b/include/linux/fscache-cache.h
@@ -14,6 +14,7 @@
 #ifndef _LINUX_FSCACHE_CACHE_H
 #define _LINUX_FSCACHE_CACHE_H
 
+#include <linux/refcount.h>
 #include <linux/fscache.h>
 #include <linux/sched.h>
 #include <linux/workqueue.h>
@@ -45,7 +46,7 @@ struct fscache_cache_tag {
 	struct fscache_cache	*cache;		/* cache referred to by this tag */
 	unsigned long		flags;
 #define FSCACHE_TAG_RESERVED	0		/* T if tag is reserved for a cache */
-	atomic_t		usage;
+	refcount_t		usage;
 	char			name[];	/* tag name */
 };
 
-- 
2.7.4

