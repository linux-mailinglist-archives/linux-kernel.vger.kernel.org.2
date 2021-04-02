Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 645BC353063
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Apr 2021 22:48:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235094AbhDBUs1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 2 Apr 2021 16:48:27 -0400
Received: from relay12.mail.gandi.net ([217.70.178.232]:45261 "EHLO
        relay12.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229722AbhDBUsY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Apr 2021 16:48:24 -0400
Received: from localhost (91-175-115-186.subs.proxad.net [91.175.115.186])
        (Authenticated sender: gregory.clement@bootlin.com)
        by relay12.mail.gandi.net (Postfix) with ESMTPSA id ED3AF200002;
        Fri,  2 Apr 2021 20:48:18 +0000 (UTC)
From:   Gregory CLEMENT <gregory.clement@bootlin.com>
To:     kostap@marvell.com, linux-arm-kernel@lists.infradead.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     lkundrak@v3.sk, linux@armlinux.org.uk,
        sebastian.hesselbarth@gmail.com, andrew@lunn.ch,
        robh+dt@kernel.org, vkoul@kernel.org, kishon@ti.com,
        miquel.raynal@bootlin.com, mw@semihalf.com, jaz@semihalf.com,
        nadavh@marvell.com, stefanc@marvell.com, bpeled@marvell.com,
        Konstantin Porotchkin <kostap@marvell.com>
Subject: Re: [PATCH v3 0/5] Add support for CP110 UTMI PHY
In-Reply-To: <20210307163343.25684-1-kostap@marvell.com>
References: <20210307163343.25684-1-kostap@marvell.com>
Date:   Fri, 02 Apr 2021 22:48:18 +0200
Message-ID: <877dlkct0t.fsf@BL-laptop>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Kosta,

> From: Konstantin Porotchkin <kostap@marvell.com>
>
> This series of patches adds a new PHY driver for supporting CP110 UTMI
> PHY in Linux. Currently the functionality of USB ports connected to
> this PHY depends on boot loader setup.
> The new driver eliminates kernel configuration dependency from the boot
> loader. 
>
> v3:
> - rebase on top of Linux 5.12-rc2
> - convert Armada 3700 UTMI PHY DT binding document to YAML schema
> - create a separate DT binding for Armada CP11x UTMI PHY in YAML format
> - change UTMI PHY port node names from "phy" to "usb-phy"
>
> v2:
> - extend the comment about reference clock 
> - fix driver probe function, add some prints
> - move to usage of dr_mode from connected USB controller instead of
>   dedicated device tree property
>
> Konstantin Porotchkin (5):
>   drivers: phy: add support for Armada CP110 UTMI PHY
>   dt-bindings: phy: convert phy-mvebu-utmi to YAML schema
>   devicetree/bindings: add support for CP110 UTMI PHY
>   arch/arm64: dts: add support for Marvell CP110 UTMI PHY
>   arch/arm64: dts: enable CP110 UTMI PHY usage

Patch 4 and 5 applied on mvebu/dt64.

I've just modified the title to align with the other commits in
arch/arm64/boot/dts/marvell. They now begin by "arm64: dts: marvell:".

Thanks,

Gregory


>
>  .../phy/marvell,armada-3700-utmi-phy.yaml     |  57 +++
>  .../phy/marvell,armada-cp110-utmi-phy.yaml    | 109 +++++
>  .../bindings/phy/phy-mvebu-utmi.txt           |  38 --
>  .../arm64/boot/dts/marvell/armada-7040-db.dts |  14 +-
>  .../arm64/boot/dts/marvell/armada-8040-db.dts |  21 +-
>  .../boot/dts/marvell/armada-8040-mcbin.dtsi   |  19 +-
>  arch/arm64/boot/dts/marvell/armada-cp11x.dtsi |  19 +
>  arch/arm64/boot/dts/marvell/cn9130-db.dts     |  12 +-
>  arch/arm64/boot/dts/marvell/cn9131-db.dts     |   9 +-
>  arch/arm64/boot/dts/marvell/cn9132-db.dts     |  11 +-
>  drivers/phy/marvell/Kconfig                   |   8 +
>  drivers/phy/marvell/Makefile                  |   1 +
>  drivers/phy/marvell/phy-mvebu-cp110-utmi.c    | 384 ++++++++++++++++++
>  13 files changed, 650 insertions(+), 52 deletions(-)
>  create mode 100644 Documentation/devicetree/bindings/phy/marvell,armada-3700-utmi-phy.yaml
>  create mode 100644 Documentation/devicetree/bindings/phy/marvell,armada-cp110-utmi-phy.yaml
>  delete mode 100644 Documentation/devicetree/bindings/phy/phy-mvebu-utmi.txt
>  create mode 100644 drivers/phy/marvell/phy-mvebu-cp110-utmi.c
>
> -- 
> 2.17.1
>

-- 
Gregory Clement, Bootlin
Embedded Linux and Kernel engineering
http://bootlin.com
