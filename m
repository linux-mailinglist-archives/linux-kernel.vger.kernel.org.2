Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1B7D6399A57
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Jun 2021 07:54:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229812AbhFCF4N (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 3 Jun 2021 01:56:13 -0400
Received: from mail.kernel.org ([198.145.29.99]:49454 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229635AbhFCF4M (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Jun 2021 01:56:12 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 4D589613C9;
        Thu,  3 Jun 2021 05:54:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1622699668;
        bh=f4JogtJ88o/uB5SRGOdZF272124+VChsiDtFMUcw3Bo=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=o5NQXog8REkzRTEGREi1W9j0yrulGy5kmDTU3cyF+Kn16NRNjWfBAJEUlC44ybo/N
         rPFpTWmR2rJ5djKwh61YJ95gpwkHPAEuYHBI4C8En/OgxAaRdLarhcIwGmaAsPwAPq
         A52GJUvZSyaQLKIk8Rs5qKMLl/FhDRh+UcCH0rjEgCunid6IEeGHuIPIeZ2m0LRFIW
         hVyolXn/BW+ybZYjiwSZnOfaKNOBTv5wjAMXZPLyWLpWZ1hV7kb9jpDbC2PMHHa8mY
         d6aZA0kz8vh1okyNrT3PITpdIwa80tEuQi09hxuryFFujuYHJce+gj0YPvRRCPpswf
         /u7+poleUyUlw==
Date:   Thu, 3 Jun 2021 11:24:24 +0530
From:   Vinod Koul <vkoul@kernel.org>
To:     Johan Jonker <jbx6244@gmail.com>
Cc:     heiko@sntech.de, robh+dt@kernel.org, kishon@ti.com,
        t.schramm@manjaro.org, linux-phy@lists.infradead.org,
        linux-rockchip@lists.infradead.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v7 1/5] dt-bindings: phy: rename phy nodename in
 phy-rockchip-inno-usb2.yaml
Message-ID: <YLhukPL7jSx3+dBj@vkoul-mobl>
References: <20210601164800.7670-1-jbx6244@gmail.com>
 <20210601164800.7670-2-jbx6244@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210601164800.7670-2-jbx6244@gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 01-06-21, 18:47, Johan Jonker wrote:
> The pattern: "^(|usb-|usb2-|usb3-|pci-|pcie-|sata-)phy(@[0-9a-f,]+)*$"
> in phy-provider.yaml has required "#phy-cells" for phy nodes.
> The "phy-cells" in rockchip-inno-usb2 nodes are located in subnodes.
> Rename the nodename to pattern "usb2phy@[0-9a-f]+$" to prevent
> notifications. Remove unneeded "#phy-cells" from parent node.
> Also sort example.
> 
> make ARCH=arm dtbs_check
> DT_SCHEMA_FILES=~/.local/lib/python3.5/site-packages/dtschema/schemas/
> phy/phy-provider.yaml
> 
> Signed-off-by: Johan Jonker <jbx6244@gmail.com>
> Acked-by: Rob Herring <robh@kernel.org>
> ---
>  .../devicetree/bindings/phy/phy-rockchip-inno-usb2.yaml       | 11 +++--------
>  Documentation/devicetree/bindings/soc/rockchip/grf.yaml       |  4 ++--

I dont have grf.yaml, I guess it would be easier to split this into two
or apply this thru rockchip tree. If you prefer latter:

Acked-By: Vinod Koul <vkoul@kernel.org>

-- 
~Vinod
