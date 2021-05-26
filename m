Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DC8A9392277
	for <lists+linux-kernel@lfdr.de>; Thu, 27 May 2021 00:02:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234329AbhEZWD4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 26 May 2021 18:03:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51604 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232221AbhEZWDu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 May 2021 18:03:50 -0400
Received: from mail-oi1-x22c.google.com (mail-oi1-x22c.google.com [IPv6:2607:f8b0:4864:20::22c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9023CC061574
        for <linux-kernel@vger.kernel.org>; Wed, 26 May 2021 15:02:17 -0700 (PDT)
Received: by mail-oi1-x22c.google.com with SMTP id y76so3061866oia.6
        for <linux-kernel@vger.kernel.org>; Wed, 26 May 2021 15:02:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:in-reply-to:references:from:user-agent:date:message-id
         :subject:to:cc;
        bh=+4HllXG54gfe8ZEeglIaINql3dVM8uhOiJune2YdDg8=;
        b=ebuWdiTfHr5eD4p7IYU/65gQt0cF3VGp6rAyR4yBOGoCFyTDqLM2tUbUT1TkrDXPKf
         Qc7L82VLVlMGXWFAt8sz3SNbvq3fVznQuriS3lnf9WxsZYQ/J6XMC7QbeYEcEkM+OId3
         BjsiFUTLl9vPPiVi2Lkkj/HadjMeSD07sanVc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from
         :user-agent:date:message-id:subject:to:cc;
        bh=+4HllXG54gfe8ZEeglIaINql3dVM8uhOiJune2YdDg8=;
        b=Yhz253amgnjX9fzxW96OV67Fa0UUNfh8c3oqABbQNXWJQ+1gdw1cMMjTzddGyKokEY
         hgGFWs2LaCPCjPw2u3i98iw38bVmJCaPHQCJrGduxGct++N4lo7sSqI6CSLXhce54mjb
         IlaTAjO0Y9eXoeo13r1ZrGif5+7R1CfgFlPoQn3i9gkGGnoKVMtSu3fZ3YVs5kCEV19k
         UeZ5VlvQgeETikbNi4shKaWtuYfSHfnGmtqMk5wrgc4Gn2ulWvx1x9fHHN2TPS6oqrTK
         oOFeYSS7awWlW0easXwqAlWFNCI7jkBH88oOuKvZeKWR1vch2m/8NFaSDY/dYVRfdiKB
         wfcg==
X-Gm-Message-State: AOAM531VGME8N+WnhPoG7iJioIllhkXGfhe6DrtaakHvgZBwY4Nq692w
        QamrzUxQHm0uhopuWoEGSrtX5whlzz0B/wvFo20QaQ==
X-Google-Smtp-Source: ABdhPJyHRHfa/vjrPgMKmf8sOPM3OqyfmvQhl89FBASFn0gMNY6AQc29rFGhS2QeJiHMNUq/2ErJSZ6cjPiBFiqHKMI=
X-Received: by 2002:a05:6808:144e:: with SMTP id x14mr3538168oiv.166.1622066536891;
 Wed, 26 May 2021 15:02:16 -0700 (PDT)
Received: from 753933720722 named unknown by gmailapi.google.com with
 HTTPREST; Wed, 26 May 2021 18:02:16 -0400
MIME-Version: 1.0
In-Reply-To: <CAD=FV=XfY3yNnH0ZJiRJQCcw8Rs=RGCntETXofK+5xRACVnDyQ@mail.gmail.com>
References: <20210520012731.3731314-1-swboyd@chromium.org> <CAD=FV=XfY3yNnH0ZJiRJQCcw8Rs=RGCntETXofK+5xRACVnDyQ@mail.gmail.com>
From:   Stephen Boyd <swboyd@chromium.org>
User-Agent: alot/0.9.1
Date:   Wed, 26 May 2021 18:02:16 -0400
Message-ID: <CAE-0n50Q17XHF1tp=pk-He0neLY87gerMn-cRvokSiwsBF0X4Q@mail.gmail.com>
Subject: Re: [PATCH] of/fdt: Don't worry about non-memory region overlap for no-map
To:     Doug Anderson <dianders@chromium.org>
Cc:     Rob Herring <robh@kernel.org>,
        Frank Rowand <frowand.list@gmail.com>,
        LKML <linux-kernel@vger.kernel.org>, devicetree@vger.kernel.org,
        Nicolas Boichat <drinkcat@chromium.org>,
        Quentin Perret <qperret@google.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Doug Anderson (2021-05-20 09:17:39)
> Hi,
>
> On Wed, May 19, 2021 at 6:27 PM Stephen Boyd <swboyd@chromium.org> wrote:
> >
> > In commit 8a5a75e5e9e5 ("of/fdt: Make sure no-map does not remove
> > already reserved regions") we returned -EBUSY when trying to mark
> > regions as no-map when they're in the reserved memory node. This if
> > condition will still trigger though if the DT has a /memreserve/ that
> > completely subsumes the no-map memory carveouts in the reserved memory
> > node. Let's only consider this to be a problem if we're trying to mark a
> > region as no-map and it is actually memory. If it isn't memory,
> > presumably it was removed from the memory map via /memreserve/ and thus
> > can't be mapped anyway.
> >
> > This silences a warning seen at boot for me on sc7180-trogdor.dtsi
> > boards that have /memreserve/ coming from the bootloader and those
> > reserved regions overlap with the carveouts that we want to use in DT
> > for other purposes like communicating with remote processors.
> >
> > Cc: Douglas Anderson <dianders@chromium.org>
> > Cc: Nicolas Boichat <drinkcat@chromium.org>
> > Cc: Quentin Perret <qperret@google.com>
> > Fixes: 8a5a75e5e9e5 ("of/fdt: Make sure no-map does not remove already reserved regions")
> > Signed-off-by: Stephen Boyd <swboyd@chromium.org>
> > ---
> >  drivers/of/fdt.c | 3 ++-
> >  1 file changed, 2 insertions(+), 1 deletion(-)
> >
> > diff --git a/drivers/of/fdt.c b/drivers/of/fdt.c
> > index ba17a80b8c79..be13b4b6c2d8 100644
> > --- a/drivers/of/fdt.c
> > +++ b/drivers/of/fdt.c
> > @@ -1161,7 +1161,8 @@ int __init __weak early_init_dt_reserve_memory_arch(phys_addr_t base,
> >                  * If the memory is already reserved (by another region), we
> >                  * should not allow it to be marked nomap.
> >                  */
> > -               if (memblock_is_region_reserved(base, size))
> > +               if (memblock_is_region_memory(base, size) &&
> > +                   memblock_is_region_reserved(base, size))
> >                         return -EBUSY;
>
> I'm not an expert on this code, so take review comments w/ a grain of salt.
>
> That being said, while the change looks right on the surface, I'm not
> sure it's 100% right when I dig. The names of
> memblock_is_region_memory() and memblock_is_region_reserved() make
> them sound more similar than they actually are. One of the two tests
> for intersection and the other for "subset of". I think if
> memblock_is_region_memory() used "intersects" instead of "subset of"
> then your patch would be correct.
>
> Specifically if you've got memory regions:
>
> 0x1000 - 0x2000 - memory
> 0x3000 - 0x4000 - memory
>
> Then you check memblock_is_region_memory(0x2800, 0x1000) or
> memblock_is_region_memory(0x1800, 0x1000) then I think it will return
> false, right? Because those aren't _subsets_ of memory even though
> they intersect memory.
>
> I don't know if cases like that show up in practice, but it seems
> better to be safe?
>

Good point. If the reserved region intersects with memory and "not
memory" then the check won't be attempted to see if the region
intersects with a reserved region. I was trying to match the spirit of
the commit that this is fixing, i.e. trying to only care if the region
is for kernel memory. At least my read of that commit text led me to
believe that it was trying to print a warning if we have a big kernel
image reservation that overlaps with the reserved memory regions in DT.
Before that patch it would silently allow a no-map region to overlap
with the kernel image (text/data/heap/bss) and then unmap the kernel,
ouch! Now it will return -EBUSY and not let the kernel unmap itself.

In my case I have a /memreserve/ region from DT that marks a large
region as reserved, and then I have a few reserved memory nodes in DT
that are marked no-map and they fit entirely inside the /memreserve/
region so they're a "subset of". Let me see if I can devise some way to
fix both scenarios. My understanding is /memreserve/ is essentially the
same as no-map in that the kernel doesn't consider the region as memory
and doesn't map it in the kernel page tables, so this silences a warning
for me but functionally doesn't change anything.
