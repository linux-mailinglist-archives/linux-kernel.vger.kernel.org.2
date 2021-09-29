Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5F9D541BCB8
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Sep 2021 04:28:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243785AbhI2C3r (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 28 Sep 2021 22:29:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48676 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243718AbhI2C3j (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Sep 2021 22:29:39 -0400
Received: from mail-lf1-x12a.google.com (mail-lf1-x12a.google.com [IPv6:2a00:1450:4864:20::12a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1C456C061745
        for <linux-kernel@vger.kernel.org>; Tue, 28 Sep 2021 19:27:59 -0700 (PDT)
Received: by mail-lf1-x12a.google.com with SMTP id x27so4259652lfa.9
        for <linux-kernel@vger.kernel.org>; Tue, 28 Sep 2021 19:27:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=fJjBCR4+9bCZVm0Fu8Xcmw+g/rqGltdjILLNILMG/mA=;
        b=gZItg880S7ngvt1ScsVFZbT92Pz35STUpkg7MtmBPG38S8oE0RNWXVxg5AsCJmsiso
         gjU9EtdpeqLxN8TOF5kWZEb6v6ULSNqjKWay2YeRQCSYzJo2aiENwykZpJGyAuHjhXlY
         nukor5W0hJzjkNO93yWm4lxshhwfHKxlrCThA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=fJjBCR4+9bCZVm0Fu8Xcmw+g/rqGltdjILLNILMG/mA=;
        b=NdjGx7yg/GI1NgIyrpiLO9wAqfJawAnj3N+TRPYnuxdYF1m2GuB3HWNn7c+6wdtnzR
         CIJFY4pC1nrUKk7mOgvRid8UOCmolXlhOpWrBL0F162pYF0Y5C3SZAIEac/wvy1Jpevu
         OFIHA7te7qMsH7CPOXFiT2srJj5qtH3tdrPccge9t9S2VH/qYsjZItCuu96v+83JeCOn
         AgIT0t/epZsP3hO5NvvfGBBDmf9pNvGDQSkbgn6t7IzSssoWSrtjZpkhBBJlH/e+WkqG
         8LhGmmwWVXTE468CBpzlyUQFKC3pBdquI+NVIFg1TFghbqZjqq6tPY5iYilwniy2mNcW
         rFuA==
X-Gm-Message-State: AOAM5317zDPo96nKLE1rr4p35qHgpbWqfTxH/FfrEi5HDLRbBKH1ulfy
        HpUF8R4om9GSw19It3YkSmUD5lyBYTiCH+iubs0sjA==
X-Google-Smtp-Source: ABdhPJxtLJKFI2ooM24bJMRumtCIgTrU9ia9VK2xsan8DKGDUzhXg/ByJkFUAByLAPwnyRDMK4Wt9rw5VOO0jFuGCL8=
X-Received: by 2002:ac2:495b:: with SMTP id o27mr8638251lfi.501.1632882477417;
 Tue, 28 Sep 2021 19:27:57 -0700 (PDT)
MIME-Version: 1.0
References: <20210928213552.1001939-1-briannorris@chromium.org> <20210928143413.v3.1.Ic2904d37f30013a7f3d8476203ad3733c186827e@changeid>
In-Reply-To: <20210928143413.v3.1.Ic2904d37f30013a7f3d8476203ad3733c186827e@changeid>
From:   Chen-Yu Tsai <wenst@chromium.org>
Date:   Wed, 29 Sep 2021 10:27:46 +0800
Message-ID: <CAGXv+5FO2GrH9BQ=ohH-oE_A6rKAoEfpbAB_1Qsq9v0vGJ+7ww@mail.gmail.com>
Subject: Re: [PATCH v3 1/4] drm/rockchip: dsi: Hold pm-runtime across bind/unbind
To:     Brian Norris <briannorris@chromium.org>
Cc:     =?UTF-8?Q?Heiko_St=C3=BCbner?= <heiko@sntech.de>,
        LKML <linux-kernel@vger.kernel.org>,
        dri-devel <dri-devel@lists.freedesktop.org>,
        "open list:ARM/Rockchip SoC..." <linux-rockchip@lists.infradead.org>,
        Sandy Huang <hjc@rock-chips.com>,
        Thomas Hebb <tommyhebb@gmail.com>,
        aleksandr.o.makarov@gmail.com, stable@vger.kernel.org,
        =?UTF-8?B?TsOtY29sYXMgRiAuIFIgLiBBIC4gUHJhZG8=?= 
        <nfraprado@collabora.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Sep 29, 2021 at 5:36 AM Brian Norris <briannorris@chromium.org> wro=
te:
>
> In commit 43c2de1002d2, we moved most HW configuration to bind(), but we
> didn't move the runtime PM management. Therefore, depending on initial
> boot state, runtime-PM workqueue delays, and other timing factors, we
> may disable our power domain in between the hardware configuration
> (bind()) and when we enable the display. This can cause us to lose
> hardware state and fail to configure our display. For example:
>
>   dw-mipi-dsi-rockchip ff968000.mipi: failed to write command FIFO
>   panel-innolux-p079zca ff960000.mipi.0: failed to write command 0
>
> or:
>
>   dw-mipi-dsi-rockchip ff968000.mipi: failed to write command FIFO
>   panel-kingdisplay-kd097d04 ff960000.mipi.0: failed write init cmds: -11=
0
>
> We should match the runtime PM to the lifetime of the bind()/unbind()
> cycle.
>
> Tested on Acer Chrometab 10 (RK3399 Gru-Scarlet), with panel drivers
> built either as modules or built-in.
>
> Side notes: it seems one is more likely to see this problem when the
> panel driver is built into the kernel. I've also seen this problem
> bisect down to commits that simply changed Kconfig dependencies, because
> it changed the order in which driver init functions were compiled into
> the kernel, and therefore the ordering and timing of built-in device
> probe.
>
> Fixes: 43c2de1002d2 ("drm/rockchip: dsi: move all lane config except LCDC=
 mux to bind()")
> Link: https://lore.kernel.org/linux-rockchip/9aedfb528600ecf871885f7293ca=
4207c84d16c1.camel@gmail.com/
> Reported-by: <aleksandr.o.makarov@gmail.com>
> Cc: <stable@vger.kernel.org>
> Signed-off-by: Brian Norris <briannorris@chromium.org>
> Tested-by: N=C3=ADcolas F. R. A. Prado <nfraprado@collabora.com>

Reviewed-by: Chen-Yu Tsai <wenst@chromium.org>
