Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4C27C4410F3
	for <lists+linux-kernel@lfdr.de>; Sun, 31 Oct 2021 22:11:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230327AbhJaVNk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 31 Oct 2021 17:13:40 -0400
Received: from ip-16.mailobj.net ([213.182.54.16]:37066 "EHLO msg-6.mailo.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230274AbhJaVNj (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 31 Oct 2021 17:13:39 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=mailoo.org; s=mailo;
        t=1635714614; bh=LNkreUhiu43JsXeeJiApozKI0sEfD92k9YXF89qjvq8=;
        h=X-EA-Auth:From:To:Cc:Subject:Date:Message-Id:X-Mailer:In-Reply-To:
         References:MIME-Version:Content-Transfer-Encoding;
        b=J9LcOBcaGVZ3x6+YTvtJnp3prkvfKX4WAtnjbgeZiEVyPar+Q92bAILUF4noRKOIE
         TrZBdCVSrAwGD+MWSP1X/E8RVYsdQsoFGCrrNOZ/dbAaXnUXat6HHLc8bXO5sh2XK8
         r5RrUuG1eGZxj/VVv5D9ZdTZIaaskk1F3GYqUARk=
Received: by b-6.in.mailobj.net [192.168.90.16] with ESMTP
        via proxy.mailoo.org [213.182.55.207]
        Sun, 31 Oct 2021 22:10:14 +0100 (CET)
X-EA-Auth: td5AK5cFG4jHZ8IYXJbkHQS/M3KoPeaMR30Ppnd5l2BXyJrvpMEKFA6z6aV9haR/yFAZHKmUKs2lPEag3uk80vfpIYkWlYJhr8Ia5eg/DMk=
From:   Vincent Knecht <vincent.knecht@mailoo.org>
To:     stephan@gerhold.net, lgirdwood@gmail.com, broonie@kernel.org,
        robh+dt@kernel.org, perex@perex.cz, tiwai@suse.com
Cc:     alsa-devel@alsa-project.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        ~postmarketos/upstreaming@lists.sr.ht,
        Vincent Knecht <vincent.knecht@mailoo.org>
Subject: [PATCH 1/2] ASoC: dt-bindings: nxp, tfa989x: Add rcv-gpios property for tfa9897
Date:   Sun, 31 Oct 2021 22:09:55 +0100
Message-Id: <20211031210956.812101-2-vincent.knecht@mailoo.org>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20211031210956.812101-1-vincent.knecht@mailoo.org>
References: <20211031210956.812101-1-vincent.knecht@mailoo.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add optional rcv-gpios property specific to tfa9897 receiver mode.

Signed-off-by: Vincent Knecht <vincent.knecht@mailoo.org>
---
 .../bindings/sound/nxp,tfa989x.yaml           | 41 +++++++++++++++++++
 1 file changed, 41 insertions(+)

diff --git a/Documentation/devicetree/bindings/sound/nxp,tfa989x.yaml b/Documentation/devicetree/bindings/sound/nxp,tfa989x.yaml
index 7667471be1e4..b9b1dba40856 100644
--- a/Documentation/devicetree/bindings/sound/nxp,tfa989x.yaml
+++ b/Documentation/devicetree/bindings/sound/nxp,tfa989x.yaml
@@ -24,11 +24,23 @@ properties:
   '#sound-dai-cells':
     const: 0
 
+  rcv-gpios:
+    description: optional GPIO to be asserted when receiver mode is enabled.
+
   sound-name-prefix: true
 
   vddd-supply:
     description: regulator phandle for the VDDD power supply.
 
+if:
+  not:
+    properties:
+      compatible:
+        const: nxp,tfa9897
+then:
+  properties:
+    rcv-gpios: false
+
 required:
   - compatible
   - reg
@@ -55,3 +67,32 @@ examples:
         #sound-dai-cells = <0>;
       };
     };
+
+  - |
+    #include <dt-bindings/gpio/gpio.h>
+    i2c {
+      #address-cells = <1>;
+      #size-cells = <0>;
+
+      speaker_codec_top: audio-codec@34 {
+        compatible = "nxp,tfa9897";
+        reg = <0x34>;
+        vddd-supply = <&pm8916_l6>;
+        rcv-gpios = <&msmgpio 50 GPIO_ACTIVE_HIGH>;
+        pinctrl-names = "default";
+        pinctrl-0 = <&speaker_top_default>;
+        sound-name-prefix = "Speaker Top";
+        #sound-dai-cells = <0>;
+      };
+
+      speaker_codec_bottom: audio-codec@36 {
+        compatible = "nxp,tfa9897";
+        reg = <0x36>;
+        vddd-supply = <&pm8916_l6>;
+        rcv-gpios = <&msmgpio 111 GPIO_ACTIVE_HIGH>;
+        pinctrl-names = "default";
+        pinctrl-0 = <&speaker_bottom_default>;
+        sound-name-prefix = "Speaker Bottom";
+        #sound-dai-cells = <0>;
+      };
+    };
-- 
2.31.1



