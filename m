Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E3BFC44BB97
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Nov 2021 07:19:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230071AbhKJGVz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 10 Nov 2021 01:21:55 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43240 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229572AbhKJGVy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 Nov 2021 01:21:54 -0500
Received: from mail-yb1-xb33.google.com (mail-yb1-xb33.google.com [IPv6:2607:f8b0:4864:20::b33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 75E5AC061764
        for <linux-kernel@vger.kernel.org>; Tue,  9 Nov 2021 22:19:07 -0800 (PST)
Received: by mail-yb1-xb33.google.com with SMTP id o12so3809018ybk.1
        for <linux-kernel@vger.kernel.org>; Tue, 09 Nov 2021 22:19:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance-com.20210112.gappssmtp.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=IjUT8zCp2aLFMQgSGnAyzSy9afXTEGUeSUT1uAZ7PO8=;
        b=v9Y/NbJGrZHSlykl99QODQr2L+E6A/yXZBeBI6qkRCLgq3bsOIp2K86NV5/7A2MCWO
         W5iIvM32RREMYIexhAKSHaabulV+5QCary78yorn8Bdqf/JV/KR5nDVwXmrIkMnAVJtp
         lJb5H2+JwqrgqysOJXa7oZtiNWZmz+3weCON1t/D7ptQpsGxFYpL1nPfmAevqYrLpxGX
         B3tzSoNjBm/UbNWh6Z44JTfXa4c8SsYCIcb8hnczY++B5QoKj2palcQ+u+q4n/PuU/I7
         /hcmU920o2jq57EE9RKaBfIgnHI3xyRpsZf/mzDfVAj45qDsEup1eaHpm648d/IJ+diT
         7eKA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=IjUT8zCp2aLFMQgSGnAyzSy9afXTEGUeSUT1uAZ7PO8=;
        b=j6TsgVxrwn7xizBDDlnBT2qhu3PCxt2aQ0RMxTv4+iugYJv+zlxtmUj7d0yYcuTzSG
         7JuZhoV9BWFGpraBPnXD69YGxSmzBpOPHkaNzVB29VNIPSV5QQcgCdvrmz+JjnFuMQK8
         y5qPi0NDUF3BZiTUFndihaxKXRTMQ28szky+XBV5Zcs+RV5Ufdf/oPgA4UjlER5ruPIH
         KPzcWYmaA8puVq8/dusFmfvHQtaEeTr9j99EyeEPaxde0VBy21jNeX+vcko4VAKFT7gN
         zvj5P6Z8EtbUv75KL30eWO9sfbAWfghxAiJ+Pc9BV2Vdn/2YcEKgVmdrXl4lGVvNj+4d
         tkmg==
X-Gm-Message-State: AOAM533BtdKvcKRHMKqTjInL6Te0QfVkIXuqGHJJee+Wpme0tJW8Fp/F
        1VEqJXN14UUlo5KtmC6auIAl/E30qQYvT35YER1tlg==
X-Google-Smtp-Source: ABdhPJyohPEpBCsDPpumT7620p3FFrCbW0oBZn8eKqR9DCKf+/LwgW+c7aCl7L981TDd4Nbz5zjOd52C8OBlwTDibwo=
X-Received: by 2002:a25:ef0b:: with SMTP id g11mr14790116ybd.404.1636525146779;
 Tue, 09 Nov 2021 22:19:06 -0800 (PST)
MIME-Version: 1.0
References: <20211101031651.75851-1-songmuchun@bytedance.com>
 <CAMZfGtUeL45=WG3ceaZ_tALMGZTLtuD9jbfKEzeQv270OnaLYQ@mail.gmail.com> <35c5217d-eb8f-6f70-544a-a3e8bd009a46@oracle.com>
In-Reply-To: <35c5217d-eb8f-6f70-544a-a3e8bd009a46@oracle.com>
From:   Muchun Song <songmuchun@bytedance.com>
Date:   Wed, 10 Nov 2021 14:18:28 +0800
Message-ID: <CAMZfGtW=e___8kpe1B5a1rK+SV63bP_Nwucj89QKaX4ZOMUpaw@mail.gmail.com>
Subject: Re: [PATCH v7 0/5] Free the 2nd vmemmap page associated with each
 HugeTLB page
To:     Mike Kravetz <mike.kravetz@oracle.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Oscar Salvador <osalvador@suse.de>,
        Michal Hocko <mhocko@suse.com>,
        David Hildenbrand <david@redhat.com>,
        Jonathan Corbet <corbet@lwn.net>,
        Matthew Wilcox <willy@infradead.org>,
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

On Tue, Nov 9, 2021 at 3:33 AM Mike Kravetz <mike.kravetz@oracle.com> wrote:
>
> On 11/8/21 12:16 AM, Muchun Song wrote:
> > On Mon, Nov 1, 2021 at 11:22 AM Muchun Song <songmuchun@bytedance.com> wrote:
> >>
> >> This series can minimize the overhead of struct page for 2MB HugeTLB pages
> >> significantly. It further reduces the overhead of struct page by 12.5% for
> >> a 2MB HugeTLB compared to the previous approach, which means 2GB per 1TB
> >> HugeTLB. It is a nice gain. Comments and reviews are welcome. Thanks.
> >>
> >
> > Hi,
> >
> > Ping guys. Does anyone have any comments or suggestions
> > on this series?
> >
> > Thanks.
> >
>
> I did look over the series earlier.  I have no issue with the hugetlb and
> vmemmap modifications as they are enhancements to the existing
> optimizations.  My primary concern is the (small) increased overhead
> for the helpers as outlined in your cover letter.  Since these helpers
> are not limited to hugetlb and used throughout the kernel, I would
> really like to get comments from others with a better understanding of
> the potential impact.

Thanks Mike. I'd like to hear others' comments about this as well.
From my point of view, maybe the (small) overhead is acceptable
since it only affects the head page, however Matthew Wilcox's folio
series could reduce this situation as well.

Looking forward to others' comments.

Thanks.

>
> --
> Mike Kravetz
