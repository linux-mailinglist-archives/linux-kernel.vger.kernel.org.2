Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D008E3D4659
	for <lists+linux-kernel@lfdr.de>; Sat, 24 Jul 2021 10:42:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234623AbhGXIBU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 24 Jul 2021 04:01:20 -0400
Received: from mail.kernel.org ([198.145.29.99]:59868 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S234232AbhGXIBS (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 24 Jul 2021 04:01:18 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 29E9660E91;
        Sat, 24 Jul 2021 08:41:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1627116111;
        bh=moILCmtiV0p2uGFG391GTWj+y6SvAuyzOjgR3BA13Ls=;
        h=From:To:Cc:Subject:Date:From;
        b=c69gNAtmmqAF0//TDI1Tw3gBd9UJc6N6MXEGWjIRDGxDDZC2vZ23BtTBOjCn4fhsF
         orSTIDGF/RjpCdcpxEZuH0gfZFquvbNIb3mj59Eljx3SSh56gdlkqLowXvEFeYp3AK
         SitDwgT4GfGqEbrn8L71k2tVNQyeYZzF7JF6RMo9wz5PkRi+uENSXoW9vC4o2T/R/c
         Iq09JPj+mKeDthPQ6s03r+GxkoQcS+Qs0p9OaX+fke4Q7MHSDmArml5Yd56ccWKb57
         De6aN/ZP0HGFzcBLOp8G35LSvhY6h20bK09+XCukNE3yXX2dmftJAfz+oYfjwlWtrF
         8KnvHvyvNJlvg==
Received: by mail.kernel.org with local (Exim 4.94.2)
        (envelope-from <mchehab@kernel.org>)
        id 1m7DEC-00BEqc-R7; Sat, 24 Jul 2021 10:41:48 +0200
From:   Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     linuxarm@huawei.com, mauro.chehab@huawei.com,
        Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
        "Rob Herring" <robh@kernel.org>, Lee Jones <lee.jones@linaro.org>,
        Rob Herring <robh+dt@kernel.org>, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH] dt-bindings: hisilicon,hi6421-spmi-pmic.yaml: make some rules stricter
Date:   Sat, 24 Jul 2021 10:41:45 +0200
Message-Id: <b7a775808d9c3a87fbe1c5a6dd71f8f18be7e649.1627116034.git.mchehab+huawei@kernel.org>
X-Mailer: git-send-email 2.31.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: Mauro Carvalho Chehab <mchehab@kernel.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Define maxItems for interrupts and accept only "ldo" in lower case.

Reviewed-by: Rob Herring <robh@kernel.org>
Signed-off-by: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
---
Greg,

Please apply this patch on your staging tree. It addresses the remaining
bits from Rob's review.

I'll submit the DTS patches via HiSilicon tree, c/c you and Rob.

 .../mfd/hisilicon,hi6421-spmi-pmic.yaml       | 21 ++++++++++---------
 1 file changed, 11 insertions(+), 10 deletions(-)

diff --git a/Documentation/devicetree/bindings/mfd/hisilicon,hi6421-spmi-pmic.yaml b/Documentation/devicetree/bindings/mfd/hisilicon,hi6421-spmi-pmic.yaml
index cedf9d99a34b..22edcb4b212f 100644
--- a/Documentation/devicetree/bindings/mfd/hisilicon,hi6421-spmi-pmic.yaml
+++ b/Documentation/devicetree/bindings/mfd/hisilicon,hi6421-spmi-pmic.yaml
@@ -34,7 +34,8 @@ properties:
 
   interrupt-controller: true
 
-  interrupts: true
+  interrupts:
+    maxItems: 1
 
   regulators:
     type: object
@@ -49,7 +50,7 @@ properties:
         const: 0
 
     patternProperties:
-      '^(ldo|LDO)[0-9]+$':
+      '^ldo[0-9]+$':
         type: object
 
         $ref: "/schemas/regulator/regulator.yaml#"
@@ -79,55 +80,55 @@ examples:
         #address-cells = <1>;
         #size-cells = <0>;
 
-        ldo3: LDO3 {
+        ldo3: ldo3 {
           regulator-name = "ldo3";
           regulator-min-microvolt = <1500000>;
           regulator-max-microvolt = <2000000>;
           regulator-boot-on;
         };
 
-        ldo4: LDO4 {
+        ldo4: ldo4 {
           regulator-name = "ldo4";
           regulator-min-microvolt = <1725000>;
           regulator-max-microvolt = <1900000>;
           regulator-boot-on;
         };
 
-        ldo9: LDO9 {
+        ldo9: ldo9 {
           regulator-name = "ldo9";
           regulator-min-microvolt = <1750000>;
           regulator-max-microvolt = <3300000>;
           regulator-boot-on;
         };
 
-        ldo15: LDO15 {
+        ldo15: ldo15 {
           regulator-name = "ldo15";
           regulator-min-microvolt = <1800000>;
           regulator-max-microvolt = <3000000>;
           regulator-always-on;
         };
 
-        ldo16: LDO16 {
+        ldo16: ldo16 {
           regulator-name = "ldo16";
           regulator-min-microvolt = <1800000>;
           regulator-max-microvolt = <3000000>;
           regulator-boot-on;
         };
 
-        ldo17: LDO17 {
+        ldo17: ldo17 {
           regulator-name = "ldo17";
           regulator-min-microvolt = <2500000>;
           regulator-max-microvolt = <3300000>;
         };
 
-        ldo33: LDO33 {
+        ldo33: ldo33 {
           regulator-name = "ldo33";
           regulator-min-microvolt = <2500000>;
           regulator-max-microvolt = <3300000>;
           regulator-boot-on;
         };
 
-        ldo34: LDO34 {
+        ldo34: ldo34 {
           regulator-name = "ldo34";
           regulator-min-microvolt = <2600000>;
           regulator-max-microvolt = <3300000>;
-- 
2.31.1


