Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B445C3A0ED6
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Jun 2021 10:41:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237687AbhFIInk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 9 Jun 2021 04:43:40 -0400
Received: from smtp-out1.suse.de ([195.135.220.28]:54644 "EHLO
        smtp-out1.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235548AbhFIIni (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Jun 2021 04:43:38 -0400
Received: from imap.suse.de (imap-alt.suse-dmz.suse.de [192.168.254.47])
        (using TLSv1.2 with cipher ECDHE-ECDSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id 85175219B9;
        Wed,  9 Jun 2021 08:41:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1623228103; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=XW50r/dVGSB8GZhYgnYKju32pddbaWM8FKgjyzfxzdc=;
        b=Ts9zdesHFrCvu5FYB1cN8HQJQto0fnqSf/aSkJQY+FL6Ohhrdukw4yupD8JatkUL7qWuoJ
        7lcfSuhPzKi0+jDFYQuzlN4OnXxUr4l2bw85HleDo71XLUe8f8JkgXwbhMN39mfgEVckN6
        6bLHi58L+BruKadlUR3hsFwqbbGU7WE=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1623228103;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=XW50r/dVGSB8GZhYgnYKju32pddbaWM8FKgjyzfxzdc=;
        b=lzOofCO4L+MEvzYmZo7eT1zsHFhf4PCx2jkHGSshPy8rKZpE1o65W3t6YRNhLSAdJVB30z
        SOal9mAK8P1iAfCQ==
Received: from imap3-int (imap-alt.suse-dmz.suse.de [192.168.254.47])
        by imap.suse.de (Postfix) with ESMTP id 6149B118DD;
        Wed,  9 Jun 2021 08:41:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1623228103; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=XW50r/dVGSB8GZhYgnYKju32pddbaWM8FKgjyzfxzdc=;
        b=Ts9zdesHFrCvu5FYB1cN8HQJQto0fnqSf/aSkJQY+FL6Ohhrdukw4yupD8JatkUL7qWuoJ
        7lcfSuhPzKi0+jDFYQuzlN4OnXxUr4l2bw85HleDo71XLUe8f8JkgXwbhMN39mfgEVckN6
        6bLHi58L+BruKadlUR3hsFwqbbGU7WE=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1623228103;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=XW50r/dVGSB8GZhYgnYKju32pddbaWM8FKgjyzfxzdc=;
        b=lzOofCO4L+MEvzYmZo7eT1zsHFhf4PCx2jkHGSshPy8rKZpE1o65W3t6YRNhLSAdJVB30z
        SOal9mAK8P1iAfCQ==
Received: from director1.suse.de ([192.168.254.71])
        by imap3-int with ESMTPSA
        id VP8zF8d+wGD3XwAALh3uQQ
        (envelope-from <vbabka@suse.cz>); Wed, 09 Jun 2021 08:41:43 +0000
Subject: Re: [RFC 25/26] mm, slub: use migrate_disable() in put_cpu_partial()
To:     Jann Horn <jannh@google.com>
Cc:     Linux-MM <linux-mm@kvack.org>,
        kernel list <linux-kernel@vger.kernel.org>,
        Christoph Lameter <cl@linux.com>,
        David Rientjes <rientjes@google.com>,
        Pekka Enberg <penberg@kernel.org>,
        Joonsoo Kim <iamjoonsoo.kim@lge.com>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        Thomas Gleixner <tglx@linutronix.de>,
        Mel Gorman <mgorman@techsingularity.net>,
        Jesper Dangaard Brouer <brouer@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>
References: <20210524233946.20352-1-vbabka@suse.cz>
 <20210524233946.20352-26-vbabka@suse.cz>
 <CAG48ez1mvUuXwg0YPH5ANzhQLpbphqk-ZS+jbRz+H66fvm4FcA@mail.gmail.com>
From:   Vlastimil Babka <vbabka@suse.cz>
Message-ID: <2a5cddf1-100d-9d24-fb98-8a5bd439a804@suse.cz>
Date:   Wed, 9 Jun 2021 10:41:43 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.10.2
MIME-Version: 1.0
In-Reply-To: <CAG48ez1mvUuXwg0YPH5ANzhQLpbphqk-ZS+jbRz+H66fvm4FcA@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 5/25/21 5:33 PM, Jann Horn wrote:
> On Tue, May 25, 2021 at 1:40 AM Vlastimil Babka <vbabka@suse.cz> wrote:
>> In put_cpu_partial, we need a stable cpu, but being preempted is not an issue.
>> So, disable migration instead of preemption.
> 
> I wouldn't say "not an issue", more like "you're not making it worse".
> 
> From what I can tell, the following race can already theoretically happen:
> 
> task A: put_cpu_partial() calls preempt_disable()
> task A: oldpage = this_cpu_read(s->cpu_slab->partial)
> interrupt: kfree() reaches unfreeze_partials() and discards the page
> task B (on another CPU): reallocates page as page cache
> task A: reads page->pages and page->pobjects, which are actually
> halves of the pointer page->lru.prev
> task B (on another CPU): frees page
> interrupt: allocates page as SLUB page and places it on the percpu partial list
> task A: this_cpu_cmpxchg() succeeds

Oops, nice find. Thanks.

> which would cause page->pages and page->pobjects to end up containing
> halves of pointers that would then influence when put_cpu_partial()
> happens and show up in root-only sysfs files. Maybe that's acceptable,
> I don't know. But there should probably at least be a comment for now
> to point out that we're reading union fields of a page that might be
> in a completely different state.
> 
> (Someone should probably fix that code sometime and get rid of
> page->pobjects entirely, given how inaccurate it is...)

I'll try to address it separately later. Probably just target a number of pages,
instead of objects, on the list and store the number as part of struct
kmem_cache_cpu, not struct page. The inaccuracy leading to potentially long
lists is a good reason enough, the race scenario above is another one...

