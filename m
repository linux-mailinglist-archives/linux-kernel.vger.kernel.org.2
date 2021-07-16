Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 024133CB323
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Jul 2021 09:15:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236198AbhGPHSc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 16 Jul 2021 03:18:32 -0400
Received: from mail-vs1-f48.google.com ([209.85.217.48]:35801 "EHLO
        mail-vs1-f48.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235441AbhGPHSa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 16 Jul 2021 03:18:30 -0400
Received: by mail-vs1-f48.google.com with SMTP id r25so4518492vsk.2
        for <linux-kernel@vger.kernel.org>; Fri, 16 Jul 2021 00:15:36 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=tLGLcXHLbLcKs7Bv/yUdoVLSx2l4hTbshPA3ruuQMsI=;
        b=RkFZO/QzIXD+eHDYU67hXMPu4N/WATH6C5SV0tuhZBh54sakav01oJ2Hz44FKUpEHC
         G60eySEwoRB/S9TWx9vBEuVFnlwP2lqovMoI2EVTrbj2wrxRqOrPZjLBShiEsiqAnrrI
         lD4ivIe2cDjlAa1e0fXxp3SvTHPpnWOZicCeoDiwj2tOW/rO7E6/e5vkcCuxZDG65zp8
         AP/tHu4QtO18orzauonmxiZ7mU4EoH+s2UOV3pC2aAo2qa6BeCyj3ImsJV9q3GUzmB8w
         hK2vLK57SvFZDY0qhbvOhkVakoGM6QlprtAPE0MUQaBHkUvKN7DyRWACA4lbOGtt87CX
         Y6hw==
X-Gm-Message-State: AOAM530Sn5qBGW8/LMuA0EYObTpFXhqDavxBAaBJ9WaUVtNLYChMrvVY
        GLNi2nbkS2c2yRfXYUvo67pIfxUCig4TvdxWVsVhgEvk
X-Google-Smtp-Source: ABdhPJxU8C9UjOTZB6uTgOT7x032cUeTIuy215npQXpthcl4cR7amD3NaDh1SQpre3fagltzCSTNTDsojjxlfwMLuiA=
X-Received: by 2002:a05:6102:2828:: with SMTP id ba8mr10966737vsb.18.1626419736162;
 Fri, 16 Jul 2021 00:15:36 -0700 (PDT)
MIME-Version: 1.0
References: <20210208143855.418374-1-geert+renesas@glider.be> <162638886252.651069.16002951650407635275.b4-ty@sntech.de>
In-Reply-To: <162638886252.651069.16002951650407635275.b4-ty@sntech.de>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Fri, 16 Jul 2021 09:15:25 +0200
Message-ID: <CAMuHMdUYLVHwb1EdLO0D-cAyJAvx=pjHHZNg1wDCmVu+nTBVKw@mail.gmail.com>
Subject: Re: [PATCH] soc: rockchip: ROCKCHIP_GRF should not default to y, unconditionally
To:     Heiko Stuebner <heiko@sntech.de>
Cc:     Douglas Anderson <dianders@chromium.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        "open list:ARM/Rockchip SoC..." <linux-rockchip@lists.infradead.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Heiko,

On Fri, Jul 16, 2021 at 12:42 AM Heiko Stuebner <heiko@sntech.de> wrote:
> On Mon, 8 Feb 2021 15:38:55 +0100, Geert Uytterhoeven wrote:
> > Merely enabling CONFIG_COMPILE_TEST should not enable additional code.
> > To fix this, restrict the automatic enabling of ROCKCHIP_GRF to
> > ARCH_ROCKCHIP, and ask the user in case of compile-testing.
>
> Applied, thanks!
>
> [1/1] soc: rockchip: ROCKCHIP_GRF should not default to y, unconditionally
>       commit: 2a1c55d4762dd34a8b0f2e36fb01b7b16b60735b
>
> I actually found the old one deep down in my inbox some days ago,
> so had applied that one already. Hope nothing changed with your
> RESEND.

They're identical, thanks!

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
