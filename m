Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DACF6358F6A
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Apr 2021 23:45:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232605AbhDHVpt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 8 Apr 2021 17:45:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35068 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231862AbhDHVps (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Apr 2021 17:45:48 -0400
Received: from mail-lf1-x130.google.com (mail-lf1-x130.google.com [IPv6:2a00:1450:4864:20::130])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 11DFEC061760
        for <linux-kernel@vger.kernel.org>; Thu,  8 Apr 2021 14:45:36 -0700 (PDT)
Received: by mail-lf1-x130.google.com with SMTP id h19so6401393lfu.9
        for <linux-kernel@vger.kernel.org>; Thu, 08 Apr 2021 14:45:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=8MVBTVTbGflc/UsLhIwl2nRzF2EsRH8eZ0QlPXqs5ps=;
        b=Zk2v3nSMdaCm5adH4aHswvLKgEBKklbkCPH2zPgIVKp64w70n2axR/qGDplIQ0OZ0n
         HLegwMCSSCAxIt8LPsDPeA7J+lV2LnPtLiSNhLWjp/m3yDKXUPRvs0hxnHugTRrpsB6U
         uiiThswQsEAPRovlktmLYn49OPrRupsH66VDSzbKlxFr/Wn44w766AsgYLN7vrCHZLyR
         Uur3yAtqGAhF8O/MxSPYa1P5Yxp+6YntEF7We62ytpY0VEX1MNQUtmH/O+iMLbWa2H+y
         yeUIQCjgCMD2v6FVfHm061JaiZ7pmmjnI2REqJ3G0vMQF8z8vVWj0AbKZlNKPI0hg/VG
         eF2A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=8MVBTVTbGflc/UsLhIwl2nRzF2EsRH8eZ0QlPXqs5ps=;
        b=GfEK+sjUSyItn6kv2kSKn+NCh24fWg2cNo0JtSsyzk52WL9O4YvZ95YMyxjm6hwMpc
         GBw5AmIT+pB5SOCi/sy7wpJrG6jsVZ0YWKeA/IDxy87397hOboySVqbfSWMCZ+TLqVwE
         ZBcygH25kP4ipLGaYChJsFIsTfdTbrcS1t1sd/HXfQnB4g8tU/YMDCo/OrVegmHu9OzW
         foMrUAreVJRAkql4Rzo2eL/bv/J3WMrZfnS6NFCQyB01D/obbSECYAwhUz2N9l3OEFTm
         HTi4pana6/DDAZfqMidFvlgOLinjC8wyJF1v3hMdGqSYs1i7TupPaQTu7kUFgM/naQ9c
         2Row==
X-Gm-Message-State: AOAM533TODQU4oiyajgrsuUmWzLkKojOriB66X73Lycm5tvwephA0vqX
        Gn6UNLoutwG2Acxlsk+KSA2svvfMllD1tii8evLcF8mDdsjcUA==
X-Google-Smtp-Source: ABdhPJwOR1qaBP0hkaYoeDA9UZM861Q2LgMU2bP4wenXDG9wfbiuruw1rThn3wnUQVO3cDtDB82sQHZzPUH6KOtdfMo=
X-Received: by 2002:a19:ef18:: with SMTP id n24mr8062945lfh.291.1617918334556;
 Thu, 08 Apr 2021 14:45:34 -0700 (PDT)
MIME-Version: 1.0
References: <20210408092011.52763-1-david@redhat.com> <20210408092011.52763-3-david@redhat.com>
 <CAK8P3a09LdJ-87ZrN28y=t8Sa0zL-3NOvEWhkStMY+2EbO7UAw@mail.gmail.com>
 <cd14d4b4-da82-b21c-2cd6-8e474d97b955@redhat.com> <CAK8P3a0Wg1mGZoBkD_RwMx-jzQNK2krrDxDQV5uhCHoyz-e=dw@mail.gmail.com>
 <7496ac87-9676-1b4e-3444-c2a662ec376b@redhat.com> <CAK8P3a1tVwkDbtvKi8atkrg1-CfoQHGrXLCzn_uo+=dfZJfdQA@mail.gmail.com>
 <3a2d64a7-8425-8daf-17ee-95b9f0c635f9@redhat.com> <CACRpkdYizKGhtYzE+22oZAduLNCOGP9Vbp=LQbXG1C-a+MyMcg@mail.gmail.com>
 <2ef3b65c-c0ef-7bbe-0e05-39ee8f2bae48@redhat.com>
In-Reply-To: <2ef3b65c-c0ef-7bbe-0e05-39ee8f2bae48@redhat.com>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Thu, 8 Apr 2021 23:45:23 +0200
Message-ID: <CACRpkdbMLBzG_Q=-XzjsWvpofHyRv7sdB697mHLaRu4F=+GC-g@mail.gmail.com>
Subject: Re: [PATCH v1 2/2] drivers/gpu/drm: don't select DMA_CMA or CMA from
 aspeed or etnaviv
To:     David Hildenbrand <david@redhat.com>
Cc:     Arnd Bergmann <arnd@arndb.de>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux-MM <linux-mm@kvack.org>, Joel Stanley <joel@jms.id.au>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        Andrew Jeffery <andrew@aj.id.au>,
        Lucas Stach <l.stach@pengutronix.de>,
        Russell King <linux+etnaviv@armlinux.org.uk>,
        Christian Gmeiner <christian.gmeiner@gmail.com>,
        Mike Rapoport <rppt@kernel.org>,
        Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>,
        Michal Simek <michal.simek@xilinx.com>,
        Masahiro Yamada <masahiroy@kernel.org>,
        Randy Dunlap <rdunlap@infradead.org>,
        Peter Collingbourne <pcc@google.com>,
        linux-aspeed <linux-aspeed@lists.ozlabs.org>,
        dri-devel <dri-devel@lists.freedesktop.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        The etnaviv authors <etnaviv@lists.freedesktop.org>,
        Linux Fbdev development list <linux-fbdev@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Apr 8, 2021 at 6:44 PM David Hildenbrand <david@redhat.com> wrote:

> > drivers/gpu/drm/mcde/Kconfig
> > drivers/gpu/drm/pl111/Kconfig
> > drivers/gpu/drm/tve200/Kconfig
>
> I was assuming these are "real" dependencies. Will it also work without
> DMA_CMA?

It will mostly work but that is only because the reservations are
mostly contiguous anyway because they are done early and
are small. The hardware requires contiguous buffers in all
three cases. I'm not sure I always got it right.

> > certainly needs this as well, and pretty much anything that is
> > selecting DRM_KMS_CMA_HELPER or
> > DRM_GEM_CMA_HELPER "wants" DMA_CMA.
>
> "wants" as in "desires to use but can life without" or "wants" as in
> "really needs it". ?

I don't know the exact semantics of using DRM_KMS_CMA*
without actually using DMA_CMA. I suspect small allocations
will be contiguous and big allocations will start to fragment?
but it's just my guess. I guess "really need it"?

Yours,
Linus Walleij
