Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B11E7395806
	for <lists+linux-kernel@lfdr.de>; Mon, 31 May 2021 11:23:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230423AbhEaJYq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 31 May 2021 05:24:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59948 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229550AbhEaJYm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 31 May 2021 05:24:42 -0400
Received: from mail-oo1-xc29.google.com (mail-oo1-xc29.google.com [IPv6:2607:f8b0:4864:20::c29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A3CAFC061574
        for <linux-kernel@vger.kernel.org>; Mon, 31 May 2021 02:23:01 -0700 (PDT)
Received: by mail-oo1-xc29.google.com with SMTP id m15-20020a4ae3cf0000b029024598c3e273so627826oov.13
        for <linux-kernel@vger.kernel.org>; Mon, 31 May 2021 02:23:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=jY9BuK9FNLMjbPTJtB8IDmbrG3t6+tuv/+gLi9Ppjao=;
        b=srDlNUPWE+qZTl9DnNgSplvRBy+lMllJN9jvZUo8wu6+fXy1o8QVoCdZ9Bzjdw3RtP
         sYG7+z4CdNRzG6esqaZ9KededzACmzQGmkz/1KAcKpaCmkEqKYiMNA34dbzHdPDAhwnV
         SMpqCaitIPYFnyllogzeOZtuTFGcCynkf15AC5uuOlISQNvZUIPwRq2vP1DujF21RICR
         DBqzjZlP0AJHP+B1ipPRZZUf5Ld0CZxsuIy+Q89PpfTmxjsDcvGWme/POK7x93vqXR4k
         AR/nY0sP+lroh8F2TX/GoedgEeNahMizurg8mipwioS6m0kFDfu/n2rTnQqd8wad8UuK
         WfHg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=jY9BuK9FNLMjbPTJtB8IDmbrG3t6+tuv/+gLi9Ppjao=;
        b=Zzh8vWQHnmHGHokUbRjuwZstLst1NRCt9gQOsL2AqoRx4nJMGFhzgZa5e+mpiCzXUF
         x/43ZcXuZW5okcUE+3BYeQVTGZlcvJsJmD3hIi6+o6z913EEodE+OGbc1NDt9+TBJy33
         KTt6N5v7vgRl6uJp4e/UUfDCoGcChowkm4ta7SVolVAMPXvQZ7U8n9iK/iRa5eIdWX29
         seUare05q8NUUo8Pj47ILYspfq2uje1wZZ6iGU2ABgfQdjfxqVhT6Ruh5+vUWyb4kU6h
         +Mh9BYDSvBiWnI6A8DI2cgRM6IVeg5q2k1aFDVXxeZX8g9jglJzCOYoD4qUC7Ap4WZAV
         m/9g==
X-Gm-Message-State: AOAM530TtxFlGW32frkoMt5hIwG0vvK+K8l6D/yweFvVvtqBROSnUEmi
        nnAlpoBELxlat7y3MlooYY2KX2JwxE4avYGmTzQ=
X-Google-Smtp-Source: ABdhPJycrk2SDlZgHzTDhg9lJXQwtQoDox9LR72Vg7tmBV/z0zsiYPUgLgQghhPKoDT8OrM+dj0sNsg0LB9NomYB4k4=
X-Received: by 2002:a4a:d89a:: with SMTP id b26mr15783705oov.11.1622452981041;
 Mon, 31 May 2021 02:23:01 -0700 (PDT)
MIME-Version: 1.0
References: <20210518112857.1198415-1-aisheng.dong@nxp.com>
In-Reply-To: <20210518112857.1198415-1-aisheng.dong@nxp.com>
From:   Dong Aisheng <dongas86@gmail.com>
Date:   Mon, 31 May 2021 17:21:51 +0800
Message-ID: <CAA+hA=SSeRrnBRGeqVxJ71Cv0uxydidWoKmG6b0bYzoEdcgqOQ@mail.gmail.com>
Subject: Re: [PATCH 1/1] dma-contiguous: return early for dt case in dma_contiguous_reserve
To:     Dong Aisheng <aisheng.dong@nxp.com>
Cc:     iommu@lists.linux-foundation.org,
        open list <linux-kernel@vger.kernel.org>,
        Christoph Hellwig <hch@lst.de>,
        Marek Szyprowski <m.szyprowski@samsung.com>,
        Robin Murphy <robin.murphy@arm.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, May 18, 2021 at 7:29 PM Dong Aisheng <aisheng.dong@nxp.com> wrote:
>
> dma_contiguous_reserve() aims to support cmdline case for CMA memory
> reserve. But if users define reserved memory in DT,
> 'dma_contiguous_default_area' will not be 0, then it's meaningless
> to continue to run dma_contiguous_reserve(). So we return early
> if detect 'dma_contiguous_default_area' is unzero.
>
> Cc: Christoph Hellwig <hch@lst.de>
> Cc: Marek Szyprowski <m.szyprowski@samsung.com>
> Cc: Robin Murphy <robin.murphy@arm.com>
> Signed-off-by: Dong Aisheng <aisheng.dong@nxp.com>

Gently ping

Regards
Aisheng

> ---
>  kernel/dma/contiguous.c | 5 ++++-
>  1 file changed, 4 insertions(+), 1 deletion(-)
>
> diff --git a/kernel/dma/contiguous.c b/kernel/dma/contiguous.c
> index 3d63d91cba5c..ebade9f43eff 100644
> --- a/kernel/dma/contiguous.c
> +++ b/kernel/dma/contiguous.c
> @@ -171,6 +171,9 @@ void __init dma_contiguous_reserve(phys_addr_t limit)
>         phys_addr_t selected_limit = limit;
>         bool fixed = false;
>
> +       if (dma_contiguous_default_area)
> +               return;
> +
>         pr_debug("%s(limit %08lx)\n", __func__, (unsigned long)limit);
>
>         if (size_cmdline != -1) {
> @@ -191,7 +194,7 @@ void __init dma_contiguous_reserve(phys_addr_t limit)
>  #endif
>         }
>
> -       if (selected_size && !dma_contiguous_default_area) {
> +       if (selected_size) {
>                 pr_debug("%s: reserving %ld MiB for global area\n", __func__,
>                          (unsigned long)selected_size / SZ_1M);
>
> --
> 2.25.1
>
