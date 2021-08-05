Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B948A3E1A55
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Aug 2021 19:26:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239917AbhHER0z (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 5 Aug 2021 13:26:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55408 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230004AbhHER0y (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Aug 2021 13:26:54 -0400
Received: from mail-ed1-x532.google.com (mail-ed1-x532.google.com [IPv6:2a00:1450:4864:20::532])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A69C5C061765
        for <linux-kernel@vger.kernel.org>; Thu,  5 Aug 2021 10:26:39 -0700 (PDT)
Received: by mail-ed1-x532.google.com with SMTP id x90so9444332ede.8
        for <linux-kernel@vger.kernel.org>; Thu, 05 Aug 2021 10:26:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=HO/VWbPyEGux1Nvoe1OrTwHAMeu7O8EJMXgJFLFnPt4=;
        b=QUg/IFNFajos3Op9XPFn9Z2yyu7QdQ+aBF3GIXSsyzA9X9ttRHD6xnn8r7/NfCpuyo
         DaGYLiZcjzh0XyYLh9yXMJue7OPY2bq8inskhycvIw0TVR2clDgNEqQYMUibALmuf4Lx
         pS9NwbCloRJrd5UwMJhDQXRQdQmrPYBMkStCVUzGOTposRd6MzHxMyWMNFSSynM/ZHcg
         J9/2PBmBUhMSOyLJA1OvEzX21rqveVhZn7Yhx9Mf7l0bbDXnvEI93uh1fN6+UacxG2VD
         lfDyH4JNNi/U8BzAbYngx4XfjtcthIsvYjHG0Abt+KDrulf+50uRraX/vyjGmmTulB92
         k2gw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=HO/VWbPyEGux1Nvoe1OrTwHAMeu7O8EJMXgJFLFnPt4=;
        b=tVjIBVZSaAt9Xd85SGJgsO2T0Irqzo0OAS8OhAhhOA2LJ5lZUc5RW1rrNrTODz5Y2Z
         MzQ17xEmgTxA0Bi487ekzq8gMId6jwgDYUDnx3zIufEh/OKLS63KL27DVoyoNTUR0wOL
         hqkNpgJl4pOAsulwgNavhEGu+jfq03bixurkTMo963DXMaBJDTudEhALPsVW4EQjB+hf
         wlgaPtlNWdisEnFNmLRNQzKZJcJUFBB1j7/ajHYBvd0f7TWweOX2aHxqNHkZfgroTvu2
         RbooPb4P+Sidx/r8ugEWLC/OARB9EJXpx0Vu4hBlPnw/EAJhk0aSj/yyJwRgZYD3hV7i
         QUJw==
X-Gm-Message-State: AOAM530oilL4YZ+AghjcHjJbGWaoS3+K/S64orZywlrBwXMThr3OTv2H
        hkk2XQFJiIJ7Vur9LDK27TnaAQTin6+Vn/MYy6Us8YYUzMA=
X-Google-Smtp-Source: ABdhPJxUJKrl4G+Wvvup0m24Y+tEHDGNfZGkO63VD4bdIluevNZKFbOeq4jwCMLlwtpKCe5HttjKPIjHW6V6Xzad8SI=
X-Received: by 2002:a05:6402:1a4c:: with SMTP id bf12mr7995070edb.137.1628184398345;
 Thu, 05 Aug 2021 10:26:38 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1628174413.git.baolin.wang@linux.alibaba.com> <433d0be927c0cae047a4ca04feff0a1dccefe324.1628174413.git.baolin.wang@linux.alibaba.com>
In-Reply-To: <433d0be927c0cae047a4ca04feff0a1dccefe324.1628174413.git.baolin.wang@linux.alibaba.com>
From:   Yang Shi <shy828301@gmail.com>
Date:   Thu, 5 Aug 2021 10:26:26 -0700
Message-ID: <CAHbLzkqENNRnt-4p0s6-xSVOe4c8P4+0bxgs2kVZ6CAOH5XcQA@mail.gmail.com>
Subject: Re: [PATCH 3/5] mm: migrate: Fix the incorrect function name in comments
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
> since commit a98a2f0c8ce1 ("mm/rmap: split migration into its own function"),
> the migration ptes establishment has been split into a separate
> try_to_migrate() function, thus update the related comments.
>
> Signed-off-by: Baolin Wang <baolin.wang@linux.alibaba.com>

Reviewed-by: Yang Shi <shy828301@gmail.com>

> ---
>  mm/migrate.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/mm/migrate.c b/mm/migrate.c
> index eeba4c6..6f048a8 100644
> --- a/mm/migrate.c
> +++ b/mm/migrate.c
> @@ -1005,7 +1005,7 @@ static int __unmap_and_move(struct page *page, struct page *newpage,
>         }
>
>         /*
> -        * By try_to_unmap(), page->mapcount goes down to 0 here. In this case,
> +        * By try_to_migrate(), page->mapcount goes down to 0 here. In this case,
>          * we cannot notice that anon_vma is freed while we migrates a page.
>          * This get_anon_vma() delays freeing anon_vma pointer until the end
>          * of migration. File cache pages are no problem because of page_lock()
> --
> 1.8.3.1
>
>
