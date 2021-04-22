Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0950E36869E
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Apr 2021 20:35:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238621AbhDVSgL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 22 Apr 2021 14:36:11 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:24238 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S236885AbhDVSgK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Apr 2021 14:36:10 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1619116534;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=Kz4vXeVMATI5AQeq6XpCZGiPxgizORCRtbXEta792G4=;
        b=cX13f+NGzcOadQ7wdRRqWedh/VOwCBGlCL4SENoNtkQC/PHz3ojcwE7Z19bw7Fhtm5/laB
        BF0kCCv2GTjt4wzMVhMcpDQuU+XvGBjfhAO0yLA+QGI6/yvd4fdOrfau3sBGW2XbtrGbUq
        nhxCVNo+m3ndR4deCHyW4ZAmW9U5jnU=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-82-5Wfn_JUwOD2-WazJGY2q-g-1; Thu, 22 Apr 2021 14:35:30 -0400
X-MC-Unique: 5Wfn_JUwOD2-WazJGY2q-g-1
Received: by mail-wr1-f71.google.com with SMTP id y13-20020adfdf0d0000b02901029a3bf796so14173878wrl.15
        for <linux-kernel@vger.kernel.org>; Thu, 22 Apr 2021 11:35:30 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:organization
         :message-id:date:user-agent:mime-version:in-reply-to
         :content-language:content-transfer-encoding;
        bh=Kz4vXeVMATI5AQeq6XpCZGiPxgizORCRtbXEta792G4=;
        b=jkJHJC5Ckk0e2LIvkcUs8cYi1yNOv+te75HZcaAd45fcRTIyxWzQCiifnx1GRyFxxt
         4wwmpKX8vd+8+t324XkUPhn8n8duCN2Dnqj+MJR2txOmIWzT2gMN6yqldc35sHVwTbhI
         n4o5+HAmf/upaDNQHLJ7k4zkx89Bh74nWTitw0xXYE5uLyDWCsHX2AZOHD1JZOObYky/
         8DJrDSjN8xbk5rH860ttSStYsImqUuUnWMjvLYuzryHUY3saDge5sfgA0mqZ13ZW/2SA
         0ZBudry1c24AD364SihkeRaDFPfMKiccFWqLCDLLKMSihd71KyzfJCfGsRvskXeqLJBg
         vQeA==
X-Gm-Message-State: AOAM531hJ1AxHd1al0W8RXI1U68h0uBtGASpfqUY1f6T/EAMREfFndHa
        09dW1vKzOsEfq0LePvB1/ou9Ez/etdjYBT7uhzW4YkYNvclYipnQzbkj57Cg+MHlhiHJQKqHy9M
        +OuWeb4bQO86YneWAPHdBunFP
X-Received: by 2002:a7b:c7d2:: with SMTP id z18mr1455027wmk.104.1619116529161;
        Thu, 22 Apr 2021 11:35:29 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJwAQZUObyiz3i0vFyBT/BBrWAuuzWOPOI6zmgVJXEKCC41h1S9PCHMY1r7uTMpOj+cwsvgJ1w==
X-Received: by 2002:a7b:c7d2:: with SMTP id z18mr1455002wmk.104.1619116528914;
        Thu, 22 Apr 2021 11:35:28 -0700 (PDT)
Received: from [192.168.3.132] (p4ff23eb0.dip0.t-ipconnect.de. [79.242.62.176])
        by smtp.gmail.com with ESMTPSA id v4sm5350524wrf.36.2021.04.22.11.35.27
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 22 Apr 2021 11:35:28 -0700 (PDT)
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
From:   David Hildenbrand <david@redhat.com>
Organization: Red Hat
Message-ID: <9df905cf-cc4f-c739-26cb-c2e5c6e5a234@redhat.com>
Date:   Thu, 22 Apr 2021 20:35:27 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.1
MIME-Version: 1.0
In-Reply-To: <58726a6b-5468-a6b4-7c26-371ef5d71ee2@gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 22.04.21 19:50, Florian Fainelli wrote:
> 
> 
> On 4/22/2021 1:56 AM, David Hildenbrand wrote:
>> On 22.04.21 09:49, Michal Hocko wrote:
>>> Cc David and Oscar who are familiar with this code as well.
>>>
>>> On Wed 21-04-21 11:36:01, Florian Fainelli wrote:
>>>> Hi all,
>>>>
>>>> I have been trying for the past few days to identify the source of a
>>>> performance regression that we are seeing with the 5.4 kernel but not
>>>> with the 4.9 kernel on ARM64. Testing something newer like 5.10 is a bit
>>>> challenging at the moment but will happen eventually.
>>>>
>>>> What we are seeing is a ~3x increase in the time needed for
>>>> alloc_contig_range() to allocate 1GB in blocks of 2MB pages. The system
>>>> is idle at the time and there are no other contenders for memory other
>>>> than the user-space programs already started (DHCP client, shell, etc.).
>>
>> Hi,
>>
>> If you can easily reproduce it might be worth to just try bisecting;
>> that could be faster than manually poking around in the code.
>>
>> Also, it would be worth having a look at the state of upstream Linux.
>> Upstream Linux developers tend to not care about minor performance
>> regressions on oldish kernels.
> 
> This is a big pain point here and I cannot agree more, but until we
> bridge that gap, this is not exactly easy to do for me unfortunately and
> neither is bisection :/
> 
>>
>> There has been work on improving exactly the situation you are
>> describing -- a "fail fast" / "no retry" mode for alloc_contig_range().
>> Maybe it tackles exactly this issue.
>>
>> https://lkml.kernel.org/r/20210121175502.274391-3-minchan@kernel.org
>>
>> Minchan is already on cc.
> 
> This patch does not appear to be helping, in fact, I had locally applied
> this patch from way back when:
> 
> https://lkml.org/lkml/2014/5/28/113
> 
> which would effectively do this unconditionally. Let me see if I can
> showcase this problem a x86 virtual machine operating in similar
> conditions to ours.

How exactly are you allocating these 2MiB blocks?

Via CMA->alloc_contig_range() or via alloc_contig_range() directly? I 
assume via CMA.

For

https://lkml.kernel.org/r/20210121175502.274391-3-minchan@kernel.org

to do its work you'll have to pass  __GFP_NORETRY to 
alloc_contig_range(). This requires CMA adaptions, from where we call 
alloc_contig_range().

-- 
Thanks,

David / dhildenb

