Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CA40A336D29
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Mar 2021 08:35:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231842AbhCKHe6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 11 Mar 2021 02:34:58 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54862 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231700AbhCKHd6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 11 Mar 2021 02:33:58 -0500
Received: from mail-pf1-x42d.google.com (mail-pf1-x42d.google.com [IPv6:2607:f8b0:4864:20::42d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D150CC061574
        for <linux-kernel@vger.kernel.org>; Wed, 10 Mar 2021 23:33:57 -0800 (PST)
Received: by mail-pf1-x42d.google.com with SMTP id b23so5273827pfo.8
        for <linux-kernel@vger.kernel.org>; Wed, 10 Mar 2021 23:33:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=PRwM5iGLtwZBTnG8om/++s86+EBuCATUoQNKFoo4Vus=;
        b=CokBfhYF94Mz/PQxCgAws4A6RnAg0Rhfn9RMSb1BX25wrdmVgzZPCbYYIxXJsmHYTB
         6BcvY6NwLwD/zR8WjrkD3uwQoFPwbW0tZstyoG2ypygIGqNezSd3TZDlyvtp3+41WOvb
         RCUT10zMp6cIjsMD7ae40s5aJBwKeeF9OoEtxpcEcGejDlUgFs2FldnIlJWtAd6FjlnV
         IZIoVrE5M+CqvBAxr1FFevb45gI6JqjyJB8C6qfxmMFb3ebPKuoVrdpQmUeW/4FrwHQd
         sdOgA4hUun59ScPunvN91nYpGcjbNf1hb57ZrFnSDtR6hccNAT76r99kAVbsAFlzFjFZ
         O09A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=PRwM5iGLtwZBTnG8om/++s86+EBuCATUoQNKFoo4Vus=;
        b=PVG2wXdDT7fQu0MC0XB9G0EfNtMpttes0+mR4bNOW3ll8hzWhqpPJRVZ9rsow1uruF
         n1XZ/LT5Kk25ByjmfMsNBvRAiURnzi/KbDN59J2AoDJGz4z9PaYguqPM18dKfIg2sCyv
         f7OZ9WVjat9EOCIcrtirM/FtJgKmAGZwPnxO9U/dS7uwEInRVPi272I/CtT0mO3YaFAX
         vJs1rOQfLCtDgVCsOcfj9gqJy9h2HJLRKsr4GMqRg7YtMMf1SjDOWLXoWorVl2xBTlAF
         +ITkjY8RSro4EL328gUCSvmwmYnxx6s/x8wah7tiAOgyPinaGRe4hT2GHgjwlDV/XNTx
         XGaw==
X-Gm-Message-State: AOAM533Daeh7ZoVu4yJaUo4WdoXHINRh5QkvBlUZ+EOhtjxWIriWuLB0
        Td3wbdaA/9T8fKJrU3klLIQcehCuu6KF06wwilwBTQ==
X-Google-Smtp-Source: ABdhPJxI8OpzzjMHc+EojMt4EpAQ1I5fSlulun0k4KemCXO9upjJHTPuwi6LSd+hznDbn0zA0DfJtSI2TRcL1/7lLY4=
X-Received: by 2002:a63:141e:: with SMTP id u30mr6322639pgl.31.1615448037407;
 Wed, 10 Mar 2021 23:33:57 -0800 (PST)
MIME-Version: 1.0
References: <20210308102807.59745-1-songmuchun@bytedance.com>
 <20210308102807.59745-10-songmuchun@bytedance.com> <YEjoozshsvKeMAAu@dhcp22.suse.cz>
In-Reply-To: <YEjoozshsvKeMAAu@dhcp22.suse.cz>
From:   Muchun Song <songmuchun@bytedance.com>
Date:   Thu, 11 Mar 2021 15:33:20 +0800
Message-ID: <CAMZfGtV1Fp1RiQ64c9RrMmZ+=EwjGRHjwL8Wx3Q0YRWbbKF6xg@mail.gmail.com>
Subject: Re: [External] Re: [PATCH v18 9/9] mm: hugetlb: optimize the code
 with the help of the compiler
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

On Wed, Mar 10, 2021 at 11:41 PM Michal Hocko <mhocko@suse.com> wrote:
>
> On Mon 08-03-21 18:28:07, Muchun Song wrote:
> > When the "struct page size" crosses page boundaries we cannot
> > make use of this feature. Let free_vmemmap_pages_per_hpage()
> > return zero if that is the case, most of the functions can be
> > optimized away.
>
> I am confused. Don't you check for this in early_hugetlb_free_vmemmap_param already?

Right.

> Why do we need any runtime checks?

If the size of the struct page is not power of 2, compiler can think
is_hugetlb_free_vmemmap_enabled() always return false. So
the code snippet of this user can be optimized away.

E.g.

if (is_hugetlb_free_vmemmap_enabled())
        /* do something */

The compiler can drop "/* do something */" directly, because
it knows is_hugetlb_free_vmemmap_enabled() always returns
false.

Thanks.

>
> > Signed-off-by: Muchun Song <songmuchun@bytedance.com>
> > Reviewed-by: Miaohe Lin <linmiaohe@huawei.com>
> > Reviewed-by: Oscar Salvador <osalvador@suse.de>
> > Tested-by: Chen Huang <chenhuang5@huawei.com>
> > Tested-by: Bodeddula Balasubramaniam <bodeddub@amazon.com>
> > ---
> >  include/linux/hugetlb.h | 3 ++-
> >  mm/hugetlb_vmemmap.c    | 7 +++++++
> >  mm/hugetlb_vmemmap.h    | 6 ++++++
> >  3 files changed, 15 insertions(+), 1 deletion(-)
> >
> > diff --git a/include/linux/hugetlb.h b/include/linux/hugetlb.h
> > index c70421e26189..333dd0479fc2 100644
> > --- a/include/linux/hugetlb.h
> > +++ b/include/linux/hugetlb.h
> > @@ -880,7 +880,8 @@ extern bool hugetlb_free_vmemmap_enabled;
> >
> >  static inline bool is_hugetlb_free_vmemmap_enabled(void)
> >  {
> > -     return hugetlb_free_vmemmap_enabled;
> > +     return hugetlb_free_vmemmap_enabled &&
> > +            is_power_of_2(sizeof(struct page));
> >  }
> >  #else
> >  static inline bool is_hugetlb_free_vmemmap_enabled(void)
> > diff --git a/mm/hugetlb_vmemmap.c b/mm/hugetlb_vmemmap.c
> > index 33e42678abe3..1ba1ef45c48c 100644
> > --- a/mm/hugetlb_vmemmap.c
> > +++ b/mm/hugetlb_vmemmap.c
> > @@ -265,6 +265,13 @@ void __init hugetlb_vmemmap_init(struct hstate *h)
> >       BUILD_BUG_ON(__NR_USED_SUBPAGE >=
> >                    RESERVE_VMEMMAP_SIZE / sizeof(struct page));
> >
> > +     /*
> > +      * The compiler can help us to optimize this function to null
> > +      * when the size of the struct page is not power of 2.
> > +      */
> > +     if (!is_power_of_2(sizeof(struct page)))
> > +             return;
> > +
> >       if (!hugetlb_free_vmemmap_enabled)
> >               return;
> >
> > diff --git a/mm/hugetlb_vmemmap.h b/mm/hugetlb_vmemmap.h
> > index cb2bef8f9e73..29aaaf7b741e 100644
> > --- a/mm/hugetlb_vmemmap.h
> > +++ b/mm/hugetlb_vmemmap.h
> > @@ -21,6 +21,12 @@ void hugetlb_vmemmap_init(struct hstate *h);
> >   */
> >  static inline unsigned int free_vmemmap_pages_per_hpage(struct hstate *h)
> >  {
> > +     /*
> > +      * This check aims to let the compiler help us optimize the code as
> > +      * much as possible.
> > +      */
> > +     if (!is_power_of_2(sizeof(struct page)))
> > +             return 0;
> >       return h->nr_free_vmemmap_pages;
> >  }
> >  #else
> > --
> > 2.11.0
> >
>
> --
> Michal Hocko
> SUSE Labs
