Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B6A7045ABB8
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Nov 2021 19:51:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236175AbhKWSzC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 23 Nov 2021 13:55:02 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39990 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231344AbhKWSzA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 Nov 2021 13:55:00 -0500
Received: from mail-ed1-x532.google.com (mail-ed1-x532.google.com [IPv6:2a00:1450:4864:20::532])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 614D2C061574
        for <linux-kernel@vger.kernel.org>; Tue, 23 Nov 2021 10:51:52 -0800 (PST)
Received: by mail-ed1-x532.google.com with SMTP id v1so62463229edx.2
        for <linux-kernel@vger.kernel.org>; Tue, 23 Nov 2021 10:51:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=vW/KcDWewUAaWZErZ3pm+uGPBgzQunMq22fbX0UUYYg=;
        b=L8efeLnGRxHYB3fOjN1WnGxaz5qBS1Q9pmDbYvBAGsLT0gwjGeBIAQX5rXQx+29+X0
         r7f22p0KZQHPL3jva5UgQUmvRPGBlaak6q6onOtHWhz8doC3EyvmZ+pkgJOhIQVepxx7
         zIi4ASnFMN1l85k3feS9SKJJYRYCuuFOJo7Pb4FgKcssQ6sB24acT3XuZOkWg5mXSF1q
         yq3imb6U5O2gsfWwA7zyJtpv8xxFxJkgPGmDQcZ8BdEMv9hvLxaoJVPD+aQfE/NDIuk7
         7g2jr8J2u1RqUbQv3Okka8fKbZsD4hqkmQn6GM6YnmxEb+Qv2EzraxoF1qFt1v9Rh7TN
         /1Jw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=vW/KcDWewUAaWZErZ3pm+uGPBgzQunMq22fbX0UUYYg=;
        b=gj051RUYmuU1Xj1jqncOY6RdyApdhJlYrOMGXIFcj52tJQsoxmIECjRDm3G1V9lELD
         jIygTtcBr/yTVn+NP8MGqIPz8ELEj5AqJOs2imJyyrU46PPViyY7Ukz+e1728kPraFOi
         XGImChX6JC8eST/OgrNHeKLrV+zl/uR55MefUKMxjT42nfx90mwHizWSUNJFOWPdn+mY
         zfZotQhSrCtep505U9mC45xiiaaLjyd3/Z6054T8yP/+hB9C563KIixNX3MSZWJMJKJa
         VH8sm8gYVGekB0nEy5yFfH0/zGpGeDEm1xQxgfjGJ/pa2xiCGRTd8daOkg0VwNwSZDq2
         1ipA==
X-Gm-Message-State: AOAM531wWgjhnjLjcnhiiXAjI2fIy7o1WQjZPHyZ5fu910Xr+llXfO8M
        OcXjdiloAXPVIy2y46uWw/NN7jdXW74LFgtQIVA=
X-Google-Smtp-Source: ABdhPJw0M9iKRESs4ESux5Fo97VRwJyeiSGtVg59hZo7c72LFyWwIYFPW92PWeNFyP5qpyabG3nNnRHhPaC5mKac6KU=
X-Received: by 2002:a17:907:3f83:: with SMTP id hr3mr10669261ejc.555.1637693510762;
 Tue, 23 Nov 2021 10:51:50 -0800 (PST)
MIME-Version: 1.0
References: <20211123174658.1728753-1-shakeelb@google.com>
In-Reply-To: <20211123174658.1728753-1-shakeelb@google.com>
From:   Yang Shi <shy828301@gmail.com>
Date:   Tue, 23 Nov 2021 10:51:39 -0800
Message-ID: <CAHbLzkpxnbzLFB0=dbtavkvNGY8aamNKSu+YU2eYK3KM5d2g4Q@mail.gmail.com>
Subject: Re: [PATCH] mm: thp: update split_queue_len correctly
To:     Shakeel Butt <shakeelb@google.com>
Cc:     David Hildenbrand <david@redhat.com>,
        "Kirill A . Shutemov" <kirill.shutemov@linux.intel.com>,
        Zi Yan <ziy@nvidia.com>, Matthew Wilcox <willy@infradead.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Linux MM <linux-mm@kvack.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Nov 23, 2021 at 9:47 AM Shakeel Butt <shakeelb@google.com> wrote:
>
> The deferred THPs are split on memory pressure through shrinker
> callback and splitting of THP during reclaim can fail for several
> reasons like unable to lock the THP, under writeback or unexpected
> number of pins on the THP. Such pages are put back on the deferred split
> list for consideration later. However kernel does not update the
> deferred queue size on putting back the pages whose split was failed.
> This patch fixes that.
>
> Fixes: 364c1eebe453 ("mm: thp: extract split_queue_* into a struct")
> Signed-off-by: Shakeel Butt <shakeelb@google.com>
> ---
>  mm/huge_memory.c | 4 +++-
>  1 file changed, 3 insertions(+), 1 deletion(-)
>
> diff --git a/mm/huge_memory.c b/mm/huge_memory.c
> index e5483347291c..4fff9584815b 100644
> --- a/mm/huge_memory.c
> +++ b/mm/huge_memory.c
> @@ -2809,7 +2809,7 @@ static unsigned long deferred_split_scan(struct shrinker *shrink,
>         unsigned long flags;
>         LIST_HEAD(list), *pos, *next;
>         struct page *page;
> -       int split = 0;
> +       unsigned long split = 0, num = 0;
>
>  #ifdef CONFIG_MEMCG
>         if (sc->memcg)
> @@ -2823,6 +2823,7 @@ static unsigned long deferred_split_scan(struct shrinker *shrink,
>                 page = compound_head(page);
>                 if (get_page_unless_zero(page)) {
>                         list_move(page_deferred_list(page), &list);
> +                       num++;

Thanks for catching this. But I don't think "num" is needed, isn't the
below code good enough?

diff --git a/mm/huge_memory.c b/mm/huge_memory.c
index e5483347291c..1fbd8299db0c 100644
--- a/mm/huge_memory.c
+++ b/mm/huge_memory.c
@@ -2847,6 +2847,7 @@ static unsigned long deferred_split_scan(struct
shrinker *shrink,

        spin_lock_irqsave(&ds_queue->split_queue_lock, flags);
        list_splice_tail(&list, &ds_queue->split_queue);
+       ds_queue->split_queue_len -= split;
        spin_unlock_irqrestore(&ds_queue->split_queue_lock, flags);

        /*

>                 } else {
>                         /* We lost race with put_compound_page() */
>                         list_del_init(page_deferred_list(page));
> @@ -2847,6 +2848,7 @@ static unsigned long deferred_split_scan(struct shrinker *shrink,
>
>         spin_lock_irqsave(&ds_queue->split_queue_lock, flags);
>         list_splice_tail(&list, &ds_queue->split_queue);
> +       ds_queue->split_queue_len += (num - split);
>         spin_unlock_irqrestore(&ds_queue->split_queue_lock, flags);
>
>         /*
> --
> 2.34.0.rc2.393.gf8c9666880-goog
>
