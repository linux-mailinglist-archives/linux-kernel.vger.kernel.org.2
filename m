Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 07EF73FFD2B
	for <lists+linux-kernel@lfdr.de>; Fri,  3 Sep 2021 11:33:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348848AbhICJcJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 3 Sep 2021 05:32:09 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124]:25460 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1348796AbhICJcF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 Sep 2021 05:32:05 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1630661465;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=N5+N+U9+Ro03PZVc42PFsHKY2Zftj9SLOC7/mSkA8LA=;
        b=ZewKSnNW3vxallX0UlbYw+cnbVgvyLPLHM4XCnOkrS3chzVcnmKIwv/J66PmRwsTAyjUv2
        TvxA5Gijn17lfezTgkcnbmCnx4ifHKMLeRE+cpNswFLieGHYWstVW2FkSufV5BgDi7yQOQ
        psQi9qDLTtwurL0qLQIXGmif73AzNVk=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-13-7M01hx53OxSI-bvT6v_C0w-1; Fri, 03 Sep 2021 05:31:04 -0400
X-MC-Unique: 7M01hx53OxSI-bvT6v_C0w-1
Received: by mail-wm1-f69.google.com with SMTP id m16-20020a7bca50000000b002ee5287d4bfso1751320wml.7
        for <linux-kernel@vger.kernel.org>; Fri, 03 Sep 2021 02:31:03 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:organization
         :message-id:date:user-agent:mime-version:in-reply-to
         :content-language:content-transfer-encoding;
        bh=N5+N+U9+Ro03PZVc42PFsHKY2Zftj9SLOC7/mSkA8LA=;
        b=JtrnpBFcr44W9uHrdZ33ncGtgxqx+KikqqsN5AFsChtzyo7WstVBwgLrddTxEqcNUz
         J7gCDHfz9U715gsDd5DMJg0z3azvCKHIMKqwLySYkbNNduMJwyXKws+36PcAU1w/niTh
         xMtf+NXJs5sYbkcqQ3Vb9+tS4Xm14luj0MQHUtLN4v55LCmHm9cU+IT+93tcH3Uh0eA5
         8+LQ5QKzPM1vPf4eNs6hb3fwon4/g2OTBSpiUnNEOnVsg7uA5oLNhSB/tEADStaq+Y3l
         FsNN/0PJhojv5mBtKeUQ762Dwuf1movZ4m1/ZtL9qu2L7Bbo6/lIFmbZ3cwOaPVatACI
         OBmQ==
X-Gm-Message-State: AOAM530rNOW2CjuvCAePJ224PxyL9pcVfMZCKa/7SVaYrbq4sZ93Twdh
        UVtLWEVgnBUy3OPUDl2JApieYIOOYyMQ/XdW/qDkw04vwRbEZKnwZGgG5Fph+ojq28I228kJ56f
        6GC6f4weuaobDQNRL+Q/6lBMT
X-Received: by 2002:adf:c54f:: with SMTP id s15mr2953082wrf.222.1630661462937;
        Fri, 03 Sep 2021 02:31:02 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJw5o7mCUSKHnT4zBk3DaC9uUSt8QVVTDjXAr1RDTVgACfhSL4WqgOPMh3i3zQ432rXMqQciww==
X-Received: by 2002:adf:c54f:: with SMTP id s15mr2953059wrf.222.1630661462706;
        Fri, 03 Sep 2021 02:31:02 -0700 (PDT)
Received: from [192.168.3.132] (p4ff23e05.dip0.t-ipconnect.de. [79.242.62.5])
        by smtp.gmail.com with ESMTPSA id n18sm3653838wmc.22.2021.09.03.02.31.01
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 03 Sep 2021 02:31:02 -0700 (PDT)
Subject: Re: [RFC][PATCH] mm/page_isolation: tracing: trace all
 test_pages_isolated failures
To:     "George G. Davis" <george_davis@mentor.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        "open list:MEMORY MANAGEMENT" <linux-mm@kvack.org>,
        open list <linux-kernel@vger.kernel.org>,
        Eugeniu Rosca <erosca@de.adit-jv.com>,
        "George G. Davis" <davis.george@siemens.com>
References: <20210823202823.13765-1-george_davis@mentor.com>
 <4f680b5a-9076-3ba4-caea-bdd6eafeb899@redhat.com>
 <20210902222152.GA25844@mam-gdavis-dt>
From:   David Hildenbrand <david@redhat.com>
Organization: Red Hat
Message-ID: <8dca5a34-2c5c-bc49-b2ad-f3e5e0fdbba3@redhat.com>
Date:   Fri, 3 Sep 2021 11:31:01 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
MIME-Version: 1.0
In-Reply-To: <20210902222152.GA25844@mam-gdavis-dt>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 03.09.21 00:21, George G. Davis wrote:
> On Tue, Aug 31, 2021 at 04:53:31PM +0200, David Hildenbrand wrote:
>> On 23.08.21 22:28, George G. Davis wrote:
>>> From: "George G. Davis" <davis.george@siemens.com>
>>>
>>> Some test_pages_isolated failure conditions don't include trace points.
>>> For debugging issues caused by "pinned" pages, make sure to trace all
>>> calls whether they succeed or fail. In this case, a failure case did not
>>> result in a trace point. So add the missing failure case in
>>> test_pages_isolated traces.
>>
>> In which setups did you actually run into these cases?
> 
> Good question!
> 
> Although I'm not 100% certain that this specific failure condition has
> occurred in my recent testing, I'm able to reproduce cma_alloc -EBUSY
> faiure conditions when testing latest/recent master on arm64 based
> Renesas R-Car Starter Kit [1] using defconfig with
> CONFIG_CMA_SIZE_MBYTES=384 while running the following test case:

Okay, I think you are not hitting the path you touched in this patch, 
because I assume it will never ever really trigger ...

> 
> trace-cmd record -N 192.168.1.87:12345 -b 4096 -e cma -e page_isolation -e compaction -e migrate &
> sleep 10
> while true; do a=$(( ( RANDOM % 10000 ) + 1 )); echo $a > /sys/kernel/debug/cma/cma-reserved/alloc && (usleep $a; echo $a > /sys/kernel/debug/cma/cma-reserved/free); done &
> while true; do b=$(( ( RANDOM % 10000 ) + 1 )); echo $b > /sys/kernel/debug/cma/cma-reserved/alloc && (usleep $b; echo $b > /sys/kernel/debug/cma/cma-reserved/free); done &
> while true; do c=$(( ( RANDOM % 10000 ) + 1 )); echo $c > /sys/kernel/debug/cma/cma-reserved/alloc && (usleep $c; echo $c > /sys/kernel/debug/cma/cma-reserved/free); done &
> while true; do d=$(( ( RANDOM % 10000 ) + 1 )); echo $d > /sys/kernel/debug/cma/cma-reserved/alloc && (usleep $d; echo $d > /sys/kernel/debug/cma/cma-reserved/free); done &
> while true; do e=$(( ( RANDOM % 10000 ) + 1 )); echo $e > /sys/kernel/debug/cma/cma-reserved/alloc && (usleep $e; echo $e > /sys/kernel/debug/cma/cma-reserved/free); done &
> /selftests/vm/transhuge-stress &
> 
> The cma_alloc -EBUSY failures are caused by THP compound pages allocated
> from the CMA region where migration does not seem to work for compound
> THP pages. The work around is to disable CONFIG_TRANSPARENT_HUGEPAGE
> since it seems incompatible with the intended use of the CMA region.


Oh, that sounds broken, THP should not block CMA allocation or page 
migration for other purposes.

a) Are these temporary or permanent allocation errors? If they are 
permanent, they will also break memory unplug.

b) Did you reproduce on other architectures as well?

c) Did it use to work but is now broken? IOW, did you try bisecting?

-- 
Thanks,

David / dhildenb

