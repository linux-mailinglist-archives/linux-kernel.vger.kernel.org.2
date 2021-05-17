Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E68AC3825A0
	for <lists+linux-kernel@lfdr.de>; Mon, 17 May 2021 09:46:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235334AbhEQHre (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 17 May 2021 03:47:34 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:53356 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S231787AbhEQHrd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 May 2021 03:47:33 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1621237577;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=oW3LzEcy6xhREj6wjyfZMKHY6gt96o4WsFjzrVstiLo=;
        b=QuCL3B8suBxuTTqw+Xgx/ADfOp9Xv2Cvl0U5grI9CpcR6DKrA86dAPftRPB83pw46KIOhg
        tWAhZg0jh7HOZBRY7escjf9c6vQAJuvQdG8k0noGSYmFHYokdNQ8Dd6viwIYJ16bn1qjFE
        ObLMe5qkq5cCYt4bmGY3Zk7tjnpVq8U=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-423-51a54doqMlSq815_HPeq-w-1; Mon, 17 May 2021 03:46:15 -0400
X-MC-Unique: 51a54doqMlSq815_HPeq-w-1
Received: by mail-wm1-f72.google.com with SMTP id g206-20020a1c39d70000b029016ac627fbe9so1094072wma.9
        for <linux-kernel@vger.kernel.org>; Mon, 17 May 2021 00:46:15 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:organization
         :message-id:date:user-agent:mime-version:in-reply-to
         :content-language:content-transfer-encoding;
        bh=oW3LzEcy6xhREj6wjyfZMKHY6gt96o4WsFjzrVstiLo=;
        b=phQ4iqy1nclDW+ItQizet1XWK2xqICqPXYp9FJSBYFvZvaTuO/7+wfZ87sVjcQ8k9g
         LxvyjygAQoW8PAtpySXnYMJo7fNodk2l3DpsIAv8BHaKYgnV5nXuB7JVU1LmffaGhWsh
         OulNIH8bf0nk/R0CYSfk/zM/AgAke1GqaCetp2J+gsDJ1DaKZJGeaC89btyj1u1NX5Cp
         vRZ8U5hL/LMv8P93GMgiLQqHtts72HPwaEpDItS4DzEDvYVsWe3khihyjxa9Xe8EB4Rf
         ORA/MmdM+OjNxGHcHocFGqTBUDXQQFiKFGSwVlKuygaarMHa0cOEQGc0Fds8EGsTaY+Q
         xd0g==
X-Gm-Message-State: AOAM533of1At7tIRZtze2UbNw/vE8t6RYkTVPL17qD4XJX6q2Jp/bImp
        XVmij1RbqP6lO88Mu+pPO6g4KofPz4wkmdfJwV4LQG/KIJRxBIW6GVf22KJ58BMPMOsYkQrQOI7
        swM+++FlHign8CFA54+tE+xyP
X-Received: by 2002:a5d:438c:: with SMTP id i12mr26903792wrq.44.1621237574409;
        Mon, 17 May 2021 00:46:14 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJwROdnuXYbqFLPiHMKE8n+P0duVXjs1e5WKix8FiCyLOl1Qa/HiqWLT3lnItQNHmk8XZbmiTQ==
X-Received: by 2002:a5d:438c:: with SMTP id i12mr26903768wrq.44.1621237574201;
        Mon, 17 May 2021 00:46:14 -0700 (PDT)
Received: from [192.168.3.132] (p5b0c6833.dip0.t-ipconnect.de. [91.12.104.51])
        by smtp.gmail.com with ESMTPSA id f4sm16730658wrz.33.2021.05.17.00.46.13
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 17 May 2021 00:46:13 -0700 (PDT)
Subject: Re: alloc_contig_range() with MIGRATE_MOVABLE performance regression
 since 4.9
To:     Florian Fainelli <f.fainelli@gmail.com>,
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
 <a15bd5c9-870d-3824-99cc-e5073d4d42a1@gmail.com>
From:   David Hildenbrand <david@redhat.com>
Organization: Red Hat
Message-ID: <d2bf87c0-7a2d-d663-a0ac-99840c77cd44@redhat.com>
Date:   Mon, 17 May 2021 09:46:12 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.10.1
MIME-Version: 1.0
In-Reply-To: <a15bd5c9-870d-3824-99cc-e5073d4d42a1@gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 16.05.21 18:13, Florian Fainelli wrote:
> 
> 
> On 4/22/2021 12:31 PM, Florian Fainelli wrote:
>>> For
>>>
>>> https://lkml.kernel.org/r/20210121175502.274391-3-minchan@kernel.org
>>>
>>> to do its work you'll have to pass  __GFP_NORETRY to
>>> alloc_contig_range(). This requires CMA adaptions, from where we call
>>> alloc_contig_range().
>>
>> Yes, I did modify the alloc_contig_range() caller to pass GFP_KERNEL |
>> __GFP_NORETRY. I did run for a more iterations (1000) and the results
>> are not very conclusive as with __GFP_NORETRY the allocation time per
>> allocation was not significantly better, in fact it was slightly worse
>> by 100us than without.
>>
>> My x86 VM with 1GB of DRAM including 512MB being in ZONE_MOVABLE does
>> shows identical numbers for both 4.9 and 5.4 so this must be something
>> specific to ARM64 and/or the code we added to create a ZONE_MOVABLE on
>> that architecture since movablecore does not appear to have any effect
>> unlike x86.
> 
> We tracked down the slowdowns to be caused by two major contributors:
> 
> - for a reason that we do not fully understand yet the same cpufreq
> governor (conservative) did not cause alloc_contig_range() to be slowed
> down on 4.9 as much as it it with 5.4, running tests with the
> performance cpufreq governor works a tad better and the results are more
> consistent from run to run with a smaller variation.

Interesting! So your CPU is down-clocking while performing (heavy) 
kernel work? Is that expected or are we mis-accounting kernel cpu time 
somehow when it comes to determining the CPU target frequency?

> 
> - another large contributor to the slowdown was having enabled
> CONFIG_IRQSOFF_TRACER. After c3bc8fd637a9623f5c507bd18f9677effbddf584
> ("tracing: Centralize preemptirq tracepoints and unify their usage") we
> now prepare arguments for tracing even if we end-up not using them since
> tracing is not enabled at runtime. Getting the caller function's return
> address is cheap on arm64 for level == 0, but getting the preceding
> caller involves doing a backtrace walk which is expensive (see
> arch/arm64/kernel/return_address.c).

Again, very interesting finding.

> 
> So with these two variables eliminated we are only about x2 slower on
> 5.4 than we were on 4.9 and this is acceptable for our use case. I would
> not say the case is closed but at least we understand it better. We now
> have 5.10 brought up to speed so any new investigation will be focused
> on that kernel.
> 

Thanks for the insight, please do let me know when you learn more. x2 
slowdown still is quite a lot.

-- 
Thanks,

David / dhildenb

