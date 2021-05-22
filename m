Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BD0AC38D3C6
	for <lists+linux-kernel@lfdr.de>; Sat, 22 May 2021 07:10:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231320AbhEVFLf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 22 May 2021 01:11:35 -0400
Received: from muru.com ([72.249.23.125]:58804 "EHLO muru.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229914AbhEVFLe (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 22 May 2021 01:11:34 -0400
Received: from hillo.muru.com (localhost [127.0.0.1])
        by muru.com (Postfix) with ESMTP id B65E780C0;
        Sat, 22 May 2021 05:10:13 +0000 (UTC)
From:   Tony Lindgren <tony@atomide.com>
To:     Lee Jones <lee.jones@linaro.org>
Cc:     linux-kernel@vger.kernel.org,
        Carl Philipp Klemm <philipp@uvos.xyz>,
        Ivan Jelincic <parazyd@dyne.org>,
        Merlijn Wajer <merlijn@wizzup.org>,
        Pavel Machek <pavel@ucw.cz>,
        Sebastian Reichel <sre@kernel.org>,
        "Sicelo A . Mhlongo" <absicsz@gmail.com>
Subject: [PATCH] mfd: cpcap: Fix cpcap dmamask not set warnings
Date:   Sat, 22 May 2021 08:10:01 +0300
Message-Id: <20210522051001.53060-1-tony@atomide.com>
X-Mailer: git-send-email 2.31.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

We have started to get a bunch of pointless dmamask not set warnings
that makes the output of dmesg -l err,warn hard to read with many
extra warnings:

cpcap-regulator cpcap-regulator.0: DMA mask not set
cpcap_adc cpcap_adc.0: DMA mask not set
cpcap_battery cpcap_battery.0: DMA mask not set
cpcap-charger cpcap-charger.0: DMA mask not set
cpcap-pwrbutton cpcap-pwrbutton.0: DMA mask not set
cpcap-led cpcap-led.0: DMA mask not set
cpcap-led cpcap-led.1: DMA mask not set
cpcap-led cpcap-led.2: DMA mask not set
cpcap-led cpcap-led.3: DMA mask not set
cpcap-led cpcap-led.4: DMA mask not set
cpcap-rtc cpcap-rtc.0: DMA mask not set
cpcap-usb-phy cpcap-usb-phy.0: DMA mask not set

This seems to have started with commit 4d8bde883bfb ("OF: Don't set
default coherent DMA mask"). We have the parent SPI controller use
DMA, while CPCAP driver and it's children do not. For audio, the
DMA is handled over I2S bus with the McBSP driver.

Cc: Carl Philipp Klemm <philipp@uvos.xyz>
Cc: Ivan Jelincic <parazyd@dyne.org>
Cc: Merlijn Wajer <merlijn@wizzup.org>
Cc: Pavel Machek <pavel@ucw.cz>
Cc: Sebastian Reichel <sre@kernel.org>
Cc: Sicelo A. Mhlongo <absicsz@gmail.com>
Signed-off-by: Tony Lindgren <tony@atomide.com>
---
 drivers/mfd/motorola-cpcap.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/drivers/mfd/motorola-cpcap.c b/drivers/mfd/motorola-cpcap.c
--- a/drivers/mfd/motorola-cpcap.c
+++ b/drivers/mfd/motorola-cpcap.c
@@ -327,6 +327,10 @@ static int cpcap_probe(struct spi_device *spi)
 	if (ret)
 		return ret;
 
+	/* Parent SPI controller uses DMA, CPCAP and child devices do not */
+	spi->dev.coherent_dma_mask = 0;
+	spi->dev.dma_mask = &spi->dev.coherent_dma_mask;
+
 	return devm_mfd_add_devices(&spi->dev, 0, cpcap_mfd_devices,
 				    ARRAY_SIZE(cpcap_mfd_devices), NULL, 0, NULL);
 }
-- 
2.31.1
