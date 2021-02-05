Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E8E79310B1C
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Feb 2021 13:34:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232147AbhBEMdZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 5 Feb 2021 07:33:25 -0500
Received: from esa.microchip.iphmx.com ([68.232.154.123]:63518 "EHLO
        esa.microchip.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231757AbhBEM3p (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 5 Feb 2021 07:29:45 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1612528184; x=1644064184;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=9u3i8Yg6h1PHkJnzPW5ztDqwmTdV0zuKMkau8oPFBg0=;
  b=uPj9xGom5CXI5rCuoqb+aVM6hTFlru1qRryta/31em9Nr8TH9wz0VNvN
   LRlO3+F/VbZ6y9Yep3WT5RXwB+9HfZ/2uVX0/r4m1CGezZGKMon5R5FDt
   Uw1Hf1euQPB82BWojzTV8HRgKW8dHgbQd0U1ohs7hQyFTsCgvM8oLcQxe
   J9xanHxmGctj4suqqvfUFHjSJ+xWvZ5iD0Lco0j0jnwHYljy9A2ApF5aK
   IhdBroU2H8ZxXDvDcjWnBQDJDebriQetH6ilf9XYC5WEuD9bHYP9jiXiK
   praPsLgMzjySOfQEm/pB+QQIHOdsSv7gxrAFgwuxckCBqZR+crTdQx/AC
   A==;
IronPort-SDR: Xd3vr+BFmmZXFIKZrps9aJ/Btf4ovlHZKKejkJg4GscS2NDmF//RwVg07l2It7n/RE/atQPQA1
 gLzA3ICqo3DuqIPUbGoAVRR0mz6hu66Dtega9Qvvd6mSxpExH5H8E4k23ahxmZExNvcW6qAg3n
 mnuAhxHUOmynP53I33nND5Rq/2vjcyRfgntnY3iJ9sx06R1Q1A/jJ8+6NVKOYHoRPQM+SQZupQ
 /Gmbe3POIt2o4+8pFe6MvfVqt8N8Epj+0wnuiy4f8irFRNzvXmycyjpwr80O6Az/GZPvYCfRkf
 jxo=
X-IronPort-AV: E=Sophos;i="5.81,154,1610434800"; 
   d="scan'208";a="102734006"
Received: from smtpout.microchip.com (HELO email.microchip.com) ([198.175.253.82])
  by esa4.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 05 Feb 2021 05:28:11 -0700
Received: from chn-vm-ex02.mchp-main.com (10.10.85.144) by
 chn-vm-ex03.mchp-main.com (10.10.85.151) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1979.3; Fri, 5 Feb 2021 05:28:10 -0700
Received: from localhost.localdomain (10.10.115.15) by
 chn-vm-ex02.mchp-main.com (10.10.85.144) with Microsoft SMTP Server id
 15.1.1979.3 via Frontend Transport; Fri, 5 Feb 2021 05:28:09 -0700
From:   <nicolas.ferre@microchip.com>
To:     Alexandre Belloni <alexandre.belloni@bootlin.com>,
        Ludovic Desroches <ludovic.desroches@microchip.com>
CC:     <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        Nicolas Ferre <nicolas.ferre@microchip.com>
Subject: [PATCH 3/3] ARM: configs: at91_dt_defconfig: add useful helper options
Date:   Fri, 5 Feb 2021 13:27:56 +0100
Message-ID: <609f6193e709a5b8762735b949972b855218652b.1612528021.git.nicolas.ferre@microchip.com>
X-Mailer: git-send-email 2.30.0
In-Reply-To: <bc06f0943bd93dd8c7e2f763f792074ce79c5b64.1612528021.git.nicolas.ferre@microchip.com>
References: <bc06f0943bd93dd8c7e2f763f792074ce79c5b64.1612528021.git.nicolas.ferre@microchip.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Nicolas Ferre <nicolas.ferre@microchip.com>

Add GPIO, SPI and I2C options that were missing from the
at91_dt_defconfig whereas they were in sama5_defconfig. It unifies all
AT91 defconfigs with same set of useful options.

Signed-off-by: Nicolas Ferre <nicolas.ferre@microchip.com>
---
 arch/arm/configs/at91_dt_defconfig | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/arch/arm/configs/at91_dt_defconfig b/arch/arm/configs/at91_dt_defconfig
index 3e4adbd30a53..edd888214873 100644
--- a/arch/arm/configs/at91_dt_defconfig
+++ b/arch/arm/configs/at91_dt_defconfig
@@ -107,10 +107,13 @@ CONFIG_LEGACY_PTY_COUNT=4
 CONFIG_SERIAL_ATMEL=y
 CONFIG_SERIAL_ATMEL_CONSOLE=y
 CONFIG_HW_RANDOM=y
+CONFIG_I2C_CHARDEV=y
 CONFIG_I2C_AT91=y
 CONFIG_I2C_GPIO=y
 CONFIG_SPI=y
 CONFIG_SPI_ATMEL=y
+CONFIG_SPI_GPIO=y
+CONFIG_GPIO_SYSFS=y
 CONFIG_SPI_ATMEL_QUADSPI=y
 CONFIG_PINCTRL_MCP23S08=m
 CONFIG_POWER_RESET=y
-- 
2.30.0

