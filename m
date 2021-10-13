Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 384BB42B3CB
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Oct 2021 05:45:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237301AbhJMDrA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 12 Oct 2021 23:47:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42550 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231253AbhJMDq6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Oct 2021 23:46:58 -0400
Received: from mail-pg1-x533.google.com (mail-pg1-x533.google.com [IPv6:2607:f8b0:4864:20::533])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3609BC061570
        for <linux-kernel@vger.kernel.org>; Tue, 12 Oct 2021 20:44:56 -0700 (PDT)
Received: by mail-pg1-x533.google.com with SMTP id m21so972036pgu.13
        for <linux-kernel@vger.kernel.org>; Tue, 12 Oct 2021 20:44:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=NPYgrbf9559QlllyAfgrfZzaAR2G3z6MzzMdSacYVDk=;
        b=qwTDO27q1hmN0i8E5OebUw3Fy9WikHhwEqwRQbWYg4iX56IgsvfOa6W/qc7Vx8NqX2
         06Ifc3jggJa20HFM5uC8YZzDvrfDLkoul9BRvEQUSp91LPxehHsAKYUDvaREEkGsJO4E
         akWnsEFPMol2kigezE/0fUWBPt+FKXxgD+rE2dwNuT5F5FF+kywYzcBVaok940z8IMhY
         ZWf7aSlBlqvtG6+8oLeK7J8yWgqbBLNzZWnmCYShdL509863gKLKTezy7bhMzn5okr/F
         m2oeGfO9E7f5ueN5PT+5rF9GHTEMKjyILFwzbJSB8NkbKCpm8ezO/fMa5D9GWfWS08wM
         niAA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=NPYgrbf9559QlllyAfgrfZzaAR2G3z6MzzMdSacYVDk=;
        b=AahrN3+FHAMuzQkgMVSqk+1t0Yn9qa+IbrLdbfIr2Pco9gsMOnc/FYlqupQ4UsVk02
         i0AUs1PA3MisNd4pwj2lhw+rtDLgYV+JqR1lp0BNOI9SuFNz99X+hi0+zR4u815YJzo8
         HKViBb8R3JeWPDrfY+SQSLF7BirjouL1cHaLoDVoKpUm2kLKlZSxb8rAJsL2uaWMJo62
         5LZtEX7kpM7JoxnuECE0l+zzuKemn6D4TJhufjcoU7dMXPN4fAEXqLBU8QFyLmc0BM76
         4aIKlZaijRCOe84Yp2Oioavn+cymQUK3r5OA59TwlZAeajc56iuy1PeBWLpBCL0iogzD
         /tJw==
X-Gm-Message-State: AOAM532t05vw+vtRVEd+61YZwVs5SKeJ0c1W9mL/T55OgsLSFz5eFxW7
        VItwmNcAp1Pw+ZzXpEMFb94=
X-Google-Smtp-Source: ABdhPJxvkBaMJi8cGjDOfMO7F/noVX+3tEWo5xolEbY8oKD+sSwF8+K5HXuaD6vx5S8NX8ty8nJ6OA==
X-Received: by 2002:a05:6a00:8d0:b0:44c:26e6:1c13 with SMTP id s16-20020a056a0008d000b0044c26e61c13mr35896493pfu.28.1634096694122;
        Tue, 12 Oct 2021 20:44:54 -0700 (PDT)
Received: from kvm.asia-northeast3-a.c.our-ratio-313919.internal (24.151.64.34.bc.googleusercontent.com. [34.64.151.24])
        by smtp.gmail.com with ESMTPSA id m11sm12888291pga.27.2021.10.12.20.44.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 12 Oct 2021 20:44:53 -0700 (PDT)
Date:   Wed, 13 Oct 2021 03:44:49 +0000
From:   Hyeonggon Yoo <42.hyeyoo@gmail.com>
To:     Christoph Lameter <cl@gentwo.de>
Cc:     linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        Pekka Enberg <penberg@kernel.org>,
        David Rientjes <rientjes@google.com>,
        Joonsoo Kim <iamjoonsoo.kim@lge.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Vlastimil Babka <vbabka@suse.cz>
Subject: Re: [RFC] Some questions and an idea on SLUB/SLAB
Message-ID: <20211013034449.GA118049@kvm.asia-northeast3-a.c.our-ratio-313919.internal>
References: <20211009001903.GA3285@kvm.asia-northeast3-a.c.our-ratio-313919.internal>
 <alpine.DEB.2.22.394.2110110909150.130815@gentwo.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <alpine.DEB.2.22.394.2110110909150.130815@gentwo.de>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


Hello Christoph, thank you for answering.

On Mon, Oct 11, 2021 at 09:13:52AM +0200, Christoph Lameter wrote:
> On Sat, 9 Oct 2021, Hyeonggon Yoo wrote:
> 
> >  - Is there a reason that SLUB does not implement cache coloring?
> >    it will help utilizing hardware cache. Especially in block layer,
> >    they are literally *squeezing* its performance now.
> 
> Well as Matthew says: The high associativity of caches 

it seems not useful on my both machines (4-way / 8-way set associative) too.

> and the execution
> of other code path seems to make this not useful anymore.
> 
> I am sure you can find a benchmark that shows some benefit. But please
> realize that in real-life the OS must perform work. This means that
> multiple other code paths are executed that affect cache use and placement
> of data in cache lines.
> 

cache coloring can make benchmark results better. But as slab uses more
cache lines - that reduces other code paths' cache line. Did I get right?

> 
> >  - In SLAB, do we really need to flush queues every few seconds?
> >    (per cpu queue and shared queue). Flushing alien caches makes
> >    sense, but flushing queues seems reducing it's fastpath.
> >    But yeah, we need to reclaim memory. can we just defer this?
> 
> The queues are designed to track cache hot objects (See the Bonwick
> paper). After a while the cachelines will be used for other purposes and
> no longer reflect what is in the caches. That is why they need to be
> expired.

I've read Bonwick paper but I thought expiring was need for reclaiming
memory. maybe I got it wrong.. I should read it again.

> 
> 
> >   - I don't like SLAB's per-node cache coloring, because L1 cache
> >     isn't shared between cpus. For now, cpus in same node are sharing
> >     its colour_next - but we can do better.
> 
> This differs based on the cpu architecture in use. SLAB has an ideal model
> of how caches work and keeps objects cache hot based on that. In real life
> the cpu architecture differs from what SLAB things how caches operate.
> 

So the point is, As cache hierarchy differs based on architecture,
assuming cpus have both unique cache per cpu, and shared cache among
cpus can misfit in some architectures.

> >     what about splitting some per-cpu variables into kmem_cache_cpu
> >     like SLUB? I think cpu_cache, colour (and colour_next),
> >     alloc{hit,miss}, and free{hit,miss} can be per-cpu variables.
> 
> That would in turn increase memory use and potentially the cache footprint
> of the hot paths.
>

I thought splitting percpu data was need for coloring but it
isn't useful. So that's unnecessary cost.

Thanks,
Hyeonggon.
