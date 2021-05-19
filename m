Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2B746388D4E
	for <lists+linux-kernel@lfdr.de>; Wed, 19 May 2021 13:54:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1352739AbhESL4P (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 19 May 2021 07:56:15 -0400
Received: from tux.runtux.com ([176.9.82.136]:39240 "EHLO tux.runtux.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S240448AbhESL4O (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 May 2021 07:56:14 -0400
Received: from localhost (localhost [127.0.0.1])
        by tux.runtux.com (Postfix) with ESMTP id A77CB6F0D6;
        Wed, 19 May 2021 13:54:52 +0200 (CEST)
X-Virus-Scanned: Debian amavisd-new at tux.runtux.com
Received: from tux.runtux.com ([127.0.0.1])
        by localhost (tux2.runtux.com [127.0.0.1]) (amavisd-new, port 10026)
        with LMTP id S3S3Grr3HLSe; Wed, 19 May 2021 13:54:51 +0200 (CEST)
Received: from bee.priv.zoo (62-99-217-90.static.upcbusiness.at [62.99.217.90])
        (Authenticated sender: postmaster@runtux.com)
        by tux.runtux.com (Postfix) with ESMTPSA id 9F36A6EFFE;
        Wed, 19 May 2021 13:54:51 +0200 (CEST)
Received: by bee.priv.zoo (Postfix, from userid 1002)
        id 32B5A46E; Wed, 19 May 2021 13:54:51 +0200 (CEST)
Date:   Wed, 19 May 2021 13:54:51 +0200
From:   Ralf Schlatterbeck <rsc@runtux.com>
To:     Geert Uytterhoeven <geert@linux-m68k.org>
Cc:     Rob Herring <robh@kernel.org>,
        Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Willy Tarreau <w@1wt.eu>, Lars Poeschel <poeschel@lemonage.de>,
        Linus Walleij <linus.walleij@linaro.org>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>
Subject: Re: [PATCH 1/1] auxdisplay: Add I2C gpio expander example
Message-ID: <20210519115450.qoqpy7d5dgnjtenx@runtux.com>
References: <20210106113730.k5qveshjgcd57kgx@runtux.com>
 <20210106113929.fizyg6fcsmsntkiy@runtux.com>
 <CANiq72=Cfv=Qo2fs+HDjUc8pV37mL326SDS5JpGotUfHLwK_rQ@mail.gmail.com>
 <CAMuHMdUW3U6DVkHp3xiHFzvRUDJ1FwTNCnBWp5LCuDGxhds9wg@mail.gmail.com>
 <CANiq72mCFwYnbynQgwNGTt0mzo_rMrnQfpinz6DrPttFxUpyNQ@mail.gmail.com>
 <20210517152035.GA2581887@robh.at.kernel.org>
 <20210519090047.e63d2im5vgskqpcs@runtux.com>
 <CAMuHMdV80XUo5ihXUkogCikGA4H71Ada9w=9W9d9d1zdgrw0uA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAMuHMdV80XUo5ihXUkogCikGA4H71Ada9w=9W9d9d1zdgrw0uA@mail.gmail.com>
X-ray:  beware
User-Agent: NeoMutt/20180716
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The hd44780 displays are often used with pcf8574 based I/O expanders.
Add example to documentation.

Signed-off-by: Ralf Schlatterbeck <rsc@runtux.com>
---
Updated Patch, thanks to Geert Uytterhoeven for his tip on how to
reproduce the warning. I've removed the address from the i2c stanza
which fixes it. Let me know if I should re-post the patch in a separate
thread.

 .../bindings/auxdisplay/hit,hd44780.yaml      | 31 ++++++++++++++++++-
 1 file changed, 30 insertions(+), 1 deletion(-)

diff --git a/Documentation/devicetree/bindings/auxdisplay/hit,hd44780.yaml b/Documentation/devicetree/bindings/auxdisplay/hit,hd44780.yaml
index 9222b06e93a0..fde07e4b119d 100644
--- a/Documentation/devicetree/bindings/auxdisplay/hit,hd44780.yaml
+++ b/Documentation/devicetree/bindings/auxdisplay/hit,hd44780.yaml
@@ -12,7 +12,10 @@ maintainers:
 description:
   The Hitachi HD44780 Character LCD Controller is commonly used on character
   LCDs that can display one or more lines of text. It exposes an M6800 bus
-  interface, which can be used in either 4-bit or 8-bit mode.
+  interface, which can be used in either 4-bit or 8-bit mode. By using a
+  GPIO expander it is possible to use the driver with one of the popular I2C
+  expander boards based on the PCF8574 available for these displays. For
+  an example see below.
 
 properties:
   compatible:
@@ -94,3 +97,29 @@ examples:
             display-height-chars = <2>;
             display-width-chars = <16>;
     };
+  - |
+    #include <dt-bindings/gpio/gpio.h>
+    i2c {
+            #address-cells = <1>;
+            #size-cells = <0>;
+
+            pcf8574: pcf8574@27 {
+                    compatible = "nxp,pcf8574";
+                    reg = <0x27>;
+                    gpio-controller;
+                    #gpio-cells = <2>;
+            };
+    };
+    hd44780 {
+            compatible = "hit,hd44780";
+            display-height-chars = <2>;
+            display-width-chars  = <16>;
+            data-gpios = <&pcf8574 4 0>,
+                         <&pcf8574 5 0>,
+                         <&pcf8574 6 0>,
+                         <&pcf8574 7 0>;
+            enable-gpios = <&pcf8574 2 0>;
+            rs-gpios = <&pcf8574 0 0>;
+            rw-gpios = <&pcf8574 1 0>;
+            backlight-gpios = <&pcf8574 3 0>;
+    };
-- 
2.20.1
