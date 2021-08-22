Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 52DB03F41E6
	for <lists+linux-kernel@lfdr.de>; Mon, 23 Aug 2021 00:19:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233707AbhHVWTz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 22 Aug 2021 18:19:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36142 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229700AbhHVWTx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 22 Aug 2021 18:19:53 -0400
Received: from mail-wm1-x333.google.com (mail-wm1-x333.google.com [IPv6:2a00:1450:4864:20::333])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5A7CEC061575;
        Sun, 22 Aug 2021 15:19:11 -0700 (PDT)
Received: by mail-wm1-x333.google.com with SMTP id l7-20020a1c2507000000b002e6be5d86b3so9507277wml.3;
        Sun, 22 Aug 2021 15:19:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-transfer-encoding:content-language;
        bh=jJbzfY3J31R5QWngmUYeYdxzeAtmKFvE5F0hxn4JZuI=;
        b=sonh4OKDkUqZNnBP91jhGurw0kgke3bYqK9Sjul2Wzfk8CpUqPve9bnZ7/+RiZSdbu
         ZmaMe+NVxKkmgoEzouc38aCj5pncNk2zwLTWpI5P67byViKHD8nws9sBuwUWzbs8R77L
         9dLHo1lT4p48+DUXX3RKNu9n77//pZAIcAFBQt43+wOexac4XBmF1QBEQBXb984RtCa3
         +2Prgxm/EokCE68P/QHbeX4fcjUqs0kDYKW2I52GxeHIb6okDYf5eKSjsFSA63vaWwu6
         h1zaCwRV1KNKb60+5N2ye6U3VLVWMgFYc/uAjc3PcfqgeSiJImoxy5CAUOIqicek0kir
         AnMQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding
         :content-language;
        bh=jJbzfY3J31R5QWngmUYeYdxzeAtmKFvE5F0hxn4JZuI=;
        b=DRal7leeeyT535fkxnge3juSebx2SkWToemCD65x4soY9GvAmhSyE7ioGtcvY8d7Y5
         iiMJ8VT+ULtuH7terwVXuqKPz7fvHMxuo1Lqy0baqaop0xFGt7ygjTmgsmoaUS0oKbg2
         2ZX+ujL6Wa4F3SExD2GCt4KuGNwWs25JNTT1jGmCpevkq8yBV36Czz3Tc2xgXQGHFocq
         5p4oEyltlCIp4+zLEaEotfABXTJariWGtYB4QxiOxS3f+y8GtqsUS41+F0nMRqQdp4AQ
         lCqJOzUjxsREUFOikYSecL7KXEAdw8Si3kef1zKcW7x/Z5pcLNc+8KqSkeFiBXORyHl1
         ph+A==
X-Gm-Message-State: AOAM530odxThVM0te7L3SbpjQZlz0NfrcuK+DnTGmXv444UML1Xa5yyp
        FH9D8bJkkEfA9rcXvQYTr5oHIWZMqzUj
X-Google-Smtp-Source: ABdhPJxcen/OdScVUcs9fnwQHzsoIRW2aHmR54BIsCLT/Rsr70uMcDOnDYMgt9qCNcHfrYeLo+WTwg==
X-Received: by 2002:a1c:f414:: with SMTP id z20mr13752100wma.94.1629670749888;
        Sun, 22 Aug 2021 15:19:09 -0700 (PDT)
Received: from ?IPv6:2a02:810b:f40:4200:f3bc:8bd1:bbc3:e753? ([2a02:810b:f40:4200:f3bc:8bd1:bbc3:e753])
        by smtp.gmail.com with ESMTPSA id d8sm12881848wrx.12.2021.08.22.15.19.09
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 22 Aug 2021 15:19:09 -0700 (PDT)
Subject: Re: [PATCH] arm64: dts: rockchip: Fix GPU register width for RK3328
To:     Heiko Stuebner <heiko@sntech.de>
Cc:     Rob Herring <robh+dt@kernel.org>, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-rockchip@lists.infradead.org, linux-kernel@vger.kernel.org
References: <20210623115926.164861-1-knaerzche@gmail.com>
From:   Alex Bee <knaerzche@gmail.com>
Message-ID: <c586d864-994f-2d24-9b29-2933b567be84@gmail.com>
Date:   Mon, 23 Aug 2021 00:19:08 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
MIME-Version: 1.0
In-Reply-To: <20210623115926.164861-1-knaerzche@gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Heiko,

is there anything left to do for this one?

Same for:

https://patchwork.kernel.org/project/linux-rockchip/patch/20210623145918.187018-1-knaerzche@gmail.com/

and

https://patchwork.kernel.org/project/linux-rockchip/patch/20210623150208.187201-1-knaerzche@gmail.com/

Alex

Am 23.06.21 um 13:59 schrieb Alex Bee:
> As can be seen in RK3328's TRM the register range for the GPU is
> 0xff300000 to 0xff330000.
> It would (and does in vendor kernel) overlap with the registers of
> the HEVC encoder (node/driver do not exist yet in upstream kernel).
> See already existing h265e_mmu node.
>
> Fixes: 752fbc0c8da7 ("arm64: dts: rockchip: add rk3328 mali gpu node")
> Signed-off-by: Alex Bee <knaerzche@gmail.com>
> ---
>   arch/arm64/boot/dts/rockchip/rk3328.dtsi | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/arch/arm64/boot/dts/rockchip/rk3328.dtsi b/arch/arm64/boot/dts/rockchip/rk3328.dtsi
> index 8c821acb21ff..da84be6f4715 100644
> --- a/arch/arm64/boot/dts/rockchip/rk3328.dtsi
> +++ b/arch/arm64/boot/dts/rockchip/rk3328.dtsi
> @@ -599,7 +599,7 @@ saradc: adc@ff280000 {
>   
>   	gpu: gpu@ff300000 {
>   		compatible = "rockchip,rk3328-mali", "arm,mali-450";
> -		reg = <0x0 0xff300000 0x0 0x40000>;
> +		reg = <0x0 0xff300000 0x0 0x30000>;
>   		interrupts = <GIC_SPI 90 IRQ_TYPE_LEVEL_HIGH>,
>   			     <GIC_SPI 87 IRQ_TYPE_LEVEL_HIGH>,
>   			     <GIC_SPI 93 IRQ_TYPE_LEVEL_HIGH>,
