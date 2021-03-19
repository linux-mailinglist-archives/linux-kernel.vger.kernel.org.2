Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9DC033424AA
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Mar 2021 19:29:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230341AbhCSS2r (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 19 Mar 2021 14:28:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50512 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230240AbhCSS2N (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 19 Mar 2021 14:28:13 -0400
Received: from mail-ed1-x533.google.com (mail-ed1-x533.google.com [IPv6:2a00:1450:4864:20::533])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0BC7CC06174A;
        Fri, 19 Mar 2021 11:28:13 -0700 (PDT)
Received: by mail-ed1-x533.google.com with SMTP id dm8so11915865edb.2;
        Fri, 19 Mar 2021 11:28:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=pHQeL+zKucmwsz2xyFaNwYWj4QdkKVqhrqUT1DhydgM=;
        b=KeO5TNpkPYjcPmBEX/8uLaa84tKmzd1CeVAO3DG7993Op7PiXHLH3qn/5mVu9xmxPe
         f2/GD/SUQxAviYKLCrFbSI1Q3EJ3xgvKWWvp0jgDAMID0/82MOji/JlhJH1qFsh58M+R
         wK/+uFn7pcRLyGEhU5u5jc+uZt7OrFPOaUjKlpglGeJ84VGqwq2PJr8mH8mu4mlVf2TR
         69sUPY+6jb9UP7lvXryh6nlk0QCApxxWffSmCZ5GcDpNIim7KOO8u8JCVd+1+1VZv38H
         8cmJzXpP22qgqoRmuTLSZ09TTXssDWMwujIj240bo+KyXvBgu5q1Al6M0VBf3H7a/zwu
         lp6Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=pHQeL+zKucmwsz2xyFaNwYWj4QdkKVqhrqUT1DhydgM=;
        b=os00BD+RxbHGkRX16sQuaBdKILCYnVMDEXNe2iAFrIG1I2KoRbKUg7utgsuMgelwIe
         Ckr2Ap49rjqpG4rWVa/XKATrPrhIR7XUAUZowman022PPzYbZzynuW5hsbvrnUhnDr5W
         vwceR0R/hlUt3ErbOU4GVnQONH4m2VLC5CdOE/rdf4CFxJu0XVTtF2ekDaW5g4nsLZF7
         X3dca4iY3u0hwnlb0mMKR/ahzCr54ZkTp+VR/oYmlx10+bP4tNUj1Wpqc8X4PkpsHpVU
         cqSWGij255NDjXfnCg29G9iRzmgmcXdyro42xbbSuZI1qQmF6HVboWFum/8lLn9mzty8
         Ew/g==
X-Gm-Message-State: AOAM532GdtNdcHxuMhdMdB17+oE+oqEw/P17d+PDuVnKfpK5pa5eOb6n
        rWS4ImOrGIQTCDuJq722zw4=
X-Google-Smtp-Source: ABdhPJwYbZdKc3KwdQ9V6TCPfF8E2WubTksv/nE+ZJSAcAm7tsEBQkSFPX/FwkmG4T6Qk6sLD1yNaQ==
X-Received: by 2002:a05:6402:5252:: with SMTP id t18mr11515330edd.258.1616178485541;
        Fri, 19 Mar 2021 11:28:05 -0700 (PDT)
Received: from localhost.localdomain ([188.24.140.160])
        by smtp.gmail.com with ESMTPSA id gb22sm3951070ejc.78.2021.03.19.11.28.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 19 Mar 2021 11:28:05 -0700 (PDT)
From:   Cristian Ciocaltea <cristian.ciocaltea@gmail.com>
To:     Rob Herring <robh+dt@kernel.org>,
        =?UTF-8?q?Andreas=20F=C3=A4rber?= <afaerber@suse.de>,
        Manivannan Sadhasivam <mani@kernel.org>
Cc:     devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-actions@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH 1/4] dt-bindings: soc: actions: Add Actions Semi Owl socinfo binding
Date:   Fri, 19 Mar 2021 20:27:59 +0200
Message-Id: <95105518f61408743d17783099ed9c373a3dfe18.1616178258.git.cristian.ciocaltea@gmail.com>
X-Mailer: git-send-email 2.31.0
In-Reply-To: <cover.1616178258.git.cristian.ciocaltea@gmail.com>
References: <cover.1616178258.git.cristian.ciocaltea@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add devicetree binding for the Actions Semi Owl SoCs info module.

Signed-off-by: Cristian Ciocaltea <cristian.ciocaltea@gmail.com>
---
 .../bindings/soc/actions/owl-socinfo.yaml     | 71 +++++++++++++++++++
 1 file changed, 71 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/soc/actions/owl-socinfo.yaml

diff --git a/Documentation/devicetree/bindings/soc/actions/owl-socinfo.yaml b/Documentation/devicetree/bindings/soc/actions/owl-socinfo.yaml
new file mode 100644
index 000000000000..3fcb1f584fdf
--- /dev/null
+++ b/Documentation/devicetree/bindings/soc/actions/owl-socinfo.yaml
@@ -0,0 +1,71 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/soc/actions/owl-socinfo.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Actions Semi Owl SoC info module
+
+maintainers:
+  - Cristian Ciocaltea <cristian.ciocaltea@gmail.com>
+
+description: |
+  Actions Semi Owl SoC info module provides access to various information
+  about the S500, S700 and S900 SoC variants, such as serial number or id.
+
+patternProperties:
+  "^soc(@[0-9a-f]+)?$":
+    type: object
+    properties:
+      compatible:
+        items:
+          - enum:
+              - actions,s500-soc
+              - actions,s700-soc
+              - actions,s900-soc
+          - const: simple-bus
+
+      "#address-cells":
+        enum: [1, 2]
+
+      "#size-cells":
+        enum: [1, 2]
+
+      ranges: true
+
+      actions,serial-number-addrs:
+        description: |
+          Contains the physical addresses in DDR memory where the two parts
+          of the serial number (low & high) can be read from.
+          This is currently supported only on the S500 SoC variant.
+        $ref: /schemas/types.yaml#/definitions/uint32-array
+        minItems: 2
+        maxItems: 2
+
+    required:
+      - compatible
+
+    additionalProperties:
+      type: object
+
+additionalProperties: true
+
+examples:
+  - |
+    / {
+        compatible = "roseapplepi,roseapplepi", "actions,s500";
+        model = "Roseapple Pi";
+        #address-cells = <1>;
+        #size-cells = <1>;
+
+        soc {
+            compatible = "actions,s500-soc", "simple-bus";
+            #address-cells = <1>;
+            #size-cells = <1>;
+            ranges;
+            actions,serial-number-addrs = <0x800>, /* S/N Low */
+                                          <0x804>; /* S/N High */
+        };
+    };
+
+...
-- 
2.31.0

