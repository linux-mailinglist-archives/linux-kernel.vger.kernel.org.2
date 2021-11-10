Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1467344CA76
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Nov 2021 21:19:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232477AbhKJUWI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 10 Nov 2021 15:22:08 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37604 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231254AbhKJUWH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 Nov 2021 15:22:07 -0500
Received: from mail-lf1-x129.google.com (mail-lf1-x129.google.com [IPv6:2a00:1450:4864:20::129])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6F33EC061764
        for <linux-kernel@vger.kernel.org>; Wed, 10 Nov 2021 12:19:19 -0800 (PST)
Received: by mail-lf1-x129.google.com with SMTP id f18so8808012lfv.6
        for <linux-kernel@vger.kernel.org>; Wed, 10 Nov 2021 12:19:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=sfkLEyAh2f0FnZgoyr5ZOnaxpuprPl9HQyaWcoACmR8=;
        b=sqjWIl2uzMEK2g5GksLYcz/qLHpXgLzH13UQB3j1AUlei4YSIvbgoY5o/k2+vT7Wg+
         VyCIULycAv3lK5CmoVpP+rVNfmeUqzrp7Wb32G8OzooVp1VJQhgghC3VbkRyp+Je7Emh
         fjc8RFf0NZEGOOFa7AGURqpR+wFVOLhPvpVq+i/TQxQhd3MBY4Hasd5OuCVJWfUZEpce
         TYvr/rZz2A347yMu2gkQEcknY6LmUYJTvR78OlfQUS6A1xFzVTV55SC0YkyoSpxPG3Gz
         63RCKroXx6LgLISkyWb2bMemYWJcxVO+nxgTKx2Gov3SlpN+rgtdmkwrBJKg6Y8zrp0m
         G6CA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=sfkLEyAh2f0FnZgoyr5ZOnaxpuprPl9HQyaWcoACmR8=;
        b=nW5aTAwaP07Mf4v8rERneODJi8kza9MYUHRkSpUm9oeZhicntJ521xkwhFXvOLJANz
         rA2po/9qwmkdoY9KKmWfAEz8Ad2T+pZONBmzwgzxs8x1h5iYdkEHFnnpAZp1YewJFxLm
         hILihoWNNk3DuJZN4QDSez6uePD724FTD2mYGC9f+FgLpkWDo+at7F8Jy5XO04s4VuG/
         Rc5BEi1lKULTJalW9nYhp/7BmsjJns9G6/i5AsmmYx4I3pCwJ627agG7RhM0dIg/m895
         pJXBU1GSpnUfo/llGmf+qqt/mXeR8YHT8oFwTPkVR6wmjyzHZJ+3BS6YJibXfTVXkKcu
         rr5A==
X-Gm-Message-State: AOAM531zjWm6cVyOj4f7nH6lm5x4znvRVY36FSDP+9q8SPxEbrywBT+G
        /UZjGtdBOAwOGM8q1JQ7nBHsgvgvu5JUu6rGxOMynA==
X-Google-Smtp-Source: ABdhPJxqn/www7tIhoKSEkqyNjE2zOFSoBeoIMJ138IF8vw8u0UOPO9GEH/e0CpTKJg2Xjx8Ov1vhkFgbm43fEr/eoY=
X-Received: by 2002:ac2:4d19:: with SMTP id r25mr1658265lfi.82.1636575557693;
 Wed, 10 Nov 2021 12:19:17 -0800 (PST)
MIME-Version: 1.0
References: <YYhY7GqlrcTZlzuA@fedora>
In-Reply-To: <YYhY7GqlrcTZlzuA@fedora>
From:   Nick Desaulniers <ndesaulniers@google.com>
Date:   Wed, 10 Nov 2021 12:19:06 -0800
Message-ID: <CAKwvOd=SsrCy=aG_t2=58YFymR-j6Rp-Jxb_RDfFwX3Lfy8E2g@mail.gmail.com>
Subject: Re: [PATCH] iommu/vt-d: Remove unused dma_to_mm_pfn function
To:     =?UTF-8?B?TWHDrXJhIENhbmFs?= <maira.canal@usp.br>
Cc:     dwmw2@infradead.org, baolu.lu@linux.intel.com, joro@8bytes.org,
        will@kernel.org, nathan@kernel.org,
        iommu@lists.linux-foundation.org, linux-kernel@vger.kernel.org,
        llvm@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Nov 7, 2021 at 2:53 PM Ma=C3=ADra Canal <maira.canal@usp.br> wrote:
>
> Remove dma_to_buf_pfn function, which is not used in the codebase.
>
> This was pointed by clang with the following warning:
>
> drivers/iommu/intel/iommu.c:136:29: warning: unused function
> 'dma_to_mm_pfn' [-Wunused-function]
> static inline unsigned long dma_to_mm_pfn(unsigned long dma_pfn)
>                             ^

Thanks for the patch!
Fixes: dd4e831960e4f ("intel-iommu: Change dma_set_pte_addr() to
dma_set_pte_pfn()")
Reviewed-by: Nick Desaulniers <ndesaulniers@google.com>

>
> Signed-off-by: Ma=C3=ADra Canal <maira.canal@usp.br>
> ---
>  drivers/iommu/intel/iommu.c | 5 -----
>  1 file changed, 5 deletions(-)
>
> diff --git a/drivers/iommu/intel/iommu.c b/drivers/iommu/intel/iommu.c
> index 0bde0c8b4126..35300b5b69f7 100644
> --- a/drivers/iommu/intel/iommu.c
> +++ b/drivers/iommu/intel/iommu.c
> @@ -133,11 +133,6 @@ static inline unsigned long lvl_to_nr_pages(unsigned=
 int lvl)
>
>  /* VT-d pages must always be _smaller_ than MM pages. Otherwise things
>     are never going to work. */
> -static inline unsigned long dma_to_mm_pfn(unsigned long dma_pfn)
> -{
> -       return dma_pfn >> (PAGE_SHIFT - VTD_PAGE_SHIFT);
> -}
> -
>  static inline unsigned long mm_to_dma_pfn(unsigned long mm_pfn)
>  {
>         return mm_pfn << (PAGE_SHIFT - VTD_PAGE_SHIFT);
> --
> 2.31.1
>


--=20
Thanks,
~Nick Desaulniers
