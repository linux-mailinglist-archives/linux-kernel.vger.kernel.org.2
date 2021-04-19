Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7E0ED364CE7
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Apr 2021 23:11:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240366AbhDSVMQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 19 Apr 2021 17:12:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50572 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232289AbhDSVMK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Apr 2021 17:12:10 -0400
Received: from mail-qk1-x729.google.com (mail-qk1-x729.google.com [IPv6:2607:f8b0:4864:20::729])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3FD1AC06174A
        for <linux-kernel@vger.kernel.org>; Mon, 19 Apr 2021 14:11:39 -0700 (PDT)
Received: by mail-qk1-x729.google.com with SMTP id y136so5255290qkb.1
        for <linux-kernel@vger.kernel.org>; Mon, 19 Apr 2021 14:11:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cmpxchg-org.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=kPOgD6C7v2B3aEHjJMDvlRbbnpG5eAvY8t4HD5c6Yis=;
        b=UlWrQYGza8aibZnqSYH/OqcDuvVsUUVBQcgNrU+9I1ijvOfKSrXrmSPsfS3Q+ISSeU
         bLQphTkHmGtTjpITmZRb5yABkr0e+MyWqnDYelz/IzjLDJPkknb4yhiSISEAxkPVXuQ8
         EbK7XbgKE94d6C/E5X7z3Wtr3KC5GhI8OSwlxl0XIbIMkrczsRO2ksmNhUKp5iy/AEWg
         crD3NfneUNuz6kHAtfpEfxWx2OrkJqA2tLKOOWX/Wbov8TyxF8/oS/VW74aqW4BdqGwO
         /dM3US/3owHiccUEwLP9jLRAJWTf5QOqAlhohiMnUCHMBUkOR+8Bb6p91ByyU68c6CJw
         j/mg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=kPOgD6C7v2B3aEHjJMDvlRbbnpG5eAvY8t4HD5c6Yis=;
        b=NbkkL09WdqE+TkNpaCGHWkOd7IBfOGXjgMGsueBSCG1feJ+Tg3H33fPb0E89JiUbye
         SgW8VsKKc7Mxq+hTP4iV/Q3d+gkXnjHJl29C51fejhe5F7rVNXTDPOmc6imI6pgfbB45
         PXMJHtsHb+40VJzulBIMfkfmCGyj3lNU3GvcxdM7HieqeHXkF6LGlpNixerGQzpCXY6L
         +BQbALn+f5JmPGIVAxILwtfOfEAIyRAKVpVkTTa5vkTd8Og2Yr3lb1UVHzJ4aRn4qjeV
         3nfPTFlGuBWFMW7Nh5VMyjcn9T0QiuD0neEqBVTW4twPZSsJmhBSrcGKpwAeFX8vQ/fL
         25uA==
X-Gm-Message-State: AOAM530glW9PWoApu+IMy2h2KHR5OUg4N1T6IzuvcptG6Fw72tQx1DhU
        J3bCAOD7K7rDcOtSjUb9e6nVMQ==
X-Google-Smtp-Source: ABdhPJx+8QKA7AkE7vpCKAo17/CK+jq9lSJriGKPFMrlgLdPnOmxYyJw8UzQZ2lGMnMtW2XGNBWwEw==
X-Received: by 2002:a37:9903:: with SMTP id b3mr1913227qke.17.1618866698526;
        Mon, 19 Apr 2021 14:11:38 -0700 (PDT)
Received: from localhost (70.44.39.90.res-cmts.bus.ptd.net. [70.44.39.90])
        by smtp.gmail.com with ESMTPSA id d207sm5796754qke.59.2021.04.19.14.11.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 19 Apr 2021 14:11:38 -0700 (PDT)
Date:   Mon, 19 Apr 2021 17:11:37 -0400
From:   Johannes Weiner <hannes@cmpxchg.org>
To:     Waiman Long <llong@redhat.com>
Cc:     Michal Hocko <mhocko@kernel.org>,
        Vladimir Davydov <vdavydov.dev@gmail.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Tejun Heo <tj@kernel.org>, Christoph Lameter <cl@linux.com>,
        Pekka Enberg <penberg@kernel.org>,
        David Rientjes <rientjes@google.com>,
        Joonsoo Kim <iamjoonsoo.kim@lge.com>,
        Vlastimil Babka <vbabka@suse.cz>, Roman Gushchin <guro@fb.com>,
        linux-kernel@vger.kernel.org, cgroups@vger.kernel.org,
        linux-mm@kvack.org, Shakeel Butt <shakeelb@google.com>,
        Muchun Song <songmuchun@bytedance.com>,
        Alex Shi <alex.shi@linux.alibaba.com>,
        Chris Down <chris@chrisdown.name>,
        Yafang Shao <laoar.shao@gmail.com>,
        Wei Yang <richard.weiyang@gmail.com>,
        Masayoshi Mizuma <msys.mizuma@gmail.com>,
        Xing Zhengjun <zhengjun.xing@linux.intel.com>,
        Matthew Wilcox <willy@infradead.org>
Subject: Re: [PATCH v4 1/5] mm/memcg: Move mod_objcg_state() to memcontrol.c
Message-ID: <YH3yCZn9EeSPKKGY@cmpxchg.org>
References: <20210419000032.5432-1-longman@redhat.com>
 <20210419000032.5432-2-longman@redhat.com>
 <YH2eT+JCII48hX80@cmpxchg.org>
 <ffb5705e-8629-808d-9d09-0c9c7f509326@redhat.com>
 <140444ea-14e7-b305-910f-f23fafe45488@redhat.com>
 <YH26RrMBOxLaMg4l@cmpxchg.org>
 <b7c8e209-3311-609b-9b61-5602a89a8313@redhat.com>
 <d1c36f26-b958-49e0-ae44-1cf6334fa4c5@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <d1c36f26-b958-49e0-ae44-1cf6334fa4c5@redhat.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Apr 19, 2021 at 01:26:29PM -0400, Waiman Long wrote:
> On 4/19/21 1:19 PM, Waiman Long wrote:
> > On 4/19/21 1:13 PM, Johannes Weiner wrote:
> > > The CONFIG_MEMCG_KMEM has become sort of useless now. It used to be
> > > configurable, but now it just means CONFIG_MEMCG && !CONFIG_SLOB. And
> > > even that doesn't make sense because while slob doesn't support slab
> > > object tracking, we can still do all the other stuff we do under
> > > KMEM. I have a patch in the works to remove the symbol and ifdefs.
> > > 
> > > With that in mind, it's better to group the functions based on what
> > > they do rather than based on CONFIG_MEMCG_KMEM. It's easier to just
> > > remove another ifdef later than it is to reorder the functions.
> > > 
> > OK, I will make the move then. Thanks for the explanation.

Thanks!

> BTW, have you ever thought of moving the cgroup-v1 specific functions out
> into a separate memcontrol-v1.c file just like kernel/cgroup/cgroup-v1.c?
> 
> I thought of that before, but memcontrol.c is a frequently changed file and
> so a bit hard to do.

I haven't looked too deeply at it so far, but I think it would make
sense to try.

There are indeed many of the entry paths from the MM code that are
shared between cgroup1 and cgroup2, with smaller branches here and
there to adjust behavior. Those would throw conflicts, but those we
should probably keep in the main memcontrol.c for readability anyway.

But there is also plenty of code that is exclusively about cgroup1,
and which actually doesn't change much in a long time. Moving that
elsewhere shouldn't create difficult conflicts - maybe a few line
offset warnings or fuzz in the diff context of unrelated changes:

- the soft limit tree and soft limit reclaim

- the threshold and oom event notification stuff

- the charge moving code

- remaining v1 interface files, as well as their helper functions

From a quick scan, this adds up to ~2,500 lines of old code with no
actual dependencies from the common code or from v2, and which could
be moved out of the way without disrupting ongoing development much.
