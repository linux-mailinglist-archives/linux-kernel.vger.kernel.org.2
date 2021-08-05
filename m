Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9C5303E1A74
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Aug 2021 19:34:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239998AbhHERfL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 5 Aug 2021 13:35:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57236 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231278AbhHERfJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Aug 2021 13:35:09 -0400
Received: from mail-ed1-x52f.google.com (mail-ed1-x52f.google.com [IPv6:2a00:1450:4864:20::52f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2D0FFC061765
        for <linux-kernel@vger.kernel.org>; Thu,  5 Aug 2021 10:34:55 -0700 (PDT)
Received: by mail-ed1-x52f.google.com with SMTP id y12so9492901edo.6
        for <linux-kernel@vger.kernel.org>; Thu, 05 Aug 2021 10:34:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=9kMAajMtAAkQ+B+kyhrLYpvECyySrIVX4pfb5IgDdJ4=;
        b=P5pTwd5Dc7XsWEoDMScfA5rcLY5hIs22eHaZzPfkT6+qKz66AeSNpFZdKpVMi0gQft
         6r+XIHuyZ/Q9aIhWPyXK0h44Qzj0rZr+ROxIb9QsuIcBDi4rI0/0Xp5+9pIU/Bno4YuK
         sRKECaYco050svSwkio1vMKl1liCAbl7GeDQ1WR+sSd4YX2yq1rh2mQ1WSmNAMfE+YuA
         4uZ95xOMbKZAlj6r1s/50Y4zpI31l/cvfEOydcp0wCGvIF6i9d2u57PfHIsESFPrkA2I
         rgVy+0X8EnI8OXHduu8Z61ON7l7UtAGHzGBjSm5rD288MZSIk8NkFpQP/cnzmFvfi8DK
         4PZw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=9kMAajMtAAkQ+B+kyhrLYpvECyySrIVX4pfb5IgDdJ4=;
        b=YmII8SC+8Auc6b7aBlIMJeXj3hxWr5nfO2UUd9sFvMXmtDHQOnfys+9l5pBMUpE/nz
         x3IzHywJDAyzt+XX92HTMyS3jjAt7DZFI4xuLzcupONVjpdbBT10A0ekcMRKzduWi85e
         IqtFEmj8ToWTTrFF2e2rqmGQIvSg+XbdHSA115Bmxbwx6mYR31aRFP54sGfSAkthusAK
         78kq1P6TZ/jSF8yrqcB2douy575/ZooJ2ryyVbnT2tDsIdZWZJYG30JcBt2FkM6cq50n
         nDn+p6wID/0i8vcvSlDvftfLgzxrR9U5vco9jLEgVFN1lgYWngr1F/T+5dmzknZm98vv
         GPRQ==
X-Gm-Message-State: AOAM533YzcC9IT75JvDIKDYjKLMV97Zj1JtPFccOB+q3GgOUtp9T5b3j
        IslICKGIbem0HN5omnpserI10U5AiNjc3kKOu0M=
X-Google-Smtp-Source: ABdhPJy/sJZYP3/YtPmXGxs/cjsuvNPnwb4N3jPPElnhzQF8nDpTkB+1lzk4cqmZyqs73qhbs+LyMtOr9nx6dh7fzIo=
X-Received: by 2002:aa7:d899:: with SMTP id u25mr8031341edq.151.1628184893816;
 Thu, 05 Aug 2021 10:34:53 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1628174413.git.baolin.wang@linux.alibaba.com> <11d1f8fc954a83945930a5b11f47e00c063bdc1b.1628174413.git.baolin.wang@linux.alibaba.com>
In-Reply-To: <11d1f8fc954a83945930a5b11f47e00c063bdc1b.1628174413.git.baolin.wang@linux.alibaba.com>
From:   Yang Shi <shy828301@gmail.com>
Date:   Thu, 5 Aug 2021 10:34:42 -0700
Message-ID: <CAHbLzkqX9E3NQiOmGxg5ovmjTqyMkeVPmS2pZYdmrhkfb+cT2g@mail.gmail.com>
Subject: Re: [PATCH 4/5] mm: migrate: Change to use bool type for 'page_was_mapped'
To:     Baolin Wang <baolin.wang@linux.alibaba.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Linux MM <linux-mm@kvack.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Aug 5, 2021 at 8:06 AM Baolin Wang
<baolin.wang@linux.alibaba.com> wrote:
>
> Change to use bool type for 'page_was_mapped' variable making it
> more readable.

Seems better to me. Reviewed-by: Yang Shi <shy828301@gmail.com>

>
> Signed-off-by: Baolin Wang <baolin.wang@linux.alibaba.com>
> ---
>  mm/migrate.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/mm/migrate.c b/mm/migrate.c
> index 6f048a8..0ab364f 100644
> --- a/mm/migrate.c
> +++ b/mm/migrate.c
> @@ -957,7 +957,7 @@ static int __unmap_and_move(struct page *page, struct page *newpage,
>                                 int force, enum migrate_mode mode)
>  {
>         int rc = -EAGAIN;
> -       int page_was_mapped = 0;
> +       bool page_was_mapped = false;
>         struct anon_vma *anon_vma = NULL;
>         bool is_lru = !__PageMovable(page);
>
> @@ -1060,7 +1060,7 @@ static int __unmap_and_move(struct page *page, struct page *newpage,
>                 VM_BUG_ON_PAGE(PageAnon(page) && !PageKsm(page) && !anon_vma,
>                                 page);
>                 try_to_migrate(page, 0);
> -               page_was_mapped = 1;
> +               page_was_mapped = true;
>         }
>
>         if (!page_mapped(page))
> --
> 1.8.3.1
>
>
