Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C653840F63E
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Sep 2021 12:50:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235249AbhIQKv0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 17 Sep 2021 06:51:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42354 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232848AbhIQKvY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Sep 2021 06:51:24 -0400
Received: from mail-pl1-x630.google.com (mail-pl1-x630.google.com [IPv6:2607:f8b0:4864:20::630])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 33DD7C061574
        for <linux-kernel@vger.kernel.org>; Fri, 17 Sep 2021 03:50:03 -0700 (PDT)
Received: by mail-pl1-x630.google.com with SMTP id l6so1162997plh.9
        for <linux-kernel@vger.kernel.org>; Fri, 17 Sep 2021 03:50:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance-com.20210112.gappssmtp.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=g4vyRKEIUiu45D51r7XhzUKkB2Cebq0r9MOFU5Rsk84=;
        b=05M06HYqKZipEP5EwPjCKhM17S57oJhsjjeabLjo7ThsmfwwgWobY39fx8bB4rbl5r
         f27qU39b3vBOJZbG5Szk3HYi9CKPk9HmvirYZhihSqbsKJhnhz3Kj4th257EoM3tjICC
         xdULXOelJcdTOTU9v4u/5QrcqdkZJMLU3+gBSskuI4ZfnnuBz61TIjJneTJ08QAEXEBp
         e5y6GUJwfRyeYA0UCVVJLLMwkbiyBopnJTq8cydpck21il7CMGs+KbZKyWGpVvqqNN5H
         PPCAm+aSVenlblAEpyY7rpgTitTgndDKEm0ExwLujAGaAitt44kgUgze/0tsWGMtqUVk
         xMGw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=g4vyRKEIUiu45D51r7XhzUKkB2Cebq0r9MOFU5Rsk84=;
        b=6m/ALxMGsZ/6coAmJ+4DbRv8c4sd+nGw7DYlg3pOXhTE2mkCwsdTDtPD8d69Xq4rAW
         7SScbKZstBbQnMZPtuDr1kU2lm7oESKzmjRr5ZzUPR2kJhH8Lk7ZnuJHyf32aKgsCDBr
         Kq0A9X2s7G/ACa2FyjRsJl/UbUy3qe02r2lpYq8+2v4ndTm6fpqFta3M8Kig6QFhw53x
         vCdg/amaHdKs4/RBiI7rLmwZjNSntIPes/Bo+Ks+mUHyVT+mKIqShdjpOdjoxFsNyoXE
         Zg9Z/M+XRH4WFMkv4grB4IxREbMEUVpqkiS0piMLwhp9XkkIeIiU5sAuEFWwFO6bgUrU
         3y/A==
X-Gm-Message-State: AOAM533n9jRZiAqZKURIBE1RMYigVatO8Ddbm1sWY+y+5drfXJGl+qZA
        oyRLNpSBn+FfuSCW1Er5SO9B7+uKY43St2Zxdxd6VA==
X-Google-Smtp-Source: ABdhPJzIXgbIS7KQ1Pi0ina81GvSAlcfS4Ljtx7M0muOzGWHB11wGZ9eu5Ct1nNNvUlsshQkgiBs4B+XrWZAdEpmTOQ=
X-Received: by 2002:a17:902:7107:b0:13d:93aa:a70a with SMTP id
 a7-20020a170902710700b0013d93aaa70amr827046pll.32.1631875802670; Fri, 17 Sep
 2021 03:50:02 -0700 (PDT)
MIME-Version: 1.0
References: <20210916134748.67712-1-songmuchun@bytedance.com> <YUPvVYFyBR/qwy2X@carbon.DHCP.thefacebook.com>
In-Reply-To: <YUPvVYFyBR/qwy2X@carbon.DHCP.thefacebook.com>
From:   Muchun Song <songmuchun@bytedance.com>
Date:   Fri, 17 Sep 2021 18:49:21 +0800
Message-ID: <CAMZfGtU42K0O+_KuuQ2untdYTiQet=W8K0m4+eh1CosJ96QL1Q@mail.gmail.com>
Subject: Re: [PATCH v2 00/13] Use obj_cgroup APIs to charge the LRU pages
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

On Fri, Sep 17, 2021 at 9:29 AM Roman Gushchin <guro@fb.com> wrote:
>
> Hi Muchun!
>
> On Thu, Sep 16, 2021 at 09:47:35PM +0800, Muchun Song wrote:
> > This version is rebased over linux 5.15-rc1, because Shakeel has asked me
> > if I could do that. I rework some code suggested by Roman as well in this
> > version. I have not removed the Acked-by tags which are from Roman, because
> > this version is not based on the folio relevant. If Roman wants me to
> > do this, please let me know, thanks.
>
> I'm fine with this, thanks for clarifying.
>
> >
> > Since the following patchsets applied. All the kernel memory are charged
> > with the new APIs of obj_cgroup.
> >
> >       [v17,00/19] The new cgroup slab memory controller[1]
> >       [v5,0/7] Use obj_cgroup APIs to charge kmem pages[2]
> >
> > But user memory allocations (LRU pages) pinning memcgs for a long time -
> > it exists at a larger scale and is causing recurring problems in the real
> > world: page cache doesn't get reclaimed for a long time, or is used by the
> > second, third, fourth, ... instance of the same job that was restarted into
> > a new cgroup every time. Unreclaimable dying cgroups pile up, waste memory,
> > and make page reclaim very inefficient.
>
> I've an idea: what if we use struct list_lru_memcg as an intermediate object
> between an individual page and struct mem_cgroup?
>
> It could contain a pointer to a memory cgroup structure (not even sure if a
> reference is needed), and a lru page can contain a pointer to the lruvec instead
> of memcg/objcg.

Hi Roman,

If I understand properly, here you mean the struct page has a pointer
to the struct lruvec not struct list_lru_memcg. What's the functionality
of the struct list_lru_memcg? Would you mind exposing more details?

>
> This approach can probably simplify the locking scheme. But what's more
> important, it can dramatically reduce the number of css_get()/put() calls.
> The latter are not particularly cheap after the deletion of a cgroup:
> they are atomic_dec()'s. As a result, the reclaim efficiency could be much
> better. The downside: we will need to update page->lruvec_memcg pointers on
> reparenting pages during the cgroup removal.

Here we need to update page->lruvec_memcg pointers one by one,
right? Because the lru lock is per lruvec, the locking scheme still need
to be as proposed by this series when the page->lruvec_memcg is
changed If I understand properly. It's likely that I don't get your point.
Looking forward to your further details.

Thanks.

>
> This is a rough idea, maybe there are significant reasons why it's not possible
> or will be way worse. But I think it's worth discussing. What do you think?
>
> Thanks!
