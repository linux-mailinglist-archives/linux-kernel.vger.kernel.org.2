Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B543734CD89
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Mar 2021 12:01:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232620AbhC2KBd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 29 Mar 2021 06:01:33 -0400
Received: from esa.microchip.iphmx.com ([68.232.154.123]:53767 "EHLO
        esa.microchip.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231755AbhC2KBG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 Mar 2021 06:01:06 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1617012067; x=1648548067;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=goA/VATcwnFmBmk+CMANyWIQ8ldin4wUy5CxoZ/djng=;
  b=xThXZ4vf70Kqor9io4uxJ8X6L8RmzAaT9d/w9moFF00CmeWyjEsiSx3e
   XSU1AzYelVBPgcw24PnokgkctfjyMuFvE4eh2+ANdHe5UsoZcIM9UICuE
   6jL1NLa0NjR6JuplgpHpLS+WoBqDTjynqlep/gUy1VPCD9SROsFZWUPBD
   CBoEdjcPc59aUyviXnomS3mmhRrpuQdcvvddrLwoqMWpTwxsuQ1LdY2kG
   62dp5AYjpeji+pLfVYOlHCnNdGsnfN9CFo0o6uFWY5am5d4bnZDoxA9Jr
   JqDFNn+/D9ErcBGcXvPYXoEzsZPeYGYQX2aMKtBkxinLcQ1L7G7NUP+ew
   A==;
IronPort-SDR: kxSgVmdMMUQDEAUQ4owKOgLO4o6x0SGwzxiHVxOxnNHGnKD7XYBPbHvhZFbh+46L76PF5eyCNs
 x9Sk1xEC5CSkIQCR7AKzF9EV/ky5S2QT6Pk/tGBovEJuzL7felhZXn5y+/TiUigBw1IKZQBlMD
 U0JUfkPU/A8Krr5t+AugPxhz0jVf+NR7gdK7S97251V127vqAHyl08bjv+ogIsS9HGG/A1ac7l
 33qjlDmnr+4z5gAZQZF9rxMCsvLaZppEId14wW5QfyZtYwWGN3PhxHyXgPWVYUNS0Ych3l+VT5
 GLU=
X-IronPort-AV: E=Sophos;i="5.81,287,1610434800"; 
   d="scan'208";a="111696123"
Received: from smtpout.microchip.com (HELO email.microchip.com) ([198.175.253.82])
  by esa2.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 29 Mar 2021 03:01:06 -0700
Received: from chn-vm-ex02.mchp-main.com (10.10.85.144) by
 chn-vm-ex03.mchp-main.com (10.10.85.151) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2176.2; Mon, 29 Mar 2021 03:01:06 -0700
Received: from localhost.localdomain (10.10.115.15) by
 chn-vm-ex02.mchp-main.com (10.10.85.144) with Microsoft SMTP Server id
 15.1.2176.2 via Frontend Transport; Mon, 29 Mar 2021 03:01:03 -0700
From:   <nicolas.ferre@microchip.com>
To:     <linux-arm-kernel@lists.infradead.org>
CC:     <linux-kernel@vger.kernel.org>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>,
        Ludovic Desroches <ludovic.desroches@microchip.com>,
        Codrin Ciubotariu <codrin.ciubotariu@microchip.com>,
        Claudiu Beznea <claudiu.beznea@microchip.com>,
        Eugen Hristev <eugen.hristev@microchip.com>,
        Tudor Ambarus <tudor.ambarus@microchip.com>,
        Cristian Birsan <cristian.birsan@microchip.com>,
        <emil.velikov@collabora.com>, <ezequiel@collabora.com>
Subject: [PATCH 2/7] ARM: configs: at91: sama5: PIOBU as built-in
Date:   Mon, 29 Mar 2021 11:56:40 +0200
Message-ID: <3133badba54c6c92ad628a1671b5e6dc6cdd060d.1617010856.git.nicolas.ferre@microchip.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <cover.1617010856.git.nicolas.ferre@microchip.com>
References: <cover.1617010856.git.nicolas.ferre@microchip.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Razvan Stefanescu <razvan.stefanescu@microchip.com>

Include as built-in as it's used by multiple boards.

Signed-off-by: Razvan Stefanescu <razvan.stefanescu@microchip.com>
[nicolas.ferre@microchip.com: adap to newer kernel]
Signed-off-by: Nicolas Ferre <nicolas.ferre@microchip.com>
---
 arch/arm/configs/sama5_defconfig | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm/configs/sama5_defconfig b/arch/arm/configs/sama5_defconfig
index 72e58a835c37..26222046a9cb 100644
--- a/arch/arm/configs/sama5_defconfig
+++ b/arch/arm/configs/sama5_defconfig
@@ -123,7 +123,7 @@ CONFIG_SPI_ATMEL=y
 CONFIG_SPI_ATMEL_QUADSPI=y
 CONFIG_SPI_GPIO=y
 CONFIG_GPIO_SYSFS=y
-CONFIG_GPIO_SAMA5D2_PIOBU=m
+CONFIG_GPIO_SAMA5D2_PIOBU=y
 CONFIG_POWER_RESET=y
 CONFIG_POWER_SUPPLY=y
 CONFIG_BATTERY_ACT8945A=y
-- 
2.31.1

