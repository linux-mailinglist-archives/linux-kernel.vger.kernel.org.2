Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 668D345889D
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Nov 2021 05:22:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231656AbhKVEZQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 21 Nov 2021 23:25:16 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50948 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230218AbhKVEZO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 21 Nov 2021 23:25:14 -0500
Received: from mail-yb1-xb30.google.com (mail-yb1-xb30.google.com [IPv6:2607:f8b0:4864:20::b30])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DE80BC061714
        for <linux-kernel@vger.kernel.org>; Sun, 21 Nov 2021 20:22:08 -0800 (PST)
Received: by mail-yb1-xb30.google.com with SMTP id v7so46671364ybq.0
        for <linux-kernel@vger.kernel.org>; Sun, 21 Nov 2021 20:22:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance-com.20210112.gappssmtp.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=mQsLjE4VGO0GATJ9B+7NKTiNyNHw6FkgFYmoa5dRxaE=;
        b=n2wxVyb1ktE/Q3z6Up43RPvke0doMGm7LsaT1A3inEXXo7bAW8Rv4agR9gFi4nxpYu
         QpRn+MB5CK+ksrmTA+vEFDRq+SBlaSnERuN8x4q3V87cSyalGIW1H8AcPIJ4ySa+il2C
         Upg+Ir/DKLdh+MGVdQoFBfT7pZJK8map2eTu3cqgYtA7UwZniDV+rcTlfYTduQ+X+Eja
         tmkpNU07wpIZbPVIoo+oG6Ca04ao5Wt+ny9hrx553Sh6afvyRqrtpfPs7M0bW39UqWzd
         7ZwNKkjK4iru7FuLlVJ3F4JesEcJ7S+GspwGvM98J5bnSys3BhVg54PZWfIIyQIJlK1K
         TxBA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=mQsLjE4VGO0GATJ9B+7NKTiNyNHw6FkgFYmoa5dRxaE=;
        b=Pd+6XUlZmnkmXEzqPknRnaKXWsVGWJ9X8QSBPM4oxSldyQ/prXGcRFsBqxq5Bv4Jeb
         1LEgB9uD6YHeOCb1t0UN7hR5lBxzbso+HOs61C2v7URPhaWwVzs6leZSygPYhgHkSIRD
         rEGMb+9OjSU21tp09Fr1VJJ0umOJ2PP6SMPX/ifsjs5zhELGEhEUPVVokgQIGcaklIyw
         kLW+Eqo12WaJJBd8S3J0omKdidQUr27F4Bs0ZdnEJCrtLzVbHpw8V3xQiRYPTfBEYMM2
         buKzOmYBPcGDAHxsAx7S37G+SEyhZ8ZaNAw0axDWIF1dJJrhxRERtQrsXWsiyMUJFsrF
         w6rw==
X-Gm-Message-State: AOAM533JcWYvCZK1uL7VIyzQdYJvAfHZLK4AQpwpTmw9yth4/1S6Edtp
        EMQ3SVG/7VCZYZHPPR29D+TtLighh/1DvSOvlWSmFw==
X-Google-Smtp-Source: ABdhPJxkQANMOc1KWaxVyyp66k2Es4bDOOEupiGo2PTdTOZqGNwZC04+EYiUjduPrrRpVNzw4kkPbidwB/luXt/4NV0=
X-Received: by 2002:a05:6902:1144:: with SMTP id p4mr3480817ybu.189.1637554928109;
 Sun, 21 Nov 2021 20:22:08 -0800 (PST)
MIME-Version: 1.0
References: <20211101031651.75851-1-songmuchun@bytedance.com>
 <CAMZfGtUeL45=WG3ceaZ_tALMGZTLtuD9jbfKEzeQv270OnaLYQ@mail.gmail.com>
 <35c5217d-eb8f-6f70-544a-a3e8bd009a46@oracle.com> <CAMZfGtW=e___8kpe1B5a1rK+SV63bP_Nwucj89QKaX4ZOMUpaw@mail.gmail.com>
In-Reply-To: <CAMZfGtW=e___8kpe1B5a1rK+SV63bP_Nwucj89QKaX4ZOMUpaw@mail.gmail.com>
From:   Muchun Song <songmuchun@bytedance.com>
Date:   Mon, 22 Nov 2021 12:21:32 +0800
Message-ID: <CAMZfGtV0JKcjVL0qGoYCQJ-LsXdng7Z2UjBym5hf_WM0LcYi=Q@mail.gmail.com>
Subject: Re: [PATCH v7 0/5] Free the 2nd vmemmap page associated with each
 HugeTLB page
To:     Mike Kravetz <mike.kravetz@oracle.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Oscar Salvador <osalvador@suse.de>,
        David Hildenbrand <david@redhat.com>,
        Michal Hocko <mhocko@suse.com>,
        Matthew Wilcox <willy@infradead.org>
Cc:     Jonathan Corbet <corbet@lwn.net>,
        Xiongchun duan <duanxiongchun@bytedance.com>,
        fam.zheng@bytedance.com, Muchun Song <smuchun@gmail.com>,
        Qi Zheng <zhengqi.arch@bytedance.com>,
        linux-doc@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>,
        Linux Memory Management List <linux-mm@kvack.org>,
        "Song Bao Hua (Barry Song)" <song.bao.hua@hisilicon.com>,
        Barry Song <21cnbao@gmail.com>,
        Chen Huang <chenhuang5@huawei.com>,
        "Bodeddula, Balasubramaniam" <bodeddub@amazon.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Nov 10, 2021 at 2:18 PM Muchun Song <songmuchun@bytedance.com> wrote:
>
> On Tue, Nov 9, 2021 at 3:33 AM Mike Kravetz <mike.kravetz@oracle.com> wrote:
> >
> > On 11/8/21 12:16 AM, Muchun Song wrote:
> > > On Mon, Nov 1, 2021 at 11:22 AM Muchun Song <songmuchun@bytedance.com> wrote:
> > >>
> > >> This series can minimize the overhead of struct page for 2MB HugeTLB pages
> > >> significantly. It further reduces the overhead of struct page by 12.5% for
> > >> a 2MB HugeTLB compared to the previous approach, which means 2GB per 1TB
> > >> HugeTLB. It is a nice gain. Comments and reviews are welcome. Thanks.
> > >>
> > >
> > > Hi,
> > >
> > > Ping guys. Does anyone have any comments or suggestions
> > > on this series?
> > >
> > > Thanks.
> > >
> >
> > I did look over the series earlier.  I have no issue with the hugetlb and
> > vmemmap modifications as they are enhancements to the existing
> > optimizations.  My primary concern is the (small) increased overhead
> > for the helpers as outlined in your cover letter.  Since these helpers
> > are not limited to hugetlb and used throughout the kernel, I would
> > really like to get comments from others with a better understanding of
> > the potential impact.
>
> Thanks Mike. I'd like to hear others' comments about this as well.
> From my point of view, maybe the (small) overhead is acceptable
> since it only affects the head page, however Matthew Wilcox's folio
> series could reduce this situation as well.
>
> Looking forward to others' comments.
>

Ping guys.

Hi Andrew,

Do you have any suggestions on this series to move it on?

Thanks.
