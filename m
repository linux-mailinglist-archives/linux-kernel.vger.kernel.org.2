Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 19A8A3A5FB7
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Jun 2021 12:08:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232747AbhFNKK3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 14 Jun 2021 06:10:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54718 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232579AbhFNKK1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Jun 2021 06:10:27 -0400
Received: from mail-oo1-xc2f.google.com (mail-oo1-xc2f.google.com [IPv6:2607:f8b0:4864:20::c2f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D7A09C061574
        for <linux-kernel@vger.kernel.org>; Mon, 14 Jun 2021 03:08:23 -0700 (PDT)
Received: by mail-oo1-xc2f.google.com with SMTP id 67-20020a4a01460000b0290245b81f6261so2514292oor.6
        for <linux-kernel@vger.kernel.org>; Mon, 14 Jun 2021 03:08:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=2VU+I2JY7nagoQJLZQjBNcNIb1qYx8IdZde11I0FLps=;
        b=rNjbdGE1R6371RlbKuw0VPLhk0hVt+tVCRj+HwZIWyGIyJmhmjaOFD7SKz++9Kx4gX
         bikuCAeXdr5XAPh2pkrHHoQwlPN9xvxMdPaA6yopfD9r7KAoh7yqVpRELa+nqS5J4tC3
         QegydvRCFFQ3nrKsJEaU2V0YPw1gZyK6Tmiydu7JlsvaqicIg1Bod1OVmLcMmIlxhCbQ
         4s0rJ2G1wmaxFcM1kHGmd82ABBRgRm3JmCE0y+H06KHrL5budfoXvEmJ5baAODQr1o8U
         ColYeKSuvr0YztdKM/VPSsIObiebDsbu0cmjc8sxCk2n4mckaoh68/wyNibGa85Bk5IP
         VXdA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=2VU+I2JY7nagoQJLZQjBNcNIb1qYx8IdZde11I0FLps=;
        b=mOnLTkqLBveSxB4SEd1yW2xQv93PQ+GB1eZ+Uz/X9bC/6bx4NHhDObc7c7QzB3bM9B
         0Qseg9XBls1XE074cUvGLMK2Wv/JE12YjTSzxGrMN9OzVdf+w3IfYko09SB0YnbMGk6L
         7CsJ2jn32MGUT0Gzor/olFqutpDPW9TQaxfLPxoxxwsS9StgiMb6MRQ75pd6aSdkxF0J
         fu0sxqphajNuyGliWW4aCgp8uTghdBpO7sssAoXvRBaK2nBjjjypWQkc5OXNuda365MW
         V0P7Zlar8XHWx3cN0P3i70DDqUWH1koJAiZ82Fit6DtC+gaZX52HRvWndNn4UmK2N50w
         vs0A==
X-Gm-Message-State: AOAM531sL6Sqyu7uC5UNaTIBSNwycUUXRbvNdo+TsXIhddj/nhbWoxTw
        12evozZ1WC3iTJPdlssOyhfXYTE0mui8Z+09fk4=
X-Google-Smtp-Source: ABdhPJzT94HAfh7KH1qNLSmqXHnVlpNeuigsQEcfaynhB2GlcMTV+2U8AmlyonkjfOjKcDdy570egAaH81rScRC+Ydg=
X-Received: by 2002:a4a:e887:: with SMTP id g7mr12530141ooe.64.1623665303198;
 Mon, 14 Jun 2021 03:08:23 -0700 (PDT)
MIME-Version: 1.0
References: <20210611131056.3731084-1-aisheng.dong@nxp.com> <20210614083609.GA18701@willie-the-truck>
In-Reply-To: <20210614083609.GA18701@willie-the-truck>
From:   Dong Aisheng <dongas86@gmail.com>
Date:   Mon, 14 Jun 2021 18:07:04 +0800
Message-ID: <CAA+hA=S8x4S0sgAiJbqOC-wgtOshV_jhAq6eVqX5-EAeg3Dczg@mail.gmail.com>
Subject: Re: [PATCH 1/1] dma: coherent: check no-map property for arm64
To:     Will Deacon <will@kernel.org>
Cc:     Dong Aisheng <aisheng.dong@nxp.com>,
        iommu@lists.linux-foundation.org,
        open list <linux-kernel@vger.kernel.org>, linux-mm@kvack.org,
        "moderated list:ARM/FREESCALE IMX / MXC ARM ARCHITECTURE" 
        <linux-arm-kernel@lists.infradead.org>,
        Christoph Hellwig <hch@lst.de>,
        Marek Szyprowski <m.szyprowski@samsung.com>,
        Robin Murphy <robin.murphy@arm.com>,
        Catalin Marinas <catalin.marinas@arm.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Will,

On Mon, Jun 14, 2021 at 4:36 PM Will Deacon <will@kernel.org> wrote:
>
> [+Catalin]
>
> On Fri, Jun 11, 2021 at 09:10:56PM +0800, Dong Aisheng wrote:
> > Coherent dma on ARM64 also can't work with mapped system ram,
> > that means 'no-map' property must be specified in dts.
> > Add the missing check for ARM64 platforms as well.
> > Besides 'no-map' checking, 'linux,dma-default' feature is also
> > enabled for ARM64 along with this patch.
>
> Please can you explain _why_ it can't work? We don't need to tear down
> aliases from the linear map for the streaming DMA API, so why is this
> case different? Also, coherent devices wouldn't need this either way,
> would they? What problem are you solving here?
>

Not sure if i get your point correctly. Here is my understanding. (fix
me if wrong)
In current implementation, the coherent dma memory will be remapped as
writecombine and uncached type which can't reuse the linear mapping.
The prerequisite to do this is the memory must not be mapped System RAM.
e.g. reserved memory with no-map property and invisible to the buddy system.

This seems a little different from CMA which the memory is still
underlying managed
by the buddy system in order to support migration.

The patch here does not resolve a real issue but just open the sanity check for
ARM64 case as well as ARM  which reports the issue a little bit earlier at
rmem_dma_setup() time.

Regards
Aisheng

> Thanks,
>
> Will
>
> >
> > Cc: Christoph Hellwig <hch@lst.de>
> > Cc: Marek Szyprowski <m.szyprowski@samsung.com>
> > Cc: Robin Murphy <robin.murphy@arm.com>
> > Signed-off-by: Dong Aisheng <aisheng.dong@nxp.com>
> > ---
> >  kernel/dma/coherent.c | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> >
> > diff --git a/kernel/dma/coherent.c b/kernel/dma/coherent.c
> > index 5b5b6c7ec7f2..d1831da7afba 100644
> > --- a/kernel/dma/coherent.c
> > +++ b/kernel/dma/coherent.c
> > @@ -356,7 +356,7 @@ static int __init rmem_dma_setup(struct reserved_mem *rmem)
> >       if (of_get_flat_dt_prop(node, "reusable", NULL))
> >               return -EINVAL;
> >
> > -#ifdef CONFIG_ARM
> > +#if defined(CONFIG_ARM) || defined(CONFIG_ARM64)
> >       if (!of_get_flat_dt_prop(node, "no-map", NULL)) {
> >               pr_err("Reserved memory: regions without no-map are not yet supported\n");
> >               return -EINVAL;
> > --
> > 2.25.1
> >
