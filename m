Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3C00C3107A7
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Feb 2021 10:23:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229824AbhBEJUk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 5 Feb 2021 04:20:40 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42552 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230034AbhBEJRu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 5 Feb 2021 04:17:50 -0500
Received: from mail-pl1-x62a.google.com (mail-pl1-x62a.google.com [IPv6:2607:f8b0:4864:20::62a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5BB28C06121D
        for <linux-kernel@vger.kernel.org>; Fri,  5 Feb 2021 01:16:52 -0800 (PST)
Received: by mail-pl1-x62a.google.com with SMTP id y10so3245891plk.7
        for <linux-kernel@vger.kernel.org>; Fri, 05 Feb 2021 01:16:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=JKBbTXlpTBr2zkO3oY2VYzHBYqP1g9U9wb97XhjPk3c=;
        b=j7JyuYJPrQMqeqz2xvLh4JkheheodV0fbqZ+U5Nyi+WlHItSQ/S5FhNeMvX3ErJFo0
         a/uKfBqkKYGqTHCIzbz3OIxi7IAwIL/dtcEPj0yabvtrpkv+ac86EWgnu9iWMwThbY/9
         kkrEPfq+wxD2BEgUDga2Ap10+8GrkdtO8FEw4+ZOXdNiMGKXbCcKs7nKu7BbSHSMlSwW
         WSVqrtQfbeD1UOBLKhUXbi9V7gfRLUS9H/v5W/tixV7HKePviu+pHr5lINyLf8GwRVC4
         gxUFexvRlUBrJsm87ZD+E7EbrSmvltyn5C2GCAgHlgIq78Y0gsThcpTFsa2q0k3MMa2y
         3dwQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=JKBbTXlpTBr2zkO3oY2VYzHBYqP1g9U9wb97XhjPk3c=;
        b=fp4nlGnyYo9Q1DvOLyF2E8zyJBHUHvKo4E+ybykIU7Grjhyz5TGA5Bw3RSD7MUp0iX
         gii0obqd02lwA1DNV0ThVZpx57IvdIfc8kciGvINLec4yZquOPtaNa8T0d8tBWKbe0fa
         w9s5RnBh4YJf6pqaBr62ZzYmCeA1QiD5fbpQv9YlE/uCuFNpgxHr4nDZBtijepTkTKin
         48jGvCnK02m/3U3YApDb7B6kv0sJF18OrLP/LI/uckBhjI0/qdt3gH5csLVPNKU/CnGZ
         MiWB1Dwe9BJoFFbe/cK07NR3y0SEFnd7zlw4BrEacVTaoL4tolgCd/eMFiWE0pTZqcBb
         w9tw==
X-Gm-Message-State: AOAM532i05X4/a5RCoopavjjVulJqikfbL5gvbrU7kgFIFnEGdcanbsa
        JwJoIxLxbtN15ZeChNTIyCAmBz88CKduceM72oWUrA==
X-Google-Smtp-Source: ABdhPJxZ6G6+qg2ZmOZzWsRNHh2l3AmLgDkONGW2As0+kb3WJmj4TRcnH8wewkq5uTSX/8vKKt1X+HLNb6wSWA/XJ6M=
X-Received: by 2002:a17:90b:1096:: with SMTP id gj22mr3172401pjb.229.1612516611919;
 Fri, 05 Feb 2021 01:16:51 -0800 (PST)
MIME-Version: 1.0
References: <20210204035043.36609-1-songmuchun@bytedance.com>
 <20210204035043.36609-9-songmuchun@bytedance.com> <20210205090924.GA14537@linux>
In-Reply-To: <20210205090924.GA14537@linux>
From:   Muchun Song <songmuchun@bytedance.com>
Date:   Fri, 5 Feb 2021 17:16:14 +0800
Message-ID: <CAMZfGtUWo9=ca9dzE1--uHYQ-9Az3cbxy6v4Kn6pcHGZ04zcfg@mail.gmail.com>
Subject: Re: [External] Re: [PATCH v14 8/8] mm: hugetlb: optimize the code
 with the help of the compiler
To:     Oscar Salvador <osalvador@suse.de>
Cc:     Jonathan Corbet <corbet@lwn.net>,
        Mike Kravetz <mike.kravetz@oracle.com>,
        Thomas Gleixner <tglx@linutronix.de>, mingo@redhat.com,
        bp@alien8.de, x86@kernel.org, hpa@zytor.com,
        dave.hansen@linux.intel.com, luto@kernel.org,
        Peter Zijlstra <peterz@infradead.org>, viro@zeniv.linux.org.uk,
        Andrew Morton <akpm@linux-foundation.org>, paulmck@kernel.org,
        mchehab+huawei@kernel.org, pawan.kumar.gupta@linux.intel.com,
        Randy Dunlap <rdunlap@infradead.org>, oneukum@suse.com,
        anshuman.khandual@arm.com, jroedel@suse.de,
        Mina Almasry <almasrymina@google.com>,
        David Rientjes <rientjes@google.com>,
        Matthew Wilcox <willy@infradead.org>,
        Michal Hocko <mhocko@suse.com>,
        "Song Bao Hua (Barry Song)" <song.bao.hua@hisilicon.com>,
        David Hildenbrand <david@redhat.com>,
        =?UTF-8?B?SE9SSUdVQ0hJIE5BT1lBKOWggOWPoyDnm7TkuZ8p?= 
        <naoya.horiguchi@nec.com>,
        Xiongchun duan <duanxiongchun@bytedance.com>,
        linux-doc@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>,
        Linux Memory Management List <linux-mm@kvack.org>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Feb 5, 2021 at 5:09 PM Oscar Salvador <osalvador@suse.de> wrote:
>
> On Thu, Feb 04, 2021 at 11:50:43AM +0800, Muchun Song wrote:
> > We cannot optimize if a "struct page" crosses page boundaries. If
> > it is true, we can optimize the code with the help of a compiler.
> > When free_vmemmap_pages_per_hpage() returns zero, most functions are
> > optimized by the compiler.
>
> "When the "struct page size" crosses page boundaries we cannot
>  make use of this feature.
>  Let free_vmemmap_pages_per_hpage() return zero if that is the case,
>  most of the functions can be optimized away."
>
> I think the above is more clear, but just a suggestion.

OK. I will use it. Thanks for your suggestions.

>
>
> > Signed-off-by: Muchun Song <songmuchun@bytedance.com>
>
> Reviewed-by: Oscar Salvador <osalvador@suse.de>

Thanks.

>
> > ---
> >  include/linux/hugetlb.h |  3 ++-
> >  mm/hugetlb_vmemmap.c    | 13 +++++++++++++
> >  2 files changed, 15 insertions(+), 1 deletion(-)
> >
> > diff --git a/include/linux/hugetlb.h b/include/linux/hugetlb.h
> > index 822ab2f5542a..7bfb06e16298 100644
> > --- a/include/linux/hugetlb.h
> > +++ b/include/linux/hugetlb.h
> > @@ -878,7 +878,8 @@ extern bool hugetlb_free_vmemmap_enabled;
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
> > index 8efad9978821..068d0e0cebc8 100644
> > --- a/mm/hugetlb_vmemmap.c
> > +++ b/mm/hugetlb_vmemmap.c
> > @@ -211,6 +211,12 @@ early_param("hugetlb_free_vmemmap", early_hugetlb_free_vmemmap_param);
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
> >
> > @@ -280,6 +286,13 @@ void __init hugetlb_vmemmap_init(struct hstate *h)
> >       BUILD_BUG_ON(NR_USED_SUBPAGE >=
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
> > --
> > 2.11.0
> >
> >
>
> --
> Oscar Salvador
> SUSE L3
