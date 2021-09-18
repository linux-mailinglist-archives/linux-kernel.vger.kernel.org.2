Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 174AF4104EA
	for <lists+linux-kernel@lfdr.de>; Sat, 18 Sep 2021 09:55:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243400AbhIRH5J (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 18 Sep 2021 03:57:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43336 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233741AbhIRH5F (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 18 Sep 2021 03:57:05 -0400
Received: from mail-pj1-x1031.google.com (mail-pj1-x1031.google.com [IPv6:2607:f8b0:4864:20::1031])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D0D3BC061574
        for <linux-kernel@vger.kernel.org>; Sat, 18 Sep 2021 00:55:41 -0700 (PDT)
Received: by mail-pj1-x1031.google.com with SMTP id k23-20020a17090a591700b001976d2db364so9058126pji.2
        for <linux-kernel@vger.kernel.org>; Sat, 18 Sep 2021 00:55:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance-com.20210112.gappssmtp.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Y3Gvwx2bn9q0G9QM9HtT1I3LdyzvpbTk56Q2HZWRQvk=;
        b=cSP90aMO2q4sng5CrQIbgmWUuF3Dfzb3aMv9iWZT5xVTRyW5/+MW39tP8PO0V/BaZj
         574H29DSVkfXBEoM/XcsBQ+DOiU9XBBhdEjJyW3NMOdLulC+/bHMZ5fhQrLFjJVRzz5S
         HFb9Axoh1wy0VKi66yA8MHA0O6tF0aPM540ztW7uvH7Xfgsgj/GTrX1kMeoP/xnXaIj9
         Yes97w46LeuhoghG0vN0VWV5BrT/Ld7+sMiJsoL8uSfV1M+rhmxItmScbCyDBEZiQVwM
         YJyeD1QPTfrBElUA1NQWyaPozyNC+n23TnY3SrjM8AwQlPQJipVLbShFLVIBjTHMlIWy
         ckVg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Y3Gvwx2bn9q0G9QM9HtT1I3LdyzvpbTk56Q2HZWRQvk=;
        b=nGEYxFOTrLz0SwWrWV5hbrhxRUyCuL3RyhZqAfFajJZIRvZTdp4vNxGvTWOZ94gfWQ
         Imha9jkLD52ddlpEz5Pcac+QYGCachPi9ONJjh2cN0Qqv60r8KROQxbn8zQrCDHisqzS
         EK6kvg0Cr2gb8MfGmGfBkCMv2p3D/msT1Wbj7kMORg7/NvjiWlW5fSqwUBN4SqVFBRNY
         4Sc6rm4dV6mFHBFmMtnRercdbooOCQegZ66TJM4/bwcfyJFw07jmlX8/ov/wDddNvaCR
         USTFAQ/dtkugOGYu6pGw9Z7B5lPGvmvCB/rnSz5Kz8Z8WE1Jj1QZdYZ4IYodYmpkvGKF
         HnPQ==
X-Gm-Message-State: AOAM530k9K/m61FbjOofVpoH1se/D1cyU55qS0W0W9e+Zo6kFAOcSnib
        zpu2Uez0+rGhtDJ3E5/nacO3Rk8yYA2vEmZtctGFNg==
X-Google-Smtp-Source: ABdhPJzAFBToLyzQTBujVXVXDzoO5yiLXzBNiThQTHNwMKNZTfyeNrfFVx9YaR0Lu+dglyPBXsakAZ4JPp/tO3SpPd0=
X-Received: by 2002:a17:90b:1807:: with SMTP id lw7mr13397776pjb.217.1631951741155;
 Sat, 18 Sep 2021 00:55:41 -0700 (PDT)
MIME-Version: 1.0
References: <20210916134748.67712-1-songmuchun@bytedance.com>
 <YUPvVYFyBR/qwy2X@carbon.DHCP.thefacebook.com> <CAMZfGtU42K0O+_KuuQ2untdYTiQet=W8K0m4+eh1CosJ96QL1Q@mail.gmail.com>
 <YUUvOhX4Yk2xuGTu@carbon.dhcp.thefacebook.com>
In-Reply-To: <YUUvOhX4Yk2xuGTu@carbon.dhcp.thefacebook.com>
From:   Muchun Song <songmuchun@bytedance.com>
Date:   Sat, 18 Sep 2021 15:55:02 +0800
Message-ID: <CAMZfGtWoiEOjDauJcK+cd_EKztvam9PSb1ghPkTyvw1tNJ-bzw@mail.gmail.com>
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

On Sat, Sep 18, 2021 at 8:13 AM Roman Gushchin <guro@fb.com> wrote:
>
> On Fri, Sep 17, 2021 at 06:49:21PM +0800, Muchun Song wrote:
> > On Fri, Sep 17, 2021 at 9:29 AM Roman Gushchin <guro@fb.com> wrote:
> > >
> > > Hi Muchun!
> > >
> > > On Thu, Sep 16, 2021 at 09:47:35PM +0800, Muchun Song wrote:
> > > > This version is rebased over linux 5.15-rc1, because Shakeel has asked me
> > > > if I could do that. I rework some code suggested by Roman as well in this
> > > > version. I have not removed the Acked-by tags which are from Roman, because
> > > > this version is not based on the folio relevant. If Roman wants me to
> > > > do this, please let me know, thanks.
> > >
> > > I'm fine with this, thanks for clarifying.
> > >
> > > >
> > > > Since the following patchsets applied. All the kernel memory are charged
> > > > with the new APIs of obj_cgroup.
> > > >
> > > >       [v17,00/19] The new cgroup slab memory controller[1]
> > > >       [v5,0/7] Use obj_cgroup APIs to charge kmem pages[2]
> > > >
> > > > But user memory allocations (LRU pages) pinning memcgs for a long time -
> > > > it exists at a larger scale and is causing recurring problems in the real
> > > > world: page cache doesn't get reclaimed for a long time, or is used by the
> > > > second, third, fourth, ... instance of the same job that was restarted into
> > > > a new cgroup every time. Unreclaimable dying cgroups pile up, waste memory,
> > > > and make page reclaim very inefficient.
> > >
> > > I've an idea: what if we use struct list_lru_memcg as an intermediate object
> > > between an individual page and struct mem_cgroup?
> > >
> > > It could contain a pointer to a memory cgroup structure (not even sure if a
> > > reference is needed), and a lru page can contain a pointer to the lruvec instead
> > > of memcg/objcg.
>
> lruvec_memcg I mean.

Thanks for your clarification.

>
> >
> > Hi Roman,
> >
> > If I understand properly, here you mean the struct page has a pointer
> > to the struct lruvec not struct list_lru_memcg. What's the functionality
> > of the struct list_lru_memcg? Would you mind exposing more details?
>
> So the basic idea is simple: a lru page charged to a memcg is associated with
> a per-memcg lruvec (list_lru_memcg), which is associated with a memory cgroup.
> And after your patches there is a second link of associations: page to objcg
> to memcg:
>
> 1) page->objcg->memcg
> 2) page->list_lru_memcg->memcg
>
> (those are not necessarily direct pointers, but generally speaking, relations).
>
> My gut feeling is that if we can merge them into just 2) and use list_lru_memcg
> as an intermediate object between pages and memory cgroups, the whole thing can
> be more efficient and beautiful.
>
> Yes, on reparenting we'd need to scan over all pages in the lru list, but
> hopefully we can do it from a worker context. And it's not such a big deal as
> with slab objects, where we simple had no list of all objects.

struct list_lru_memcg seems to be redundant, it just contains a pointer
to struct mem_cgroup. We need to update each page->lruvec_memcg,
why not update page->memcg_data directly to its parent memcg?

The update of page->lruvec_memcg should be under both child and
parent's lruvec lock, right? I suppose scanning over all pages may be
a problem if there are many pages.

Thanks.

>
> Again, I'm not 100% sure if it's possible and worth it, so it shouldn't block
> your patchset if everybody else like it.
>
> Thanks
