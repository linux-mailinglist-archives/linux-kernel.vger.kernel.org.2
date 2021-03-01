Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 98C2D329375
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Mar 2021 22:21:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244522AbhCAVT0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 1 Mar 2021 16:19:26 -0500
Received: from esa.microchip.iphmx.com ([68.232.153.233]:32429 "EHLO
        esa.microchip.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233180AbhCARQE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Mar 2021 12:16:04 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1614618961; x=1646154961;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=JAZW71oGr+uPsf05sRgZbONv7U3epY8nJsk/yvQb0aY=;
  b=MK47i3J7DRIzlHog6SdxOcVJOOWeLDZHVmymNweL17ygHJdtNH4Di4Xf
   RkkqBd7nSXrWsFpFsKZrfAqK0yASxTa1lAVYlFoLAvbW2tMxuAwdbEMFW
   xNHlY0hen7Jy2zAP7ri2fJ8awSzrfrrxhv/1bAmT2vQeYqsUqO1qU+4/N
   u4K6SyjkhyVZatvDBrFsZBDSZ7tDJljdrGlo1wm6y3XRwFafJ9maI18wM
   Fx60v9OmoT11dro+GQldUcQcn6J6YJsI5G4Zgt1tjIzwxLdB4iUp2AhVj
   SsQ/HyCQzuBOKJVOzCM5WVTpKWexnuUB/5Qp2+Ef+TEs0eVF0lHAF5r0v
   A==;
IronPort-SDR: OPDsas62esXmTkEDESjLiHXRHblwzIfU0ueGzYrZIw/dOcdPD2yx1XgAlDHFc2xTpHZsz43RJ3
 4yLsRplyaAbjqUvgsXWihaeNVctgWBHvQQQh4Lk+0hIzWXevUNmHs3VAUe6904MDuzz2lru7YM
 9+wYMXjSPg1Qfo0F1KclMNWMm7zQm/iq720ZtIagfmthg6Le49RxCYKyMD1ERJ0szF2H+4FovP
 XxtY5Fz00L96swuHseNSjUh+fG3KQNciR9kHY4xB775oQBdvN9TnJ250SXMj7uW+ThTqjaa65S
 6Zo=
X-IronPort-AV: E=Sophos;i="5.81,215,1610434800"; 
   d="scan'208";a="111511738"
Received: from smtpout.microchip.com (HELO email.microchip.com) ([198.175.253.82])
  by esa3.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 01 Mar 2021 10:09:54 -0700
Received: from chn-vm-ex04.mchp-main.com (10.10.85.152) by
 chn-vm-ex03.mchp-main.com (10.10.85.151) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1979.3; Mon, 1 Mar 2021 10:09:49 -0700
Received: from rob-ult-m19940.amer.actel.com (10.10.115.15) by
 chn-vm-ex04.mchp-main.com (10.10.85.152) with Microsoft SMTP Server id
 15.1.1979.3 via Frontend Transport; Mon, 1 Mar 2021 10:09:46 -0700
From:   Codrin Ciubotariu <codrin.ciubotariu@microchip.com>
To:     <alsa-devel@alsa-project.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>
CC:     <lgirdwood@gmail.com>, <broonie@kernel.org>, <robh+dt@kernel.org>,
        <perex@perex.cz>, <tiwai@suse.com>, <nicolas.ferre@microchip.com>,
        <alexandre.belloni@bootlin.com>, <ludovic.desroches@microchip.com>,
        "Codrin Ciubotariu" <codrin.ciubotariu@microchip.com>
Subject: [PATCH v2 4/7] dt-bindings: mchp,i2s-mcc: Add property to specify pin pair for TDM
Date:   Mon, 1 Mar 2021 19:09:02 +0200
Message-ID: <20210301170905.835091-5-codrin.ciubotariu@microchip.com>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20210301170905.835091-1-codrin.ciubotariu@microchip.com>
References: <20210301170905.835091-1-codrin.ciubotariu@microchip.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

SAMA7G5's I2S-MCC has 4 pairs of DIN/DOUT pins. Since TDM only uses a
single pair of pins for synchronous capture and playback, the controller
needs to be told which of the pair is connected. This can be mentioned
using the new "microchip,tdm-data-pair" property. The property is optional,
needed only if TDM is used, and if it's missing DIN/DOUT 0 pins will be
used by default.

Signed-off-by: Codrin Ciubotariu <codrin.ciubotariu@microchip.com>
---

Changes in v2:
- changes are done to mchp-i2s-mcc.txt insted of mchp,i2s-mcc.yaml

 Documentation/devicetree/bindings/sound/mchp-i2s-mcc.txt | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/Documentation/devicetree/bindings/sound/mchp-i2s-mcc.txt b/Documentation/devicetree/bindings/sound/mchp-i2s-mcc.txt
index 2180dbd9ea81..af8fe3e657df 100644
--- a/Documentation/devicetree/bindings/sound/mchp-i2s-mcc.txt
+++ b/Documentation/devicetree/bindings/sound/mchp-i2s-mcc.txt
@@ -19,7 +19,12 @@ Required properties:
 Optional properties:
 - pinctrl-0:      Should specify pin control groups used for this controller.
 - princtrl-names: Should contain only one value - "default".
-
+- microchip,tdm-data-pair: 8 bit value that represents the DIN/DOUT pair pins
+			   which are used to receive/send TDM data. It is optional
+			   and it is only needed if the controller uses the TDM
+			   mode. Not available for "microchip,sam9x60-i2smcc"
+			   compatible. If it's not present, the default value is 0,
+			   so the DIN/DOUT 0 pins are used.
 
 (1) : Only the peripheral clock is required. The generated clock is optional
       and should be set mostly when Master Mode is required.
-- 
2.27.0

