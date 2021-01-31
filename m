Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2AE5B309C73
	for <lists+linux-kernel@lfdr.de>; Sun, 31 Jan 2021 15:03:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231796AbhAaNs0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 31 Jan 2021 08:48:26 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51990 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231464AbhAaLbb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 31 Jan 2021 06:31:31 -0500
Received: from mail-wm1-x335.google.com (mail-wm1-x335.google.com [IPv6:2a00:1450:4864:20::335])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 78528C06178B;
        Sun, 31 Jan 2021 03:29:43 -0800 (PST)
Received: by mail-wm1-x335.google.com with SMTP id m1so7456894wml.2;
        Sun, 31 Jan 2021 03:29:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=XHb9cnox9HkjfJVutQn1daYnX6lfpuc7jeu45/QEfeI=;
        b=EQeHdvxEhoyJe9zcUUy/4MUJFr7xk942ZePSW3M+m4/sZqotS29RG3HdBcEcP1JOnz
         wQ4Ya6LxkaogoTRIFPlBQ3EuyVVEuvnfD2d2pNE3LB8kuITs9n5zz4i/qbxTI47/MC3J
         O5ZwA3QvAGZzaPJ3UmgGVagq/DwjwPMQjz+whLq7tTbDcOHT2JxvrBcNmsCw1ZMXag3h
         xdvh9Nlslmy1Iu6NpKqdj8r17O1lMsb5PoeaylQ7VMLm+dXzQi8nsd7GeHoQ1zDIeqpa
         IQQ4kySEJZLafR7+bzuz6rDegIID4bF9hyEegbodxfMtUeC9SnDbMWomOmFOdiOaF40C
         Fkrg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=XHb9cnox9HkjfJVutQn1daYnX6lfpuc7jeu45/QEfeI=;
        b=CuObOq5KRRBQXrQrQKpToM2MHGEkAbOX0eLYv3HmxUWUFcJo4qykKr7m5kRv0nb1xA
         SNsmHN/X9PftmvyNaZXpZXS2Qvpu/74Ism+KZ3aadRJx4IrQ1WAto3vm7QlBBo6OGJ8y
         sd4CJqyIVlu6UxiZjCwlGqEhDJhG56hV7OiZf6Zty/OS39cZzbSF3Xn5qM1Nxy0zuPbA
         azSyDz5lvAO4gHitucxWw5LEqRHQ/k/GpyrZqg3CKB6enFkLvuVpDX0ukxDfi+rnp4p2
         UxRX5/tLM8o2Sc8nJPm2yFUhfIs2faMxFXbJ4Ar5INF/UlzgTbYLfNgCaweMq89SnzgC
         jCTg==
X-Gm-Message-State: AOAM533Dw5Wrq+yR6vJSfUiKz6T+g378avflbwDBacwvXjQL4lkSpQAW
        xsOZntqBHrv3AXF58Q9vx6E=
X-Google-Smtp-Source: ABdhPJxldbS+DBTdSmlDy0S9DQbm5EfFn+7dzBMcUpRAq1/jcgUEDxeOgVOPME7rz9Liocj4zeWn8g==
X-Received: by 2002:a05:600c:3510:: with SMTP id h16mr10719171wmq.156.1612092582086;
        Sun, 31 Jan 2021 03:29:42 -0800 (PST)
Received: from ziggy.stardust ([213.195.126.134])
        by smtp.gmail.com with ESMTPSA id z18sm22061538wro.91.2021.01.31.03.29.40
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 31 Jan 2021 03:29:41 -0800 (PST)
Subject: Re: [PATCH v13 1/8] arm64: dts: mt8183: rename rdma fifo size
To:     Hsin-Yi Wang <hsinyi@chromium.org>, CK Hu <ck.hu@mediatek.com>,
        Philipp Zabel <p.zabel@pengutronix.de>
Cc:     David Airlie <airlied@linux.ie>, Daniel Vetter <daniel@ffwll.ch>,
        Mark Rutland <mark.rutland@arm.com>,
        dri-devel@lists.freedesktop.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org,
        Yongqiang Niu <yongqiang.niu@mediatek.com>
References: <20210129092209.2584718-1-hsinyi@chromium.org>
 <20210129092209.2584718-2-hsinyi@chromium.org>
From:   Matthias Brugger <matthias.bgg@gmail.com>
Message-ID: <72ebe1a7-a54b-fafc-c58b-05b06d63e210@gmail.com>
Date:   Sun, 31 Jan 2021 12:29:40 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.6.1
MIME-Version: 1.0
In-Reply-To: <20210129092209.2584718-2-hsinyi@chromium.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Hsin-Yi,

On 29/01/2021 10:22, Hsin-Yi Wang wrote:
> From: Yongqiang Niu <yongqiang.niu@mediatek.com>
> 
> property name must include only lowercase and '-'
> 
> Fixes: 91f9c963ce79 ("arm64: dts: mt8183: Add display nodes for MT8183")
> Signed-off-by: Yongqiang Niu <yongqiang.niu@mediatek.com>
> Signed-off-by: Hsin-Yi Wang <hsinyi@chromium.org>
> Reviewed-by: Chun-Kuang Hu <chunkuang.hu@kernel.org>
> Reviewed-by: Enric Balletbo i Serra <enric.balletbo@collabora.com>
> ---

I applied 1/8 and 2/8 already, so please drop them for v14.

Thanks,
Matthias

>  arch/arm64/boot/dts/mediatek/mt8183.dtsi | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/arch/arm64/boot/dts/mediatek/mt8183.dtsi b/arch/arm64/boot/dts/mediatek/mt8183.dtsi
> index 5b782a4769e7e..6c84ccb709af6 100644
> --- a/arch/arm64/boot/dts/mediatek/mt8183.dtsi
> +++ b/arch/arm64/boot/dts/mediatek/mt8183.dtsi
> @@ -1011,7 +1011,7 @@ rdma0: rdma@1400b000 {
>  			clocks = <&mmsys CLK_MM_DISP_RDMA0>;
>  			iommus = <&iommu M4U_PORT_DISP_RDMA0>;
>  			mediatek,larb = <&larb0>;
> -			mediatek,rdma_fifo_size = <5120>;
> +			mediatek,rdma-fifo-size = <5120>;
>  			mediatek,gce-client-reg = <&gce SUBSYS_1400XXXX 0xb000 0x1000>;
>  		};
>  
> @@ -1023,7 +1023,7 @@ rdma1: rdma@1400c000 {
>  			clocks = <&mmsys CLK_MM_DISP_RDMA1>;
>  			iommus = <&iommu M4U_PORT_DISP_RDMA1>;
>  			mediatek,larb = <&larb0>;
> -			mediatek,rdma_fifo_size = <2048>;
> +			mediatek,rdma-fifo-size = <2048>;
>  			mediatek,gce-client-reg = <&gce SUBSYS_1400XXXX 0xc000 0x1000>;
>  		};
>  
> 
