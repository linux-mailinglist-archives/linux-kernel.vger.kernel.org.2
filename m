Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B5B4F4032F2
	for <lists+linux-kernel@lfdr.de>; Wed,  8 Sep 2021 05:36:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344596AbhIHDhK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 7 Sep 2021 23:37:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52438 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231151AbhIHDhI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Sep 2021 23:37:08 -0400
Received: from mail-qk1-x72d.google.com (mail-qk1-x72d.google.com [IPv6:2607:f8b0:4864:20::72d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9E676C061575
        for <linux-kernel@vger.kernel.org>; Tue,  7 Sep 2021 20:36:01 -0700 (PDT)
Received: by mail-qk1-x72d.google.com with SMTP id c10so882063qko.11
        for <linux-kernel@vger.kernel.org>; Tue, 07 Sep 2021 20:36:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=va3qLF49mXwo2qEKOYCT81K5dNv0miga50Xk8uaUMHc=;
        b=KdFL2XFD5/y5UwVa42KQwzyaksZ6R0j6vfMdoPNDGiqtscT87XuhFWe7Bw2HcANZPJ
         Kj4h3YGm+qvilaHkb4WiTwOKk1mYH32xrMTe3PLgRqupy3xMKS8uCA22um4n+ZTZtxx6
         7Bv90uxICb/SeAs/zhLfY4H5x77SD2eNPaqlSCxGGXzmeqbZ8uQsgDpXanJX2LOhpNmO
         PiiFYAjYlZUfd6hcOM1BJJ7e5l2+6K3NDcj3WVpN8mJNIyGoiQ1SWGtB6QxcbZVaM1if
         rSgLKVDwk4kK94LG3C+BHpFF4Hz+WoppdBuq7neV82VuzPQQQWG/qutHVAXhPlXQbiOk
         VxwA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=va3qLF49mXwo2qEKOYCT81K5dNv0miga50Xk8uaUMHc=;
        b=s5EozvYN6OCwoR8FT7AxNKWMmOUxghoR7U/qRPvxE5woaJPc9Lhfv/VreznBWRIGSq
         GcpCDNwY8Ztl3oiYGBwBI9VCxqJb6gbfYzns8D34h1odmcwdBm5+erp/8rI0w4w2Ln4R
         eBgL6/OPP4X6g9nni/iHVBiXdh8Ggz9LqlJZHt1F0XZwSfW76R6p6b1nyUVn3yOtKEOg
         xM3uO5GAh2fCjycM6hv3Xv4iWVzk823psKhI4NKYI0uBKROiAQuIsQRAUlMx3hT0ozWo
         Xu00CmFY6RQrh2mG/OEosMfrKsbNWzeaZwCuPu3JJcuVSOsjY+ZpO7J6TBqqHeIlq6fR
         mtHg==
X-Gm-Message-State: AOAM530QHvaFQ74kP8wfCzp2/8A7k8u+pR0QekJy1ZtDwG8zM9F8wsCo
        1rRlZ2LJ3C8zm+XpmWoeRIF7eknzKs3465HeqKk=
X-Google-Smtp-Source: ABdhPJx+sTzc+/ItKGf/oZR9yrZTp57Dj5D+jR/Sbww8bLVl7HyibV2aBVpWdWiaqLxp6myTzkRHi2ezPv6RJisHaFo=
X-Received: by 2002:ae9:dd43:: with SMTP id r64mr1492829qkf.225.1631072160836;
 Tue, 07 Sep 2021 20:36:00 -0700 (PDT)
MIME-Version: 1.0
References: <1631015968-9779-1-git-send-email-huangzhaoyang@gmail.com>
 <79c08d1d-eef5-bc15-8186-7e3367b4ebe7@suse.cz> <CAGWkznHY-iZ0ERbJdX-j4S5qOsUAzV0+x67maprz3W+xbq4hTQ@mail.gmail.com>
 <YTdoesOHCNoe+rGH@cmpxchg.org>
In-Reply-To: <YTdoesOHCNoe+rGH@cmpxchg.org>
From:   Zhaoyang Huang <huangzhaoyang@gmail.com>
Date:   Wed, 8 Sep 2021 11:35:40 +0800
Message-ID: <CAGWkznG+m0CgEHUAN4dmeenYYkBFP5JUzyLnzhfTK0Am25xXDA@mail.gmail.com>
Subject: Re: [PATCH] mm : bail out from psi memstall after submit_bio in swap_readpage
To:     Johannes Weiner <hannes@cmpxchg.org>
Cc:     Vlastimil Babka <vbabka@suse.cz>,
        Andrew Morton <akpm@linux-foundation.org>,
        Minchan Kim <minchan@kernel.org>,
        Zhaoyang Huang <zhaoyang.huang@unisoc.com>,
        "open list:MEMORY MANAGEMENT" <linux-mm@kvack.org>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Sep 7, 2021 at 9:24 PM Johannes Weiner <hannes@cmpxchg.org> wrote:
>
> On Tue, Sep 07, 2021 at 08:15:30PM +0800, Zhaoyang Huang wrote:
> > On Tue, Sep 7, 2021 at 8:03 PM Vlastimil Babka <vbabka@suse.cz> wrote:
> > >
> > > On 9/7/21 13:59, Huangzhaoyang wrote:
> > > > From: Zhaoyang Huang <zhaoyang.huang@unisoc.com>
> > > >
> > > > It doesn't make sense to count IO time into psi memstall. Bail out after
> > > > bio submitted.
> > >
> > > Isn't that the point if psi, to observe real stalls, which include IO?
>
> Yes, correct.
>
> > IO stalls could be observed within blk_io_schedule. The time cost of
> > the data from block device to RAM is counted here.
>
> Yes, that is on purpose. The time a thread waits for swap read IO is
> time in which the thread is not productive due to a lack of memory.
>
> For async-submitted IO, this happens in lock_page() called from
> do_swap_page(). If the submitting thread directly waits after the
> submit_bio(), then that should be accounted too.
IMO, memstall counting should be terminated by bio submitted. blk
driver fetching request and the operation on the real device shouldn't
be counted in. It especially doesn't make sense in a virtualization
system like XEN etc, where the blk driver is implemented via
backend-frontend way that introduce  memory irrelevant latency

>
> This patch doesn't make sense to me.
