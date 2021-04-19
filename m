Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B7CAA3646D6
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Apr 2021 17:14:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240795AbhDSPO6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 19 Apr 2021 11:14:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56412 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229661AbhDSPO4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Apr 2021 11:14:56 -0400
Received: from mail-qv1-xf2b.google.com (mail-qv1-xf2b.google.com [IPv6:2607:f8b0:4864:20::f2b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 84A24C061761
        for <linux-kernel@vger.kernel.org>; Mon, 19 Apr 2021 08:14:25 -0700 (PDT)
Received: by mail-qv1-xf2b.google.com with SMTP id i11so11511044qvu.10
        for <linux-kernel@vger.kernel.org>; Mon, 19 Apr 2021 08:14:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cmpxchg-org.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=55uomXciVSZ6J6HOTB32O4AbktADuhgCDGYMDuRmQxE=;
        b=RQhB8OjlxbRDagS7zeb7sF3QHZwiZdGpXuuxJSsZOxySpSixsl4FqbgevMPiEdfs5V
         SRiDYvj2aok3lt+Kb0CaDE3nO0nzdifSCwV5jMfBFJKlVGGw/SPYIp+lJPWdQxVl560T
         KwQRD7NBYrflCIbsLoFGLGlPICDLLjfLaQ0HYUmIZjCRldM6OI4HbuVdhXzoKRxCpaUo
         u5u7RbH0I2icI19RuUvEqPq/Xhey6DWAxZzyBlCCemoLeo2zwVbfv8HkjRR7iyIZ652x
         +zYC+YI6muSdaB8L13xdzgdASaPEkae7oXWHP5rleWZLqiD8bRo2JZNvQKm2o4u1CmOa
         FsgA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=55uomXciVSZ6J6HOTB32O4AbktADuhgCDGYMDuRmQxE=;
        b=Ouw88Ob87+PL7/lVIGdpHNa3tzVayzoyA/iMmdd8Mj42w7Nt1QqY3JsuozelkR37B2
         Zk2kubi+AQ35IVaF6f8nFdZYm0rR2E41ZpoWXqPYEyRc7T87s+FKi/VvrQm/1o/Q5tPn
         BkZj8izumKNz4y0K9AGBQXOdKO8qnecXSwYC3KJsgD9TQsNvkPeXve7IDdFtzpJ8PaqQ
         jXyBw8GUufqRM5uzeleDNVGvbyvjHQWkQwjsdDAcA4SzRIxCezEqHP6WGF/Pc/NmueFb
         KmMQUlczcpxY30wwK1US5TUtc6py3sx7FzIFVSQsUVRjYfOEDNFddwnFMgsP8Y19x0Ct
         rj/g==
X-Gm-Message-State: AOAM5328MN0QjYBHJ/OdugFX+Sran1zITWhIIG3vkwUb4ZAGzzZQNisV
        o/KNYxxnW8IAHDOPd/zqo44BVQ==
X-Google-Smtp-Source: ABdhPJxpsSV7l37HtQTRT1SxTkkytlcWsNYVRzMS2JBB0kroc1KQt8l+9N1P/5oyTmVh5BwQvaqBrA==
X-Received: by 2002:a0c:e24e:: with SMTP id x14mr22422271qvl.33.1618845264783;
        Mon, 19 Apr 2021 08:14:24 -0700 (PDT)
Received: from localhost (70.44.39.90.res-cmts.bus.ptd.net. [70.44.39.90])
        by smtp.gmail.com with ESMTPSA id o25sm5681249qtl.37.2021.04.19.08.14.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 19 Apr 2021 08:14:23 -0700 (PDT)
Date:   Mon, 19 Apr 2021 11:14:23 -0400
From:   Johannes Weiner <hannes@cmpxchg.org>
To:     Waiman Long <longman@redhat.com>
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
Subject: Re: [PATCH v4 1/5] mm/memcg: Move mod_objcg_state() to memcontrol.c
Message-ID: <YH2eT+JCII48hX80@cmpxchg.org>
References: <20210419000032.5432-1-longman@redhat.com>
 <20210419000032.5432-2-longman@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210419000032.5432-2-longman@redhat.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Apr 18, 2021 at 08:00:28PM -0400, Waiman Long wrote:
> The mod_objcg_state() function is moved from mm/slab.h to mm/memcontrol.c
> so that further optimization can be done to it in later patches without
> exposing unnecessary details to other mm components.
> 
> Signed-off-by: Waiman Long <longman@redhat.com>
> ---
>  mm/memcontrol.c | 13 +++++++++++++
>  mm/slab.h       | 16 ++--------------
>  2 files changed, 15 insertions(+), 14 deletions(-)
> 
> diff --git a/mm/memcontrol.c b/mm/memcontrol.c
> index e064ac0d850a..dc9032f28f2e 100644
> --- a/mm/memcontrol.c
> +++ b/mm/memcontrol.c
> @@ -3150,6 +3150,19 @@ void __memcg_kmem_uncharge_page(struct page *page, int order)
>  	css_put(&memcg->css);
>  }
>  
> +void mod_objcg_state(struct obj_cgroup *objcg, struct pglist_data *pgdat,
> +		     enum node_stat_item idx, int nr)
> +{
> +	struct mem_cgroup *memcg;
> +	struct lruvec *lruvec = NULL;
> +
> +	rcu_read_lock();
> +	memcg = obj_cgroup_memcg(objcg);
> +	lruvec = mem_cgroup_lruvec(memcg, pgdat);
> +	mod_memcg_lruvec_state(lruvec, idx, nr);
> +	rcu_read_unlock();
> +}

It would be more naturally placed next to the others, e.g. below
__mod_lruvec_kmem_state().

But no deal breaker if there isn't another revision.

Acked-by: Johannes Weiner <hannes@cmpxchg.org>
