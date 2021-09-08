Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 32490403FFF
	for <lists+linux-kernel@lfdr.de>; Wed,  8 Sep 2021 21:45:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1352295AbhIHTqW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 8 Sep 2021 15:46:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47802 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1343558AbhIHTqT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Sep 2021 15:46:19 -0400
Received: from mail-io1-xd34.google.com (mail-io1-xd34.google.com [IPv6:2607:f8b0:4864:20::d34])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C1ABCC061575
        for <linux-kernel@vger.kernel.org>; Wed,  8 Sep 2021 12:45:10 -0700 (PDT)
Received: by mail-io1-xd34.google.com with SMTP id a13so4796764iol.5
        for <linux-kernel@vger.kernel.org>; Wed, 08 Sep 2021 12:45:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=cY82i5QFt3f+oSOKzp91m6FG0+h9u8XPOeGXpy/rmp8=;
        b=PwjzusCCcXmrdIWclxRAbuawGLVSB/EhOV0thKoYUYRN8m+k7eb0NyC+XejhuiM7E2
         Lo8AkpNDdkwirrJNaeci63OOGFVyta6AEUcmcJjX72OKeVxDTK5zyN55XXQEu43RY1tS
         P2AQ+ZQLsdhztPCSDW3x+zG6Y8pSL2z1eP9g4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=cY82i5QFt3f+oSOKzp91m6FG0+h9u8XPOeGXpy/rmp8=;
        b=hv7QF7sU+uhdS8Y6A0tMCVSaqeyPgKSbscYJKHIDjSelJp1J7AgPTlrWAraHpi/eem
         5B5x8Q/pv1Bdd2T+YPK8Oj6RectiR6yk1fgRnSYAlE4RWfpYqesl3NmKf992Tf0s285O
         z3peYOic9GxpUnS3rNpWzSJNjbC2zb6Qbzs0Bbux3lOFPBmG/G/Cb7KNyL8P0hFypXKs
         sOvy7/ZIdKnSCxFEMNlM3KPA8hz5rXCfJJgWbvs1XnfgqvkVjZnXot9SjTyqh66UdQIb
         /Fy3gcQY2tIwAGzM3znTGObuCl60QF0mNDVaip4bkoO6LdbyQYTix9elVaZdaFDR/4q+
         luaQ==
X-Gm-Message-State: AOAM532qvQTehQcABIh6R15YIxnemXmQ/EHtQmRYr4whOhGknPmNsddO
        4+0mf4B/mLRZwu5ex+EwJCgto45bQxepng==
X-Google-Smtp-Source: ABdhPJxXw4CZHVqdrfapx2+/2gs5ODkQBfqLwr8NBdvXkHjSaFt+FEl/Oj8Gk7rKj9Tvz+OqLYux4w==
X-Received: by 2002:a02:2341:: with SMTP id u62mr37753jau.6.1631130309738;
        Wed, 08 Sep 2021 12:45:09 -0700 (PDT)
Received: from mail-il1-f170.google.com (mail-il1-f170.google.com. [209.85.166.170])
        by smtp.gmail.com with ESMTPSA id z26sm50123iol.6.2021.09.08.12.45.08
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 08 Sep 2021 12:45:08 -0700 (PDT)
Received: by mail-il1-f170.google.com with SMTP id b4so3539613ilr.11
        for <linux-kernel@vger.kernel.org>; Wed, 08 Sep 2021 12:45:08 -0700 (PDT)
X-Received: by 2002:a05:6e02:e02:: with SMTP id a2mr1190609ilk.180.1631130308475;
 Wed, 08 Sep 2021 12:45:08 -0700 (PDT)
MIME-Version: 1.0
References: <20210908111337.v2.1.I006bb36063555079b1a88f01d20e38d7e4705ae0@changeid>
 <20210908111337.v2.2.If29cd838efbcee4450a62b8d84a99b23c86e0a3f@changeid>
In-Reply-To: <20210908111337.v2.2.If29cd838efbcee4450a62b8d84a99b23c86e0a3f@changeid>
From:   Doug Anderson <dianders@chromium.org>
Date:   Wed, 8 Sep 2021 12:44:57 -0700
X-Gmail-Original-Message-ID: <CAD=FV=Ua21T1S33nx9oFRLT8bhJFMazA_5Gd_+DQ+GYWm=q1Dw@mail.gmail.com>
Message-ID: <CAD=FV=Ua21T1S33nx9oFRLT8bhJFMazA_5Gd_+DQ+GYWm=q1Dw@mail.gmail.com>
Subject: Re: [PATCH v2 2/3] clk: rockchip: rk3399: expose PCLK_COREDBG_{B,L}
To:     Brian Norris <briannorris@chromium.org>
Cc:     Heiko Stuebner <heiko@sntech.de>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        "open list:ARM/Rockchip SoC..." <linux-rockchip@lists.infradead.org>,
        linux-clk <linux-clk@vger.kernel.org>,
        Chen-Yu Tsai <wenst@chromium.org>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Wed, Sep 8, 2021 at 11:14 AM Brian Norris <briannorris@chromium.org> wrote:
>
> We have DT IDs for PCLK_COREDBG_L and PCLK_COREDBG_B, but we don't
> actually expose them.
>
> Note that this requires the previous patch (making "armclkl" and
> "armclkb" into "critical" clocks) to prevent these clocks from taking
> down the CPU.
>
> Reviewed-by: Chen-Yu Tsai <wenst@chromium.org>
> Signed-off-by: Brian Norris <briannorris@chromium.org>
> ---
>
> Changes in v2:
>   - Split "CPU clocks are critical" to a new patch, to make it more
>     obvious
>
>  drivers/clk/rockchip/clk-rk3399.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)

Reviewed-by: Douglas Anderson <dianders@chromium.org>
