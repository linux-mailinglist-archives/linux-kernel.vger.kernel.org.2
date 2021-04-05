Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 771C03546BB
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Apr 2021 20:21:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235084AbhDESVJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 5 Apr 2021 14:21:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34840 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234552AbhDESVI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Apr 2021 14:21:08 -0400
Received: from mail-ed1-x52d.google.com (mail-ed1-x52d.google.com [IPv6:2a00:1450:4864:20::52d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7603DC061756
        for <linux-kernel@vger.kernel.org>; Mon,  5 Apr 2021 11:21:00 -0700 (PDT)
Received: by mail-ed1-x52d.google.com with SMTP id r22so1016423edq.9
        for <linux-kernel@vger.kernel.org>; Mon, 05 Apr 2021 11:21:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=ar3GZrsZAoxiwaAKwrinVn8bd57MclGABFFkui0oZ7I=;
        b=G0UX1D8YfamriSLn3tfIkyF1l768/z4Xvh1tKbjmEG1uLpzn1fx/8gSAJlyUta81or
         ruksmpskDrHNltCP+Q30iit0IzFAbdMRql6dB/3OOj047Lu2RLpkzkQTdQY4TKLjTjvE
         jj/H5F+n5ItEubcI5J/cr+W6LimqipbYprxlP+zTWVCOwbbjJMPb35fNoFZqlE3HQ1Yw
         rwRdq+vcPtf2CKnRBHcvEnXXtiSQBwdi11oRuM68qebKhKawmELORybovjV+kda2RuBj
         BSs2rnokh73Q73EhJFbrlOQZdDhZvjm9ZwIEkqxbQKk1dcz4DPjbyM4ezEFAePIQ3/ll
         frmQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=ar3GZrsZAoxiwaAKwrinVn8bd57MclGABFFkui0oZ7I=;
        b=ul3+QUhagmvmaA4fpWRdma5LzHmYD7cjUrKABieqEwCP7yWeBz6cAZHKkVGOlV7Tbm
         VQ8pVI6xiTzqLL3fgpUI/DyDtrr1ZEJQ6GhZzeW/gX3AmvIRSIOV23Y9wVrb42o1UOWC
         oKGMuc5agmMuKOITKOyjKXMJ0i3bdvgHDUvchvx5nOfGk/sVcDE6TZj6/Qo83zIht/Of
         +YkzvUjJDxcgj1uiAribXKLrWe63PmYmcwsfE3B8pU4aiMLxbxaQZlrKLYg9Eebkj56s
         kuP8FdPdsHtrlZLvz4anqMhxy6UZWmqNb1iJz2iy95HY8alPQObIdi9LlmJF+E3NQiGb
         Laog==
X-Gm-Message-State: AOAM533soJkSZSJWOWWJA0IexTa+UcyyBFo9gdf/U/+V7qGr8tprHkVC
        mY+502z4S7+JyMq3fjwwiPiu5hPP0+8j0dCRDpg=
X-Google-Smtp-Source: ABdhPJz7QeRur+MyAqiN11SWCKHFaFv4fhHO+gOj977Bx3XnFcOx1Iochb84NWrFN+I8LYgq2RgLHqrI1mnc6UX9Hyo=
X-Received: by 2002:a05:6402:518d:: with SMTP id q13mr33195428edd.313.1617646859199;
 Mon, 05 Apr 2021 11:20:59 -0700 (PDT)
MIME-Version: 1.0
References: <20210404153311.1460106-1-yanfei.xu@windriver.com> <20210404153311.1460106-3-yanfei.xu@windriver.com>
In-Reply-To: <20210404153311.1460106-3-yanfei.xu@windriver.com>
From:   Yang Shi <shy828301@gmail.com>
Date:   Mon, 5 Apr 2021 11:20:47 -0700
Message-ID: <CAHbLzkrSaODz+SeT+GY3tOS6Jm8NSznmknP83RUCrn+Sr9cAAg@mail.gmail.com>
Subject: Re: [PATCH 2/2] mm: khugepaged: check MMF_DISABLE_THP ahead of
 iterating over vmas
To:     yanfei.xu@windriver.com
Cc:     Linux MM <linux-mm@kvack.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Apr 4, 2021 at 8:33 AM <yanfei.xu@windriver.com> wrote:
>
> From: Yanfei Xu <yanfei.xu@windriver.com>
>
> We could check MMF_DISABLE_THP ahead of iterating over all of vma.
> Otherwise if some mm_struct contain a large number of vma, there will
> be amounts meaningless cpu cycles cost.
>
> BTW, drop an unnecessary cond_resched(), because there is a another
> cond_resched() followed it and no consumed invocation between them.
>
> Signed-off-by: Yanfei Xu <yanfei.xu@windriver.com>
> ---
>  mm/khugepaged.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
>
> diff --git a/mm/khugepaged.c b/mm/khugepaged.c
> index 2efe1d0c92ed..c293ec4a94ea 100644
> --- a/mm/khugepaged.c
> +++ b/mm/khugepaged.c
> @@ -2094,6 +2094,8 @@ static unsigned int khugepaged_scan_mm_slot(unsigned int pages,
>          */
>         if (unlikely(!mmap_read_trylock(mm)))
>                 goto breakouterloop_mmap_lock;
> +       if (test_bit(MMF_DISABLE_THP, &mm->flags))
> +               goto breakouterloop_mmap_lock;

It is fine to check this flag. But mmap_lock has been acquired so you
should jump to breakouterloop.

>         if (likely(!khugepaged_test_exit(mm)))
>                 vma = find_vma(mm, khugepaged_scan.address);
>
> @@ -2101,7 +2103,6 @@ static unsigned int khugepaged_scan_mm_slot(unsigned int pages,
>         for (; vma; vma = vma->vm_next) {
>                 unsigned long hstart, hend;
>
> -               cond_resched();

I don't have a strong opinion for removing this cond_resched(). But
IIUC khugepaged is a best effort job there is no harm to keep it IMHO.

>                 if (unlikely(khugepaged_test_exit(mm))) {
>                         progress++;
>                         break;
> --
> 2.27.0
>
>
