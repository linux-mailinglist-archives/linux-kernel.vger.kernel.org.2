Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E43D9390E6E
	for <lists+linux-kernel@lfdr.de>; Wed, 26 May 2021 04:47:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232508AbhEZCsn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 25 May 2021 22:48:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43438 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230312AbhEZCsm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 May 2021 22:48:42 -0400
Received: from mail-pj1-x1029.google.com (mail-pj1-x1029.google.com [IPv6:2607:f8b0:4864:20::1029])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DDC6AC061574
        for <linux-kernel@vger.kernel.org>; Tue, 25 May 2021 19:47:10 -0700 (PDT)
Received: by mail-pj1-x1029.google.com with SMTP id lx17-20020a17090b4b11b029015f3b32b8dbso12621169pjb.0
        for <linux-kernel@vger.kernel.org>; Tue, 25 May 2021 19:47:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=rv5/ezA/8ChULZqCUpXeS3F+dyYW6ATzNriZIRF37oU=;
        b=x2XFtSpk+a0G0Xh8JqZ6IYdsFxwgPM1uoaWudn2o45O4Kgp5ohOFq8Bxrj2EjXiYwa
         z1lwL26xH7JpX1pJf8DgME42AIE7GR8S6gGIN0+YfYeQOfFqg7O9XEqTuBimnGq80ANS
         m7sfN2mG2XZTVJIDJ6WIjcBn4J5oIyJsT5IF/8O8ooRjDwdXGZIFAqMpLK1/y4F6mxaj
         HPw2lEQzLhN4iyZtfIxyP5DZsS/J3Kj3nbjSYsh0sZmcWk1jMwVGmDBm7zO+nKUxBsy+
         QbW7b/KVL+KMu8DDZs5c1mpPg39nXPRwG3fGzoCZ9nVM4qCnUh282TeOmQYGxayP2wsL
         KUTw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=rv5/ezA/8ChULZqCUpXeS3F+dyYW6ATzNriZIRF37oU=;
        b=gnK3l+KT6+HNLz8UfdUJxjxUmjkJaCkd18hx8JSyV8ydgHwwVcPD0KohNA/nKxAbJ/
         nLlVpBuyw/eFiaadrBPRHGtsTlZoa0UbhNbD/GP5FpMrMozTSf92GKHKN1yQIdKlxnwn
         xiKTf5D+PmBQyYCJH+9da7ADGOwawZR5KsHP7DKvpzEKtYCa7GTBdk6a2Dj3+nJzeOcP
         g8N32y9EZ2njUT7xbWbb2tB+23IoDEtLFSxcEuWSnqHUpCCk1tHRPfcUmMe5gXAq0w8+
         KbWP090ajFX7qvaOdinOdVuT0O/Z8PBvjfL55cxBRVeVdZ4aUR5yrIP00E5TgF4DJD5I
         Talw==
X-Gm-Message-State: AOAM531sF+j/PWdPydxreIqoON/QBentGgpmL6eA5OCFG3EA3rUTnxY7
        OjttpddURsSyI7uI7NSFzFEL8/prvt0We3Ne6Ml0ew==
X-Google-Smtp-Source: ABdhPJxP8OLfQ9amwyzkTyXy09v+A82DJD0GfHZJFLhR+rGr+5DPNA10gLlPgTF9H3tCb4DJAXhSRjGZQTLjLabVWuI=
X-Received: by 2002:a17:902:d711:b029:f0:b127:8105 with SMTP id
 w17-20020a170902d711b02900f0b1278105mr33927023ply.20.1621997230423; Tue, 25
 May 2021 19:47:10 -0700 (PDT)
MIME-Version: 1.0
References: <20210421070059.69361-1-songmuchun@bytedance.com>
 <20210421070059.69361-2-songmuchun@bytedance.com> <YK0lckLSLxhZMk3S@carbon.dhcp.thefacebook.com>
In-Reply-To: <YK0lckLSLxhZMk3S@carbon.dhcp.thefacebook.com>
From:   Muchun Song <songmuchun@bytedance.com>
Date:   Wed, 26 May 2021 10:46:34 +0800
Message-ID: <CAMZfGtWWHHVL1hten=tGBcYUye19i+PK0_3o8=p0uYJ_w=o1cQ@mail.gmail.com>
Subject: Re: [External] Re: [RFC PATCH v3 01/12] mm: memcontrol: move the
 objcg infrastructure out of CONFIG_MEMCG_KMEM
To:     Roman Gushchin <guro@fb.com>
Cc:     Johannes Weiner <hannes@cmpxchg.org>,
        Michal Hocko <mhocko@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Shakeel Butt <shakeelb@google.com>,
        Vladimir Davydov <vdavydov.dev@gmail.com>,
        LKML <linux-kernel@vger.kernel.org>,
        Linux Memory Management List <linux-mm@kvack.org>,
        Xiongchun duan <duanxiongchun@bytedance.com>,
        fam.zheng@bytedance.com, "Singh, Balbir" <bsingharora@gmail.com>,
        Yang Shi <shy828301@gmail.com>,
        Alex Shi <alex.shi@linux.alibaba.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, May 26, 2021 at 12:27 AM Roman Gushchin <guro@fb.com> wrote:
>
> On Wed, Apr 21, 2021 at 03:00:48PM +0800, Muchun Song wrote:
> > Because memory allocations pinning memcgs for a long time - it exists
> > at a larger scale and is causing recurring problems in the real world:
> > page cache doesn't get reclaimed for a long time, or is used by the
> > second, third, fourth, ... instance of the same job that was restarted
> > into a new cgroup every time. Unreclaimable dying cgroups pile up,
> > waste memory, and make page reclaim very inefficient.
> >
> > We can convert LRU pages and most other raw memcg pins to the objcg
> > direction to fix this problem, and then the page->memcg will always
> > point to an object cgroup pointer.
> >
> > Therefore, the infrastructure of objcg no longer only serves
> > CONFIG_MEMCG_KMEM. In this patch, we move the infrastructure of the
> > objcg out of the scope of the CONFIG_MEMCG_KMEM so that the LRU pages
> > can reuse it to charge pages.
> >
> > We know that the LRU pages are not accounted at the root level. But
> > the page->memcg_data points to the root_mem_cgroup. So the
> > page->memcg_data of the LRU pages always points to a valid pointer.
> > But the root_mem_cgroup dose not have an object cgroup. If we use
> > obj_cgroup APIs to charge the LRU pages, we should set the
> > page->memcg_data to a root object cgroup. So we also allocate an
> > object cgroup for the root_mem_cgroup.
>
> Overall the patch looks very good to me. There are few small things to enhance:
>
> 1) I'd rename it. Looking at the title I expect a trivial code move,
>    however the patch is doing more than this: e.g. allocating an objcg
>    for the root memcg. Something like "prepare objcg API for non-kmem usage".

OK. I will rename it.

> 2) How about obj_cgroup_release_kmem() instead of obj_cgroup_release_uncharge()?

LGTM. Will use this name.

> 3) The first paragraph of the commit log looks a bit vague: which allocations
>    pinning memcgs? How about something like this?
>
> Pagecache pages are charged at the allocation time and holding a reference
> to the original memory cgroup until being reclaimed. Depending on the memory
> pressure, specific patterns of the page sharing between different cgroups and
> the cgroup creation and destruction rates, a large number of dying memory
> cgroups can be pinned by pagecache pages. It makes the page reclaim less
> efficient and wastes memory.

More clear. I would love to use this.

Thanks Roman.

>
>
> Thanks!
