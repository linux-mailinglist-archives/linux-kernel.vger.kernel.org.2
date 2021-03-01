Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3AFC532930E
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Mar 2021 21:58:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243942AbhCAU6U (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 1 Mar 2021 15:58:20 -0500
Received: from esa.microchip.iphmx.com ([68.232.153.233]:12062 "EHLO
        esa.microchip.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237306AbhCARLR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Mar 2021 12:11:17 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1614618675; x=1646154675;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=9Dw+kwhMQDbH+M3mWnOXIqZENc4i58L5DgTTWewcxdU=;
  b=BD+UbIaL2btEe12JWHVj31dAgTW5E1+zQ5ty4ywIziyk4O7naWZo0VCo
   kZ+M6PJTtEKunjZT4IaA0LKViZZZFxiRYWEPdNs+vTmMY6tG1XOF+zPUs
   DdUqt1nu0xe1KDGyveK2nr3hsethv/kaDhGWEKOMA0YVlbkmQQoc4yV63
   W5kBjMSk+aJSKg5DckwQQZwdCS59G9wAQRq4MB04rFg8GsAcrtatdz15N
   8NtiHR8GbGPZtTOqczJ3Gj4+FpwklvsadTtKyRmHiFtwaQN32ymJex4fy
   2tyvT0l1wBmBYdtCH1r3gNnYNvTyswfIOsT35T/xFF0gNGNTBpsS6oJyS
   g==;
IronPort-SDR: KUIfx+c87XzXmqdIZUjC7INv++N9JoD8Vn+raEsJ7CxoEifIYuw6S4RjEiXU8gczsv0CczRSdQ
 jEVeGdfGSsfDymW2DgPxo6roOOfH/hYr5TwjX7nTs2r3keiKgZSzi88Exi6Lz6EGfauvoilmnb
 fQBCrzUNcr5YXqriGeJGsCdFEQkgiDmhAvQviccNf4lXiJwQ1Is3KSnBbpeaLTG5phHTS+GUTz
 lqOcyeUDZybU4p2zhDCBXmecgOrvGeKfigyV05nn3BkpAVzZmpxRAYriCAZvtb4nKA+mkpAz6W
 N0w=
X-IronPort-AV: E=Sophos;i="5.81,215,1610434800"; 
   d="scan'208";a="111511618"
Received: from smtpout.microchip.com (HELO email.microchip.com) ([198.175.253.82])
  by esa3.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 01 Mar 2021 10:09:38 -0700
Received: from chn-vm-ex04.mchp-main.com (10.10.85.152) by
 chn-vm-ex03.mchp-main.com (10.10.85.151) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1979.3; Mon, 1 Mar 2021 10:09:38 -0700
Received: from rob-ult-m19940.amer.actel.com (10.10.115.15) by
 chn-vm-ex04.mchp-main.com (10.10.85.152) with Microsoft SMTP Server id
 15.1.1979.3 via Frontend Transport; Mon, 1 Mar 2021 10:09:34 -0700
From:   Codrin Ciubotariu <codrin.ciubotariu@microchip.com>
To:     <alsa-devel@alsa-project.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>
CC:     <lgirdwood@gmail.com>, <broonie@kernel.org>, <robh+dt@kernel.org>,
        <perex@perex.cz>, <tiwai@suse.com>, <nicolas.ferre@microchip.com>,
        <alexandre.belloni@bootlin.com>, <ludovic.desroches@microchip.com>,
        "Codrin Ciubotariu" <codrin.ciubotariu@microchip.com>
Subject: [PATCH v2 1/7] dt-bindings: mchp,i2s-mcc: Add SAMA7G5 to binding
Date:   Mon, 1 Mar 2021 19:08:59 +0200
Message-ID: <20210301170905.835091-2-codrin.ciubotariu@microchip.com>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20210301170905.835091-1-codrin.ciubotariu@microchip.com>
References: <20210301170905.835091-1-codrin.ciubotariu@microchip.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

SAMA7G5 includes an updated version of the I2S-MCC driver, that includes
3 more DIN/DOUT pin pairs for multi-channel.

Signed-off-by: Codrin Ciubotariu <codrin.ciubotariu@microchip.com>
---

Changes in v2:
- changes are done to mchp-i2s-mcc.txt insted of mchp,i2s-mcc.yaml

 Documentation/devicetree/bindings/sound/mchp-i2s-mcc.txt | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/Documentation/devicetree/bindings/sound/mchp-i2s-mcc.txt b/Documentation/devicetree/bindings/sound/mchp-i2s-mcc.txt
index 91ec83a6faed..2180dbd9ea81 100644
--- a/Documentation/devicetree/bindings/sound/mchp-i2s-mcc.txt
+++ b/Documentation/devicetree/bindings/sound/mchp-i2s-mcc.txt
@@ -1,7 +1,8 @@
 * Microchip I2S Multi-Channel Controller
 
 Required properties:
-- compatible:     Should be "microchip,sam9x60-i2smcc".
+- compatible:     Should be "microchip,sam9x60-i2smcc" or
+		  "microchip,sama7g5-i2smcc".
 - reg:            Should be the physical base address of the controller and the
                   length of memory mapped region.
 - interrupts:     Should contain the interrupt for the controller.
-- 
2.27.0

