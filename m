Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7ED173A8C18
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Jun 2021 00:51:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231295AbhFOWxc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 15 Jun 2021 18:53:32 -0400
Received: from mail-io1-f48.google.com ([209.85.166.48]:40839 "EHLO
        mail-io1-f48.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230012AbhFOWx3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Jun 2021 18:53:29 -0400
Received: by mail-io1-f48.google.com with SMTP id l64so930385ioa.7;
        Tue, 15 Jun 2021 15:51:23 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=v8B2wVaCpr8Qn6YRXaLqCqpnrK4WnHFpvkW5d5afMdg=;
        b=RUBVB27RUM6muBfYE1Iyh3U4/3dzpw5rMXGBMunGFA+bQCZTlDq1g9j6S8tq/bcypP
         Ubi0b9MzX67xYleYTVRCERPypOrfevch+/Nkobn4HM1dCj9PssB+OcKS1Lo61oSN9z2M
         V1usd8jGBOQMIaOC/x6PZmHhw9OH+EWnCoEV39DUTvk5akXp/pPLfxH8ialbvgwo6eQt
         LXZ4U3ZCTa03XQ5QvBHCqqT6XI2KQihizDYcj3oNiPH7q/JKHipSCSsAd38O1P9u3aov
         Lz+ADaL0vTepWYa9j/PIK1B8tFTKosNRQMmkaXuZra/ZK1ksMfDdnn4iFV0lvTJqWrE1
         VCMQ==
X-Gm-Message-State: AOAM53264tXWhmEYog7O1K0A1UXGtN6xG7tG0FoH4ETz1lMxE+evH5a0
        WK9rrbQTF7LjwPbzKST0lZ9F76Y8UA==
X-Google-Smtp-Source: ABdhPJzth4nSZ4K819GvxhIixj1/TglDmqAwAzcAoOD5AHy/ymD3hT+sv48s6GG8ejdtxEtcuUq9XQ==
X-Received: by 2002:a02:2547:: with SMTP id g68mr1300142jag.24.1623797482806;
        Tue, 15 Jun 2021 15:51:22 -0700 (PDT)
Received: from robh.at.kernel.org ([64.188.179.248])
        by smtp.gmail.com with ESMTPSA id k4sm223526ior.55.2021.06.15.15.51.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 15 Jun 2021 15:51:22 -0700 (PDT)
Received: (nullmailer pid 1434108 invoked by uid 1000);
        Tue, 15 Jun 2021 22:51:20 -0000
Date:   Tue, 15 Jun 2021 16:51:20 -0600
From:   Rob Herring <robh@kernel.org>
To:     Benjamin Gaignard <benjamin.gaignard@collabora.com>
Cc:     kishon@ti.com, vkoul@kernel.org, heiko@sntech.de,
        pgwipeout@gmail.com, linux-phy@lists.infradead.org,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-rockchip@lists.infradead.org, linux-kernel@vger.kernel.org,
        kernel@collabora.com
Subject: Re: [PATCH 1/4] dt-bindings: phy: rockchip: USB2: remove useless
 #phy-cells property
Message-ID: <20210615225120.GA1433605@robh.at.kernel.org>
References: <20210614154359.805555-1-benjamin.gaignard@collabora.com>
 <20210614154359.805555-2-benjamin.gaignard@collabora.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210614154359.805555-2-benjamin.gaignard@collabora.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jun 14, 2021 at 05:43:56PM +0200, Benjamin Gaignard wrote:
> '#phy-cells' property is needed in host-port and otg-port nodes but
> not in parent nodes. Remove it from the JSON schema.

Pretty sure there's already a fix for this.

> 
> Signed-off-by: Benjamin Gaignard <benjamin.gaignard@collabora.com>
> ---
>  .../devicetree/bindings/phy/phy-rockchip-inno-usb2.yaml         | 2 --
>  1 file changed, 2 deletions(-)
> 
> diff --git a/Documentation/devicetree/bindings/phy/phy-rockchip-inno-usb2.yaml b/Documentation/devicetree/bindings/phy/phy-rockchip-inno-usb2.yaml
> index fb29ad807b68f..b14387a48f6a3 100644
> --- a/Documentation/devicetree/bindings/phy/phy-rockchip-inno-usb2.yaml
> +++ b/Documentation/devicetree/bindings/phy/phy-rockchip-inno-usb2.yaml
> @@ -119,7 +119,6 @@ required:
>    - reg
>    - clock-output-names
>    - "#clock-cells"
> -  - "#phy-cells"
>    - host-port
>    - otg-port
>  
> @@ -137,7 +136,6 @@ examples:
>        clock-names = "phyclk";
>        clock-output-names = "clk_usbphy0_480m";
>        #clock-cells = <0>;
> -      #phy-cells = <0>;
>  
>        u2phy0_host: host-port {
>          #phy-cells = <0>;
> -- 
> 2.25.1
