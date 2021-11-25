Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B82D745D59C
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Nov 2021 08:38:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236817AbhKYHlS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 25 Nov 2021 02:41:18 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52768 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236816AbhKYHjJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Nov 2021 02:39:09 -0500
Received: from mail-qv1-xf31.google.com (mail-qv1-xf31.google.com [IPv6:2607:f8b0:4864:20::f31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 729A4C06175C
        for <linux-kernel@vger.kernel.org>; Wed, 24 Nov 2021 23:35:58 -0800 (PST)
Received: by mail-qv1-xf31.google.com with SMTP id a24so3823571qvb.5
        for <linux-kernel@vger.kernel.org>; Wed, 24 Nov 2021 23:35:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=KNC33UOfOEobGSH4D2BAGe1O2xKscv36EvgOg4IHB58=;
        b=Rpw/69UAWSNd8StTv2nscHlaIMcTUiobMTp+ftwkGCsaQtyLxOr7gGSWKoYZgshUWk
         ewf72wr6GPbS5wtHpXlTgrhNhl+T97U/m5QPSD6tac5ZJR/aUUYbszs5FGZgW4ncfiBa
         +MrtrH9UwcSQcT3C6GtR9iK8GlmmoOJ45yoDg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=KNC33UOfOEobGSH4D2BAGe1O2xKscv36EvgOg4IHB58=;
        b=rVBiBArxqz78gL0LneT1lT6YDK/X0Gqxu8lP4gr/ypM/3tMsucw3l87IJTW5lmYML2
         ynR/ECrdekPB5cYfJcEDWrBv9xus4yBYSaLz6HpDbhcrbRD1nzpX2YHmSQWFSY6cCLp4
         4zIrlZ3J2qKv7oRN7isAlEewD7GZUcFGRycnm3KH6tDWARyhbA7elEBePhbAWQivr7uT
         SRlLsqmKOUV7qkLBcI6c6IP8h2Bt4WzMkmB/GZEOwe1tKzeOYgEbJdtezPLOCE/OZXb6
         FVe5J2zfvPhwnc758Eo9Xeljn+ZGJ5nYWzsEIMuR214w54aR66gotXfRy8CMslZGN5+Z
         4nOA==
X-Gm-Message-State: AOAM531HAF6QGZ+FyALesqiJEcBRSeyAovNMxyWw3j59Z5otnlzZmIAH
        IRVE2Wq/CX4r0feBQTxNAud++b6nIueY+g==
X-Google-Smtp-Source: ABdhPJyb+EQhtRngBwv2zSt3hsc/Z7ZNobpxY9hg/hggWnq/iRbE0pUGmRBIJpcac5JWpUV5Ejyp0g==
X-Received: by 2002:a05:6214:400e:: with SMTP id kd14mr3016671qvb.72.1637825757282;
        Wed, 24 Nov 2021 23:35:57 -0800 (PST)
Received: from mail-qk1-f169.google.com (mail-qk1-f169.google.com. [209.85.222.169])
        by smtp.gmail.com with ESMTPSA id m20sm1077233qkp.112.2021.11.24.23.35.56
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 24 Nov 2021 23:35:56 -0800 (PST)
Received: by mail-qk1-f169.google.com with SMTP id 132so9831312qkj.11
        for <linux-kernel@vger.kernel.org>; Wed, 24 Nov 2021 23:35:56 -0800 (PST)
X-Received: by 2002:a25:ccd0:: with SMTP id l199mr4122013ybf.39.1637825755668;
 Wed, 24 Nov 2021 23:35:55 -0800 (PST)
MIME-Version: 1.0
References: <20211123112104.3530135-1-hsinyi@chromium.org> <75ea1026-63e5-165a-9e07-27b5ac4c7579@arm.com>
In-Reply-To: <75ea1026-63e5-165a-9e07-27b5ac4c7579@arm.com>
From:   Tomasz Figa <tfiga@chromium.org>
Date:   Thu, 25 Nov 2021 16:35:43 +0900
X-Gmail-Original-Message-ID: <CAAFQd5AA3XCqxOSdQOOCMEdByDKRz5J9vWB0QghO2SSCqOvQBQ@mail.gmail.com>
Message-ID: <CAAFQd5AA3XCqxOSdQOOCMEdByDKRz5J9vWB0QghO2SSCqOvQBQ@mail.gmail.com>
Subject: Re: [PATCH 0/3] Allow restricted-dma-pool to customize IO_TLB_SEGSIZE
To:     Robin Murphy <robin.murphy@arm.com>
Cc:     Hsin-Yi Wang <hsinyi@chromium.org>,
        Christoph Hellwig <hch@infradead.org>,
        Marek Szyprowski <m.szyprowski@samsung.com>,
        iommu@lists.linux-foundation.org, linux-kernel@vger.kernel.org,
        Rob Herring <robh+dt@kernel.org>,
        Maxime Ripard <maxime@cerno.tech>,
        - <devicetree-spec@vger.kernel.org>, devicetree@vger.kernel.org,
        Matthias Brugger <matthias.bgg@gmail.com>,
        linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, senozhatsky@chromium.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Robin,

On Tue, Nov 23, 2021 at 8:59 PM Robin Murphy <robin.murphy@arm.com> wrote:
>
> On 2021-11-23 11:21, Hsin-Yi Wang wrote:
> > Default IO_TLB_SEGSIZE (128) slabs may be not enough for some use cases.
> > This series adds support to customize io_tlb_segsize for each
> > restricted-dma-pool.
> >
> > Example use case:
> >
> > mtk-isp drivers[1] are controlled by mtk-scp[2] and allocate memory through
> > mtk-scp. In order to use the noncontiguous DMA API[3], we need to use
> > the swiotlb pool. mtk-scp needs to allocate memory with 2560 slabs.
> > mtk-isp drivers also needs to allocate memory with 200+ slabs. Both are
> > larger than the default IO_TLB_SEGSIZE (128) slabs.
>
> Are drivers really doing streaming DMA mappings that large? If so, that
> seems like it might be worth trying to address in its own right for the
> sake of efficiency - allocating ~5MB of memory twice and copying it back
> and forth doesn't sound like the ideal thing to do.
>
> If it's really about coherent DMA buffer allocation, I thought the plan
> was that devices which expect to use a significant amount and/or size of
> coherent buffers would continue to use a shared-dma-pool for that? It's
> still what the binding implies. My understanding was that
> swiotlb_alloc() is mostly just a fallback for the sake of drivers which
> mostly do streaming DMA but may allocate a handful of pages worth of
> coherent buffers here and there. Certainly looking at the mtk_scp
> driver, that seems like it shouldn't be going anywhere near SWIOTLB at all.

First, thanks a lot for taking a look at this patch series.

The drivers would do streaming DMA within a reserved region that is
the only memory accessible to them for security reasons. This seems to
exactly match the definition of the restricted pool as merged
recently.

The new dma_alloc_noncontiguous() API would allow allocating suitable
memory directly from the pool, which would eliminate the need to copy.
However, for a restricted pool, this would exercise the SWIOTLB
allocator, which currently suffers from the limitation as described by
Hsin-Yi. Since the allocator in general is quite general purpose and
already used for coherent allocations as per the current restricted
pool implementation, I think it indeed makes sense to lift the
limitation, rather than trying to come up with yet another thing.

Best regards,
Tomasz

>
> Robin.
>
> > [1] (not in upstream) https://patchwork.kernel.org/project/linux-media/cover/20190611035344.29814-1-jungo.lin@mediatek.com/
> > [2] https://elixir.bootlin.com/linux/latest/source/drivers/remoteproc/mtk_scp.c
> > [3] https://patchwork.kernel.org/project/linux-media/cover/20210909112430.61243-1-senozhatsky@chromium.org/
> >
> > Hsin-Yi Wang (3):
> >    dma: swiotlb: Allow restricted-dma-pool to customize IO_TLB_SEGSIZE
> >    dt-bindings: Add io-tlb-segsize property for restricted-dma-pool
> >    arm64: dts: mt8183: use restricted swiotlb for scp mem
> >
> >   .../reserved-memory/shared-dma-pool.yaml      |  8 +++++
> >   .../arm64/boot/dts/mediatek/mt8183-kukui.dtsi |  4 +--
> >   include/linux/swiotlb.h                       |  1 +
> >   kernel/dma/swiotlb.c                          | 34 ++++++++++++++-----
> >   4 files changed, 37 insertions(+), 10 deletions(-)
> >
