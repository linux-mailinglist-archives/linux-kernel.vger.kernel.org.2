Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BE904311AF9
	for <lists+linux-kernel@lfdr.de>; Sat,  6 Feb 2021 05:39:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230406AbhBFEin (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 5 Feb 2021 23:38:43 -0500
Received: from mail-yb1-f177.google.com ([209.85.219.177]:37245 "EHLO
        mail-yb1-f177.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231725AbhBFDUV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 5 Feb 2021 22:20:21 -0500
Received: by mail-yb1-f177.google.com with SMTP id s61so8775288ybi.4;
        Fri, 05 Feb 2021 19:20:04 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=N/44ej6j4UuVwqBrJ6twQtXNQW2Tr20mLuJV3JZRN5A=;
        b=NoAmpOPq8C419QLwcZIN5w9ghr1jJzadJ7iarzIG/h2aMU//IWnO9JZqeZ10UMnHXB
         UgpfwibCTZ6b6B5AgWtRKUdIgUO5v4kS1Y+uLbGiTg+4NYYzoY79jtj6CBBoazJt2uok
         ChSrux4feLrhv8NYqO3bQ3BCIm1sPc+4Awrk6QhCl3UsjznX09s5+4D5aJl17bzTkwAb
         w1Wc8w/uqjg5DcoHtvBG0ZLus8RF2cKeLNxnBsKrbBm/LS7q/ZJfZ5eQR2tqowCcsxCM
         w4wRpVQ41sjV+C3QsgzDQkxmnGo1x5dBlJ5w8UARWEv/sLbn5aaoNu0CVwLabAhNjB2S
         sE6A==
X-Gm-Message-State: AOAM531lrn15MZIW97i1bJ9bPqQpV0YN/Z3JqqFcTdMVCtqHFgAjw8Li
        +eyEkyxJeGZA4ZAyYt5TfrreKKEf3Q==
X-Google-Smtp-Source: ABdhPJziqTqsYFOgzP6jVWyDWaLupnP8jgUARfZkx1WuuMbtUtiadqQGBejvB0Mmet9VWnU9WeJnQg==
X-Received: by 2002:a05:6830:1bc9:: with SMTP id v9mr2320019ota.106.1612564528471;
        Fri, 05 Feb 2021 14:35:28 -0800 (PST)
Received: from robh.at.kernel.org (24-155-109-49.dyn.grandenetworks.net. [24.155.109.49])
        by smtp.gmail.com with ESMTPSA id y24sm2094268oos.44.2021.02.05.14.35.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 05 Feb 2021 14:35:27 -0800 (PST)
Received: (nullmailer pid 3880904 invoked by uid 1000);
        Fri, 05 Feb 2021 22:35:26 -0000
Date:   Fri, 5 Feb 2021 16:35:26 -0600
From:   Rob Herring <robh@kernel.org>
To:     Steen Hegelund <steen.hegelund@microchip.com>
Cc:     Philipp Zabel <p.zabel@pengutronix.de>,
        Andrew Lunn <andrew@lunn.ch>,
        Microchip Linux Driver Support <UNGLinuxDriver@microchip.com>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>,
        Gregory Clement <gregory.clement@bootlin.com>,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        devicetree@vger.kernel.org
Subject: Re: [PATCH v4 3/3] arm64: dts: reset: add microchip sparx5 switch
 reset driver
Message-ID: <20210205223526.GA3869001@robh.at.kernel.org>
References: <20210120081921.3315847-1-steen.hegelund@microchip.com>
 <20210120081921.3315847-4-steen.hegelund@microchip.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210120081921.3315847-4-steen.hegelund@microchip.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jan 20, 2021 at 09:19:21AM +0100, Steen Hegelund wrote:
> This provides reset driver support for the Microchip Sparx5 PCB134 and
> PCB135 reference boards.

This isn't a compatible change. You need an explanation why that's okay 
if that's intended.

> 
> Signed-off-by: Steen Hegelund <steen.hegelund@microchip.com>
> ---
>  arch/arm64/boot/dts/microchip/sparx5.dtsi | 14 +++++++++++---
>  1 file changed, 11 insertions(+), 3 deletions(-)
> 
> diff --git a/arch/arm64/boot/dts/microchip/sparx5.dtsi b/arch/arm64/boot/dts/microchip/sparx5.dtsi
> index 380281f312d8..4edbb9fcdce0 100644
> --- a/arch/arm64/boot/dts/microchip/sparx5.dtsi
> +++ b/arch/arm64/boot/dts/microchip/sparx5.dtsi
> @@ -132,9 +132,17 @@ mux: mux-controller {
>  			};
>  		};
>  
> -		reset@611010008 {
> -			compatible = "microchip,sparx5-chip-reset";
> -			reg = <0x6 0x11010008 0x4>;
> +		gcb_ctrl: syscon@611010000 {
> +			compatible = "microchip,sparx5-gcb-syscon", "syscon";
> +			reg = <0x6 0x11010000 0x10000>;
> +		};
> +
> +		reset: reset-controller@0 {
> +			compatible = "microchip,sparx5-switch-reset";
> +			reg = <0x6 0x0 0x0>;

Your register length is 0?

> +			#reset-cells = <1>;
> +			cpu-syscon = <&cpu_ctrl>;

Can't you accomplish the same thing adding these to 
"microchip,sparx5-chip-reset"? Or possibly as a child node.

Define nodes based on h/w blocks, not as containers of things you happen 
to want for some driver.

> +			gcb-syscon = <&gcb_ctrl>;
>  		};
>  
>  		uart0: serial@600100000 {
> -- 
> 2.29.2
> 
