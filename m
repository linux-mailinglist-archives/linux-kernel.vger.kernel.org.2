Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6805035D3B6
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Apr 2021 01:07:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242631AbhDLXHd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 12 Apr 2021 19:07:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55810 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237939AbhDLXHd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Apr 2021 19:07:33 -0400
Received: from mail-lj1-x22d.google.com (mail-lj1-x22d.google.com [IPv6:2a00:1450:4864:20::22d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 46DBBC061574
        for <linux-kernel@vger.kernel.org>; Mon, 12 Apr 2021 16:07:14 -0700 (PDT)
Received: by mail-lj1-x22d.google.com with SMTP id a1so17344554ljp.2
        for <linux-kernel@vger.kernel.org>; Mon, 12 Apr 2021 16:07:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=aTRzEJFSpnM/9p6JIBDLvAw2rNJrlqUIjfDvML3pE+I=;
        b=EHPYiqK56Fzjbrc/qW5NAyRz0w3Dd7UjTe+Axr6LHCmgrAtap46JcXM/jhRbSqGaqj
         gELdIQCoZW1yGJ7H6bqgbzih4W9cnGFArn0Rj0j+2c2Q3GbIY+2GgqX5/PEk3shQ3giX
         3lwvh05R+eQ8cJZSE+I0lFHl8NpHDPVHuC/uwPpK4IBXWJ+59w/w2ofII93zsVvGa8V/
         8pB0HpV4QPaPPvjSlPmTAq6DQctnDEAsvd5fxTuZs2L8FEl4PFyJqmgPzFtfmpoThlEr
         5Z5TwK//szee0vkGALcf84NtuKt4j+yXoePUMMGhTUPBYvf/wC7+E0u8EY6RwdWpgrZU
         Dkiw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=aTRzEJFSpnM/9p6JIBDLvAw2rNJrlqUIjfDvML3pE+I=;
        b=JhvYT4KjsQhBCp5WC0eoiA9j5aXoD2bzOXT+KAPot/dC6fU53XQuFz21BMc8HaKpd5
         ZESFfkvgHMkEAPmUjyRdUlQmyBe5BJd4AyqCkAhMuEwLYe/8CYLiqPhQZoD6LbnL/bpH
         CrGGrhMRHDk7mAGFyFtXvF5nJq/nY5VIF27NcCGBG4sBcj0xFMGclq2R3+ht4U9aec3z
         U0ZcIhGmqtLuEAF8JrZVdfYR6yeMED3gM2N9QaqnZQr6ZPOMz6uxaKjQJXAEnFcN//GS
         EwAnIu9TzNpg0Z/s9xDytSi5avveaIhnQF/mmHnbJT150eULuyv7qrwrgpOjaP11cUgq
         MZ5A==
X-Gm-Message-State: AOAM530MvtzXbrDZi93nemLmJEqhmG611MQ8tYdP4/FJf3eYKMVkWCzm
        /8ZP/FxYXUHetJLSEqZsWIYCLuKpFHFabKw5cTPU1g==
X-Google-Smtp-Source: ABdhPJzGkUJEltWcM75+iXwmV51kn/P/TwZoP85lVcwyLyK75hqfBjSoBiha6DJxTWXQTkYiFW75dddv0klDmE3JUbM=
X-Received: by 2002:a2e:8084:: with SMTP id i4mr19954167ljg.122.1618268832376;
 Mon, 12 Apr 2021 16:07:12 -0700 (PDT)
MIME-Version: 1.0
References: <20210412225503.15119-1-longman@redhat.com> <20210412225503.15119-5-longman@redhat.com>
In-Reply-To: <20210412225503.15119-5-longman@redhat.com>
From:   Shakeel Butt <shakeelb@google.com>
Date:   Mon, 12 Apr 2021 16:07:01 -0700
Message-ID: <CALvZod4Rd3arXjJX87dbSoO5iL6HauSfSdWxkreT_ydGYiAHiA@mail.gmail.com>
Subject: Re: [PATCH v2 4/5] mm/memcg: Separate out object stock data into its
 own struct
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
> The object stock data stored in struct memcg_stock_pcp are independent
> of the other page based data stored there. Separating them out into
> their own struct to highlight the independency.
>
> Signed-off-by: Waiman Long <longman@redhat.com>
> Acked-by: Roman Gushchin <guro@fb.com>

Reviewed-by: Shakeel Butt <shakeelb@google.com>
