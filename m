Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 20A863B0B8D
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Jun 2021 19:39:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231964AbhFVRmB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 22 Jun 2021 13:42:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33312 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229501AbhFVRmB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Jun 2021 13:42:01 -0400
Received: from mail-ej1-x634.google.com (mail-ej1-x634.google.com [IPv6:2a00:1450:4864:20::634])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0A7FFC061574
        for <linux-kernel@vger.kernel.org>; Tue, 22 Jun 2021 10:39:44 -0700 (PDT)
Received: by mail-ej1-x634.google.com with SMTP id bu12so2528760ejb.0
        for <linux-kernel@vger.kernel.org>; Tue, 22 Jun 2021 10:39:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=vzEV/LXUCOUKIacuVIarnUamt4RwzwK/u08u24ha27k=;
        b=PpM3LEXqUuUKFl8KpINDC0rXa4/PjeICtfvuGlxk11FYwbFIWPxZcNkpT0lYa7rGKw
         6tYGL/BVmu2gWYq4cHRKjKTayTuEhUq/L23cYI07421fZDpI2fSfHIA1zc1VvtPyiuZz
         DZ/CFE7mPkJGL/1aBsS2tcIFASBQm4Al9RQdSsztQiS2xW1jNzsGcocnzznijOI5Qz32
         5pvBiLFe/0w4Oi37Ct7ukjohcmcroJNMyeg6tQCjNONUDDYibK3X5RgElZJOozAzPeb0
         Dgx7Gi3Rue2dcsAwX1WBVg/JpcQmHBOr0emhOYxjVWOHZpqDFPJOQCyPo9ZBKOO3BPci
         6FdQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=vzEV/LXUCOUKIacuVIarnUamt4RwzwK/u08u24ha27k=;
        b=PyfkQpNhb9yYLZ6gwW9keuD6re3IuMJKrP0C/lZY/UfJjtTt0ckT34Q5bBuK04dBhZ
         Y2n9KxwXVwxvDWTnkPwaxTERNq/qVBg/Db+Jl4Cb/Dq0qRcYT0D7APAiyFWESPuazfJo
         UmAuurzOpAktZ1OW6nmiBptMbBfOcNIiabAhLpZai0oMI41GB/09ovS+sZc1V7LWtPWl
         abvnvcMdUpQrCQDo/ru79Q0uPaVW5dO1n2hfYZ5hZBlqGrLVrd5w73KbV8T2GgsGPYUI
         miV/4MLpETPvnFs6frd1xAL1rWAmoFAZ/qykrniAH4GeiWOAR4t8xnzR2F3MeUX63zUB
         J3lQ==
X-Gm-Message-State: AOAM533JHuBmgolVxCjLVMpN4bDwICzYPiVkV7HL5qOjiNWS6cTRfG12
        GzJklVKkMRizP6DAuGQHMUSQvfntM2KPK/m7SCs=
X-Google-Smtp-Source: ABdhPJw4mj9cHRUGvTmOHI3mJ3iokanfJI5F3ztuD0BdhAmZvZC2ZG+rIq+eHClY24zJzA7tYLVmM5mg1YtBdruc/wg=
X-Received: by 2002:a17:906:1f11:: with SMTP id w17mr5166177ejj.33.1624383581728;
 Tue, 22 Jun 2021 10:39:41 -0700 (PDT)
MIME-Version: 1.0
References: <20210622074926.333223-1-gshan@redhat.com> <20210622074926.333223-3-gshan@redhat.com>
In-Reply-To: <20210622074926.333223-3-gshan@redhat.com>
From:   Alexander Duyck <alexander.duyck@gmail.com>
Date:   Tue, 22 Jun 2021 10:39:30 -0700
Message-ID: <CAKgT0UfXfqUhm5P-2J4ftgU9xmy9GixJdFnpUP-ppXih1yZXyQ@mail.gmail.com>
Subject: Re: [PATCH v2 2/3] mm/page_reporting: Allow driver to specify threshold
To:     Gavin Shan <gshan@redhat.com>
Cc:     linux-mm <linux-mm@kvack.org>, LKML <linux-kernel@vger.kernel.org>,
        David Hildenbrand <david@redhat.com>,
        "Michael S. Tsirkin" <mst@redhat.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Anshuman Khandual <anshuman.khandual@arm.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>, shan.gavin@gmail.com
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jun 21, 2021 at 10:48 PM Gavin Shan <gshan@redhat.com> wrote:
>
> The page reporting threshold is currently sticky to @pageblock_order.
> The page reporting can never be triggered because the freeing page
> can't come up with a free area like that huge. The situation becomes
> worse when the system memory becomes heavily fragmented.
>
> For example, the following configurations are used on ARM64 when 64KB
> base page size is enabled. In this specific case, the page reporting
> won't be triggered until the freeing page comes up with a 512MB free
> area. That's hard to be met, especially when the system memory becomes
> heavily fragmented.
>
>    PAGE_SIZE:          64KB
>    HPAGE_SIZE:         512MB
>    pageblock_order:    13       (512MB)
>    MAX_ORDER:          14
>
> This allows the drivers to specify the threshold when the page
> reporting device is registered. The threshold falls back to
> @pageblock_order if it's not specified by the driver. The existing
> users (hv_balloon and virtio_balloon) don't specify the threshold
> and @pageblock_order is still taken as their page reporting order.
> So this shouldn't introduce functional changes.
>
> Signed-off-by: Gavin Shan <gshan@redhat.com>
> ---
>  include/linux/page_reporting.h |  3 +++
>  mm/page_reporting.c            | 14 ++++++++++----
>  mm/page_reporting.h            | 10 ++--------
>  3 files changed, 15 insertions(+), 12 deletions(-)
>
> diff --git a/include/linux/page_reporting.h b/include/linux/page_reporting.h
> index 3b99e0ec24f2..fe648dfa3a7c 100644
> --- a/include/linux/page_reporting.h
> +++ b/include/linux/page_reporting.h
> @@ -18,6 +18,9 @@ struct page_reporting_dev_info {
>
>         /* Current state of page reporting */
>         atomic_t state;
> +
> +       /* Minimal order of page reporting */
> +       unsigned int order;
>  };
>
>  /* Tear-down and bring-up for page reporting devices */
> diff --git a/mm/page_reporting.c b/mm/page_reporting.c
> index df9c5054e1b4..27670360bae6 100644
> --- a/mm/page_reporting.c
> +++ b/mm/page_reporting.c

<snip>

> @@ -324,6 +324,12 @@ int page_reporting_register(struct page_reporting_dev_info *prdev)
>                 goto err_out;
>         }
>
> +       /*
> +        * We need to choose the minimal order of page reporting if it's
> +        * not specified by the driver.
> +        */
> +       prdev->order = prdev->order ? prdev->order : pageblock_order;
> +
>         /* initialize state and work structures */
>         atomic_set(&prdev->state, PAGE_REPORTING_IDLE);
>         INIT_DELAYED_WORK(&prdev->work, &page_reporting_process);

Rather than using prdev->order directly it might be better to have a
reporting_order value you could export for use by
page_reporting_notify_free. That way you avoid the overhead of having
to make a function call per page freed.

> diff --git a/mm/page_reporting.h b/mm/page_reporting.h
> index 2c385dd4ddbd..d9f972e72649 100644
> --- a/mm/page_reporting.h
> +++ b/mm/page_reporting.h
> @@ -10,11 +10,9 @@
>  #include <linux/pgtable.h>
>  #include <linux/scatterlist.h>
>
> -#define PAGE_REPORTING_MIN_ORDER       pageblock_order
> -
>  #ifdef CONFIG_PAGE_REPORTING
>  DECLARE_STATIC_KEY_FALSE(page_reporting_enabled);
> -void __page_reporting_notify(void);
> +void __page_reporting_notify(unsigned int order);
>
>  static inline bool page_reported(struct page *page)
>  {
> @@ -37,12 +35,8 @@ static inline void page_reporting_notify_free(unsigned int order)
>         if (!static_branch_unlikely(&page_reporting_enabled))
>                 return;
>
> -       /* Determine if we have crossed reporting threshold */
> -       if (order < PAGE_REPORTING_MIN_ORDER)
> -               return;
> -
>         /* This will add a few cycles, but should be called infrequently */
> -       __page_reporting_notify();
> +       __page_reporting_notify(order);
>  }
>  #else /* CONFIG_PAGE_REPORTING */
>  #define page_reported(_page)   false

With us making the function call per page freed we are likely to have
a much more significant impact on performance with page reporting
enabled. Ideally we want to limit this impact so that we only take the
cost for the conditional check on the lower order pages.
