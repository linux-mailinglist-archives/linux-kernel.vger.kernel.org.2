Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E900E3610C6
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Apr 2021 19:08:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234374AbhDORJA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 15 Apr 2021 13:09:00 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:24895 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S231137AbhDORI5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Apr 2021 13:08:57 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1618506513;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=c4bUwdWqx5JUrWJYR1rKkQlIPcDgNW5mI87L7J9m2Ko=;
        b=cPfFTRNhSCEXmtPLmxTSsiEx5SDNvPZ+llFjaON/nLMgxaorLChekgF+Kt+tbihq7nXZLK
        hnBrXikii2IqjA4BlnNpR4XtqICm7vKLYnFKYHlUihfwviNW3CrJCQUXmpS+MxEBv3c1V6
        1H9L6XhLlOFAAry3CEtvOADgOKDhmJA=
Received: from mail-qk1-f197.google.com (mail-qk1-f197.google.com
 [209.85.222.197]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-132-OCKGBshbMKOgaNgfPICTlA-1; Thu, 15 Apr 2021 13:08:32 -0400
X-MC-Unique: OCKGBshbMKOgaNgfPICTlA-1
Received: by mail-qk1-f197.google.com with SMTP id h21so1954320qkl.12
        for <linux-kernel@vger.kernel.org>; Thu, 15 Apr 2021 10:08:32 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:subject:to:cc:references:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding
         :content-language;
        bh=c4bUwdWqx5JUrWJYR1rKkQlIPcDgNW5mI87L7J9m2Ko=;
        b=s10wzVmDcHZPfL1D/xPkEir+4z3cBlWp5WHTruNPEDDmwsazeC75oc4h/TPvIpa7v+
         LKCZNTiZJVZqr4L0kgZY/VUFK8VdFJjFLehJBTbSDl4U9HBKJOnctn2GaRBOfH0Do4zT
         ILkTbCI0D7PDNYtzrAAhn0y6jqLzcfBT5MjzMp0vYobAkVQtjXRTDJNGhow4nfhmhquE
         YpeNqTsmFhcWt2ogmkoNDXeyhIIa10JJg8q4ewh4k+b6rLIfj6roG/TjR4ovJQ22vl/i
         xJkAqL1PP8zKi8AaIaqVA2mgdFWZsDBxUZoFYXH7Lz39zYCUvtPUAYEk+SgxaUGXruSL
         5tkg==
X-Gm-Message-State: AOAM533B92A2y1faGMXk/BUuwjUzZGkvOqFy4Ok7fFEDKP+BOkmbuc9e
        BJ1X54ktT19qEdtpgVBo8hyp1to4D2nN5P0T0PjZZGpNrE9v6H2MnzT018eoc6DpOzlOtrPGdbT
        Qy9ZTJpkoi5j08+sgnLkC+i8D
X-Received: by 2002:a0c:e601:: with SMTP id z1mr4249163qvm.62.1618506511987;
        Thu, 15 Apr 2021 10:08:31 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJyYKgNv627ZQRacj4Z0akpbwf6cDPraxoDdrUd5LGopDdVhUkGCp7HX14SZP2g3PIZr3viwAg==
X-Received: by 2002:a0c:e601:: with SMTP id z1mr4249129qvm.62.1618506511823;
        Thu, 15 Apr 2021 10:08:31 -0700 (PDT)
Received: from llong.remote.csb ([2601:191:8500:76c0::cdbc])
        by smtp.gmail.com with ESMTPSA id u21sm2196347qtq.11.2021.04.15.10.08.30
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 15 Apr 2021 10:08:31 -0700 (PDT)
From:   Waiman Long <llong@redhat.com>
X-Google-Original-From: Waiman Long <longman@redhat.com>
Subject: Re: [PATCH v3 3/5] mm/memcg: Cache vmstat data in percpu
 memcg_stock_pcp
To:     Johannes Weiner <hannes@cmpxchg.org>
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
        Xing Zhengjun <zhengjun.xing@linux.intel.com>
References: <20210414012027.5352-1-longman@redhat.com>
 <20210414012027.5352-4-longman@redhat.com> <YHhu1BOMj1Ip+sb3@cmpxchg.org>
Message-ID: <5abe499a-b1ad-fa22-3487-1a6e00e30e17@redhat.com>
Date:   Thu, 15 Apr 2021 13:08:29 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.0
MIME-Version: 1.0
In-Reply-To: <YHhu1BOMj1Ip+sb3@cmpxchg.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 4/15/21 12:50 PM, Johannes Weiner wrote:
> On Tue, Apr 13, 2021 at 09:20:25PM -0400, Waiman Long wrote:
>> Before the new slab memory controller with per object byte charging,
>> charging and vmstat data update happen only when new slab pages are
>> allocated or freed. Now they are done with every kmem_cache_alloc()
>> and kmem_cache_free(). This causes additional overhead for workloads
>> that generate a lot of alloc and free calls.
>>
>> The memcg_stock_pcp is used to cache byte charge for a specific
>> obj_cgroup to reduce that overhead. To further reducing it, this patch
>> makes the vmstat data cached in the memcg_stock_pcp structure as well
>> until it accumulates a page size worth of update or when other cached
>> data change.
>>
>> On a 2-socket Cascade Lake server with instrumentation enabled and this
>> patch applied, it was found that about 17% (946796 out of 5515184) of the
>> time when __mod_obj_stock_state() is called leads to an actual call to
>> mod_objcg_state() after initial boot. When doing parallel kernel build,
>> the figure was about 16% (21894614 out of 139780628). So caching the
>> vmstat data reduces the number of calls to mod_objcg_state() by more
>> than 80%.
> Right, but mod_objcg_state() is itself already percpu-cached. What's
> the benefit of avoiding calls to it with another percpu cache?
>
There are actually 2 set of vmstat data that have to be updated. One is 
associated with the memcg and other one is for each lruvec within the 
cgroup. Caching it in obj_stock, we replace 2 writes to two colder 
cachelines with one write to a hot cacheline. If you look at patch 5, I 
break obj_stock into two - one for task context and one for irq context. 
Interrupt disable is no longer needed in task context, but that is not 
possible when writing to the actual vmstat data arrays.

Cheers,
Longman

