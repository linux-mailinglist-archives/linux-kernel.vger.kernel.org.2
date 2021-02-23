Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3BBA2323084
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Feb 2021 19:21:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233890AbhBWSVX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 23 Feb 2021 13:21:23 -0500
Received: from esa.microchip.iphmx.com ([68.232.154.123]:58288 "EHLO
        esa.microchip.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233148AbhBWSVV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 Feb 2021 13:21:21 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1614104481; x=1645640481;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=dK2vWaZOPK17Lmr+m9zk2hLho0FOToHeXM48kxb1z+g=;
  b=TZN/dJ1FF88j4qKl5b+roIeOt5h49ptWq1ejQpIzoD6MEoxsPbAIISsb
   EH/5Jzgn/QXoeIIi7GO4Z9C0QEyUA9I4j+ltyPHkU8V/b+ylyKb4KrZDS
   Hf3xc6atOZmscmkHseCgiZfGGGVrECWn2vE79TFiR1kvGQsJCKgkpjSix
   3dDQUhG1zRuA11wpOJ/xNEgojrNN3GXvXQqvof6oCTyzPBgbeNW+1TQrs
   JV7DGEa7vLhB9qcmwlcLw/QkFHZS7QhDpkeJTshMcqZTZf2QC7fujX+ja
   E0YoPTNRO75t/e72Z6auDB0dyqtNtbgPLV76eaQtSBOd75264y16Mxtyu
   g==;
IronPort-SDR: XRqINWKwEni1gFHvuFusQPJ5tKXsUJwg64SGAqj/xrKSgTYR/xp3trJMVEnaMMgMA8KHdQ9CaD
 UztH6MH4+WSXi1vlTCgsroCBDJUKO8ZJuIg8zvSLT0gcnsLTEMh76eae7SWMloGo+UOTBebOD6
 BOqLS3792upr6s6TKLLIAfocTWnoUDpOwvdkPCXRSx4MrrKPxpvN/QEd6ZaUPVfrFehhjaJNjF
 qbi/JkfZ8H/jDNb0J3QU1S+nfDwwWA3YrmjNS8KfZSjCRPuzu2tTNTtD6ukNYqfYQm9niDLX6M
 dOA=
X-IronPort-AV: E=Sophos;i="5.81,200,1610434800"; 
   d="scan'208";a="107691056"
Received: from smtpout.microchip.com (HELO email.microchip.com) ([198.175.253.82])
  by esa2.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 23 Feb 2021 11:20:05 -0700
Received: from chn-vm-ex02.mchp-main.com (10.10.85.144) by
 chn-vm-ex04.mchp-main.com (10.10.85.152) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1979.3; Tue, 23 Feb 2021 11:20:04 -0700
Received: from rob-ult-m19940.amer.actel.com (10.10.115.15) by
 chn-vm-ex02.mchp-main.com (10.10.85.144) with Microsoft SMTP Server id
 15.1.1979.3 via Frontend Transport; Tue, 23 Feb 2021 11:20:01 -0700
From:   Codrin Ciubotariu <codrin.ciubotariu@microchip.com>
To:     <alsa-devel@alsa-project.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>
CC:     <lgirdwood@gmail.com>, <broonie@kernel.org>, <robh+dt@kernel.org>,
        <perex@perex.cz>, <tiwai@suse.com>, <nicolas.ferre@microchip.com>,
        <alexandre.belloni@bootlin.com>, <ludovic.desroches@microchip.com>,
        "Codrin Ciubotariu" <codrin.ciubotariu@microchip.com>
Subject: [PATCH 2/7] dt-bindings: mchp,i2s-mcc: Add SAMA7G5 to binding
Date:   Tue, 23 Feb 2021 20:19:24 +0200
Message-ID: <20210223181929.444640-3-codrin.ciubotariu@microchip.com>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20210223181929.444640-1-codrin.ciubotariu@microchip.com>
References: <20210223181929.444640-1-codrin.ciubotariu@microchip.com>
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
 Documentation/devicetree/bindings/sound/mchp,i2s-mcc.yaml | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/Documentation/devicetree/bindings/sound/mchp,i2s-mcc.yaml b/Documentation/devicetree/bindings/sound/mchp,i2s-mcc.yaml
index 79445f5f2804..a8a73f3ed473 100644
--- a/Documentation/devicetree/bindings/sound/mchp,i2s-mcc.yaml
+++ b/Documentation/devicetree/bindings/sound/mchp,i2s-mcc.yaml
@@ -15,13 +15,18 @@ description:
   multi-channel audio codecs. It consists of a receiver, a transmitter and a
   common clock generator that can be enabled separately to provide Adapter,
   Client or Controller modes with receiver and/or transmitter active.
+  On later I2SMCC versions (starting with Microchip's SAMA7G5) I2S
+  multi-channel is supported by using multiple data pins, output and
+  input, without TDM.
 
 properties:
   "#sound-dai-cells":
     const: 0
 
   compatible:
-    const: microchip,sam9x60-i2smcc
+    enum:
+      - microchip,sam9x60-i2smcc
+      - microchip,sama7g5-i2smcc
 
   reg:
     maxItems: 1
-- 
2.27.0

