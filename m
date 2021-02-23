Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A3AE7323089
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Feb 2021 19:21:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233925AbhBWSVj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 23 Feb 2021 13:21:39 -0500
Received: from esa.microchip.iphmx.com ([68.232.154.123]:35696 "EHLO
        esa.microchip.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233148AbhBWSVY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 Feb 2021 13:21:24 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1614104484; x=1645640484;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=MEjpyHn2CDjnPfxkT2wEky1s6pdVTEwsRbTZKg0ovic=;
  b=iaa1riWKR0hcSRKVFUmn+BUo+gv6WrEedGqzDOdbFi6KPgvc0NTFx7uW
   PdJIo+Ho59ZmNSoQZH/KwXI+xd39KH11Zw2bmV9n2ieTaHa2dd+Yi+aPa
   0YWD6QpsvKDHNeKEUl/QpzBrBl2suRu0eQ7VAs80BOsuc9Jhz02toN2Wv
   8eHSJB1KqFumx450bpHeZZ4uXKAh1ckc0gyFaH7fcYFy2dj2CP092ldEJ
   ftjwMf1h4qxB+XSmLO7XfeHDUl8ng0+GMiJL1tPeR2EGxV9bfdcSihesS
   Pfm2beb6O285HS8ccj+RPo55GE6TIkJ0K2jeH8JQrF/nsLVJKuWwgVh3X
   A==;
IronPort-SDR: rI5ETHQBkcWabJ2Bw7Ta9hW/E3dXsL1sV3yEBAiOVxZI0gvmhAz5cB4y1tdYEfMvApi+F58fVg
 mioJ1+7V7MDv/obCGqJ+LKvWxExfygRdwhXZmTmaHdtlr1j+2x84dU8FLFtZvjcyC38Ao9CpTX
 dTMcVYbWdfDCYBG+YHGpr2L8zpAyP+DZWg5EAXy2ulM8RcZcZhS8hycIgQPM+94VRcF01Ehmw9
 vhLASOJXO0L6HnwYdKuqYbKSowvuyaPTkkzZYkQ59Yv7qJbPXYHF+gZ86MWVqNRmX5fFEC0S7e
 rU4=
X-IronPort-AV: E=Sophos;i="5.81,200,1610434800"; 
   d="scan'208";a="104869134"
Received: from smtpout.microchip.com (HELO email.microchip.com) ([198.175.253.82])
  by esa4.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 23 Feb 2021 11:20:08 -0700
Received: from chn-vm-ex02.mchp-main.com (10.10.85.144) by
 chn-vm-ex04.mchp-main.com (10.10.85.152) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1979.3; Tue, 23 Feb 2021 11:20:08 -0700
Received: from rob-ult-m19940.amer.actel.com (10.10.115.15) by
 chn-vm-ex02.mchp-main.com (10.10.85.144) with Microsoft SMTP Server id
 15.1.1979.3 via Frontend Transport; Tue, 23 Feb 2021 11:20:05 -0700
From:   Codrin Ciubotariu <codrin.ciubotariu@microchip.com>
To:     <alsa-devel@alsa-project.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>
CC:     <lgirdwood@gmail.com>, <broonie@kernel.org>, <robh+dt@kernel.org>,
        <perex@perex.cz>, <tiwai@suse.com>, <nicolas.ferre@microchip.com>,
        <alexandre.belloni@bootlin.com>, <ludovic.desroches@microchip.com>,
        "Codrin Ciubotariu" <codrin.ciubotariu@microchip.com>
Subject: [PATCH 3/7] ASoC: mchp-i2s-mcc: Add compatible for SAMA7G5
Date:   Tue, 23 Feb 2021 20:19:25 +0200
Message-ID: <20210223181929.444640-4-codrin.ciubotariu@microchip.com>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20210223181929.444640-1-codrin.ciubotariu@microchip.com>
References: <20210223181929.444640-1-codrin.ciubotariu@microchip.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Microchip's new SAMA7G5 includes an updated I2S-MCC compatible with the
previous version found on SAM9X60. The new controller includes 8 (4 * 2)
input and output data pins for up to 8 channels for I2S and Left-Justified
formats.

Signed-off-by: Codrin Ciubotariu <codrin.ciubotariu@microchip.com>
---
 sound/soc/atmel/Kconfig        | 3 +++
 sound/soc/atmel/mchp-i2s-mcc.c | 3 +++
 2 files changed, 6 insertions(+)

diff --git a/sound/soc/atmel/Kconfig b/sound/soc/atmel/Kconfig
index 9fe9471f4514..ec04e3386bc0 100644
--- a/sound/soc/atmel/Kconfig
+++ b/sound/soc/atmel/Kconfig
@@ -127,10 +127,13 @@ config SND_MCHP_SOC_I2S_MCC
 	  Say Y or M if you want to add support for I2S Multi-Channel ASoC
 	  driver on the following Microchip platforms:
 	  - sam9x60
+	  - sama7g5
 
 	  The I2SMCC complies with the Inter-IC Sound (I2S) bus specification
 	  and supports a Time Division Multiplexed (TDM) interface with
 	  external multi-channel audio codecs.
+	  Starting with sama7g5, I2S and Left-Justified multi-channel is
+	  supported by using multiple data pins, output and input, without TDM.
 
 config SND_MCHP_SOC_SPDIFTX
 	tristate "Microchip ASoC driver for boards using S/PDIF TX"
diff --git a/sound/soc/atmel/mchp-i2s-mcc.c b/sound/soc/atmel/mchp-i2s-mcc.c
index 6d5ae18f8b38..0ee01383e307 100644
--- a/sound/soc/atmel/mchp-i2s-mcc.c
+++ b/sound/soc/atmel/mchp-i2s-mcc.c
@@ -873,6 +873,9 @@ static const struct of_device_id mchp_i2s_mcc_dt_ids[] = {
 	{
 		.compatible = "microchip,sam9x60-i2smcc",
 	},
+	{
+		.compatible = "microchip,sama7g5-i2smcc",
+	},
 	{ /* sentinel */ }
 };
 MODULE_DEVICE_TABLE(of, mchp_i2s_mcc_dt_ids);
-- 
2.27.0

