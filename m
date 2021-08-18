Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A61213EF942
	for <lists+linux-kernel@lfdr.de>; Wed, 18 Aug 2021 06:28:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232450AbhHRE3Q (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 18 Aug 2021 00:29:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50088 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229448AbhHRE3P (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Aug 2021 00:29:15 -0400
Received: from mail-pg1-x52b.google.com (mail-pg1-x52b.google.com [IPv6:2607:f8b0:4864:20::52b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 106B9C061764
        for <linux-kernel@vger.kernel.org>; Tue, 17 Aug 2021 21:28:41 -0700 (PDT)
Received: by mail-pg1-x52b.google.com with SMTP id x4so930681pgh.1
        for <linux-kernel@vger.kernel.org>; Tue, 17 Aug 2021 21:28:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=M4OMUrZpxJEGBppNP6I6AWvsCoN2WAaAil0LMMI5r7w=;
        b=YGtvo4t4xs4zqvtZ50FJJp/fthSkuSt28mL+68Mg+C6c/viofJiHvmRcp0QO3rdzof
         1/4droGy6AFsOeCm6LjfKInmaKmO7NCUzWuuAjKbuKqhKBBLmf3f2xRinXEp7GnSqEZs
         TqNHxqK8YnzTBGYxzn9imexx5V9BncTlx1ettwwtFd4mu+ji3j4QCC/CNLNG5A4ppnsW
         nvRMCrbGZWdoqH+bweKmgW0+G6GZrX30zfNZY6wabsy2SrdUppH5p/L9mgg49/MY2nER
         5awbSp50/gfxfQKlhJMvNa4RE9IPiQVYMdz5Vaqn4lY3usCmoKW8edO4QhMPT9I7kgYV
         hH6w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=M4OMUrZpxJEGBppNP6I6AWvsCoN2WAaAil0LMMI5r7w=;
        b=JMkgJK5j3qeBingPSXuTum5tBmDmEbnpLgCQNDiZHX0JEY2WaJdqfGng+nMo+E1+C1
         bxt+NR5Sl3O9Ps5NQDtzeoXYSs8CkXrKd6oIHORKHQATwtoCIXaGaeMnzBlAONiVMICA
         a3UFZ7aA4LK7jFMS4msr3Rk7nYobeOXU+U3wxRthjvNNNCzLbLTK+b0FaxOYh6yXmb9l
         zHr3TCean1XZdZ/wsFQ8dl8FTQqNxf4yKcuNDsbm4BeXm/BnMugv9PCWa5qd4jjOPdbZ
         G+npE9ODvjJcwMzGJuzMi5KNTTSWVXPh0L65lNqOgfNqV5NjvweR3nZ/1sTdOE0ZfV3V
         Y/Jg==
X-Gm-Message-State: AOAM5334WbQHc3wOw+jVA3LvVrcpEGsiTxDmj2hbDccZf+bf9PqEj++X
        mMCcQihO59gQW3rHedrXHBjQlLjA1wL1RfJggjtbOg==
X-Google-Smtp-Source: ABdhPJzS7aro7xemGhZ/swsjZFolSNdOJiyUhcWH5G61FbbOY6yFGtv4AhGW+idHpc5sL2zDwUsyjMcQx3UtMw/sRsM=
X-Received: by 2002:a63:f804:: with SMTP id n4mr6884502pgh.341.1629260920403;
 Tue, 17 Aug 2021 21:28:40 -0700 (PDT)
MIME-Version: 1.0
References: <20210814052519.86679-1-songmuchun@bytedance.com>
 <20210814052519.86679-4-songmuchun@bytedance.com> <YRx76SlTkTT8a1BI@carbon.dhcp.thefacebook.com>
In-Reply-To: <YRx76SlTkTT8a1BI@carbon.dhcp.thefacebook.com>
From:   Muchun Song <songmuchun@bytedance.com>
Date:   Wed, 18 Aug 2021 12:28:02 +0800
Message-ID: <CAMZfGtWhQcfFwkTq59ZboHe5iaLqeGhb9M8GzjEMWZwwYxB43w@mail.gmail.com>
Subject: Re: [PATCH v1 03/12] mm: memcontrol: make lruvec lock safe when LRU
 pages are reparented
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

On Wed, Aug 18, 2021 at 11:18 AM Roman Gushchin <guro@fb.com> wrote:
>
> On Sat, Aug 14, 2021 at 01:25:10PM +0800, Muchun Song wrote:
> > The diagram below shows how to make the folio lruvec lock safe when LRU
> > pages are reparented.
> >
> > folio_lruvec_lock(folio)
> >     retry:
> >       lruvec = folio_lruvec(folio);
> >
> >         // The folio is reparented at this time.
> >         spin_lock(&lruvec->lru_lock);
> >
> >         if (unlikely(lruvec_memcg(lruvec) != folio_memcg(folio)))
> >             // Acquired the wrong lruvec lock and need to retry.
> >             // Because this folio is on the parent memcg lruvec list.
> >             goto retry;
> >
> >         // If we reach here, it means that folio_memcg(folio) is stable.
> >
> > memcg_reparent_objcgs(memcg)
> >     // lruvec belongs to memcg and lruvec_parent belongs to parent memcg.
> >     spin_lock(&lruvec->lru_lock);
> >     spin_lock(&lruvec_parent->lru_lock);
> >
> >     // Move all the pages from the lruvec list to the parent lruvec list.
> >
> >     spin_unlock(&lruvec_parent->lru_lock);
> >     spin_unlock(&lruvec->lru_lock);
> >
> > After we acquire the lruvec lock, we need to check whether the folio is
> > reparented. If so, we need to reacquire the new lruvec lock. On the
> > routine of the LRU pages reparenting, we will also acquire the lruvec
> > lock (will be implemented in the later patch). So folio_memcg() cannot
> > be changed when we hold the lruvec lock.
> >
> > Since lruvec_memcg(lruvec) is always equal to folio_memcg(folio) after
> > we hold the lruvec lock, lruvec_memcg_debug() check is pointless. So
> > remove it.
> >
> > This is a preparation for reparenting the LRU pages.
> >
> > Signed-off-by: Muchun Song <songmuchun@bytedance.com>
> > Acked-by: Roman Gushchin <guro@fb.com>
>
> Maybe it's mostly s/page/folio, but the patch looks quite differently
> in comparison to the version I did ack. In general, please, drop acks
> when there are significant changes between versions.

Got it. I'll drop all acks in the next version. Thanks.

>
> Thanks!
