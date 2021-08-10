Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EEFC03E5630
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Aug 2021 11:03:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238500AbhHJJD1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 10 Aug 2021 05:03:27 -0400
Received: from smtp-out2.suse.de ([195.135.220.29]:44522 "EHLO
        smtp-out2.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233739AbhHJJDZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Aug 2021 05:03:25 -0400
Received: from imap1.suse-dmz.suse.de (imap1.suse-dmz.suse.de [192.168.254.73])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id 6703320085;
        Tue, 10 Aug 2021 09:03:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1628586183; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=XC2nymt1bdXjtCm1lcyAcRUORKZsijzPd2QfYFp10BY=;
        b=yg60EuW52YjQMr63UZOSOQ6lP82k6FKAqiDf3a5kpT2fRW2xGuvLHih/ye18oCwMuChKYH
        Ztwh5MjnAc8McaXNKZjs0iETqNxY7ZeX9ps3m+QE4FyL4vEPUlVxKKXEjV5Y+ZFSIa8Us7
        Uah9WEzTFC1p8HOyCSrGMNazKKNAD6U=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1628586183;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=XC2nymt1bdXjtCm1lcyAcRUORKZsijzPd2QfYFp10BY=;
        b=eefVtVgL0FJQEHr9ipkcWHqaIcD/sr7JvgxMtog0Tdr78O6vGTxBlc5lDGxxnVTBxkcaq2
        eFCOFK79NM7duzBA==
Received: from imap1.suse-dmz.suse.de (imap1.suse-dmz.suse.de [192.168.254.73])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap1.suse-dmz.suse.de (Postfix) with ESMTPS id 367641332A;
        Tue, 10 Aug 2021 09:03:03 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap1.suse-dmz.suse.de with ESMTPSA
        id uq9+DMdAEmHSYAAAGKfGzw
        (envelope-from <vbabka@suse.cz>); Tue, 10 Aug 2021 09:03:03 +0000
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
Message-ID: <fbf59e73-8b27-56a8-d863-cfe40457f4df@suse.cz>
Date:   Tue, 10 Aug 2021 11:03:02 +0200
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
>>  
>> +static DEFINE_MUTEX(flush_lock);
>> +static DEFINE_PER_CPU(struct slub_flush_work, slub_flush);
>> +
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
> 
> [   91.374541] WARNING: possible circular locking dependency detected
> [   91.381411] 5.14.0-rc5-next-20210809+ #84 Not tainted
> [   91.387149] ------------------------------------------------------
> [   91.394016] lsbug/1523 is trying to acquire lock:
> [   91.399406] ffff800018e76530 (flush_lock){+.+.}-{3:3}, at: flush_all+0x50/0x1c8
> [   91.407425] 
>                but task is already holding lock:
> [   91.414638] ffff800018e48468 (slab_mutex){+.+.}-{3:3}, at: slab_memory_callback+0x44/0x280
> [   91.423603] 
>                which lock already depends on the new lock.
> 

OK, managed to reproduce in qemu and this fixes it for me on top of
next-20210809. Could you test as well, as your testing might be more
comprehensive? I will format is as a fixup for the proper patch in the series then.

----8<----
From 7ce71c7f9455e8b96dc1b728ea566b6ef5e424e4 Mon Sep 17 00:00:00 2001
From: Vlastimil Babka <vbabka@suse.cz>
Date: Tue, 10 Aug 2021 10:58:07 +0200
Subject: [PATCH] mm, slub: fix memory offline lockdep splat

Reverse order of flush_lock and cpus_read_lock() to prevent lockdep splat.
In slab_mem_going_offline_callback() we already have cpus_read_lock()
held so make sure it's not taken again.

Signed-off-by: Vlastimil Babka <vbabka@suse.cz>
---
 mm/slub.c | 27 ++++++++++++++++++++-------
 1 file changed, 20 insertions(+), 7 deletions(-)

diff --git a/mm/slub.c b/mm/slub.c
index 88a6c3ed2751..073cdd4b020f 100644
--- a/mm/slub.c
+++ b/mm/slub.c
@@ -2640,13 +2640,13 @@ static bool has_cpu_slab(int cpu, struct kmem_cache *s)
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
@@ -2667,10 +2667,16 @@ static void flush_all(struct kmem_cache *s)
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
@@ -4516,7 +4522,7 @@ EXPORT_SYMBOL(kfree);
  * being allocated from last increasing the chance that the last objects
  * are freed in them.
  */
-int __kmem_cache_shrink(struct kmem_cache *s)
+int __kmem_cache_do_shrink(struct kmem_cache *s)
 {
 	int node;
 	int i;
@@ -4528,7 +4534,6 @@ int __kmem_cache_shrink(struct kmem_cache *s)
 	unsigned long flags;
 	int ret = 0;
 
-	flush_all(s);
 	for_each_kmem_cache_node(s, node, n) {
 		INIT_LIST_HEAD(&discard);
 		for (i = 0; i < SHRINK_PROMOTE_MAX; i++)
@@ -4578,13 +4583,21 @@ int __kmem_cache_shrink(struct kmem_cache *s)
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

