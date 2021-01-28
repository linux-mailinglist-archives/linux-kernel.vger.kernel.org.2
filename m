Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 817F9307B0A
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Jan 2021 17:36:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231148AbhA1Qe0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 28 Jan 2021 11:34:26 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41428 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229786AbhA1Qdt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Jan 2021 11:33:49 -0500
Received: from mail-wr1-x42f.google.com (mail-wr1-x42f.google.com [IPv6:2a00:1450:4864:20::42f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2A4E0C061573;
        Thu, 28 Jan 2021 08:33:09 -0800 (PST)
Received: by mail-wr1-x42f.google.com with SMTP id 6so6046113wri.3;
        Thu, 28 Jan 2021 08:33:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=mS4VbiBmP+TiGI4tqZd3H3wmmFTbUqmfEe4EGj5uZTQ=;
        b=jALa73k4QK4Uy0+5UktdwYg0c7XpKg8EpVst2mobL07iI/od5OxnP30mSDNFqjQTVY
         /1l1XT0nI9+XoMnyTyM/fCLDV5QzyqbDq8o0D68xNu4wQRM1O2ELY5U94tZDQf3Zblj/
         aHYjZjRqjFI6A9KZTBLIhO+viSYci6LYSlOXJbofHlIIO0xfFWu2Bds6P+yR9MPx4CaH
         VblRiCZYw7f7hpxWVFx+7WsP8N13Aew8R2XYRT2mfTKIAKjJlchp58AJuFEctm841hVR
         yMMgZiqpdJmagniZ6mhrDbjVbbMDlNqvMgJ4lqkzL2DbMTMrs9etUdAnHI+SyU+zWJqv
         atgw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=mS4VbiBmP+TiGI4tqZd3H3wmmFTbUqmfEe4EGj5uZTQ=;
        b=kfpvPQf0/RmkLoAYiHEfsibnLrQYB3Gf3rRx9WAsbgiRB5oJ5Xoc6AJIc6mztiMfg2
         Uq3Jwiqri+lEzlLmHKnMZ3kIruCrBPVDuk1zRrNLImRBYN7aZ+So0VeBwnfp8E4WdMb7
         Ailcl6iuabC2sXD+W1EzGg/al2AaZKnfwb7rFcWwSl4l4CfZOK78akNbtd0creZ3nZn7
         WSv5ShPKUGygldyFy8xxQhPhSHqaBuHJ/3bv/WB0X2JbIyOWeA42kVm0wtn1DJ08npC1
         Op46enWUgxEqbpFIIuil9p954KvcXUCUf7/9gLLxDfNe6JLTUEmh1lb+vuJfrq/qkIMv
         50Gg==
X-Gm-Message-State: AOAM531rXMcNyxrz086WeTsOIHmRg3JE4v9iCcfchuZhuZZ4LGf0tzWx
        OARjhgVxZU0a1YNcfpwZg+0=
X-Google-Smtp-Source: ABdhPJzXc7RAcUzkhqmVzI5/o/6zMGEWLiJthw7dPGDuM3HIKgO1NIh8wZNNDVCWgLTJkb2rzY4xcg==
X-Received: by 2002:a5d:4443:: with SMTP id x3mr17870569wrr.409.1611851587974;
        Thu, 28 Jan 2021 08:33:07 -0800 (PST)
Received: from ziggy.stardust ([213.195.126.134])
        by smtp.gmail.com with ESMTPSA id 62sm6630860wmd.34.2021.01.28.08.33.06
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 28 Jan 2021 08:33:07 -0800 (PST)
Subject: Re: [PATCH v12 2/8] arm64: dts: mt8183: refine gamma compatible name
To:     Hsin-Yi Wang <hsinyi@chromium.org>, CK Hu <ck.hu@mediatek.com>,
        Philipp Zabel <p.zabel@pengutronix.de>
Cc:     David Airlie <airlied@linux.ie>, Daniel Vetter <daniel@ffwll.ch>,
        Mark Rutland <mark.rutland@arm.com>,
        dri-devel@lists.freedesktop.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org,
        Yongqiang Niu <yongqiang.niu@mediatek.com>
References: <20210128112314.1304160-1-hsinyi@chromium.org>
 <20210128112314.1304160-3-hsinyi@chromium.org>
From:   Matthias Brugger <matthias.bgg@gmail.com>
Message-ID: <a8d5d947-532c-a9f9-d249-e1a0b246c41a@gmail.com>
Date:   Thu, 28 Jan 2021 17:33:06 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.6.1
MIME-Version: 1.0
In-Reply-To: <20210128112314.1304160-3-hsinyi@chromium.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 28/01/2021 12:23, Hsin-Yi Wang wrote:
> From: Yongqiang Niu <yongqiang.niu@mediatek.com>
> 
> mt8183 gamma is different with mt8173
> remove mt8173 compatible name for mt8183 gamma
> 
> Fixes: 91f9c963ce79 ("arm64: dts: mt8183: Add display nodes for MT8183")
> Signed-off-by: Yongqiang Niu <yongqiang.niu@mediatek.com>
> Signed-off-by: Hsin-Yi Wang <hsinyi@chromium.org>
> Reviewed-by: Enric Balletbo i Serra <enric.balletbo@collabora.com>

Applied to v5.11-next/dts64

Thanks

> ---
>  arch/arm64/boot/dts/mediatek/mt8183.dtsi | 3 +--
>  1 file changed, 1 insertion(+), 2 deletions(-)
> 
> diff --git a/arch/arm64/boot/dts/mediatek/mt8183.dtsi b/arch/arm64/boot/dts/mediatek/mt8183.dtsi
> index 6c84ccb709af6..9c0073cfad452 100644
> --- a/arch/arm64/boot/dts/mediatek/mt8183.dtsi
> +++ b/arch/arm64/boot/dts/mediatek/mt8183.dtsi
> @@ -1055,8 +1055,7 @@ aal0: aal@14010000 {
>  		};
>  
>  		gamma0: gamma@14011000 {
> -			compatible = "mediatek,mt8183-disp-gamma",
> -				     "mediatek,mt8173-disp-gamma";
> +			compatible = "mediatek,mt8183-disp-gamma";
>  			reg = <0 0x14011000 0 0x1000>;
>  			interrupts = <GIC_SPI 234 IRQ_TYPE_LEVEL_LOW>;
>  			power-domains = <&spm MT8183_POWER_DOMAIN_DISP>;
> 
