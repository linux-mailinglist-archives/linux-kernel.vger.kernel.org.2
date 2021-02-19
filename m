Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 06F7F31F9D3
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Feb 2021 14:20:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230163AbhBSNUg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 19 Feb 2021 08:20:36 -0500
Received: from mail-wr1-f41.google.com ([209.85.221.41]:42068 "EHLO
        mail-wr1-f41.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229799AbhBSNUc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 19 Feb 2021 08:20:32 -0500
Received: by mail-wr1-f41.google.com with SMTP id r21so8429484wrr.9;
        Fri, 19 Feb 2021 05:20:15 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=h1NBAsdGKZOONNxeyvlSgGrRj1mc/OHyP7XLJUbFHDw=;
        b=QvbTtnyXInPaJWV3gfXOGdxOGfGzUeR27hF5jiPcMtcRzsq43K7PUBMta40RiOoQaq
         W3Y19MBjR2Zh1VwBsZ012bLwU0tj96HEgu8DC/lywK3T/ManN1l6JK10UbbTBTfSkByi
         hKfCl5UErQWPYc7BNZCRv/BqwAEdj62Q7L3nRcUipwoY3KeyUOM053Pplhr9GW1biHrR
         cgWzsvA1OMaqTPT7yPQLBQ+tIam6mXbxwWkXz3ek8sWB2XeNa4MtKvSmjua3IWu3YYaW
         xHNXAzL9gBJM64hLinJPMfeiUuSd11eBaO9yzBG6joLxves2GNJ9joWge6+2mCoh9Brk
         vvFA==
X-Gm-Message-State: AOAM532Y4Q4Bw9BVyoty9VUy8yjGvzx7zUNcsEedKzNTZ/Ew+8Ksy0SQ
        nxCBvDjMVfba8klTqe41TkM=
X-Google-Smtp-Source: ABdhPJwSvRbN6anIxrMOz594ruA9hoHVhNJQLyqQg1npifmz3yYnPkrCdfT0uLkI9oztmcz45am+nw==
X-Received: by 2002:a05:6000:114b:: with SMTP id d11mr8907025wrx.318.1613740789887;
        Fri, 19 Feb 2021 05:19:49 -0800 (PST)
Received: from kozik-lap (adsl-84-226-167-205.adslplus.ch. [84.226.167.205])
        by smtp.googlemail.com with ESMTPSA id y6sm11610410wma.10.2021.02.19.05.19.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 19 Feb 2021 05:19:48 -0800 (PST)
Date:   Fri, 19 Feb 2021 14:19:47 +0100
From:   Krzysztof Kozlowski <krzk@kernel.org>
To:     Adrien Grassein <adrien.grassein@gmail.com>
Cc:     robh+dt@kernel.org, shawnguo@kernel.org, s.hauer@pengutronix.de,
        kernel@pengutronix.de, festevam@gmail.com, linux-imx@nxp.com,
        catalin.marinas@arm.com, will@kernel.org,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 3/8] arm64: dts: imx8mm-nitrogen-r2: add espi2 support
Message-ID: <20210219131947.fcgoshnowurvwqf3@kozik-lap>
References: <20210217161052.877877-1-adrien.grassein@gmail.com>
 <20210217161052.877877-4-adrien.grassein@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20210217161052.877877-4-adrien.grassein@gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Feb 17, 2021 at 05:10:47PM +0100, Adrien Grassein wrote:
> Add the description for espi support.
> 
> Signed-off-by: Adrien Grassein <adrien.grassein@gmail.com>
> Reviewed-by: Krzysztof Kozlowski <krzk@kernel.org>
> ---
>  .../boot/dts/freescale/imx8mm-nitrogen-r2.dts | 30 +++++++++++++++++++
>  1 file changed, 30 insertions(+)
> 
> diff --git a/arch/arm64/boot/dts/freescale/imx8mm-nitrogen-r2.dts b/arch/arm64/boot/dts/freescale/imx8mm-nitrogen-r2.dts
> index f62a25efc69e..c4bb22bb4e6a 100644
> --- a/arch/arm64/boot/dts/freescale/imx8mm-nitrogen-r2.dts
> +++ b/arch/arm64/boot/dts/freescale/imx8mm-nitrogen-r2.dts
> @@ -10,6 +10,14 @@ / {
>  	model = "Boundary Devices i.MX8MMini Nitrogen8MM Rev2";
>  	compatible = "boundary,imx8mm-nitrogen8mm", "fsl,imx8mm";
>  
> +	clock {
> +		clk16m: clk16m {

No changes here. The review tag was conditional in a way that I assumed
you will implement this change.

Best regards,
Krzysztof
