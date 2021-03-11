Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3DE78336C57
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Mar 2021 07:37:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231203AbhCKGhE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 11 Mar 2021 01:37:04 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42600 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229958AbhCKGgm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 11 Mar 2021 01:36:42 -0500
Received: from mail-pj1-x102b.google.com (mail-pj1-x102b.google.com [IPv6:2607:f8b0:4864:20::102b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 56009C061760
        for <linux-kernel@vger.kernel.org>; Wed, 10 Mar 2021 22:36:42 -0800 (PST)
Received: by mail-pj1-x102b.google.com with SMTP id t18so2958997pjs.3
        for <linux-kernel@vger.kernel.org>; Wed, 10 Mar 2021 22:36:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=F3D6jkjfAIdhrcFMdi8lIAUvY2kCMaCF37DRtFS3gwM=;
        b=nOvanrDQRINbuSw4dRh8vVphBVe9aAu/9Now9LsoOkZB0ka8L0/xyHDeINBijT2p48
         Bl6Qi42KUg2hSIfAMA65+wQ17uAKciMMtotFCUC8I8/tRp1ktYzSaJeCXai4pUy5JJfd
         VxTNycFVz0i3cyPuZb8AVXLl+VwkWviQN+6CBTfXraaM8qVpp0eOoHNHWNhgFuR96uYO
         v5qdaB6VkSYkRwoOnhxWZb7+nXR6t+PUpXg8G7dHaJjKEKYisgZ8bNr6NubB9dgN6pLz
         Kan/5cXaAPa/ALyCphqr+4nEz77HQbg1TyOQrpnyU7f50n3AOBbl5YZOgByLNBY9vFN4
         J3XQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=F3D6jkjfAIdhrcFMdi8lIAUvY2kCMaCF37DRtFS3gwM=;
        b=ufI8ZnCwGjfeR2uLPcsu1iqo0epArp3DzfqSL4c/RVTJopncBn26O4048dsLX8SRR3
         TL7fH72sFwaSBSC9v6lw8sT6NWAYSYh5yc2D+C6ZnCX1Hfl4AE5T+ou7rezbFAzZWJRC
         LgQ7xzYGwNG8KnqCFl1obK3q+h33piPAKeHOTT/R+onkBaAAvuVFkLfAR1dYdI8ZzGMP
         GtdnKIAqfSUMYMGJl3dyRLSXVOoClGohjRs3UdAwBbAu3FUhW2No+DHqEh7Iz4nBoktx
         5yXZNWFQrgN8VZDIGQwOVBOkf89OhKf8Y62aHgcaEvzOuuxG1g/YJnHP7tjhR7c9rkk1
         LeuQ==
X-Gm-Message-State: AOAM532748gOkW90HFyX3TeZ7TZM6+CTtkv70cKOX04TxfBzetqj2Bng
        tWU/nFI4ej8Ul/2lbCTQrZWEKoyYUG2lpl9hh4hcIQ==
X-Google-Smtp-Source: ABdhPJyuvjbucZ4H5bOplCMAaZBYTLRCk/7ZefVaR7LNivXYFib9KTRuXnuCJe66IQ2aHfi43ZJ30KxMKzxzVn9P4D4=
X-Received: by 2002:a17:90a:901:: with SMTP id n1mr7489410pjn.147.1615444601814;
 Wed, 10 Mar 2021 22:36:41 -0800 (PST)
MIME-Version: 1.0
References: <20210308102807.59745-1-songmuchun@bytedance.com>
 <20210308102807.59745-7-songmuchun@bytedance.com> <YEjnpwN8eDlyc08+@dhcp22.suse.cz>
In-Reply-To: <YEjnpwN8eDlyc08+@dhcp22.suse.cz>
From:   Muchun Song <songmuchun@bytedance.com>
Date:   Thu, 11 Mar 2021 14:36:03 +0800
Message-ID: <CAMZfGtVBqQNg_p6HBUFJYSK0ZrPDhGEk2T2muyecHwi=OOHZRA@mail.gmail.com>
Subject: Re: [External] Re: [PATCH v18 6/9] mm: hugetlb: add a kernel
 parameter hugetlb_free_vmemmap
To:     Michal Hocko <mhocko@suse.com>
Cc:     Jonathan Corbet <corbet@lwn.net>,
        Mike Kravetz <mike.kravetz@oracle.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, bp@alien8.de, x86@kernel.org,
        hpa@zytor.com, dave.hansen@linux.intel.com, luto@kernel.org,
        Peter Zijlstra <peterz@infradead.org>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Andrew Morton <akpm@linux-foundation.org>, paulmck@kernel.org,
        mchehab+huawei@kernel.org, pawan.kumar.gupta@linux.intel.com,
        Randy Dunlap <rdunlap@infradead.org>, oneukum@suse.com,
        anshuman.khandual@arm.com, jroedel@suse.de,
        Mina Almasry <almasrymina@google.com>,
        David Rientjes <rientjes@google.com>,
        Matthew Wilcox <willy@infradead.org>,
        Oscar Salvador <osalvador@suse.de>,
        "Song Bao Hua (Barry Song)" <song.bao.hua@hisilicon.com>,
        David Hildenbrand <david@redhat.com>,
        =?UTF-8?B?SE9SSUdVQ0hJIE5BT1lBKOWggOWPoyDnm7TkuZ8p?= 
        <naoya.horiguchi@nec.com>,
        Joao Martins <joao.m.martins@oracle.com>,
        Xiongchun duan <duanxiongchun@bytedance.com>,
        linux-doc@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>,
        Linux Memory Management List <linux-mm@kvack.org>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        Miaohe Lin <linmiaohe@huawei.com>,
        Chen Huang <chenhuang5@huawei.com>,
        Bodeddula Balasubramaniam <bodeddub@amazon.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Mar 10, 2021 at 11:37 PM Michal Hocko <mhocko@suse.com> wrote:
>
> On Mon 08-03-21 18:28:04, Muchun Song wrote:
> > Add a kernel parameter hugetlb_free_vmemmap to enable the feature of
> > freeing unused vmemmap pages associated with each hugetlb page on boot.
> >
> > We disables PMD mapping of vmemmap pages for x86-64 arch when this
> > feature is enabled. Because vmemmap_remap_free() depends on vmemmap
> > being base page mapped.
> >
> > Signed-off-by: Muchun Song <songmuchun@bytedance.com>
> > Reviewed-by: Oscar Salvador <osalvador@suse.de>
> > Reviewed-by: Barry Song <song.bao.hua@hisilicon.com>
> > Reviewed-by: Miaohe Lin <linmiaohe@huawei.com>
> > Tested-by: Chen Huang <chenhuang5@huawei.com>
> > Tested-by: Bodeddula Balasubramaniam <bodeddub@amazon.com>
> > ---
> >  Documentation/admin-guide/kernel-parameters.txt | 14 ++++++++++++++
> >  Documentation/admin-guide/mm/hugetlbpage.rst    |  3 +++
> >  arch/x86/mm/init_64.c                           |  8 ++++++--
> >  include/linux/hugetlb.h                         | 19 +++++++++++++++++++
> >  mm/hugetlb_vmemmap.c                            | 24 ++++++++++++++++++++++++
> >  5 files changed, 66 insertions(+), 2 deletions(-)
> >
> > diff --git a/Documentation/admin-guide/kernel-parameters.txt b/Documentation/admin-guide/kernel-parameters.txt
> > index 04545725f187..de91d54573c4 100644
> > --- a/Documentation/admin-guide/kernel-parameters.txt
> > +++ b/Documentation/admin-guide/kernel-parameters.txt
> > @@ -1557,6 +1557,20 @@
> >                       Documentation/admin-guide/mm/hugetlbpage.rst.
> >                       Format: size[KMG]
> >
> > +     hugetlb_free_vmemmap=
> > +                     [KNL] When CONFIG_HUGETLB_PAGE_FREE_VMEMMAP is set,
> > +                     this controls freeing unused vmemmap pages associated
> > +                     with each HugeTLB page. When this option is enabled,
> > +                     we disable PMD/huge page mapping of vmemmap pages which
> > +                     increase page table pages. So if a user/sysadmin only
> > +                     uses a small number of HugeTLB pages (as a percentage
> > +                     of system memory), they could end up using more memory
> > +                     with hugetlb_free_vmemmap on as opposed to off.
> > +                     Format: { on | off (default) }
>
> Please note this is an admin guide and for those this seems overly low

OK.

> level. I would use something like the following
>                         [KNL] Reguires CONFIG_HUGETLB_PAGE_FREE_VMEMMAP
>                         enabled.
>                         Allows heavy hugetlb users to free up some more
>                         memory (6 * PAGE_SIZE for each 2MB hugetlb
>                         page).
>                         This feauture is not free though. Large page
>                         tables are not use to back vmemmap pages which
>                         can lead to a performance degradation for some
>                         workloads. Also there will be memory allocation
>                         required when hugetlb pages are freed from the
>                         pool which can lead to corner cases under heavy
>                         memory pressure.

Very thanks. I will update this.

> > +
> > +                     on:  enable the feature
> > +                     off: disable the feature
> > +
> >       hung_task_panic=
> >                       [KNL] Should the hung task detector generate panics.
> >                       Format: 0 | 1
> --
> Michal Hocko
> SUSE Labs
