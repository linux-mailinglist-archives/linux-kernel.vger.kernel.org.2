Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E73F73C574D
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Jul 2021 12:58:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1376963AbhGLIbN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 12 Jul 2021 04:31:13 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:25216 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1349591AbhGLHoU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Jul 2021 03:44:20 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1626075691;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=9UxiIsS2bDCDwcOogs+eEqta/QcjF32ApVFvqJdxX48=;
        b=e4KvFw6Mlr3IHm5QXv/cILj2lwKvSXziO9I2UwKFoxLFlP33J4GLVRs0v6rwWWI5Vqbaiq
        KQ057kNzsXKxIdU9SGTYDLK5q42mtyWA9PYcOwXC5wFhb0X6waJO74YSy271paH2ybr7mj
        0b7JHj6vQeKoosaopib7Gp/e2B3FSyI=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-514-a6MPT9tLP8CfYsAg0USGLQ-1; Mon, 12 Jul 2021 03:41:30 -0400
X-MC-Unique: a6MPT9tLP8CfYsAg0USGLQ-1
Received: by mail-wm1-f72.google.com with SMTP id b26-20020a7bc25a0000b0290218757e2783so4395662wmj.7
        for <linux-kernel@vger.kernel.org>; Mon, 12 Jul 2021 00:41:29 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:organization
         :message-id:date:user-agent:mime-version:in-reply-to
         :content-language:content-transfer-encoding;
        bh=9UxiIsS2bDCDwcOogs+eEqta/QcjF32ApVFvqJdxX48=;
        b=ibL0choDvCzDmlVcuOc0x/BlWDAtm1kIHYDWCno4fbuPbnDjtck3btQm5ZJ7RDAeqV
         RKi23GEUbK+weqbjZGuo933hz7/Lg1e6HjWH7LWSoDKAWgpUQx+u35gBucN/kyJ2IO4q
         nDOUxGwETHxt631VgTnXzAClESgEsBEgpOqVvn6gUVLUdJ7tPwn5TXDhzdLAQxc/FzYr
         6V9Ysagr1ek+EhupYErp0hV1QEDin9gxnLTytD3E9vgvZ+7vfNmFpapk29fSaXl0eba8
         V2JnnvVqGu0pKrz+pqe9BycbZCrYieLMI/yOVNheVaEfP1A59nwaFjadPW8kNHsCgQU/
         xOgQ==
X-Gm-Message-State: AOAM531llNsEf3FT4bHUdAvlcpVoA0piQMuGUvval/oD9O2MmVjuoW+r
        q+9wuDGA6aPICJYb0uddN7T8yE6I/swF+3Fj9JYtIHFNqwqW88pSLRSVQUb1Zhtd0Mz9rIuP24c
        hDvRRsj6pTSr1vI9r0N1GBn4M
X-Received: by 2002:adf:f085:: with SMTP id n5mr38427749wro.148.1626075689024;
        Mon, 12 Jul 2021 00:41:29 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJyuph2xUEhOYsAOR+5Ndv4BRqy6A3z+3Uiy1VN8XUXUPlWOD/N6tuZKznFC2+4OHoqeGdmqWw==
X-Received: by 2002:adf:f085:: with SMTP id n5mr38427734wro.148.1626075688834;
        Mon, 12 Jul 2021 00:41:28 -0700 (PDT)
Received: from ?IPv6:2003:d8:2f0a:7f00:fad7:3bc9:69d:31f? (p200300d82f0a7f00fad73bc9069d031f.dip0.t-ipconnect.de. [2003:d8:2f0a:7f00:fad7:3bc9:69d:31f])
        by smtp.gmail.com with ESMTPSA id b6sm2679799wmj.34.2021.07.12.00.41.26
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 12 Jul 2021 00:41:27 -0700 (PDT)
Subject: Re: [PATCH v2] mm: Enable suspend-only swap spaces
To:     Michal Hocko <mhocko@suse.com>, Evan Green <evgreen@chromium.org>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Pavel Machek <pavel@ucw.cz>, Alex Shi <alexs@kernel.org>,
        Alistair Popple <apopple@nvidia.com>,
        Jens Axboe <axboe@kernel.dk>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Joonsoo Kim <iamjoonsoo.kim@lge.com>,
        "Matthew Wilcox (Oracle)" <willy@infradead.org>,
        Miaohe Lin <linmiaohe@huawei.com>,
        Minchan Kim <minchan@kernel.org>,
        Vlastimil Babka <vbabka@suse.cz>, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, linux-api@vger.kernel.org
References: <20210709105012.v2.1.I09866d90c6de14f21223a03e9e6a31f8a02ecbaf@changeid>
 <YOvpVRSMJe8NQuS2@dhcp22.suse.cz>
From:   David Hildenbrand <david@redhat.com>
Organization: Red Hat
Message-ID: <30dddfb1-388c-a593-0987-73e821216da9@redhat.com>
Date:   Mon, 12 Jul 2021 09:41:26 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
MIME-Version: 1.0
In-Reply-To: <YOvpVRSMJe8NQuS2@dhcp22.suse.cz>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 12.07.21 09:03, Michal Hocko wrote:
> [Cc linux-api]
> 
> On Fri 09-07-21 10:50:48, Evan Green wrote:
>> Currently it's not possible to enable hibernation without also enabling
>> generic swap for a given swap area. These two use cases are not the
>> same. For example there may be users who want to enable hibernation,
>> but whose drives don't have the write endurance for generic swap
>> activities.
>>
>> Add a new SWAP_FLAG_NOSWAP that adds a swap region but refuses to allow
>> generic swapping to it. This region can still be wired up for use in
>> suspend-to-disk activities, but will never have regular pages swapped to
>> it.
> 
> Could you expand some more on why a strict exclusion is really
> necessary? I do understand that one might not want to have swap storage
> available all the time but considering that swapon is really a light
> operation so something like the following should be a reasonable
> workaround, no?
> 	swapon storage/file
> 	s2disk
> 	swapoff storage

I'm certainly not a hibernation expert, but I'd guess this can also be 
triggered by HW events, so from the kernel and not only from user space 
where your workaround would apply.

-- 
Thanks,

David / dhildenb

