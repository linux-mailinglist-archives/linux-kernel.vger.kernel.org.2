Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 428EE3E1D0C
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Aug 2021 21:54:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240022AbhHETyu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 5 Aug 2021 15:54:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33258 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239709AbhHETys (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Aug 2021 15:54:48 -0400
Received: from mail-ej1-x631.google.com (mail-ej1-x631.google.com [IPv6:2a00:1450:4864:20::631])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DA483C061765
        for <linux-kernel@vger.kernel.org>; Thu,  5 Aug 2021 12:54:32 -0700 (PDT)
Received: by mail-ej1-x631.google.com with SMTP id u3so11500457ejz.1
        for <linux-kernel@vger.kernel.org>; Thu, 05 Aug 2021 12:54:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=oinuciazXZfKW3TA9YzSzopJrbNJm33ivJgVFjFAUqI=;
        b=TQeDfCeS06LDTcK4A+9yVv4lstRFP3tT1dJQhE+YuLxHRkr5UTy/ZqABUCl53AMO42
         nkX99lqF3uf8sH6Rb08U/TvjAJ7JE9zT/jiQHBZz2Bjm251rLu2ugwOOlF6yIp/r9SPE
         bGcmcKlWebmmDOqGRgxpFq8GdG+G69jl9YO6t3EYEoYlkbLmFNuO9yc8BlGGNhx09zMl
         TR9s195p2O+tFeEKr9dZ2o/Pc9OtTXGFTPoODtbLAzYi9CpdAgIE2CLuVaIaJrSFa5qa
         6qhP/f6tJqAJezayA+1BUHdyKznufJhO4eDYk1EtXb2SGnBTCtamM6N5Nm/F4yrbc/cC
         4ATg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=oinuciazXZfKW3TA9YzSzopJrbNJm33ivJgVFjFAUqI=;
        b=R6xCN/60e26Vegmwbtcj1HnnyLAuqqKEBrL/z8PsA2hW4OUiEDef/r79kDpbaruukc
         ZtTFZLoc1xcZtxNsZzq4aKZvrK993nZ8QPcs/pUDnrI/PpxrA2tzBE8SDr4hb5uZa7h2
         0ozgt6TlS3N1M6rxa6ZXmXK2MXVTHTMKFqfhYSohQ/ZgMsbjAQ30PW2HJwlzjBn+xe83
         i5Omm5mor8oZjJOYagZa1FbQHXwaLF5tAB0LcGWPE0h7Fp49XwEDwL4nGW7zV5Vm7sE2
         P1yofxuiEsbVBEQuFSzIt/aB/wzkvDYjS3D6Iay4tu/DRcrEyexJ6CBdWhxp7W4baUQH
         fYAw==
X-Gm-Message-State: AOAM530kkBW0JLBP/EY04CBbN24mf18nYXeFaB/pjiSyhFkWgfHsd6u2
        2aGUI+03x5DKHPwwI4EOX1/TTfCdxCyHPF9QW+8=
X-Google-Smtp-Source: ABdhPJxkQjEaUpkRe3wmRLfGE8VZoOWXYMUbx4g5Y/9/PRoG4zR+lS4NgOE21pyikNB2anncTFrUTkgGbs9oEBMf/pA=
X-Received: by 2002:a17:906:1919:: with SMTP id a25mr6399565eje.161.1628193271401;
 Thu, 05 Aug 2021 12:54:31 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1628174413.git.baolin.wang@linux.alibaba.com> <d359dcf73a7a868f1b126cb73368fea64aec1f25.1628174413.git.baolin.wang@linux.alibaba.com>
In-Reply-To: <d359dcf73a7a868f1b126cb73368fea64aec1f25.1628174413.git.baolin.wang@linux.alibaba.com>
From:   Yang Shi <shy828301@gmail.com>
Date:   Thu, 5 Aug 2021 12:54:19 -0700
Message-ID: <CAHbLzkrqwOp0a_6Vzn29h9qwCiwVSLL6QzsMLfOYTWj7mtkNZg@mail.gmail.com>
Subject: Re: [PATCH 5/5] mm: migrate: Remove redundant goto labels
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
> Remove redundant goto labels to simplify the code.

TBH I don't see too much benefit. The "goto" makes the functions have
a single exit point.

>
> Signed-off-by: Baolin Wang <baolin.wang@linux.alibaba.com>
> ---
>  mm/migrate.c | 8 +++-----
>  1 file changed, 3 insertions(+), 5 deletions(-)
>
> diff --git a/mm/migrate.c b/mm/migrate.c
> index 0ab364f..ed74fda 100644
> --- a/mm/migrate.c
> +++ b/mm/migrate.c
> @@ -911,9 +911,8 @@ static int move_to_new_page(struct page *newpage, struct page *page,
>                  */
>                 VM_BUG_ON_PAGE(!PageIsolated(page), page);
>                 if (!PageMovable(page)) {
> -                       rc = MIGRATEPAGE_SUCCESS;
>                         __ClearPageIsolated(page);
> -                       goto out;
> +                       return MIGRATEPAGE_SUCCESS;
>                 }
>
>                 rc = mapping->a_ops->migratepage(mapping, newpage,
> @@ -949,7 +948,7 @@ static int move_to_new_page(struct page *newpage, struct page *page,
>                         flush_dcache_page(newpage);
>
>         }
> -out:
> +
>         return rc;
>  }
>
> @@ -2095,11 +2094,10 @@ static struct page *alloc_misplaced_dst_page_thp(struct page *page,
>         newpage = alloc_pages_node(nid, (GFP_TRANSHUGE_LIGHT | __GFP_THISNODE),
>                                    HPAGE_PMD_ORDER);
>         if (!newpage)
> -               goto out;
> +               return NULL;
>
>         prep_transhuge_page(newpage);
>
> -out:
>         return newpage;
>  }
>
> --
> 1.8.3.1
>
>
