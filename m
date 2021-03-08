Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CFB18331984
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Mar 2021 22:46:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229901AbhCHVqH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 8 Mar 2021 16:46:07 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39194 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230509AbhCHVpo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Mar 2021 16:45:44 -0500
Received: from mail-oo1-xc2b.google.com (mail-oo1-xc2b.google.com [IPv6:2607:f8b0:4864:20::c2b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BDB14C06174A
        for <linux-kernel@vger.kernel.org>; Mon,  8 Mar 2021 13:45:44 -0800 (PST)
Received: by mail-oo1-xc2b.google.com with SMTP id l5so2549810ooj.7
        for <linux-kernel@vger.kernel.org>; Mon, 08 Mar 2021 13:45:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=98cBjcjhuYHRPD7k85MY8DSxP3E150dqHIpXKr7a8vo=;
        b=HTNVHer2R1dsIR8ja17XwqWKWkEQRomuKKAFZBtej5KqVJPPaJjh28B5dI+v3ASXR2
         Aiv4Df+7C9OYzaNZHFfEV7OyVLMD/GCAKrX2XgeBkZR8XhdUlLMUBp1m+JAxlex/3Iqn
         oVw1bJsQ9Yz92eDMa0jL0yO5FGrSR+AKD8XtJ8dZs8q4lm0v+/hWFc0ppMpgXCSsvwaF
         Q7SjKCYgtt+P+wLA8P1GpH9pVEL8H9ghqHDUuZG23dE2RdsbT155L/w/tS2dS71I8N47
         poEQCJUjZPp6EtDjiCw9e1lfpinSouLeV//1U6NZBIfOsY8SU3W9o0tZchFSv9wzX21M
         spDg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=98cBjcjhuYHRPD7k85MY8DSxP3E150dqHIpXKr7a8vo=;
        b=TKesf2pE2HjUUz9Tyew+p7lDwavsgoFq3evkFnSqOwIxz+rh95BRIiUGQx1awnt8/C
         vyb0Xfbl/cCx2UCgtOyjF9XMfUuIfFPfUzPaEkyvRIrXVNvFPHPSkNwN4RIT+mRdAFXE
         gVwPW6XAkcyIq5LoQWaIHVNWGdwQlKb68oGhDvTpKragt20EXpbggEEMdW87UFhDkAZt
         jY5HUcmwUjZ9UBDJmmPmMUgx1m22lqM8/KoSkWp2d3+5emN1fQhNbpM7xibOhbqoATwm
         WKcndTxN2dOIfKz/LdxFL4o+DN5fPiE7dZs9oevXY+Znrrkn7UHK7JSWzHP5zAQaPQY3
         NXqw==
X-Gm-Message-State: AOAM5301B4zaXx1nBZ9QnFrVEl7SXh6EO344ChzrKtfDXUEaUdVZ2y7G
        z3rhCdbXRiUoFb2mhNkBQ4qjItCF1fonH9ar0S0=
X-Google-Smtp-Source: ABdhPJwpsHutLCgDMpdVA+x2+rqBtCCg/0khVtNykRTxJz6fzAakSBg9LGgIAsGNhNJObjtkA57rNQ/RQJlxHyshSQQ=
X-Received: by 2002:a4a:d155:: with SMTP id o21mr19817235oor.72.1615239944232;
 Mon, 08 Mar 2021 13:45:44 -0800 (PST)
MIME-Version: 1.0
References: <20210306110525.216316-1-zhang.yunkai@zte.com.cn>
In-Reply-To: <20210306110525.216316-1-zhang.yunkai@zte.com.cn>
From:   Alex Deucher <alexdeucher@gmail.com>
Date:   Mon, 8 Mar 2021 16:45:33 -0500
Message-ID: <CADnq5_Mxeg2jpzPkQ1f8ugEyB7j9U1hp6+_3xsY-0LuA7yTwaw@mail.gmail.com>
Subject: Re: [PATCH] drm/amd/display: remove duplicate include in dcn21 and gpio
To:     menglong8.dong@gmail.com
Cc:     "Leo (Sunpeng) Li" <sunpeng.li@amd.com>, isabel.zhang@amd.com,
        Sung Lee <sung.lee@amd.com>,
        Dmytro Laktyushkin <Dmytro.Laktyushkin@amd.com>,
        Dave Airlie <airlied@linux.ie>,
        "Cheng, Tony" <Tony.Cheng@amd.com>,
        "Siqueira, Rodrigo" <Rodrigo.Siqueira@amd.com>,
        amd-gfx list <amd-gfx@lists.freedesktop.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Zhang Yunkai <zhang.yunkai@zte.com.cn>,
        Aurabindo Pillai <aurabindo.pillai@amd.com>,
        Maling list - DRI developers 
        <dri-devel@lists.freedesktop.org>, Wyatt Wood <wyatt.wood@amd.com>,
        "Deucher, Alexander" <alexander.deucher@amd.com>,
        Krunoslav Kovac <Krunoslav.Kovac@amd.com>,
        Christian Koenig <christian.koenig@amd.com>,
        Anthony Koo <Anthony.Koo@amd.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Applied.  Thanks!

Alex

On Sat, Mar 6, 2021 at 6:05 AM <menglong8.dong@gmail.com> wrote:
>
> From: Zhang Yunkai <zhang.yunkai@zte.com.cn>
>
> 'dce110_resource.h' included in 'dcn21_resource.c' is duplicated.
> 'hw_gpio.h' included in 'hw_factory_dce110.c' is duplicated.
>
> Signed-off-by: Zhang Yunkai <zhang.yunkai@zte.com.cn>
> ---
>  drivers/gpu/drm/amd/display/dc/dcn21/dcn21_resource.c         | 1 -
>  .../gpu/drm/amd/display/dc/gpio/dce110/hw_factory_dce110.c    | 4 ----
>  2 files changed, 5 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/display/dc/dcn21/dcn21_resource.c b/drivers/gpu/drm/amd/display/dc/dcn21/dcn21_resource.c
> index 072f8c880924..8a6a965751e8 100644
> --- a/drivers/gpu/drm/amd/display/dc/dcn21/dcn21_resource.c
> +++ b/drivers/gpu/drm/amd/display/dc/dcn21/dcn21_resource.c
> @@ -61,7 +61,6 @@
>  #include "dcn21/dcn21_dccg.h"
>  #include "dcn21_hubbub.h"
>  #include "dcn10/dcn10_resource.h"
> -#include "dce110/dce110_resource.h"
>  #include "dce/dce_panel_cntl.h"
>
>  #include "dcn20/dcn20_dwb.h"
> diff --git a/drivers/gpu/drm/amd/display/dc/gpio/dce110/hw_factory_dce110.c b/drivers/gpu/drm/amd/display/dc/gpio/dce110/hw_factory_dce110.c
> index 66e4841f41e4..ca335ea60412 100644
> --- a/drivers/gpu/drm/amd/display/dc/gpio/dce110/hw_factory_dce110.c
> +++ b/drivers/gpu/drm/amd/display/dc/gpio/dce110/hw_factory_dce110.c
> @@ -48,10 +48,6 @@
>  #define REGI(reg_name, block, id)\
>         mm ## block ## id ## _ ## reg_name
>
> -#include "../hw_gpio.h"
> -#include "../hw_ddc.h"
> -#include "../hw_hpd.h"
> -
>  #include "reg_helper.h"
>  #include "../hpd_regs.h"
>
> --
> 2.25.1
>
> _______________________________________________
> dri-devel mailing list
> dri-devel@lists.freedesktop.org
> https://lists.freedesktop.org/mailman/listinfo/dri-devel
