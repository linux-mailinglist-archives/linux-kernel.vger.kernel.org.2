Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DD99C40B93E
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Sep 2021 22:26:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233749AbhINU2N (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 14 Sep 2021 16:28:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38660 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232909AbhINU2L (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Sep 2021 16:28:11 -0400
Received: from mail-ej1-x635.google.com (mail-ej1-x635.google.com [IPv6:2a00:1450:4864:20::635])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F21D3C061574;
        Tue, 14 Sep 2021 13:26:53 -0700 (PDT)
Received: by mail-ej1-x635.google.com with SMTP id jg16so1167806ejc.1;
        Tue, 14 Sep 2021 13:26:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=Ny9V3/mCs1gXy/RCoJNt43WdA8dbZAMsrJUkH0JBUJY=;
        b=NkdKj97ea/mAtodeeaU63NlQQwyU5y1/jGRGOH8nhiK9E/uk5WFP+LiSdeEnbatGDa
         8Cvu2QhaX9f57Y8Sb/bLsAznlks6mSmlKqPdHLYnFbTdNqQ5ho2TAC3Fi1x/wpiyZqKH
         0iXZE5ldX7i/ebGW+L4Q3GzFLcCyUj2mzKkjE8zuh6gdVwGSvQOqb/Ko8PLxaehfvRLy
         qkbFAtPW4Mfuu3xZ96IEDdBSZvK3nTCSNNeupYlSmjW84oJRnbpTcmiIdiH/tC5OYFZL
         59tVcwCmrCX1QIyWoyMl4W74LGOxoEgBDsk9Ql7eDv9Q5Cv3OBgsgMQYT8prOkgK3M97
         DFOg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=Ny9V3/mCs1gXy/RCoJNt43WdA8dbZAMsrJUkH0JBUJY=;
        b=HtZTIK+0L1VmL/IOBchITe1A7uzi/NeUrB1jJy0Qreann+tZJH4noe6hTOvRyyAPCu
         SSc7nJ+bXDanljI9nENPydCk0sjGR9p/gAMA/9D3gx5fbXAlghjLbdenQMZu/74iq55b
         HYhsjnESzP467mSg4sii/3CNt2Fd0Pyjd+7shumiZX9dQwKNEz3yzfUVOjX/TYceJrZb
         hhmYtNI9r0lf1Cu89qihSjcJP4a3n0pImZJQOMVIdiV1Q9ZWO5/5Y++tI7NUGtbMYe+C
         UU8CDDpm8O2ducDBv+prlsztnjbczDkyDXgM1YA5fU1Qvzk3WX6ng7l+Y9+6vqIjnDKq
         Z+Zw==
X-Gm-Message-State: AOAM5334O1TbkXdmcvL+ywuWlbIRkn2+avhjhgtJVi45NGUV7nYLXhgl
        lZmez1kZAHxdfmCTNeE7Whc=
X-Google-Smtp-Source: ABdhPJzx2FUqHRpbL4wRfDRv1SBt2WsH8dhPqtgeJpH2RsP4C2x1Ad9tyzm7idxgezXB6udMRenyjw==
X-Received: by 2002:a17:906:cc57:: with SMTP id mm23mr20825666ejb.540.1631651212574;
        Tue, 14 Sep 2021 13:26:52 -0700 (PDT)
Received: from kista.localnet (cpe-86-58-29-253.static.triera.net. [86.58.29.253])
        by smtp.gmail.com with ESMTPSA id g10sm5327677ejj.44.2021.09.14.13.26.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 14 Sep 2021 13:26:52 -0700 (PDT)
From:   Jernej =?utf-8?B?xaBrcmFiZWM=?= <jernej.skrabec@gmail.com>
To:     Dang Huynh <danct12@disroot.org>
Cc:     danct12@disroot.org, Rob Herring <robh+dt@kernel.org>,
        Maxime Ripard <mripard@kernel.org>,
        Chen-Yu Tsai <wens@csie.org>, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-sunxi@lists.linux.dev,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] arm64: dts: allwinner: pinetab: Add HDMI support
Date:   Tue, 14 Sep 2021 22:26:51 +0200
Message-ID: <2558517.IGp7HM5rsX@kista>
In-Reply-To: <20210914193732.3047668-1-danct12@disroot.org>
References: <20210914193732.3047668-1-danct12@disroot.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

Dne torek, 14. september 2021 ob 21:37:32 CEST je Dang Huynh napisal(a):
> This patch enables HDMI display on PINE64 PineTab.
> 
> The PineTab has a HDMI Type C (mini) port.
> 
> Signed-off-by: Dang Huynh <danct12@disroot.org>
> ---
>  .../boot/dts/allwinner/sun50i-a64-pinetab.dts | 26 +++++++++++++++++++
>  1 file changed, 26 insertions(+)
> 
> diff --git a/arch/arm64/boot/dts/allwinner/sun50i-a64-pinetab.dts b/arch/
arm64/boot/dts/allwinner/sun50i-a64-pinetab.dts
> index 6a4af14718f5..adb0b28b06d8 100644
> --- a/arch/arm64/boot/dts/allwinner/sun50i-a64-pinetab.dts
> +++ b/arch/arm64/boot/dts/allwinner/sun50i-a64-pinetab.dts
> @@ -35,6 +35,17 @@ chosen {
>  		stdout-path = "serial0:115200n8";
>  	};
>  
> +	hdmi-connector {
> +		compatible = "hdmi-connector";
> +		type = "c";
> +
> +		port {
> +			hdmi_con_in: endpoint {
> +				remote-endpoint = <&hdmi_out_con>;
> +			};
> +		};
> +	};
> +
>  	i2c-csi {
>  		compatible = "i2c-gpio";
>  		sda-gpios = <&pio 4 13 GPIO_ACTIVE_HIGH>; /* PE13 */
> @@ -410,6 +421,21 @@ &reg_rtc_ldo {
>  	regulator-name = "vcc-rtc";
>  };
>  
> +&simplefb_hdmi {
> +	vcc-hdmi-supply = <&reg_dldo1>;

You have to set status to okay here.

With that fixed, you can add:
Reviewed-by: Jernej Skrabec <jernej.skrabec@gmail.com>

Best regards,
Jernej

> +};
> +
> +&hdmi {
> +	hvcc-supply = <&reg_dldo1>;
> +	status = "okay";
> +};
> +
> +&hdmi_out {
> +	hdmi_out_con: endpoint {
> +		remote-endpoint = <&hdmi_con_in>;
> +	};
> +};
> +
>  &sound {
>  	status = "okay";
>  	simple-audio-card,aux-devs = <&codec_analog>, <&speaker_amp>;
> -- 
> 2.33.0
> 
> 


