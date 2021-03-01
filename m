Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3619D32933C
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Mar 2021 22:10:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244028AbhCAVIf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 1 Mar 2021 16:08:35 -0500
Received: from esa.microchip.iphmx.com ([68.232.153.233]:12062 "EHLO
        esa.microchip.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237797AbhCARNV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Mar 2021 12:13:21 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1614618799; x=1646154799;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=GNe5qxOScaDRkau7kWsGzTtDQtpnbj9n+i9KnLZKnoc=;
  b=R65GkzK5mBHzUo1swoF/VU3PC9DpB/YdVCN4U46lcWV+doPdxUw+3ApV
   upoER0/ccG6CjPGrlO6kC3JuRSKoKwAoPNkrOeN7ugTarAVwDbDSC0ci5
   lX+98ki5xCLfa9gs+ISF2fnQPWHlVXG7ejBY94lE8OIr9hTYLHEDkKlEg
   H910XAyiEQ2YDlK7ft1vZ0JmPPAu5uA0a7EsLZ5YSCZkAEGXkovZfJ51m
   uBebuelOVBmnrJadGBn5iLNTxJ9dOm0KuisEQzBMaFho5vAE1/XFi9g9Q
   lg2d8BjnLzzHYI/7N/kVffaSVoDSt7K9d58s/87R2Xm/DxPQtFuUxJIm5
   w==;
IronPort-SDR: b1QKTRCL3OutM/khAUSHwQaIZo1GLML5eG0GIeYcLd6sZjl5QEn4lmJem+pA6p0jehOadPGDZD
 kJo832DwQhMdCQKpFfF8SAnscOqbhjFNxIovjQlYKDXaiyycRCP+T6RtpjhAprVp/0w9GrQCqe
 JOqX5DcXNDDeHWBw7VQq3RPirpORyhT67Xf6hM/RxsGLbaikatudmZ/gLiT+MXKzed0iQZrMsQ
 0OVoXF/CITxhBFcAA+PAq8jiEDWwvaFcMuNjqcG8Q841PCmo4J1X5TrEz3542EroMsv7qOoYUT
 VFo=
X-IronPort-AV: E=Sophos;i="5.81,215,1610434800"; 
   d="scan'208";a="111511668"
Received: from smtpout.microchip.com (HELO email.microchip.com) ([198.175.253.82])
  by esa3.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 01 Mar 2021 10:09:46 -0700
Received: from chn-vm-ex04.mchp-main.com (10.10.85.152) by
 chn-vm-ex03.mchp-main.com (10.10.85.151) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1979.3; Mon, 1 Mar 2021 10:09:41 -0700
Received: from rob-ult-m19940.amer.actel.com (10.10.115.15) by
 chn-vm-ex04.mchp-main.com (10.10.85.152) with Microsoft SMTP Server id
 15.1.1979.3 via Frontend Transport; Mon, 1 Mar 2021 10:09:38 -0700
From:   Codrin Ciubotariu <codrin.ciubotariu@microchip.com>
To:     <alsa-devel@alsa-project.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>
CC:     <lgirdwood@gmail.com>, <broonie@kernel.org>, <robh+dt@kernel.org>,
        <perex@perex.cz>, <tiwai@suse.com>, <nicolas.ferre@microchip.com>,
        <alexandre.belloni@bootlin.com>, <ludovic.desroches@microchip.com>,
        "Codrin Ciubotariu" <codrin.ciubotariu@microchip.com>
Subject: [PATCH v2 2/7] ASoC: mchp-i2s-mcc: Add compatible for SAMA7G5
Date:   Mon, 1 Mar 2021 19:09:00 +0200
Message-ID: <20210301170905.835091-3-codrin.ciubotariu@microchip.com>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20210301170905.835091-1-codrin.ciubotariu@microchip.com>
References: <20210301170905.835091-1-codrin.ciubotariu@microchip.com>
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

Changes in v2:
- none

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

