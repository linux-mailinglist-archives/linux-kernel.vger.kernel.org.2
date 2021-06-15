Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BB99A3A768A
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Jun 2021 07:37:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229968AbhFOFj6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 15 Jun 2021 01:39:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58714 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229463AbhFOFj5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Jun 2021 01:39:57 -0400
Received: from mail-pf1-x42d.google.com (mail-pf1-x42d.google.com [IPv6:2607:f8b0:4864:20::42d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0E64AC061767
        for <linux-kernel@vger.kernel.org>; Mon, 14 Jun 2021 22:37:53 -0700 (PDT)
Received: by mail-pf1-x42d.google.com with SMTP id c12so12406530pfl.3
        for <linux-kernel@vger.kernel.org>; Mon, 14 Jun 2021 22:37:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=FROCF/wehWqD3D+6TzCI2mXkvIl9M441mZJuZdDzK5Q=;
        b=sWMapGlebjinzHy8S1SJ63upE5HLeUenezmsTf8ZuxsdEh1oylFjkPZza80YHRIZbG
         o1gfoPV9PJJ9ppaoTP2ozMm3qpZE26qzkV7XXJQhotmRyZ95CHQCJkZqzobFl9yX0CH5
         Vp/y5Q9rkXjTbgF0TFlQ98MH9BMQ+dyw3ROljUIuJsMgZCkgiFNJLanAYqAmlqHYHUTm
         uZk22YWDdfOh5h1FlztHOARvhmCndatsoPBvxqQcPzNjTbsB3r55kSMbSQy9VwdyhNyo
         gCSzXI8QL75s3xzrRxFO9qzLMhxOLGNgyHI9eN4Wq5v73mzubJVY3Qfg3bQMrbY8IReW
         vziQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=FROCF/wehWqD3D+6TzCI2mXkvIl9M441mZJuZdDzK5Q=;
        b=I6wc7AUxg8iaWPA+hHeApR8LS9B4Duawn2J4toz2PeLkLvgzO/s5n5l6+V5znboeBU
         Ij0UqTjm79AEcRmLtYu7kgnDgjvg+zgSDvdzMO+xj8Mn837coTZ50IK73uzI0cxfeozx
         EEHT7p1YT9jUpwew1gP9RF15k/iIYb/QqnWa56U7MZnqobl1oVDSifV/B2hguavxMx7m
         QO2eka61YYDDRnqHoyXo8FFH/bKBWXWwBcfTryMC5cTdGnPuMGzPvHT7k4xa8ujwDPaE
         WYy790gPNv7KIQKMJgC++ka97aC6T6bLh2YfIKKyKWFrOFd0GWG1Zc6Kp5QKHcBFZRDU
         c0Eg==
X-Gm-Message-State: AOAM531q5oEkY9QKtEOvQmCZ6T5Lxp54YajaV1y9OGVm4r6if+ZSHyyX
        PTNqHSHbVlR9ThHvCBoGcIrO67VGSC0o/b06P2yfCw==
X-Google-Smtp-Source: ABdhPJy1FKxWnBv2dwbVWwFRbgPWHeFLWIv1SaMfnwhWm1Gf6b9YEMIUKsaPiU/D0WXoX++kUUtDhWqeI+OUWrTlZjY=
X-Received: by 2002:aa7:96fc:0:b029:2e9:e827:928f with SMTP id
 i28-20020aa796fc0000b02902e9e827928fmr2646011pfq.49.1623735472353; Mon, 14
 Jun 2021 22:37:52 -0700 (PDT)
MIME-Version: 1.0
References: <20210612094555.71344-1-songmuchun@bytedance.com>
 <20210614181237.5513724624dde3ac930b75d8@linux-foundation.org> <fe65a409-b989-5e05-952e-6fcf6aa2ab55@oracle.com>
In-Reply-To: <fe65a409-b989-5e05-952e-6fcf6aa2ab55@oracle.com>
From:   Muchun Song <songmuchun@bytedance.com>
Date:   Tue, 15 Jun 2021 13:37:15 +0800
Message-ID: <CAMZfGtU3=9JUVj5a7fFo_1K18yOcU4+9c5R2goXVwsGGJxLvNw@mail.gmail.com>
Subject: Re: [External] Re: [PATCH v2 0/3] Split huge PMD mapping of vmemmap pages
To:     Mike Kravetz <mike.kravetz@oracle.com>,
        Andrew Morton <akpm@linux-foundation.org>
Cc:     Oscar Salvador <osalvador@suse.de>, Michal Hocko <mhocko@suse.com>,
        "Song Bao Hua (Barry Song)" <song.bao.hua@hisilicon.com>,
        David Hildenbrand <david@redhat.com>,
        Chen Huang <chenhuang5@huawei.com>,
        "Bodeddula, Balasubramaniam" <bodeddub@amazon.com>,
        Jonathan Corbet <corbet@lwn.net>,
        Xiongchun duan <duanxiongchun@bytedance.com>,
        fam.zheng@bytedance.com, linux-doc@vger.kernel.org,
        LKML <linux-kernel@vger.kernel.org>,
        Linux Memory Management List <linux-mm@kvack.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jun 15, 2021 at 11:52 AM Mike Kravetz <mike.kravetz@oracle.com> wrote:
>
> On 6/14/21 6:12 PM, Andrew Morton wrote:
> > On Sat, 12 Jun 2021 17:45:52 +0800 Muchun Song <songmuchun@bytedance.com> wrote:
> >
> >> In order to reduce the difficulty of code review in series[1]. We disable
> >> huge PMD mapping of vmemmap pages when that feature is enabled. In this
> >> series, we do not disable huge PMD mapping of vmemmap pages anymore. We
> >> will split huge PMD mapping when needed. When HugeTLB pages are freed from
> >> the pool we do not attempt coalasce and move back to a PMD mapping because
> >> it is much more complex.
> >>
> >> [1] https://lore.kernel.org/linux-doc/20210510030027.56044-1-songmuchun@bytedance.com/
> >
> > [1] had a nice [0/n] description but the v2 series lost that.  I could
> > copy/paste the v1 changelogging but I am unsure that it has been
> > maintained appropriately for the v2 series.
> >
> > I think I'll pass on this v2 pending additional review input.  Please reinstate
> > the [0/n] overview if/when resending?
>
> There may be some confusion.
>
> This series is a follow on optimization for the functionality provided by
> [1].  Early in the development of [1], it was decided to drop some code
> for ease of review.  Specifically, splitting vmemmap PMD mappings to PTE
> mappings as required when hugetlb pages were allocated.  The
> 'simplification' in [1] is that if the feature is enabled then vmemmap
> will only be mapped with PTEs.
>
> This series provides the ability to split PMD mappings 'on demand' as
> hugetlb pages are allocated.  As mentioned, it really is a follow on and
> optimization to functionality provided in [1].  As such, I am not sure
> that repeating the [0/n] description from 1 is necessary here.
>
> In any case, this should be clearly stated in the [0/n] description of
> this series.

Thanks for the clarification for me. I totally agree with you.

>
> BTW- I did get through the series today, and did not discover any
> issues.  However, I want to sleep on it before signing off.
> --
> Mike Kravetz
