Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 12B35314752
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Feb 2021 05:10:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230208AbhBIEKB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 8 Feb 2021 23:10:01 -0500
Received: from zg8tmja2lje4os4yms4ymjma.icoremail.net ([206.189.21.223]:47011
        "HELO zg8tmja2lje4os4yms4ymjma.icoremail.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with SMTP id S230054AbhBIDvA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Feb 2021 22:51:00 -0500
Received: from centos7u5.localdomain (unknown [202.43.158.76])
        by c1app2 (Coremail) with SMTP id AgINCgCnr7tEAiJg3Wj0Ag--.47078S3;
        Tue, 09 Feb 2021 11:32:21 +0800 (CST)
From:   Zhiyuan Dai <daizhiyuan@phytium.com.cn>
To:     cl@linux.com, penberg@kernel.org, rientjes@google.com,
        iamjoonsoo.kim@lge.com, akpm@linux-foundation.org, vbabka@suse.cz
Cc:     linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        Zhiyuan Dai <daizhiyuan@phytium.com.cn>
Subject: [PATCH] mm/slab: minor coding style tweaks
Date:   Tue,  9 Feb 2021 11:31:39 +0800
Message-Id: <1612841499-32166-1-git-send-email-daizhiyuan@phytium.com.cn>
X-Mailer: git-send-email 1.8.3.1
X-CM-TRANSID: AgINCgCnr7tEAiJg3Wj0Ag--.47078S3
X-Coremail-Antispam: 1UD129KBjvJXoWxZr1xKFyxtrWfAF48JrWDurg_yoW5GFWDpF
        9rC345tFZ3WF42gayxtw4DWFyfArZ7G3ZxCayj9a10v3Z8Z3WrXFW7XrW5JFs5Zry8CF4a
        van5t3y7u397Ar7anT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
        9KBjDU0xBIdaVrnRJUUUkl14x267AKxVW8JVW5JwAFc2x0x2IEx4CE42xK8VAvwI8IcIk0
        rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2ocxC64kIII0Yj41l84x0c7CEw4AK67xGY2AK02
        1l84ACjcxK6xIIjxv20xvE14v26r1I6r4UM28EF7xvwVC0I7IYx2IY6xkF7I0E14v26r4j
        6F4UM28EF7xvwVC2z280aVAFwI0_Gr1j6F4UJwA2z4x0Y4vEx4A2jsIEc7CjxVAFwI0_Gr
        1j6F4UJwAS0I0E0xvYzxvE52x082IY62kv0487Mc02F40EFcxC0VAKzVAqx4xG6I80ewAv
        7VC0I7IYx2IY67AKxVWUJVWUGwAv7VC2z280aVAFwI0_Jr0_Gr1lOx8S6xCaFVCjc4AY6r
        1j6r4UM4x0Y48IcxkI7VAKI48JM4x0x7Aq67IIx4CEVc8vx2IErcIFxwCY02Avz4vE14v_
        Gr4l42xK82IYc2Ij64vIr41l4I8I3I0E4IkC6x0Yz7v_Jr0_Gr1lx2IqxVAqx4xG67AKxV
        WUJVWUGwC20s026x8GjcxK67AKxVWUGVWUWwC2zVAF1VAY17CE14v26r1q6r43MIIYrxkI
        7VAKI48JMIIF0xvE2Ix0cI8IcVAFwI0_Jr0_JF4lIxAIcVC0I7IYx2IY6xkF7I0E14v26r
        1j6r4UMIIF0xvE42xK8VAvwI8IcIk0rVWrZr1j6s0DMIIF0xvEx4A2jsIE14v26r1j6r4U
        MIIF0xvEx4A2jsIEc7CjxVAFwI0_Jr0_GrUvcSsGvfC2KfnxnUUI43ZEXa7VUjQBMtUUUU
        U==
X-Originating-IP: [202.43.158.76]
X-CM-SenderInfo: hgdl6xpl1xt0o6sk53xlxphulrpou0/
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fixed some coding style issues, improve code reading.
This patch adds whitespace to clearly separate the parameters.

Signed-off-by: Zhiyuan Dai <daizhiyuan@phytium.com.cn>
---
 mm/slab.c | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/mm/slab.c b/mm/slab.c
index d7c8da9..30bba30 100644
--- a/mm/slab.c
+++ b/mm/slab.c
@@ -272,7 +272,7 @@ static void kmem_cache_node_init(struct kmem_cache_node *parent)
 #define	STATS_DEC_ACTIVE(x)	((x)->num_active--)
 #define	STATS_INC_ALLOCED(x)	((x)->num_allocations++)
 #define	STATS_INC_GROWN(x)	((x)->grown++)
-#define	STATS_ADD_REAPED(x,y)	((x)->reaped += (y))
+#define	STATS_ADD_REAPED(x, y)	((x)->reaped += (y))
 #define	STATS_SET_HIGH(x)						\
 	do {								\
 		if ((x)->num_active > (x)->high_mark)			\
@@ -296,7 +296,7 @@ static void kmem_cache_node_init(struct kmem_cache_node *parent)
 #define	STATS_DEC_ACTIVE(x)	do { } while (0)
 #define	STATS_INC_ALLOCED(x)	do { } while (0)
 #define	STATS_INC_GROWN(x)	do { } while (0)
-#define	STATS_ADD_REAPED(x,y)	do { (void)(y); } while (0)
+#define	STATS_ADD_REAPED(x, y)	do { (void)(y); } while (0)
 #define	STATS_SET_HIGH(x)	do { } while (0)
 #define	STATS_INC_ERR(x)	do { } while (0)
 #define	STATS_INC_NODEALLOCS(x)	do { } while (0)
@@ -332,7 +332,7 @@ static int obj_offset(struct kmem_cache *cachep)
 static unsigned long long *dbg_redzone1(struct kmem_cache *cachep, void *objp)
 {
 	BUG_ON(!(cachep->flags & SLAB_RED_ZONE));
-	return (unsigned long long*) (objp + obj_offset(cachep) -
+	return (unsigned long long *) (objp + obj_offset(cachep) -
 				      sizeof(unsigned long long));
 }
 
@@ -580,7 +580,7 @@ static int transfer_objects(struct array_cache *to,
 	if (!nr)
 		return 0;
 
-	memcpy(to->entry + to->avail, from->entry + from->avail -nr,
+	memcpy(to->entry + to->avail, from->entry + from->avail - nr,
 			sizeof(void *) *nr);
 
 	from->avail -= nr;
@@ -2738,7 +2738,7 @@ static void *cache_free_debugcheck(struct kmem_cache *cachep, void *objp,
 
 #else
 #define kfree_debugcheck(x) do { } while(0)
-#define cache_free_debugcheck(x,objp,z) (objp)
+#define cache_free_debugcheck(x, objp, z) (objp)
 #endif
 
 static inline void fixup_objfreelist_debug(struct kmem_cache *cachep,
@@ -3025,7 +3025,7 @@ static void *cache_alloc_debugcheck_after(struct kmem_cache *cachep,
 	return objp;
 }
 #else
-#define cache_alloc_debugcheck_after(a,b,objp,d) (objp)
+#define cache_alloc_debugcheck_after(a, b, objp, d) (objp)
 #endif
 
 static inline void *____cache_alloc(struct kmem_cache *cachep, gfp_t flags)
-- 
1.8.3.1

