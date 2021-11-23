Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C317745A40F
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Nov 2021 14:44:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236744AbhKWNrt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 23 Nov 2021 08:47:49 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52424 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229808AbhKWNrs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 Nov 2021 08:47:48 -0500
Received: from ssl.serverraum.org (ssl.serverraum.org [IPv6:2a01:4f8:151:8464::1:2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 04DB3C061574;
        Tue, 23 Nov 2021 05:44:39 -0800 (PST)
Received: from mwalle01.kontron.local. (unknown [IPv6:2a02:810c:c240:2017:fa59:71ff:fe9b:b851])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-384) server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by ssl.serverraum.org (Postfix) with ESMTPSA id C9A9E22175;
        Tue, 23 Nov 2021 14:44:35 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=walle.cc; s=mail2016061301;
        t=1637675076;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=HtRvcht0aDcjR88YtM14Y1YaKjCCiIhS1+AggGgbTbc=;
        b=l1whAx+l3jXwRBv+m0TjESqVF4qHK2K7vJId1I0fEbd5cv2fhq4uVeupbmh0uBObTT1LRI
        iUHRknVgrEcTx4vYKjFU090vNPqwayJi4KMpzVbpZEj8EBYBPS00Y68iIb2O6oRhwJodHa
        5H4jy/4o0q3MyeMjkG4zykCfFPEDAug=
From:   Michael Walle <michael@walle.cc>
To:     devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Frank Rowand <frowand.list@gmail.com>,
        Ansuel Smith <ansuelsmth@gmail.com>,
        Andrew Lunn <andrew@lunn.ch>, Michael Walle <michael@walle.cc>
Subject: [RFC PATCH] dt-bindings: nvmem: add transformation support
Date:   Tue, 23 Nov 2021 14:44:25 +0100
Message-Id: <20211123134425.3875656-1-michael@walle.cc>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This is my second attempt to solve the use case where there is only the
base MAC address stored in an EEPROM or similar storage provider. This
is the case for the Kontron sl28 board and multiple openwrt supported
boards.

The first proposal [1] didn't find much appreciation and there wasn't
any reply to my question or new proposal [2]. So here we are with my new
proposal, that is more flexible and doesn't fix the ethernet mac only.
This is just an RFC for the device tree representation for now to see if
this is the correct way to tackle this.

I'm also aware of the latest post process hook support [3]. This doesn't
fix the base mac address issue, but I think it also doesn't solve the
case with swapped ethernet addresses in the general case. That hook will
involve the driver to do the swapping, but how would the driver know
if that swapping is actually required. Usually the interpretation of the
content is opaque to the driver, after all it is the user/board
manufacturer who does program the storage device. We might be lucky in
the imx-ocotp case because the IMX reference manual actually states
where and in which format the mac address is programmed.

Introduce a transformation property. This is intended to be just an
enumeration of operations. If there will be a new operation, support for
it has to be added to the nvmem core.

A transformation might have multiple output values, like in the base mac
address case. It reads the mac address from the nvmem storage and
generates multiple individual addresses, i.e. on our board we reserve 8
consecutive addresses. These addresses then can be assigned to different
network interfaces. To make it possible to reference different values we
need to introduce an argument to the phandle. This additional argument
is then an index into a list of values.

Example:
  mac_addresses: base-mac-address@10 {
    #nvmem-cell-cells = <1>;
    reg = <10 6>;
    transformation = <NVMEM_T_ETH_OFFSET 0 1 7>;
  }

  &eth0 {
    nvmem-cells = <&mac_addresses 0>;
    nvmem-cell-names = "mac-address";
  };

  &eth1 {
    nvmem-cells = <&mac_addresses 2>;
    nvmem-cell-names = "mac-address";
  };

The NVMEM_T_ETH_OFFSET transformation takes N additional (dt) cells and
will generate N values. In this example BASE_MAC+0, BASE_MAC+1, BASE_MAC+7.
An nvmem consumer can then reference the nvmem cell with an index. So eth0
will get BASE_MAC+0 and eth1 will get BASE_MAC+7.

This should be sufficient flexible for many different transformations
without having to touch the bindings except for adding documentation and
checks for new transformations.

I do have one question regarding "#nvmem-cell-cells" (aside from the
awkward naming): is it allowed to have that property optional if there
is no additional argument to the phandle?

[1] https://lore.kernel.org/all/20210414152657.12097-2-michael@walle.cc/
[2] https://lore.kernel.org/linux-devicetree/362f1c6a8b0ec191b285ac6a604500da@walle.cc/
[3] https://lore.kernel.org/lkml/20211013131957.30271-1-srinivas.kandagatla@linaro.org/

Signed-off-by: Michael Walle <michael@walle.cc>
---
 .../devicetree/bindings/nvmem/nvmem.yaml      | 29 +++++++++++++++++++
 1 file changed, 29 insertions(+)

diff --git a/Documentation/devicetree/bindings/nvmem/nvmem.yaml b/Documentation/devicetree/bindings/nvmem/nvmem.yaml
index 456fb808100a..8893d045be77 100644
--- a/Documentation/devicetree/bindings/nvmem/nvmem.yaml
+++ b/Documentation/devicetree/bindings/nvmem/nvmem.yaml
@@ -26,11 +26,34 @@ properties:
   "#size-cells":
     const: 1
 
+  '#nvmem-cell-cells':
+    enum: [0, 1]
+    description:
+      Must be 1 if the transformations has multiple output values.
+      The argument is then the index into the list of output values.
+      For example, if the nvmem cell only specify a base ethernet
+      address the transformation can then create different individual
+      ethernet addresses.
+
   read-only:
     $ref: /schemas/types.yaml#/definitions/flag
     description:
       Mark the provider as read only.
 
+  transformation:
+    description:
+      Transform the content of a NVMEM cell. Sometimes it is necessary
+      to preprocess the content of a cell so it is usable by the NVMEM
+      consumer. There are also cases where one NVMEM cell value can
+      generate a list of values.
+
+      Use one of the NVMEM_T_* prefixed definitions from the header
+      include/dt-bindings/nvmem/nvmem.h.
+
+      Some transformations might have additional arguments.
+    $ref: /schemas/types.yaml#/definitions/uint32
+
+
   wp-gpios:
     description:
       GPIO to which the write-protect pin of the chip is connected.
@@ -98,6 +121,12 @@ examples:
               reg = <0xc 0x1>;
               bits = <2 3>;
           };
+
+          ethernet_base_mac: base-mac-address@100 {
+              #nvmem-cell-cells = <1>;
+              reg = <0x100 0x6>;
+              transformation = <NVMEM_T_ETH_OFFSET 0 1 2 7>;
+          };
       };
 
 ...
-- 
2.30.2

