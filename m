Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A1CB04334DA
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Oct 2021 13:38:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235461AbhJSLkE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 19 Oct 2021 07:40:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53076 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235401AbhJSLj7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Oct 2021 07:39:59 -0400
Received: from mail-lf1-x12b.google.com (mail-lf1-x12b.google.com [IPv6:2a00:1450:4864:20::12b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E651AC061772
        for <linux-kernel@vger.kernel.org>; Tue, 19 Oct 2021 04:37:37 -0700 (PDT)
Received: by mail-lf1-x12b.google.com with SMTP id x27so6774047lfu.5
        for <linux-kernel@vger.kernel.org>; Tue, 19 Oct 2021 04:37:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=U36LIf5+tljufBvVEM58yc8vCPbhSTcJ8OL4uJO2PFM=;
        b=zEOFkXRvhUqeeBzMbMrkfCpPQwfb2xW23osQXL1q9VtS9XMSBvnFtcInNPvmzPCv2i
         Y/4Szbo8QuKG70ldNdcts4hXKIdKoV7R3s7WcT/PJvA4pV1japkkbY4eWI/37YAYBAs7
         SRKyZL/1qFGHnhoznGUdDx0CNYwgGHmL1xoYHmOyy3L21EzqOigNuWA4s3Iqz7JbhREp
         xRrzaDUW+FlE8K4oLUDSpELoxfWOZ9dciloZxAtiKXs4WGFenYy9FpihvHclQ/2L9f7r
         4GDv2Wrj2uWORwrV31M7yLPbQKHky+hRKpk9tpYVWmYWtFJyAz6U+KBqHpW95tp/EF/U
         BkTQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=U36LIf5+tljufBvVEM58yc8vCPbhSTcJ8OL4uJO2PFM=;
        b=cUTv5dtk8tmu6IDxWLKqDxk5n//CHDwoB5tJFfrlkD7cBQdkvO9xsOTPP7AfAB1598
         TAVBKk2rkvFMkR82f84gJ4qYXxvsvvF/zec5zxCUpGzSjIfd48Ui/igCrQaPYQ27kn4U
         afmXAXMpwoLjAZdLOLr5vW6Z3D8sji7y6pkAeDhSS/DSgJN/j8h/1XL6ZugEpQyGXfij
         dbCPu7d9HGL6Cy7ZWM9yDTaBRKjgNp1MBBEXlrCs/Kqh4dki0pw1VniLjqu5F71BadXl
         ZSn6PyOekPtjHXxMk7jzQgvW1Ae9WX0PtUx9vpW/VIFj3VMXaIRjVPrsM9uZbfNKpfKf
         KA/g==
X-Gm-Message-State: AOAM532O/G693hdUuh3eKKusfkN1utmB964b4euO8WQaPWToQpxz4QpU
        eauGgDh3koWu45PK8qxVHyTdTzFkCVxcnjv1OUHsaw==
X-Google-Smtp-Source: ABdhPJzZoWIKBvppscKREVbWcuzaxw1WipKDOxdzvZxLuHJRu3ua1R5naxHREJaxvKXNplNOKPTE/Il2eRRibOTPz3U=
X-Received: by 2002:a05:6512:1515:: with SMTP id bq21mr5598334lfb.71.1634643456337;
 Tue, 19 Oct 2021 04:37:36 -0700 (PDT)
MIME-Version: 1.0
References: <1634383581-11055-1-git-send-email-zheyuma97@gmail.com>
In-Reply-To: <1634383581-11055-1-git-send-email-zheyuma97@gmail.com>
From:   Ulf Hansson <ulf.hansson@linaro.org>
Date:   Tue, 19 Oct 2021 13:36:59 +0200
Message-ID: <CAPDyKFp4tt4xA-Fo_E7yWV2Mi4ES5ko=g1XgfaJwxhkSiaCEMg@mail.gmail.com>
Subject: Re: [PATCH] memstick: r592: Fix a UAF bug when removing the driver
To:     Zheyu Ma <zheyuma97@gmail.com>
Cc:     Maxim Levitsky <maximlevitsky@gmail.com>,
        Alex Dubov <oakad@yahoo.com>,
        linux-mmc <linux-mmc@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 16 Oct 2021 at 13:26, Zheyu Ma <zheyuma97@gmail.com> wrote:
>
> In r592_remove(), the driver will free dma after freeing the host, which
> may cause a UAF bug.
>
> The following log reveals it:
>
> [   45.361796 ] BUG: KASAN: use-after-free in r592_remove+0x269/0x350 [r592]
> [   45.364286 ] Call Trace:
> [   45.364472 ]  dump_stack_lvl+0xa8/0xd1
> [   45.364751 ]  print_address_description+0x87/0x3b0
> [   45.365137 ]  kasan_report+0x172/0x1c0
> [   45.365415 ]  ? r592_remove+0x269/0x350 [r592]
> [   45.365834 ]  ? r592_remove+0x269/0x350 [r592]
> [   45.366168 ]  __asan_report_load8_noabort+0x14/0x20
> [   45.366531 ]  r592_remove+0x269/0x350 [r592]
> [   45.378785 ]
> [   45.378903 ] Allocated by task 4674:
> [   45.379162 ]  ____kasan_kmalloc+0xb5/0xe0
> [   45.379455 ]  __kasan_kmalloc+0x9/0x10
> [   45.379730 ]  __kmalloc+0x150/0x280
> [   45.379984 ]  memstick_alloc_host+0x2a/0x190
> [   45.380664 ]
> [   45.380781 ] Freed by task 5509:
> [   45.381014 ]  kasan_set_track+0x3d/0x70
> [   45.381293 ]  kasan_set_free_info+0x23/0x40
> [   45.381635 ]  ____kasan_slab_free+0x10b/0x140
> [   45.381950 ]  __kasan_slab_free+0x11/0x20
> [   45.382241 ]  slab_free_freelist_hook+0x81/0x150
> [   45.382575 ]  kfree+0x13e/0x290
> [   45.382805 ]  memstick_free+0x1c/0x20
> [   45.383070 ]  device_release+0x9c/0x1d0
> [   45.383349 ]  kobject_put+0x2ef/0x4c0
> [   45.383616 ]  put_device+0x1f/0x30
> [   45.383865 ]  memstick_free_host+0x24/0x30
> [   45.384162 ]  r592_remove+0x242/0x350 [r592]
> [   45.384473 ]  pci_device_remove+0xa9/0x250
>
> Signed-off-by: Zheyu Ma <zheyuma97@gmail.com>

Applied for next, thanks!

Kind regards
Uffe


> ---
>  drivers/memstick/host/r592.c | 8 ++++----
>  1 file changed, 4 insertions(+), 4 deletions(-)
>
> diff --git a/drivers/memstick/host/r592.c b/drivers/memstick/host/r592.c
> index e79a0218c492..1d35d147552d 100644
> --- a/drivers/memstick/host/r592.c
> +++ b/drivers/memstick/host/r592.c
> @@ -838,15 +838,15 @@ static void r592_remove(struct pci_dev *pdev)
>         }
>         memstick_remove_host(dev->host);
>
> +       if (dev->dummy_dma_page)
> +               dma_free_coherent(&pdev->dev, PAGE_SIZE, dev->dummy_dma_page,
> +                       dev->dummy_dma_page_physical_address);
> +
>         free_irq(dev->irq, dev);
>         iounmap(dev->mmio);
>         pci_release_regions(pdev);
>         pci_disable_device(pdev);
>         memstick_free_host(dev->host);
> -
> -       if (dev->dummy_dma_page)
> -               dma_free_coherent(&pdev->dev, PAGE_SIZE, dev->dummy_dma_page,
> -                       dev->dummy_dma_page_physical_address);
>  }
>
>  #ifdef CONFIG_PM_SLEEP
> --
> 2.17.6
>
