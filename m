Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C10B4349E8D
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Mar 2021 02:19:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230204AbhCZBSo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 25 Mar 2021 21:18:44 -0400
Received: from mail-io1-f42.google.com ([209.85.166.42]:42655 "EHLO
        mail-io1-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230013AbhCZBS1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Mar 2021 21:18:27 -0400
Received: by mail-io1-f42.google.com with SMTP id r193so3818551ior.9;
        Thu, 25 Mar 2021 18:18:27 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=uLEv/UUTMOz0YMtABzYyD5q0F3bD9ue+f7LZRR5uqaQ=;
        b=OY9edyg0TvmQkHuh/2HMI++wxFmANudCYtIaV3ED27tyPLLTpGFwsAbcRvILk7+SxE
         0x2nLwKtXJDDJDJ+1UhbXccbJmq3KKjsLDG2Z3vciUiBECU/APFzNTSJXkOLCLmb5eJA
         GrL7eQB3rSLGLrrdfIdBq6K1TTZtks3OadlE1mL6OE5vEEgWA5BgBbzR3kNJlT6mkbNY
         UvdE+/vLhveomoFbgcepiBGAXGK411OBRkcQ2gbMzPfNfIR5VJdDv7qWcqykAPvDQd37
         98swN9M73lpo0M31Z3YoV33H/xhm50Z2XYpZl0xm+yVf2/IfSFQjW3ZlR1l4Y/CxTDCn
         8hog==
X-Gm-Message-State: AOAM533+yltcGUj15WWxKbmfJfEg3D4p1uC4LFYkiZgv5zTDj1YZNNXW
        rSsaQWKob6Zpo9/6rRc+aQ==
X-Google-Smtp-Source: ABdhPJzqjnBsjg5OOMfmunx455Sgg50aTb8Nxfxl10GMGD+dZ9XGG9xe6kn6gqUrOhukuU0sLugHyQ==
X-Received: by 2002:a05:6638:224e:: with SMTP id m14mr10171656jas.8.1616721506708;
        Thu, 25 Mar 2021 18:18:26 -0700 (PDT)
Received: from robh.at.kernel.org ([64.188.179.253])
        by smtp.gmail.com with ESMTPSA id e2sm3452684iov.26.2021.03.25.18.18.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 25 Mar 2021 18:18:26 -0700 (PDT)
Received: (nullmailer pid 2110362 invoked by uid 1000);
        Fri, 26 Mar 2021 01:18:23 -0000
Date:   Thu, 25 Mar 2021 19:18:23 -0600
From:   Rob Herring <robh@kernel.org>
To:     Dario Binacchi <dariobin@libero.it>
Cc:     linux-kernel@vger.kernel.org,
        Grygorii Strashko <grygorii.strashko@ti.com>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>, devicetree@vger.kernel.org,
        linux-clk@vger.kernel.org
Subject: Re: [PATCH v2 2/4] dt-bindings: ti: dpll: add spread spectrum support
Message-ID: <20210326011823.GA2102368@robh.at.kernel.org>
References: <20210318172627.12173-1-dariobin@libero.it>
 <20210318172627.12173-3-dariobin@libero.it>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210318172627.12173-3-dariobin@libero.it>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Mar 18, 2021 at 06:26:24PM +0100, Dario Binacchi wrote:
> DT bindings for enabling and adjusting spread spectrum clocking have
> been added.
> 
> Signed-off-by: Dario Binacchi <dariobin@libero.it>
> ---
> 
> (no changes since v1)
> 
>  .../devicetree/bindings/clock/ti/dpll.txt     | 20 +++++++++++++++++++
>  1 file changed, 20 insertions(+)
> 
> diff --git a/Documentation/devicetree/bindings/clock/ti/dpll.txt b/Documentation/devicetree/bindings/clock/ti/dpll.txt
> index df57009ff8e7..0810ae073294 100644
> --- a/Documentation/devicetree/bindings/clock/ti/dpll.txt
> +++ b/Documentation/devicetree/bindings/clock/ti/dpll.txt
> @@ -42,6 +42,11 @@ Required properties:
>  	"idlest" - contains the idle status register base address
>  	"mult-div1" - contains the multiplier / divider register base address
>  	"autoidle" - contains the autoidle register base address (optional)
> +	"ssc-deltam" - DPLL supports spread spectrum clocking (SSC), contains
> +		       the frequency spreading register base address (optional)
> +	"ssc-modfreq" - DPLL supports spread spectrum clocking (SSC), contains
> +		        the modulation frequency register base address
> +			(optional)
>    ti,am3-* dpll types do not have autoidle register
>    ti,omap2-* dpll type does not support idlest / autoidle registers
>  
> @@ -51,6 +56,14 @@ Optional properties:
>  	- ti,low-power-stop : DPLL supports low power stop mode, gating output
>  	- ti,low-power-bypass : DPLL output matches rate of parent bypass clock
>  	- ti,lock : DPLL locks in programmed rate
> +	- ti,min-div : the minimum divisor to start from to round the DPLL
> +		       target rate
> +	- ti,ssc-deltam : DPLL supports spread spectrum clocking, frequency
> +			  spreading in permille (10th of a percent)
> +	- ti,ssc-modfreq : DPLL supports spread spectrum clocking, spread
> +			   spectrum modulation frequency in kHz

Use a standard unit suffix (-hz or -mhz).

> +	- ti,ssc-downspread : DPLL supports spread spectrum clocking, boolean
> +			      to enable the downspread feature
>  
>  Examples:
>  	dpll_core_ck: dpll_core_ck@44e00490 {
> @@ -83,3 +96,10 @@ Examples:
>  		clocks = <&sys_ck>, <&sys_ck>;
>  		reg = <0x0500>, <0x0540>;
>  	};
> +
> +	dpll_disp_ck: dpll_disp_ck {
> +		#clock-cells = <0>;
> +		compatible = "ti,am3-dpll-no-gate-clock";
> +		clocks = <&sys_clkin_ck>, <&sys_clkin_ck>;
> +		reg = <0x0498>, <0x0448>, <0x0454>, <0x044c>, <0x0450>;
> +	};
> -- 
> 2.17.1
> 
