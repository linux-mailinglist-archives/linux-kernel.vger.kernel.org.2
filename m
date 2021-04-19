Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 28355364D00
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Apr 2021 23:24:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231458AbhDSVZF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 19 Apr 2021 17:25:05 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:56332 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229734AbhDSVYz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Apr 2021 17:24:55 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1618867465;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=Wmgc0BS4/Q3289dtVfzWyet+zhdbOakz2oUo7zL63L8=;
        b=dhFcRLXV2tXDrv2zLjNLZw4Y1P79aL4shmksee6prNMqIt4sQhOp1zTfDSXPaEdM83mdlD
        /nxW/cpmcyrvKF+hKM3/Bh/4tAAcFfAmxCQIJyYSJ4iD83+qPkzRf9/eQM/vPLECAmpV9L
        2+Rph6tzZFPjVeA19GkhzZ+Z+yrq4o8=
Received: from mail-qt1-f200.google.com (mail-qt1-f200.google.com
 [209.85.160.200]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-409-6TMyqEQcNt2xnAY5jZaIXA-1; Mon, 19 Apr 2021 17:24:23 -0400
X-MC-Unique: 6TMyqEQcNt2xnAY5jZaIXA-1
Received: by mail-qt1-f200.google.com with SMTP id i7-20020ac84f470000b02901b944d49e13so2084254qtw.7
        for <linux-kernel@vger.kernel.org>; Mon, 19 Apr 2021 14:24:23 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:subject:to:cc:references:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding
         :content-language;
        bh=Wmgc0BS4/Q3289dtVfzWyet+zhdbOakz2oUo7zL63L8=;
        b=FJ1p81esVxHUtFOI/OGJDh/V9cehT0TlF1wCuYuUNoRhrVVk5JWX9zY+BMZKeDpUjz
         XnUAM7K9NDnelJA41SGyr/kcOxUXiMdJTNNIuMi5Vm2W71OSjSJhgzfyBnbF8ZUgpU1Y
         Pmi08EHACvV14e+RZ8QDiUwmFk/i9HjSoVoBBUDGumt0rHI287XMvsywOhKDmBv7KHIZ
         OiVqZSmANkBbh7wWSuvBXQPynVug15vPxEX59vrNRUMkKPkp/kZEfAHbSPDu4mmhdaft
         L8uXfFFujCATWanHyxruhr3CuZ8jaeFixWX4SwImOCt9DnH1txUD/RSwnJ6kngQwbRd6
         7izw==
X-Gm-Message-State: AOAM530L49yg2Usd6FMLlOU+yyzB0ag/rfHoKL5BazBL+IdQ3MD3sX8t
        gNITrvmw/eXXjMj/tKMUuNmtgMMo61kEk761xtAujUA8R3YiRsUqhXRovlB8AqfTOYOKPXe+7rz
        qAEDOCLaypTtzWNfzn6SClReS
X-Received: by 2002:a37:8184:: with SMTP id c126mr14086913qkd.353.1618867463396;
        Mon, 19 Apr 2021 14:24:23 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJy4FLubBFrEkXj33csDxvgbw+/gusWYsbykbD8A8Hymwn6ZZwBB+TSD06sOCo/kXS0LWCU1pg==
X-Received: by 2002:a37:8184:: with SMTP id c126mr14086886qkd.353.1618867463222;
        Mon, 19 Apr 2021 14:24:23 -0700 (PDT)
Received: from llong.remote.csb ([2601:191:8500:76c0::cdbc])
        by smtp.gmail.com with ESMTPSA id q23sm10293947qtl.25.2021.04.19.14.24.20
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 19 Apr 2021 14:24:22 -0700 (PDT)
From:   Waiman Long <llong@redhat.com>
X-Google-Original-From: Waiman Long <longman@redhat.com>
Subject: Re: [PATCH v4 1/5] mm/memcg: Move mod_objcg_state() to memcontrol.c
To:     Johannes Weiner <hannes@cmpxchg.org>,
        Waiman Long <llong@redhat.com>
Cc:     Michal Hocko <mhocko@kernel.org>,
        Vladimir Davydov <vdavydov.dev@gmail.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Tejun Heo <tj@kernel.org>, Christoph Lameter <cl@linux.com>,
        Pekka Enberg <penberg@kernel.org>,
        David Rientjes <rientjes@google.com>,
        Joonsoo Kim <iamjoonsoo.kim@lge.com>,
        Vlastimil Babka <vbabka@suse.cz>, Roman Gushchin <guro@fb.com>,
        linux-kernel@vger.kernel.org, cgroups@vger.kernel.org,
        linux-mm@kvack.org, Shakeel Butt <shakeelb@google.com>,
        Muchun Song <songmuchun@bytedance.com>,
        Alex Shi <alex.shi@linux.alibaba.com>,
        Chris Down <chris@chrisdown.name>,
        Yafang Shao <laoar.shao@gmail.com>,
        Wei Yang <richard.weiyang@gmail.com>,
        Masayoshi Mizuma <msys.mizuma@gmail.com>,
        Xing Zhengjun <zhengjun.xing@linux.intel.com>,
        Matthew Wilcox <willy@infradead.org>
References: <20210419000032.5432-1-longman@redhat.com>
 <20210419000032.5432-2-longman@redhat.com> <YH2eT+JCII48hX80@cmpxchg.org>
 <ffb5705e-8629-808d-9d09-0c9c7f509326@redhat.com>
 <140444ea-14e7-b305-910f-f23fafe45488@redhat.com>
 <YH26RrMBOxLaMg4l@cmpxchg.org>
 <b7c8e209-3311-609b-9b61-5602a89a8313@redhat.com>
 <d1c36f26-b958-49e0-ae44-1cf6334fa4c5@redhat.com>
 <YH3yCZn9EeSPKKGY@cmpxchg.org>
Message-ID: <18fc7f4c-d44e-8651-6593-a3e89147e230@redhat.com>
Date:   Mon, 19 Apr 2021 17:24:20 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.9.0
MIME-Version: 1.0
In-Reply-To: <YH3yCZn9EeSPKKGY@cmpxchg.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 4/19/21 5:11 PM, Johannes Weiner wrote:
>
>> BTW, have you ever thought of moving the cgroup-v1 specific functions out
>> into a separate memcontrol-v1.c file just like kernel/cgroup/cgroup-v1.c?
>>
>> I thought of that before, but memcontrol.c is a frequently changed file and
>> so a bit hard to do.
> I haven't looked too deeply at it so far, but I think it would make
> sense to try.
>
> There are indeed many of the entry paths from the MM code that are
> shared between cgroup1 and cgroup2, with smaller branches here and
> there to adjust behavior. Those would throw conflicts, but those we
> should probably keep in the main memcontrol.c for readability anyway.
>
> But there is also plenty of code that is exclusively about cgroup1,
> and which actually doesn't change much in a long time. Moving that
> elsewhere shouldn't create difficult conflicts - maybe a few line
> offset warnings or fuzz-- Rafael
>
>
>   in the diff context of unrelated changes:
>
> - the soft limit tree and soft limit reclaim
>
> - the threshold and oom event notification stuff
>
> - the charge moving code
>
> - remaining v1 interface files, as well as their helper functions
>
>  From a quick scan, this adds up to ~2,500 lines of old code with no
> actual dependencies from the common code or from v2, and which could
> be moved out of the way without disrupting ongoing development much.
>
Right.

Currently memcontrol.c has over 7000 lines of code and keep growing. 
That makes it harder to read, navigate and update. If we can cut out 
2000 lines or more from memcontrol.c, it will make it more manageable.

Cheers,
Longman

