Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 487EA44D076
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Nov 2021 04:38:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232138AbhKKDlC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 10 Nov 2021 22:41:02 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52072 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230185AbhKKDlB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 Nov 2021 22:41:01 -0500
Received: from mail-yb1-xb29.google.com (mail-yb1-xb29.google.com [IPv6:2607:f8b0:4864:20::b29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4E6ABC061766
        for <linux-kernel@vger.kernel.org>; Wed, 10 Nov 2021 19:38:13 -0800 (PST)
Received: by mail-yb1-xb29.google.com with SMTP id y68so6460015ybe.1
        for <linux-kernel@vger.kernel.org>; Wed, 10 Nov 2021 19:38:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance-com.20210112.gappssmtp.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=yOsFvx3uBmNrzTbP+yFE5JKWjrB+4rqD5uI1hcAhx6E=;
        b=QCAinz1h8etTsGUK/7abyyo7bFt7h+bw3B1DdXB6u15ssBnB5HPur4a/hTbQ4ZQtSn
         PWHhz8bYwu9+3Wg1nrtkaKbwV6u14PGbek5nfjfYdJmcJdimBhR/dZ6dwq8GcCgOXtHc
         WZMs2I3Ed7202wgRqEwk69c8Dqiqiv6gbOzCkgDpa2zoHOryzo+kjLUtXF0t8rTBPwmy
         rq5dwKYG1KOXH+IKXQSYdtuqJezL3JBMRoyh8t17jA7uZu6MviIqzUdNE1nRtQWc8tv0
         eOMSx3qgKrZqbwOQoVR0yKpkbul+u+MvYPLQkH/Cfduo8gTShi6ArtWbx2ldJOz0oGB/
         pT/A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=yOsFvx3uBmNrzTbP+yFE5JKWjrB+4rqD5uI1hcAhx6E=;
        b=btoIQg4OqLyLw0DRJx0Yu6PCuLfzoO0TquDJzQYvqfnGPpym9zy8DCyhY0qrRqHy59
         qRodg0K8vGTh85oGCnsj6eZxs7YdcnfE1wrI/g2AgcGuiWp993489lNJ7DKHihwY0HrY
         rs0WxPL6Z+wwERAEK2diTd5C0OcIKoS7hQuIQ7vAQaXuYBkcsEfrx1s4zIo+QJ2e/B/r
         4aExwxw/CZYj+HgFQBsL2qkXHJKjxIu2166pgAQqwrp4+vJ1o1qBC6tS1wbvfSBM8Gps
         vmsHxotvdmKc31lZ2HwKWgSUdKgZGIZ60BALQgolSJMoj4nYc0k2yoP/vx4vRko0aysv
         QO0w==
X-Gm-Message-State: AOAM531WMWtLi0u/ywP3oCmLU1Omz0wNCLR5gX0rDLnkHzhafzf+siHv
        6flsXltDqDsh4ievFpFeWpMQyqpGFCgJx4myqXXLfUDSzz/aEuwk
X-Google-Smtp-Source: ABdhPJzKSIZk0rZsyKz7G4gja5tr4jOpR2PI3QokR/n2GMSumujMwDmGpqPDgHXcKIfE//WiHJswSo6oYRrtvEJ1Wh0=
X-Received: by 2002:a05:6902:1342:: with SMTP id g2mr5020180ybu.419.1636601892568;
 Wed, 10 Nov 2021 19:38:12 -0800 (PST)
MIME-Version: 1.0
References: <20211111032204.3721-1-hanyihao@vivo.com>
In-Reply-To: <20211111032204.3721-1-hanyihao@vivo.com>
From:   Muchun Song <songmuchun@bytedance.com>
Date:   Thu, 11 Nov 2021 11:37:36 +0800
Message-ID: <CAMZfGtWVVLKO76OmtVp+xOL1waTxBb05tvWXgsnf=k7nFF4J2A@mail.gmail.com>
Subject: Re: [PATCH] mm/damon/vaddr: remove swap_ranges() and replace it with swap()
To:     Yihao Han <hanyihao@vivo.com>
Cc:     SeongJae Park <sj@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Linux Memory Management List <linux-mm@kvack.org>,
        LKML <linux-kernel@vger.kernel.org>, kernel@vivo.com
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Nov 11, 2021 at 11:22 AM Yihao Han <hanyihao@vivo.com> wrote:
>
> Remove 'swap_ranges()' and replace it with the macro 'swap()'
> defined in 'include/linux/minmax.h' to simplify code and improve efficiency
>
> Reviewed-by: SeongJae Park <sj@kernel.org>
> Reviewed-by: Muchun Song <songmuchun@bytedance.com>
> Signed-off-by: Yihao Han <hanyihao@vivo.com>

Actually, I and SeongJae didn't provide Reviewed-by in the
previous thread. But this patch looks good to me, so

Reviewed-by: Muchun Song <songmuchun@bytedance.com>

BTW, the subject missed a "v2" tag (and changes log
should include what you have changed since v1).

Thanks.

> ---
>  mm/damon/vaddr.c | 16 +++-------------
>  1 file changed, 3 insertions(+), 13 deletions(-)
>
> diff --git a/mm/damon/vaddr.c b/mm/damon/vaddr.c
> index 35fe49080ee9..814dc811d7c4 100644
> --- a/mm/damon/vaddr.c
> +++ b/mm/damon/vaddr.c
> @@ -97,16 +97,6 @@ static unsigned long sz_range(struct damon_addr_range *r)
>         return r->end - r->start;
>  }
>
> -static void swap_ranges(struct damon_addr_range *r1,
> -                       struct damon_addr_range *r2)
> -{
> -       struct damon_addr_range tmp;
> -
> -       tmp = *r1;
> -       *r1 = *r2;
> -       *r2 = tmp;
> -}
> -
>  /*
>   * Find three regions separated by two biggest unmapped regions
>   *
> @@ -145,9 +135,9 @@ static int __damon_va_three_regions(struct vm_area_struct *vma,
>                 gap.start = last_vma->vm_end;
>                 gap.end = vma->vm_start;
>                 if (sz_range(&gap) > sz_range(&second_gap)) {
> -                       swap_ranges(&gap, &second_gap);
> +                       swap(gap, second_gap);
>                         if (sz_range(&second_gap) > sz_range(&first_gap))
> -                               swap_ranges(&second_gap, &first_gap);
> +                               swap(second_gap, first_gap);
>                 }
>  next:
>                 last_vma = vma;
> @@ -158,7 +148,7 @@ static int __damon_va_three_regions(struct vm_area_struct *vma,
>
>         /* Sort the two biggest gaps by address */
>         if (first_gap.start > second_gap.start)
> -               swap_ranges(&first_gap, &second_gap);
> +               swap(first_gap, second_gap);
>
>         /* Store the result */
>         regions[0].start = ALIGN(start, DAMON_MIN_REGION);
> --
> 2.17.1
>
