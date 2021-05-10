Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 58BC63799A0
	for <lists+linux-kernel@lfdr.de>; Tue, 11 May 2021 00:04:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231208AbhEJWFO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 10 May 2021 18:05:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53440 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230045AbhEJWFK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 May 2021 18:05:10 -0400
Received: from mail-lf1-x136.google.com (mail-lf1-x136.google.com [IPv6:2a00:1450:4864:20::136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 84C83C061574
        for <linux-kernel@vger.kernel.org>; Mon, 10 May 2021 15:04:04 -0700 (PDT)
Received: by mail-lf1-x136.google.com with SMTP id j10so25597722lfb.12
        for <linux-kernel@vger.kernel.org>; Mon, 10 May 2021 15:04:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=KwtTE/gl2dcTlM1KY2uJwCHjgoUE9x51RcP+6cTsKk4=;
        b=LXVG67xBqmulAarA32cTdz4NzSJdDEwdV8S83EpC+5jiXdNqNXg9jwGZDQMTCEGvtg
         06WlAhff1zjTZTas3gGGNgEC4vus6SFpa6DxbFOxBO4KHpHJ3S174+HZBDmAGR4KrsUR
         VfAazMEPntUGYITmPn4Nmnlh+cfjMx+1fuGwOl5Yg7m7XvDMnPy0IS0orBjcS1UtZ6+X
         w99/+zvuAIUvumvVC7kXIDSaWE7N6OBDW/Jca5nF0spbNiK3MMTfc2o63i1Zxir3k5ZH
         nOejwYjKr6gi+772J+svQSkZBiSSU/vUXE+Z8S0zusjU8uM8E8JHZ5PQT6DHPCugjCWG
         DAvw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=KwtTE/gl2dcTlM1KY2uJwCHjgoUE9x51RcP+6cTsKk4=;
        b=TarcordNiFblFuiT5nrdXrXlPVZx4oepqB+sDW2kzkLRl6p8Cz/sDPp77qlc/R2vKw
         +SNCas8MhK+9JJYBf6U0PhXoHQsAd/uWxUv95F/sb06ABqKDW647hVASGfEkdOTqbzsM
         ddHnuvgwCw0PJBnWr3LtGdwnPQrvxwDL54sJzAVqHgInVU4wuS+knUKh7UO0wt+VU/ga
         YD3g2sN53zU1n7qEdYR1wQVG+4FooitJF5u0SqPOSS3mB0RJBug84bHfOiq9A/UG8Sw7
         Wa3LSTh/XWg3EhuqPCP+YaaGhtciWB4dz2zp6q1uYdLTQc+fsOs88VXE3kKmoqvxsSLD
         Pm3Q==
X-Gm-Message-State: AOAM532YHOHJi4Zg7BleF3XeU+3GRORhTw5IrXnasEsqtxDh0ngNdcKq
        WbPJcxNlDGJvMnSGthveht7fip+F596KbFTPszjwcg==
X-Google-Smtp-Source: ABdhPJxebhvrh5QRDC+NkCa65ISSto2NJS7oVcfK+tZ1UGWI5IvW67TEUabtNJGskDZxibh0cZ4BBIWH/fVkLlbGE4U=
X-Received: by 2002:a05:6512:208b:: with SMTP id t11mr18182790lfr.358.1620684242850;
 Mon, 10 May 2021 15:04:02 -0700 (PDT)
MIME-Version: 1.0
References: <20210425075410.19255-1-songmuchun@bytedance.com>
In-Reply-To: <20210425075410.19255-1-songmuchun@bytedance.com>
From:   Shakeel Butt <shakeelb@google.com>
Date:   Mon, 10 May 2021 15:03:52 -0700
Message-ID: <CALvZod5dOwLAbShLKP2o=nZVcPNJ2pwR-EDNfSTX77H3VVK5+A@mail.gmail.com>
Subject: Re: [PATCH v2] mm: memcontrol: fix root_mem_cgroup charging
To:     Muchun Song <songmuchun@bytedance.com>
Cc:     Roman Gushchin <guro@fb.com>, Johannes Weiner <hannes@cmpxchg.org>,
        Michal Hocko <mhocko@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Vladimir Davydov <vdavydov.dev@gmail.com>,
        LKML <linux-kernel@vger.kernel.org>,
        Linux MM <linux-mm@kvack.org>,
        Xiongchun duan <duanxiongchun@bytedance.com>,
        fam.zheng@bytedance.com, zhengqi.arch@bytedance.com
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Apr 25, 2021 at 12:57 AM Muchun Song <songmuchun@bytedance.com> wrote:
>
> The below scenario can cause the page counters of the root_mem_cgroup
> to be out of balance.
>
> CPU0:                                   CPU1:
>
> objcg = get_obj_cgroup_from_current()
> obj_cgroup_charge_pages(objcg)
>                                         memcg_reparent_objcgs()
>                                             // reparent to root_mem_cgroup
>                                             WRITE_ONCE(iter->memcg, parent)
>     // memcg == root_mem_cgroup
>     memcg = get_mem_cgroup_from_objcg(objcg)
>     // do not charge to the root_mem_cgroup
>     try_charge(memcg)
>
> obj_cgroup_uncharge_pages(objcg)
>     memcg = get_mem_cgroup_from_objcg(objcg)
>     // uncharge from the root_mem_cgroup
>     refill_stock(memcg)
>         drain_stock(memcg)
>             page_counter_uncharge(&memcg->memory)
>
> get_obj_cgroup_from_current() never returns a root_mem_cgroup's objcg,
> so we never explicitly charge the root_mem_cgroup. And it's not
> going to change. It's all about a race when we got an obj_cgroup
> pointing at some non-root memcg, but before we were able to charge it,
> the cgroup was gone, objcg was reparented to the root and so we're
> skipping the charging. Then we store the objcg pointer and later use
> to uncharge the root_mem_cgroup.
>
> This can cause the page counter to be less than the actual value.
> Although we do not display the value (mem_cgroup_usage) so there
> shouldn't be any actual problem, but there is a WARN_ON_ONCE in
> the page_counter_cancel(). Who knows if it will trigger? So it
> is better to fix it.
>
> Signed-off-by: Muchun Song <songmuchun@bytedance.com>

Reviewed-by: Shakeel Butt <shakeelb@google.com>
