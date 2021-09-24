Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BD3C6417714
	for <lists+linux-kernel@lfdr.de>; Fri, 24 Sep 2021 16:50:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346910AbhIXOwB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 24 Sep 2021 10:52:01 -0400
Received: from vps0.lunn.ch ([185.16.172.187]:58734 "EHLO vps0.lunn.ch"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1346847AbhIXOv7 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Sep 2021 10:51:59 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
        s=20171124; h=In-Reply-To:Content-Transfer-Encoding:Content-Disposition:
        Content-Type:MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:From:
        Sender:Reply-To:Subject:Date:Message-ID:To:Cc:MIME-Version:Content-Type:
        Content-Transfer-Encoding:Content-ID:Content-Description:Content-Disposition:
        In-Reply-To:References; bh=5TIp+jvOSKncRqk5PW16MyMZMoU58Ut9aKPAaTdYe2I=; b=GG
        D5LoUwPkC0fmN1cwGJgWlBkTtYXaOtmfeVUQES1tCDz+jkUw9sx2mmkRF8adU4T3VRl4Q/kdJZAxM
        EMCy6yMympATD3URl3jIbmE7vSahrm6Px6AYI6TaqQ8GOsFb+6c10xu/c5huZAGHyDb+vQV4ri52k
        ynZsocV3zgn68u0=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
        (envelope-from <andrew@lunn.ch>)
        id 1mTmWq-0086fH-11; Fri, 24 Sep 2021 16:50:20 +0200
Date:   Fri, 24 Sep 2021 16:50:20 +0200
From:   Andrew Lunn <andrew@lunn.ch>
To:     Robert Marko <robert.marko@sartura.hr>
Cc:     robh+dt@kernel.org, gregory.clement@bootlin.com,
        sebastian.hesselbarth@gmail.com, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH v3] arm64: dts: marvell: add Globalscale MOCHAbin
Message-ID: <YU3lrIbRKLU21z/F@lunn.ch>
References: <20210923181830.3449602-1-robert.marko@sartura.hr>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20210923181830.3449602-1-robert.marko@sartura.hr>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Sep 23, 2021 at 08:18:30PM +0200, Robert Marko wrote:
> Globalscale MOCHAbin is a Armada 7040 based development board.
> 
> Specifications:
> * Armada 7040 Quad core ARMv8 Cortex A-72 @ 1.4GHz
> * 2 / 4 / 8 GB of DDR4 DRAM
> * 16 GB eMMC
> * 4MB SPI-NOR (Bootloader)
> * 1x M.2-2280 B-key socket (for SSD expansion, SATA3 only)
> * 1x M.2-2250 B-key socket (for modems, USB2.0 and I2C only)
> * 1x Mini-PCIe 3.0 (x1, USB2.0 and I2C)
> * 1x SATA 7+15 socket (SATA3)
> * 1x 16-pin (2×8) MikroBus Connector
> * 1x SIM card slot (Connected to the mini-PCIe and both M.2 slots)
> * 2x USB3.0 Type-A ports via SMSC USB5434B hub
> * Cortex 2x5 JTAG
> * microUSB port for UART (PL2303GL/PL2303SA onboard)
> * 1x 10G SFP+
> * 1x 1G SFP (Connected to 88E1512 PHY)
> * 1x 1G RJ45 with PoE PD (Connected to 88E1512 PHY)
> * 4x 1G RJ45 ports via Topaz 88E6141 switch
> * RTC with battery holder (SoC provided, requires CR2032 battery)
> * 1x 12V DC IN
> * 1x Power switch
> * 1x 12V fan header (3-pin, power only)
> * 1x mini-PCIe LED header (2x0.1" pins)
> * 1x M.2-2280 LED header (2x0.1" pins)
> * 6x Bootstrap jumpers
> * 1x Power LED (Green)
> * 3x Tri-color RGB LEDs (Controllable)
> * 1x Microchip ATECC608B secure element
> 
> Note that 1G SFP and 1G WAN cannot be used at the same time as they are in
> parallel connected to the same PHY.
> 
> Signed-off-by: Robert Marko <robert.marko@sartura.hr>

Reviewed-by: Andrew Lunn <andrew@lunn.ch>

    Andrew
