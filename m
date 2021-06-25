Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2282A3B3A6B
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Jun 2021 03:14:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232972AbhFYBRH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 24 Jun 2021 21:17:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48982 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229521AbhFYBRD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Jun 2021 21:17:03 -0400
Received: from mail-ed1-x533.google.com (mail-ed1-x533.google.com [IPv6:2a00:1450:4864:20::533])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E75A4C061574
        for <linux-kernel@vger.kernel.org>; Thu, 24 Jun 2021 18:14:41 -0700 (PDT)
Received: by mail-ed1-x533.google.com with SMTP id c7so11181171edn.6
        for <linux-kernel@vger.kernel.org>; Thu, 24 Jun 2021 18:14:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=++bd/zxPZIg5f+Gya9goVmaIP8xL9wMKa30VOqCJVNk=;
        b=vQ9Vtog4GWWcOeLae3m360zDz7ru20Oz+JaqzXcKG1mxB6GsEU/kK66fBsFayYP7M8
         iPAGfbG3fau3yE1dpuauCLODZVsi0SO++1KH8LVNnUGKeSz4Ontb2QCr79tBp4/Jb54i
         tz3mQdX8qU0mADWfEzKmWsxwVmFXQ4Aq1dEoAllu4mW4rTSU0o6uDPws6GXkpZIcjdhD
         l6pLERhAxni2CATS8v3teO43t8N9g+GulQW43DLvBZS0maT2u0O3ip7Un6qqh6+hkgZQ
         6wYQOr1tKOXhWuL1FBBRQAGn+b/ncVlXy+WdEsEbAcQqbuv7SkB+xsMTSoa3D3LSJWIz
         fQJA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=++bd/zxPZIg5f+Gya9goVmaIP8xL9wMKa30VOqCJVNk=;
        b=SauxPGzQT0iYKBbtcZ6Et6ORBuKnVf2oNa0H+jBihvDdoYN+f5+5HQWZr9gJMGRgF3
         ATfZSEdpyDdws7VtlcxKz2yg+qWR5wQhlg/ot2CxVDvVoywhlgtVDIeDYTtINkDIRkgZ
         vtff3KWjUfKsuUD8V+7RcRvKVWkd/TXE8tlsJQ0tBTGITwmeVtBJ7wyiDK8TMlS9/yYP
         Jr9MSsC+qdCms6sx7PVyWAcUZhryeImaT1hzPni+OQXHuDtxuVCuWd0sZ4JSZUDmR06s
         UrSHKLPXnOu4s9Xbm6FVzYGXdCqGHPDvpNNXfubIRccn01OVLV+t9mp574OORHr14KdL
         c8ag==
X-Gm-Message-State: AOAM533PyCXYW2P9G7lSLE0Bfr7AKACb1+hMluj2PmCcp99359iFgIO1
        ORKMJwuxm7vPzUbWDKs5O/nesuzd9tj2HfFxK1g=
X-Google-Smtp-Source: ABdhPJye1s1wXUtxv1u5XaZCLyNj1gU/0F8HRi3adTJKDxEOLV2GpAMn58UFUanBO3130YVKyY6DvJQk5J+dtryzeYw=
X-Received: by 2002:a50:8dc6:: with SMTP id s6mr11161724edh.50.1624583680505;
 Thu, 24 Jun 2021 18:14:40 -0700 (PDT)
MIME-Version: 1.0
References: <20210625014710.42954-1-gshan@redhat.com> <20210625014710.42954-3-gshan@redhat.com>
In-Reply-To: <20210625014710.42954-3-gshan@redhat.com>
From:   Alexander Duyck <alexander.duyck@gmail.com>
Date:   Thu, 24 Jun 2021 18:14:29 -0700
Message-ID: <CAKgT0UeM4nCAWUFfSrvy54X5JrY6uoULkbrVcazFMT6aOk6J8w@mail.gmail.com>
Subject: Re: [PATCH v4 2/4] mm/page_reporting: Export reporting order as
 module parameter
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

On Thu, Jun 24, 2021 at 4:46 PM Gavin Shan <gshan@redhat.com> wrote:
>
> The macro PAGE_REPORTING_MIN_ORDER is defined as the page reporting
> threshold. It can't be adjusted at runtime.
>
> This introduces a variable (@page_reporting_order) to replace the
> marcro (PAGE_REPORTING_MIN_ORDER). MAX_ORDER is assigned to it initially,
> meaning the page reporting is disabled. It will be specified by driver
> if valid one is provided. Otherwise, it will fall back to @pageblock_order.
> It's also exported so that the page reporting order can be adjusted at
> runtime.
>
> Suggested-by: David Hildenbrand <david@redhat.com>
> Signed-off-by: Gavin Shan <gshan@redhat.com>
> Reviewed-by: Alexander Duyck <alexanderduyck@fb.com>

So this patch looks like it is technically broken. We need a line in
page_reporting_register that will overwrite the value with
pageblock_order if it is less than page_reporting_order.

> ---
>  Documentation/admin-guide/kernel-parameters.txt | 6 ++++++
>  mm/page_reporting.c                             | 9 +++++++--
>  mm/page_reporting.h                             | 5 ++---
>  3 files changed, 15 insertions(+), 5 deletions(-)
>
> diff --git a/Documentation/admin-guide/kernel-parameters.txt b/Documentation/admin-guide/kernel-parameters.txt
> index cb89dbdedc46..566c4b9af3cd 100644
> --- a/Documentation/admin-guide/kernel-parameters.txt
> +++ b/Documentation/admin-guide/kernel-parameters.txt
> @@ -3566,6 +3566,12 @@
>                         off: turn off poisoning (default)
>                         on: turn on poisoning
>
> +       page_reporting.page_reporting_order=
> +                       [KNL] Minimal page reporting order
> +                       Format: <integer>
> +                       Adjust the minimal page reporting order. The page
> +                       reporting is disabled when it exceeds (MAX_ORDER-1).
> +
>         panic=          [KNL] Kernel behaviour on panic: delay <timeout>
>                         timeout > 0: seconds before rebooting
>                         timeout = 0: wait forever
> diff --git a/mm/page_reporting.c b/mm/page_reporting.c
> index df9c5054e1b4..34bf4d26c2c4 100644
> --- a/mm/page_reporting.c
> +++ b/mm/page_reporting.c
> @@ -4,12 +4,17 @@
>  #include <linux/page_reporting.h>
>  #include <linux/gfp.h>
>  #include <linux/export.h>
> +#include <linux/module.h>
>  #include <linux/delay.h>
>  #include <linux/scatterlist.h>
>
>  #include "page_reporting.h"
>  #include "internal.h"
>
> +unsigned int page_reporting_order = MAX_ORDER;
> +module_param(page_reporting_order, uint, 0644);
> +MODULE_PARM_DESC(page_reporting_order, "Set page reporting order");
> +
>  #define PAGE_REPORTING_DELAY   (2 * HZ)
>  static struct page_reporting_dev_info __rcu *pr_dev_info __read_mostly;
>
> @@ -229,7 +234,7 @@ page_reporting_process_zone(struct page_reporting_dev_info *prdev,
>
>         /* Generate minimum watermark to be able to guarantee progress */
>         watermark = low_wmark_pages(zone) +
> -                   (PAGE_REPORTING_CAPACITY << PAGE_REPORTING_MIN_ORDER);
> +                   (PAGE_REPORTING_CAPACITY << page_reporting_order);
>
>         /*
>          * Cancel request if insufficient free memory or if we failed
> @@ -239,7 +244,7 @@ page_reporting_process_zone(struct page_reporting_dev_info *prdev,
>                 return err;
>
>         /* Process each free list starting from lowest order/mt */
> -       for (order = PAGE_REPORTING_MIN_ORDER; order < MAX_ORDER; order++) {
> +       for (order = page_reporting_order; order < MAX_ORDER; order++) {
>                 for (mt = 0; mt < MIGRATE_TYPES; mt++) {
>                         /* We do not pull pages from the isolate free list */
>                         if (is_migrate_isolate(mt))
> diff --git a/mm/page_reporting.h b/mm/page_reporting.h
> index 2c385dd4ddbd..c51dbc228b94 100644
> --- a/mm/page_reporting.h
> +++ b/mm/page_reporting.h
> @@ -10,10 +10,9 @@
>  #include <linux/pgtable.h>
>  #include <linux/scatterlist.h>
>
> -#define PAGE_REPORTING_MIN_ORDER       pageblock_order
> -
>  #ifdef CONFIG_PAGE_REPORTING
>  DECLARE_STATIC_KEY_FALSE(page_reporting_enabled);
> +extern unsigned int page_reporting_order;
>  void __page_reporting_notify(void);
>
>  static inline bool page_reported(struct page *page)
> @@ -38,7 +37,7 @@ static inline void page_reporting_notify_free(unsigned int order)
>                 return;
>
>         /* Determine if we have crossed reporting threshold */
> -       if (order < PAGE_REPORTING_MIN_ORDER)
> +       if (order < page_reporting_order)
>                 return;
>
>         /* This will add a few cycles, but should be called infrequently */
> --
> 2.23.0
>
