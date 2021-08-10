Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 329863E861B
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Aug 2021 00:36:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235033AbhHJWg1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 10 Aug 2021 18:36:27 -0400
Received: from smtp-out1.suse.de ([195.135.220.28]:54406 "EHLO
        smtp-out1.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231380AbhHJWgZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Aug 2021 18:36:25 -0400
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id 47F9922074;
        Tue, 10 Aug 2021 22:36:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1628634962; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=eKK1VzUeLkeOPxPNWQtm/sXKsDQbfgwdK/8tDf08a1k=;
        b=dUz5N/0SHLhdc8ux+Z2PnlN1zF5GAy7XQ1LYrbv2mNUGKZ8t9PDxmN6gZPiG0PKeO0sYCy
        Fyl/6N6k55SXFPEM+xgx2pILCPh2/KzsDpR3jl7N8yrhKpyz2znQhdFslTcE92u4c6FUI7
        7ZURns5vvy2rQWA2JsqCTaLO0siRo2Q=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1628634962;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=eKK1VzUeLkeOPxPNWQtm/sXKsDQbfgwdK/8tDf08a1k=;
        b=Wejdjm4mu2JXgw9iDBMgRJmHT/R9nR5ELQGp7C1m+uuf7vozNQIudcNZXGO2ZQMvGnh8HF
        i0Xx+TnqlZXiqXAw==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 144C513BE5;
        Tue, 10 Aug 2021 22:36:02 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id gLM9BFL/EmGCcwAAMHmgww
        (envelope-from <vbabka@suse.cz>); Tue, 10 Aug 2021 22:36:02 +0000
Subject: Re: [PATCH v4 29/35] mm: slub: Move flush_cpu_slab() invocations
 __free_slab() invocations out of IRQ context
To:     paulmck@kernel.org, Mike Galbraith <efault@gmx.de>
Cc:     Qian Cai <quic_qiancai@quicinc.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Christoph Lameter <cl@linux.com>,
        David Rientjes <rientjes@google.com>,
        Pekka Enberg <penberg@kernel.org>,
        Joonsoo Kim <iamjoonsoo.kim@lge.com>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        Thomas Gleixner <tglx@linutronix.de>,
        Mel Gorman <mgorman@techsingularity.net>,
        Jesper Dangaard Brouer <brouer@redhat.com>,
        Jann Horn <jannh@google.com>
References: <20210805152000.12817-1-vbabka@suse.cz>
 <20210805152000.12817-30-vbabka@suse.cz>
 <0b36128c-3e12-77df-85fe-a153a714569b@quicinc.com>
 <fbf59e73-8b27-56a8-d863-cfe40457f4df@suse.cz>
 <2eb3cf340716c40f03a0a342ab40219b3d1de195.camel@gmx.de>
 <20210810203123.GB190765@paulmck-ThinkPad-P17-Gen-1>
From:   Vlastimil Babka <vbabka@suse.cz>
Message-ID: <a8308403-ae87-28ce-1aa3-66e1a436b144@suse.cz>
Date:   Wed, 11 Aug 2021 00:36:00 +0200
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.12.0
MIME-Version: 1.0
In-Reply-To: <20210810203123.GB190765@paulmck-ThinkPad-P17-Gen-1>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 8/10/2021 10:31 PM, Paul E. McKenney wrote:
> On Tue, Aug 10, 2021 at 01:47:42PM +0200, Mike Galbraith wrote:
>> On Tue, 2021-08-10 at 11:03 +0200, Vlastimil Babka wrote:
>>> On 8/9/21 3:41 PM, Qian Cai wrote:
>>>>>  
>>>>> +static DEFINE_MUTEX(flush_lock);
>>>>> +static DEFINE_PER_CPU(struct slub_flush_work, slub_flush);
>>>>> +
>>>>>  static void flush_all(struct kmem_cache *s)
>>>>>  {
>>>>> -       on_each_cpu_cond(has_cpu_slab, flush_cpu_slab, s, 1);
>>>>> +       struct slub_flush_work *sfw;
>>>>> +       unsigned int cpu;
>>>>> +
>>>>> +       mutex_lock(&flush_lock);
>>>>
>>>> Vlastimil, taking the lock here could trigger a warning during memory offline/online due to the locking order:
>>>>
>>>> slab_mutex -> flush_lock
>>>>
>>>> [   91.374541] WARNING: possible circular locking dependency detected
>>>> [   91.381411] 5.14.0-rc5-next-20210809+ #84 Not tainted
>>>> [   91.387149] ------------------------------------------------------
>>>> [   91.394016] lsbug/1523 is trying to acquire lock:
>>>> [   91.399406] ffff800018e76530 (flush_lock){+.+.}-{3:3}, at: flush_all+0x50/0x1c8
>>>> [   91.407425]
>>>>                but task is already holding lock:
>>>> [   91.414638] ffff800018e48468 (slab_mutex){+.+.}-{3:3}, at: slab_memory_callback+0x44/0x280
>>>> [   91.423603]
>>>>                which lock already depends on the new lock.
>>>>
>>>
>>> OK, managed to reproduce in qemu and this fixes it for me on top of
>>> next-20210809. Could you test as well, as your testing might be more
>>> comprehensive? I will format is as a fixup for the proper patch in the series then.
>>
>> As it appeared it should, moving cpu_hotplug_lock outside slab_mutex in
>> kmem_cache_destroy() on top of that silenced the cpu offline gripe.
> 
> And this one got rid of the remainder of the deadlock, but gets me the
> splat shown at the end of this message.  So some sort of middle ground
> may be needed.
> 
> (Same reproducer as in my previous reply to Vlastimil.)
> 
> 							Thanx, Paul
> 
>> ---
>>  mm/slab_common.c |    2 ++
>>  mm/slub.c        |    2 +-
>>  2 files changed, 3 insertions(+), 1 deletion(-)
>>
>> --- a/mm/slab_common.c
>> +++ b/mm/slab_common.c
>> @@ -502,6 +502,7 @@ void kmem_cache_destroy(struct kmem_cach
>>  	if (unlikely(!s))
>>  		return;
>>
>> +	cpus_read_lock();
>>  	mutex_lock(&slab_mutex);
>>
>>  	s->refcount--;
>> @@ -516,6 +517,7 @@ void kmem_cache_destroy(struct kmem_cach
>>  	}
>>  out_unlock:
>>  	mutex_unlock(&slab_mutex);
>> +	cpus_read_unlock();
>>  }
>>  EXPORT_SYMBOL(kmem_cache_destroy);
>>
>> --- a/mm/slub.c
>> +++ b/mm/slub.c
>> @@ -4234,7 +4234,7 @@ int __kmem_cache_shutdown(struct kmem_ca
>>  	int node;
>>  	struct kmem_cache_node *n;
>>
>> -	flush_all(s);
>> +	flush_all_cpus_locked(s);
>>  	/* Attempt to free all objects */
>>  	for_each_kmem_cache_node(s, node, n) {
>>  		free_partial(s, n);
> 
> [  602.539109] ------------[ cut here ]------------
> [  602.539804] WARNING: CPU: 3 PID: 88 at kernel/cpu.c:335 lockdep_assert_cpus_held+0x29/0x30

So this says the assert failed and we don't have the cpus_read_lock(), right, but...

> [  602.540940] Modules linked in:
> [  602.541377] CPU: 3 PID: 88 Comm: torture_shutdow Not tainted 5.14.0-rc5-next-20210809+ #3299
> [  602.542536] Hardware name: Red Hat KVM/RHEL-AV, BIOS 1.13.0-2.module_el8.5.0+746+bbd5d70c 04/01/2014
> [  602.543786] RIP: 0010:lockdep_assert_cpus_held+0x29/0x30
> [  602.544524] Code: 00 83 3d 4d f1 a4 01 01 76 0a 8b 05 4d 23 a5 01 85 c0 75 01 c3 be ff ff ff ff 48 c7 c7 b0 86 66 a3 e8 9b 05 c9 00 85 c0 75 ea <0f> 0b c3 0f 1f 40 00 41 57 41 89 ff 41 56 4d 89 c6 41 55 49 89 cd
> [  602.547051] RSP: 0000:ffffb382802efdb8 EFLAGS: 00010246
> [  602.547783] RAX: 0000000000000000 RBX: ffffa23301a44000 RCX: 0000000000000001
> [  602.548764] RDX: 0000000000000001 RSI: ffffffffa335f5c0 RDI: ffffffffa33adbbf[  602.549747] RBP: ffffa23301a44000 R08: ffffa23302810000 R09: 974cf0ba5c48ad3c
> [  602.550727] R10: ffffb382802efe78 R11: 0000000000000001 R12: ffffa23301a44000[  602.551709] R13: 00000000000249c0 R14: 00000000ffffffff R15: 0000000fffffffe0
> [  602.552694] FS:  0000000000000000(0000) GS:ffffa2331f580000(0000) knlGS:0000000000000000
> [  602.553805] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> [  602.554606] CR2: 0000000000000000 CR3: 0000000017222000 CR4: 00000000000006e0
> [  602.555601] DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
> [  602.556590] DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
> [  602.557585] Call Trace:
> [  602.557927]  flush_all_cpus_locked+0x29/0x140
> [  602.558535]  __kmem_cache_shutdown+0x26/0x200
> [  602.559145]  ? lock_is_held_type+0xd6/0x130
> [  602.559739]  ? torture_onoff+0x260/0x260
> [  602.560284]  kmem_cache_destroy+0x38/0x110

It should have been taken here. I don't understand. It's as if only the
mm/slub.c was patched by Mike's patch, but mm/slab_common.c not?

> [  602.560859]  rcu_torture_cleanup.cold.36+0x192/0x421
> [  602.561539]  ? wait_woken+0x60/0x60
> [  602.562035]  ? torture_onoff+0x260/0x260
> [  602.562591]  torture_shutdown+0xdd/0x1c0
> [  602.563131]  kthread+0x132/0x160
> [  602.563592]  ? set_kthread_struct+0x40/0x40
> [  602.564172]  ret_from_fork+0x22/0x30
> [  602.564696] irq event stamp: 1307
> [  602.565161] hardirqs last  enabled at (1315): [<ffffffffa1eddced>] __up_console_sem+0x4d/0x50
> [  602.566321] hardirqs last disabled at (1324): [<ffffffffa1eddcd2>] __up_console_sem+0x32/0x50
> [  602.567479] softirqs last  enabled at (1304): [<ffffffffa2e00311>] __do_softirq+0x311/0x473
> [  602.568616] softirqs last disabled at (1299): [<ffffffffa1e72eb8>] irq_exit_rcu+0xe8/0xf0
> [  602.569735] ---[ end trace 26fd643e1df331c9 ]---
> 

