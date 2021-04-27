Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F3D7236C609
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Apr 2021 14:27:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235639AbhD0M1m (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 27 Apr 2021 08:27:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55748 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235410AbhD0M1i (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Apr 2021 08:27:38 -0400
Received: from mail-qk1-x72d.google.com (mail-qk1-x72d.google.com [IPv6:2607:f8b0:4864:20::72d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 70AB8C061574
        for <linux-kernel@vger.kernel.org>; Tue, 27 Apr 2021 05:26:54 -0700 (PDT)
Received: by mail-qk1-x72d.google.com with SMTP id k127so4076427qkc.6
        for <linux-kernel@vger.kernel.org>; Tue, 27 Apr 2021 05:26:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chrisdown.name; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=PYcA31V7XskJPAxgNF4CCjQEn63i1T7UnsYeovcLOww=;
        b=wE8L40gRP2X+ZjTns24WQMUjmZfSeQjLlkB1/7IpD++TK6FqvLS74oOV3Tp9xYGLof
         703xKXkcNEgVGBvQ7rq+yk2kbrCBR/X1zzQnRMfia8LmvT4bGO9a9pt5akosYClAep/1
         AQnR/fLUYER9dUM3g+RnLSOlDyI4EltIPfn9s=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=PYcA31V7XskJPAxgNF4CCjQEn63i1T7UnsYeovcLOww=;
        b=lbTfwB9PqO+3fO/d2ga+1AeDvk9YvZdHc95fkbrDIYZ1YbZlpDgcvw23Urcede75QM
         ORlJP8SMgrYf40YFFugKz7JOIWVunKJlVlkt0V8CPuXzcKicZ2/3W/OmK7KTW7Fh24z9
         RwGfLR5RWrwA0peMLiMUVNXGd3B+1RTdbzdj9XQZnn6INdax73qMhkAK9hITiQj+yKYH
         COYam1Fq6gHC5Eh+Lu+/s7yv2iejtog0nwCxwsjkxqtMNa3jN1zyP8lGffDwkvplDXBE
         rVEihvN9WECT+iasgk8poHxJc3Q1Tgo6Tv+8eNhFX7RE9FBUW81LehUC57sB6eaft96p
         CG1w==
X-Gm-Message-State: AOAM533yXyHZ77kWTGmkZLrrHlDngFJ/rEN2hUIgEFYHWHy40Dps84PO
        ofSXiOmhvEeFvjcWKAt1oBgDdVFFMMY/hHCxha0=
X-Google-Smtp-Source: ABdhPJzuY7SH7RUTnunb+VrRU2bwW0MMi9/TNKXd6WqhnTFo2DNjf6p1o04C9UJ17f0ObbNY0lXhVQ==
X-Received: by 2002:a37:9d0b:: with SMTP id g11mr7695158qke.355.1619526413441;
        Tue, 27 Apr 2021 05:26:53 -0700 (PDT)
Received: from localhost ([2620:10d:c091:480::1:5d5f])
        by smtp.gmail.com with ESMTPSA id b17sm13394562qto.88.2021.04.27.05.26.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 27 Apr 2021 05:26:53 -0700 (PDT)
Date:   Tue, 27 Apr 2021 13:26:51 +0100
From:   Chris Down <chris@chrisdown.name>
To:     Alexander Sosna <alexander@sosna.de>
Cc:     linux-mm@kvack.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Prevent OOM casualties by enforcing memcg limits
Message-ID: <YIgDCzmKaesjl8aU@chrisdown.name>
References: <ea6db5cc-f862-7c4b-d872-acb29c2d8193@sosna.de>
 <YIdWMC/iAdanDjLh@chrisdown.name>
 <410a58ba-d746-4ed6-a660-98b5f99258c3@sosna.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <410a58ba-d746-4ed6-a660-98b5f99258c3@sosna.de>
User-Agent: Mutt/2.0.6 (98f8cb83) (2021-03-06)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Alexander Sosna writes:
>> We don't guarantee that vm.overcommit_memory 2 means "no OOM killer". It
>> can still happen for a bunch of reasons, so I really hope PostgreSQL
>> isn't relying on that.
>>
>> Could you please be more clear about the "huge problem" being solved
>> here? I'm not seeing it.
>
>let me explain the problem I encounter and why I fell down the mm rabbit
>hole.  It is not a PostgreSQL specific problem but that's where I run
>into it.  PostgreSQL forks a backend for each client connection.  All
>backends have shared memory as well as local work memory.  When a
>backend needs more dynamic work_mem to execute a query, new memory
>is allocated.  It is normal that such an allocation can fail.  If the
>backend gets an ENOMEM the current query is rolled back an all dynamic
>work_mem is freed. The RDBMS stays operational an no other query is
>disturbed.
>
>When running in a memory cgroup - for example via systemd or on k8s -
>the kernel will not return ENOMEM even if the cgroup's memory limit is
>exceeded.  Instead the OOM killer is awakened and kills processes in the
>violating cgroup.  If any backend is killed with SIGKILL the shared
>memory of the whole cluster is deemed potentially corrupted and
>PostgreSQL needs to do an emergency restart.  This cancels all operation
>on all backends and it entails a potentially lengthy recovery process.
>Therefore the behavior is quite "costly".

My point that memory cgroups are completely overcommit agnostic isn't just a 
question of abstract semantics, but a practical one. Exceeding memory.max is 
not overcommitment, because overages are physical, not virtual, and that has 
vastly different ramifications in terms of what managing that overage means.

For example, if we aggressively ENOMEM at the memory.max bounds, there's no 
provision provided for the natural bounds of memory reclaim to occur. Now maybe 
your application likes that (which I find highly dubious), but from a memory 
balancing perspective it's just nonsensical: we need to ensure that we're 
assisting forward progress of the system at the cgroup level, especially with 
the huge amounts of slack generated.

>I totally understand that vm.overcommit_memory 2 does not mean "no OOM
>killer". IMHO it should mean "no OOM killer if we can avoid it" and I
>would highly appreciate if the kernel would use a less invasive means
>whenever possible.  I guess this might also be the expectation by many
>other users.  In my described case - which is a real pain for me - it is
>quite easy to tweak the kernel behavior in order to handle this and
>other similar situations with less casualties.  This is why I send a
>patch instead of starting a theoretical discussion.

vm.overcommit_memory=2 means "don't overcommit", nothing less, nothing more. 
Adding more semantics is a very good way to make an extremely confusing and 
overloaded API.

This commit reminds me of the comments on cosmetic products that say "no 
parabens". Ok, so there's no parabens -- great, parabens are terrible -- but 
are you now using a much more dangerous preservative instead?

Likewise, this commit claims that it reduces the likelihood of invoking the OOM 
killer -- great, nobody wants their processes to be OOM killed. What do we have 
instead? Code that calls off memory allocations way, way before it's needed to 
do so, and prevents the system from even getting into a state where it can 
efficiently evaluate how it should rebalance memory. That's really not a good 
tradeoff.

>What do you think is necessary to get this to an approvable quality?

The problem is not the code, it's the concept and the way it interacts with the 
rest of the mm subsystem. It asks the mm subsystem to deny memory allocations 
long before it has even had a chance to reliably rebalance (just as one 
example, to punt anon pages to swap) based on the new allocations, which 
doesn't make very much sense. It may not break in some highly trivial setups, 
but it certainly will not work well with stacking or machines with high 
volatility of the anon/file LRUs. You're also likely to see random ENOMEM 
failures from kernelspace when operating under this memcg context long before 
such a response was necessary, which doesn't make much sense.

If you want to know when to back off allocations, use memory.high with PSI 
pressure metrics.

I also would strongly suggest that vm.overcommit_memory=2 is the equivalent of 
using a bucket of ignited thermite to warm one's house.
