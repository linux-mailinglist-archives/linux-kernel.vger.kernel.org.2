Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2FEFF3EAC01
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Aug 2021 22:42:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237970AbhHLUmc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 12 Aug 2021 16:42:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50188 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237876AbhHLUmZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Aug 2021 16:42:25 -0400
Received: from mail-qk1-x736.google.com (mail-qk1-x736.google.com [IPv6:2607:f8b0:4864:20::736])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0E511C061756;
        Thu, 12 Aug 2021 13:42:00 -0700 (PDT)
Received: by mail-qk1-x736.google.com with SMTP id y130so8264928qkb.6;
        Thu, 12 Aug 2021 13:42:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=ochq/82t5xUPXvIID1znrVTmhLe5E8Izsp9c+gWvjrs=;
        b=Ed+L/+HybSvG4ub6uDGYR4D3031+XqS2vV/V6Zxga1iPxvcAIKPkTXPVoHkCVCs+Jc
         OKUpjvQMuusgI+rqnw2LTK+aJ2VxMT5xjukAFHS3q+mwW19KSl6HlxU63WGj3x3RBAvr
         MOxZmmj52Fo0YcckO8dSOhTrhBgiP/5R1ePBp9JKzIxrBtfztUWJVSOBO1JfHLFdW7Ba
         hspMqOkcp9js009uvTsU7HDcdWMpXA0UoLF0DX8sgc+tZBK0fMs8MFs+UTAtwUJOk+IX
         WwjfNLmZKGHiCxD4PV3ngGlugVyUsslMv0PxzSi4LsJAmzoGCndHxLA6WC6pg748Bk/W
         oy/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=ochq/82t5xUPXvIID1znrVTmhLe5E8Izsp9c+gWvjrs=;
        b=oKRw0+gfR4fL1EZjvBRuJmLoQ2MjSobVQ27/3TGbxGxm1Rh4fOgKG+txXP4j99WdsU
         w2BBzuPCt3BvLgyPC7BowS8GiNXupYjjwwnUkwydLE14Jq4DbKGl0xusJqR2Q7avkghj
         JZKVAHDMGtSQc7uDEYL2ReFujVcKdIfrV+NuvMySQPwWCSxvjG7eZkr9IZvpQhW91Abx
         NRrWXQWZzldaxCP8seQ4aq8k7hn1XuH1wBfPkB8wWBqvS4Ng4gs5dec+8aidRrHuFUY5
         5l5bbJqE6rSG3uR1xXe9ti1WEW6Je3nj2J+Bqec5U1L3eSnWyiDRujx8xte1UcpcT20M
         2FPw==
X-Gm-Message-State: AOAM530uOgAD+poJvr+oU9jwDWETMmnC64yvAgZt7jddZJpDMhY1ebEF
        zYlM8kmUbVvhhoYZyFSn0iQ=
X-Google-Smtp-Source: ABdhPJxc8txTOhaH5bN7e5C0ZZdy7/xbhS9z9tOTuYM+5y6GbHfXe3ZldmfmU/BYBbYY0BHqOmGbkQ==
X-Received: by 2002:a37:43ca:: with SMTP id q193mr6552744qka.459.1628800919041;
        Thu, 12 Aug 2021 13:41:59 -0700 (PDT)
Received: from master-laptop.sparksnet ([2601:153:980:85b1:e89f:d077:9161:1bd7])
        by smtp.gmail.com with ESMTPSA id m16sm1940361qki.19.2021.08.12.13.41.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 12 Aug 2021 13:41:58 -0700 (PDT)
From:   Peter Geis <pgwipeout@gmail.com>
To:     Kishon Vijay Abraham I <kishon@ti.com>,
        Vinod Koul <vkoul@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Heiko Stuebner <heiko@sntech.de>
Cc:     Peter Geis <pgwipeout@gmail.com>, linux-phy@lists.infradead.org,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-rockchip@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH v2 2/8] dt-bindings: phy: phy-rockchip-inno-usb2: add rk3568 documentation
Date:   Thu, 12 Aug 2021 16:41:10 -0400
Message-Id: <20210812204116.2303617-3-pgwipeout@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210812204116.2303617-1-pgwipeout@gmail.com>
References: <20210812204116.2303617-1-pgwipeout@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The rk3568 usb2phy node is a standalone node with a single muxed
interrupt.
Add documentation for it to phy-rockchip-inno-usb2.

Signed-off-by: Peter Geis <pgwipeout@gmail.com>
---
 .../bindings/phy/phy-rockchip-inno-usb2.yaml  | 31 ++++++++++++++++---
 1 file changed, 27 insertions(+), 4 deletions(-)

diff --git a/Documentation/devicetree/bindings/phy/phy-rockchip-inno-usb2.yaml b/Documentation/devicetree/bindings/phy/phy-rockchip-inno-usb2.yaml
index 5bebd86bf8b6..d2a749c3f9a3 100644
--- a/Documentation/devicetree/bindings/phy/phy-rockchip-inno-usb2.yaml
+++ b/Documentation/devicetree/bindings/phy/phy-rockchip-inno-usb2.yaml
@@ -18,6 +18,7 @@ properties:
       - rockchip,rk3328-usb2phy
       - rockchip,rk3366-usb2phy
       - rockchip,rk3399-usb2phy
+      - rockchip,rk3568-usb2phy
       - rockchip,rv1108-usb2phy
 
   reg:
@@ -50,6 +51,9 @@ properties:
     description:
       Phandle to the extcon device providing the cable state for the otg phy.
 
+  interrupts:
+    description: Muxed interrupt for both ports
+
   rockchip,usbgrf:
     $ref: /schemas/types.yaml#/definitions/phandle
     description:
@@ -78,8 +82,6 @@ properties:
 
     required:
       - "#phy-cells"
-      - interrupts
-      - interrupt-names
 
   otg-port:
     type: object
@@ -109,8 +111,6 @@ properties:
 
     required:
       - "#phy-cells"
-      - interrupts
-      - interrupt-names
 
 required:
   - compatible
@@ -120,6 +120,29 @@ required:
   - host-port
   - otg-port
 
+allOf:
+  - if:
+      properties:
+        compatible:
+          contains:
+            const: rockchip,rk3568-usb2phy
+      then:
+        properties:
+          interrupts:
+            maxItems: 1
+        required:
+          - interrupts
+      else:
+        properties:
+          host-port:
+            required:
+              - interrupts
+              - interrupt-names
+          otg-port:
+            required:
+              - interrupts
+              - interrupt-names
+
 additionalProperties: false
 
 examples:
-- 
2.25.1

