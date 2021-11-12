Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1769944E740
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Nov 2021 14:24:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234986AbhKLN1U (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 12 Nov 2021 08:27:20 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54310 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231855AbhKLN1T (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 12 Nov 2021 08:27:19 -0500
Received: from mail-wm1-x335.google.com (mail-wm1-x335.google.com [IPv6:2a00:1450:4864:20::335])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 753D8C061766
        for <linux-kernel@vger.kernel.org>; Fri, 12 Nov 2021 05:24:28 -0800 (PST)
Received: by mail-wm1-x335.google.com with SMTP id z200so7718709wmc.1
        for <linux-kernel@vger.kernel.org>; Fri, 12 Nov 2021 05:24:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20210112.gappssmtp.com; s=20210112;
        h=subject:to:cc:references:from:organization:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=pvQoleAGM9Zrph+RM13dsCV9NkoY/kMYM5P43VaVlns=;
        b=qaVKsAW0Aq9EIXUGVOdi0/rsBJ+wQM59iVEqQzmRET3Igj3lB4KgSF4gV1PHP/2oil
         0gn+LQAap+LbA3zly0Dz0cBAY7Ea6r0dPr4O6+ryKnwDP2MXTdtNyQUFjnhalEQVYGUb
         Mfum9u0hKUt7/TspQcmZE8SFI3SE6J1AeXuJWPjzLDKCunSDyDTShULfmXf6CdKzXYc5
         eRy2yPr1k+CsvDcr5rgKWSpCrQ6sZ/4nPGyPCOJ7qKf8qUkFZuiYA+mpGw3ZaVLEi42x
         9T6Hncf4kQPbuy6MPRtuEFvNn1TeY5fQyderi57bb7C83Ob6XVnQDrBjfD2aX/kB/rgG
         KQSQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:subject:to:cc:references:from:organization
         :message-id:date:user-agent:mime-version:in-reply-to
         :content-language:content-transfer-encoding;
        bh=pvQoleAGM9Zrph+RM13dsCV9NkoY/kMYM5P43VaVlns=;
        b=LYViHcGry1TI3xVKvtr4O2J5eVB13F8iymOoWWCbDbi4OH6rxXg/p4sTt0TPvTeHE0
         +K9co7rQr4D46U3RdowRbO+VXPr9HEeDAwwwihmzAjZiTOOb+SyiYVImyeSIpiCudPxj
         Jx6hy+RTEJN41zCImy1w3u/szXKypOZKmSyB5lsazCXAJRARDH9mJRFKlho+AM4NVKTB
         Mw7kBlBRA1qFzHiX8kJKJHlgPcHuIyapaJ7jnGewuLtmvzN6pEMp3hrSh5Q7M1Podemu
         SL80Ej3nyOgTcJfNWTCFM+RPYGOGhFMow7zd6MF6ySlGaR7/cvUFRx568maIE7LsMpkB
         A3Aw==
X-Gm-Message-State: AOAM532ENb7yO6ZxvDBEw0pai3zB0fRnhZwHmT6zKgWBpakXOOVJ70vD
        4DWRW2C4CFf+LukC59nc6f5q8PCIfKAk3QLw
X-Google-Smtp-Source: ABdhPJypVrEMaaFxG9GsLct4xeTHd0tGCt2OsXltLtPd9pGRzvEezB5JSb8+HTfZRNCYd5lod1o2EQ==
X-Received: by 2002:a7b:c155:: with SMTP id z21mr33442835wmi.107.1636723466539;
        Fri, 12 Nov 2021 05:24:26 -0800 (PST)
Received: from ?IPv6:2001:861:44c0:66c0:15c5:4746:b404:ed78? ([2001:861:44c0:66c0:15c5:4746:b404:ed78])
        by smtp.gmail.com with ESMTPSA id h204sm5979057wmh.33.2021.11.12.05.24.25
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 12 Nov 2021 05:24:26 -0800 (PST)
Subject: Re: [PATCH v3 0/6] drm/meson: rework encoders to pass
 ATTACH_NO_CONNECTOR
To:     daniel@ffwll.ch, Laurent.pinchart@ideasonboard.com,
        sam@ravnborg.org
Cc:     martin.blumenstingl@googlemail.com,
        dri-devel@lists.freedesktop.org, linux-amlogic@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
References: <20211020123947.2585572-1-narmstrong@baylibre.com>
From:   Neil Armstrong <narmstrong@baylibre.com>
Organization: Baylibre
Message-ID: <3e0e5a2f-a81b-dcba-e379-4786c4a5de7b@baylibre.com>
Date:   Fri, 12 Nov 2021 14:24:25 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.13.0
MIME-Version: 1.0
In-Reply-To: <20211020123947.2585572-1-narmstrong@baylibre.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 20/10/2021 14:39, Neil Armstrong wrote:
> This serie finnally reworks the drm/meson driver by extracting the encoders
> in their own file and moves to bridge-only callbacks.
> 
> This permits passing the ATTACH_NO_CONNECTOR bridge attach flag and finally
> use the CVBS & HDMI display-connector driver.
> 
> This will ease Martin Blumenstingl writing the HDMI transceiver driver for
> the older Meson8/8b SoCs, and sets the proper architecture for the work in
> progress MIPI-DSI support.
> 
> Finally, this serie will path the way to a removal of the device component
> and use the drmm memory management.
> 
> Changes since v2 at [2]:
>  - patch 1: no changes
>  - patch 2: added martin's ack
>  - patch 3: moved ->enable & ->disable to atomic, added sam's & martin's acks
>  - patch 4: added martin's ack
>  - patch 5: added martin's ack
>  - patch 6: moved ->enable & ->disable to atomic, added martin's ack
> 
> Changes since v1 at [1];
>  - patch 1: added sam's review tag, fixed include order, fixed doc wording
>  - patch 2: added sam's ack tag, switched to dev_dbg()
>  - patch 3: moved mode_set to atomic_enable, removed DRM_DEBUG, fixed include order
>  - patch 4: added sam's ack tag & applied to drm-misc-next
>  - patch 5 & 6: added sam's ack tag
>  - patch 7: added sam's review tag, stopped saving connector, moved mode_set to atomic_enable,
>  	added missing atomic state callbacks, fixed include order, switched to dev_dbg/dev_err
> 
> [1] https://lore.kernel.org/r/20211014152606.2289528-1-narmstrong@baylibre.com
> [2] https://lore.kernel.org/r/20211015141107.2430800-1-narmstrong@baylibre.com
> 
> Neil Armstrong (6):
>   drm/bridge: display-connector: implement bus fmts callbacks
>   drm/meson: remove useless recursive components matching
>   drm/meson: split out encoder from meson_dw_hdmi
>   drm/meson: encoder_hdmi: switch to bridge
>     DRM_BRIDGE_ATTACH_NO_CONNECTOR
>   drm/meson: rename venc_cvbs to encoder_cvbs
>   drm/meson: encoder_cvbs: switch to bridge with ATTACH_NO_CONNECTOR
> 
>  drivers/gpu/drm/bridge/display-connector.c    |  86 ++++
>  drivers/gpu/drm/meson/Kconfig                 |   2 +
>  drivers/gpu/drm/meson/Makefile                |   3 +-
>  drivers/gpu/drm/meson/meson_drv.c             |  71 ++-
>  drivers/gpu/drm/meson/meson_dw_hdmi.c         | 342 +-------------
>  drivers/gpu/drm/meson/meson_encoder_cvbs.c    | 284 +++++++++++
>  ...meson_venc_cvbs.h => meson_encoder_cvbs.h} |   2 +-
>  drivers/gpu/drm/meson/meson_encoder_hdmi.c    | 446 ++++++++++++++++++
>  drivers/gpu/drm/meson/meson_encoder_hdmi.h    |  12 +
>  drivers/gpu/drm/meson/meson_venc_cvbs.c       | 293 ------------
>  10 files changed, 881 insertions(+), 660 deletions(-)
>  create mode 100644 drivers/gpu/drm/meson/meson_encoder_cvbs.c
>  rename drivers/gpu/drm/meson/{meson_venc_cvbs.h => meson_encoder_cvbs.h} (92%)
>  create mode 100644 drivers/gpu/drm/meson/meson_encoder_hdmi.c
>  create mode 100644 drivers/gpu/drm/meson/meson_encoder_hdmi.h
>  delete mode 100644 drivers/gpu/drm/meson/meson_venc_cvbs.c
> 
> 
> base-commit: f6632721cd6231e1bf28b5317dcc7543e43359f7
> 

Applied to drm-misc-next

Now https://lore.kernel.org/all/20211029135947.3022875-1-narmstrong@baylibre.com/ has been applied, we should have no regression.

Neil
