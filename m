Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D64FB3885CC
	for <lists+linux-kernel@lfdr.de>; Wed, 19 May 2021 05:56:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1353260AbhESD5V (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 18 May 2021 23:57:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38738 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235703AbhESD5U (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 May 2021 23:57:20 -0400
Received: from mail-ot1-x332.google.com (mail-ot1-x332.google.com [IPv6:2607:f8b0:4864:20::332])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 749B9C06175F
        for <linux-kernel@vger.kernel.org>; Tue, 18 May 2021 20:56:00 -0700 (PDT)
Received: by mail-ot1-x332.google.com with SMTP id d3-20020a9d29030000b029027e8019067fso10559810otb.13
        for <linux-kernel@vger.kernel.org>; Tue, 18 May 2021 20:56:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=HhI/6V9NfoJZk78Xj3HSIgGBenrGacrIrQhkazt2/Pg=;
        b=BDabwLgl6MZS4U8XrrFfu4+rhJeSJnpXyXKVfXeCBYYzg6RwPFuTQUgwemNDEpr1u5
         0MOMW4AxeFPbDMVv7pPJL90+WLZm0edmQl2boNfWalW9tn1lcBGFQxOGwJfRHSo2XFW5
         BrWESt0MqZgnRAE9FJShc8MbG9Qt8GnzeAaUQFGE7Qs+19jLWg2Wp9EC4VFfeE7ezmdG
         GV/fR0iVhT8T7+hT8+6DvdP7JkKyWmfHRQR50XuE0RHlnvbR0/s6fxeF5IXXGlfPN4vc
         fAr0KmaSIZCfhtexblbMFReAvS1w7z2uv5rwGnkHMZ7Kp25fYRuJvIZrsUaitszkaL8I
         wmZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=HhI/6V9NfoJZk78Xj3HSIgGBenrGacrIrQhkazt2/Pg=;
        b=BUaChGMmT2MUJdjbn7T9k4LExaOWGx6yKucRChEOHFDZP8pdKu0k+j/F1Ysjm4lJYw
         mG37umd0UWaP7q1xJaXTAqd1R7kH5P5SRBfNg160KvelSIk+QqgB3Zp7uzCj2owqboJ6
         zMjPbasXjrBMtQWZDzy7icf1f5Q4IqD3+24iOuqWumIgtexCwdpwZ0St3dNYx0e8+oqc
         azBpLUojL105bFHgkCiluenjY38FSXYQ9+sE9yRWS5qbB37EMqnpQIMR3NCqPk1pXmWM
         WV/JxvV0Ty3eiqTU8btSS/1th7JoXx7zOGL/0qVDKvM9bIwt78K2sWTtsCDnhoVQOVZR
         fpQQ==
X-Gm-Message-State: AOAM530jWisMDR8jFsCS0qPtGB2Qo7qGWmzeZkhsrbKrEWa84HCnO23s
        2l/m3e5ETx/lTsAwndYnbOBPUQ2F6lbMX0plgIJt0g+O
X-Google-Smtp-Source: ABdhPJynQ7/RGStOwc2agXrmWgyvoU6JpN55uvWTWxM567AKkz/5AStqjojczNtSZroC42xTdrkDxgQwaLArKPkNTco=
X-Received: by 2002:a9d:4115:: with SMTP id o21mr7143864ote.52.1621396559845;
 Tue, 18 May 2021 20:55:59 -0700 (PDT)
MIME-Version: 1.0
References: <20210518112857.1198415-1-aisheng.dong@nxp.com> <fe37a3d0-1360-77e8-f594-c9f32cc39cf2@arm.com>
In-Reply-To: <fe37a3d0-1360-77e8-f594-c9f32cc39cf2@arm.com>
From:   Dong Aisheng <dongas86@gmail.com>
Date:   Wed, 19 May 2021 11:54:56 +0800
Message-ID: <CAA+hA=RnEh8QG1vHSFBwMF2pwxv-J14m3za3yaqcNgqb=+xezA@mail.gmail.com>
Subject: Re: [PATCH 1/1] dma-contiguous: return early for dt case in dma_contiguous_reserve
To:     Robin Murphy <robin.murphy@arm.com>
Cc:     Dong Aisheng <aisheng.dong@nxp.com>,
        iommu@lists.linux-foundation.org,
        open list <linux-kernel@vger.kernel.org>,
        Christoph Hellwig <hch@lst.de>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, May 19, 2021 at 2:51 AM Robin Murphy <robin.murphy@arm.com> wrote:
>
> On 2021-05-18 12:28, Dong Aisheng wrote:
> > dma_contiguous_reserve() aims to support cmdline case for CMA memory
> > reserve. But if users define reserved memory in DT,
> > 'dma_contiguous_default_area' will not be 0, then it's meaningless
> > to continue to run dma_contiguous_reserve(). So we return early
> > if detect 'dma_contiguous_default_area' is unzero.
>
> But dma_contiguous_default_area *shouldn't* be set if the command-line
> argument is present - see the "if (size_cmdline != -1 && default_cma)"
> part of rmem_cma_setup(). Are you seeing something different in practice?
>

yes, you're right.

> > Cc: Christoph Hellwig <hch@lst.de>
> > Cc: Marek Szyprowski <m.szyprowski@samsung.com>
> > Cc: Robin Murphy <robin.murphy@arm.com>
> > Signed-off-by: Dong Aisheng <aisheng.dong@nxp.com>
> > ---
> >   kernel/dma/contiguous.c | 5 ++++-
> >   1 file changed, 4 insertions(+), 1 deletion(-)
> >
> > diff --git a/kernel/dma/contiguous.c b/kernel/dma/contiguous.c
> > index 3d63d91cba5c..ebade9f43eff 100644
> > --- a/kernel/dma/contiguous.c
> > +++ b/kernel/dma/contiguous.c
> > @@ -171,6 +171,9 @@ void __init dma_contiguous_reserve(phys_addr_t limit)
> >       phys_addr_t selected_limit = limit;
> >       bool fixed = false;
> >
> > +     if (dma_contiguous_default_area)
> > +             return;
> > +
> >       pr_debug("%s(limit %08lx)\n", __func__, (unsigned long)limit);
> >
> >       if (size_cmdline != -1) {
> > @@ -191,7 +194,7 @@ void __init dma_contiguous_reserve(phys_addr_t limit)
> >   #endif
> >       }
> >
> > -     if (selected_size && !dma_contiguous_default_area) {
> > +     if (selected_size) {
>
> Either way, does skipping a handful of trivial calculations and a
> debugging message really matter even when it is redundant? I can't
> imagine it has any measurable effect on boot times...
>

I think it's not about performance.
It aims to improve the code readability as it's meaningless to continue to
execute cmdline CMA reserve logic once DT is used successfully which is
a bit confusing when people first read this part of code.
Does it make sense to you?

Regards
Aisheng

> Robin.
>
> >               pr_debug("%s: reserving %ld MiB for global area\n", __func__,
> >                        (unsigned long)selected_size / SZ_1M);
> >
> >
