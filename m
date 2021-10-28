Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2119943D921
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Oct 2021 04:04:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229791AbhJ1CG6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 27 Oct 2021 22:06:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33134 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229534AbhJ1CG5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Oct 2021 22:06:57 -0400
Received: from mail-wm1-x330.google.com (mail-wm1-x330.google.com [IPv6:2a00:1450:4864:20::330])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 02E19C061570
        for <linux-kernel@vger.kernel.org>; Wed, 27 Oct 2021 19:04:31 -0700 (PDT)
Received: by mail-wm1-x330.google.com with SMTP id z81-20020a1c7e54000000b0032cc97975e4so3806730wmc.4
        for <linux-kernel@vger.kernel.org>; Wed, 27 Oct 2021 19:04:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chrisdown.name; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=OSitA3a4YdoD7AVvtO/o5ytce1HdqvvgQyY7x4m623Y=;
        b=mmf9O/JyqVE44qprYmMNGB3KgytgDnVfCtOffK2ETwkIff5iwuA63uXVFF9fc1CcVV
         aAOattZGuBHK/u+qPj1f5rqPo884LJ1BMCHq2cpFc7ObzD1mwH0oevizG+xM0tPlRW1E
         W534UqCvIDA7nR5gucRUoyBPfTVTt2zbdJPCI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=OSitA3a4YdoD7AVvtO/o5ytce1HdqvvgQyY7x4m623Y=;
        b=mRzzWescZmryC8O1kqMQM4wB3WqOLsjYbzEcatEFAtrp2yAjFBmlXadyOdy0LJle/O
         7jn3+hJKPwG8UPH/gt8RtSFUXFoK4Xs/upX47+SCkGDoYduGLIlrBHheL2IlmGB9vsyI
         OsJ+Yxtak8F1ZWOlewBDVxv/TbkCRZhNp3BeE0WtrMf2jx41cxTMt5L8qnqrFvmqGqbY
         164ys69miYoMUQ+0osQYmaIDKVCBZTQnN9wbydQnMbN3EfB3sGid3B7Du44t/iPPe4pU
         bmMLpXwWjxkpWq0NXanVKv5dJ8/o0N5Q8l6qi2tsy8iUqm97KeRO6KtmZ2yG7oRT47s4
         OHxw==
X-Gm-Message-State: AOAM530ksNu73+6JiAzo+w5g8Floyf/SZgSEL8u19d0aKWsnoWltan20
        EY7O067h8fuR4wSrPRxdUjKl4A==
X-Google-Smtp-Source: ABdhPJz3Grg0PQlE13IjsjxOMWSf+DeGi0+RpvMssd352w2yaCF0NIt1b5uV5UBX3LOKD5LdGqRviQ==
X-Received: by 2002:a05:600c:2145:: with SMTP id v5mr1357440wml.182.1635386669578;
        Wed, 27 Oct 2021 19:04:29 -0700 (PDT)
Received: from localhost ([2620:10d:c093:400::5:5833])
        by smtp.gmail.com with ESMTPSA id l21sm5068138wms.16.2021.10.27.19.04.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 27 Oct 2021 19:04:29 -0700 (PDT)
Date:   Thu, 28 Oct 2021 03:04:28 +0100
From:   Chris Down <chris@chrisdown.name>
To:     Zhaoyang Huang <huangzhaoyang@gmail.com>
Cc:     Michal Hocko <mhocko@suse.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Vladimir Davydov <vdavydov.dev@gmail.com>,
        Zhaoyang Huang <zhaoyang.huang@unisoc.com>,
        "open list:MEMORY MANAGEMENT" <linux-mm@kvack.org>,
        LKML <linux-kernel@vger.kernel.org>
Subject: Re: [RFC PATCH] mm: have kswapd only reclaiming use min protection
 on memcg
Message-ID: <YXoFLAGzihy20P+l@chrisdown.name>
References: <1635318110-1905-1-git-send-email-huangzhaoyang@gmail.com>
 <YXj9w+8Bwlkz5PRy@dhcp22.suse.cz>
 <CAGWkznHVHVBrQEiO32p2uX_5BDUMc1fE64KuV34WJfpwC_23Pw@mail.gmail.com>
 <YXkNJjD4axYlmqQ5@dhcp22.suse.cz>
 <CAGWkznHrZ=Y3kG5j5aYdTV2294QGrQbM6251zcdGphzCGUP6dw@mail.gmail.com>
 <YXk9a3X62vNTyvGE@dhcp22.suse.cz>
 <CAGWkznEZhPxgb_K2vcfyhnGufPMaX3ksxbJvQSurwkNtLKRTGg@mail.gmail.com>
 <YXlGhEDYtnKtwKUb@dhcp22.suse.cz>
 <CAGWkznGp8Z9F8wK5UN+1Z-5NwQjZ+okpVfnq9-Gzv38xHPEDrQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <CAGWkznGp8Z9F8wK5UN+1Z-5NwQjZ+okpVfnq9-Gzv38xHPEDrQ@mail.gmail.com>
User-Agent: Mutt/2.1.3 (987dde4c) (2021-09-10)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Zhaoyang Huang writes:
>On Wed, Oct 27, 2021 at 8:31 PM Michal Hocko <mhocko@suse.com> wrote:
>>
>> On Wed 27-10-21 20:05:30, Zhaoyang Huang wrote:
>> > On Wed, Oct 27, 2021 at 7:52 PM Michal Hocko <mhocko@suse.com> wrote:
>> > >
>> > > On Wed 27-10-21 17:19:56, Zhaoyang Huang wrote:
>> > > > On Wed, Oct 27, 2021 at 4:26 PM Michal Hocko <mhocko@suse.com> wrote:
>> > > > >
>> > > > > On Wed 27-10-21 15:46:19, Zhaoyang Huang wrote:
>> > > > > > On Wed, Oct 27, 2021 at 3:20 PM Michal Hocko <mhocko@suse.com> wrote:
>> > > > > > >
>> > > > > > > On Wed 27-10-21 15:01:50, Huangzhaoyang wrote:
>> > > > > > > > From: Zhaoyang Huang <zhaoyang.huang@unisoc.com>
>> > > > > > > >
>> > > > > > > > For the kswapd only reclaiming, there is no chance to try again on
>> > > > > > > > this group while direct reclaim has. fix it by judging gfp flag.
>> > > > > > >
>> > > > > > > There is no problem description (same as in your last submissions. Have
>> > > > > > > you looked at the patch submission documentation as recommended
>> > > > > > > previously?).
>> > > > > > >
>> > > > > > > Also this patch doesn't make any sense. Both direct reclaim and kswapd
>> > > > > > > use a gfp mask which contains __GFP_DIRECT_RECLAIM (see balance_pgdat
>> > > > > > > for the kswapd part)..
>> > > > > > ok, but how does the reclaiming try with memcg's min protection on the
>> > > > > > alloc without __GFP_DIRECT_RECLAIM?
>> > > > >
>> > > > > I do not follow. There is no need to protect memcg if the allocation
>> > > > > request doesn't have __GFP_DIRECT_RECLAIM because that would fail the
>> > > > > charge if a hard limit is reached, see try_charge_memcg and
>> > > > > gfpflags_allow_blocking check.
>> > > > >
>> > > > > Background reclaim, on the other hand never breaches reclaim protection.
>> > > > >
>> > > > > What is the actual problem you want to solve?
>> > > > Imagine there is an allocation with gfp_mask & ~GFP_DIRECT_RECLAIM and
>> > > > all processes are under cgroups. Kswapd is the only hope here which
>> > > > however has a low efficiency of get_scan_count. I would like to have
>> > > > kswapd work as direct reclaim in 2nd round which will have
>> > > > protection=memory.min.
>> > >
>> > > Do you have an example where this would be a practical problem? Atomic
>> > > allocations should be rather rare.
>> > Please find below for the search result of '~__GFP_DIRECT_RECLAIM'
>> > which shows some drivers and net prefer to behave like that.
>> > Furthermore, the allocations are always together with high order.
>>
>> And what is the _practical_ problem you are seeing or trying to solve?
>We do have out of tree code behave like this and want to make the
>mechanics more robust

It does one no good to use concepts like "robustness" in an unsubstantiated, 
unmeasured, and unquantified way. Either provide the measurements and tell us 
why we should care about those measurements, or there's very little to discuss.

As it is this is a ten-deep thread where Michal has asked several perfectly 
reasonable questions and has received only a flimsy pastiche of discussion as a 
reply. Please provide tangible, hard data with reasons we should care about it.

With that said, there's no way we're going to change core mm behaviour based on 
the whims of poorly behaved out of tree drivers.
