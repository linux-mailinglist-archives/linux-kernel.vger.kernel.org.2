Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CAD2D35770C
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Apr 2021 23:41:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233976AbhDGVlW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 7 Apr 2021 17:41:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58564 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233880AbhDGVlU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Apr 2021 17:41:20 -0400
Received: from mail-ej1-x62e.google.com (mail-ej1-x62e.google.com [IPv6:2a00:1450:4864:20::62e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 45F47C061761
        for <linux-kernel@vger.kernel.org>; Wed,  7 Apr 2021 14:41:09 -0700 (PDT)
Received: by mail-ej1-x62e.google.com with SMTP id u17so23812706ejk.2
        for <linux-kernel@vger.kernel.org>; Wed, 07 Apr 2021 14:41:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=9SQ0hw9S+bPEMfp5AGgdbU/K5VN9SJhDyLuUFosgsgY=;
        b=ESHvBwnuUCFygLrjCnezEKDuoL+Hh4uXgo88Dp2LIkN5nmUE8680L3lZPgur65/3SE
         5ZNfyhRfiPGtLknk5Tjxco4axiImqC+O/lqBsuMY3CUgKoO/X8MDppiL91tJlF5YzKFU
         4K7NDpzVwc0dishcJoWXBoY17GZiz8/oX2P8hrIWyRAXc74nGeOr2NgGJzJASYZDsffD
         m1h3pNHs7MSV+oMoaxKLBOpSXhQGY18CxgjGOiprRzkX+9Z56FVNdlO+L9ZngzwSZQ+n
         KQSOFThhR5Q71KdvgJJ/4NGlrjVh1DJF2kyAQadGTstAE+uhE6jhqxa6HDvMsWQGGV36
         FNuQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=9SQ0hw9S+bPEMfp5AGgdbU/K5VN9SJhDyLuUFosgsgY=;
        b=cVZ5AbLCtKtfilRB0J+qt9x37LmzLEQXwuppDaaLGyGc43Mk3YnQy/Dw0OTJ2QPeGC
         pQaiCbe6vP6WH7xC4YPAE014S3DCcSPNjyGNdeJaBGAFOzVQYX68u3P1CEn8VY8YOt9u
         /EjI1GpLysAc2Y+NuUJwDRDuSWfmRAeBdJVV+PGElsU6hBpa3ISu52BpsJaFRN6ZpiyS
         wsXEdFHsw2sUp6GwoTZwm94wnUgZlHC8miQh7xddUt4bLgGzqI9ic8tE8WtUxlLRZo1i
         hv1iF490bcizhepYMsGv6evY09KCH1gtraDcfoAxn0xKPhJFp6DL1lJ9I7E+cWYRHmHL
         BqnQ==
X-Gm-Message-State: AOAM533CCThV3MAsUKk4nl4t6GvSBW9o2MR2qpu5lIHE5XBu4I5kACGe
        Ul4GwiBHYpSQo+vWDMUhVS2Fe/M8io7zleVUkac=
X-Google-Smtp-Source: ABdhPJxRFtyJp1tZ+HioE3vlOFvVHCWtnaJxYQgCxv1aKGweVa32E2fq+27a96LfqGIyz99oBQxT8XIFACN97foEs8I=
X-Received: by 2002:a17:906:b296:: with SMTP id q22mr6182541ejz.161.1617831667800;
 Wed, 07 Apr 2021 14:41:07 -0700 (PDT)
MIME-Version: 1.0
References: <20210407030548.189104-1-yanfei.xu@windriver.com> <20210407030548.189104-3-yanfei.xu@windriver.com>
In-Reply-To: <20210407030548.189104-3-yanfei.xu@windriver.com>
From:   Yang Shi <shy828301@gmail.com>
Date:   Wed, 7 Apr 2021 14:40:56 -0700
Message-ID: <CAHbLzkqR28PW9eYJAXCjXBL+=cxQDXFrXiPfDkxCDYPB+1HgiA@mail.gmail.com>
Subject: Re: [PATCH v2 2/2] mm: khugepaged: check MMF_DISABLE_THP ahead of
 iterating over vmas
To:     "Xu, Yanfei" <yanfei.xu@windriver.com>
Cc:     Linux MM <linux-mm@kvack.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Apr 6, 2021 at 8:06 PM <yanfei.xu@windriver.com> wrote:
>
> From: Yanfei Xu <yanfei.xu@windriver.com>
>
> We could check MMF_DISABLE_THP ahead of iterating over all of vma.
> Otherwise if some mm_struct contain a large number of vma, there will
> be amounts meaningless cpu cycles cost.

Reviewed-by: Yang Shi <shy828301@gmail.com>

>
> Signed-off-by: Yanfei Xu <yanfei.xu@windriver.com>
> ---
>  mm/khugepaged.c | 2 ++
>  1 file changed, 2 insertions(+)
>
> diff --git a/mm/khugepaged.c b/mm/khugepaged.c
> index a6012b9259a2..f4ad25a7db55 100644
> --- a/mm/khugepaged.c
> +++ b/mm/khugepaged.c
> @@ -2094,6 +2094,8 @@ static unsigned int khugepaged_scan_mm_slot(unsigned int pages,
>          */
>         if (unlikely(!mmap_read_trylock(mm)))
>                 goto breakouterloop_mmap_lock;
> +       if (test_bit(MMF_DISABLE_THP, &mm->flags))
> +               goto breakouterloop;
>         if (likely(!khugepaged_test_exit(mm)))
>                 vma = find_vma(mm, khugepaged_scan.address);
>
> --
> 2.27.0
>
