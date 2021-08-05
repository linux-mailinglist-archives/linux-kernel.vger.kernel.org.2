Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 469B43E1A99
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Aug 2021 19:42:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239557AbhHERmt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 5 Aug 2021 13:42:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58992 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232410AbhHERmq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Aug 2021 13:42:46 -0400
Received: from mail-ej1-x632.google.com (mail-ej1-x632.google.com [IPv6:2a00:1450:4864:20::632])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BC325C061765
        for <linux-kernel@vger.kernel.org>; Thu,  5 Aug 2021 10:42:31 -0700 (PDT)
Received: by mail-ej1-x632.google.com with SMTP id oz16so10887104ejc.7
        for <linux-kernel@vger.kernel.org>; Thu, 05 Aug 2021 10:42:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=0kwcq2vwgaqhWyej8Dvyil/ttiS5XKEcNi0TvEB5Tgc=;
        b=kp21L82WdyWCKPskjHwNLuKwoR7OjYhu+Uku9LXRiS4Gb+FFi6jLIFyr6Fnjpl1Ro/
         d2+itDg/f6QOGZCtG4D0tcw2ZS9vdVl2+7VA7JLgSoT7dUG5SuhXArTpzKONFKm2WTOz
         P3y474xCNac2WQYs1IPvi032xsUwqhgt5nAy4ssa011XN/H6kc9ik5+VPsvNZozdmZwC
         sVGcHs8dENUbE1lXhhO0R5IjNfe4m1rVuuQmf/boWWukm83ZVTYeRVC6O4ZT4spzwE9i
         RXOpep6KvDNZYtmpOIOI3QxMbZfFi8I/h0ANTXR4auBOsXsci+iihbdsHYqDBEqh2zHG
         0gJQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=0kwcq2vwgaqhWyej8Dvyil/ttiS5XKEcNi0TvEB5Tgc=;
        b=nZAMJXsM76kACoDXbSE1nhSn8KEPOpKDA76N6HYywa+3TLFSpo+UmfU4Fn8TTDLLQQ
         YWDscCr7WgNcTMkWb67smhrArE8XUhhaNY0lXffEINlDyZkQO0NQSjCuDjFX0OJbXtCs
         s/e+0viO+oZgCilwI7Om2jz09R2t4ELc1sc0e1KuFCHW8suimOiENlG3KTh5rY3ehrhh
         pzDoU+nzVTRSV4tHvbmVvUrP2ODmsN05JZdl0YuoKdYR4rj+9bOVf3zMWXT+OoSUbKZQ
         H2q/+9sr79FA/eSsNkNiA7Hwl5HQCuUpiAmHidf2UGlpE+cN4IHq8DIvUdX4lAJcEyZ8
         CTOw==
X-Gm-Message-State: AOAM531J/ipYqBm9ocTLcMeBJqqw70gVhGnjon8nXOd5uRQIHlcRVIE8
        imtBQ8MroNT9LEM40lh4bnBMB2Ps/OSAZwexMk0dviZofZU=
X-Google-Smtp-Source: ABdhPJxI/c74AwqjFKwul5SxdIi97MikBfUfUiOxUUUhcEOTSTNO4DJsQJ0op0B27fm4QQKtjZEgVcZTe6OX9tYe3Rs=
X-Received: by 2002:a17:906:58d1:: with SMTP id e17mr3663543ejs.383.1628185350291;
 Thu, 05 Aug 2021 10:42:30 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1628174413.git.baolin.wang@linux.alibaba.com> <b06c1515a4520f8d8259c991320a44c54c56edfa.1628174413.git.baolin.wang@linux.alibaba.com>
In-Reply-To: <b06c1515a4520f8d8259c991320a44c54c56edfa.1628174413.git.baolin.wang@linux.alibaba.com>
From:   Yang Shi <shy828301@gmail.com>
Date:   Thu, 5 Aug 2021 10:42:18 -0700
Message-ID: <CAHbLzkqKvB6NJXPD2oiuKVr4AdESEGSBzRdFCiMv3Re+=nJFFg@mail.gmail.com>
Subject: Re: [PATCH 2/5] mm: migrate: Introduce a local variable to get the
 number of pages
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
> Use thp_nr_pages() instead of compound_nr() to get the number of pages
> for THP page, meanwhile introducing a local variable 'nr_pages' to
> avoid getting the number of pages repeatedly.
>
> Signed-off-by: Baolin Wang <baolin.wang@linux.alibaba.com>

Reviewed-by: Yang Shi <shy828301@gmail.com>

> ---
>  mm/migrate.c | 5 +++--
>  1 file changed, 3 insertions(+), 2 deletions(-)
>
> diff --git a/mm/migrate.c b/mm/migrate.c
> index 5559571..eeba4c6 100644
> --- a/mm/migrate.c
> +++ b/mm/migrate.c
> @@ -2106,6 +2106,7 @@ static struct page *alloc_misplaced_dst_page_thp(struct page *page,
>  static int numamigrate_isolate_page(pg_data_t *pgdat, struct page *page)
>  {
>         int page_lru;
> +       int nr_pages = thp_nr_pages(page);
>
>         VM_BUG_ON_PAGE(compound_order(page) && !PageTransHuge(page), page);
>
> @@ -2114,7 +2115,7 @@ static int numamigrate_isolate_page(pg_data_t *pgdat, struct page *page)
>                 return 0;
>
>         /* Avoid migrating to a node that is nearly full */
> -       if (!migrate_balanced_pgdat(pgdat, compound_nr(page)))
> +       if (!migrate_balanced_pgdat(pgdat, nr_pages))
>                 return 0;
>
>         if (isolate_lru_page(page))
> @@ -2122,7 +2123,7 @@ static int numamigrate_isolate_page(pg_data_t *pgdat, struct page *page)
>
>         page_lru = page_is_file_lru(page);
>         mod_node_page_state(page_pgdat(page), NR_ISOLATED_ANON + page_lru,
> -                               thp_nr_pages(page));
> +                           nr_pages);
>
>         /*
>          * Isolating the page has taken another reference, so the
> --
> 1.8.3.1
>
>
