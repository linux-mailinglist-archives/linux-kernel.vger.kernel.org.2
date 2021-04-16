Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 22685361B60
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Apr 2021 10:34:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239718AbhDPIIT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 16 Apr 2021 04:08:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43088 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235020AbhDPIIS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 16 Apr 2021 04:08:18 -0400
Received: from mail-ej1-x631.google.com (mail-ej1-x631.google.com [IPv6:2a00:1450:4864:20::631])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 24F34C061574;
        Fri, 16 Apr 2021 01:07:54 -0700 (PDT)
Received: by mail-ej1-x631.google.com with SMTP id w23so25021150ejb.9;
        Fri, 16 Apr 2021 01:07:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=JB/6AfI4ud8q47U6IB+7D2XVQS2wvjRMG+o3isDfwPk=;
        b=gX9kjeKTIrlEdDQZhJ3nxnCkByo/W5bezm2SwwaIQFgr1v6e/AQYEKYc88mVWvDbev
         3nOCQcc6ycWLc314y9oz8HfO+f7/ijdTQfJNEm2j06jrAMpkEi+biFG2bEEmhQbGYnLX
         FyMeW+8ckeUDTmYB4yG6dB74BlSnwHdZrs7uG1Jyudbr0cXCxTp+kWn0xdnXfImfLIv3
         YZ8GscJY3/63egkVdR4iFc1NxBG3u3lY2LlQElQKavGsHKe9NHFrzFpjCpLtwK8cxMbF
         m95rVOwN2XYBZMeGCTCl3AdTZO8nucKiTUDY6gempDR8ZPEs0bHkB6Ai78GNatJAQP28
         Y1OA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=JB/6AfI4ud8q47U6IB+7D2XVQS2wvjRMG+o3isDfwPk=;
        b=VdGNUCq3xqbEJuGThSHOLSgUhTTKY0Aa8DJX9s8SFHGILVQ/NPNEatt6Sef/h5bY+C
         8V+vi+xAvFmBbqXMYBKHI98W6+cc2sqoFds94QRQVvXKWhIamxDRtWTp9Nj7esnwkHDU
         0/afkOj0XvgJTA2xmDc+SRv5NwKyp7zHNadE3TdSf2xYK0KweaW29ePq1BRVKKNcsBgt
         DOivUUHPg3M8RwvaGS4vRscqbmCGNDJGw5+AFVz5l07a9vfssuR0iji79B3MKeC69CzD
         W5ikjwnsnux6qVSafH6jyCKpOm6DgA8N1mPJvQ3bmfcXttDdyD1TaIlx4y1LfMKyGbHz
         uYng==
X-Gm-Message-State: AOAM533jthEYLopgyaHHMmH3eL9XOLMiUurZT5zZFrPBd6b/oKoGFiq2
        g41IfxZpH95TphX77k17o/c=
X-Google-Smtp-Source: ABdhPJz0qwv5UviIlnsK3nx1HPlgfkqcRasGMe4EXUnjKGPYp+ZNof/CYOEvlKn0P3kjoEnQ5iIqoA==
X-Received: by 2002:a17:906:e84:: with SMTP id p4mr7194244ejf.248.1618560472807;
        Fri, 16 Apr 2021 01:07:52 -0700 (PDT)
Received: from debian.home (81-204-249-205.fixed.kpn.net. [81.204.249.205])
        by smtp.gmail.com with ESMTPSA id q16sm4672303edv.61.2021.04.16.01.07.37
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 16 Apr 2021 01:07:52 -0700 (PDT)
From:   Johan Jonker <jbx6244@gmail.com>
To:     heiko@sntech.de
Cc:     robh+dt@kernel.org, zhangqing@rock-chips.com,
        enric.balletbo@collabora.com, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-rockchip@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH v8 11/15] dt-bindings: arm: rockchip: convert pmu.txt to YAML
Date:   Fri, 16 Apr 2021 10:03:38 +0200
Message-Id: <20210416080342.18614-12-jbx6244@gmail.com>
X-Mailer: git-send-email 2.11.0
In-Reply-To: <20210416080342.18614-1-jbx6244@gmail.com>
References: <20210416080342.18614-1-jbx6244@gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Current dts files with 'pmu' nodes are manually verified.
In order to automate this process pmu.txt
has to be converted to yaml.

Signed-off-by: Johan Jonker <jbx6244@gmail.com>
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

