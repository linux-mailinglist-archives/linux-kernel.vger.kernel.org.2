Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 94AB93BB812
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Jul 2021 09:44:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230104AbhGEHrL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 5 Jul 2021 03:47:11 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:27679 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229817AbhGEHrL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Jul 2021 03:47:11 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1625471074;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=5np36eWmSvMO78OcbcuN9y0DCOEjj7CB0/OWLTB56sM=;
        b=RKf7g8IoVzKd/xy0TOYsIsj40iI6fzrQ2IBOsHOXGt035SweZAU4mlSzXFHu5MXCPm3vc9
        nzPh5s36Fy0qnc71qdi1o5es01aIUB1PjrC03ynO4pG5lUm6qyp3F7/I5NhawbZs4Uwq7f
        G9bm0hrE1SuMSeL9TuhanYG8XgCiVkY=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-143-Pmpa97ctNFy7r4wXBRz6Ow-1; Mon, 05 Jul 2021 03:44:33 -0400
X-MC-Unique: Pmpa97ctNFy7r4wXBRz6Ow-1
Received: by mail-wr1-f69.google.com with SMTP id p6-20020a5d45860000b02901258b6ae8a5so5919958wrq.15
        for <linux-kernel@vger.kernel.org>; Mon, 05 Jul 2021 00:44:32 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:organization
         :message-id:date:user-agent:mime-version:in-reply-to
         :content-language:content-transfer-encoding;
        bh=5np36eWmSvMO78OcbcuN9y0DCOEjj7CB0/OWLTB56sM=;
        b=iVCHVBHtzL8VqxZvDh8u3Fm/bsPviEF3z04cadR5HumkG2aaCzGmJ2ykBuHod8AnCG
         NxEQHLY7a+Ysi29Y2vbDpDe2rCydEG/QeZMsdhxEU/GBco4NI5ferr1T+QpCjUWJMuIk
         OiN5P5pu82RL9HtTkzsYtW7AWk9hes2XR7sfkAcPocpeQ92nmhQd74HAECM4nUJVpckA
         8vFqWWwf6Q5DyHXhwZUVIMWs05orWk6yQAlv62ZjGLwXfMnzyWGpkmkpIsp8s7w/ZjVX
         wT6Asn90b5JHI+EUtV/3rBBiDTbdCTTcu7BMa/LrdnWNUwnrPT/HYHTzCRpfpJacTUn+
         6q4g==
X-Gm-Message-State: AOAM530flUHYFcxOrJrIKUrspEmfRKVEGSQFc+COicFSehRRwg2e2jvY
        8WkGZvoZ4QvOGyikLiI7LVJCbXycdxO10FEb6SAhoyU5zAi6JkT7PZl2M8UUZqaerROMSK8KaOK
        QLkLD+z98UQds8KN0+g8GZoqN
X-Received: by 2002:a5d:4351:: with SMTP id u17mr13902862wrr.47.1625471072150;
        Mon, 05 Jul 2021 00:44:32 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJzZEBJsRvqmPHoTLdce0dIvJJTt5iVxgxtJhBUqISg2Kcf4rWXTtDjWAcmG8am/2rOegeRzqg==
X-Received: by 2002:a5d:4351:: with SMTP id u17mr13902846wrr.47.1625471071973;
        Mon, 05 Jul 2021 00:44:31 -0700 (PDT)
Received: from ?IPv6:2003:d8:2f0a:7f00:fad7:3bc9:69d:31f? (p200300d82f0a7f00fad73bc9069d031f.dip0.t-ipconnect.de. [2003:d8:2f0a:7f00:fad7:3bc9:69d:31f])
        by smtp.gmail.com with ESMTPSA id b20sm11829216wmj.7.2021.07.05.00.44.31
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 05 Jul 2021 00:44:31 -0700 (PDT)
Subject: Re: [PATCH v1] mm: Enable suspend-only swap spaces
To:     Evan Green <evgreen@chromium.org>,
        Andrew Morton <akpm@linux-foundation.org>
Cc:     Alex Shi <alexs@kernel.org>, Alistair Popple <apopple@nvidia.com>,
        Jens Axboe <axboe@kernel.dk>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Joonsoo Kim <iamjoonsoo.kim@lge.com>,
        "Matthew Wilcox (Oracle)" <willy@infradead.org>,
        Miaohe Lin <linmiaohe@huawei.com>,
        Minchan Kim <minchan@kernel.org>,
        Stephen Rothwell <sfr@canb.auug.org.au>,
        Vlastimil Babka <vbabka@suse.cz>, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org
References: <20210630100432.v1.1.I09866d90c6de14f21223a03e9e6a31f8a02ecbaf@changeid>
From:   David Hildenbrand <david@redhat.com>
Organization: Red Hat
Message-ID: <c178b1f1-73ee-d5a8-dfda-b2d53aa8d83d@redhat.com>
Date:   Mon, 5 Jul 2021 09:44:30 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
MIME-Version: 1.0
In-Reply-To: <20210630100432.v1.1.I09866d90c6de14f21223a03e9e6a31f8a02ecbaf@changeid>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 30.06.21 19:07, Evan Green wrote:
> Currently it's not possible to enable hibernation without also enabling
> generic swap for a given swap area. These two use cases are not the
> same. For example there may be users who want to enable hibernation,
> but whose drives don't have the write endurance for generic swap
> activities.
> 
> Add a new SWAP_FLAG_NOSWAP that adds a swap region but refuses to allow
> generic swapping to it. This region can still be wired up for use in
> suspend-to-disk activities, but will never have regular pages swapped to
> it.

Just to confirm: things like /proc/meminfo won't show this "swap that's 
not actually swap" as free/total swap, correct? Maybe it's worth 
spelling the expected system behavior out here.


-- 
Thanks,

David / dhildenb

