Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 636B23F2706
	for <lists+linux-kernel@lfdr.de>; Fri, 20 Aug 2021 08:45:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238581AbhHTGpX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 20 Aug 2021 02:45:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40328 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238579AbhHTGpW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 Aug 2021 02:45:22 -0400
Received: from mail-pg1-x533.google.com (mail-pg1-x533.google.com [IPv6:2607:f8b0:4864:20::533])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 91785C061756
        for <linux-kernel@vger.kernel.org>; Thu, 19 Aug 2021 23:44:45 -0700 (PDT)
Received: by mail-pg1-x533.google.com with SMTP id n18so8202228pgm.12
        for <linux-kernel@vger.kernel.org>; Thu, 19 Aug 2021 23:44:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=KE1zb6m8muvukw7sccIpaWu9LaRU18Aa0FS6/xMdGNo=;
        b=bbyBO+VBSqjFPmChF/PUQMrXZ+tNKSnjEZo+/rf8AwVRMwGy+TnHXfIleNPM9rLe1L
         qqL0MRTutOdwQKxRjGe0pA7A8m9Pe+1yq+jaJ12cF7IcBZUeKN32RNYQQigaerpdw2Nr
         q3xsbrn5vY7IKwGvweMK13Z1KF+p+gNta/GxYEeptWPoATQQZXAwl6Ku+uxn18nD1jFR
         IzzMwqifQS+riB7eTXIQQRCbSDGcI538TgQS5qyXM6HeGNKXSEwWcfqjacJIs+n155VV
         rw5kONuOd52RX6RedS9Sb/ncVSYJY0/mmvLOfNDGp+VnrXypKn8xYF/MSauNNI5uqpgq
         DcBQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=KE1zb6m8muvukw7sccIpaWu9LaRU18Aa0FS6/xMdGNo=;
        b=Z017cWcpHDdUJ00pzsu3M2Zqcj0NAdv8DH1KGQRPg8edie7yOCgaxfjKedQnSNQZGU
         GFCn0Y3yaIrSNnCPhDY8H05qsjAoKfMlSVxgvrtrz14KQddwJKpjxqLzh2vUWf/uBleP
         Cpz8td2eM268FMtAmPoZHp/NAH8nsaknDd+ABK2GfwT65IIbBPCMlkNQ/pGhd80kYNIq
         JBaN5evaFDDjiL4346WQ1A2KS1yIBhNPe5XZnRHGpIAuqYUfEkKehP4iCTd4D6FyTodt
         pDpXg0ULcAZNmzH1Kkuwj/fiqdSVnCC1nJSGf2UZ41JLTeBdHQPm8+OIHiQdvNyi/TNX
         AhMw==
X-Gm-Message-State: AOAM532Yx6QHCfi0OSmmcI8C/QjCL6UFvMx3MThSpYTrIpYIsbg4ykPR
        b+J8Rg9hkeEniMy/RMxahaAfe4ylrxDPVVl32SZXHw==
X-Google-Smtp-Source: ABdhPJzjCKemjp4rN7FqnClXF7A2/Ui/MfIaVs0es2mwWAIM3ZFyKAYmEpJmgTHfdKFuNosU+oid82ft5IgdaYv0asE=
X-Received: by 2002:a63:f804:: with SMTP id n4mr17132101pgh.341.1629441884963;
 Thu, 19 Aug 2021 23:44:44 -0700 (PDT)
MIME-Version: 1.0
References: <20210814052519.86679-1-songmuchun@bytedance.com>
 <20210814052519.86679-2-songmuchun@bytedance.com> <YRx4EM0MWSjtutPD@carbon.dhcp.thefacebook.com>
In-Reply-To: <YRx4EM0MWSjtutPD@carbon.dhcp.thefacebook.com>
From:   Muchun Song <songmuchun@bytedance.com>
Date:   Fri, 20 Aug 2021 14:44:08 +0800
Message-ID: <CAMZfGtWfEMvDekoZEktgOfLvLG1i5m=J+XWj5=W3=W+D9-xPgg@mail.gmail.com>
Subject: Re: [PATCH v1 01/12] mm: memcontrol: prepare objcg API for non-kmem usage
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
        Yang Shi <shy828301@gmail.com>, Alex Shi <alexs@kernel.org>,
        Muchun Song <smuchun@gmail.com>,
        Qi Zheng <zhengqi.arch@bytedance.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Aug 18, 2021 at 11:01 AM Roman Gushchin <guro@fb.com> wrote:
>
> On Sat, Aug 14, 2021 at 01:25:08PM +0800, Muchun Song wrote:
> > Pagecache pages are charged at the allocation time and holding a
> > reference to the original memory cgroup until being reclaimed.
> > Depending on the memory pressure, specific patterns of the page
> > sharing between different cgroups and the cgroup creation and
> > destruction rates, a large number of dying memory cgroups can be
> > pinned by pagecache pages. It makes the page reclaim less efficient
> > and wastes memory.
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
> >
> > Signed-off-by: Muchun Song <songmuchun@bytedance.com>
>
> I like the "move objcg stuff to memcg/css level" part.
>
> I'm less convinced about making byte-sized charging kmem-specific
> (both naming and #ifdef CONFIG_MEMCG_KMEM). Do we really win a lot?
>
> I understand why we might wanna compile out some checks from the
> hot allocation path, but few bytes in struct objcg will not make a big
> difference, as well as few lines of code in cgroup creation/removal paths.
>
> Also it might be useful for byte-sized accounting outside kmem, e.g. zswap.
> So, I'd remove this dependency and rename to something like
> obj_cgroup_release_bytes().

Got it. I'll do that in the next version. Thanks for your suggestions.

>
> In the long run we might wanna to eliminate CONFIG_MEMCG_KMEM completely,
> so let's at least not add new dependencies.

Got it.

>
> Thanks!
