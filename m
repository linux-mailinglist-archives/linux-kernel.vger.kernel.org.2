Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E6E4E459CE6
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Nov 2021 08:39:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234209AbhKWHmg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 23 Nov 2021 02:42:36 -0500
Received: from mail.kernel.org ([198.145.29.99]:54112 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S234161AbhKWHme (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 Nov 2021 02:42:34 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id E7B9E60E94;
        Tue, 23 Nov 2021 07:39:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1637653164;
        bh=SyxAeQw9fyWOIjanhRWuVLtPc7UGBdVPN7fyibQE8EM=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=FLns9YHMWZ32JS+1lWSZPCqVHZJS8exzZmtoPNw4L9qM7Wk60R/uU+CrloQ6D5kHp
         7qdoj0mKTlDXQIMRNh1kPrM8LEDM/2YlBOy0XuC+S/jrcjoLR0P7UbcCylxI4yJkjO
         xrJ4PlOhM/F7zgNuHwF+IoyPvcf3ARYr1YuCuUkFFlpFP0xTJZRLdRAteSxndu40fq
         hBJcHejJDyU54WAsXBUP2m4V5XbsQ0enRHOOmqXq3EXmjp+6Eq1A8cTQdp9OihBCXP
         rzHM3gGI5Zs3UlgQ2DOrQ4DHG+ncgpUsJOz+AFUMres+X+e2AzGF5GOEKy/HrJ58JB
         Ood0Xz1ZhvKow==
Date:   Tue, 23 Nov 2021 13:09:19 +0530
From:   Vinod Koul <vkoul@kernel.org>
To:     Horatiu Vultur <horatiu.vultur@microchip.com>
Cc:     kishon@ti.com, robh+dt@kernel.org, andrew@lunn.ch,
        alexandre.belloni@bootlin.com, kuba@kernel.org,
        linux-phy@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH resend v4 0/3] phy: Add driver for lan966x Serdes driver
Message-ID: <YZyap7IgY/6WIHEE@matsya>
References: <20211116100818.1615762-1-horatiu.vultur@microchip.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211116100818.1615762-1-horatiu.vultur@microchip.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 16-11-21, 11:08, Horatiu Vultur wrote:
> This patch serie adds support for Microchip lan966x serdes. The lan966x
> device contains 7 interfaces, consisting of 2 copper transceivers,
> 3 Serdes and 2 RGMII interfaces. Two of the Serdes support QSGMII.
> The driver also adds the functionality of "muxing" the interfaces to
> different logical ports.
> 
> The following table shows which interfaces can be supported by the port.
> 
> PortNumber    Max Speed    Ethernet interface options
>     0            1Gbps       CuPHY, 1G SGMII or QSGMII
>     1            1Gbps       CuPHY, 1G SGMII or QSGMII
>     2          2.5Gbps       2.5G SGMII, QSGMII, RGMII
>     3          2.5Gbps       2.5G SGMII, QSGMII, RGMII
>     4          2.5Gbps       2.5G SGMII, QSGMII
>     5            1Gbps       QSGMII, RGMII
>     6            1Gbps       QSGMII, RGMII
>     7            1Gbps       QSGMII

Applied, thanks

-- 
~Vinod
