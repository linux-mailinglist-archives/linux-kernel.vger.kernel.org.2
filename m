Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AF70E3AB7B4
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Jun 2021 17:40:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233366AbhFQPmN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 17 Jun 2021 11:42:13 -0400
Received: from relay4-d.mail.gandi.net ([217.70.183.196]:46723 "EHLO
        relay4-d.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232638AbhFQPmM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Jun 2021 11:42:12 -0400
Received: (Authenticated sender: gregory.clement@bootlin.com)
        by relay4-d.mail.gandi.net (Postfix) with ESMTPSA id 17061E000E;
        Thu, 17 Jun 2021 15:40:00 +0000 (UTC)
From:   Gregory CLEMENT <gregory.clement@bootlin.com>
To:     kostap@marvell.com, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Cc:     vladimir.vid@sartura.hr, tmn505@gmail.com, luka.kovacic@sartura.hr,
        sebastian.hesselbarth@gmail.com, andrew@lunn.ch,
        robh+dt@kernel.org, vkoul@kernel.org, kishon@ti.com,
        miquel.raynal@bootlin.com, mw@semihalf.com, jaz@semihalf.com,
        nadavh@marvell.com, stefanc@marvell.com, bpeled@marvell.com,
        Konstantin Porotchkin <kostap@marvell.com>
Subject: Re: [PATCH v4 0/5] DTS updates for Marvell Armada CN913x platforms
In-Reply-To: <20210209134610.19904-1-kostap@marvell.com>
References: <20210209134610.19904-1-kostap@marvell.com>
Date:   Thu, 17 Jun 2021 17:40:00 +0200
Message-ID: <87h7hw1ovj.fsf@BL-laptop>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

> From: Konstantin Porotchkin <kostap@marvell.com>
>
> This patch series contains the following changes/fixes:
> 1. Add support for Armada CN913x Development Board topology "B"
> 2. Add support for Armada CN913x Reference Design boards (CRB)
> 3. Fixes the CP11X references in PHY binding document
> 4. Fixes the NAND paritioninig scheme in DTS eliminating gap between
> consecutive partitions
> All above changes are already intergated into Marvell official SDK sources
>
> v2:
> - extract common nodes from DB boards to separate DTSI files
> - disable eth2 on CRB boards until the required phy mode support is added
> - mention the switch part ID in CRB board description
>
> v3:
> - do not rename setup A DTS files for DB variants
> - fix a couple of wrong include names
>
> v4:
> - Rebase on top of Linus master branch (v5.11-rc7)
> - Remove HS400 timing from CRB AP SDHCI (not supported by connected eMMC)
> - Add cd-gpio entry to CP0 SDHCI for SD card support
> - Add a comment to CN9130-CRB patch about the required defconfig
>   changes for supporting the onboard i2c expander
> - Add Stefan's patch to enable 10G port on CN9130-DB platforms
>
> Grzegorz Jaszczyk (1):
>   Documentation/bindings: phy: update references to cp11x
>
> Konstantin Porotchkin (3):
>   arch/arm64/boot/dts/marvell: fix NAND partitioning scheme
>   arm64: dts: cn913x: add device trees for topology B boards
>   arm64: dts: add support for Marvell cn9130-crb platform
>
> Stefan Chulski (1):
>   dts: marvell: Enable 10G interface on 9130-DB board
>

I've applied patches 1 and 2, but I have issue with patch 3, there was some
changes around the phys and I am not sure of the correct way to modify
the patch.

Could you rebase it on v5.13-c1 and fix the merge issue ?

Thanks,

Gregory

>  .../bindings/phy/phy-mvebu-comphy.txt         |  12 +-
>  arch/arm64/boot/dts/marvell/Makefile          |   5 +
>  arch/arm64/boot/dts/marvell/cn9130-crb-A.dts  |  38 ++
>  arch/arm64/boot/dts/marvell/cn9130-crb-B.dts  |  46 ++
>  arch/arm64/boot/dts/marvell/cn9130-crb.dtsi   | 221 ++++++++++
>  arch/arm64/boot/dts/marvell/cn9130-db-B.dts   |  22 +
>  arch/arm64/boot/dts/marvell/cn9130-db.dts     | 393 +----------------
>  arch/arm64/boot/dts/marvell/cn9130-db.dtsi    | 402 ++++++++++++++++++
>  arch/arm64/boot/dts/marvell/cn9131-db-B.dts   |  22 +
>  arch/arm64/boot/dts/marvell/cn9131-db.dts     | 192 +--------
>  arch/arm64/boot/dts/marvell/cn9131-db.dtsi    | 201 +++++++++
>  arch/arm64/boot/dts/marvell/cn9132-db-B.dts   |  22 +
>  arch/arm64/boot/dts/marvell/cn9132-db.dts     | 211 +--------
>  arch/arm64/boot/dts/marvell/cn9132-db.dtsi    | 220 ++++++++++
>  14 files changed, 1223 insertions(+), 784 deletions(-)
>  create mode 100644 arch/arm64/boot/dts/marvell/cn9130-crb-A.dts
>  create mode 100644 arch/arm64/boot/dts/marvell/cn9130-crb-B.dts
>  create mode 100644 arch/arm64/boot/dts/marvell/cn9130-crb.dtsi
>  create mode 100644 arch/arm64/boot/dts/marvell/cn9130-db-B.dts
>  create mode 100644 arch/arm64/boot/dts/marvell/cn9130-db.dtsi
>  create mode 100644 arch/arm64/boot/dts/marvell/cn9131-db-B.dts
>  create mode 100644 arch/arm64/boot/dts/marvell/cn9131-db.dtsi
>  create mode 100644 arch/arm64/boot/dts/marvell/cn9132-db-B.dts
>  create mode 100644 arch/arm64/boot/dts/marvell/cn9132-db.dtsi
>
> -- 
> 2.17.1
>

-- 
Gregory Clement, Bootlin
Embedded Linux and Kernel engineering
http://bootlin.com
