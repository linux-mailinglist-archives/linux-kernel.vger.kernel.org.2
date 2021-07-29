Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9B8F53D9D65
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Jul 2021 08:01:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234044AbhG2GBM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 29 Jul 2021 02:01:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52974 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230223AbhG2GBL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Jul 2021 02:01:11 -0400
Received: from mail-pj1-x1029.google.com (mail-pj1-x1029.google.com [IPv6:2607:f8b0:4864:20::1029])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A70D3C061765
        for <linux-kernel@vger.kernel.org>; Wed, 28 Jul 2021 23:01:08 -0700 (PDT)
Received: by mail-pj1-x1029.google.com with SMTP id m1so8752779pjv.2
        for <linux-kernel@vger.kernel.org>; Wed, 28 Jul 2021 23:01:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=OgD5C61YbZ2KunWoqNcKnBbaf1qoas81IHhBsJLKfSM=;
        b=EnJl/Mx7QLBayu7Yl3kff+Gl9vL7axw9v4cntOhPsXkky2EN/GwFYc2ew6t5qU4Eh2
         Csmn/NjeHBKpt1ddqOD9UIPc6Y+5weNm9lJ10a2LP9l52vxd3KmJvfvv4pjj570xYZ2c
         6vgl2oDqrpEhPiidu4UN+GbhPO+VGurpaDrmVS9H7qqDQt03nEPD7vQzG9hFzVBG+VJy
         DnYKIPV4q9xCH+VnuBu4i9UFgJ8jBXx5mEyr59xxYIz+tHOdIoIR7/eYeKVljfdkTUPm
         VEvq0U525iIPHBay2MJF76CnO47yzAq93gYOmmAZAPnWb5eX0eWjmxxeRzlsq+EV/O1v
         Pp4g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=OgD5C61YbZ2KunWoqNcKnBbaf1qoas81IHhBsJLKfSM=;
        b=fWQeFDJh1+fnoD/pDgLOQar7N0U52EKRblGxslQfqVq40kl/VG+vRrZ3nznoFR5RVS
         r/vlawwfH1ijcD/5RF0+AR+DIgUlSvqsUhibTPG2WLQmF3nExKwQQK1lBnacl6gq6B+T
         j4eEgyc7Punvhvu1Lv4FeSXWxd6sqkxOGaKIGvzSDGsY0qUvP5zUdREjV7IFX/hRW/wJ
         VO8wAX9ZLXXX/+Mqlo6hCGEAAEsWVooYrU1a/hO4NZT6p7Ljgbh+qhMStsdd0WjkrFxg
         YDwPz6PlETm57IkaY1Jokky/yHGJseGOMCUWAiLTb43pRY8RP+etYzRbYg9TPd8sDt5X
         KFVQ==
X-Gm-Message-State: AOAM533nRpz1Nnv06M/PDcwVyWdVGAqjNPe811KbpizSTnjHqUntEWeO
        ARE0En3/3YMmfp/emXtcQcTWmKDIgHgrKe+JaR3scg==
X-Google-Smtp-Source: ABdhPJwgmmS8Q6Z8sSqxjFLXS+0lYHCYezXCZpuTpd9HoPdRfyijBwKfbyNCcV13ys534Nfd6x7nsXbkoqv2rbURjVE=
X-Received: by 2002:a17:902:6ac9:b029:12c:3bac:8d78 with SMTP id
 i9-20020a1709026ac9b029012c3bac8d78mr3101247plt.34.1627538468213; Wed, 28 Jul
 2021 23:01:08 -0700 (PDT)
MIME-Version: 1.0
References: <20210714091800.42645-1-songmuchun@bytedance.com>
 <20210714091800.42645-2-songmuchun@bytedance.com> <cf279a44-2a1a-6385-8230-86e083e11ba0@oracle.com>
 <CAMZfGtUtk9uyO7v0v94YqLaHhrZ-CoFvVH60n54apib7PHPcKw@mail.gmail.com>
In-Reply-To: <CAMZfGtUtk9uyO7v0v94YqLaHhrZ-CoFvVH60n54apib7PHPcKw@mail.gmail.com>
From:   Muchun Song <songmuchun@bytedance.com>
Date:   Thu, 29 Jul 2021 14:00:28 +0800
Message-ID: <CAMZfGtXmNSg2mNsdG20JDzZofMSdreYOiKCO1WQ+zAEomkozyw@mail.gmail.com>
Subject: Re: [PATCH 1/5] mm: introduce PAGEFLAGS_MASK to replace ((1UL <<
 NR_PAGEFLAGS) - 1)
To:     Mike Kravetz <mike.kravetz@oracle.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Oscar Salvador <osalvador@suse.de>,
        Michal Hocko <mhocko@suse.com>,
        "Song Bao Hua (Barry Song)" <song.bao.hua@hisilicon.com>,
        David Hildenbrand <david@redhat.com>,
        Chen Huang <chenhuang5@huawei.com>,
        "Bodeddula, Balasubramaniam" <bodeddub@amazon.com>,
        Jonathan Corbet <corbet@lwn.net>,
        Xiongchun duan <duanxiongchun@bytedance.com>,
        fam.zheng@bytedance.com, linux-doc@vger.kernel.org,
        LKML <linux-kernel@vger.kernel.org>,
        Linux Memory Management List <linux-mm@kvack.org>,
        Qi Zheng <zhengqi.arch@bytedance.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jul 27, 2021 at 2:27 PM Muchun Song <songmuchun@bytedance.com> wrote:
>
> On Tue, Jul 27, 2021 at 5:04 AM Mike Kravetz <mike.kravetz@oracle.com> wrote:
> >
> > On 7/14/21 2:17 AM, Muchun Song wrote:
> > > Instead of hard-coding ((1UL << NR_PAGEFLAGS) - 1) everywhere, introducing
> > > PAGEFLAGS_MASK to make the code clear to get the page flags.
> > >
> > > Signed-off-by: Muchun Song <songmuchun@bytedance.com>
> > > ---
> > >  include/linux/page-flags.h      | 4 +++-
> > >  include/trace/events/page_ref.h | 4 ++--
> > >  lib/test_printf.c               | 2 +-
> > >  lib/vsprintf.c                  | 2 +-
> > >  4 files changed, 7 insertions(+), 5 deletions(-)
> > >
> > > diff --git a/include/linux/page-flags.h b/include/linux/page-flags.h
> > > index 5922031ffab6..358d3f6fa976 100644
> > > --- a/include/linux/page-flags.h
> > > +++ b/include/linux/page-flags.h
> > > @@ -178,6 +178,8 @@ enum pageflags {
> > >       PG_reported = PG_uptodate,
> > >  };
> > >
> > > +#define PAGEFLAGS_MASK               (~((1UL << NR_PAGEFLAGS) - 1))
> >
> > Can you explain why you chose this definition instead of
> >
> > #define PAGEFLAGS_MASK          ((1UL << NR_PAGEFLAGS) - 1)
> >
> > and mostly use ~PAGEFLAGS_MASK below?
>
> Hi Mike,
>
> Actually, I learned from PAGE_MASK. So I thought the macro
> like xxx_MASK should be the format of 0x00...00ff...ff. I don't
                                           ^^^
Sorry. I mean 0xff...ff00...00 here.

> know if this is an unwritten rule. Please correct me if I am
> wrong.
>
> Thanks.
>
> > --
> > Mike Kravetz
