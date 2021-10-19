Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 20261432C92
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Oct 2021 06:17:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231313AbhJSETW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 19 Oct 2021 00:19:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37384 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229784AbhJSETP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Oct 2021 00:19:15 -0400
Received: from mail-wm1-x32c.google.com (mail-wm1-x32c.google.com [IPv6:2a00:1450:4864:20::32c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 42BEAC061768;
        Mon, 18 Oct 2021 21:17:03 -0700 (PDT)
Received: by mail-wm1-x32c.google.com with SMTP id a140-20020a1c7f92000000b0030d8315b593so1229099wmd.5;
        Mon, 18 Oct 2021 21:17:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=Ad8rUiMWfEqGOMVtLxzAbxKW1DNAfkjWTH/ERwCOuek=;
        b=BtCuT653GJRoiO9Z1cWc/0pGqqJKf9MB4G2IE9LNrze0sD86SJi0YFifEgEehlwo7G
         XnkzpM4dJDmLxeBFCdk6vx8OTSv8LvHliumIbNlhPiJSSdtV50oVi1Qn31hXVesACGVa
         T1PY6sSQisf2zJIPKzme33UooLaWL2N87uf9wKcXt09rm5qcWR4mob0MidgKdARQOXD0
         Z4qR7FJGDI+/LRJ2kedWUa17B5OsSaQq1ONtIlZbnjfgs/c1IUW1/mdwHRcPpnUE7Ll5
         5ADGAL8sSvmX7sRWZlDvvfcR2L0QMuGY+gU75xsWdO/IqxzwhdbG4U/ORDRuR7eepnlu
         YHZg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=Ad8rUiMWfEqGOMVtLxzAbxKW1DNAfkjWTH/ERwCOuek=;
        b=2mb+DcfImyiNCR8txYIL/WsfgJ3CzkHAibovXMSqZFXTeJeHJMOSarFhzxpv+/lSgA
         MVra0CKUla1roBcVu1mfXk64Ekc0ly8fOO6u1Y3eSNuY8AqmG+x6Rxhq8DicAKLuxvEE
         8386ef9IZVUo1y99mXQvSmzjJqQkEy5Hbudg6UnuWSoQ93u8trvapxwE0xpoaWjO4HaA
         D3aSvbSXsSFc+IhFfGlVYO96ehNruBy0WmGEOHbWXvoQoaX4kCbq/bd9UTQU2s8gFEZi
         iQB+n/XECVtd3qBCsc/fGR9EgPyEk5VoU4PHlO7A5BHm7kHxnljLhHpm21buaTKRuZWn
         UbkQ==
X-Gm-Message-State: AOAM533HsDZc7g76j7mCRAAzVI4U/+YX6gTAeKToZhwbtWWKQx73fYXS
        Xw2njllnmPYNnRZ47bGCmBquwLHPm9o=
X-Google-Smtp-Source: ABdhPJzksrRbcm25IOpAiXTmY27POdYAt5WGNN63MlffTA+Oz3sqnS43tJmh+rxbsTBr3kUcpXs91g==
X-Received: by 2002:a1c:f601:: with SMTP id w1mr3390187wmc.112.1634617021608;
        Mon, 18 Oct 2021 21:17:01 -0700 (PDT)
Received: from localhost.localdomain (252.red-83-54-181.dynamicip.rima-tde.net. [83.54.181.252])
        by smtp.gmail.com with ESMTPSA id b3sm14332489wrp.52.2021.10.18.21.17.00
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 18 Oct 2021 21:17:01 -0700 (PDT)
From:   Sergio Paracuellos <sergio.paracuellos@gmail.com>
To:     devicetree@vger.kernel.org
Cc:     robh@kernel.org, john@phrozen.org, neil@brown.name,
        linux-kernel@vger.kernel.org
Subject: [PATCH] dt-bindings: mips: convert Ralink SoCs and boards to schema
Date:   Tue, 19 Oct 2021 06:16:59 +0200
Message-Id: <20211019041659.15761-1-sergio.paracuellos@gmail.com>
X-Mailer: git-send-email 2.33.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Convert Ralink SoCs and boards bindings to YAML schema.

Signed-off-by: Sergio Paracuellos <sergio.paracuellos@gmail.com>
---
 .../devicetree/bindings/mips/ralink.txt       | 32 -------
 .../devicetree/bindings/mips/ralink.yaml      | 87 +++++++++++++++++++
 2 files changed, 87 insertions(+), 32 deletions(-)
 delete mode 100644 Documentation/devicetree/bindings/mips/ralink.txt
 create mode 100644 Documentation/devicetree/bindings/mips/ralink.yaml

diff --git a/Documentation/devicetree/bindings/mips/ralink.txt b/Documentation/devicetree/bindings/mips/ralink.txt
deleted file mode 100644
index 8cc0ab41578c..000000000000
--- a/Documentation/devicetree/bindings/mips/ralink.txt
+++ /dev/null
@@ -1,32 +0,0 @@
-Ralink MIPS SoC device tree bindings
-
-1. SoCs
-
-Each device tree must specify a compatible value for the Ralink SoC
-it uses in the compatible property of the root node. The compatible
-value must be one of the following values:
-
-  ralink,rt2880-soc
-  ralink,rt3050-soc
-  ralink,rt3052-soc
-  ralink,rt3350-soc
-  ralink,rt3352-soc
-  ralink,rt3883-soc
-  ralink,rt5350-soc
-  ralink,mt7620a-soc
-  ralink,mt7620n-soc
-  ralink,mt7628a-soc
-  ralink,mt7688a-soc
-
-2. Boards
-
-GARDENA smart Gateway (MT7688)
-
-This board is based on the MediaTek MT7688 and equipped with 128 MiB
-of DDR and 8 MiB of flash (SPI NOR) and additional 128MiB SPI NAND
-storage.
-
-------------------------------
-Required root node properties:
-- compatible = "gardena,smart-gateway-mt7688", "ralink,mt7688a-soc",
-		"ralink,mt7628a-soc";
diff --git a/Documentation/devicetree/bindings/mips/ralink.yaml b/Documentation/devicetree/bindings/mips/ralink.yaml
new file mode 100644
index 000000000000..0588cee25ae9
--- /dev/null
+++ b/Documentation/devicetree/bindings/mips/ralink.yaml
@@ -0,0 +1,87 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/mips/ralink.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Ralink SoC based Platforms Device Tree Bindings
+
+maintainers:
+  - Sergio Paracuellos <sergio.paracuellos@gmail.com>
+
+description: |
+    Boards with a Ralink SoC shall have the following properties.
+
+properties:
+  $nodename:
+    const: '/'
+  compatible:
+    oneOf:
+      - description: Boards with Ralink RT2880 SoC
+        items:
+          - enum:
+              - ralink,rt2880-eval-board
+          - const: ralink,rt2880-soc
+
+      - description: Boards with Ralink RT3050 SoC
+        items:
+          - const: ralink,rt3050-soc
+
+      - description: Boards with Ralink RT3052 SoC
+        items:
+          - enum:
+              - ralink,rt3052-eval-board
+          - const: ralink,rt3052-soc
+
+      - description: Boards with Ralink RT3350 SoC
+        items:
+          - const: ralink,rt3350-soc
+
+      - description: Boards with Ralink RT3352 SoC
+        items:
+          - const: ralink,rt3352-soc
+
+      - description: Boards with Ralink RT3383 SoC
+        items:
+          - enum:
+              - ralink,rt3883-eval-board
+          - const: ralink,rt3383-soc
+
+      - description: Boards with Ralink RT5350 SoC
+        items:
+          - const: ralink,rt5350-soc
+
+      - description: Boards with Mediatek/Ralink MT7620A SoC
+        items:
+          - enum:
+              - ralink,mt7620a-eval-board
+          - const: ralink,mt7620a-soc
+
+      - description: Boards with Mediatek/Ralink MT7620N SoC
+        items:
+          - const: ralink,mt7620n-soc
+
+      - description: Boards with Mediatek/Ralink MT7628A SoC
+        items:
+          - enum:
+              - onion,omega2+
+              - vocore,vocore2
+          - const: ralink,mt7628a-soc
+
+      - description: Boards with Mediatek/Ralink MT7688A SoC
+        items:
+          - enum:
+              - gardena,smart-gateway-mt7688
+              - onion,omega2+
+          - const: ralink,mt7628a-soc
+
+      - description: Boards with Mediatek/Ralink MT7621 SoC
+        items:
+          - enum:
+              - gnubee,gb-pc1
+              - gnubee,gb-pc2
+          - const: mediatek,mt7621-soc
+
+additionalProperties: true
+
+...
-- 
2.33.0

