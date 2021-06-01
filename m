Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D7F253971DA
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Jun 2021 12:52:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233650AbhFAKye (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 1 Jun 2021 06:54:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33254 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230282AbhFAKyc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Jun 2021 06:54:32 -0400
Received: from mail-pf1-x42b.google.com (mail-pf1-x42b.google.com [IPv6:2607:f8b0:4864:20::42b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6AB25C061574
        for <linux-kernel@vger.kernel.org>; Tue,  1 Jun 2021 03:52:50 -0700 (PDT)
Received: by mail-pf1-x42b.google.com with SMTP id z26so7079101pfj.5
        for <linux-kernel@vger.kernel.org>; Tue, 01 Jun 2021 03:52:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=gCRowJKEF6abtOyiSLRhg1Y3idIlIdXjyYVD3tmG9YY=;
        b=kQ06QptlyaouHmPEZoKAx6vMrnJfCWjKQgzgmVeiLtojUjNkX+/CCe7yJbhmpWhet6
         JSk4MB/c5YOt+3BLXcIy9HLf0+I3TjnIapaLK3tmJXxYUiHdLDCq3JhQ/2vMx2I4PYpg
         qBxz0/9Op8rZ2gREcRC+jL1HXkac8zWL7mer5VuI6LmU0uNv8BIvffW28fvMDM5oauom
         KYRghkfi/SGT53URu8216lBfFK0/jlmWvJfdGwirPO4hEWgWLRxZzxbd5AOXcJ8OF7LX
         o6iXo0THhRAyc5FPhv3BwPTKTaCyyTgbWiRxcLhynqAzUhq03ke2unKFRvuzRwSc2hRl
         dZAw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=gCRowJKEF6abtOyiSLRhg1Y3idIlIdXjyYVD3tmG9YY=;
        b=HOb2Xxj/d/js1oucrakicif3Zfb+3U8Q3X/W+MoGyFA//VTz6VbgtZHpmYH/UCwzOJ
         OEoOYQ35PjAPxu313kkGboWLtx/pWce1sfl9SDN4vO1grsNX78pFIc4f3uRZNt1FaVOJ
         flf7qjete3aEDQhScX/zh878FsdlDYzV8t7npQnk2j1mK38sXOtJgRF0915D5WtH2joQ
         EYbOQmPJuCWbXJjeUUnmwDjQBGRF9h0HCbiQnNHaeifHansXjoTNowbNhQsylor3m9D4
         Tinzcf4nxk9ShOU/kJbyimJeisiy7sjR6RPCkoXqYXQz+yzb59CLM8ENKSEYKg25jJZZ
         Ju7Q==
X-Gm-Message-State: AOAM531Rch1HhTr9eQ8du4i5O+MDTUjsXLFoqZYdwRmCinCBMiHKU8WC
        X0gH2e5g5WR2zyalsZvbEQe3eN615jZp6q/O2dBG8Q==
X-Google-Smtp-Source: ABdhPJyY3Og9DuDfi3jlT2rFT/1OIbsdz5p57E5ro/YoqnayLxkjkO+KqnCp9w6rmNR0cRd+mbEfe4iFfC3fOgwxh/c=
X-Received: by 2002:a05:6a00:c86:b029:2e9:3041:162f with SMTP id
 a6-20020a056a000c86b02902e93041162fmr21353488pfv.78.1622544769781; Tue, 01
 Jun 2021 03:52:49 -0700 (PDT)
MIME-Version: 1.0
References: <YLX9FCOU0Il8Ejoy@mwanda>
In-Reply-To: <YLX9FCOU0Il8Ejoy@mwanda>
From:   Mina Almasry <almasrymina@google.com>
Date:   Tue, 1 Jun 2021 03:52:38 -0700
Message-ID: <CAHS8izMrnLPD1_J5wPPREZixX6WaOtb6qjMZ_nYNjzYo5Zw3_g@mail.gmail.com>
Subject: Re: [PATCH] mm: hugetlb: checking for IS_ERR() instead of NULL
To:     Dan Carpenter <dan.carpenter@oracle.com>
Cc:     Mike Kravetz <mike.kravetz@oracle.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Stephen Rothwell <sfr@canb.auug.org.au>,
        Linux-MM <linux-mm@kvack.org>,
        open list <linux-kernel@vger.kernel.org>,
        kernel-janitors@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jun 1, 2021 at 2:26 AM Dan Carpenter <dan.carpenter@oracle.com> wrote:
>
> The alloc_migrate_huge_page() doesn't return error pointers, it returns
> NULL.
>
> Fixes: ab45bc8b5910 ("mm, hugetlb: fix resv_huge_pages underflow on UFFDIO_COPY")
> Signed-off-by: Dan Carpenter <dan.carpenter@oracle.com>
> ---
>  mm/hugetlb.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>

Gah, my bad.

Reviewed-by: Mina Almasry <almasrymina@google.com>

> diff --git a/mm/hugetlb.c b/mm/hugetlb.c
> index 69a4b551c157..3221c94b4749 100644
> --- a/mm/hugetlb.c
> +++ b/mm/hugetlb.c
> @@ -5103,7 +5103,7 @@ int hugetlb_mcopy_atomic_pte(struct mm_struct *dst_mm,
>                          */
>                         page = alloc_migrate_huge_page(h, gfp_mask, node,
>                                                        nodemask);
> -                       if (IS_ERR(page)) {
> +                       if (!page) {
>                                 ret = -ENOMEM;
>                                 goto out;
>                         }
> --
> 2.30.2
>
