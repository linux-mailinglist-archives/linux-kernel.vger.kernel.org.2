Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C4F83361ADC
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Apr 2021 09:55:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239733AbhDPHwN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 16 Apr 2021 03:52:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39418 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231898AbhDPHwL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 16 Apr 2021 03:52:11 -0400
Received: from mail-ot1-x336.google.com (mail-ot1-x336.google.com [IPv6:2607:f8b0:4864:20::336])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E1763C061574;
        Fri, 16 Apr 2021 00:51:45 -0700 (PDT)
Received: by mail-ot1-x336.google.com with SMTP id t17-20020a9d77510000b0290287a5143b41so13766333otl.11;
        Fri, 16 Apr 2021 00:51:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=4GwvUVkQCAs0X/UNyX5pEqeUO1WdFhB1WSpRysQPPC8=;
        b=ljbOw4dWBTZwCsHaMq0PZ/dctFokBT9dSEg2Wl9dz4QOE/hP5GrAF7ZL0ZQ4nIWc8p
         GVNXrKAVueX8JdkY0wN5dOt/vg+Pwddybkab8HfeqAP261sEeE2sAmenIg40VaJTjcig
         oSle/efFKv/StjK8RCTDswW3fIE/7aevPjOyy3SRIyZHSCfGfa48bUZeDSsPho0+yf/C
         KJffQXuM2WgS4rHZjFHx/PuevLB1Uh5GtieZBbhwtml2KBFZfjR+UFEvz7NvlGj2e9L6
         5wgZj4WxOYKw+IGwDwX7RkHD5EKlqbUBkIEgXLzvpqUK4LJ2ABhx0TwshlSdPyId4UUz
         W7Lw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=4GwvUVkQCAs0X/UNyX5pEqeUO1WdFhB1WSpRysQPPC8=;
        b=OpvpMDGksbRTiYlQyglT5njGAdJA3SsSpdoDOT2MEttRR/eCMcr7ujLALrl8M0wHau
         q3oDWDAdntS1klmOjgEJQedOR+f2HsHhl+i5CosWjTqUBUHtDgoQgqFUbAguJ23FEE5J
         df7rX98dxfTUG6plU+ExqYGhjy25dGAvopCijpEBtHBqu9yF/l0tZ9uQm/U8oz9956L8
         6/4b6S+2Notskq6oEQak+TPrWgQW7XL4smccdCkw3y0Y8GFBvVfdmTJ7hsow6tLBdz7c
         LFZX/ytlyUOYh0FtrATCe9s+de7KHmZsJpk3t5+D0ehr3h6RMfEgsc50xZbSI6BIEJha
         EdEA==
X-Gm-Message-State: AOAM532JXCONRIslecr7pFxS1y6dVs8TD+PmmzpNRFDokWESYSR5VdF2
        1d29l3hYdcGs8MhvJRMkAvJ07m9DW8lhKgIJRu0=
X-Google-Smtp-Source: ABdhPJx2zqCjdlBGHxyj00xydr3ubb35ShJaQk8s7sLVXgo86SVvtyMsx4K2PWJIMxLsD/RDwg4wOFQmAlPFoFPd/hE=
X-Received: by 2002:a05:6830:1398:: with SMTP id d24mr2808423otq.281.1618559505373;
 Fri, 16 Apr 2021 00:51:45 -0700 (PDT)
MIME-Version: 1.0
References: <1618236288-1617-1-git-send-email-yongqiang.niu@mediatek.com> <1618236288-1617-3-git-send-email-yongqiang.niu@mediatek.com>
In-Reply-To: <1618236288-1617-3-git-send-email-yongqiang.niu@mediatek.com>
From:   Enric Balletbo Serra <eballetbo@gmail.com>
Date:   Fri, 16 Apr 2021 09:51:36 +0200
Message-ID: <CAFqH_50kRmQLukyRERwtRGErETuKP8jry9+oG1CSX+=-Ckz7gw@mail.gmail.com>
Subject: Re: [PATCH v5, 2/4] soc: mediatek: mmsys: add component POSTMASK
To:     Yongqiang Niu <yongqiang.niu@mediatek.com>
Cc:     Chun-Kuang Hu <chunkuang.hu@kernel.org>,
        devicetree <devicetree@vger.kernel.org>,
        Project_Global_Chrome_Upstream_Group@mediatek.com,
        David Airlie <airlied@linux.ie>,
        Jassi Brar <jassisinghbrar@gmail.com>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        dri-devel <dri-devel@lists.freedesktop.org>,
        Dennis YC Hsieh <dennis-yc.hsieh@mediatek.com>,
        Fabien Parent <fparent@baylibre.com>,
        Rob Herring <robh+dt@kernel.org>,
        "moderated list:ARM/Mediatek SoC support" 
        <linux-mediatek@lists.infradead.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Yongqiang,

Thank you for your patch.

Missatge de Yongqiang Niu <yongqiang.niu@mediatek.com> del dia dl., 12
d=E2=80=99abr. 2021 a les 16:05:
>
> This patch add component POSTMASK
>
> Signed-off-by: Yongqiang Niu <yongqiang.niu@mediatek.com>

Reviewed-by: Enric Balletbo i Serra <enric.balletbo@collabora.com>

> ---
>  include/linux/soc/mediatek/mtk-mmsys.h | 1 +
>  1 file changed, 1 insertion(+)
>
> diff --git a/include/linux/soc/mediatek/mtk-mmsys.h b/include/linux/soc/m=
ediatek/mtk-mmsys.h
> index f6b58f9..7718cd6 100644
> --- a/include/linux/soc/mediatek/mtk-mmsys.h
> +++ b/include/linux/soc/mediatek/mtk-mmsys.h
> @@ -31,6 +31,7 @@ enum mtk_ddp_comp_id {
>         DDP_COMPONENT_OVL_2L1,
>         DDP_COMPONENT_OVL_2L2,
>         DDP_COMPONENT_OVL1,
> +       DDP_COMPONENT_POSTMASK0,
>         DDP_COMPONENT_PWM0,
>         DDP_COMPONENT_PWM1,
>         DDP_COMPONENT_PWM2,
> --
> 1.8.1.1.dirty
>
> _______________________________________________
> dri-devel mailing list
> dri-devel@lists.freedesktop.org
> https://lists.freedesktop.org/mailman/listinfo/dri-devel
