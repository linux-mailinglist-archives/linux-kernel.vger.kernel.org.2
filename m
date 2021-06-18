Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 47D543ACE49
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Jun 2021 17:08:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234183AbhFRPKI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 18 Jun 2021 11:10:08 -0400
Received: from esa.microchip.iphmx.com ([68.232.153.233]:63016 "EHLO
        esa.microchip.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229550AbhFRPKH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Jun 2021 11:10:07 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1624028878; x=1655564878;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=IzAFS24DfSTX6qaj3N/BA5FejAJqaXgVPe/qZtDzDi4=;
  b=gARg9mUH+PhlnTyLZBHFUp/8Y2VLTU3kCgxp0swNvxCtHuObrOo/hexG
   OYj/J6ydLU4omkUjSCTc3+i3NJ9RtkugEZLCAQg8Cpgt5j7VJD1MYcKeX
   kxThYudH2GhIkzZgOZzdhNpxyW1icsvXF6W7zLoO15QdvpQuFn2lV4Pfe
   Gd7zH8xti6wnf8TAQWfeGa8YJHNlFJeu8FrR/3MS+s5d088xUou4kToiv
   in0LxSGV4RcZGIEf0hZ1+3No4HVR7figxRxbJ3ksNo28BF8o5R78J9TIM
   LBjQEKliX0jcKT4zuLX0fTlBuV/WubUbgoBe1hbHHvEU7ftbvxZpMp7D6
   w==;
IronPort-SDR: f0mrNz8xIX6w1qwdLQ6vPQJ/IZFBjvXtlQkgIJ4IR6Nu/wq6XnA6SKquQtvZAUyAvCfHv/kxaA
 PXFKhBzDXJz1hxZu9awgHmYKkDuilMSofL/t3Tib497N4hL+sALEN4kdm4+4gVL8IEPwqycs7s
 A9h8JCHOj3SZjd08xRx9OhXuoskl/5eHzoHbeYAbcsnEP/Fl54e7vohoB7LPrzldxIYOM2BD/i
 EESX9WRtNTTpvjRfsSyY05+qtsmZTsAnGuN+IdJQ29U1loiNo9blCFJRNlU7itUGTSd/YVo5Co
 v4U=
X-IronPort-AV: E=Sophos;i="5.83,284,1616482800"; 
   d="scan'208";a="125835064"
Received: from smtpout.microchip.com (HELO email.microchip.com) ([198.175.253.82])
  by esa3.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 18 Jun 2021 08:07:57 -0700
Received: from chn-vm-ex04.mchp-main.com (10.10.85.152) by
 chn-vm-ex04.mchp-main.com (10.10.85.152) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2176.2; Fri, 18 Jun 2021 08:07:57 -0700
Received: from rob-ult-m19940.amer.actel.com (10.10.115.15) by
 chn-vm-ex04.mchp-main.com (10.10.85.152) with Microsoft SMTP Server id
 15.1.2176.2 via Frontend Transport; Fri, 18 Jun 2021 08:07:54 -0700
From:   Codrin Ciubotariu <codrin.ciubotariu@microchip.com>
To:     <alsa-devel@alsa-project.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>
CC:     <broonie@kernel.org>, <perex@perex.cz>, <tiwai@suse.com>,
        <nicolas.ferre@microchip.com>, <alexandre.belloni@bootlin.com>,
        <ludovic.desroches@microchip.com>,
        Codrin Ciubotariu <codrin.ciubotariu@microchip.com>
Subject: [PATCH 1/2] ASoC: atmel-i2s: Set symmetric sample bits
Date:   Fri, 18 Jun 2021 18:07:40 +0300
Message-ID: <20210618150741.401739-1-codrin.ciubotariu@microchip.com>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The I2S needs to have the same sample bits for both capture and playback
streams.

Fixes: b543e467d1a9 ("ASoC: atmel-i2s: add driver for the new Atmel I2S controller")
Signed-off-by: Codrin Ciubotariu <codrin.ciubotariu@microchip.com>
---
 sound/soc/atmel/atmel-i2s.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/sound/soc/atmel/atmel-i2s.c b/sound/soc/atmel/atmel-i2s.c
index e8fe1a7a4d83..a95002b0cc8e 100644
--- a/sound/soc/atmel/atmel-i2s.c
+++ b/sound/soc/atmel/atmel-i2s.c
@@ -542,6 +542,7 @@ static struct snd_soc_dai_driver atmel_i2s_dai = {
 	},
 	.ops = &atmel_i2s_dai_ops,
 	.symmetric_rate = 1,
+	.symmetric_sample_bits = 1,
 };
 
 static const struct snd_soc_component_driver atmel_i2s_component = {
-- 
2.30.2

