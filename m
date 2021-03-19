Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 07C743424A5
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Mar 2021 19:28:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230324AbhCSS2P (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 19 Mar 2021 14:28:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50492 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230057AbhCSS2I (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 19 Mar 2021 14:28:08 -0400
Received: from mail-lj1-x231.google.com (mail-lj1-x231.google.com [IPv6:2a00:1450:4864:20::231])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 029C9C06175F
        for <linux-kernel@vger.kernel.org>; Fri, 19 Mar 2021 11:28:07 -0700 (PDT)
Received: by mail-lj1-x231.google.com with SMTP id 16so13110957ljc.11
        for <linux-kernel@vger.kernel.org>; Fri, 19 Mar 2021 11:28:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=J6QHzWANXCm1SDgro0BN9kWI3qVUYrxfC5IeHWzOdDc=;
        b=XqMgT1C3COSq8U0uhLfZF1mhN+0leCRVgDQhdv8f8qYUTjYZFkdlVp1g+NPwesMUKa
         JsQpDKs/Za+UNeYiBzYo8HP1CFQLtajyEoXfRF81DkEkNVOIIgjUCBWy1MX80ENSVCkX
         SL530kChb5osZtRBLpWvw8N5+gvxZGeyrDDCM59d4BEY1gs1U0rBIvZnhf9PLGQ5SBMK
         zIi+ZHtL1XM4fK41xmYGI8CC4+tACGhpXmrJ/pAKK+x/nARRgnsLIojbz4NP1O+eemjA
         jxso7E4lrbiR+wUzmv8K0FqpX/IXXW+lGPfHnIi87hHXo4ZU5Q/aSCuxzshQ81cGSzep
         KeKQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=J6QHzWANXCm1SDgro0BN9kWI3qVUYrxfC5IeHWzOdDc=;
        b=dP7ugr2M8EbjUWmnqXtrlQcfqb8H7c9kJJTx7Gm/pUCwzWcqALIT3tw1vY6ap1VVB4
         cQsbfUDDRgr0iyNqBep2+xRZQLw1hOrGIBuZxu1Az3uOe9pG3SX6oBBfTRqKDdmEWqdg
         enO8n54/cDA/d/rnXJZEeJbm2qdm+HavAul5+knYD+gIo3ypKIrG3nK9/mpQALp24ycs
         ysN00q4ThNsFS5jmZGSN+Dihtb++y4VDcbrI/QOSvYYWajnVAQQKB2gQsfh7A9icoS4S
         mi4aP0SXaFYdrP4llxlkwJj0q0CD3+9rBk18+Y5BcSxDBqHGF5YAWvZc/qAlSonyocMC
         ne1A==
X-Gm-Message-State: AOAM5323BxE6fGTxBji6wEqgiyd/Yy8GYwJSGs9Joan1iJ3XOcvFXVs8
        JVUcUZ8qBfnWA2avG2UKZI/fEYpwU5f62yfr6M749A==
X-Google-Smtp-Source: ABdhPJxew8YLG9vvfoGt8TDHG4Oa+irPZ0uYV3KUM+TSwaAUGGWMwgveoUALHDKCGz63uOS0FEqG+GGwNBGu2vmSOUs=
X-Received: by 2002:a05:651c:2c6:: with SMTP id f6mr1708421ljo.279.1616178486188;
 Fri, 19 Mar 2021 11:28:06 -0700 (PDT)
MIME-Version: 1.0
References: <20210319163821.20704-1-songmuchun@bytedance.com> <20210319163821.20704-6-songmuchun@bytedance.com>
In-Reply-To: <20210319163821.20704-6-songmuchun@bytedance.com>
From:   Shakeel Butt <shakeelb@google.com>
Date:   Fri, 19 Mar 2021 11:27:54 -0700
Message-ID: <CALvZod6PbwSm6Jtz-TqfUb=1-ATX6gAmwXVvn3HUcEBAjKt3sQ@mail.gmail.com>
Subject: Re: [PATCH v5 5/7] mm: memcontrol: use obj_cgroup APIs to charge kmem pages
To:     Muchun Song <songmuchun@bytedance.com>
Cc:     Roman Gushchin <guro@fb.com>, Johannes Weiner <hannes@cmpxchg.org>,
        Michal Hocko <mhocko@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Vladimir Davydov <vdavydov.dev@gmail.com>,
        LKML <linux-kernel@vger.kernel.org>,
        Linux MM <linux-mm@kvack.org>,
        Xiongchun duan <duanxiongchun@bytedance.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Mar 19, 2021 at 9:39 AM Muchun Song <songmuchun@bytedance.com> wrote:
>
> Since Roman series "The new cgroup slab memory controller" applied. All
> slab objects are charged via the new APIs of obj_cgroup. The new APIs
> introduce a struct obj_cgroup to charge slab objects. It prevents
> long-living objects from pinning the original memory cgroup in the memory.
> But there are still some corner objects (e.g. allocations larger than
> order-1 page on SLUB) which are not charged via the new APIs. Those
> objects (include the pages which are allocated from buddy allocator
> directly) are charged as kmem pages which still hold a reference to
> the memory cgroup.
>
> We want to reuse the obj_cgroup APIs to charge the kmem pages.
> If we do that, we should store an object cgroup pointer to
> page->memcg_data for the kmem pages.
>
> Finally, page->memcg_data will have 3 different meanings.
>
>   1) For the slab pages, page->memcg_data points to an object cgroups
>      vector.
>
>   2) For the kmem pages (exclude the slab pages), page->memcg_data
>      points to an object cgroup.
>
>   3) For the user pages (e.g. the LRU pages), page->memcg_data points
>      to a memory cgroup.
>
> We do not change the behavior of page_memcg() and page_memcg_rcu().
> They are also suitable for LRU pages and kmem pages. Why?
>
> Because memory allocations pinning memcgs for a long time - it exists
> at a larger scale and is causing recurring problems in the real world:
> page cache doesn't get reclaimed for a long time, or is used by the
> second, third, fourth, ... instance of the same job that was restarted
> into a new cgroup every time. Unreclaimable dying cgroups pile up,
> waste memory, and make page reclaim very inefficient.
>
> We can convert LRU pages and most other raw memcg pins to the objcg
> direction to fix this problem, and then the page->memcg will always
> point to an object cgroup pointer. At that time, LRU pages and kmem
> pages will be treated the same. The implementation of page_memcg()
> will remove the kmem page check.
>
> This patch aims to charge the kmem pages by using the new APIs of
> obj_cgroup. Finally, the page->memcg_data of the kmem page points to
> an object cgroup. We can use the __page_objcg() to get the object
> cgroup associated with a kmem page. Or we can use page_memcg()
> to get the memory cgroup associated with a kmem page, but caller must
> ensure that the returned memcg won't be released (e.g. acquire the
> rcu_read_lock or css_set_lock).
>
> Signed-off-by: Muchun Song <songmuchun@bytedance.com>
> Acked-by: Johannes Weiner <hannes@cmpxchg.org>

Reviewed-by: Shakeel Butt <shakeelb@google.com>
