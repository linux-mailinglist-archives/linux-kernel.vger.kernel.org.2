Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 961C742F151
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Oct 2021 14:49:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239030AbhJOMvQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 15 Oct 2021 08:51:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59988 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239000AbhJOMvO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Oct 2021 08:51:14 -0400
Received: from mail.fris.de (mail.fris.de [IPv6:2a01:4f8:c2c:390b::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A56A6C061570;
        Fri, 15 Oct 2021 05:49:00 -0700 (PDT)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 64CFBBFBEC;
        Fri, 15 Oct 2021 14:48:45 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fris.de; s=dkim;
        t=1634302126; h=from:subject:date:message-id:to:cc:mime-version:
         content-transfer-encoding; bh=lOn7NeO59/Fi4i0OML9CVZB/3oE8KtVxjm9Mthzxob0=;
        b=AHidvNU4wPFKekFfxWqIl9Ad58/SWqIYNn4C6mnyOvVAfcfLbYmozT/hhjhseHhuIe7hVY
        Ke3a/hxiYq0OZSOqueAN5ynCEHRSym2fMEwn6m2lmeKvf4dQIZ0uXYNVeEctNxUUkMkg9b
        WePg7mol4OygzeMGuyhVnkfbPfurKpCM/tarMLuXRzr86vaGvLQrOaJFbXyl6CK6G7XwFf
        UEmPYV+7U6HG8PsFHCTMkHpOVoLsDwSJNOy6bJVx8+5LqZJWJztt9946MrM8r6xHPWm3Aj
        dj2jGgF+fiS2H+7NO4L6yKNY32AjiLA9IM5m4C4DHOpgvDU+wMqKK60l1b/vBw==
From:   Frieder Schrempf <frieder@fris.de>
To:     devicetree@vger.kernel.org,
        Frieder Schrempf <frieder.schrempf@kontron.de>,
        Krzysztof Kozlowski <krzk@kernel.org>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Shawn Guo <shawnguo@kernel.org>
Cc:     Rob Herring <robh+dt@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>
Subject: [PATCH v2 0/6] Devicetree fixes and additions for Kontron SL/BL i.MX8MM boards
Date:   Fri, 15 Oct 2021 14:48:34 +0200
Message-Id: <20211015124841.28226-1-frieder@fris.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Last-TLS-Session-Version: TLSv1.3
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Frieder Schrempf <frieder.schrempf@kontron.de>

This is a set of enhancements and fixes for the devicetrees of the Kontron
SL/BL i.MX8MM SoMs and boards.

See the individual patches for more information and changelogs.

For v2, the review comments from Shawn ahve been taken into account
(thanks!) and the patches 7 and 8 have been dropped, as they were already
applied separately.

Frieder Schrempf (6):
  arm64: dts: imx8mm-kontron: Add support for ultra high speed modes on
    SD card
  arm64: dts: imx8mm-kontron: Make sure SOC and DRAM supply voltages are
    correct
  arm64: dts: imx8mm-kontron: Set lower limit of VDD_SNVS to 800 mV
  arm64: dts: imx8mm-kontron: Fix polarity of reg_rst_eth2
  arm64: dts: imx8mm-kontron: Fix CAN SPI clock frequency
  arm64: dts: imx8mm-kontron: Fix connection type for VSC8531 RGMII PHY

 .../dts/freescale/imx8mm-kontron-n801x-s.dts  | 36 ++++++++++++++++---
 .../freescale/imx8mm-kontron-n801x-som.dtsi   | 10 ++++--
 2 files changed, 39 insertions(+), 7 deletions(-)

-- 
2.33.0
