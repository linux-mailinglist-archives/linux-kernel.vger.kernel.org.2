Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 580FC373CB5
	for <lists+linux-kernel@lfdr.de>; Wed,  5 May 2021 15:53:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233325AbhEENyS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 5 May 2021 09:54:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58120 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232541AbhEENyQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 May 2021 09:54:16 -0400
Received: from mail-pg1-x52b.google.com (mail-pg1-x52b.google.com [IPv6:2607:f8b0:4864:20::52b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3AD33C061574
        for <linux-kernel@vger.kernel.org>; Wed,  5 May 2021 06:53:19 -0700 (PDT)
Received: by mail-pg1-x52b.google.com with SMTP id c21so1851828pgg.3
        for <linux-kernel@vger.kernel.org>; Wed, 05 May 2021 06:53:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=n1bbsdQFslUe2/D8fiyQmt7GT8BuGOrH6bymhVpBYX0=;
        b=Key2mtimVz3Ms9QHFbm4+H7mGJ0Ryu2plYuVDFRZjpPSMAdAD5nCBdXFdPFEFUJIvf
         QsPqFq2nTQv3zsXqVfDIqgtf/Q7ma8W2BEtCjCaq2veefFeg9Zf5iFSuhQWPe/MRYHhO
         J+pT6zBwMfMpXE2z4H0pWtMDJRH0kOnIGMH5JKuz7O31W0CVIV0iefAiDshNHsUT8KUw
         ys6ywYxzupKjoqkEv9sW1YvBER5/JV2MYPXmDnJq6hKgQe3DETrS0fuI4a+ZbH6vHx2T
         yU0Iv7KK9687KoatwGwgtHpGT5v4//KWks/yMgZfx4fHaRGcUHdf+eUFpqYT3bF8afEW
         hkGA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=n1bbsdQFslUe2/D8fiyQmt7GT8BuGOrH6bymhVpBYX0=;
        b=ch/pdFV7uX8QlcxPMyRSWAnjRlwwx4IuJ3N1qtdDHvOveoqomrA7slZRMhUfpS0aqz
         BaGk1D3r6nQPKJ1lkiljxzpwRyqR4mZ8qvsE8Pwuqx9SRjfHQ3rXCEokCc6Oyocxakag
         DRcElpP8p6Q/C/BAoGFpEIoBm4vYK/rPp7d2jqv1n72z1HbthdrDFm9zZ+es9oqgNUr3
         e7Kq29ZVVX6VHVRmrkf0ksL1EBy4s3/NrLmUxp8XV4W3wnRMBKCuUHnoFdMVEPPC394A
         i9jJAu35EZzY0BsqE0Wsv7be4/pHnrRwB2cGjp/GPP6sTTqFi2zfyG3rqmkE/c3/XjMm
         HZ4A==
X-Gm-Message-State: AOAM531NdOWq81Z+1JTbjS2DO7mGApGSEbZ0nYT+hxjuyHwJHy1Ckj9W
        wDDBGR7GMNzsj2H1p8dy2PF/e16MB4q9BauqbOrHT1tMk0JQvg==
X-Google-Smtp-Source: ABdhPJyluxFRTo8fdiox4JZ/YBjp7C3OIiVJ3YAHoNyjb+ElKi+tqlmQFHxdzj08K6nCwubf+VSVhH2i0N/I2jSnzsg=
X-Received: by 2002:a65:4c8e:: with SMTP id m14mr27753924pgt.377.1620222798644;
 Wed, 05 May 2021 06:53:18 -0700 (PDT)
MIME-Version: 1.0
References: <55fe7f3454d8c91dc3837ba5aa741d4a0e67378f.1618797813.git.tommyhebb@gmail.com>
In-Reply-To: <55fe7f3454d8c91dc3837ba5aa741d4a0e67378f.1618797813.git.tommyhebb@gmail.com>
From:   Jonathan Liu <net147@gmail.com>
Date:   Wed, 5 May 2021 23:53:07 +1000
Message-ID: <CANwerB2Jjtu=HyLEgFjf1PyJEWzE9_7rcTgTr2QAXCWXZWjC3g@mail.gmail.com>
Subject: Re: [RESEND PATCH] drm/rockchip: dsi: move all lane config except
 LCDC mux to bind()
To:     Thomas Hebb <tommyhebb@gmail.com>
Cc:     linux-kernel <linux-kernel@vger.kernel.org>,
        Nickey Yang <nickey.yang@rock-chips.com>,
        Heiko Stuebner <heiko@sntech.de>,
        Andrzej Hajda <a.hajda@samsung.com>,
        Brian Norris <briannorris@chromium.org>,
        Daniel Vetter <daniel@ffwll.ch>,
        David Airlie <airlied@linux.ie>,
        Sandy Huang <hjc@rock-chips.com>,
        Sean Paul <seanpaul@chromium.org>,
        dri-devel <dri-devel@lists.freedesktop.org>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        linux-rockchip@lists.infradead.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 19 Apr 2021 at 02:04, Thomas Hebb <tommyhebb@gmail.com> wrote:
>
> When we first enable the DSI encoder, we currently program some per-chip
> configuration that we look up in rk3399_chip_data based on the device
> tree compatible we match. This data configures various parameters of the
> MIPI lanes, including on RK3399 whether DSI1 is slaved to DSI0 in a
> dual-mode configuration. It also selects which LCDC (i.e. VOP) to scan
> out from.
>
> This causes a problem in RK3399 dual-mode configurations, though: panel
> prepare() callbacks run before the encoder gets enabled and expect to be
> able to write commands to the DSI bus, but the bus isn't fully
> functional until the lane and master/slave configuration have been
> programmed. As a result, dual-mode panels (and possibly others too) fail
> to turn on when the rockchipdrm driver is initially loaded.
>
> Because the LCDC mux is the only thing we don't know until enable time
> (and is the only thing that can ever change), we can actually move most
> of the initialization to bind() and get it out of the way early. That's
> what this change does. (Rockchip's 4.4 BSP kernel does it in mode_set(),
> which also avoids the issue, but bind() seems like the more correct
> place to me.)
>
> Tested on a Google Scarlet board (Acer Chromebook Tab 10), which has a
> Kingdisplay KD097D04 dual-mode panel. Prior to this change, the panel's
> backlight would turn on but no image would appear when initially loading
> rockchipdrm. If I kept rockchipdrm loaded and reloaded the panel driver,
> it would come on. With this change, the panel successfully turns on
> during initial rockchipdrm load as expected.
>
> Fixes: 2d4f7bdafd70 ("drm/rockchip: dsi: migrate to use dw-mipi-dsi bridge driver")
> Signed-off-by: Thomas Hebb <tommyhebb@gmail.com>

Tested-by: Jonathan Liu <net147@gmail.com>

Fixes MIPI-DSI panel initialization for me on RK3399 too.

Regards,
Jonathan
