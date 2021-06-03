Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4564539AD7A
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Jun 2021 00:09:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230407AbhFCWL0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 3 Jun 2021 18:11:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60402 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229576AbhFCWLZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Jun 2021 18:11:25 -0400
Received: from mail-ej1-x62c.google.com (mail-ej1-x62c.google.com [IPv6:2a00:1450:4864:20::62c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 07710C06174A
        for <linux-kernel@vger.kernel.org>; Thu,  3 Jun 2021 15:09:30 -0700 (PDT)
Received: by mail-ej1-x62c.google.com with SMTP id l1so11475484ejb.6
        for <linux-kernel@vger.kernel.org>; Thu, 03 Jun 2021 15:09:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=xzfzoB78UopFehP2rZuPNY6pMK6KSVtNl9pjPqUQdkg=;
        b=OXddwIVVqk7mMnbvUmy/B4vinnZoldRQPMmjX0oGBP4JWDb74m2zdXEvW/MiQqbJ5B
         MYfQ9M76M6Ih+vqYWZnBvTdP4DhooLQ8/v7XnkSBhUTlN7UKKw+0CKsr6tpqU2sAnYjV
         NCv2RRzp0+4h9cVbfCJkOS+NmFEHGftO/QWi/FKP/r6BPiuV7k2Z6PgUgZkj/4IHaRCc
         KDNjLToXSAjAkKIYnBO7YYgW9sYdKCncFIY6Hz0yWhdnDsh0fpT611aT58zYII6ArLUN
         hHpzUPg2uUHNwtm0UlhJXvZWjy3PFtyNUUBB688zGQ8EEtn4ZPSZrsaB+3HSUGZd7VC0
         R9vw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=xzfzoB78UopFehP2rZuPNY6pMK6KSVtNl9pjPqUQdkg=;
        b=KCvK4g+QQdcHcMH/KqcVMxFEZoD0vameXnN1EBik06gvqIA/yL9n+jlpQowtu8Gc9Z
         Cucl2+Jtf4CxyVmVn5iqXhH+sQYXpKlDpHZTDBByy9CJsrOEqmJ/Bkk3UmGTjYq6/5Wd
         LxR1UQJT9KfrIbUKeEwlAnzSUuhvoU+NuCYGNnxGIX3Fj2paEGlEMFQg1I3GJgT2SoDa
         LKpIdjrqb/MYIZS9B+jpn7DJeDMZcWWCDn4YueB32ufuxeXbu6bZubbhDc6ylYZl/xyG
         IKCsO70GM9ni06qDXgE7btqpEVKksRRhVhXgNqnxtk2HejuFhLUdSv4wc35txiNjMN5U
         x2/g==
X-Gm-Message-State: AOAM530DAUVSjtwU0dVguM/HNSRDkWvBYo5sBNRQalqj6pMEsZIRmeLg
        yFSW52k/onlOtaf23LNvVkseMZ20H1KdSExnNos=
X-Google-Smtp-Source: ABdhPJw0W4kHchr2hzsUBmxSKzORn+tZaxPDtWRmhXgCiAZoFnWh2VecE/kBv9g50EPNCC4vXMEKsDkIjvsDoUfgf1Q=
X-Received: by 2002:a17:906:3912:: with SMTP id f18mr1235862eje.161.1622758168683;
 Thu, 03 Jun 2021 15:09:28 -0700 (PDT)
MIME-Version: 1.0
References: <alpine.LSU.2.11.2106011353270.2148@eggly.anvils> <alpine.LSU.2.11.2106011415430.2148@eggly.anvils>
In-Reply-To: <alpine.LSU.2.11.2106011415430.2148@eggly.anvils>
From:   Yang Shi <shy828301@gmail.com>
Date:   Thu, 3 Jun 2021 15:09:17 -0700
Message-ID: <CAHbLzkoW+XVcf+DAvMArJTvapUfygQxQXX9AwfCN7tjrEGiUdQ@mail.gmail.com>
Subject: Re: [PATCH 7/7] mm/thp: remap_page() is only needed on anonymous THP
To:     Hugh Dickins <hughd@google.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
        Wang Yugui <wangyugui@e16-tech.com>,
        Matthew Wilcox <willy@infradead.org>,
        Naoya Horiguchi <naoya.horiguchi@nec.com>,
        Alistair Popple <apopple@nvidia.com>,
        Ralph Campbell <rcampbell@nvidia.com>, Zi Yan <ziy@nvidia.com>,
        Miaohe Lin <linmiaohe@huawei.com>,
        Minchan Kim <minchan@kernel.org>, Jue Wang <juew@google.com>,
        Peter Xu <peterx@redhat.com>, Jan Kara <jack@suse.cz>,
        Linux MM <linux-mm@kvack.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jun 1, 2021 at 2:17 PM Hugh Dickins <hughd@google.com> wrote:
>
> THP splitting's unmap_page() only sets TTU_SPLIT_FREEZE when PageAnon,
> and migration entries are only inserted when TTU_MIGRATION (unused here)
> or TTU_SPLIT_FREEZE is set: so it's just a waste of time for remap_page()
> to search for migration entries to remove when !PageAnon.
>
> Fixes: baa355fd3314 ("thp: file pages support for split_huge_page()")
> Signed-off-by: Hugh Dickins <hughd@google.com>

Reviewed-by: Yang Shi <shy828301@gmail.com>

> ---
>  mm/huge_memory.c | 5 +++++
>  1 file changed, 5 insertions(+)
>
> diff --git a/mm/huge_memory.c b/mm/huge_memory.c
> index 305f709a7aca..e4a83e310452 100644
> --- a/mm/huge_memory.c
> +++ b/mm/huge_memory.c
> @@ -2354,6 +2354,7 @@ static void unmap_page(struct page *page)
>
>         VM_BUG_ON_PAGE(!PageHead(page), page);
>
> +       /* If TTU_SPLIT_FREEZE is ever extended to file, update remap_page() */
>         if (PageAnon(page))
>                 ttu_flags |= TTU_SPLIT_FREEZE;
>
> @@ -2368,6 +2369,10 @@ static void unmap_page(struct page *page)
>  static void remap_page(struct page *page, unsigned int nr)
>  {
>         int i;
> +
> +       /* If TTU_SPLIT_FREEZE is ever extended to file, remove this check */
> +       if (!PageAnon(page))
> +               return;
>         if (PageTransHuge(page)) {
>                 remove_migration_ptes(page, page, true);
>         } else {
> --
> 2.32.0.rc0.204.g9fa02ecfa5-goog
>
