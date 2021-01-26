Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E56EC305290
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Jan 2021 06:54:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234922AbhA0DO5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 26 Jan 2021 22:14:57 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55970 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728952AbhAZTjF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Jan 2021 14:39:05 -0500
Received: from mail-lj1-x236.google.com (mail-lj1-x236.google.com [IPv6:2a00:1450:4864:20::236])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E5CECC06174A
        for <linux-kernel@vger.kernel.org>; Tue, 26 Jan 2021 11:38:24 -0800 (PST)
Received: by mail-lj1-x236.google.com with SMTP id r14so2330619ljc.2
        for <linux-kernel@vger.kernel.org>; Tue, 26 Jan 2021 11:38:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:subject:from:to:date:in-reply-to:references:user-agent
         :mime-version:content-transfer-encoding;
        bh=QJYovKT99XXIoP/qY54FEd7zbaJUkpH5fmKd5QnuoOg=;
        b=FgRy4EOuuaXksD0SJxgNsQol120CK1WUCFz7OEYGmFKwOO9fhjUzas98tKXQWy77hp
         RyzNg7siskA3gRl7XMauAbQpVQScnkaYarGi2aB/iQUxP6SVEgSswe27qvKQgz4DmC0X
         SdCGYgJT957kVGl1gRH5Rvh4jAVEU0yCzI3cil3GM1GaU/WBd99BPPobUBha6yqn9KPF
         i94y2k8cjtSvJYm5SOR1w35R/A9j1QT00T9UC6227b3Q9f26dE0w8n3Ab6G0W/G3OgaJ
         Jjb7weDDC1KYwlkBO3LGjLyMFUkWttJMPzQ08XXS3n1766Hl2fqGd1iAMGYltYF02F+A
         fLvw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:subject:from:to:date:in-reply-to
         :references:user-agent:mime-version:content-transfer-encoding;
        bh=QJYovKT99XXIoP/qY54FEd7zbaJUkpH5fmKd5QnuoOg=;
        b=AlV1gje/UJVncL0Vk0jY8X8Br8xMvV+H+hktTwlR6Yh8grpY+baWdGKLXCsnHK4VwX
         CiW4q+yQuheS2rmieMb2hVX3bOq/BmcuLryWGw3NSBqYiIcZSKoNRHmx49fQkUAlbnf1
         vliaY8S2e4N6CCBmASe5OpEU3D/9WoPWiaHb4WaULdsKN2OsoJVaxexE701/NT8U/08p
         luv71K2laHqSM1ohiKKTaFKv8V1YLhUM2gzDz2kpY2Qvb84ZHn6M0bhBORa9AO818JFL
         z90XeBhIilid20R2M7JHKhMXnzOWuIFtncWrsemc8SM0v4Pg0LE1bDYRdDRy9PatEaXt
         oxJA==
X-Gm-Message-State: AOAM530nkYDwZPiMZ8VE6F2p+nx0pm+M26s+wsSN+fcCRnksiD4aCd72
        X7ZLhmAjyHI2qSuQvz78+/Y=
X-Google-Smtp-Source: ABdhPJyRgIwA4Gv0YSGMtUyNidF9HCtWfQnILR+W+6IxjuVt5JYejYkcN4Ph62Nssv3hkTfORiHl+Q==
X-Received: by 2002:a2e:a379:: with SMTP id i25mr3744134ljn.430.1611689903467;
        Tue, 26 Jan 2021 11:38:23 -0800 (PST)
Received: from localhost.localdomain (unnum-78-27-181-19.domashka.kiev.ua. [78.27.181.19])
        by smtp.gmail.com with ESMTPSA id a81sm1438719lfd.211.2021.01.26.11.38.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 26 Jan 2021 11:38:22 -0800 (PST)
Message-ID: <d6c4a63fb6d51c23db50bf15335d059208aeb3a4.camel@gmail.com>
Subject: Re: panel: panel-raydium68200 driver fails to write MIPI DSI init
 commands
From:   aleksandr.o.makarov@gmail.com
To:     Philippe CORNU <philippe.cornu@st.com>,
        Andrzej Hajda <a.hajda@samsung.com>,
        Neil Armstrong <narmstrong@baylibre.com>,
        Laurent Pinchart <Laurent.pinchart@ideasonboard.com>,
        Jonas Karlman <jonas@kwiboo.se>,
        Jernej Skrabec <jernej.skrabec@siol.net>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        Sam Ravnborg <sam@ravnborg.org>,
        Antonio BORNEO <antonio.borneo@st.com>,
        "<dri-devel@lists.freedesktop.org>" <linux-kernel@vger.kernel.org>
Date:   Tue, 26 Jan 2021 21:38:21 +0200
In-Reply-To: <a855ddc858394a2492dce1ce3267946e@SFHDAG2NODE3.st.com>
References: <bf9ddf520b6f6f6d61123db02cd8fea10f495562.camel@gmail.com>
         <a855ddc858394a2492dce1ce3267946e@SFHDAG2NODE3.st.com>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.38.2 (3.38.2-1.module_f33+10736+4f8d5006) 
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

В Вт, 19/01/2021 в 16:24 +0000, Philippe CORNU пишет:
> Dear Aleksandr,
> 
> We use the raydium68200 ic driver in a dsi 720p 2dl panel module mounted on the MB1230 board [1], mounted on the STM32MP157 eval board [2].
> 
> According to your email, you are using the EDT ETML0500F3DHA panel module, probably composed of a raydium68200+a touchscreen+a glass+backlight+.... 
> 
> Could you please double check if your panel module has the same characteristics as the one described in panel-raydium68200.c (pixel clock, blanking values, resolutions, number of dsi data lanes, enable & reset gpios, backlight...).
> 
> Moreover, maybe your panel embeds a non-volatile ram which contains nice default values ("fused" during production) allowing to reduce a lot the panel init sequence... allowing then to use panel-simple.c instead of panel-raydium68200.c (that could explain why you can see "colors" without sending any init sequence).
> 
> The issues you encountered may come from (starting with the highest probability):
> * bad lcd hw vs sw configuration (see description above).
> * bad pixel clock frequency, bad blanking values...
> * bad dsi internal Rockchip ip programming (pll and clock trees in dt...)
> 
> Hope it helps,
> 
> [1] https://wiki.st.com/stm32mpu/wiki/MB1230
> [2] https://www.st.com/en/evaluation-tools/stm32mp157a-ev1.html
> 
> Philippe :-)
> 
I've fixed errors related to writing to DSI after applying this [1]
patch.

With the panel timings and other parameters all left intact in device
tree, I only had to apply that patch to start to see video.

After doing some testing, I found an issue with patch. With it applied,
you must keep your driver as module with DRM_PANEL_RAYDIUM_RM68200=m.
Otherwise, if DRM_PANEL_RAYDIUM_RM68200=y is set, the issues with
writing to DSI from prepare() shall persist. 

[1] https://patchwork.kernel.org/project/dri-
devel/patch/95f16906d654057c912f089d286bd51856ee3bdf.1607892237.git.tom
myhebb@gmail.com/
> -----Original Message-----
> From: aleksandr.o.makarov@gmail.com <aleksandr.o.makarov@gmail.com> 
> Sent: Saturday, January 16, 2021 12:40
> To: Andrzej Hajda <a.hajda@samsung.com>; Neil Armstrong <narmstrong@baylibre.com>; Laurent Pinchart <Laurent.pinchart@ideasonboard.com>; Jonas Karlman <jonas@kwiboo.se>; Jernej Skrabec <jernej.skrabec@siol.net>; David Airlie <airlied@linux.ie>; Daniel Vetter <daniel@ffwll.ch>; Sam Ravnborg <sam@ravnborg.org>; Philippe CORNU <philippe.cornu@st.com>; Antonio BORNEO <antonio.borneo@st.com>; <dri-devel@lists.freedesktop.org> <linux-kernel@vger.kernel.org>
> Subject: drm: panel: panel-raydium68200 driver fails to write MIPI DSI init commands
> 
> I need to bring up my MIPI DSI 1280x720 EDT ETML0500F3DHA panel on a
> RockPro64 V2.1 board.
> 
> There is no completely suitable in-tree driver for that panel yet, but for the purpose of reproducing the issue that I face, the gpu/drm/panel/panel-raydium-rm68200.c can do just fine.
> 
> To reproduce:
> 
> - Get the same Linux 5.9.14 as on my RockPro64 board (with Armbian
> 20.11.6 on it)
> 
> - Patch the rk3399-rockpro64.dts to add a panel node that is compatible with "raydium,rm68200" driver on MIPI interface (rockpro64- rm68200.patch attached)
> 
> - Compile and put the resulting rk3399-rockpro64.dtb on the target system. The panel driver shall then get probed at next boot.
> 
> The kernel log shall contain following errors:
> 
> [   10.139957] dw-mipi-dsi-rockchip ff960000.mipi: failed to write
> command FIFO
> [   10.139988] [drm:rm68200_dcs_write_cmd.isra.4
> [panel_raydium_rm68200]] *ERROR* MIPI DSI DCS write failed: -110
> [   10.160972] dw-mipi-dsi-rockchip ff960000.mipi: failed to write
> command FIFO
> [   10.161000] [drm:rm68200_dcs_write_buf.isra.5
> [panel_raydium_rm68200]] *ERROR* MIPI DSI DCS write buffer failed: -110
> [   10.181929] dw-mipi-dsi-rockchip ff960000.mipi: failed to write
> command FIFO
> [   10.181953] [drm:rm68200_dcs_write_buf.isra.5
> [panel_raydium_rm68200]] *ERROR* MIPI DSI DCS write buffer failed: -110
> [   10.202923] dw-mipi-dsi-rockchip ff960000.mipi: failed to write
> command FIFO
> [   10.202947] [drm:rm68200_dcs_write_buf.isra.5
> [panel_raydium_rm68200]] *ERROR* MIPI DSI DCS write buffer failed: -110
> [   10.223064] dw-mipi-dsi-rockchip ff960000.mipi: failed to write
> command FIFO
> [   10.223094] [drm:rm68200_dcs_write_buf.isra.5
> [panel_raydium_rm68200]] *ERROR* MIPI DSI DCS write buffer failed: -110
> [   10.226104] zram1: detected capacity change from 0 to 52428800
> [   10.244027] dw-mipi-dsi-rockchip ff960000.mipi: failed to write
> command FIFO
> [   10.244073] [drm:rm68200_dcs_write_buf.isra.5
> [panel_raydium_rm68200]] *ERROR* MIPI DSI DCS write buffer failed: -110
> [   10.265024] dw-mipi-dsi-rockchip ff960000.mipi: failed to write
> command FIFO
> [   10.265064] [drm:rm68200_dcs_write_buf.isra.5
> [panel_raydium_rm68200]] *ERROR* MIPI DSI DCS write buffer failed: -110
> [   10.285711] dw-mipi-dsi-rockchip ff960000.mipi: failed to write
> command FIFO
> [   10.285746] [drm:rm68200_dcs_write_buf.isra.5
> [panel_raydium_rm68200]] *ERROR* MIPI DSI DCS write buffer failed: -110
> [   10.305926] dw-mipi-dsi-rockchip ff960000.mipi: failed to write
> command FIFO
> [   10.305955] [drm:rm68200_dcs_write_buf.isra.5
> [panel_raydium_rm68200]] *ERROR* MIPI DSI DCS write buffer failed: -110
> [   10.326996] dw-mipi-dsi-rockchip ff960000.mipi: failed to write
> command FIFO
> [   10.327039] [drm:rm68200_dcs_write_buf.isra.5
> [panel_raydium_rm68200]] *ERROR* MIPI DSI DCS write buffer failed: -110
> [   10.348030] dw-mipi-dsi-rockchip ff960000.mipi: failed to write
> command FIFO
> [   10.348074] [drm:rm68200_dcs_write_buf.isra.5
> [panel_raydium_rm68200]] *ERROR* MIPI DSI DCS write buffer failed: -110
> 
> It's remarkable that if to pull the module panel-rm682000 out and then back in, there are no errors mentioned. I can for sure say that those commands become effective - I start seeing colourful stripes on the display after. That is, if I would send the correct command set to the panel, then it would bring up just fine. the panel, then it would bring up just fine.


