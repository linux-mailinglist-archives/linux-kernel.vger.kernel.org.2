Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3DE9C420045
	for <lists+linux-kernel@lfdr.de>; Sun,  3 Oct 2021 07:59:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229771AbhJCGBZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 3 Oct 2021 02:01:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41658 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229450AbhJCGBW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 3 Oct 2021 02:01:22 -0400
Received: from mail-pl1-x633.google.com (mail-pl1-x633.google.com [IPv6:2607:f8b0:4864:20::633])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 222CBC0613EC
        for <linux-kernel@vger.kernel.org>; Sat,  2 Oct 2021 22:59:34 -0700 (PDT)
Received: by mail-pl1-x633.google.com with SMTP id c4so8958169pls.6
        for <linux-kernel@vger.kernel.org>; Sat, 02 Oct 2021 22:59:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=V6ZpF0ldcg9/Zwn0MsKUAJuO0Q0m7PTHvpa800jV2eU=;
        b=SUBJOv0hJpW25/w/0H7o4VQDZUrQaddp3PnMiBC0/pDhk2tl+AC0CUCkmMF9c8q4hR
         YzU1L/gjFVebxBg4o8UNHJS0oW2lt6Ox+KipP61eT3HAEvF97YswazmBN/9DG0YKImky
         /bYOKyViZmB7GgeQx9WUkiT3BgP4uMraIGCxe2t2B3HShABeieEaJCuI2uDEfBTJSXnt
         eOpkZw4C7+cSMhJ3P4XNskLvnDexiXR5UO7PZpPDKnqTuOmyLzvdbf/0gFN6F1ZqHzcS
         Z7y6qL8yuqgiQActXrg2geePSbRq9H3sqZrH5Q239nDJ19KX5fVSq/pII15B2tHGmJSi
         5qMg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=V6ZpF0ldcg9/Zwn0MsKUAJuO0Q0m7PTHvpa800jV2eU=;
        b=ef2q9ApxCTNM3W572QoQuQtVfHbMWnER5lw4wFCm0xDtVS+0iKVaV0OyTXQpSDX0ta
         fMH6Vp0bogc5YO5ZA48OseCZ8aKtQ4R8VkxCbMWlw0PMGElh+1iUf5iytojhPwjEn+He
         pcVr1n3DGNLzNOmNhJpYWYIlXCBOEf2HnU0pMLV5hCM0qig3cfXPTvw9GNxf1v//5zxa
         I1hOqEWQ6uhHh155NvoiVkEbKTgcq4uenDMQdtkMoEB2/zjZdCByaEe5ZMvaStyHYDpd
         mUNcDLT1MxBIjzGuCNUnlno7gsESt/RpNZZIIT6goH25zKy3PGzHS3uKK3R1pvxCkCND
         px+A==
X-Gm-Message-State: AOAM5323UuQyrIAPfLKRfkp8uvLrLy8PD4zbDnqCF+yPwcJmgg8OUEsm
        Dk/p3FOQM+IaQqVxXzO9Xj76/IhW19I=
X-Google-Smtp-Source: ABdhPJxClbyiHt1sAptjEyfBFYqa+wH2au+Q4Uy6ljYVjvU1gH48iivEn1s/Pxt9kslYiv6d3jt4ag==
X-Received: by 2002:a17:902:be0c:b0:13e:2b53:d3 with SMTP id r12-20020a170902be0c00b0013e2b5300d3mr17236543pls.86.1633240773651;
        Sat, 02 Oct 2021 22:59:33 -0700 (PDT)
Received: from linux.asia-northeast3-a.c.our-ratio-313919.internal (252.229.64.34.bc.googleusercontent.com. [34.64.229.252])
        by smtp.gmail.com with ESMTPSA id x13sm10274230pfp.133.2021.10.02.22.59.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 02 Oct 2021 22:59:33 -0700 (PDT)
Date:   Sun, 3 Oct 2021 05:59:28 +0000
From:   Hyeonggon Yoo <42.hyeyoo@gmail.com>
To:     Vlastimil Babka <vbabka@suse.cz>
Cc:     linux-mm@kvack.org, Christoph Lameter <cl@linux.com>,
        Pekka Enberg <penberg@kernel.org>,
        David Rientjes <rientjes@google.com>,
        Joonsoo Kim <iamjoonsoo.kim@lge.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        linux-kernel@vger.kernel.org
Subject: Re: [QUESTION] is SLAB considered legacy and deprecated?
Message-ID: <20211003055928.GA7643@linux.asia-northeast3-a.c.our-ratio-313919.internal>
References: <20210927090347.GA2533@linux.asia-northeast3-a.c.our-ratio-313919.internal>
 <8aa15f4b-71de-5283-5ebc-d8d1a323473d@suse.cz>
 <20210928111231.GA2596@linux.asia-northeast3-a.c.our-ratio-313919.internal>
 <b3c5bd9a-5fbc-8388-a4ab-6c20864dc7c6@suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <b3c5bd9a-5fbc-8388-a4ab-6c20864dc7c6@suse.cz>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello Vlastimil! I'm happy to discuss with you.
I hope this discussion to make us think about slab allocator.

On Fri, Oct 01, 2021 at 04:07:56PM +0200, Vlastimil Babka wrote:
> >> In some contexts it's still being preferred, AFAIK.
> > 
> > In what context is SLAB or SLUB is preferred?
> 
> I don't know the full answer. With our distro we have used SLAB, and
> switched to SLUB after verifying that there are no major regressions.
> Better debugging features were perhaps the major reason.
>

> > And what is the core reason that SLUB is used by default?
> 
> The usual reason in MM, nobody objected :)
> https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=a0acd82080768
>

What was the decision based on ? performance measurements or anything
else? 'Because nobody objected' is not a good reason to make a decision.

>>>> So there is a fundamental question coming into my mind:
>>>>     'is SLAB considered legacy and deprecated?'
>>>
>>> To some extend, but not yet in a sense where we would have a deadline to get
>>> rid of it.
>>>
>> What makes you to say 'To some extent'?
>> That's what I'm curious about :)

> "To some extent" because SLUB is default and if some new stuff was added
> that only worked with SLUB and not SLAB, there wouldn't be major
> objections expected.

You said new features are added to only SLUB and there are no
objections expected, But what makes you to do so?

You are not saying why. what you are saying is just only result.
What is the mind behind maintaining SLUB and neglecting SLAB?

is SLUB really next-generation slab allocator that can ultimately replace SLAB?
if so, why not just drop SLAB?
if not, why not maintain SLAB?

> >>> It seems there are little development on SLAB and people think that
> >>> SLAB is legacy and deprecated, so CONFIG_SLUB is used by default.
> >>>
> >>> But I think both has pros and cons for their own:
> >>> 	SLAB: more temporal locality (cache friendly)
> >>> 	but high usage of memory, and less spatial locality (TLB misses) than SLUB.
> >>>
> >>> 	SLUB: less temporal locality (less cache friendly) than SLAB
> >>> 	but more spatial locality (TLB hit), and low usage of memory
> >>> 	and good debugging feature.
> >>
> >> I'm not so sure about the usage of memory, SLUB can easily use more I
> >> believe. Instead of caching some arrays of objects it will have one or more
> >> private slabs per cpu, and the slabs are larger-order pages.
> >>
> > 
> > SLAB uses much memory than slab, when there are *lots* of NUMA nodes.
> > 	because kmem_cache_node exist per node and it keeps alien cache
> > 	(used for caching freeing object from remote node),
> > 	so it keeps MAX_NUMANODES ^ 2 of array_cache per slab.
> > 	that is why I said SLAB uses much memory than SLUB.
> 
> Maybe, theoretically. But SLUB has per-cpu partial lists caching whole
> slab pages, not just arrays of objects. Number of cpus will generally
> grow with number of NUMA nodes.
> 

Sorry, it was my mistake. I mean SLAB uses much memory than SLUB when
there are lots of NUMA nodes. in SLAB, there is alien_cache to batch
freeing objects from remote node. and alien cache has space complexity
of MAX_NUMNODES ^ 2. That's why I said SLAB uses much memory.

> > to quote Christoph Lameter's (who made SLUB and current maintainer) presentation in 2014:
> > 	See link [6] for this
> > 	p21: "SLAB queuing can get intensive memory usage going grows
> > 	exponentially by NUMA node"
> > 
> > But I'm not sure if SLAB or SLUB is good on UMA architecture.
> >

And that is one of reasons why Christoph made SLUB [8]

> >>> Why do people say SLAB is deprecated/legacy?
> >>
> >> Do they?
> >>
> > 
> > Yes I think they do.
> > 
> > One example is presentation of David Rientjes (one of maintainers) in 2011:
> > 	See link [7]
> > 	p5: "SLAB is deprecated, very little development"
> > 	p5: "Many distributions still ship with CONFIG_SLAB even
> > 		though it is not the kernel default"
> > 
> > Anyway, I wanted to discuss the current status of SLAB.
> > 
> > To me, it seems that people do not work on SLAB lately
> > and it seems some maintainers (David, Christoph) think
> > it's better to move from SLAB to SLUB. one of them is Christoph himself.
> > As he made SLUB because he don't agree on design of SLAB. [8]
> 
> Right.
> Here's the discussion from the last time SLAB removal was proposed and
> rejected, feel free to evaluate if the points there are still valid today:
> 
> https://lore.kernel.org/all/20190410024714.26607-1-tobin@kernel.org/
>

I think the points are still valid because on some workloads SLAB works
better. especially when alloc/frees are intensive, SLUB tends to become
bottleneck.

If we can't drop SLAB, it should be at least maintained :(
But it has been neglected for a long time, which makes people not to
use SLAB. Nobody likes to use a subsystem that isn't maintained.

Anyway, I'm curious about share of SLAB and SLUB and on what situations
SLAB or SLUB is preferred. that information would help maintain both.

Thanks,
Hyeonggon

> > Thanks,
> > Hyeonggon.
> > 
> > Searching his name and sort by date
> > [1] https://lore.kernel.org/lkml/?q=Christoph+Lameter&o=10800
> > 
> > [GIT PULL] SLAB updates for 2.6.37-rc1 by Pekka Enberg
> > [2] https://lore.kernel.org/lkml/alpine.DEB.2.00.1010242005280.4447@tiger/#r
> > 
> > His work on lockless fastpath of slub (2011-02),
> > [3] https://lore.kernel.org/lkml/20110225173850.486326452@linux.com/
> > 
> > His work on lockless fastpath of slub (2011-06)
> > [4] https://lore.kernel.org/lkml/20110601172543.437240675@linux.com/
> > 
> > His work on per cpu partial lists
> > [5] https://lore.kernel.org/lkml/20110809211221.831975979@linux.com/
> > 
> > Christoph's presentation on slab
> > [6] - https://events.static.linuxfound.org/sites/events/files/slides/slaballocators.pdf
> > 
> > David's presentation on slab
> > [7] - https://www.socallinuxexpo.org/scale9x-media/scalemedia/scale/scale9x-media/simple_cfp/presentations/16_30-DavidRientjes-Status_of_the_Linux_Slab_Allocators.pdf
> > 
> > [8] SLUB: The unqueued slab allocator V6
> > https://lwn.net/Articles/229096/
> > 
> 
