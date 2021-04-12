Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 60F8B35D17B
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Apr 2021 21:53:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238793AbhDLTwl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 12 Apr 2021 15:52:41 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:23472 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S236851AbhDLTwj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Apr 2021 15:52:39 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1618257141;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=kEsyK2g9kHom6z8QSkc+1WTaBxF4g3Yjct+1jOELHcQ=;
        b=c7/00ltqNSiQ6PdHoLaTZCAA9SicKWInj97K/N2PXeYifFT7Ifj06YuEk3JTGCsAKlnAmM
        J7FZ3IfwlTnZFExY1NvIy9LA03x5qtjHNYJI7h/ofvYbyBPFby47+axjDasV27gDXr8ySf
        VPaKfW78+E7vor96BN8d4fJykT41D8o=
Received: from mail-qt1-f199.google.com (mail-qt1-f199.google.com
 [209.85.160.199]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-169-bNppWzHtPWmzMak_IS6HNg-1; Mon, 12 Apr 2021 15:52:07 -0400
X-MC-Unique: bNppWzHtPWmzMak_IS6HNg-1
Received: by mail-qt1-f199.google.com with SMTP id m8so7457576qtp.14
        for <linux-kernel@vger.kernel.org>; Mon, 12 Apr 2021 12:52:07 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:subject:to:cc:references:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding
         :content-language;
        bh=kEsyK2g9kHom6z8QSkc+1WTaBxF4g3Yjct+1jOELHcQ=;
        b=Jf2+IpCvKM6xK7Yre64vEsZlEUGNcgQXxNP+3pOptNqctvPgELD/1itbS6gdbN8SE0
         bRDDlCtAYUrf8DtaqZ9RYlhLEgraRoo71aQmD/tbnCYYZzklSvi8w82ZTqIkR4M+NGXz
         SlME1x8gMt7GHkgR1An+BinSiiuLnq+xMqnMsePwa+KGCPpoDm+swSeLUl5PELuBEmhw
         cYrbFrpPRbtnhywfnRim/C2gSkmlb61DGvFrw6gPw/b8WATPUnnsZC3GN5haMBWkuOYU
         QfMVMZpz2C/aA+VIiZM5PDwKdcg+AIl92af11PgkIq51lg5nrFf67cQIaTSxTP724aTH
         q8IQ==
X-Gm-Message-State: AOAM530Hb56MM9c01H2873twhQsCMHHNcTEg7cKh1jsZR5xFYpyiOLrL
        yCeCEUtpVcSZuy9kSmkHWnK3W9dqzxiGsElx2tsL3l5Iv57PTvARbIWRcIhChf1m63oCXly0a5n
        z1yyWN7BfftPeT1EvDNmxjDps
X-Received: by 2002:a05:620a:132a:: with SMTP id p10mr3286745qkj.165.1618257127137;
        Mon, 12 Apr 2021 12:52:07 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJyKH+lNuLlL7aD09WaoehTTXPuqbCVRZbhiAmNL0Qw6hKshPAX2h5hY1AbftX2FVtoNOxOIkQ==
X-Received: by 2002:a05:620a:132a:: with SMTP id p10mr3286713qkj.165.1618257126892;
        Mon, 12 Apr 2021 12:52:06 -0700 (PDT)
Received: from llong.remote.csb ([2601:191:8500:76c0::cdbc])
        by smtp.gmail.com with ESMTPSA id j129sm8652011qkf.110.2021.04.12.12.52.05
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 12 Apr 2021 12:52:06 -0700 (PDT)
From:   Waiman Long <llong@redhat.com>
X-Google-Original-From: Waiman Long <longman@redhat.com>
Subject: Re: [PATCH 0/5] mm/memcg: Reduce kmemcache memory accounting overhead
To:     Roman Gushchin <guro@fb.com>
Cc:     Johannes Weiner <hannes@cmpxchg.org>,
        Michal Hocko <mhocko@kernel.org>,
        Vladimir Davydov <vdavydov.dev@gmail.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Tejun Heo <tj@kernel.org>, Christoph Lameter <cl@linux.com>,
        Pekka Enberg <penberg@kernel.org>,
        David Rientjes <rientjes@google.com>,
        Joonsoo Kim <iamjoonsoo.kim@lge.com>,
        Vlastimil Babka <vbabka@suse.cz>, linux-kernel@vger.kernel.org,
        cgroups@vger.kernel.org, linux-mm@kvack.org,
        Shakeel Butt <shakeelb@google.com>,
        Muchun Song <songmuchun@bytedance.com>,
        Alex Shi <alex.shi@linux.alibaba.com>,
        Chris Down <chris@chrisdown.name>,
        Yafang Shao <laoar.shao@gmail.com>,
        Alexander Duyck <alexander.h.duyck@linux.intel.com>,
        Wei Yang <richard.weiyang@gmail.com>,
        Masayoshi Mizuma <msys.mizuma@gmail.com>
References: <20210409231842.8840-1-longman@redhat.com>
 <YHSZ6X/DvgddiZBi@carbon.dhcp.thefacebook.com>
Message-ID: <74f8abd9-9efc-3ded-e8cb-8e3465873383@redhat.com>
Date:   Mon, 12 Apr 2021 15:51:52 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.0
MIME-Version: 1.0
In-Reply-To: <YHSZ6X/DvgddiZBi@carbon.dhcp.thefacebook.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 4/12/21 3:05 PM, Roman Gushchin wrote:
> On Fri, Apr 09, 2021 at 07:18:37PM -0400, Waiman Long wrote:
>> With the recent introduction of the new slab memory controller, we
>> eliminate the need for having separate kmemcaches for each memory
>> cgroup and reduce overall kernel memory usage. However, we also add
>> additional memory accounting overhead to each call of kmem_cache_alloc()
>> and kmem_cache_free().
>>
>> For workloads that require a lot of kmemcache allocations and
>> de-allocations, they may experience performance regression as illustrated
>> in [1].
>>
>> With a simple kernel module that performs repeated loop of 100,000,000
>> kmem_cache_alloc() and kmem_cache_free() of 64-byte object at module
>> init. The execution time to load the kernel module with and without
>> memory accounting were:
>>
>>    with accounting = 6.798s
>>    w/o  accounting = 1.758s
>>
>> That is an increase of 5.04s (287%). With this patchset applied, the
>> execution time became 4.254s. So the memory accounting overhead is now
>> 2.496s which is a 50% reduction.
> Btw, there were two recent independent report about benchmark results
> regression caused by the introduction of the per-object accounting:
> 1) Xing reported a hackbench regression:
> https://lkml.org/lkml/2021/1/13/1277
> 2) Masayoshi reported a pgbench regression:
> https://www.spinics.net/lists/linux-mm/msg252540.html
>
> I wonder if you can run them (or at least one) and attach the result
> to the series? It would be very helpful.

Actually, it was a bug reported filed by Masayoshi-san that triggered me 
to work on reducing the memory accounting overhead. He is also in the cc 
line and so is aware of that. I will cc Xing in my v2 patch.

Cheers,
Longman


