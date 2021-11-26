Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 93AF745E9CB
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Nov 2021 10:01:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1359829AbhKZJEI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 26 Nov 2021 04:04:08 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48390 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345056AbhKZJCF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 Nov 2021 04:02:05 -0500
Received: from mail-yb1-xb32.google.com (mail-yb1-xb32.google.com [IPv6:2607:f8b0:4864:20::b32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6E5BCC061759
        for <linux-kernel@vger.kernel.org>; Fri, 26 Nov 2021 00:58:10 -0800 (PST)
Received: by mail-yb1-xb32.google.com with SMTP id f186so18386035ybg.2
        for <linux-kernel@vger.kernel.org>; Fri, 26 Nov 2021 00:58:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance-com.20210112.gappssmtp.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=huEf5sIiaaLscYYkAZY0WDzbxVnMYvMHJ0EGSQecX60=;
        b=kHOA2uus9T8XqKH+3IVJyKPQb6VSGbElEkUXn/O4XUXd+onL7OYfTxnBroLdWa3bxl
         Ex7JJI5BvP6SZ4HYHDYHbdZRkj1KnG94fc3kTNSQvYoU7cI3e34hkZy4uxwTvPEQs4iJ
         qNcEXWKOLzM3x29pVlckJRm9dTg58N8N4jIqbg9CfnZ1I5Dm5+81nIoqf0S/zxipTlkF
         teO8i+RA5ZFC7yA9YuRz7eXbxubivVrFDUKPZJpVSivElNaqtbhVbl/TdhVoRqzx1dwg
         SKX/KhzwR5q6LtQZrx+mpScVQr/54jYAuqWd/VC+3X3/CMIzxOWjIouLTV4WdbPmACUE
         w2Gw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=huEf5sIiaaLscYYkAZY0WDzbxVnMYvMHJ0EGSQecX60=;
        b=Dafb78x3LY7auGw9zR7U3C92hd/44B/aw/f/zZf+fE+nREI1CAcXaDqT3Citk4ikRd
         5TLjNgOEkAq3U1aJzbDTgzeymkosX2aAbE2h+/54yDIxvO0qw+wPebLuU6dZP1gq6hiM
         +4qpPWV6oheSQnQNcVbYZEJ30laKTgmLto0dXCel/ho9LJkXzkDl366CblzyG5fzYGNB
         anoquis38ouE6/SMA7ERWZA/cKsM4F5w6NZ/B4hvMzRq/Tjyl/6AZsLGceV12eiEKyRn
         oeiUP0xmwU0GiNKczhvuDq+O1Ljo5+nmKKkv+ftI/tqJe+l+KNHr/lq0UdTcXQhxvCgi
         QKMw==
X-Gm-Message-State: AOAM532oBP1EReZLAZ5V488Zq31/6rTG10OtfFCK6aW1dK1l8hTMx3A4
        k/H+LG4mokrsJdtmmGl+kRucN6GP6OHXG8EstNzFnw==
X-Google-Smtp-Source: ABdhPJxchGeSakpJLdij/o4GKRb3zqOZ1d4CR1ucs6BwmQ35UiNCbs/nFetd6WUo44spzGVwUD09r6pD6ArLVvAfwpM=
X-Received: by 2002:a25:bc07:: with SMTP id i7mr12560099ybh.340.1637917089608;
 Fri, 26 Nov 2021 00:58:09 -0800 (PST)
MIME-Version: 1.0
References: <20211125090635.23508-1-colin.i.king@gmail.com>
 <aa7ad39528c768dfd3a33890cf7d14b59ba3a5fc.camel@perches.com> <dcd6ed6a-a915-49b5-a428-f21f2e3e3e00@gmail.com>
In-Reply-To: <dcd6ed6a-a915-49b5-a428-f21f2e3e3e00@gmail.com>
From:   Muchun Song <songmuchun@bytedance.com>
Date:   Fri, 26 Nov 2021 16:57:29 +0800
Message-ID: <CAMZfGtXJkEtH+nVMLtGhfVqySZ+iGc-1yd9OJ3jxK65puFgf_Q@mail.gmail.com>
Subject: Re: [PATCH][next] hugetlb: Fix spelling mistake "hierarichal" -> "hierarchical"
To:     "Colin King (gmail)" <colin.i.king@googlemail.com>
Cc:     Joe Perches <joe@perches.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Linux Memory Management List <linux-mm@kvack.org>,
        kernel-janitors@vger.kernel.org,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Nov 26, 2021 at 4:38 PM Colin King (gmail)
<colin.i.king@googlemail.com> wrote:
>
> On 26/11/2021 08:15, Joe Perches wrote:
> > On Thu, 2021-11-25 at 09:06 +0000, Colin Ian King wrote:
> >> There is a spelling mistake in a literal string and a comment. Fix them.
> > []
> >> diff --git a/mm/hugetlb_cgroup.c b/mm/hugetlb_cgroup.c
> > []
> >> @@ -495,11 +495,11 @@ static int hugetlb_cgroup_read_numa_stat(struct seq_file *seq, void *dummy)
> >>       * The hierarchical total is pretty much the value recorded by the
> >>       * counter, so use that.
> >>       */
> >> -    seq_printf(seq, "%stotal=%lu", legacy ? "hierarichal_" : "",
> >> +    seq_printf(seq, "%stotal=%lu", legacy ? "hierarchical_" : "",
> >>                 page_counter_read(&h_cg->hugepage[idx]) * PAGE_SIZE);
> >
> > Not sure this should be changed as seq output is nominally ABI.
>
> This just landed in linux-next, so I doubt many folk are using it. Let's
> fix it before it lands mainline.

Totally agree.

>
> >
> >>
> >>      /*
> >> -     * For each node, transverse the css tree to obtain the hierarichal
> >> +     * For each node, transverse the css tree to obtain the hierarchical
> >
> > Fixing the comment typo is good.  Thanks.
> >
> >
>
