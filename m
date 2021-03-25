Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EB230349878
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Mar 2021 18:42:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230139AbhCYRlx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 25 Mar 2021 13:41:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37000 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230041AbhCYRlt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Mar 2021 13:41:49 -0400
Received: from mail-ed1-x536.google.com (mail-ed1-x536.google.com [IPv6:2a00:1450:4864:20::536])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 92932C06174A
        for <linux-kernel@vger.kernel.org>; Thu, 25 Mar 2021 10:41:49 -0700 (PDT)
Received: by mail-ed1-x536.google.com with SMTP id j3so3335924edp.11
        for <linux-kernel@vger.kernel.org>; Thu, 25 Mar 2021 10:41:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=IHDykkReNSm3ZOFg7ydDzHjqeU87p4aBYX134mXqwS0=;
        b=U8jWh1rt8wbsrOMOgiWrInaicpU1aTZUHHFwoA1Ita/pIAdAA2N+zD5kzQaaFLaPm7
         sz5OdDarqh/Rk2foLOjXlf9e1veqEA3Yx8+8IrJJEgVWdRg5QRTJsHD7qGZrVegiu7Kk
         /7KOTRSLAovyXZlTu3IsHtB8SH7Za1zwRuQDKm9vlBxTwvWyRWTh+UUaHsYFzICLOQ/w
         rPKMQ4DaoOQPrKOZYo8UHoCUxnbQQm2eVnBn2m13Hd19URD1Y0vljd6pnpApVgkjPDLf
         EAagTxYcLVwZm84aMRqB3q58U4N++DV3PSwxr7FSwyJZJOnvng8xaLgmnkSRlvcsP1BV
         E60g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=IHDykkReNSm3ZOFg7ydDzHjqeU87p4aBYX134mXqwS0=;
        b=umlngveBxMEgGnTkoAOV0VELgyNXzexjI9gB0xswaUSigjVWljdqTuYSouHoNRx/IO
         OQ+ApcVkKUfGIHD921abLSxdeIkRAv+M1mv5i7VKU3DGOv5uwhfmvURyxQeN06bEvxNh
         5YgnZ19CGjnvtP//dYTSHnvfybeur+uUq8BfSW66YvCvGp/Hm3EkBROeCs5WYEPxp+zI
         BF4hxt+Gh807rT0bTY5/k9Kf4CTuyNs5p36TBSoQEuUJZ4gcsHcWoNfTjFQkr12rSh6y
         s24abNeTeME8tIpBPCojZVU1zTCNJh/TKdq4Fwvkbgm1DiQ4vW/s09lxVhLmU2pfPR0C
         ykYQ==
X-Gm-Message-State: AOAM530dIWmv3cz441ctc752lHbIcOdrLnqJKY4oFGsNu9Nkdk347eqZ
        crL27By2oPTD7+Ulb45nWWscwoBCchmJeit2z0U=
X-Google-Smtp-Source: ABdhPJw+mEY8ZzQ3Maik8xS/iynh/pNdIFiPp8cPjI3hBlOWkrnp2ghRvm/M/KkdIByLOPi05qFw7vQAArqm819rSJA=
X-Received: by 2002:aa7:df86:: with SMTP id b6mr10424244edy.294.1616694108324;
 Thu, 25 Mar 2021 10:41:48 -0700 (PDT)
MIME-Version: 1.0
References: <20210325131524.48181-1-linmiaohe@huawei.com> <20210325131524.48181-2-linmiaohe@huawei.com>
In-Reply-To: <20210325131524.48181-2-linmiaohe@huawei.com>
From:   Yang Shi <shy828301@gmail.com>
Date:   Thu, 25 Mar 2021 10:41:36 -0700
Message-ID: <CAHbLzkrRd1VCKZUVHvSs6VgWphOKMm=8Xt7+_QcTc7b9WVCFnw@mail.gmail.com>
Subject: Re: [PATCH v3 1/5] mm/migrate.c: make putback_movable_page() static
To:     Miaohe Lin <linmiaohe@huawei.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Jerome Glisse <jglisse@redhat.com>,
        Rafael Aquini <aquini@redhat.com>,
        David Hildenbrand <david@redhat.com>,
        Alistair Popple <apopple@nvidia.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux MM <linux-mm@kvack.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Mar 25, 2021 at 6:16 AM Miaohe Lin <linmiaohe@huawei.com> wrote:
>
> The putback_movable_page() is just called by putback_movable_pages() and
> we know the page is locked and both PageMovable() and PageIsolated() is
> checked right before calling putback_movable_page(). So we make it static
> and remove all the 3 VM_BUG_ON_PAGE().

Reviewed-by: Yang Shi <shy828301@gmail.com>

>
> Signed-off-by: Miaohe Lin <linmiaohe@huawei.com>
> ---
>  include/linux/migrate.h | 1 -
>  mm/migrate.c            | 7 +------
>  2 files changed, 1 insertion(+), 7 deletions(-)
>
> diff --git a/include/linux/migrate.h b/include/linux/migrate.h
> index fdf65f23acec..1d8095069b1c 100644
> --- a/include/linux/migrate.h
> +++ b/include/linux/migrate.h
> @@ -44,7 +44,6 @@ extern int migrate_pages(struct list_head *l, new_page_t new, free_page_t free,
>                 unsigned long private, enum migrate_mode mode, int reason);
>  extern struct page *alloc_migration_target(struct page *page, unsigned long private);
>  extern int isolate_movable_page(struct page *page, isolate_mode_t mode);
> -extern void putback_movable_page(struct page *page);
>
>  extern void migrate_prep(void);
>  extern void migrate_prep_local(void);
> diff --git a/mm/migrate.c b/mm/migrate.c
> index 47df0df8f21a..61e7f848b554 100644
> --- a/mm/migrate.c
> +++ b/mm/migrate.c
> @@ -140,15 +140,10 @@ int isolate_movable_page(struct page *page, isolate_mode_t mode)
>         return -EBUSY;
>  }
>
> -/* It should be called on page which is PG_movable */
> -void putback_movable_page(struct page *page)
> +static void putback_movable_page(struct page *page)
>  {
>         struct address_space *mapping;
>
> -       VM_BUG_ON_PAGE(!PageLocked(page), page);
> -       VM_BUG_ON_PAGE(!PageMovable(page), page);
> -       VM_BUG_ON_PAGE(!PageIsolated(page), page);
> -
>         mapping = page_mapping(page);
>         mapping->a_ops->putback_page(page);
>         __ClearPageIsolated(page);
> --
> 2.19.1
>
