Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5A3BB41DE2C
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Sep 2021 17:56:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347255AbhI3P63 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 30 Sep 2021 11:58:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56756 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346680AbhI3P62 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Sep 2021 11:58:28 -0400
Received: from mail.fris.de (mail.fris.de [IPv6:2a01:4f8:c2c:390b::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6BC6FC06176A;
        Thu, 30 Sep 2021 08:56:45 -0700 (PDT)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 9564FBFBD8;
        Thu, 30 Sep 2021 17:56:42 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fris.de; s=dkim;
        t=1633017403; h=from:subject:date:message-id:to:cc:mime-version:
         content-transfer-encoding; bh=XBSu7hJpYwdszH0R07z1b1OPV/Szsg9EeM9Pfix0hJw=;
        b=g2efb4U6oV/lyf4K8utbp67YJKWaOAGhQT77WVpKGKhfx9KJhrFWUqzdebyw5nGqXzqPuD
        j6aw+OxRx5yCc5qQ5NunT8oQV/xXKkBYngttI/+8wMQtXCEsv6oJhPBxZKhSNhM3nhTGiW
        wDF/1mbXpMiGbvtdRHPAMHIwCs3zLFEQZhLffznDHawISg22esg/db7I2xOLpG+Brooxwl
        hnw5R2KtyOipDAoMqk57B55+pxP1hRDbjhg0UykLughXGPNq9AudF7SYzYyFH6TkY4DJO5
        WAM0Hk8QGVVkeU3lmFql0kTkW6DK4HBllUILe4Bb3gYASQyEqcjAJ6xGohYyCw==
From:   Frieder Schrempf <frieder@fris.de>
To:     devicetree@vger.kernel.org,
        Frieder Schrempf <frieder.schrempf@kontron.de>,
        Krzysztof Kozlowski <krzk@kernel.org>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Shawn Guo <shawnguo@kernel.org>
Cc:     Rob Herring <robh+dt@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>
Subject: [PATCH 0/8] Devicetree fixes and additions for Kontron SL/BL i.MX8MM boards
Date:   Thu, 30 Sep 2021 17:56:23 +0200
Message-Id: <20210930155633.2745201-1-frieder@fris.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Last-TLS-Session-Version: TLSv1.3
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Frieder Schrempf <frieder.schrempf@kontron.de>

This is a set of enhancements and fixes for the devicetrees of the Kontron
SL/BL i.MX8MM SoMs and boards.

Frieder Schrempf (8):
  arm64: dts: imx8mm-kontron: Add support for ultra high speed modes on
    SD card
  arm64: dts: imx8mm-kontron: Make sure SOC and DRAM supply voltages are
    correct
  arm64: dts: imx8mm-kontron: Set VDD_SNVS to 800 mV
  arm64: dts: imx8mm-kontron: Fix reg_rst_eth2 and reg_vdd_5v regulators
  arm64: dts: imx8mm-kontron: Fix CAN SPI clock frequency
  arm64: dts: imx8mm-kontron: Fix connection type for VSC8531 RGMII PHY
  arm64: dts: imx8mm-kontron: Fix reset delays for ethernet PHY
  arm64: dts: imx8mm-kontron: Leave reg_vdd_arm always powered on

 .../dts/freescale/imx8mm-kontron-n801x-s.dts  | 41 ++++++++++++++++---
 .../freescale/imx8mm-kontron-n801x-som.dtsi   | 13 ++++--
 2 files changed, 44 insertions(+), 10 deletions(-)

-- 
2.33.0

