Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id ACF883E4D9F
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Aug 2021 22:09:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235711AbhHIUJU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 9 Aug 2021 16:09:20 -0400
Received: from smtp-out1.suse.de ([195.135.220.28]:51236 "EHLO
        smtp-out1.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233617AbhHIUJH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Aug 2021 16:09:07 -0400
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id 61BF021EC8;
        Mon,  9 Aug 2021 20:08:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1628539725; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=5x82NUkOknffAHFN2Rs5YRMh7Ejf3hpkaRgEovnkMu0=;
        b=pqB99FiBD7LXzFQSv1SOK7v4TIqEWVmzGLhi7T6LmCSRAfbFJoWeyu+EsltNgYyALTFgHk
        zlohidhJfAbrm1aeDwXcnjcT/C1DgtrNYKNNPXAOG5zLZHZKHS7cnuT7OcPW4m5KCcDFk/
        pFqxFAzXicGB9PHyNl9Rhthgo1jv+kE=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1628539725;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=5x82NUkOknffAHFN2Rs5YRMh7Ejf3hpkaRgEovnkMu0=;
        b=V4x9XN4P2cIigfYWZopKSNihTg0oqq8WHx/PUQ7A/P+cybc2W8ANlQRNKPoBFO4NLq4F+d
        nFbNhCI5Nzau2+DQ==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 3148313AD4;
        Mon,  9 Aug 2021 20:08:45 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id uC5ZC02LEWG3fQAAMHmgww
        (envelope-from <vbabka@suse.cz>); Mon, 09 Aug 2021 20:08:45 +0000
Subject: Re: [PATCH v4 29/35] mm: slub: Move flush_cpu_slab() invocations
 __free_slab() invocations out of IRQ context
To:     Mike Galbraith <efault@gmx.de>,
        Qian Cai <quic_qiancai@quicinc.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Christoph Lameter <cl@linux.com>,
        David Rientjes <rientjes@google.com>,
        Pekka Enberg <penberg@kernel.org>,
        Joonsoo Kim <iamjoonsoo.kim@lge.com>
Cc:     linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        Thomas Gleixner <tglx@linutronix.de>,
        Mel Gorman <mgorman@techsingularity.net>,
        Jesper Dangaard Brouer <brouer@redhat.com>,
        Jann Horn <jannh@google.com>
References: <20210805152000.12817-1-vbabka@suse.cz>
 <20210805152000.12817-30-vbabka@suse.cz>
 <0b36128c-3e12-77df-85fe-a153a714569b@quicinc.com>
 <6e3bb54fdf7208f3f86a5d31e1ef2a576d8e7e37.camel@gmx.de>
From:   Vlastimil Babka <vbabka@suse.cz>
Message-ID: <7d9ac614-f18e-de5d-2d47-f92e618d76fc@suse.cz>
Date:   Mon, 9 Aug 2021 22:08:44 +0200
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.12.0
MIME-Version: 1.0
In-Reply-To: <6e3bb54fdf7208f3f86a5d31e1ef2a576d8e7e37.camel@gmx.de>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 8/9/2021 8:44 PM, Mike Galbraith wrote:
> On Mon, 2021-08-09 at 09:41 -0400, Qian Cai wrote:
>>
>>
>> On 8/5/2021 11:19 AM, Vlastimil Babka wrote:
>>>
>>>  
>>> +static DEFINE_MUTEX(flush_lock);
>>> +static DEFINE_PER_CPU(struct slub_flush_work, slub_flush);
>>> +
>>>  static void flush_all(struct kmem_cache *s)
>>>  {
>>> -       on_each_cpu_cond(has_cpu_slab, flush_cpu_slab, s, 1);
>>> +       struct slub_flush_work *sfw;
>>> +       unsigned int cpu;
>>> +
>>> +       mutex_lock(&flush_lock);
>>
>> Vlastimil, taking the lock here could trigger a warning during memory
>> offline/online due to the locking order:
>>
>> slab_mutex -> flush_lock
> 
> Bugger.  That chain ending with cpu_hotplug_lock makes slub_cpu_dead()
> taking slab_mutex a non-starter for cpu hotplug as well.  It's
> established early by kernel_init_freeable()..kmem_cache_destroy() as
> well as by slab_mem_going_offline_callback().

I suck at reading the lockdep splats, so I don't see yet how the "existing
reverse order" occurs - I do understand the order in the "lsbug".
What I also wonder is why didn't this occur also in the older RT trees with this
patch. I did change the order of locks in flush_all() to take flush_lock first
and cpus_read_lock() second, as Cyrill Gorcunov suggested. Would the original
order prevent this? Or we would fail anyway because we already took
cpus_read_lock() in offline_pages() and now are taking it again - do these nest
or not?
