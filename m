Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AC1E0316F8B
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Feb 2021 20:06:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231609AbhBJTEx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 10 Feb 2021 14:04:53 -0500
Received: from mail-ot1-f45.google.com ([209.85.210.45]:43822 "EHLO
        mail-ot1-f45.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233033AbhBJTEI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 Feb 2021 14:04:08 -0500
Received: by mail-ot1-f45.google.com with SMTP id l23so2809847otn.10;
        Wed, 10 Feb 2021 11:03:49 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=2x+EOIuPdBTznUqzDSV5oD4ee/OTH0GyH6F9c80brmU=;
        b=E69JDJ6vzVP4kBGBSXK53zaOIaLZjvRj2rXcJpaECV3W+I3gJi4UoncldCMUILhFqX
         pW+CwFjTNltGh+TxnM/Xk7gdrE8YkbBPs7G8hfTqMa80+/iTy40o7YdNKheFtPtPsCoo
         TjHb2ov9O5W32g+/GfRhxr3Idr/zY0vTLhedHIOAg2TA0iAwTlMei511XwQilDIvIBuX
         0zZbs/oMwbux6B2qkBcsy9T9hNuf+TI/gmkxXKRpupdjJdKuhzDAhrYHPIvNwlZ79HNI
         VLDljGuw7LtoBITzf3WgCFJ9bIm6V2SX4lqTiJCh04zwFKbTjTIHr++ocC5RNjrJwf5O
         tFcw==
X-Gm-Message-State: AOAM530bEGoRKFPPuVZAMBx2VlFiBahLHgVcuQ74QQBHOW0k8jS2j51T
        o6FY5IgoZyJq7EMJb7ka7g==
X-Google-Smtp-Source: ABdhPJxNanMjvR3D9jVhNKwPipPfT3CkersCx0nGRPMJcnbWgEoxRBYupmh5YT36/6Y3BJq4k8s3qQ==
X-Received: by 2002:a9d:3ec:: with SMTP id f99mr3267311otf.299.1612983804617;
        Wed, 10 Feb 2021 11:03:24 -0800 (PST)
Received: from robh.at.kernel.org (24-155-109-49.dyn.grandenetworks.net. [24.155.109.49])
        by smtp.gmail.com with ESMTPSA id g14sm521323oon.23.2021.02.10.11.03.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 10 Feb 2021 11:03:23 -0800 (PST)
Received: (nullmailer pid 2555793 invoked by uid 1000);
        Wed, 10 Feb 2021 19:03:22 -0000
Date:   Wed, 10 Feb 2021 13:03:22 -0600
From:   Rob Herring <robh@kernel.org>
To:     kostap@marvell.com
Cc:     linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, vladimir.vid@sartura.hr,
        tmn505@gmail.com, luka.kovacic@sartura.hr,
        sebastian.hesselbarth@gmail.com, gregory.clement@bootlin.com,
        andrew@lunn.ch, vkoul@kernel.org, kishon@ti.com,
        miquel.raynal@bootlin.com, mw@semihalf.com, jaz@semihalf.com,
        nadavh@marvell.com, stefanc@marvell.com, bpeled@marvell.com
Subject: Re: [PATCH v5 1/5] Documentation/bindings: phy: update references to
 cp11x
Message-ID: <20210210190322.GA2549599@robh.at.kernel.org>
References: <20210210131604.28806-1-kostap@marvell.com>
 <20210210131604.28806-2-kostap@marvell.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210210131604.28806-2-kostap@marvell.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Feb 10, 2021 at 03:16:00PM +0200, kostap@marvell.com wrote:
> From: Grzegorz Jaszczyk <jaz@semihalf.com>
> 
> The cp11x references in dts has changed, reflect it in comphy
> documentation.

Who cares. Examples are just examples.

If you really want to improve the binding, convert it to schema.

> Signed-off-by: Grzegorz Jaszczyk <jaz@semihalf.com>
> Signed-off-by: Konstantin Porotchkin <kostap@marvell.com>
> ---
>  Documentation/devicetree/bindings/phy/phy-mvebu-comphy.txt | 12 ++++++------
>  1 file changed, 6 insertions(+), 6 deletions(-)
> 
> diff --git a/Documentation/devicetree/bindings/phy/phy-mvebu-comphy.txt b/Documentation/devicetree/bindings/phy/phy-mvebu-comphy.txt
> index 8c60e6985950..5ffd0f55d010 100644
> --- a/Documentation/devicetree/bindings/phy/phy-mvebu-comphy.txt
> +++ b/Documentation/devicetree/bindings/phy/phy-mvebu-comphy.txt
> @@ -42,22 +42,22 @@ Required properties (child nodes):
>  
>  Examples:
>  
> -	cpm_comphy: phy@120000 {
> +	CP11X_LABEL(comphy): phy@120000 {
>  		compatible = "marvell,comphy-cp110";
>  		reg = <0x120000 0x6000>;
> -		marvell,system-controller = <&cpm_syscon0>;
> -		clocks = <&CP110_LABEL(clk) 1 5>, <&CP110_LABEL(clk) 1 6>,
> -			 <&CP110_LABEL(clk) 1 18>;
> +		marvell,system-controller = <&CP11X_LABEL(syscon0)>;
> +		clocks = <&CP11X_LABEL(clk) 1 5>, <&CP11X_LABEL(clk) 1 6>,
> +			 <&CP11X_LABEL(clk) 1 18>;
>  		clock-names = "mg_clk", "mg_core_clk", "axi_clk";
>  		#address-cells = <1>;
>  		#size-cells = <0>;
>  
> -		cpm_comphy0: phy@0 {
> +		CP11X_LABEL(comphy0): phy@0 {
>  			reg = <0>;
>  			#phy-cells = <1>;
>  		};
>  
> -		cpm_comphy1: phy@1 {
> +		CP11X_LABEL(comphy1): phy@1 {
>  			reg = <1>;
>  			#phy-cells = <1>;
>  		};
> -- 
> 2.17.1
> 
