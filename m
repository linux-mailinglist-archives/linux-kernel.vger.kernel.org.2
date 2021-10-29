Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 932B94402D7
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Oct 2021 21:06:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230426AbhJ2TI2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 29 Oct 2021 15:08:28 -0400
Received: from ixit.cz ([94.230.151.217]:54036 "EHLO ixit.cz"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230168AbhJ2TI0 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 29 Oct 2021 15:08:26 -0400
Received: from localhost.localdomain (ip-89-176-96-70.net.upcbroadband.cz [89.176.96.70])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by ixit.cz (Postfix) with ESMTPSA id 70DA624E6B;
        Fri, 29 Oct 2021 19:54:28 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ixit.cz; s=dkim;
        t=1635530068;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=6ToVB7x10YgE3pIY4Ta3eLJU9jiD1tCEr5Va3QGvfnQ=;
        b=qfn6ZuqxpF4YDRb8llLEHmOpPPwLVzci3cWhqHwfs2KDNkjbel9iw1O5AvQHuF2uiQenDI
        R30KSQVOF9al1rSEMj3HA2bNB1ERwbvHuRWrNI3/5DDuxzXqJjNWzTrIXKtVujbbuspgl/
        BOBkTi9ULCmujOMYzHJx1yVUoDmOJqk=
From:   David Heidelberg <david@ixit.cz>
To:     Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Rob Herring <robh+dt@kernel.org>, angus@akkea.ca
Cc:     ~okias/devicetree@lists.sr.ht, David Heidelberg <david@ixit.cz>,
        alsa-devel@alsa-project.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH] dt-bindings: sound: gtm601: convert to YAML
Date:   Fri, 29 Oct 2021 19:54:17 +0200
Message-Id: <20211029175418.83899-1-david@ixit.cz>
X-Mailer: git-send-email 2.33.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Convert GTM601 binding to the YAML format.

Signed-off-by: David Heidelberg <david@ixit.cz>
---
 .../devicetree/bindings/sound/gtm601.txt      | 19 -----------
 .../devicetree/bindings/sound/gtm601.yaml     | 33 +++++++++++++++++++
 2 files changed, 33 insertions(+), 19 deletions(-)
 delete mode 100644 Documentation/devicetree/bindings/sound/gtm601.txt
 create mode 100644 Documentation/devicetree/bindings/sound/gtm601.yaml

diff --git a/Documentation/devicetree/bindings/sound/gtm601.txt b/Documentation/devicetree/bindings/sound/gtm601.txt
deleted file mode 100644
index efa32a486c4a..000000000000
--- a/Documentation/devicetree/bindings/sound/gtm601.txt
+++ /dev/null
@@ -1,19 +0,0 @@
-GTM601 UMTS modem audio interface CODEC
-
-This device has no configuration interface. The sample rate and channels are
-based on the compatible string
-	"option,gtm601" = 8kHz mono
-	"broadmobi,bm818" = 48KHz stereo
-
-Required properties:
-
-  - compatible : one of
-	"option,gtm601"
-	"broadmobi,bm818"
-
-
-Example:
-
-codec: gtm601_codec {
-	compatible = "option,gtm601";
-};
diff --git a/Documentation/devicetree/bindings/sound/gtm601.yaml b/Documentation/devicetree/bindings/sound/gtm601.yaml
new file mode 100644
index 000000000000..804402c72798
--- /dev/null
+++ b/Documentation/devicetree/bindings/sound/gtm601.yaml
@@ -0,0 +1,33 @@
+# SPDX-License-Identifier: GPL-2.0-only OR BSD-2-Clause
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/sound/gtm601.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: GTM601 UMTS modem audio interface CODEC
+
+maintainers:
+  - Angus Ainslie (Purism) <angus@akkea.ca>
+
+description: >
+  This device has no configuration interface. The sample rate and channels are
+  based on the compatible string
+
+properties:
+  compatible:
+    oneOf:
+      - items:
+          - const: broadmobi,bm818
+          - const: option,gtm601
+      - items:
+          - enum:
+              - broadmobi,bm818  # 48 kHz stereo
+              - option,gtm601  # 8 kHz mono
+
+additionalProperties: false
+
+examples:
+  - |
+    gtm601_codec {
+        compatible = "option,gtm601";
+    };
-- 
2.33.0

