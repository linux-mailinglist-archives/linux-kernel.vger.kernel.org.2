Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E2A143E5E0D
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Aug 2021 16:33:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240651AbhHJOdw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 10 Aug 2021 10:33:52 -0400
Received: from smtp-out2.suse.de ([195.135.220.29]:38218 "EHLO
        smtp-out2.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240629AbhHJOdu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Aug 2021 10:33:50 -0400
Received: from imap1.suse-dmz.suse.de (imap1.suse-dmz.suse.de [192.168.254.73])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id E9AEC200C7;
        Tue, 10 Aug 2021 14:33:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1628606006; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=wkCnELVQwQiatAq1mq/m2UWsuNx0qmvOx/DTX3yze94=;
        b=PyUt5v+D+FboPBYc+IcSZj/SZGf/LH1ys/od5Gnna2VAQTn3mCawhMZiPk4y6AyrHRVBWP
        dBHYWjmpTO2IRkRYD26+giiASFp6m0C4CoAxUSGtbq2fv4C2hePqjq6hFO+P30E1ZShPfa
        IHTJLlgXx/W7YOrspULkf6ad5OqzWLM=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1628606006;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=wkCnELVQwQiatAq1mq/m2UWsuNx0qmvOx/DTX3yze94=;
        b=mskJZwk/qb2l/3FS1vqpjDpVLjxJoAlU8cyp6hg/xvXBJPGPU3lGdXyXtlQsZ5A6ETnueq
        cYxdr+ocSJ1WjjAA==
Received: from imap1.suse-dmz.suse.de (imap1.suse-dmz.suse.de [192.168.254.73])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap1.suse-dmz.suse.de (Postfix) with ESMTPS id B450C137DA;
        Tue, 10 Aug 2021 14:33:26 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap1.suse-dmz.suse.de with ESMTPSA
        id S6soKzaOEmH+NQAAGKfGzw
        (envelope-from <vbabka@suse.cz>); Tue, 10 Aug 2021 14:33:26 +0000
Subject: Re: [PATCH v4 29/35] mm: slub: Move flush_cpu_slab() invocations
 __free_slab() invocations out of IRQ context
To:     Qian Cai <quic_qiancai@quicinc.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Christoph Lameter <cl@linux.com>,
        David Rientjes <rientjes@google.com>,
        Pekka Enberg <penberg@kernel.org>,
        Joonsoo Kim <iamjoonsoo.kim@lge.com>
Cc:     linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        Mike Galbraith <efault@gmx.de>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        Thomas Gleixner <tglx@linutronix.de>,
        Mel Gorman <mgorman@techsingularity.net>,
        Jesper Dangaard Brouer <brouer@redhat.com>,
        Jann Horn <jannh@google.com>
References: <20210805152000.12817-1-vbabka@suse.cz>
 <20210805152000.12817-30-vbabka@suse.cz>
 <0b36128c-3e12-77df-85fe-a153a714569b@quicinc.com>
From:   Vlastimil Babka <vbabka@suse.cz>
Message-ID: <50fe26ba-450b-af57-506d-438f67cfbce3@suse.cz>
Date:   Tue, 10 Aug 2021 16:33:26 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.12.0
MIME-Version: 1.0
In-Reply-To: <0b36128c-3e12-77df-85fe-a153a714569b@quicinc.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 8/9/21 3:41 PM, Qian Cai wrote:

>>  static void flush_all(struct kmem_cache *s)
>>  {
>> -	on_each_cpu_cond(has_cpu_slab, flush_cpu_slab, s, 1);
>> +	struct slub_flush_work *sfw;
>> +	unsigned int cpu;
>> +
>> +	mutex_lock(&flush_lock);
> 
> Vlastimil, taking the lock here could trigger a warning during memory offline/online due to the locking order:
> 
> slab_mutex -> flush_lock

Here's the full fixup, also incorporating Mike's fix. Thanks.

----8<----
From c2df67d5116d4615c322e262556e34117e268104 Mon Sep 17 00:00:00 2001
From: Vlastimil Babka <vbabka@suse.cz>
Date: Tue, 10 Aug 2021 10:58:07 +0200
Subject: [PATCH] mm, slub: fix memory and cpu hotplug related lock ordering
 issues

Qian Cai reported [1] a lockdep splat on memory offline.

[   91.374541] WARNING: possible circular locking dependency detected
[   91.381411] 5.14.0-rc5-next-20210809+ #84 Not tainted
[   91.387149] ------------------------------------------------------
[   91.394016] lsbug/1523 is trying to acquire lock:
[   91.399406] ffff800018e76530 (flush_lock){+.+.}-{3:3}, at: flush_all+0x50/0x1c8
[   91.407425] but task is already holding lock:
[   91.414638] ffff800018e48468 (slab_mutex){+.+.}-{3:3}, at: slab_memory_callback+0x44/0x280
[   91.423603] which lock already depends on the new lock.

To fix it, we need to change the order in flush_all() so that cpus_read_lock()
is first and mutex_lock(&flush_lock) second.

Also when called from slab_mem_going_offline_callback() we are already under
cpus_read_lock() and cannot take it again, so create a flush_all_cpus_locked()
variant and decouple flushing from actual shrinking for this call path.

Additionally, Mike Galbraith reported [2] wrong order of cpus_read_lock() and
slab_mutex in kmem_cache_destroy() path and proposed a fix to reverse it.

This patch is a fixup for the mmotm patch
mm-slub-move-flush_cpu_slab-invocations-__free_slab-invocations-out-of-irq-context.patch

[1] https://lore.kernel.org/lkml/0b36128c-3e12-77df-85fe-a153a714569b@quicinc.com/
[2] https://lore.kernel.org/lkml/2eb3cf340716c40f03a0a342ab40219b3d1de195.camel@gmx.de/

Reported-by: Qian Cai <quic_qiancai@quicinc.com>
Reported-by: Mike Galbraith <efault@gmx.de>
Signed-off-by: Vlastimil Babka <vbabka@suse.cz>
---
 mm/slab_common.c |  2 ++
 mm/slub.c        | 29 +++++++++++++++++++++--------
 2 files changed, 23 insertions(+), 8 deletions(-)

diff --git a/mm/slab_common.c b/mm/slab_common.c
index 1c673c323baf..ec2bb0beed75 100644
--- a/mm/slab_common.c
+++ b/mm/slab_common.c
@@ -502,6 +502,7 @@ void kmem_cache_destroy(struct kmem_cache *s)
 	if (unlikely(!s))
 		return;
 
+	cpus_read_lock();
 	mutex_lock(&slab_mutex);
 
 	s->refcount--;
@@ -516,6 +517,7 @@ void kmem_cache_destroy(struct kmem_cache *s)
 	}
 out_unlock:
 	mutex_unlock(&slab_mutex);
+	cpus_read_unlock();
 }
 EXPORT_SYMBOL(kmem_cache_destroy);
 
diff --git a/mm/slub.c b/mm/slub.c
index da48ada3d17f..152487f84025 100644
--- a/mm/slub.c
+++ b/mm/slub.c
@@ -2551,13 +2551,13 @@ static bool has_cpu_slab(int cpu, struct kmem_cache *s)
 static DEFINE_MUTEX(flush_lock);
 static DEFINE_PER_CPU(struct slub_flush_work, slub_flush);
 
-static void flush_all(struct kmem_cache *s)
+static void flush_all_cpus_locked(struct kmem_cache *s)
 {
 	struct slub_flush_work *sfw;
 	unsigned int cpu;
 
+	lockdep_assert_cpus_held();
 	mutex_lock(&flush_lock);
-	cpus_read_lock();
 
 	for_each_online_cpu(cpu) {
 		sfw = &per_cpu(slub_flush, cpu);
@@ -2578,10 +2578,16 @@ static void flush_all(struct kmem_cache *s)
 		flush_work(&sfw->work);
 	}
 
-	cpus_read_unlock();
 	mutex_unlock(&flush_lock);
 }
 
+static void flush_all(struct kmem_cache *s)
+{
+	cpus_read_lock();
+	flush_all_cpus_locked(s);
+	cpus_read_unlock();
+}
+
 /*
  * Use the cpu notifier to insure that the cpu slabs are flushed when
  * necessary.
@@ -4111,7 +4117,7 @@ int __kmem_cache_shutdown(struct kmem_cache *s)
 	int node;
 	struct kmem_cache_node *n;
 
-	flush_all(s);
+	flush_all_cpus_locked(s);
 	/* Attempt to free all objects */
 	for_each_kmem_cache_node(s, node, n) {
 		free_partial(s, n);
@@ -4387,7 +4393,7 @@ EXPORT_SYMBOL(kfree);
  * being allocated from last increasing the chance that the last objects
  * are freed in them.
  */
-int __kmem_cache_shrink(struct kmem_cache *s)
+int __kmem_cache_do_shrink(struct kmem_cache *s)
 {
 	int node;
 	int i;
@@ -4399,7 +4405,6 @@ int __kmem_cache_shrink(struct kmem_cache *s)
 	unsigned long flags;
 	int ret = 0;
 
-	flush_all(s);
 	for_each_kmem_cache_node(s, node, n) {
 		INIT_LIST_HEAD(&discard);
 		for (i = 0; i < SHRINK_PROMOTE_MAX; i++)
@@ -4449,13 +4454,21 @@ int __kmem_cache_shrink(struct kmem_cache *s)
 	return ret;
 }
 
+int __kmem_cache_shrink(struct kmem_cache *s)
+{
+	flush_all(s);
+	return __kmem_cache_do_shrink(s);
+}
+
 static int slab_mem_going_offline_callback(void *arg)
 {
 	struct kmem_cache *s;
 
 	mutex_lock(&slab_mutex);
-	list_for_each_entry(s, &slab_caches, list)
-		__kmem_cache_shrink(s);
+	list_for_each_entry(s, &slab_caches, list) {
+		flush_all_cpus_locked(s);
+		__kmem_cache_do_shrink(s);
+	}
 	mutex_unlock(&slab_mutex);
 
 	return 0;
-- 
2.32.0


