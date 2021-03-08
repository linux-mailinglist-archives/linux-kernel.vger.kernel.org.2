Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 464E13317FB
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Mar 2021 21:00:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231556AbhCHT7w (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 8 Mar 2021 14:59:52 -0500
Received: from mail-il1-f179.google.com ([209.85.166.179]:36712 "EHLO
        mail-il1-f179.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231156AbhCHT7h (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Mar 2021 14:59:37 -0500
Received: by mail-il1-f179.google.com with SMTP id g9so9993620ilc.3;
        Mon, 08 Mar 2021 11:59:37 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=GqDh2Qw9bvKqO+4ChtY2bB/9DV3UecEqn0ZpKAEpLuY=;
        b=HOFLnpOli+TdxgoVsiqAtMnWLNlzz2SWEusa9+X0KsvfDRktmtTf4HQAMo8XrmGnBV
         Capp83M5nOwgnSAYzZS9tsWNT4TO/GrhO8asvXVSJWUblLjKuVDyeCwZZiLONet8DQYW
         RxpsDZoYG8PJ6NJIesSgsoaZGfgNCfYvqNDhtFQ+rY2XhCjr0SFrrEu+ul+nXqRcYajD
         OOFdDyaWL+1UAxoBg9AtagQzfSAgfmoruZGilrPtxpe582NPV5H7L+PjQB88vA+VqrM7
         e/aG6YZJBsIzSe+6sWTU87JoEsE1mSrXJA6HFp1dqBqw1yfQC7gPKu/QWf9k31N8LyZt
         wM0A==
X-Gm-Message-State: AOAM530nUx4bOWtX/KtuKJqu3Fti0P4ykdKebk2d5VuvZPQcTYkGnN1F
        EPP/1vOShvc3LC4UTDEFQA==
X-Google-Smtp-Source: ABdhPJyx5uFJKP1ycPT1i1rI+Sb5Lk5WOsXuArM9P+0sDw4HHOeqtk3Mh8kasfTGdny/BZlWtG+FYw==
X-Received: by 2002:a92:b003:: with SMTP id x3mr23053380ilh.15.1615233577302;
        Mon, 08 Mar 2021 11:59:37 -0800 (PST)
Received: from robh.at.kernel.org ([64.188.179.253])
        by smtp.gmail.com with ESMTPSA id d3sm6726124ilo.32.2021.03.08.11.59.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 08 Mar 2021 11:59:36 -0800 (PST)
Received: (nullmailer pid 2867128 invoked by uid 1000);
        Mon, 08 Mar 2021 19:59:34 -0000
Date:   Mon, 8 Mar 2021 12:59:34 -0700
From:   Rob Herring <robh@kernel.org>
To:     Steen Hegelund <steen.hegelund@microchip.com>
Cc:     Philipp Zabel <p.zabel@pengutronix.de>,
        Andrew Lunn <andrew@lunn.ch>,
        Microchip Linux Driver Support <UNGLinuxDriver@microchip.com>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>,
        Gregory Clement <gregory.clement@bootlin.com>,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        devicetree@vger.kernel.org
Subject: Re: [PATCH v7 3/3] arm64: dts: reset: add microchip sparx5 switch
 reset driver
Message-ID: <20210308195934.GA2855503@robh.at.kernel.org>
References: <20210303081158.684532-1-steen.hegelund@microchip.com>
 <20210303081158.684532-4-steen.hegelund@microchip.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210303081158.684532-4-steen.hegelund@microchip.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Mar 03, 2021 at 09:11:58AM +0100, Steen Hegelund wrote:
> This provides reset driver support for the Microchip Sparx5 PCB134 and
> PCB135 reference boards.

This still looks like an incompatible change with no explanation.

What happens on an old kernel that expects "microchip,sparx5-chip-reset" 
and doesn't understand "microchip,sparx5-switch-reset"?

> 
> Signed-off-by: Steen Hegelund <steen.hegelund@microchip.com>
> ---
>  arch/arm64/boot/dts/microchip/sparx5.dtsi | 7 +++++--
>  1 file changed, 5 insertions(+), 2 deletions(-)
> 
> diff --git a/arch/arm64/boot/dts/microchip/sparx5.dtsi b/arch/arm64/boot/dts/microchip/sparx5.dtsi
> index 380281f312d8..dc3ada5cf9fc 100644
> --- a/arch/arm64/boot/dts/microchip/sparx5.dtsi
> +++ b/arch/arm64/boot/dts/microchip/sparx5.dtsi
> @@ -132,9 +132,12 @@ mux: mux-controller {
>  			};
>  		};
>  
> -		reset@611010008 {
> -			compatible = "microchip,sparx5-chip-reset";
> +		reset: reset-controller@611010008 {
> +			compatible = "microchip,sparx5-switch-reset";
>  			reg = <0x6 0x11010008 0x4>;
> +			reg-names = "gcb";
> +			#reset-cells = <1>;
> +			cpu-syscon = <&cpu_ctrl>;
>  		};
>  
>  		uart0: serial@600100000 {
> -- 
> 2.30.1
> 
