Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 798FD307B01
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Jan 2021 17:33:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232557AbhA1Qch (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 28 Jan 2021 11:32:37 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41152 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232457AbhA1Qce (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Jan 2021 11:32:34 -0500
Received: from mail-wr1-x431.google.com (mail-wr1-x431.google.com [IPv6:2a00:1450:4864:20::431])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A3FDAC061756;
        Thu, 28 Jan 2021 08:31:53 -0800 (PST)
Received: by mail-wr1-x431.google.com with SMTP id p15so6017589wrq.8;
        Thu, 28 Jan 2021 08:31:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=aB7zuQWcrPzPmAQrvOloCgHrIKsDNj/0Gfzl4leTLYE=;
        b=e5uIsa58hkgWWmUhwaKnmmHmMUqxBkDVk7uZLLwbgjSz2lN4sTUnVWwF1moV9j/Zfm
         9SoMLVIaxYNZCG9mfg/6Frbu3C2JGaXQqMN6L+v+3zyCD+pk6JpVlVSYBhu5O4Xe9OUa
         0ieB3VbXfC/pLsnVtkmY26Vq5jDJkM3FNHnQN9Lz0ywTWglPxoQPT2+TKvizMPwOmUAT
         f0ouhlrpI7UphqCMOrtQTF3xmHtt4oqHX/eBzNg59KoIpx/PI1k1TPNVlnBNpYFCb2jb
         hppBiESlyfW1zUk11ucEBIlEnNnprnXvBmPYkuSsedCk07W0f4bXH25nu+Xdf7/jplag
         bT7Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=aB7zuQWcrPzPmAQrvOloCgHrIKsDNj/0Gfzl4leTLYE=;
        b=gMZNtv9QYoCYu6h/RkY7BWnjVQUm2V3wQdpYj4rDpEZEZ4NsKMvoMGWTnV36oTEW9+
         BHy3sllj7sYqNq9QpYaF3kIk9kMKi6V29MZhiNbAgTo/8AfPDM/+bMfEWAH902KKVVJt
         bs12e8JOYi3w4vgL+pT1xMExXJTe/oOwohGkGOTXCf523hTQl38jYAxIYmqJl7AamGo8
         Nxy84pHsbKPWIR6p6DR9IUhSI7hiRfAw4ibCMYSoi6/VnA5xdQKFzsioqHhGhOoBqIta
         bdCc22PPdphb88wceScolinIOz2mbCzz84OuXFhhpXNXgQpS0V1/ZwcopAu9B56Dz2Jc
         i/Yw==
X-Gm-Message-State: AOAM531wnsuRHKeURjNRhDpzqohhrRqcA9IW5qHaC0hSFBKk3ZHnY2wy
        jt+u4LY4XLX1xuTBhDpIadg=
X-Google-Smtp-Source: ABdhPJwYip4jGo3j1j/kpGaNQKnhSrNc2zFSNPByK826616JOYqRX00Y68OHdP666t5omBXVRS5RQQ==
X-Received: by 2002:adf:e511:: with SMTP id j17mr14390620wrm.17.1611851512379;
        Thu, 28 Jan 2021 08:31:52 -0800 (PST)
Received: from ziggy.stardust ([213.195.126.134])
        by smtp.gmail.com with ESMTPSA id b3sm7439842wme.32.2021.01.28.08.31.51
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 28 Jan 2021 08:31:51 -0800 (PST)
Subject: Re: [PATCH v12 1/8] arm64: dts: mt8183: rename rdma fifo size
To:     Hsin-Yi Wang <hsinyi@chromium.org>, CK Hu <ck.hu@mediatek.com>,
        Philipp Zabel <p.zabel@pengutronix.de>
Cc:     David Airlie <airlied@linux.ie>, Daniel Vetter <daniel@ffwll.ch>,
        Mark Rutland <mark.rutland@arm.com>,
        dri-devel@lists.freedesktop.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org,
        Yongqiang Niu <yongqiang.niu@mediatek.com>
References: <20210128112314.1304160-1-hsinyi@chromium.org>
 <20210128112314.1304160-2-hsinyi@chromium.org>
From:   Matthias Brugger <matthias.bgg@gmail.com>
Message-ID: <5eec39ff-de13-a749-d8c2-f2426e9565ed@gmail.com>
Date:   Thu, 28 Jan 2021 17:31:49 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.6.1
MIME-Version: 1.0
In-Reply-To: <20210128112314.1304160-2-hsinyi@chromium.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 28/01/2021 12:23, Hsin-Yi Wang wrote:
> From: Yongqiang Niu <yongqiang.niu@mediatek.com>
> 
> property name must include only lowercase and '-'
> 
> Fixes: 91f9c963ce79 ("arm64: dts: mt8183: Add display nodes for MT8183")
> Signed-off-by: Yongqiang Niu <yongqiang.niu@mediatek.com>
> Signed-off-by: Hsin-Yi Wang <hsinyi@chromium.org>
> Reviewed-by: Chun-Kuang Hu <chunkuang.hu@kernel.org>
> Reviewed-by: Enric Balletbo i Serra <enric.balletbo@collabora.com>

Applied to v5.11-next/dts64

Thanks

> ---
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
