Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AAAD5381FB7
	for <lists+linux-kernel@lfdr.de>; Sun, 16 May 2021 18:13:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230453AbhEPQPI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 16 May 2021 12:15:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54688 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229437AbhEPQPH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 16 May 2021 12:15:07 -0400
Received: from mail-pj1-x102a.google.com (mail-pj1-x102a.google.com [IPv6:2607:f8b0:4864:20::102a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 90DAAC061573
        for <linux-kernel@vger.kernel.org>; Sun, 16 May 2021 09:13:52 -0700 (PDT)
Received: by mail-pj1-x102a.google.com with SMTP id pf4-20020a17090b1d84b029015ccffe0f2eso4255609pjb.0
        for <linux-kernel@vger.kernel.org>; Sun, 16 May 2021 09:13:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:from:to:cc:references:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=dlfMqv9wfrGJ82dGdPYDeZ8xiu5IJiVrMvefg8fg1h0=;
        b=OG/wbGXafii2uuL2ViZem+b+tSNCCwrA42+zMs+79hdTr6lyCSx4vySbm+hwv5JHN3
         Uoo4zpZZHFspu77OhK35a2pDrSkC5pPo3dfo/KdrTwNagH3WoWjH6vuHH16a0YjbJ4ID
         Wq7G+7TLzl66GT7xIn/lMChmkNIzuY8ZScEP940+tGAO6pSWYsrDY8wDLVuulpXLy04b
         xfb+BYk/5v/8LZvHamrAchsEvF4LPlzDpeDCfrCn/JCodU1cXs1AQ8xr2QkmNHWMKRNp
         4qdyp8nMc3LzEa+PGrPjH7bymK+Oap+k+NO418r0HrDavO+jFFq+3VQkSmGxKpv/cHoc
         UyCg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:from:to:cc:references:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=dlfMqv9wfrGJ82dGdPYDeZ8xiu5IJiVrMvefg8fg1h0=;
        b=IxiMN83IAg8C7tpDfvUJ81K1wAJ4hD/+ngk6zijOYgVN49nzIq8vNR7xrlAEkdXZk0
         4LHk3mV9T2QK6e2xrby7E7UyDKENfBW3lG7Mz0SVSn9cBeeoL046rY8Qve++k7rNYYcB
         plhcFaBdJ8A2Fddo4f0/e/Kxg59eyvFJPT1CFj6Y9QY+uYT0WlFMpKGrevJwrS2U9gu7
         nLPSz9fmiTegDHMd387lCBviLibYjSG8/h1c2y9xjqh845MHSJVA0Ub9XGZe76qonXRw
         xBz+6z9COFrW4rolhTq/Q6QSIz54z6+hQixw2v21/yA4rYAU7fy5f5I+sDizotYsnqEp
         bmJA==
X-Gm-Message-State: AOAM5334qoq16zuKjapMVsMaLB5GWq/iiPWFzKicc789ezhS5teYsNTv
        HyCrfnNBMi52dJ5Dfis5wBE=
X-Google-Smtp-Source: ABdhPJxze5aQgQw4bgIhABio1KoTULA2u8EBkiqDYbtNPv9gs5mrJigXuIFtBcDE0zXmbkpeNEBPCA==
X-Received: by 2002:a17:902:b18f:b029:ec:7ac0:fd1a with SMTP id s15-20020a170902b18fb02900ec7ac0fd1amr56232059plr.84.1621181632031;
        Sun, 16 May 2021 09:13:52 -0700 (PDT)
Received: from [10.230.29.202] ([192.19.223.252])
        by smtp.gmail.com with ESMTPSA id k15sm8258105pfi.0.2021.05.16.09.13.44
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 16 May 2021 09:13:51 -0700 (PDT)
Subject: Re: alloc_contig_range() with MIGRATE_MOVABLE performance regression
 since 4.9
From:   Florian Fainelli <f.fainelli@gmail.com>
To:     David Hildenbrand <david@redhat.com>,
        Michal Hocko <mhocko@suse.com>
Cc:     Vlastimil Babka <vbabka@suse.cz>, Mel Gorman <mgorman@suse.de>,
        Minchan Kim <minchan@kernel.org>,
        Johannes Weiner <hannes@cmpxchg.org>, l.stach@pengutronix.de,
        LKML <linux-kernel@vger.kernel.org>,
        Jaewon Kim <jaewon31.kim@samsung.com>,
        Michal Nazarewicz <mina86@mina86.com>,
        Joonsoo Kim <iamjoonsoo.kim@lge.com>,
        Oscar Salvador <OSalvador@suse.com>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>
References: <dbdf7b8c-9165-f87c-92d4-cfb5a4f01221@gmail.com>
 <YIEqpIOAyrs26soC@dhcp22.suse.cz>
 <8919b724-ce5b-a80f-bbea-98b99af97357@redhat.com>
 <58726a6b-5468-a6b4-7c26-371ef5d71ee2@gmail.com>
 <9df905cf-cc4f-c739-26cb-c2e5c6e5a234@redhat.com>
 <a0420344-4d9b-8e90-69cd-b0de20d683e0@gmail.com>
Message-ID: <a15bd5c9-870d-3824-99cc-e5073d4d42a1@gmail.com>
Date:   Sun, 16 May 2021 09:13:41 -0700
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Firefox/78.0 Thunderbird/78.10.1
MIME-Version: 1.0
In-Reply-To: <a0420344-4d9b-8e90-69cd-b0de20d683e0@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 4/22/2021 12:31 PM, Florian Fainelli wrote:
>> For
>>
>> https://lkml.kernel.org/r/20210121175502.274391-3-minchan@kernel.org
>>
>> to do its work you'll have to pass  __GFP_NORETRY to
>> alloc_contig_range(). This requires CMA adaptions, from where we call
>> alloc_contig_range().
> 
> Yes, I did modify the alloc_contig_range() caller to pass GFP_KERNEL |
> __GFP_NORETRY. I did run for a more iterations (1000) and the results
> are not very conclusive as with __GFP_NORETRY the allocation time per
> allocation was not significantly better, in fact it was slightly worse
> by 100us than without.
> 
> My x86 VM with 1GB of DRAM including 512MB being in ZONE_MOVABLE does
> shows identical numbers for both 4.9 and 5.4 so this must be something
> specific to ARM64 and/or the code we added to create a ZONE_MOVABLE on
> that architecture since movablecore does not appear to have any effect
> unlike x86.

We tracked down the slowdowns to be caused by two major contributors:

- for a reason that we do not fully understand yet the same cpufreq
governor (conservative) did not cause alloc_contig_range() to be slowed
down on 4.9 as much as it it with 5.4, running tests with the
performance cpufreq governor works a tad better and the results are more
consistent from run to run with a smaller variation.

- another large contributor to the slowdown was having enabled
CONFIG_IRQSOFF_TRACER. After c3bc8fd637a9623f5c507bd18f9677effbddf584
("tracing: Centralize preemptirq tracepoints and unify their usage") we
now prepare arguments for tracing even if we end-up not using them since
tracing is not enabled at runtime. Getting the caller function's return
address is cheap on arm64 for level == 0, but getting the preceding
caller involves doing a backtrace walk which is expensive (see
arch/arm64/kernel/return_address.c).

So with these two variables eliminated we are only about x2 slower on
5.4 than we were on 4.9 and this is acceptable for our use case. I would
not say the case is closed but at least we understand it better. We now
have 5.10 brought up to speed so any new investigation will be focused
on that kernel.

Thanks a lot for your help David!
-- 
Florian
