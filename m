Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AEFEA41ADA8
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Sep 2021 13:12:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240325AbhI1LOS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 28 Sep 2021 07:14:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33784 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239068AbhI1LOQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Sep 2021 07:14:16 -0400
Received: from mail-pg1-x531.google.com (mail-pg1-x531.google.com [IPv6:2607:f8b0:4864:20::531])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0253CC061575
        for <linux-kernel@vger.kernel.org>; Tue, 28 Sep 2021 04:12:37 -0700 (PDT)
Received: by mail-pg1-x531.google.com with SMTP id s11so20767846pgr.11
        for <linux-kernel@vger.kernel.org>; Tue, 28 Sep 2021 04:12:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=uUOAN7watDpAxDREqBm4Gm5B8qCscUU3nYUbBAEy4F0=;
        b=hU3Qp7q+L84+Bc11O5CF/NNqjXej7nGN3EXPHJOugiogNqEUATZftWY3zqYbSH88Bu
         OLBFflpyiE7WaBSF6v9ugJiBmwBa65ShS3/IbJJw8qwgtGagHbnXYAFvPGE4ltYDSbiK
         1ZeO3aDw+M8R8gflMCWm/n+uwSSM5qTFosU4mNPDAaaXYQ+Jrh+rzIMKGgFVbRZazbJc
         rUQV52eJsWzEUeF0THQhdDqzyr9cfglPos30Y1vTy1WSxi/8EAnEGiIlO0MBtX6eowDT
         7K3yCHhfCFnvfEoETEv999qlgzVx+MopABAdWbdqpC+QzKDgmuZ0i9xlQ5i+n066cu18
         omyQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=uUOAN7watDpAxDREqBm4Gm5B8qCscUU3nYUbBAEy4F0=;
        b=5CaqbdpDMaFBj5kEHN2HmfnJ0/1SZCgdsW5Gv/tKxHZJ/xyCBkBq15eXJiW8GMmQrK
         QV3UJiwn2lnmNBWJxPdey7faHBB6OqvT5pv0YRyeLcw8Kbd62MOVdSETRyBO5tkdYMmw
         DWM1hDSrfsAkxHErWHY4C+PMws7poXHTXbgRlOcZ5XLkXd4uUYgVmmQJwOaoAae5nnF/
         ptAKRSCiQ/Aoil58cXD8WScUAfEUvSa41Ivv5ujymi2YX6RCjCM7yviT0HvfNfzll5Dn
         CIlxCWpU1iwMdPhpT+4MKsJOEW8j/nLI5P83Ui8nxW7AVGno/geMIVgpFBUj1T3SJfKt
         fj1g==
X-Gm-Message-State: AOAM533gdQdUj5FKjYTMPN7VCta/QjCaSykNUR8K0BzCY8hPvKy0agI7
        0RocQlAN11SxW5JrN8Y9If8=
X-Google-Smtp-Source: ABdhPJzRZfsNNowFIloeTlB5KdvxDaJZbuMF/dWcr41q9FkJjHPAv1iVMXfXVW1f3VGgg+iS+Ou6qg==
X-Received: by 2002:aa7:956a:0:b0:447:96bd:8df5 with SMTP id x10-20020aa7956a000000b0044796bd8df5mr4971065pfq.35.1632827556481;
        Tue, 28 Sep 2021 04:12:36 -0700 (PDT)
Received: from linux.asia-northeast3-a.c.our-ratio-313919.internal (252.229.64.34.bc.googleusercontent.com. [34.64.229.252])
        by smtp.gmail.com with ESMTPSA id x5sm13966559pfq.136.2021.09.28.04.12.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 28 Sep 2021 04:12:36 -0700 (PDT)
Date:   Tue, 28 Sep 2021 11:12:31 +0000
From:   Hyeonggon Yoo <42.hyeyoo@gmail.com>
To:     Vlastimil Babka <vbabka@suse.cz>
Cc:     linux-mm@kvack.org, Christoph Lameter <cl@linux.com>,
        Pekka Enberg <penberg@kernel.org>,
        David Rientjes <rientjes@google.com>,
        Joonsoo Kim <iamjoonsoo.kim@lge.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        linux-kernel@vger.kernel.org
Subject: Re: [QUESTION] is SLAB considered legacy and deprecated?
Message-ID: <20210928111231.GA2596@linux.asia-northeast3-a.c.our-ratio-313919.internal>
References: <20210927090347.GA2533@linux.asia-northeast3-a.c.our-ratio-313919.internal>
 <8aa15f4b-71de-5283-5ebc-d8d1a323473d@suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <8aa15f4b-71de-5283-5ebc-d8d1a323473d@suse.cz>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Sep 27, 2021 at 07:03:19PM +0200, Vlastimil Babka wrote:
> On 9/27/21 11:03, Hyeonggon Yoo wrote:
> > Hello there,
> > 
> > I've been working on adding 'lockless cache' on sl[au]b for a while.
> > But what it actually does is actually adding 'queuing' on slub.
> 
> Yeah, I pointed out those threads from 2011 that called it exactly that...
> was there any conclusion why that was not ultimately merged?
>

It's best to ask Christoph, as he suggested to add queuing on slub.
Well, after reading old threads, I concluded that it was not merged
because Christoph stopped developing this.

To make sure that he stopped developing this, I searched
his name and sorted by date. [1]

Then I see Christoph's last response on SLUB + Queueing was:
Christopher Lameter Wrote:
	David Rientjes Wrote:
	> Overall, the results are _much_ better than the vanilla slub allocator
	> that I frequently saw ~20% regressions with the TCP_RR netperf benchmark
	> on a couple of my machines with larger cpu counts. However, there still
	> is a significant performance degradation compared to slab.

	It seems that the memory leak is still present. This likely skews the
	results. Thought I had it fixed. Thanks.

It was not merged on 2.6.37-rc1 at that time [2]
And after some time he worked on improving SLUB itself [3], [4], [5],
not SLUB with queuing. (anyway his work resulted in lots of improvement on
slub without queuing)

And in [4], Christoph Lameter wrote:
	Well here is another result of my obsession with SLAB allocators. There must be
	some way to get an allocator done that is faster without queueing and I hope
	that we are now there (maybe only almost...). Any help with cleaning up the
	rough edges would be appreciated.

So I guess he concluded that adding queuing on SLUB was not good idea
(again, it's best to ask him)

> > So there is a fundamental question coming into my mind:
> > 	'is SLAB considered legacy and deprecated?'
> 
> To some extend, but not yet in a sense where we would have a deadline to get
> rid of it. 

What makes you to say 'To some extent'?
That's what I'm curious about :)

> In some contexts it's still being preferred, AFAIK.

In what context is SLAB or SLUB is preferred?
And what is the core reason that SLUB is used by default?

> > It seems there are little development on SLAB and people think that
> > SLAB is legacy and deprecated, so CONFIG_SLUB is used by default.
> > 
> > But I think both has pros and cons for their own:
> > 	SLAB: more temporal locality (cache friendly)
> > 	but high usage of memory, and less spatial locality (TLB misses) than SLUB.
> > 
> > 	SLUB: less temporal locality (less cache friendly) than SLAB
> > 	but more spatial locality (TLB hit), and low usage of memory
> > 	and good debugging feature.
> 
> I'm not so sure about the usage of memory, SLUB can easily use more I
> believe. Instead of caching some arrays of objects it will have one or more
> private slabs per cpu, and the slabs are larger-order pages.
>

SLAB uses much memory than slab, when there are *lots* of NUMA nodes.
	because kmem_cache_node exist per node and it keeps alien cache
	(used for caching freeing object from remote node),
	so it keeps MAX_NUMANODES ^ 2 of array_cache per slab.
	that is why I said SLAB uses much memory than SLUB.

to quote Christoph Lameter's (who made SLUB and current maintainer) presentation in 2014:
	See link [6] for this
	p21: "SLAB queuing can get intensive memory usage going grows
	exponentially by NUMA node"

But I'm not sure if SLAB or SLUB is good on UMA architecture.

> > Why do people say SLAB is deprecated/legacy?
> 
> Do they?
>

Yes I think they do.

One example is presentation of David Rientjes (one of maintainers) in 2011:
	See link [7]
	p5: "SLAB is deprecated, very little development"
	p5: "Many distributions still ship with CONFIG_SLAB even
		though it is not the kernel default"

Anyway, I wanted to discuss the current status of SLAB.

To me, it seems that people do not work on SLAB lately
and it seems some maintainers (David, Christoph) think
it's better to move from SLAB to SLUB. one of them is Christoph himself.
As he made SLUB because he don't agree on design of SLAB. [8]

Thanks,
Hyeonggon.

Searching his name and sort by date
[1] https://lore.kernel.org/lkml/?q=Christoph+Lameter&o=10800

[GIT PULL] SLAB updates for 2.6.37-rc1 by Pekka Enberg
[2] https://lore.kernel.org/lkml/alpine.DEB.2.00.1010242005280.4447@tiger/#r

His work on lockless fastpath of slub (2011-02),
[3] https://lore.kernel.org/lkml/20110225173850.486326452@linux.com/

His work on lockless fastpath of slub (2011-06)
[4] https://lore.kernel.org/lkml/20110601172543.437240675@linux.com/

His work on per cpu partial lists
[5] https://lore.kernel.org/lkml/20110809211221.831975979@linux.com/

Christoph's presentation on slab
[6] - https://events.static.linuxfound.org/sites/events/files/slides/slaballocators.pdf

David's presentation on slab
[7] - https://www.socallinuxexpo.org/scale9x-media/scalemedia/scale/scale9x-media/simple_cfp/presentations/16_30-DavidRientjes-Status_of_the_Linux_Slab_Allocators.pdf

[8] SLUB: The unqueued slab allocator V6
https://lwn.net/Articles/229096/
