Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3B991315A4C
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Feb 2021 00:52:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234531AbhBIXvh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 9 Feb 2021 18:51:37 -0500
Received: from mail-yb1-f182.google.com ([209.85.219.182]:44046 "EHLO
        mail-yb1-f182.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233516AbhBIUfH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 Feb 2021 15:35:07 -0500
Received: by mail-yb1-f182.google.com with SMTP id r2so19470530ybk.11;
        Tue, 09 Feb 2021 12:34:46 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=Pnwa1q8bFk63V9muXgLO+kHUE83gy7ik9WU+PQH47No=;
        b=kNWURceCkbZ3ZXZQA6yhpVV6riQ56iv4qUkYz4B3Os06N0TYVlHJ7PeHcrax1lXRSB
         zahHRy9gATh/2GhJoqV8gq/cia7Rqz6e4jlnHRNRM2lRpdq2qA0mh6+7q4+jKbYA87wu
         oLp1jatQXOjTCD73gO2ZWCfMDyuikx69Wx5m+JkRXWWsZhLd3TmQUIskKNKPLee674oD
         TJy3HcDM5xC9WOicLW0QxXBu6iY1u6KCBg9JxobXuzGmdkj43uMODmEse3MUcMxafBNx
         Mdv213WCA5cwhCaf8uRvAt4oEaTS6fHgpanp1sh1Nn1+tAoCaeLUIVfUb9Ohl7dpxoSk
         /JpA==
X-Gm-Message-State: AOAM532PH5my11UluqdsfONx8nPxV7wU1rSTtCRMYhxkzYgKJ7soFPHX
        wtT86dUKSGNkxZr9lGnfSVi05ALT0A==
X-Google-Smtp-Source: ABdhPJwxTB/2hrPg4OkzTE0+aenHe4L34frxHXvPTssN3E4WXZROXrV5AQgadKwpCLYJzpKsYQcggA==
X-Received: by 2002:a9d:398a:: with SMTP id y10mr8209412otb.68.1612900910464;
        Tue, 09 Feb 2021 12:01:50 -0800 (PST)
Received: from robh.at.kernel.org (24-155-109-49.dyn.grandenetworks.net. [24.155.109.49])
        by smtp.gmail.com with ESMTPSA id 33sm4397956ota.69.2021.02.09.12.01.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 09 Feb 2021 12:01:49 -0800 (PST)
Received: (nullmailer pid 69000 invoked by uid 1000);
        Tue, 09 Feb 2021 20:01:48 -0000
Date:   Tue, 9 Feb 2021 14:01:48 -0600
From:   Rob Herring <robh@kernel.org>
To:     Adrien Grassein <adrien.grassein@gmail.com>
Cc:     kishon@ti.com, vkoul@kernel.org, shawnguo@kernel.org,
        s.hauer@pengutronix.de, kernel@pengutronix.de, festevam@gmail.com,
        linux-imx@nxp.com, rikard.falkeborn@gmail.com, peter.chen@nxp.com,
        jun.li@nxp.com, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH 1/2] dt-bindings: phy-imx8mq-usb: add reset-gpios property
Message-ID: <20210209200148.GA31636@robh.at.kernel.org>
References: <20210128221255.2673992-1-adrien.grassein@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210128221255.2673992-1-adrien.grassein@gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jan 28, 2021 at 11:12:54PM +0100, Adrien Grassein wrote:
> Add an optional GPIO in the dtb description that will
> be used to reset the connected hub (if any).
> 
> Signed-off-by: Adrien Grassein <adrien.grassein@gmail.com>
> ---
>  Documentation/devicetree/bindings/phy/fsl,imx8mq-usb-phy.txt | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/Documentation/devicetree/bindings/phy/fsl,imx8mq-usb-phy.txt b/Documentation/devicetree/bindings/phy/fsl,imx8mq-usb-phy.txt
> index 7c70f2ad9942..6ee2b42e0f22 100644
> --- a/Documentation/devicetree/bindings/phy/fsl,imx8mq-usb-phy.txt
> +++ b/Documentation/devicetree/bindings/phy/fsl,imx8mq-usb-phy.txt
> @@ -9,6 +9,7 @@ Required properties:
>  
>  Optional properties:
>  - vbus-supply: A phandle to the regulator for USB VBUS.
> +- reset-gpios: A phandle to the reset signal of the connected hub (if any).

This should go in a hub node (or whatever device has a reset line).

>  
>  Example:
>  	usb3_phy0: phy@381f0040 {
> -- 
> 2.25.1
> 
