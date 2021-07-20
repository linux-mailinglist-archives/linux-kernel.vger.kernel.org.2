Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 456863CF2C8
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Jul 2021 05:41:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347334AbhGTC6X (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 19 Jul 2021 22:58:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36236 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1347096AbhGTCzx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Jul 2021 22:55:53 -0400
Received: from mail-io1-xd2c.google.com (mail-io1-xd2c.google.com [IPv6:2607:f8b0:4864:20::d2c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 43B77C061574
        for <linux-kernel@vger.kernel.org>; Mon, 19 Jul 2021 20:36:32 -0700 (PDT)
Received: by mail-io1-xd2c.google.com with SMTP id l5so22522926iok.7
        for <linux-kernel@vger.kernel.org>; Mon, 19 Jul 2021 20:36:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=jJGPzo2D/QmYN8C9EYVFi8OnTZ2+dp4VjkWxhHVMGZU=;
        b=YVfiS0+FAd6ubNrNKtyu4lmHksMwrO/9rRQ3BxuHPe6lei7o4+muBmTzOy7eeC1jes
         mZLq1jtxDpJ6d30HnvM4tjIjr98oAXOWjInYI6f39yZ1iMkAaUj3olaxe3nkzQyMPgnN
         B7OBXN8k4rYmTrwZrIpVDavtLTsEVWpJ4jYAM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=jJGPzo2D/QmYN8C9EYVFi8OnTZ2+dp4VjkWxhHVMGZU=;
        b=bL5XeQK0CPt+JJJ3zljMcD8dBKSLWKbs2WNR+/s69y+liR+5bwEWA4dxgGB0N0CIbn
         uNP+J8kTVLdH4xiROXplHS3bsD/TnR1Od5jMCZbeIpOMeD/toOJMGpHEOVXtltQ6mVtr
         837WNqzy7qu3NZ9UWBpOpK7YNuNrXrK0b7s8mipdRRR6jFCKUul1GZqIuyjxuH9uZo9i
         yLhqGArvWpgqjx8074T8ObPyyJIaGVaV6j5LGzDS4u3cw6Jxi9CrDbnrMhlZe4jN5TFl
         x1+Y2jVKowhbhcLrmlN2l8W46dRzYiE0qm5Dr9UslzUAdW4faH1+R5DubAuSfLvEH9qD
         3n2g==
X-Gm-Message-State: AOAM531XNhYzf/t0kWkeNC7Ofsm7UJWJZQI0FLNmq6LilFJMsxZEw4xS
        8aiVjGSskz1gAKEt81RRfYwUHhySlHtSKQ==
X-Google-Smtp-Source: ABdhPJz+upcLQtyD8YqHpVhJJ08gUk2Spv44YlN9+Lz6WfjiFlQgvPSIXjbKQfKdaT9Xz2nAWHS8/A==
X-Received: by 2002:a5e:8816:: with SMTP id l22mr16218380ioj.100.1626752191232;
        Mon, 19 Jul 2021 20:36:31 -0700 (PDT)
Received: from mail-il1-f170.google.com (mail-il1-f170.google.com. [209.85.166.170])
        by smtp.gmail.com with ESMTPSA id u13sm11263510iot.29.2021.07.19.20.36.30
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 19 Jul 2021 20:36:30 -0700 (PDT)
Received: by mail-il1-f170.google.com with SMTP id h3so17965382ilc.9
        for <linux-kernel@vger.kernel.org>; Mon, 19 Jul 2021 20:36:30 -0700 (PDT)
X-Received: by 2002:a92:d58f:: with SMTP id a15mr2544884iln.18.1626752190055;
 Mon, 19 Jul 2021 20:36:30 -0700 (PDT)
MIME-Version: 1.0
References: <20210719123054.6844-1-will@kernel.org> <20210719123054.6844-6-will@kernel.org>
In-Reply-To: <20210719123054.6844-6-will@kernel.org>
From:   Claire Chang <tientzu@chromium.org>
Date:   Tue, 20 Jul 2021 11:36:19 +0800
X-Gmail-Original-Message-ID: <CALiNf2_Ubi9cynH1Rjy-o87V3MyvdTazv5rO=sggNai0WJZ81g@mail.gmail.com>
Message-ID: <CALiNf2_Ubi9cynH1Rjy-o87V3MyvdTazv5rO=sggNai0WJZ81g@mail.gmail.com>
Subject: Re: [PATCH 5/5] swiotlb: Free tbl memory in swiotlb_exit()
To:     Will Deacon <will@kernel.org>
Cc:     "list@263.net:IOMMU DRIVERS <iommu@lists.linux-foundation.org>, Joerg
        Roedel <joro@8bytes.org>," <iommu@lists.linux-foundation.org>,
        lkml <linux-kernel@vger.kernel.org>,
        Guenter Roeck <linux@roeck-us.net>,
        Christoph Hellwig <hch@lst.de>,
        Robin Murphy <robin.murphy@arm.com>,
        Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>,
        Nathan Chancellor <nathan@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jul 19, 2021 at 8:31 PM Will Deacon <will@kernel.org> wrote:
>
> Although swiotlb_exit() frees the 'slots' metadata array referenced by
> 'io_tlb_default_mem', it leaves the underlying buffer pages allocated
> despite no longer being usable.
>
> Extend swiotlb_exit() to free the buffer pages as well as the slots
> array.
>
> Cc: Claire Chang <tientzu@chromium.org>
> Cc: Christoph Hellwig <hch@lst.de>
> Cc: Robin Murphy <robin.murphy@arm.com>
> Cc: Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>
> Tested-by: Nathan Chancellor <nathan@kernel.org>

Tested-by: Claire Chang <tientzu@chromium.org>

> Signed-off-by: Will Deacon <will@kernel.org>
> ---
>  kernel/dma/swiotlb.c | 21 +++++++++++++++------
>  1 file changed, 15 insertions(+), 6 deletions(-)
>
> diff --git a/kernel/dma/swiotlb.c b/kernel/dma/swiotlb.c
> index b3c793ed9e64..87c40517e822 100644
> --- a/kernel/dma/swiotlb.c
> +++ b/kernel/dma/swiotlb.c
> @@ -328,18 +328,27 @@ swiotlb_late_init_with_tbl(char *tlb, unsigned long nslabs)
>
>  void __init swiotlb_exit(void)
>  {
> -       size_t size;
>         struct io_tlb_mem *mem = &io_tlb_default_mem;
> +       unsigned long tbl_vaddr;
> +       size_t tbl_size, slots_size;
>
>         if (!mem->nslabs)
>                 return;
>
>         pr_info("tearing down default memory pool\n");
> -       size = array_size(sizeof(*mem->slots), mem->nslabs);
> -       if (mem->late_alloc)
> -               free_pages((unsigned long)mem->slots, get_order(size));
> -       else
> -               memblock_free_late(__pa(mem->slots), PAGE_ALIGN(size));
> +       tbl_vaddr = (unsigned long)phys_to_virt(mem->start);
> +       tbl_size = PAGE_ALIGN(mem->end - mem->start);
> +       slots_size = PAGE_ALIGN(array_size(sizeof(*mem->slots), mem->nslabs));
> +
> +       set_memory_encrypted(tbl_vaddr, tbl_size >> PAGE_SHIFT);
> +       if (mem->late_alloc) {
> +               free_pages(tbl_vaddr, get_order(tbl_size));
> +               free_pages((unsigned long)mem->slots, get_order(slots_size));
> +       } else {
> +               memblock_free_late(mem->start, tbl_size);
> +               memblock_free_late(__pa(mem->slots), slots_size);
> +       }
> +
>         memset(mem, 0, sizeof(*mem));
>  }
>
> --
> 2.32.0.402.g57bb445576-goog
>
