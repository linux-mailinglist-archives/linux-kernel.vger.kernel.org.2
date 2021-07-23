Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DEA7D3D3AC5
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Jul 2021 14:58:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235148AbhGWMSI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 23 Jul 2021 08:18:08 -0400
Received: from relay3-d.mail.gandi.net ([217.70.183.195]:54991 "EHLO
        relay3-d.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234952AbhGWMSG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 23 Jul 2021 08:18:06 -0400
Received: (Authenticated sender: gregory.clement@bootlin.com)
        by relay3-d.mail.gandi.net (Postfix) with ESMTPSA id 884156000E;
        Fri, 23 Jul 2021 12:58:37 +0000 (UTC)
From:   Gregory CLEMENT <gregory.clement@bootlin.com>
To:     kostap@marvell.com, miquel.raynal@bootlin.com, kishon@ti.com,
        vkoul@kernel.org, robh+dt@kernel.org, andrew@lunn.ch,
        sebastian.hesselbarth@gmail.com, vladimir.vid@sartura.hr,
        luka.kovacic@sartura.hr, linux-phy@lists.infradead.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org
Cc:     mw@semihalf.com, jaz@semihalf.com, nadavh@marvell.com,
        stefanc@marvell.com, bpeled@marvell.com,
        Konstantin Porotchkin <kostap@marvell.com>
Subject: Re: [PATCH v7 0/5] DTS updates for Marvell Armada CN913x platforms
In-Reply-To: <20210708124612.30742-1-kostap@marvell.com>
References: <20210708124612.30742-1-kostap@marvell.com>
Date:   Fri, 23 Jul 2021 14:58:37 +0200
Message-ID: <87fsw5191e.fsf@BL-laptop>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Kosta,

> From: Konstantin Porotchkin <kostap@marvell.com>
>
> This patch series contains the following changes/fixes:
> 1. Add support for Armada CN913x Development Board topology "B"
> 2. Add support for Armada CN913x Reference Design boards (CRB)
> 3. Fixes the NAND paritioninig scheme in DTS eliminating gap between
>    consecutive partitions
> 4. Fix 10Gb ports PHY mode names
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
> v5:
> - Extend enablement of 10G port to CN9131-DB platform
>
> v6:
> - Rebased on top of 5.13-rc, merging UTMI settings
>   (requested by Gregory Clement)
>
> v7:
> - Remove documentation patch fixing CP11X references in PHY binding document
> - Change Armada's family 10Gb port phy mode names from 10gbase-kr to 10gbase-r
>
> Konstantin Porotchkin (4):
>   arch/arm64/boot/dts/marvell: fix NAND partitioning scheme
>   arm64: dts: cn913x: add device trees for topology B boards
>   arm64: dts: add support for Marvell cn9130-crb platform
>   arch/arm64: dts: change 10gbase-kr to 10gbase-r in Armada
>
> Stefan Chulski (1):
>   dts: marvell: Enable 10G interfaces on 9130-DB and 9131-DB boards
>

Series applied on mvebu/dt64

Thanks,

Gregory


>  arch/arm64/boot/dts/marvell/Makefile          |   5 +
>  .../arm64/boot/dts/marvell/armada-7040-db.dts |   2 +-
>  .../arm64/boot/dts/marvell/armada-8040-db.dts |   4 +-
>  arch/arm64/boot/dts/marvell/cn9130-crb-A.dts  |  38 ++
>  arch/arm64/boot/dts/marvell/cn9130-crb-B.dts  |  46 ++
>  arch/arm64/boot/dts/marvell/cn9130-crb.dtsi   | 222 ++++++++++
>  arch/arm64/boot/dts/marvell/cn9130-db-B.dts   |  22 +
>  arch/arm64/boot/dts/marvell/cn9130-db.dts     | 403 +----------------
>  arch/arm64/boot/dts/marvell/cn9130-db.dtsi    | 410 ++++++++++++++++++
>  arch/arm64/boot/dts/marvell/cn9131-db-B.dts   |  22 +
>  arch/arm64/boot/dts/marvell/cn9131-db.dts     | 197 +--------
>  arch/arm64/boot/dts/marvell/cn9131-db.dtsi    | 206 +++++++++
>  arch/arm64/boot/dts/marvell/cn9132-db-B.dts   |  22 +
>  arch/arm64/boot/dts/marvell/cn9132-db.dts     | 218 +---------
>  arch/arm64/boot/dts/marvell/cn9132-db.dtsi    | 227 ++++++++++
>  15 files changed, 1241 insertions(+), 803 deletions(-)
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
