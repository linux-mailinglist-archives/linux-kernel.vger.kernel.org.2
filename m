Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8133435CF49
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Apr 2021 19:15:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240702AbhDLRPU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 12 Apr 2021 13:15:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34906 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243509AbhDLRPS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Apr 2021 13:15:18 -0400
Received: from mail-qk1-x730.google.com (mail-qk1-x730.google.com [IPv6:2607:f8b0:4864:20::730])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B49B6C061574
        for <linux-kernel@vger.kernel.org>; Mon, 12 Apr 2021 10:14:59 -0700 (PDT)
Received: by mail-qk1-x730.google.com with SMTP id o5so15034089qkb.0
        for <linux-kernel@vger.kernel.org>; Mon, 12 Apr 2021 10:14:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cmpxchg-org.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=mztj3YmmozSjsP7YF+63NXvn93gX18LsCcbiTCMKvuY=;
        b=AgXmby4EVK1M9TaU93B0tvhyMIuWu1mucIXPlFBgZh+Uei4TlJqKcr4+2w0hcxhqKg
         Ni687E83GTPBCZY6MUE7ZFFPAPV7SaFYPuEoWz3bq6lrWz8yJ43FT8cjzI1l69D3n+ij
         pwLRZDACu8Y/WOnVkI7/P1+TuM8HbDZ0ZIOLIUQCKPu5nPz2p3+WLDs5FOrehowpd++b
         XMd3QZJdoCGZb+owWdzYXdfRV/LiuxOIcP9e2S8qMoJH/5VgqgPxksHCuoK4O4ZKwHTC
         6eArC8aBWrX9Jt4uLHQqqV7uR4wkMEcD7SY+laxxtsqUyIvZ3Zr/esGFEuOGWZEt2kz3
         LMsQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=mztj3YmmozSjsP7YF+63NXvn93gX18LsCcbiTCMKvuY=;
        b=WS8BeT/AYxGZpeLyMW72BqB4HlGTVsBHKVXRJ4niDibSBe474usZlMvOnS4QLMe3iF
         AhdPmcnM1vE/V1MwJtq736q08vBIR34lBbv6GDYSzFC0W968M4qoRDXKTzcNtluHoz2r
         2zu/lR7lxqYoWjCwxWWQ/UmDrgIH6OaXzk1kYEbPM3fCXuJ2x/dspRemxI635l+y9xUb
         xyLp2PBG3Rs0ChO28GiVTo5w+J0RaIPNyqVBwgc5Y/QKYwnYqLqtnwBrAkAxnJ1pqGdq
         gTiWCEM0ca+t1ZFn9bEH8I0Vb5kT9fVJW+LM1p14Z8HDxVZTr5oRzMlDqIwXKemY3Hfd
         HSrg==
X-Gm-Message-State: AOAM533VgqqBwnw+OtGMFu1pNCFrytkPgKfM5iJXRTLa3dAhbre9qlF/
        BRlDn5Wlu/iQTa+cJjb18xRWuQ==
X-Google-Smtp-Source: ABdhPJzvnpOuvYh0cOa1StH86GYB6t9o7Bd+ieLigHO1L6X8LfilAKfKSk5JVsXaFyfgTECudYTAhA==
X-Received: by 2002:a37:63ce:: with SMTP id x197mr13758669qkb.341.1618247698869;
        Mon, 12 Apr 2021 10:14:58 -0700 (PDT)
Received: from localhost (70.44.39.90.res-cmts.bus.ptd.net. [70.44.39.90])
        by smtp.gmail.com with ESMTPSA id z7sm8156745qkf.136.2021.04.12.10.14.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 12 Apr 2021 10:14:58 -0700 (PDT)
Date:   Mon, 12 Apr 2021 13:14:57 -0400
From:   Johannes Weiner <hannes@cmpxchg.org>
To:     Roman Gushchin <guro@fb.com>
Cc:     Muchun Song <songmuchun@bytedance.com>, mhocko@kernel.org,
        akpm@linux-foundation.org, shakeelb@google.com,
        vdavydov.dev@gmail.com, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, duanxiongchun@bytedance.com,
        fam.zheng@bytedance.com, bsingharora@gmail.com,
        shy828301@gmail.com, alex.shi@linux.alibaba.com
Subject: Re: [RFC PATCH v2 00/18] Use obj_cgroup APIs to charge the LRU pages
Message-ID: <YHSAETyyXMkygPhn@cmpxchg.org>
References: <20210409122959.82264-1-songmuchun@bytedance.com>
 <YHD/itVJlgzE2uXm@carbon.dhcp.thefacebook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YHD/itVJlgzE2uXm@carbon.dhcp.thefacebook.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Apr 09, 2021 at 06:29:46PM -0700, Roman Gushchin wrote:
> On Fri, Apr 09, 2021 at 08:29:41PM +0800, Muchun Song wrote:
> > Since the following patchsets applied. All the kernel memory are charged
> > with the new APIs of obj_cgroup.
> > 
> > 	[v17,00/19] The new cgroup slab memory controller
> > 	[v5,0/7] Use obj_cgroup APIs to charge kmem pages
> > 
> > But user memory allocations (LRU pages) pinning memcgs for a long time -
> > it exists at a larger scale and is causing recurring problems in the real
> > world: page cache doesn't get reclaimed for a long time, or is used by the
> > second, third, fourth, ... instance of the same job that was restarted into
> > a new cgroup every time. Unreclaimable dying cgroups pile up, waste memory,
> > and make page reclaim very inefficient.
> > 
> > We can convert LRU pages and most other raw memcg pins to the objcg direction
> > to fix this problem, and then the LRU pages will not pin the memcgs.
> > 
> > This patchset aims to make the LRU pages to drop the reference to memory
> > cgroup by using the APIs of obj_cgroup. Finally, we can see that the number
> > of the dying cgroups will not increase if we run the following test script.
> > 
> > ```bash
> > #!/bin/bash
> > 
> > cat /proc/cgroups | grep memory
> > 
> > cd /sys/fs/cgroup/memory
> > 
> > for i in range{1..500}
> > do
> > 	mkdir test
> > 	echo $$ > test/cgroup.procs
> > 	sleep 60 &
> > 	echo $$ > cgroup.procs
> > 	echo `cat test/cgroup.procs` > cgroup.procs
> > 	rmdir test
> > done
> > 
> > cat /proc/cgroups | grep memory
> > ```
> > 
> > Patch 1 aims to fix page charging in page replacement.
> > Patch 2-5 are code cleanup and simplification.
> > Patch 6-18 convert LRU pages pin to the objcg direction.
> > 
> > Any comments are welcome. Thanks.
> 
> Indeed the problem exists for a long time and it would be nice to fix it.
> However I'm against merging the patchset in the current form (there are some
> nice fixes/clean-ups, which can/must be applied independently). Let me explain
> my concerns:
> 
> Back to the new slab controller discussion obj_cgroup was suggested by Johannes
> as a union of two concepts:
> 1) reparenting (basically an auto-pointer to a memcg in c++ terms)
> 2) byte-sized accounting
> 
> I was initially against this union because I anticipated that the reparenting
> part will be useful separately. And the time told it was true.

"The idea of moving stocks and leftovers to the memcg_ptr/obj_cgroup
level is really good."

https://lore.kernel.org/lkml/20191025200020.GA8325@castle.DHCP.thefacebook.com/

If you recall, the main concern was how the byte charging interface
was added to the existing page charging interface, instead of being
layered on top of it. I suggested to do that and, since there was no
other user for the indirection pointer, just include it in the API.

It made sense at the time, and you seemed to agree. But I also agree
it makes sense to factor it out now that more users are materializing.

> I still think obj_cgroup API must be significantly reworked before being
> applied outside of the kmem area: reparenting part must be separated
> and moved to the cgroup core level to be used not only in the memcg
> context but also for other controllers, which are facing similar problems.
> Spilling obj_cgroup API in the current form over all memcg code will
> make it more complicated and will delay it, given the amount of changes
> and the number of potential code conflicts.
> 
> I'm working on the generalization of obj_cgroup API (as described above)
> and expect to have some patches next week.

Yeah, splitting the byte charging API from the reference API and
making the latter cgroup-generic makes sense. I'm looking forward to
your patches.

And yes, the conflicts between that work and Muchun's patches would be
quite large. However, most of them would come down to renames, since
the access rules and refcounting sites will remain the same, so it
shouldn't be too bad to rebase Muchun's patches on yours. And we can
continue reviewing his patches for correctness for now.

Thanks
