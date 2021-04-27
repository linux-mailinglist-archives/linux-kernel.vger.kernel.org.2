Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 79DDB36C64B
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Apr 2021 14:46:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236469AbhD0Mqz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 27 Apr 2021 08:46:55 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:24127 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S236332AbhD0Mqy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Apr 2021 08:46:54 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1619527570;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=Hksqsg/+fYJgnfwVftoEYR0ZtkMbPnUNSSTSXlz+2vM=;
        b=NyTeJHKpeej95zDrlczlKwiy0eq38NE+ykWj61JlGPdxdMciRnFXszJdt5mb0GtlnBHpuz
        65R60AkOn499uCAvbWUcjItOOalgwjidlzjnNzoeCuLByRhMgvj9FQdbMi6zv8O7PCcXCs
        eZ9EZ3nCOePdvftzU9vHi2/kYRFs15s=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-531-ceOFgnhLMnWNJF9fFI5OVw-1; Tue, 27 Apr 2021 08:46:08 -0400
X-MC-Unique: ceOFgnhLMnWNJF9fFI5OVw-1
Received: by mail-wm1-f72.google.com with SMTP id o18-20020a1ca5120000b02901333a56d46eso4007479wme.8
        for <linux-kernel@vger.kernel.org>; Tue, 27 Apr 2021 05:46:08 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:to:cc:references:from:organization:subject
         :message-id:date:user-agent:mime-version:in-reply-to
         :content-language:content-transfer-encoding;
        bh=Hksqsg/+fYJgnfwVftoEYR0ZtkMbPnUNSSTSXlz+2vM=;
        b=e2kibCJajaE0G2Ng9hojnzhgVA+73SgBRndgvJDmPs9iucsR8a1uLVknifAzU7OPLr
         0SBxuMDSv/Rk53T2WfMa82qef8Qr9y6S3oKwllFg9LGit1ooyNzM2LVbet8ZpHYZy9B6
         BPS7323FVJmsjrpe5jfLGoAEQH7I1iR5O7MpJSzVZh80eHjeTwk+Wx6qLW19Pf0/ELsE
         0z9MXfjTxZ/uLBiD3u17ctXZkQocKFQRp0Iofyk5HETn5BSibI5bUos0gcPweP8gA/Xv
         JLrXCEmLfWuGobW8ra2obrrvANFN8iuWEXAB6YN4GUrCnSoo6zcYMfRq6X9486XNCTBv
         kTyw==
X-Gm-Message-State: AOAM533beBIon296ulPeVmhtiCythEc1cTRyAh2ysVinSWkx5qqLi86C
        sJwc5smblXATKmzpwVZVlGjMJtaQf3zD/t1bYIGsmoLc+edq7Aqvkt1cwFdyGaG9DJ2vuvszK4j
        q7qk5foS0/OWDde1KmT+dbt6/
X-Received: by 2002:a5d:4cc1:: with SMTP id c1mr29737346wrt.291.1619527567634;
        Tue, 27 Apr 2021 05:46:07 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJwXAByV9LoODF4QKZww/QfS7aasYO7weAeY5ZC9MriJsvGwv3uvieCWGjXfIy5U9hskI4MSNg==
X-Received: by 2002:a5d:4cc1:: with SMTP id c1mr29737320wrt.291.1619527567408;
        Tue, 27 Apr 2021 05:46:07 -0700 (PDT)
Received: from ?IPv6:2003:d8:2f38:2400:62f4:c5fa:ba13:ac32? (p200300d82f38240062f4c5faba13ac32.dip0.t-ipconnect.de. [2003:d8:2f38:2400:62f4:c5fa:ba13:ac32])
        by smtp.gmail.com with ESMTPSA id g5sm3841603wrq.30.2021.04.27.05.46.06
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 27 Apr 2021 05:46:06 -0700 (PDT)
To:     "lipeifeng@oppo.com" <lipeifeng@oppo.com>,
        Vlastimil Babka <vbabka@suse.cz>,
        peifengl55 <peifengl55@gmail.com>,
        schwidefsky <schwidefsky@de.ibm.com>,
        "heiko.carstens" <heiko.carstens@de.ibm.com>,
        zhangshiming <zhangshiming@oppo.com>,
        zhouhuacai <zhouhuacai@oppo.com>,
        guoweichao <guoweichao@oppo.com>, guojian <guojian@oppo.com>
Cc:     linux-s390 <linux-s390@vger.kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        linux-mm <linux-mm@kvack.org>
References: <20210414023803.937-1-lipeifeng@oppo.com>
 <a7bb16c0-31b2-6aa5-2186-8c957955649e@suse.cz>
 <c289b9dc-1259-c829-8ee4-1bee94d7d73d@redhat.com>
 <2021042611194631963076@oppo.com>
 <7dcc87f5-9ae5-613a-0cf4-820334592b90@redhat.com>
 <20210426181947189100132@oppo.com>
From:   David Hildenbrand <david@redhat.com>
Organization: Red Hat
Subject: Re: [RFC] mm: support multi_freearea to the reduction of external
 fragmentation
Message-ID: <9808e36a-9e4e-d1e2-da49-beb567681a8b@redhat.com>
Date:   Tue, 27 Apr 2021 14:46:06 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.1
MIME-Version: 1.0
In-Reply-To: <20210426181947189100132@oppo.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 26.04.21 12:19, lipeifeng@oppo.com wrote:
> Hi David Hildenbrand <mailto:david@redhat.com>：
> 
>  >> And you don't mention what the baseline configuration was. For example,
>  >> how was compaction configured?
>  >> Just to clarify, what is monkey?
>  >> Monkey HTTP server? MonkeyTest disk benchmark? UI/Application Exerciser
>  >> Monkey?
> -------------------------------------------------------------------------------------
> I am sorry that i didn't  give a clear explanation about Monkey.
> It meant  "UI/Application Exerciser Monkey" from google.
> 
> Excuse me, let me introduce our test:
> 

Thanks for more details on the test.

> 1. record COMPACT_STALL
> We tested the patch on linux-4.4/linux-4.9/linux-4.14/linux-4.19 and the
> results shows that the patch is effective in reducing COMPACTSTALL.
>      - monkey for 12 hours.
>      - record COMPACTSTALL after test.
> 
> Test-result: reduced COMPACTSTALL by 95.6% with the patch.
> (the machine with 4 gigabytes of physical memery and in linux-4.19.)
> ---------------------------------
>                       |   COMPACTSTALL
> ---------------------------------
>     ori              |     2189
> ---------------------------------
> optimization |      95
> ---------------------------------
> 
> I fully agree with the value of compaction, but compaction also bring cpu
> consumption and will increase the time of alloc_stall. So if we can let more
> free high-orders-pages in buddy instead of signal pages, it will decrease
> COMPACT_STALL and speed up memory allocation.

Okay, but then I assume the target goal of your patch set is to minimize 
CPU consumption/allocation stall time when allocating larger order pages.

Currently you state "the probablity of high-order-pages allocation would 
be increased significantly", but I assume that's then not 100% correct. 
What you measure is the stall time to allocate higher order pages, not 
that you can allocate them.

> 
> 2. record the speed of the high-orders-pages allocation(order=4 and 
> order = 8)
> Before and after optimization, we tested the speed of the 
> high-orders-pages allocation
> after 120-hours-Monkey in 10 Android mobile phones. and the result show that
> the speed has been increased by more than 18%.
> 
> Also, we do some test designed by us:
> (the machine with 4 gigabytes of physical memery and in linux-4.19.)
> model the usage of users, and constantly start and
> operate the diffrent application for 120h, and we record COMPACT_STALL 
> is decreased by
> 90+% and speed of the high-orders-pages is increaed by 15+%.

Okay, again, this is then some optimization for allocation speed; which 
makes it less attractive IMHO (at least for more invasive changes), 
because I suspect this mostly helps in corner cases (Monkey benchmarks 
corner cases AFAIU).

> 
> and I have some question, i hope you can guide me if when you are free.
> 1) What is the compaction configured?
>      Dost it meant the members in zone? like as follows:
>      unsigned int compact_considered;
>      unsigned int compact_defer_shift;
>      int compact_order_failed;
>      bool compact_blockskip_failed;
>      Or the some Macro variable? like as follows:
>      PAGE_ALLOC_COSTLY_ORDER = 3
>      MIN_COMPACT_PRIORITY = 1
>      MAX_COMPACT_RETRIES = 16
> 

Rather if you have proactive compaction 
(/proc/sys/vm/compaction_proactiveness). But I assume because you're 
messing with older kernels, that you didn't compare against that yet. 
Would be worth a comparison.

>>> 1) multi freearea (which might
>  >> be problematic with sparcity)
> 2) Can you pls tell me what is soarcity and what is the impact of this?
>      and whether there are some documents about it?

Essentially CONFIG_SPARSEMEM, whereby we can have huge holes in physical 
memory layout and memory areas coming/going with memory hot(un)plug. 
Usually we manage all metadata per section. For example, pageblocks are 
allocated per section. We avoid arrays that depend on the 
initial/maximum physical memory size.

-- 
Thanks,

David / dhildenb

