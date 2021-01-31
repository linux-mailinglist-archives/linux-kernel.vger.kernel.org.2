Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D476E309C5F
	for <lists+linux-kernel@lfdr.de>; Sun, 31 Jan 2021 14:46:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232614AbhAaNjb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 31 Jan 2021 08:39:31 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54710 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231562AbhAaLoN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 31 Jan 2021 06:44:13 -0500
Received: from mail-wm1-x331.google.com (mail-wm1-x331.google.com [IPv6:2a00:1450:4864:20::331])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AA700C061573;
        Sun, 31 Jan 2021 03:42:26 -0800 (PST)
Received: by mail-wm1-x331.google.com with SMTP id m2so10239294wmm.1;
        Sun, 31 Jan 2021 03:42:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=to:cc:references:from:subject:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=IlbddDvBgM9r9BSAbx+bNAwgIIR/5LpoWexAqHTbNlc=;
        b=ubnlzceEIjpMwtIMZlWj/gvfGu+hgitokmhXO8nK5+Yp3g4ZZU1zVf7TTGsx5CmMkc
         7TMlOCxor8/YP2R8t6AF1X+dQ8TmajLa2qXKbLELGqvHPEW9cPf79VD5sn5rL3PlQIK7
         z28WAZUI/0O+HyN3amZVQ4yzKcMcHExnC5iiPzxKe2z7VNtw1tDo24ssLsZJgi/r656q
         /ipAIbnx/a4LYbLGIMxo18Ig1YqsoA/PuvaPKBxOzrvbqQMXguS5YDft2qHq3MQP0fTx
         vYFeZOCpPhA17Q7F3w6sVactQORrmI2KAbpteaTvKn+OJeSa2vnvB3Y5RcNxjIVg9RHe
         s5NA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:to:cc:references:from:subject:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=IlbddDvBgM9r9BSAbx+bNAwgIIR/5LpoWexAqHTbNlc=;
        b=gRCARwJiWGaxjza2VusHG+EALoF9aIXf+IgZjo0EpYFxBLK4c6OliuUkGj53aJtwFf
         L93/p+uFb1oVVGbV6vGz333iHWs+Dz+NOegBOAb/XM0FJd6f8F9jKTvhjwnBhg19JMwZ
         jMm9FJoSndvHt37UCkfB/sOm3oILWY4XTr1E7RJqMq9afD+IA9+dcSXzRGwFfVr9e/8s
         4legON0bb2jdtrzSezxXu6jI+Eq7pUKJZp0jBtcvoiaJ7zjxQgChlwaDCLofWianKAFJ
         OGk2br+xmdl5gppWKPO35skCqh6JAQ0EX1Zop4uW7ugCPA/XLOkYwgkH/9XtFgllgQ4j
         x8mA==
X-Gm-Message-State: AOAM530MShsC0uzzJ9g7/ONTOW5S4U8akjocrHU4TUOy3TRQeSxv1Hx9
        WJyBNkOfa1u9lj0HGVd0QDA=
X-Google-Smtp-Source: ABdhPJyTnZc6n0hZInkXxcAeRNV6DTSQMIMH9BUJ4r7MGmhHKROXEFwCyX/RRWAVGtU65TkuzHbV8w==
X-Received: by 2002:a1c:3286:: with SMTP id y128mr10801903wmy.104.1612093345278;
        Sun, 31 Jan 2021 03:42:25 -0800 (PST)
Received: from ziggy.stardust ([213.195.126.134])
        by smtp.gmail.com with ESMTPSA id i8sm23952003wry.90.2021.01.31.03.42.24
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 31 Jan 2021 03:42:24 -0800 (PST)
To:     Hsin-Yi Wang <hsinyi@chromium.org>, CK Hu <ck.hu@mediatek.com>,
        Philipp Zabel <p.zabel@pengutronix.de>
Cc:     David Airlie <airlied@linux.ie>, Daniel Vetter <daniel@ffwll.ch>,
        Mark Rutland <mark.rutland@arm.com>,
        dri-devel@lists.freedesktop.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org,
        Yongqiang Niu <yongqiang.niu@mediatek.com>
References: <20210129092209.2584718-1-hsinyi@chromium.org>
From:   Matthias Brugger <matthias.bgg@gmail.com>
Subject: Re: [PATCH v13 0/8] drm/mediatek: add support for mediatek SOC MT8183
Message-ID: <19742b84-abf1-c308-315e-c117531ed439@gmail.com>
Date:   Sun, 31 Jan 2021 12:42:23 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.6.1
MIME-Version: 1.0
In-Reply-To: <20210129092209.2584718-1-hsinyi@chromium.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 29/01/2021 10:22, Hsin-Yi Wang wrote:
> This series is based on kernel/git/chunkuang.hu/linux.git mediatek-drm-next
> The series is tested on a mt8183 krane device.
> 
> Change since v12
> - fix mtk_dither_config
> 
> Change since v10, v11
> - fix review comments in v9
> 
> Change since v9
> - change several function to rebase to mediatek-drm-next
> 
> Change since v8
> - fix some review comment in v8
> - separate gamma module for mt8183 has no dither function in gamma
> - enable dither function for 5 or 6 bpc panel display
> - separate ddp mutex patch from the whole Soc patch
> 
> Change since v7
> - add dt-binding for mt8183 display
> - base mmsys patch
> https://patchwork.kernel.org/project/linux-mediatek/cover/1607506379-10998-1-git-send-email-yongqiang.niu@mediatek.com/
> - base dts patch
> https://patchwork.kernel.org/project/linux-mediatek/cover/20201127104930.1981497-1-enric.balletbo@collabora.com/

These are already upstream since v5.11, right?

Please drop reference in further versions, it confused me :)

Regards,
Matthias

> - add mt8183 function call for setting the routing registers
> - add RDMA fifo size error handle
> 
> Change since v6
> - move ddp component define into mtk_mmsys.h
> - add mmsys private data to support different ic path connection
> - add mt8183-mmsys.c to support 8183 path connection
> - fix reviewed issue in v6
> 
> Change since v5
> - fix reviewed issue in v5
> base https://patchwork.kernel.org/project/linux-mediatek/list/?series=213219
> 
> Change since v4
> - fix reviewed issue in v4
> 
> Change since v3
> - fix reviewed issue in v3
> - fix type error in v3
> - fix conflict with iommu patch
> 
> Change since v2
> - fix reviewed issue in v2
> - add mutex node into dts file
> 
> Changes since v1:
> - fix reviewed issue in v1
> - add dts for mt8183 display nodes
> - adjust display clock control flow in patch 22
> - add vmap support for mediatek drm in patch 23
> - fix page offset issue for mmap function in patch 24
> - enable allow_fb_modifiers for mediatek drm in patch 25
> 
> Hsin-Yi Wang (1):
>   drm/mediatek: add mtk_dither_set_common() function
> 
> Yongqiang Niu (7):
>   arm64: dts: mt8183: rename rdma fifo size
>   arm64: dts: mt8183: refine gamma compatible name
>   drm/mediatek: separate gamma module
>   drm/mediatek: add has_dither private data for gamma
>   drm/mediatek: enable dither function
>   soc: mediatek: add mtk mutex support for MT8183
>   drm/mediatek: add support for mediatek SOC MT8183
> 
>  arch/arm64/boot/dts/mediatek/mt8183.dtsi    |   7 +-
>  drivers/gpu/drm/mediatek/Makefile           |   1 +
>  drivers/gpu/drm/mediatek/mtk_disp_drv.h     |  14 ++
>  drivers/gpu/drm/mediatek/mtk_disp_gamma.c   | 198 ++++++++++++++++++++
>  drivers/gpu/drm/mediatek/mtk_disp_ovl.c     |  18 ++
>  drivers/gpu/drm/mediatek/mtk_disp_rdma.c    |   6 +
>  drivers/gpu/drm/mediatek/mtk_drm_ddp_comp.c | 111 ++++-------
>  drivers/gpu/drm/mediatek/mtk_drm_drv.c      |  49 ++++-
>  drivers/gpu/drm/mediatek/mtk_drm_drv.h      |   1 +
>  drivers/soc/mediatek/mtk-mutex.c            |  50 +++++
>  10 files changed, 379 insertions(+), 76 deletions(-)
>  create mode 100644 drivers/gpu/drm/mediatek/mtk_disp_gamma.c
> 
