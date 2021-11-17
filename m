Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 12772454BA8
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Nov 2021 18:09:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239112AbhKQRMn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 17 Nov 2021 12:12:43 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37714 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233179AbhKQRMl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 Nov 2021 12:12:41 -0500
Received: from mail-wm1-x332.google.com (mail-wm1-x332.google.com [IPv6:2a00:1450:4864:20::332])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E3B0BC061570;
        Wed, 17 Nov 2021 09:09:42 -0800 (PST)
Received: by mail-wm1-x332.google.com with SMTP id k37-20020a05600c1ca500b00330cb84834fso5370056wms.2;
        Wed, 17 Nov 2021 09:09:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=0B+N0FA61IWnA1l5AfQzrBop1ZHsqAbfOO+sgyYzC58=;
        b=Ks1SXb180c0C9y2x2MA1wxqwqNhxfF1eIbBVXQ/pLIUBawraenmhHjlLtFqYaP5rRM
         JD99zoH+3g8POKfTifx0n5M9w/xP9atLflYx35pxWWgJzIcz9Ll4qhRRDSHODLp36Tte
         ztIbX8l0EsVjCP7get9NWkhCrC8fkXfYz/yRWEz/C7M8oOOnleGUUMwiep+6unGy6Lok
         j6e8qtJKTanvbHhlgdguDdZXc3hTYNVDjRlYLFxtIdilrFj2Vf4QiO4A8bBrq56mm6wR
         +4uV01kPmJhbAtICFVFWMOPdOL2/uCbbKJdkztnSBCb0+Dy3zAppcdWqKWeV3ZcCNazr
         KmFA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=0B+N0FA61IWnA1l5AfQzrBop1ZHsqAbfOO+sgyYzC58=;
        b=bEgONa681ED8RQZlD92zS5vmr1SZ3vhsT331o4FylhTyLd5Dd/A27iKOzjUMwSKdq2
         k8rHwexs/Y+WTxqKi+P1wGB1dG7H1LkWVPXNEhZcE0XdY9cijaV4mbbRBZBIE0zsBuzt
         Bo2Zv6N5DzaDswwtZX7O+DaHKFHzvOchZnvsTVnlDntChZpSEeL98ZYXFugXXqdR2K9N
         K5DlnzRW4hVPSdIgYOjadJFE1kUCwI8TuizNVFuPMq3BDLOKbfssWRC/6sw8qSctOJIy
         nl0KhPIEx317YPJe3KmkVH5kX8/z8A5rjM9hisKp0SpRTTp3Qd8i7I/EJkVieVi/x/Zu
         WEbA==
X-Gm-Message-State: AOAM530no5cNDwbKFZPv+1SS5qc5IFJaFE1YtY2iYfdL7ltTGIlXYdDN
        tPFvkSqvED/TiWwVN7jtMP0QkER6o4w=
X-Google-Smtp-Source: ABdhPJxGcBEQhtQFfbKcOJuuOam7iLbD22APsVdCohpJtRkkAnBdMxBD3SvwJTW07cLtCktLxwczaw==
X-Received: by 2002:a7b:ce8c:: with SMTP id q12mr1396307wmj.91.1637168981409;
        Wed, 17 Nov 2021 09:09:41 -0800 (PST)
Received: from [192.168.0.18] (static-160-219-86-188.ipcom.comunitel.net. [188.86.219.160])
        by smtp.gmail.com with ESMTPSA id m17sm432110wrz.22.2021.11.17.09.09.40
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 17 Nov 2021 09:09:40 -0800 (PST)
Message-ID: <acf4a474-7abf-49e5-aa4e-a25d101fb3d8@gmail.com>
Date:   Wed, 17 Nov 2021 18:09:39 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.2.0
Subject: Re: [PATCH v3 4/4] arm64: dts: mediatek: mt8192: fix i2c node names
Content-Language: en-US
To:     Fabien Parent <fparent@baylibre.com>,
        Rob Herring <robh+dt@kernel.org>
Cc:     devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, linux-kernel@vger.kernel.org
References: <20211110194959.20611-1-fparent@baylibre.com>
 <20211110194959.20611-4-fparent@baylibre.com>
From:   Matthias Brugger <matthias.bgg@gmail.com>
In-Reply-To: <20211110194959.20611-4-fparent@baylibre.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 10/11/2021 20:49, Fabien Parent wrote:
> Fix the i2c node names to be compliant to the YAML schema. The
> I2C node name should match the following pattern: "^i2c@[0-9a-f]+$".
> 
> Signed-off-by: Fabien Parent <fparent@baylibre.com>

Applied to v5.16-next/dts64

Thanks

> ---
> 
> v3: rebased
> v2: new patch
> 
>   arch/arm64/boot/dts/mediatek/mt8192.dtsi | 20 ++++++++++----------
>   1 file changed, 10 insertions(+), 10 deletions(-)
> 
> diff --git a/arch/arm64/boot/dts/mediatek/mt8192.dtsi b/arch/arm64/boot/dts/mediatek/mt8192.dtsi
> index c7c7d4e017ae..53d790c335f9 100644
> --- a/arch/arm64/boot/dts/mediatek/mt8192.dtsi
> +++ b/arch/arm64/boot/dts/mediatek/mt8192.dtsi
> @@ -479,7 +479,7 @@ audsys: clock-controller@11210000 {
>   			#clock-cells = <1>;
>   		};
>   
> -		i2c3: i2c3@11cb0000 {
> +		i2c3: i2c@11cb0000 {
>   			compatible = "mediatek,mt8192-i2c";
>   			reg = <0 0x11cb0000 0 0x1000>,
>   			      <0 0x10217300 0 0x80>;
> @@ -498,7 +498,7 @@ imp_iic_wrap_e: clock-controller@11cb1000 {
>   			#clock-cells = <1>;
>   		};
>   
> -		i2c7: i2c7@11d00000 {
> +		i2c7: i2c@11d00000 {
>   			compatible = "mediatek,mt8192-i2c";
>   			reg = <0 0x11d00000 0 0x1000>,
>   			      <0 0x10217600 0 0x180>;
> @@ -511,7 +511,7 @@ i2c7: i2c7@11d00000 {
>   			status = "disabled";
>   		};
>   
> -		i2c8: i2c8@11d01000 {
> +		i2c8: i2c@11d01000 {
>   			compatible = "mediatek,mt8192-i2c";
>   			reg = <0 0x11d01000 0 0x1000>,
>   			      <0 0x10217780 0 0x180>;
> @@ -524,7 +524,7 @@ i2c8: i2c8@11d01000 {
>   			status = "disabled";
>   		};
>   
> -		i2c9: i2c9@11d02000 {
> +		i2c9: i2c@11d02000 {
>   			compatible = "mediatek,mt8192-i2c";
>   			reg = <0 0x11d02000 0 0x1000>,
>   			      <0 0x10217900 0 0x180>;
> @@ -543,7 +543,7 @@ imp_iic_wrap_s: clock-controller@11d03000 {
>   			#clock-cells = <1>;
>   		};
>   
> -		i2c1: i2c1@11d20000 {
> +		i2c1: i2c@11d20000 {
>   			compatible = "mediatek,mt8192-i2c";
>   			reg = <0 0x11d20000 0 0x1000>,
>   			      <0 0x10217100 0 0x80>;
> @@ -556,7 +556,7 @@ i2c1: i2c1@11d20000 {
>   			status = "disabled";
>   		};
>   
> -		i2c2: i2c2@11d21000 {
> +		i2c2: i2c@11d21000 {
>   			compatible = "mediatek,mt8192-i2c";
>   			reg = <0 0x11d21000 0 0x1000>,
>   			      <0 0x10217180 0 0x180>;
> @@ -569,7 +569,7 @@ i2c2: i2c2@11d21000 {
>   			status = "disabled";
>   		};
>   
> -		i2c4: i2c4@11d22000 {
> +		i2c4: i2c@11d22000 {
>   			compatible = "mediatek,mt8192-i2c";
>   			reg = <0 0x11d22000 0 0x1000>,
>   			      <0 0x10217380 0 0x180>;
> @@ -588,7 +588,7 @@ imp_iic_wrap_ws: clock-controller@11d23000 {
>   			#clock-cells = <1>;
>   		};
>   
> -		i2c5: i2c5@11e00000 {
> +		i2c5: i2c@11e00000 {
>   			compatible = "mediatek,mt8192-i2c";
>   			reg = <0 0x11e00000 0 0x1000>,
>   			      <0 0x10217500 0 0x80>;
> @@ -607,7 +607,7 @@ imp_iic_wrap_w: clock-controller@11e01000 {
>   			#clock-cells = <1>;
>   		};
>   
> -		i2c0: i2c0@11f00000 {
> +		i2c0: i2c@11f00000 {
>   			compatible = "mediatek,mt8192-i2c";
>   			reg = <0 0x11f00000 0 0x1000>,
>   			      <0 0x10217080 0 0x80>;
> @@ -620,7 +620,7 @@ i2c0: i2c0@11f00000 {
>   			status = "disabled";
>   		};
>   
> -		i2c6: i2c6@11f01000 {
> +		i2c6: i2c@11f01000 {
>   			compatible = "mediatek,mt8192-i2c";
>   			reg = <0 0x11f01000 0 0x1000>,
>   			      <0 0x10217580 0 0x80>;
> 
