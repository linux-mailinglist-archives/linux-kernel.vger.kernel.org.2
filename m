Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CD9CB323099
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Feb 2021 19:24:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233952AbhBWSWW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 23 Feb 2021 13:22:22 -0500
Received: from esa.microchip.iphmx.com ([68.232.153.233]:18302 "EHLO
        esa.microchip.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232920AbhBWSVz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 Feb 2021 13:21:55 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1614104514; x=1645640514;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=84j7/78rR9j49AoWteswWe25XyPzYeNSKwnQ095gk3g=;
  b=P/3d6m5aACZ/7TiPZX6oOE1ezUKvZ6H2r9TAzMveZrge8wQhOfWDiGQw
   Yxc66hqxfMIQiCszM3G7pvJmQJ5jf+YzmX0ByEtJ3Jbr2AXE1QGrE76zz
   GsQNtEB7fr5iaaiEccreamzYpUpMX0gfUax7BjhDNwJs45rgVanGWycp8
   NMXgCzfT3dXOFh9pU4QaJOPueZJqg14tUVmyRSMaz63o1060W9eD3RXbn
   1mQr+K5mI8LFnC7RTeMP2SkTJVdyYm+hK3uTeICfIJpbzCumMy7R43b5g
   qV4adYnKl6RdRO5q9XwpT4fqrNh7HS+AH8e9ZY5+D4zq/MoXFYPOWL6d0
   w==;
IronPort-SDR: OMtCRUgrXv/RNqU6mV4ks+b8ag4aX4ymCli0/qKPvIsf6bX4q/eUGZrL3EFQS79iKq7k09h3ru
 B0U6onQLonRsePINzpsqeyZYpAsyXGgwI9cQ9ObeWZTRBUJ8JwOMsm6naaq7FrkjMpqSr8Ygib
 HHfw1/LCXMpL1WpIW/9ww2RGpDcDO6oRthFfe1o0XV94YwMZPRuTKq6R9w6sxZK1TmAYsLVD81
 h71Lf1iLwPDVQd72ZhXg5kh5SLLCaFQQHznvHCuGREIyBaFTZ/DwO2oh5PRh0WT8etLBApyPj1
 7TM=
X-IronPort-AV: E=Sophos;i="5.81,200,1610434800"; 
   d="scan'208";a="110827460"
Received: from smtpout.microchip.com (HELO email.microchip.com) ([198.175.253.82])
  by esa3.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 23 Feb 2021 11:20:16 -0700
Received: from chn-vm-ex02.mchp-main.com (10.10.87.72) by
 chn-vm-ex02.mchp-main.com (10.10.87.72) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1979.3; Tue, 23 Feb 2021 11:20:15 -0700
Received: from rob-ult-m19940.amer.actel.com (10.10.115.15) by
 chn-vm-ex02.mchp-main.com (10.10.85.144) with Microsoft SMTP Server id
 15.1.1979.3 via Frontend Transport; Tue, 23 Feb 2021 11:20:12 -0700
From:   Codrin Ciubotariu <codrin.ciubotariu@microchip.com>
To:     <alsa-devel@alsa-project.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>
CC:     <lgirdwood@gmail.com>, <broonie@kernel.org>, <robh+dt@kernel.org>,
        <perex@perex.cz>, <tiwai@suse.com>, <nicolas.ferre@microchip.com>,
        <alexandre.belloni@bootlin.com>, <ludovic.desroches@microchip.com>,
        "Codrin Ciubotariu" <codrin.ciubotariu@microchip.com>
Subject: [PATCH 5/7] dt-bindings: mchp,i2s-mcc: Add property to specify pin pair for TDM
Date:   Tue, 23 Feb 2021 20:19:27 +0200
Message-ID: <20210223181929.444640-6-codrin.ciubotariu@microchip.com>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20210223181929.444640-1-codrin.ciubotariu@microchip.com>
References: <20210223181929.444640-1-codrin.ciubotariu@microchip.com>
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
 .../devicetree/bindings/sound/mchp,i2s-mcc.yaml | 17 +++++++++++++++++
 1 file changed, 17 insertions(+)

diff --git a/Documentation/devicetree/bindings/sound/mchp,i2s-mcc.yaml b/Documentation/devicetree/bindings/sound/mchp,i2s-mcc.yaml
index a8a73f3ed473..0481315cb5f2 100644
--- a/Documentation/devicetree/bindings/sound/mchp,i2s-mcc.yaml
+++ b/Documentation/devicetree/bindings/sound/mchp,i2s-mcc.yaml
@@ -57,6 +57,23 @@ properties:
       - const: tx
       - const: rx
 
+  microchip,tdm-data-pair:
+    description:
+      Represents the DIN/DOUT pair pins that are used to receive/send
+      TDM data. It is optional and it is only needed if the controller
+      uses the TDM mode.
+    $ref: /schemas/types.yaml#/definitions/uint8
+    enum: [0, 1, 2, 3]
+    default: 0
+
+if:
+  properties:
+    compatible:
+      const: microchip,sam9x60-i2smcc
+then:
+  properties:
+    microchip,tdm-data-pair: false
+
 required:
   - "#sound-dai-cells"
   - compatible
-- 
2.27.0

