Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 608453DB9B5
	for <lists+linux-kernel@lfdr.de>; Fri, 30 Jul 2021 15:54:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239155AbhG3NyF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 30 Jul 2021 09:54:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59558 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239099AbhG3Nx5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 30 Jul 2021 09:53:57 -0400
Received: from yawp.biot.com (yawp.biot.com [IPv6:2a01:4f8:10a:8e::fce2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 21C1BC0613CF
        for <linux-kernel@vger.kernel.org>; Fri, 30 Jul 2021 06:53:53 -0700 (PDT)
Received: from debian-spamd by yawp.biot.com with sa-checked (Exim 4.93)
        (envelope-from <bert@biot.com>)
        id 1m9Spx-006bU7-J4
        for linux-kernel@vger.kernel.org; Fri, 30 Jul 2021 15:46:05 +0200
X-Spam-Checker-Version: SpamAssassin 3.4.4 (2020-01-24) on yawp
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,RDNS_NONE,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
        version=3.4.4
Received: from [2a02:578:460c:1:ae1f:6bff:fed1:9ca8] (helo=sumner.biot.com)
        by yawp.biot.com with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.93)
        (envelope-from <bert@biot.com>)
        id 1m9Spu-006bTN-4Z; Fri, 30 Jul 2021 15:46:02 +0200
Received: from bert by sumner.biot.com with local (Exim 4.93)
        (envelope-from <bert@biot.com>)
        id 1m9Spt-003a1Q-MT; Fri, 30 Jul 2021 15:46:01 +0200
From:   Bert Vermeulen <bert@biot.com>
To:     devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        Rob Herring <robh+dt@kernel.org>,
        John Crispin <john@phrozen.org>,
        Bert Vermeulen <bert@biot.com>, Felix Fietkau <nbd@nbd.name>
Subject: [PATCH 2/5] dt-bindings: arm: econet: Add binding for EN7523 SoC and EVB
Date:   Fri, 30 Jul 2021 15:45:49 +0200
Message-Id: <20210730134552.853350-3-bert@biot.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210730134552.853350-1-bert@biot.com>
References: <20210730134552.853350-1-bert@biot.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: John Crispin <john@phrozen.org>

Add devicetree binding for Econet EN7523 SoC and evaluation board.

Signed-off-by: John Crispin <john@phrozen.org>
Signed-off-by: Bert Vermeulen <bert@biot.com>
---
 .../devicetree/bindings/arm/econet.yaml       | 27 +++++++++++++++++++
 1 file changed, 27 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/arm/econet.yaml

diff --git a/Documentation/devicetree/bindings/arm/econet.yaml b/Documentation/devicetree/bindings/arm/econet.yaml
new file mode 100644
index 000000000000..39128f959fef
--- /dev/null
+++ b/Documentation/devicetree/bindings/arm/econet.yaml
@@ -0,0 +1,27 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/arm/econet.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: EcoNet SoC based Platforms Device Tree Bindings
+
+maintainers:
+  - Felix Fietkau <nbd@nbd.name>
+  - John Crispin <john@phrozen.org>
+description: |
+  Boards with an EcoNet SoC shall have the following properties.
+
+properties:
+  $nodename:
+    const: '/'
+  compatible:
+    oneOf:
+      - items:
+          - enum:
+              - econet,en7523-evb
+          - const: econet,en7523
+
+additionalProperties: true
+
+...
-- 
2.25.1

