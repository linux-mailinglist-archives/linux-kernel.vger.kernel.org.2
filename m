Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7FA1C33FE56
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Mar 2021 05:53:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229634AbhCREw1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 18 Mar 2021 00:52:27 -0400
Received: from out30-43.freemail.mail.aliyun.com ([115.124.30.43]:55190 "EHLO
        out30-43.freemail.mail.aliyun.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229540AbhCREwW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 Mar 2021 00:52:22 -0400
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R111e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=e01e01424;MF=xlpang@linux.alibaba.com;NM=1;PH=DS;RN=15;SR=0;TI=SMTPD_---0USNEbJb_1616043135;
Received: from xunleideMacBook-Pro.local(mailfrom:xlpang@linux.alibaba.com fp:SMTPD_---0USNEbJb_1616043135)
          by smtp.aliyun-inc.com(127.0.0.1);
          Thu, 18 Mar 2021 12:52:16 +0800
Reply-To: xlpang@linux.alibaba.com
Subject: Re: [PATCH v4 1/3] mm/slub: Introduce two counters for partial
 objects
To:     Vlastimil Babka <vbabka@suse.cz>,
        Xunlei Pang <xlpang@linux.alibaba.com>,
        Christoph Lameter <cl@linux.com>,
        Christoph Lameter <cl@gentwo.de>,
        Pekka Enberg <penberg@kernel.org>,
        Roman Gushchin <guro@fb.com>,
        Konstantin Khlebnikov <khlebnikov@yandex-team.ru>,
        David Rientjes <rientjes@google.com>,
        Matthew Wilcox <willy@infradead.org>,
        Shu Ming <sming56@gmail.com>,
        Andrew Morton <akpm@linux-foundation.org>
Cc:     linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        Wen Yang <wenyang@linux.alibaba.com>,
        James Wang <jnwang@linux.alibaba.com>
References: <1615967692-80524-1-git-send-email-xlpang@linux.alibaba.com>
 <1615967692-80524-2-git-send-email-xlpang@linux.alibaba.com>
 <322e2b18-e529-3004-c19a-8c4a3b97c532@suse.cz>
From:   Xunlei Pang <xlpang@linux.alibaba.com>
Message-ID: <9594c2c0-b6ef-2064-b8c0-72f67032cde8@linux.alibaba.com>
Date:   Thu, 18 Mar 2021 12:52:15 +0800
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.12; rv:78.0)
 Gecko/20100101 Thunderbird/78.7.1
MIME-Version: 1.0
In-Reply-To: <322e2b18-e529-3004-c19a-8c4a3b97c532@suse.cz>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 3/18/21 2:45 AM, Vlastimil Babka wrote:
> On 3/17/21 8:54 AM, Xunlei Pang wrote:
>> The node list_lock in count_partial() spends long time iterating
>> in case of large amount of partial page lists, which can cause
>> thunder herd effect to the list_lock contention.
>>
>> We have HSF RT(High-speed Service Framework Response-Time) monitors,
>> the RT figures fluctuated randomly, then we deployed a tool detecting
>> "irq off" and "preempt off" to dump the culprit's calltrace, capturing
>> the list_lock cost nearly 100ms with irq off issued by "ss", this also
>> caused network timeouts.
>>
>> This patch introduces two counters to maintain the actual number
>> of partial objects dynamically instead of iterating the partial
>> page lists with list_lock held.
>>
>> New counters of kmem_cache_node: partial_free_objs, partial_total_objs.
>> The main operations are under list_lock in slow path, its performance
>> impact is expected to be minimal except the __slab_free() path.
>>
>> The only concern of introducing partial counter is that partial_free_objs
>> may cause cacheline contention and false sharing issues in case of same
>> SLUB concurrent __slab_free(), so define it to be a percpu counter and
>> places it carefully.
> 
> Hm I wonder, is it possible that this will eventually overflow/underflow the
> counter on some CPU? (I guess practially only on 32bit). Maybe the operations
> that are already done under n->list_lock should flush the percpu counter to a
> shared counter?

You are right, thanks a lot for noticing this.

> 
> ...
> 
>> @@ -3039,6 +3066,13 @@ static void __slab_free(struct kmem_cache *s, struct page *page,
>>  		head, new.counters,
>>  		"__slab_free"));
>>  
>> +	if (!was_frozen && prior) {
>> +		if (n)
>> +			__update_partial_free(n, cnt);
>> +		else
>> +			__update_partial_free(get_node(s, page_to_nid(page)), cnt);
>> +	}
> 
> I would guess this is the part that makes your measurements notice that
> (although tiny) difference. We didn't need to obtain the node pointer before and
> now we do. And that is really done just for the per-node breakdown in "objects"
> and "objects_partial" files under /sys/kernel/slab - distinguishing nodes is not
> needed for /proc/slabinfo. So that kinda justifies putting this under a new
> CONFIG as you did. Although perhaps somebody interested in these kind of stats
> would enable CONFIG_SLUB_STATS anyway, so that's still an option to use instead
> of introducing a new oddly specific CONFIG? At least until somebody comes up and
> presents an use case where they want the per-node breakdowns in /sys but cannot
> afford CONFIG_SLUB_STATS.
> 
> But I'm also still thinking about simply counting all free objects (for the
> purposes of accurate <active_objs> in /proc/slabinfo) as a percpu variable in
> struct kmem_cache itself. That would basically put this_cpu_add() in all the
> fast paths, but AFAICS thanks to the segment register it doesn't mean disabling
> interrupts nor a LOCK operation, so maybe it wouldn't be that bad? And it
> shouldn't need to deal with these node pointers. So maybe that would be
> acceptable for CONFIG_SLUB_DEBUG? Guess I'll have to try...
> 

The percpu operation itself should be fine, it looks to be cacheline
pingpong issue due to extra percpu counter access, so making it
cacheline aligned improves a little according to my tests.
