Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B703C368638
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Apr 2021 19:50:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236881AbhDVRu4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 22 Apr 2021 13:50:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52964 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236459AbhDVRuy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Apr 2021 13:50:54 -0400
Received: from mail-pl1-x636.google.com (mail-pl1-x636.google.com [IPv6:2607:f8b0:4864:20::636])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BF605C06174A
        for <linux-kernel@vger.kernel.org>; Thu, 22 Apr 2021 10:50:19 -0700 (PDT)
Received: by mail-pl1-x636.google.com with SMTP id h20so23922946plr.4
        for <linux-kernel@vger.kernel.org>; Thu, 22 Apr 2021 10:50:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=mHPTQE74w3DtNKeE2TE1/pjpjT0CSeqdv53WlGy0hDQ=;
        b=mILJom+SKX4TA5KYv0mFQTTG17Kln7uTFsbB5oyHTJPzxDm9CMv0VIszYPsjLdJLMQ
         MFbE9/OiZMWGR0SAUou1hmtDXXcaJ01WAomfESUsJLytRd7tGFZcK1jq8zv4ns41Y27h
         ZY8Hz+Swd/ZYnyq38fLJqHi+2z0r6O0MLdMtzHGWimoFZL4DwlGJWtzV/JtENH23ihRI
         dAIytvEzffbKeOIr8oDXhqKqTBzPpeKjBxUsl4/4s/ByhkPOw2GRTMMSiNNRH0yCcVml
         7Ridpgnno2gmdrCDUyqJy1Q1QXzEu0vieaeZ/Oqj04synlY0xsYhUYOSel1UIhmM3gwX
         1RBQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=mHPTQE74w3DtNKeE2TE1/pjpjT0CSeqdv53WlGy0hDQ=;
        b=QLlWEeKAbKN/x+AmLeMrCneucpM8tun/NCV0Ih4af8Q4+Qm6bRl7T75AMTLSvqWl6n
         BIy5TX/gUw319hq4B11/IhIE9CA6Hs2Ri338NK0DaOynf0lQrkX9xiax/D85hcHu9SG5
         ISpIiW9ccEQxNXdl6qFtEFqz0Dsh/n4VOaRT90Eo92v6Riip5IN6iyabDv/A20uSXTG9
         1HBXbIfSi2xqsnEXWCK0GDynEVVg5UvB9+oe8IBbn/qqONPkjHy0A+U2Vk13wHGeCroE
         GZxt3TUiSAp4jiqmfhY2GKtH21OUUWwLpbYyomcLnBDVe5K/mDUMCCcZTF078MBSplcB
         C+Bw==
X-Gm-Message-State: AOAM531PKquEfPNX7f8yD25JymDaSsjJyfj9JUOU6DL1ZcztczEPkcPE
        hDgixKkJPB06/MBw3ZKuKPw=
X-Google-Smtp-Source: ABdhPJxtYCEOdLx6RKAsSSL3wbA+A9IrX2IKUBGe4YZLDiAdgHYYFHj3MB1IuDMyASrkQonPSHhBeA==
X-Received: by 2002:a17:90a:a60b:: with SMTP id c11mr5168848pjq.125.1619113819245;
        Thu, 22 Apr 2021 10:50:19 -0700 (PDT)
Received: from [10.230.29.202] ([192.19.223.252])
        by smtp.gmail.com with ESMTPSA id t21sm2577207pfg.211.2021.04.22.10.50.17
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 22 Apr 2021 10:50:18 -0700 (PDT)
Subject: Re: alloc_contig_range() with MIGRATE_MOVABLE performance regression
 since 4.9
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
From:   Florian Fainelli <f.fainelli@gmail.com>
Message-ID: <58726a6b-5468-a6b4-7c26-371ef5d71ee2@gmail.com>
Date:   Thu, 22 Apr 2021 10:50:16 -0700
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Firefox/78.0 Thunderbird/78.9.0
MIME-Version: 1.0
In-Reply-To: <8919b724-ce5b-a80f-bbea-98b99af97357@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 4/22/2021 1:56 AM, David Hildenbrand wrote:
> On 22.04.21 09:49, Michal Hocko wrote:
>> Cc David and Oscar who are familiar with this code as well.
>>
>> On Wed 21-04-21 11:36:01, Florian Fainelli wrote:
>>> Hi all,
>>>
>>> I have been trying for the past few days to identify the source of a
>>> performance regression that we are seeing with the 5.4 kernel but not
>>> with the 4.9 kernel on ARM64. Testing something newer like 5.10 is a bit
>>> challenging at the moment but will happen eventually.
>>>
>>> What we are seeing is a ~3x increase in the time needed for
>>> alloc_contig_range() to allocate 1GB in blocks of 2MB pages. The system
>>> is idle at the time and there are no other contenders for memory other
>>> than the user-space programs already started (DHCP client, shell, etc.).
> 
> Hi,
> 
> If you can easily reproduce it might be worth to just try bisecting;
> that could be faster than manually poking around in the code.
> 
> Also, it would be worth having a look at the state of upstream Linux.
> Upstream Linux developers tend to not care about minor performance
> regressions on oldish kernels.

This is a big pain point here and I cannot agree more, but until we
bridge that gap, this is not exactly easy to do for me unfortunately and
neither is bisection :/

> 
> There has been work on improving exactly the situation you are
> describing -- a "fail fast" / "no retry" mode for alloc_contig_range().
> Maybe it tackles exactly this issue.
> 
> https://lkml.kernel.org/r/20210121175502.274391-3-minchan@kernel.org
> 
> Minchan is already on cc.

This patch does not appear to be helping, in fact, I had locally applied
this patch from way back when:

https://lkml.org/lkml/2014/5/28/113

which would effectively do this unconditionally. Let me see if I can
showcase this problem a x86 virtual machine operating in similar
conditions to ours.

> 
> (next time, please cc linux-mm on core-mm questions; maybe you tried,
> but ended up with linux-mmc :) )

Yes that was the intent, thanks for correcting that.

> 
>>>
>>> I have tried playing with the compact_control structure settings but
>>> have not found anything that would bring us back to the performance of
>>> 4.9. More often than not, we see test_pages_isolated() returning an
>>> non-zero error code which would explain the slow down, since we have
>>> some logic that re-tries the allocation if alloc_contig_range() returns
>>> -EBUSY. If I remove the retry logic however, we don't get -EBUSY and we
>>> get the results below:
>>>
>>> 4.9 shows this:
>>>
>>> [  457.537634] allocating: size: 1024MB avg: 59172 (us), max: 137306
>>> (us), min: 44859 (us), total: 591723 (us), pages: 512, per-page: 115
>>> (us)
>>> [  457.550222] freeing: size: 1024MB avg: 67397 (us), max: 151408 (us),
>>> min: 52630 (us), total: 673974 (us), pages: 512, per-page: 131 (us)
>>>
>>> 5.4 show this:
>>>
>>> [  222.388758] allocating: size: 1024MB avg: 156739 (us), max: 157254
>>> (us), min: 155915 (us), total: 1567394 (us), pages: 512, per-page:
>>> 306 (us)
>>> [  222.401601] freeing: size: 1024MB avg: 209899 (us), max: 210085 (us),
>>> min: 209749 (us), total: 2098999 (us), pages: 512, per-page: 409 (us)
>>>
>>> This regression is not seen when MIGRATE_CMA is specified instead of
>>> MIGRATE_MOVABLE.
>>>
>>> A few characteristics that you should probably be aware of:
>>>
>>> - There is 4GB of memory populated with the memory being mapped into the
>>> CPU's address starting at space at 0x4000_0000 (1GB), PAGE_SIZE is 4KB
>>>
>>> - there is a ZONE_DMA32 that starts at 0x4000_0000 and ends at
>>> 0xE480_0000, from there on we have a ZONE_MOVABLE which is comprised of
>>> 0xE480_0000 - 0xfdc00000 and another range spanning 0x1_0000_0000 -
>>> 0x1_4000_0000
>>>
>>> Attached is the kernel configuration.
>>>
>>> Thanks!
>>> -- 
>>> Florian
>>
>>
>>
> 
> 

-- 
Florian
