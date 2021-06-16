Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3FC383A8F1E
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Jun 2021 05:05:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230055AbhFPDHY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 15 Jun 2021 23:07:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40060 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229782AbhFPDHV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Jun 2021 23:07:21 -0400
Received: from mail-pj1-x1030.google.com (mail-pj1-x1030.google.com [IPv6:2607:f8b0:4864:20::1030])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DB53EC061574
        for <linux-kernel@vger.kernel.org>; Tue, 15 Jun 2021 20:05:15 -0700 (PDT)
Received: by mail-pj1-x1030.google.com with SMTP id 13-20020a17090a08cdb029016eed209ca4so900093pjn.1
        for <linux-kernel@vger.kernel.org>; Tue, 15 Jun 2021 20:05:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=a++J1PMBGBktLaOqH7rcncrGjqzf1ZkNaFZTKcuqOmg=;
        b=PBDVjpnGeQjL0GbK+kJfVZDwd13zhSVfA+zXL4laYr2r9iV/YeXhChI8tcOzWH1eLa
         kke1FNxpvG5QB82Sp1sYT1J0AHLWwrHzL/kZXPqbP15rd2ck3zDKZ7r2TLgR/PAchmJv
         C6XapUnh6QI4SNPiUC6IaCgUgc8jfhmW1l800X5iEOjSjKgji//5ORvyN2TjQI8zVxar
         fs0pMrb3VaB9SVDDvKAXdRM4zMI2aI+w0fP0DYqBDA12v3vudFOhQF+fXMru/u+EWNdr
         eRokD9ZQJmgmLDjR0HL1JzUK255+kJUPzSErcLIH1xxQaFGqZclIyRee+VHBWjRMWRBv
         u9Uw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=a++J1PMBGBktLaOqH7rcncrGjqzf1ZkNaFZTKcuqOmg=;
        b=Y0ajvP/2frGZgUmjJmlqFs0MsyKftPad6Xf5dvD3J9y+gAi0WtSv1XIzQ5kPxTIc1H
         3877axqYt5bg1xPnvqKzicpp/L7mJBXZNJoWfCvgevYKzTdTL6k9Lc/Uu2kkhsTz53G0
         y4fXTq8r476qJBWpz3Hs0NbwakttxDamcDf0z+n7vBRsCwED4ufJUggLlPfsCwmV+qTV
         1smlfTp7znn3YbEtpp8U/Ttux/gw3MQRlx3+/w476rdRTloV9XpSHaZ0Q9Jh9yMht7wU
         FlDGd5SaQNiUu8Ok46KzcCcm7AW9AGTlNRvObXQNA86l3Mw4fZZVEAeJ4MrbJIxgZpIi
         5YFw==
X-Gm-Message-State: AOAM532/Jw7mt747Ef3gEA3cOVXtmD2ZUuttysowpeV5SzRAj1hQOMVc
        0/HJpc10Plk8oLIhRCv1WkYl8dNyDTrf7pHx3XQDFA==
X-Google-Smtp-Source: ABdhPJxcrQKBVPmxTPOqvQe15Lg6Siqe8aXWeDtbXRx48e1+OI13Zs12efSGLpfe5LblWFf9O2+3OeSHFlK4JkkyIwM=
X-Received: by 2002:a17:90a:10c8:: with SMTP id b8mr8378091pje.147.1623812715259;
 Tue, 15 Jun 2021 20:05:15 -0700 (PDT)
MIME-Version: 1.0
References: <20210612094555.71344-1-songmuchun@bytedance.com>
 <20210612094555.71344-4-songmuchun@bytedance.com> <3fffaa5e-246e-00bf-5972-54eeb6330a43@oracle.com>
In-Reply-To: <3fffaa5e-246e-00bf-5972-54eeb6330a43@oracle.com>
From:   Muchun Song <songmuchun@bytedance.com>
Date:   Wed, 16 Jun 2021 11:04:37 +0800
Message-ID: <CAMZfGtUPbGRO6fNgRkkGWgUDGgRY3-ijsV6ur=VfnDc9baV2Cg@mail.gmail.com>
Subject: Re: [External] Re: [PATCH v2 3/3] mm: hugetlb: introduce CONFIG_HUGETLB_PAGE_FREE_VMEMMAP_DEFAULT_ON
To:     Joao Martins <joao.m.martins@oracle.com>
Cc:     Xiongchun duan <duanxiongchun@bytedance.com>,
        fam.zheng@bytedance.com, linux-doc@vger.kernel.org,
        LKML <linux-kernel@vger.kernel.org>,
        Linux Memory Management List <linux-mm@kvack.org>,
        Mike Kravetz <mike.kravetz@oracle.com>,
        Chen Huang <chenhuang5@huawei.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Oscar Salvador <osalvador@suse.de>,
        Michal Hocko <mhocko@suse.com>,
        "Song Bao Hua (Barry Song)" <song.bao.hua@hisilicon.com>,
        David Hildenbrand <david@redhat.com>,
        Jonathan Corbet <corbet@lwn.net>,
        "Bodeddula, Balasubramaniam" <bodeddub@amazon.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jun 16, 2021 at 7:01 AM Joao Martins <joao.m.martins@oracle.com> wrote:
>
>
>
> On 6/12/21 10:45 AM, Muchun Song wrote:
> > When using HUGETLB_PAGE_FREE_VMEMMAP, the freeing unused vmemmap pages
> > associated with each HugeTLB page is default off. Now the vmemmap is PMD
> > mapped. So there is no side effect when this feature is enabled with no
> > HugeTLB pages in the system. Someone may want to enable this feature in
> > the compiler time instead of using boot command line. So add a config to
> > make it default on when someone do not want to enable it via command line.
> >
> > Signed-off-by: Muchun Song <songmuchun@bytedance.com>
> > ---
> >  Documentation/admin-guide/kernel-parameters.txt |  3 +++
> >  fs/Kconfig                                      | 10 ++++++++++
> >  mm/hugetlb_vmemmap.c                            |  6 ++++--
> >  3 files changed, 17 insertions(+), 2 deletions(-)
> >
> > diff --git a/Documentation/admin-guide/kernel-parameters.txt b/Documentation/admin-guide/kernel-parameters.txt
> > index a01aadafee38..8eee439d943c 100644
> > --- a/Documentation/admin-guide/kernel-parameters.txt
> > +++ b/Documentation/admin-guide/kernel-parameters.txt
> > @@ -1604,6 +1604,9 @@
> >                       on:  enable the feature
> >                       off: disable the feature
> >
> > +                     Built with CONFIG_HUGETLB_PAGE_FREE_VMEMMAP_DEFAULT_ON=y,
> > +                     the default is on.
> > +
> >                       This is not compatible with memory_hotplug.memmap_on_memory.
> >                       If both parameters are enabled, hugetlb_free_vmemmap takes
> >                       precedence over memory_hotplug.memmap_on_memory.
> > diff --git a/fs/Kconfig b/fs/Kconfig
> > index f40b5b98f7ba..e78bc5daf7b0 100644
> > --- a/fs/Kconfig
> > +++ b/fs/Kconfig
> > @@ -245,6 +245,16 @@ config HUGETLB_PAGE_FREE_VMEMMAP
> >       depends on X86_64
> >       depends on SPARSEMEM_VMEMMAP
> >
> Now that you have no longer have the directmap in basepages limitation, I suppose you no
> longer need explicit arch support for HUGETLB_PAGE_FREE_VMEMMAP right?
>
> If so, I suppose you might be able to remove the 'depends on X86_64' part and "gain"
> ARM64, PPC, etc support.

You are right. This is the next step I want to do. Also, include IA64 and RISCV.

>
>         Joao
