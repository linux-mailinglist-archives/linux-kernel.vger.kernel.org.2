Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5D81F36106A
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Apr 2021 18:50:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232913AbhDOQuz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 15 Apr 2021 12:50:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41494 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231137AbhDOQuy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Apr 2021 12:50:54 -0400
Received: from mail-qt1-x834.google.com (mail-qt1-x834.google.com [IPv6:2607:f8b0:4864:20::834])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E9630C061756
        for <linux-kernel@vger.kernel.org>; Thu, 15 Apr 2021 09:50:30 -0700 (PDT)
Received: by mail-qt1-x834.google.com with SMTP id z15so10597094qtj.7
        for <linux-kernel@vger.kernel.org>; Thu, 15 Apr 2021 09:50:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cmpxchg-org.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=72rB8XajCzG79dd5/kOjH7uMhYOH+DU3KMVLgxLTyr4=;
        b=gQvCER62Mwi5oOStzJNE1BKisdCON4w0Nn2typ/ZyS1Ny50cGwhUj9pvaveb3tS9/E
         X9MNmWLkyS9uXvaumY/gMJXf8m+jhaGuAOeFRcXV9DF8WLtqNDnuki4CHTcmCgRQMWgX
         f3zALOJ57RB3qV+eTAbSEx+AutfxwtoDwjoqIzk3Ei4QXWsD8M6LRgg7wGL0LaXyLiho
         344kPvBWK4+RhlgZtEs+mK5xUlqQSffYOatYybZyyx8/RhSHJFzmxMaNddavPBPrHsDA
         /hVrZaxPiv8rCR4j8LjKGwsmpreZVSW5yhnbx6wRts3LHecG1e3eyeL0/fLAEoHvRqxV
         hZrw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=72rB8XajCzG79dd5/kOjH7uMhYOH+DU3KMVLgxLTyr4=;
        b=oV+I/gcLHB5js1q9qnhp1P+nrnSjZrLimDTiU2LmWQAYaF6KLVXwVvHNHwqWUzUq+G
         h1EvvL7j9cXhUgfT9gxiA0qfk4K/Udj2OI0vARZO+EKRvGimAh+1JB/pN2KL64hBvZD+
         +yYVIRA53BEBTGZu5xQk2CAXE6u/0LnZH6OROsP4O/M18AoJJrXjp0efzfkDxJa64EXU
         x36hYjdX+nlq7C3HvqHeN4gJLxnccy/YYBHzCk8Qbbksh9mVa7ZVlMFPV3r4wqd6yMUG
         65Wkf27hHD3ljH9HKGOhZjLyamtdmRtjYr4oE4fPEb4JM2POC/F3MjPW4lBHeEcMT2ct
         y2zw==
X-Gm-Message-State: AOAM532nAjpVVYEbofFHargvsIbpQ2d6opfj34P6rOGSV2ux2qC/P751
        OQqJYBtFg6+Ar6p/5m95gTnxEA==
X-Google-Smtp-Source: ABdhPJxe0yZlRlot254D5UudbV0Ei8pWCy742LTGdpM/fwWbaN2jb/CEdpXlE2lffTEk3G2qQExxAA==
X-Received: by 2002:ac8:4883:: with SMTP id i3mr3827505qtq.232.1618505430099;
        Thu, 15 Apr 2021 09:50:30 -0700 (PDT)
Received: from localhost (70.44.39.90.res-cmts.bus.ptd.net. [70.44.39.90])
        by smtp.gmail.com with ESMTPSA id o23sm2348385qka.16.2021.04.15.09.50.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 15 Apr 2021 09:50:29 -0700 (PDT)
Date:   Thu, 15 Apr 2021 12:50:28 -0400
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
        Xing Zhengjun <zhengjun.xing@linux.intel.com>
Subject: Re: [PATCH v3 3/5] mm/memcg: Cache vmstat data in percpu
 memcg_stock_pcp
Message-ID: <YHhu1BOMj1Ip+sb3@cmpxchg.org>
References: <20210414012027.5352-1-longman@redhat.com>
 <20210414012027.5352-4-longman@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210414012027.5352-4-longman@redhat.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Apr 13, 2021 at 09:20:25PM -0400, Waiman Long wrote:
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

Right, but mod_objcg_state() is itself already percpu-cached. What's
the benefit of avoiding calls to it with another percpu cache?
