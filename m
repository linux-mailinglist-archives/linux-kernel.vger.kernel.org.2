Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 180C13D74EA
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Jul 2021 14:19:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236243AbhG0MTK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 27 Jul 2021 08:19:10 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:53297 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S236284AbhG0MTI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Jul 2021 08:19:08 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1627388347;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=Cyg4OzSfCVK2ArH8hMcR0QU6etJZdNnz5j7NaiTQwfM=;
        b=A1gqzgtgdu7+x37KOe4R+lmlTDVNXFYvhghjcMmRNIEKMbaGOVJUpwF4HvPh4/Ucc4ZJt1
        qpTZXzPKYfMM5Pexkcvdp1jjTr6bc2vnDX4nSFwFGQvlCCnN4RhcaNyxCOb09zGOkhL+D/
        /oPxxBwBpd0fgV0bFv924zRv/SGogXE=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-68-JiUNlntSMTmZrRUEKAqBBw-1; Tue, 27 Jul 2021 08:19:05 -0400
X-MC-Unique: JiUNlntSMTmZrRUEKAqBBw-1
Received: by mail-wm1-f70.google.com with SMTP id g187-20020a1c20c40000b02902458d430db6so972346wmg.9
        for <linux-kernel@vger.kernel.org>; Tue, 27 Jul 2021 05:19:05 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:organization
         :message-id:date:user-agent:mime-version:in-reply-to
         :content-language:content-transfer-encoding;
        bh=Cyg4OzSfCVK2ArH8hMcR0QU6etJZdNnz5j7NaiTQwfM=;
        b=Ktx6kurTtGYJywQ/FQR9rdJTbFPx/ydH5q8RhvG8VrCQFFaiLUkGYHRSnAy0o04Sbj
         FD0f/hjhEi37mwwapzb2AExsK1URSV1/YL3C9cqzwVQl31t+lNugTxgI5UTEy2wJQcmS
         PgrsiBQNhRIoSRS0mPgfFwhg7iGfgG1wZlgTng66hM5Ays7nm3MuEHaGfuYnTX9rrpD1
         VmLK3P0oB0NuzTZDBxpFYCenodnET0iOl6RKLuYmsIKUz8AnNI8AK2tKPti768YQWS4M
         HZWdoRFxFF6yN+TYlYUQGPOvcpcRDGw3peRVxwu3N0haEkcN0pegJIX08+EwNl8+G4Oj
         OZqQ==
X-Gm-Message-State: AOAM5331jNDyPMKueOPLiifDqzUuKxHylreDUoaLEVz4IPow/ExdFXA8
        IzGhYUOTOnaohx5LSg5teuWSHNZbSujS5ie1S9jA7kRv1ATKkI5yZb024h3FUW531aANkHfpwHE
        1csc9WbFTEfwUwQLXi29l3OgR
X-Received: by 2002:a5d:6da3:: with SMTP id u3mr24255749wrs.394.1627388344515;
        Tue, 27 Jul 2021 05:19:04 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJzoTD6xViLCv6Sh6eedwOX3/SDyry/1WTpnxYqWWSunam9tACK6ql5CgDJUDnxSNGHSYP0KSA==
X-Received: by 2002:a5d:6da3:: with SMTP id u3mr24255732wrs.394.1627388344358;
        Tue, 27 Jul 2021 05:19:04 -0700 (PDT)
Received: from [192.168.3.132] (p4ff23c36.dip0.t-ipconnect.de. [79.242.60.54])
        by smtp.gmail.com with ESMTPSA id y66sm2904831wmy.39.2021.07.27.05.19.03
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 27 Jul 2021 05:19:03 -0700 (PDT)
Subject: Re: [PATCH v2] mm: Enable suspend-only swap spaces
To:     Pavel Machek <pavel@ucw.cz>
Cc:     Michal Hocko <mhocko@suse.com>, Evan Green <evgreen@chromium.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Alex Shi <alexs@kernel.org>,
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
 <30dddfb1-388c-a593-0987-73e821216da9@redhat.com>
 <YO55ZIrgkLXI4BbS@dhcp22.suse.cz>
 <b84dfb7b-9ae7-8cd7-ce65-0b1952e30e8e@redhat.com>
 <20210727120413.GB32265@duo.ucw.cz>
From:   David Hildenbrand <david@redhat.com>
Organization: Red Hat
Message-ID: <d6f7b7a4-c27f-5ccb-c605-c16f6a7ea2e6@redhat.com>
Date:   Tue, 27 Jul 2021 14:19:02 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
MIME-Version: 1.0
In-Reply-To: <20210727120413.GB32265@duo.ucw.cz>
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 27.07.21 14:04, Pavel Machek wrote:
> Hi!
> 
>> Let's take a look at hibernate() callers:
>>
>> drivers/mfd/tps65010.c: calls hibernate() from IRQ contex, based on HW
>>                          event
> 
> No it does not. Look again.
> 

Oh, dead code :)

>> kernel/power/autosleep.c: calls hibernate() when it thinks it might be
>>   			  a good time to go to sleep
> 
> Ok, you are right, it is there. But I don't believe anyone uses this
> configuration.

If it's dead code, we might want to look into deprecating and removing 
it. It was introduced around 2012:

https://lwn.net/Articles/479841/


-- 
Thanks,

David / dhildenb

