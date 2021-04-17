Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C4DEC362F98
	for <lists+linux-kernel@lfdr.de>; Sat, 17 Apr 2021 13:33:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236375AbhDQLbT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 17 Apr 2021 07:31:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36392 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236231AbhDQLan (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 17 Apr 2021 07:30:43 -0400
Received: from mail-ej1-x635.google.com (mail-ej1-x635.google.com [IPv6:2a00:1450:4864:20::635])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DF05BC061763;
        Sat, 17 Apr 2021 04:30:16 -0700 (PDT)
Received: by mail-ej1-x635.google.com with SMTP id sd23so37191134ejb.12;
        Sat, 17 Apr 2021 04:30:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=y3wm7faQjf3OHfSZwDN9B47guWYbbRlys9qJW4VJCQI=;
        b=YS3bWQV33LBDIsf0GQbDPJwfKepFfw+Dswv6TFLEy006J1DL3ISiAOFfkFoQwQdrJ2
         Htko0opDCb7zWI2nNTo6Z8Z/6uhXFtOHs8e9JTl8TMoEI7StawB2KhWTiVMD1cA0c5KB
         fnaZgJ96uPSQMTEeK9FptQkgMhxBqqBpHWWdFMwPgIlgzvGT/1AW9dIQLPNd1AUGkGeO
         NkPPBwqWo/esyfI0g40bFC7pFksQwGG0QQMom9jwQo7sejkbaaXmtvV6WESfwhEBCa/u
         ATHi4SMtCY0dw5J10/slRCWtBNIwz1tOsCIm8093TMgyBL9D+DsiCcEBswxTkjcmORxG
         FvNw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=y3wm7faQjf3OHfSZwDN9B47guWYbbRlys9qJW4VJCQI=;
        b=dkTuOTr4wOdHeO3EPuCBvXgt83fHNZwiuOqXszMClqMRdWvDRLyN0TlMcZNmxIHn1D
         YvlzIxdo038tybfAhWLVWk/RTx/ycHtCkT1O1rjmg/wKBiDw3tiP+U8rqG9ZjHVKSbGg
         EkSBiftWj+lr+V0df0vbbAJfEMLlmf0EjpP9DOGzQP/Alpzbkm0o/nJHHXmj98sSDAOv
         lur7o5RdDBKCoW2i31pqEfGSVZb5A7sWRGQd5Z1qAd9PVG11KyBJRqYhjG6H0elA+R7j
         JNvAmcnRqKQZQiGloq3xPTfmNAZT+IvVa64zM+x8nZjEagol9SrHzJBx+QXPVU3Vx2z3
         YZ/g==
X-Gm-Message-State: AOAM533BxGlr6747+vN8df7r3JS8o+1NUsbND35QJun3/HvHB+xjMKBl
        B6p0fVh+yz62k9zfqdvPslc=
X-Google-Smtp-Source: ABdhPJzb3y9MXZdf7V8IoJrEab1zt8geOX/i3hCvDrAJrasP+3Sg9fE2m7sAT9v+6j8iCJXxAfNYCQ==
X-Received: by 2002:a17:906:c08f:: with SMTP id f15mr12843436ejz.318.1618659015690;
        Sat, 17 Apr 2021 04:30:15 -0700 (PDT)
Received: from debian.home (81-204-249-205.fixed.kpn.net. [81.204.249.205])
        by smtp.gmail.com with ESMTPSA id f20sm3022875ejw.36.2021.04.17.04.30.14
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 17 Apr 2021 04:30:15 -0700 (PDT)
From:   Johan Jonker <jbx6244@gmail.com>
To:     heiko@sntech.de
Cc:     robh+dt@kernel.org, zhangqing@rock-chips.com,
        enric.balletbo@collabora.com, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-rockchip@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH v9 11/15] dt-bindings: arm: rockchip: convert pmu.txt to YAML
Date:   Sat, 17 Apr 2021 13:29:48 +0200
Message-Id: <20210417112952.8516-12-jbx6244@gmail.com>
X-Mailer: git-send-email 2.11.0
In-Reply-To: <20210417112952.8516-1-jbx6244@gmail.com>
References: <20210417112952.8516-1-jbx6244@gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Current dts files with 'pmu' nodes are manually verified.
In order to automate this process pmu.txt
has to be converted to yaml.

Signed-off-by: Johan Jonker <jbx6244@gmail.com>
Reviewed-by: Rob Herring <robh@kernel.org>
---
 .../devicetree/bindings/arm/rockchip/pmu.txt       | 16 -------
 .../devicetree/bindings/arm/rockchip/pmu.yaml      | 49 ++++++++++++++++++++++
 2 files changed, 49 insertions(+), 16 deletions(-)
 delete mode 100644 Documentation/devicetree/bindings/arm/rockchip/pmu.txt
 create mode 100644 Documentation/devicetree/bindings/arm/rockchip/pmu.yaml

diff --git a/Documentation/devicetree/bindings/arm/rockchip/pmu.txt b/Documentation/devicetree/bindings/arm/rockchip/pmu.txt
deleted file mode 100644
index 3ee9b428b..000000000
--- a/Documentation/devicetree/bindings/arm/rockchip/pmu.txt
+++ /dev/null
@@ -1,16 +0,0 @@
-Rockchip power-management-unit:
--------------------------------
-
-The pmu is used to turn off and on different power domains of the SoCs
-This includes the power to the CPU cores.
-
-Required node properties:
-- compatible value : = "rockchip,rk3066-pmu";
-- reg : physical base address and the size of the registers window
-
-Example:
-
-	pmu@20004000 {
-		compatible = "rockchip,rk3066-pmu";
-		reg = <0x20004000 0x100>;
-	};
diff --git a/Documentation/devicetree/bindings/arm/rockchip/pmu.yaml b/Documentation/devicetree/bindings/arm/rockchip/pmu.yaml
new file mode 100644
index 000000000..0b816943d
--- /dev/null
+++ b/Documentation/devicetree/bindings/arm/rockchip/pmu.yaml
@@ -0,0 +1,49 @@
+# SPDX-License-Identifier: GPL-2.0
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/arm/rockchip/pmu.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Rockchip Power Management Unit (PMU)
+
+maintainers:
+  - Elaine Zhang <zhangqing@rock-chips.com>
+  - Heiko Stuebner <heiko@sntech.de>
+
+description: |
+  The PMU is used to turn on and off different power domains of the SoCs.
+  This includes the power to the CPU cores.
+
+select:
+  properties:
+    compatible:
+      contains:
+        enum:
+          - rockchip,rk3066-pmu
+
+  required:
+    - compatible
+
+properties:
+  compatible:
+    items:
+      - enum:
+          - rockchip,rk3066-pmu
+      - const: syscon
+      - const: simple-mfd
+
+  reg:
+    maxItems: 1
+
+required:
+  - compatible
+  - reg
+
+additionalProperties: true
+
+examples:
+  - |
+    pmu@20004000 {
+      compatible = "rockchip,rk3066-pmu", "syscon", "simple-mfd";
+      reg = <0x20004000 0x100>;
+    };
-- 
2.11.0

