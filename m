Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DD36035D3B2
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Apr 2021 01:06:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344014AbhDLXEI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 12 Apr 2021 19:04:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54988 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1343968AbhDLXDv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Apr 2021 19:03:51 -0400
Received: from mail-lf1-x129.google.com (mail-lf1-x129.google.com [IPv6:2a00:1450:4864:20::129])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5C8A8C06138D
        for <linux-kernel@vger.kernel.org>; Mon, 12 Apr 2021 16:03:31 -0700 (PDT)
Received: by mail-lf1-x129.google.com with SMTP id x13so13969233lfr.2
        for <linux-kernel@vger.kernel.org>; Mon, 12 Apr 2021 16:03:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=rzJqdflF0WnnM2sRHImKq0cVYdyTkByzLc0YHSLjXyw=;
        b=l2UdhHrElVUDwH0hdCZbLmqJp9H1jOKWmea9EvpaCTnJg5biZnZtb90GZq56pXCyuL
         qlITzfF7jqj7p3Lwo2BljksTyDdQntYdb2F6iYN5MWSe2I78ThxWhzTPYt12pd8zQkZa
         EsBPugLlm71CgY1zGZO46yoGkv140ySoB1/dNn2mPuYmBbgjUZjiqnjW7qyaohgtvdR2
         kr+fqLblcbKMouw1xITBfF2HuH64dkNcLLgG42WRVITR+ju2d1jxzzyHn+t6WSrO9u4W
         wtr8cSWu9xge+Hw9P0frVBFEToUDcRKjbOKQNbzfpoNK6N7K/sIMT7uakUFRPOaQuiIR
         Qx7Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=rzJqdflF0WnnM2sRHImKq0cVYdyTkByzLc0YHSLjXyw=;
        b=fF3BfqomhCvajqZVwihoDd61Q8JE3g6CZfu3xqbfpZ/utlZTscaexkyG4HzlJlnPWJ
         Z+xkFYgol2p8ewOlX/avEojeJ/rc9aLFq+/Zu90bmfwCX2waHxJQ3xi/e7tp7jChBlkQ
         /2pDiEpB12x/8XRYjrBzraAPW8MB2voxfWbD3pKn/w3ZFNBnNsB0OJqXWKjpM5Umbd8R
         QfvtFg+SGjP79LlkkmLz3QYiEN5KIaQrMtev+tlDqRBzML6CRfSPEerv77ZyaNMKjPvh
         tQfwXfeSBzQyLwDLQVIrKfFzT0mhtpvAw9KMN6LVDxbIJWx7i0x/zUIu7mljhgyThx39
         rNpA==
X-Gm-Message-State: AOAM530Gh5lY1R3t02sD5KJdoGsDB1yABW2kkyhX+42UUlhe0QBBe79G
        FhtomJwpLgtH5FwWCRtl0Gv1DZyNtR163LEKD3tS7Q==
X-Google-Smtp-Source: ABdhPJypa+SCYj5GmItj2Oq0Gj8dAsBY2KumHy25BwOc82qYcbNQS57CLoBVC+4YQ/b431aq9+tnXL+0VywTirWSHok=
X-Received: by 2002:a19:3804:: with SMTP id f4mr21292851lfa.117.1618268609686;
 Mon, 12 Apr 2021 16:03:29 -0700 (PDT)
MIME-Version: 1.0
References: <20210412225503.15119-1-longman@redhat.com> <20210412225503.15119-4-longman@redhat.com>
In-Reply-To: <20210412225503.15119-4-longman@redhat.com>
From:   Shakeel Butt <shakeelb@google.com>
Date:   Mon, 12 Apr 2021 16:03:17 -0700
Message-ID: <CALvZod7hBvbnF3G_Hxbu3Xmfzdip_BGAh0Nr86vvN2d9xBTaSg@mail.gmail.com>
Subject: Re: [PATCH v2 3/5] mm/memcg: Cache vmstat data in percpu memcg_stock_pcp
To:     Waiman Long <longman@redhat.com>
Cc:     Johannes Weiner <hannes@cmpxchg.org>,
        Michal Hocko <mhocko@kernel.org>,
        Vladimir Davydov <vdavydov.dev@gmail.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Tejun Heo <tj@kernel.org>, Christoph Lameter <cl@linux.com>,
        Pekka Enberg <penberg@kernel.org>,
        David Rientjes <rientjes@google.com>,
        Joonsoo Kim <iamjoonsoo.kim@lge.com>,
        Vlastimil Babka <vbabka@suse.cz>, Roman Gushchin <guro@fb.com>,
        LKML <linux-kernel@vger.kernel.org>,
        Cgroups <cgroups@vger.kernel.org>, Linux MM <linux-mm@kvack.org>,
        Muchun Song <songmuchun@bytedance.com>,
        Alex Shi <alex.shi@linux.alibaba.com>,
        Chris Down <chris@chrisdown.name>,
        Yafang Shao <laoar.shao@gmail.com>,
        Wei Yang <richard.weiyang@gmail.com>,
        Masayoshi Mizuma <msys.mizuma@gmail.com>,
        Xing Zhengjun <zhengjun.xing@linux.intel.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Apr 12, 2021 at 3:55 PM Waiman Long <longman@redhat.com> wrote:
>
> Before the new slab memory controller with per object byte charging,
> charging and vmstat data update happen only when new slab pages are
> allocated or freed. Now they are done with every kmem_cache_alloc()
> and kmem_cache_free(). This causes additional overhead for workloads
> that generate a lot of alloc and free calls.
>
> The memcg_stock_pcp is used to cache byte charge for a specific
> obj_cgroup to reduce that overhead. To further reducing it, this patch
> makes the vmstat data cached in the memcg_stock_pcp structure as well
> until it accumulates a page size worth of update or when other cached
> data change.
>
> On a 2-socket Cascade Lake server with instrumentation enabled and this
> patch applied, it was found that about 17% (946796 out of 5515184) of the
> time when __mod_obj_stock_state() is called leads to an actual call to
> mod_objcg_state() after initial boot. When doing parallel kernel build,
> the figure was about 16% (21894614 out of 139780628). So caching the
> vmstat data reduces the number of calls to mod_objcg_state() by more
> than 80%.
>
> Signed-off-by: Waiman Long <longman@redhat.com>

Reviewed-by: Shakeel Butt <shakeelb@google.com>
