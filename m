Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9111C38B41E
	for <lists+linux-kernel@lfdr.de>; Thu, 20 May 2021 18:17:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233825AbhETQTR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 20 May 2021 12:19:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52378 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233319AbhETQTQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 May 2021 12:19:16 -0400
Received: from mail-qk1-x735.google.com (mail-qk1-x735.google.com [IPv6:2607:f8b0:4864:20::735])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0FF8FC06175F
        for <linux-kernel@vger.kernel.org>; Thu, 20 May 2021 09:17:54 -0700 (PDT)
Received: by mail-qk1-x735.google.com with SMTP id o27so16711463qkj.9
        for <linux-kernel@vger.kernel.org>; Thu, 20 May 2021 09:17:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=X2K2UsQIFakSL3CdJKO88oHVvUmlIFCUmew7iYpt6xQ=;
        b=Tt16I/P3Oiie+y5ejV3kiyQ94NjZVIk6Q8QErYbjLyk8Os0LLdxq9WS2y7ANrRWOuj
         sox+ztKic5ZFWHIdB6MB3b4hSGB1Drkmx5X35/qgtfhTeWGuvZw2/jX+qIDHrsf6Ud/G
         sSUo+/LU3Kxd0o+06jjUpfLHKwWrz65aAQjcU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=X2K2UsQIFakSL3CdJKO88oHVvUmlIFCUmew7iYpt6xQ=;
        b=h+7uQbOpQeh37uJyk/dkvgEHLMwgsfsI8G0WCXGP6Zni/UF4whLC7aOvHbTVTXbTQF
         DGyLRQgF/p+TiVRcJOrzmDthzE5ajiiIDcyHYijguNVEqfbJcPcEJJ45wa4QwcyzhLbc
         MXJWh95OPPP1Eak3rJ7qsjAW3Qaf+iruqetWg9GFcnfIC5U0y8nLxuPW7JFIJHvoPKzb
         Cq51S9kLByfSR3n2TmJkr6EmhP+TPNw6CfYhk9LB3frDwn9ZWijMAr1nTaZHOtxByhaE
         kwDHtxUQIOJpqpidDPg34cnVDm2PhMmZxMTs7bZW2JxAVQYP8YPgITljLYoXfCBh8RDO
         TnUw==
X-Gm-Message-State: AOAM532AJNC1K2lrGJLpdysEsIEDTn66NFBihpcWMU5ry4Q+TyA7b43l
        LzZwk9L6ThUwPujodhloTO+8IF3a8ET8SA==
X-Google-Smtp-Source: ABdhPJxF9lfe3GtZieZODWj2nCjG+lSPridOb2iGKyb2fx3sbIFVvy0vXNMILu2NbncNdp5mlsH5fA==
X-Received: by 2002:a37:65d2:: with SMTP id z201mr6095772qkb.219.1621527472838;
        Thu, 20 May 2021 09:17:52 -0700 (PDT)
Received: from mail-yb1-f172.google.com (mail-yb1-f172.google.com. [209.85.219.172])
        by smtp.gmail.com with ESMTPSA id g5sm2132177qtv.56.2021.05.20.09.17.51
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 20 May 2021 09:17:52 -0700 (PDT)
Received: by mail-yb1-f172.google.com with SMTP id n4so5117109ybf.5
        for <linux-kernel@vger.kernel.org>; Thu, 20 May 2021 09:17:51 -0700 (PDT)
X-Received: by 2002:a25:80d4:: with SMTP id c20mr8811535ybm.345.1621527471502;
 Thu, 20 May 2021 09:17:51 -0700 (PDT)
MIME-Version: 1.0
References: <20210520012731.3731314-1-swboyd@chromium.org>
In-Reply-To: <20210520012731.3731314-1-swboyd@chromium.org>
From:   Doug Anderson <dianders@chromium.org>
Date:   Thu, 20 May 2021 09:17:39 -0700
X-Gmail-Original-Message-ID: <CAD=FV=XfY3yNnH0ZJiRJQCcw8Rs=RGCntETXofK+5xRACVnDyQ@mail.gmail.com>
Message-ID: <CAD=FV=XfY3yNnH0ZJiRJQCcw8Rs=RGCntETXofK+5xRACVnDyQ@mail.gmail.com>
Subject: Re: [PATCH] of/fdt: Don't worry about non-memory region overlap for no-map
To:     Stephen Boyd <swboyd@chromium.org>
Cc:     Rob Herring <robh@kernel.org>,
        Frank Rowand <frowand.list@gmail.com>,
        LKML <linux-kernel@vger.kernel.org>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>,
        Nicolas Boichat <drinkcat@chromium.org>,
        Quentin Perret <qperret@google.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Wed, May 19, 2021 at 6:27 PM Stephen Boyd <swboyd@chromium.org> wrote:
>
> In commit 8a5a75e5e9e5 ("of/fdt: Make sure no-map does not remove
> already reserved regions") we returned -EBUSY when trying to mark
> regions as no-map when they're in the reserved memory node. This if
> condition will still trigger though if the DT has a /memreserve/ that
> completely subsumes the no-map memory carveouts in the reserved memory
> node. Let's only consider this to be a problem if we're trying to mark a
> region as no-map and it is actually memory. If it isn't memory,
> presumably it was removed from the memory map via /memreserve/ and thus
> can't be mapped anyway.
>
> This silences a warning seen at boot for me on sc7180-trogdor.dtsi
> boards that have /memreserve/ coming from the bootloader and those
> reserved regions overlap with the carveouts that we want to use in DT
> for other purposes like communicating with remote processors.
>
> Cc: Douglas Anderson <dianders@chromium.org>
> Cc: Nicolas Boichat <drinkcat@chromium.org>
> Cc: Quentin Perret <qperret@google.com>
> Fixes: 8a5a75e5e9e5 ("of/fdt: Make sure no-map does not remove already reserved regions")
> Signed-off-by: Stephen Boyd <swboyd@chromium.org>
> ---
>  drivers/of/fdt.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/of/fdt.c b/drivers/of/fdt.c
> index ba17a80b8c79..be13b4b6c2d8 100644
> --- a/drivers/of/fdt.c
> +++ b/drivers/of/fdt.c
> @@ -1161,7 +1161,8 @@ int __init __weak early_init_dt_reserve_memory_arch(phys_addr_t base,
>                  * If the memory is already reserved (by another region), we
>                  * should not allow it to be marked nomap.
>                  */
> -               if (memblock_is_region_reserved(base, size))
> +               if (memblock_is_region_memory(base, size) &&
> +                   memblock_is_region_reserved(base, size))
>                         return -EBUSY;

I'm not an expert on this code, so take review comments w/ a grain of salt.

That being said, while the change looks right on the surface, I'm not
sure it's 100% right when I dig. The names of
memblock_is_region_memory() and memblock_is_region_reserved() make
them sound more similar than they actually are. One of the two tests
for intersection and the other for "subset of". I think if
memblock_is_region_memory() used "intersects" instead of "subset of"
then your patch would be correct.

Specifically if you've got memory regions:

0x1000 - 0x2000 - memory
0x3000 - 0x4000 - memory

Then you check memblock_is_region_memory(0x2800, 0x1000) or
memblock_is_region_memory(0x1800, 0x1000) then I think it will return
false, right? Because those aren't _subsets_ of memory even though
they intersect memory.

I don't know if cases like that show up in practice, but it seems
better to be safe?

-Doug
