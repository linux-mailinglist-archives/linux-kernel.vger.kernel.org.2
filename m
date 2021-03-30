Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0259434DD07
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Mar 2021 02:32:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230286AbhC3AcO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 29 Mar 2021 20:32:14 -0400
Received: from thorn.bewilderbeest.net ([71.19.156.171]:38343 "EHLO
        thorn.bewilderbeest.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230202AbhC3Ab7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 Mar 2021 20:31:59 -0400
X-Greylist: delayed 424 seconds by postgrey-1.27 at vger.kernel.org; Mon, 29 Mar 2021 20:31:59 EDT
Received: from hatter.bewilderbeest.net (unknown [IPv6:2600:6c44:7f:ba20::7c6])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: zev)
        by thorn.bewilderbeest.net (Postfix) with ESMTPSA id CDBB3373;
        Mon, 29 Mar 2021 17:24:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bewilderbeest.net;
        s=thorn; t=1617063894;
        bh=/9ihArs2Y5nqE6CHv1WmVwDQQrPL9NzAFux7u/c08ww=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=OOrxlajmImZXKgUN3fi/ETblSJLGwuBqdMn1HtNxikoj8n19rQG/xf+Hboe3gORv4
         KuW1Twxqb3ZHyaUBeu9RDLXzrsncDXXqiP7d/1pwO+TyPcrALgnmc+NZf61eCKYm1i
         3HjgiNvg0r9a0MWJM1/a0VyQqd35yBa/0AxhcEzc=
From:   Zev Weiss <zev@bewilderbeest.net>
To:     Joel Stanley <joel@jms.id.au>
Cc:     openbmc@lists.ozlabs.org, linux-arm-kernel@lists.infradead.org,
        linux-aspeed@lists.ozlabs.org, linux-kernel@vger.kernel.org,
        Andrew Jeffery <andrew@aj.id.au>,
        Zev Weiss <zev@bewilderbeest.net>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Rob Herring <robh+dt@kernel.org>,
        Lubomir Rintel <lkundrak@v3.sk>,
        - <devicetree@vger.kernel.org>, linux-serial@vger.kernel.org
Subject: [PATCH 2/3] dt-bindings: serial: 8250: update for aspeed,sirq-active-high
Date:   Mon, 29 Mar 2021 19:23:37 -0500
Message-Id: <20210330002338.335-3-zev@bewilderbeest.net>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20210330002338.335-1-zev@bewilderbeest.net>
References: <20210330002338.335-1-zev@bewilderbeest.net>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Update DT bindings documentation for the new incarnation of the
aspeed,sirq-polarity-sense property.

Signed-off-by: Zev Weiss <zev@bewilderbeest.net>
---
 Documentation/devicetree/bindings/serial/8250.yaml | 14 ++++++--------
 1 file changed, 6 insertions(+), 8 deletions(-)

diff --git a/Documentation/devicetree/bindings/serial/8250.yaml b/Documentation/devicetree/bindings/serial/8250.yaml
index f54cae9ff7b2..0bbb7121f720 100644
--- a/Documentation/devicetree/bindings/serial/8250.yaml
+++ b/Documentation/devicetree/bindings/serial/8250.yaml
@@ -13,7 +13,7 @@ allOf:
   - $ref: /schemas/serial.yaml#
   - if:
       required:
-        - aspeed,sirq-polarity-sense
+        - aspeed,sirq-active-high
     then:
       properties:
         compatible:
@@ -181,13 +181,11 @@ properties:
   rng-gpios: true
   dcd-gpios: true
 
-  aspeed,sirq-polarity-sense:
-    $ref: /schemas/types.yaml#/definitions/phandle-array
+  aspeed,sirq-active-high:
+    type: boolean
     description: |
-      Phandle to aspeed,ast2500-scu compatible syscon alongside register
-      offset and bit number to identify how the SIRQ polarity should be
-      configured. One possible data source is the LPC/eSPI mode bit. Only
-      applicable to aspeed,ast2500-vuart.
+      Set to indicate that the SIRQ polarity is active-high (default
+      is active-low).  Only applicable to aspeed,ast2500-vuart.
 
 required:
   - reg
@@ -227,7 +225,7 @@ examples:
         interrupts = <8>;
         clocks = <&syscon ASPEED_CLK_APB>;
         no-loopback-test;
-        aspeed,sirq-polarity-sense = <&syscon 0x70 25>;
+        aspeed,sirq-active-high;
     };
 
 ...
-- 
2.31.1

