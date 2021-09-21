Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 34D6D413358
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Sep 2021 14:29:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232686AbhIUMav (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 21 Sep 2021 08:30:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36626 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232525AbhIUMau (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Sep 2021 08:30:50 -0400
Received: from mail-ed1-x535.google.com (mail-ed1-x535.google.com [IPv6:2a00:1450:4864:20::535])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2CCADC061574;
        Tue, 21 Sep 2021 05:29:22 -0700 (PDT)
Received: by mail-ed1-x535.google.com with SMTP id h17so73825551edj.6;
        Tue, 21 Sep 2021 05:29:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=mbQXhXJLxiALHPsfWwZoPdiHBMG4EPZlanGbXM6TrrM=;
        b=baKpv2CEQS/tWKSPdcjaZsJUei28bzthQ7wJ1ePEcZ3JJlZIAULTW/3nZdMiYDLdfW
         +YekTDQqJPhGI2jqYzpV9EbL3mfkN740ZLQArVoqun6fNVUEkwNs9Gk5X2FrMr0RySUq
         TZ/Codo2apB+mxzZaYSbhyTvUDBQSrmAG8y+dn/LnpJ+e5QfuABfnyQDaxRHtSvEyNUI
         hunf9m0fToie6bVSTjFimIBOtvZK4McN1GCQNiarh5zpLDpHZGiKbPtWogB1hG72+O/t
         Kk18r47775dvNMB7qHra7yNLr8tnkAxM7Gp/9Y/lY0FlNAGTXIIVJEevNzE/k/09N7UH
         LwAQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=mbQXhXJLxiALHPsfWwZoPdiHBMG4EPZlanGbXM6TrrM=;
        b=Dr9HFDj2TxI+VFO3rUE4UaIJoCd6jJC6wv1tt/ZqWA4eIIaK3CRVpbLZlyKauoTHSN
         /WM4ne+45YMjcRPFhI54KlUempbl6AuF/s5ulNdKMyu+svni+DCFiTbKOgNnsQH/OQDv
         7IwX1UHXRDdycYyJxZEHmbvLdwKd2KJUH0/ftXtSPpL+QrI7WUFHgzr0KjCBAe4ooOVn
         9DAjAS/9mIQ3gIa8l690gc42JceTieHraJAkIL2FZuvWquv6hb2sz0noIlDT+zM2h5xB
         f+f5dJksN4iRSlE63yrMX1KVnsP4m1EP/RNvyNj+ILS3UuETc4U0O6ZnP6qTDZ4JH+Ts
         V+Mg==
X-Gm-Message-State: AOAM533Bi4lAYXe5SIh1W9WH0kVbnkjix9If0eIy6NCVkqPWEhiq18J5
        xivlliZSZhhwbD5wYsFH2SSx4hsK19QIswryOE0=
X-Google-Smtp-Source: ABdhPJyQTWjcPqp60EDkICjrXxsIMbI22Rwm4PP/8SMqWZ4RD4eogg+BeifcA4Q7OIoQMr32lSfTIBj1sVjrtEtQsFs=
X-Received: by 2002:a17:906:dbe5:: with SMTP id yd5mr33947014ejb.134.1632227342091;
 Tue, 21 Sep 2021 05:29:02 -0700 (PDT)
MIME-Version: 1.0
References: <20210917034815.80264-1-songmuchun@bytedance.com>
 <20210917034815.80264-5-songmuchun@bytedance.com> <CAGsJ_4wW6b5aC4va1_BZuWLqxzRkSi3vLcyJo7XGMbVi8i7iuw@mail.gmail.com>
 <CAMZfGtVtU2zWYJB1U_Q4AMBb5vYysT2MC06qsA5u0T6FrpbW1g@mail.gmail.com>
In-Reply-To: <CAMZfGtVtU2zWYJB1U_Q4AMBb5vYysT2MC06qsA5u0T6FrpbW1g@mail.gmail.com>
From:   Barry Song <21cnbao@gmail.com>
Date:   Tue, 21 Sep 2021 12:28:51 +1200
Message-ID: <CAGsJ_4zDKVkXf60d4ZPZjFJBN5L8wR1_57D_EUEzGZWcYhxn=A@mail.gmail.com>
Subject: Re: [PATCH RESEND v2 4/4] selftests: vm: add a hugetlb test case
To:     Muchun Song <songmuchun@bytedance.com>
Cc:     Mike Kravetz <mike.kravetz@oracle.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Oscar Salvador <osalvador@suse.de>,
        Michal Hocko <mhocko@suse.com>,
        Barry Song <song.bao.hua@hisilicon.com>,
        David Hildenbrand <david@redhat.com>,
        Chen Huang <chenhuang5@huawei.com>,
        "Bodeddula, Balasubramaniam" <bodeddub@amazon.com>,
        Jonathan Corbet <corbet@lwn.net>,
        Matthew Wilcox <willy@infradead.org>,
        Xiongchun duan <duanxiongchun@bytedance.com>,
        fam.zheng@bytedance.com, Muchun Song <smuchun@gmail.com>,
        Qi Zheng <zhengqi.arch@bytedance.com>,
        linux-doc@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>,
        Linux-MM <linux-mm@kvack.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Sep 21, 2021 at 2:26 AM Muchun Song <songmuchun@bytedance.com> wrote:
>
> On Sat, Sep 18, 2021 at 1:20 PM Barry Song <21cnbao@gmail.com> wrote:
> >
> > On Sat, Sep 18, 2021 at 12:08 AM Muchun Song <songmuchun@bytedance.com> wrote:
> > >
> > > Since the head vmemmap page frame associated with each HugeTLB page is
> > > reused, we should hide the PG_head flag of tail struct page from the
> > > user. Add a tese case to check whether it is work properly.
> > >
> >
> > TBH, I am a bit confused. I was thinking about some kernel unit tests to make
> > sure those kernel APIs touched by this patchset are still working as before.
> > This userspace test, while certainly useful for checking the content of page
> > frames as expected, doesn't directly prove things haven't changed.
> >
> > In patch 1/4, a couple of APIs have the fixup for the fake head issue.
> > Do you think a test like the below would be more sensible?
> > 1. alloc 2MB hugeTLB
>
> It is done in main().
>
> > 2. get each page frame
> > 3. apply those APIs in each page frame
> > 4. Those APIs work completely the same as before.
>
> Reading the flags of a page by /proc/kpageflags is done
> in stable_page_flags(), which has invoked PageHead(),
> PageTail(), PageCompound() and compound_head().
> If those APIs work properly, the head page must have
> 15 and 17 bits set. And tail pages must have 16 and 17
> bits set but 15 unset.
>
> So I think check_page_flags() has done the step 2 to 4.
> What do you think?

yes. Thanks for your explanation. thereby, I think we just need some doc
here to explain what it is checking. something like
/*
 * pages other than the first page must be tail and shouldn't be head;
 * this also verifies kernel has correctly set the fake page_head to tail
 * while hugetlb_free_vmemmap is enabled
 */
+       for (i = 1; i < MAP_LENGTH / PAGE_SIZE; i++) {
+               read(fd, &pageflags, sizeof(pageflags));
+               if ((pageflags & TAIL_PAGE_FLAGS) != TAIL_PAGE_FLAGS ||
+                   (pageflags & HEAD_PAGE_FLAGS) == HEAD_PAGE_FLAGS) {
+                       close(fd);
+                       printf("Tail page flags (%lx) is invalid\n", pageflags);
+                       return -1;
+               }
+       }
>
> Thanks.

Thanks
barry
