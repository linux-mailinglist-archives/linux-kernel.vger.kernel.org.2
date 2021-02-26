Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 06B28326412
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Feb 2021 15:30:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230037AbhBZO3w (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 26 Feb 2021 09:29:52 -0500
Received: from hostingweb31-40.netsons.net ([89.40.174.40]:59147 "EHLO
        hostingweb31-40.netsons.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229622AbhBZO3p (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 Feb 2021 09:29:45 -0500
Received: from [77.244.183.192] (port=64786 helo=melee.dev.aim)
        by hostingweb31.netsons.net with esmtpa (Exim 4.93)
        (envelope-from <luca@lucaceresoli.net>)
        id 1lFe73-001EWE-6N; Fri, 26 Feb 2021 15:29:01 +0100
From:   Luca Ceresoli <luca@lucaceresoli.net>
To:     Lee Jones <lee.jones@linaro.org>, devicetree@vger.kernel.org
Cc:     Luca Ceresoli <luca@lucaceresoli.net>,
        Rob Herring <robh+dt@kernel.org>, Keerthy <j-keerthy@ti.com>,
        linux-kernel@vger.kernel.org
Subject: [PATCH 1/2] dt-bindings: mfd: lp875xx: add optional reset GPIO
Date:   Fri, 26 Feb 2021 15:28:51 +0100
Message-Id: <20210226142852.19632-1-luca@lucaceresoli.net>
X-Mailer: git-send-email 2.30.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - hostingweb31.netsons.net
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - lucaceresoli.net
X-Get-Message-Sender-Via: hostingweb31.netsons.net: authenticated_id: luca+lucaceresoli.net/only user confirmed/virtual account not confirmed
X-Authenticated-Sender: hostingweb31.netsons.net: luca@lucaceresoli.net
X-Source: 
X-Source-Args: 
X-Source-Dir: 
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Document the LP8756x-Q1 and LP87524-Q1 ICs reset pin.

Signed-off-by: Luca Ceresoli <luca@lucaceresoli.net>
---
 Documentation/devicetree/bindings/mfd/ti,lp87524-q1.yaml | 4 ++++
 Documentation/devicetree/bindings/mfd/ti,lp87561-q1.yaml | 4 ++++
 Documentation/devicetree/bindings/mfd/ti,lp87565-q1.yaml | 4 ++++
 3 files changed, 12 insertions(+)

diff --git a/Documentation/devicetree/bindings/mfd/ti,lp87524-q1.yaml b/Documentation/devicetree/bindings/mfd/ti,lp87524-q1.yaml
index c4fc5345d38d..f6cac4b1079c 100644
--- a/Documentation/devicetree/bindings/mfd/ti,lp87524-q1.yaml
+++ b/Documentation/devicetree/bindings/mfd/ti,lp87524-q1.yaml
@@ -17,6 +17,10 @@ properties:
     description: I2C slave address
     const: 0x60
 
+  reset-gpios:
+    description: GPIO connected to NRST pin (active low reset, pin 20)
+    maxItems: 1
+
   gpio-controller: true
 
   '#gpio-cells':
diff --git a/Documentation/devicetree/bindings/mfd/ti,lp87561-q1.yaml b/Documentation/devicetree/bindings/mfd/ti,lp87561-q1.yaml
index a7e57c0913e1..dc5a29b5ef7d 100644
--- a/Documentation/devicetree/bindings/mfd/ti,lp87561-q1.yaml
+++ b/Documentation/devicetree/bindings/mfd/ti,lp87561-q1.yaml
@@ -17,6 +17,10 @@ properties:
     description: I2C slave address
     const: 0x60
 
+  reset-gpios:
+    description: GPIO connected to NRST pin (active low reset, pin 20)
+    maxItems: 1
+
   gpio-controller: true
 
   '#gpio-cells':
diff --git a/Documentation/devicetree/bindings/mfd/ti,lp87565-q1.yaml b/Documentation/devicetree/bindings/mfd/ti,lp87565-q1.yaml
index 1da6d6a958c9..48d4d53c25f9 100644
--- a/Documentation/devicetree/bindings/mfd/ti,lp87565-q1.yaml
+++ b/Documentation/devicetree/bindings/mfd/ti,lp87565-q1.yaml
@@ -19,6 +19,10 @@ properties:
     description: I2C slave address
     const: 0x60
 
+  reset-gpios:
+    description: GPIO connected to NRST pin (active low reset, pin 20)
+    maxItems: 1
+
   gpio-controller: true
 
   '#gpio-cells':
-- 
2.30.0

