Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 84F5C33B2AD
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Mar 2021 13:26:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229831AbhCOM0f (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 15 Mar 2021 08:26:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52664 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229718AbhCOM0M (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 Mar 2021 08:26:12 -0400
Received: from mail-wr1-x432.google.com (mail-wr1-x432.google.com [IPv6:2a00:1450:4864:20::432])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5C1C0C06175F;
        Mon, 15 Mar 2021 05:26:11 -0700 (PDT)
Received: by mail-wr1-x432.google.com with SMTP id k8so5585415wrc.3;
        Mon, 15 Mar 2021 05:26:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=pS078ZcCIx29RU55R2WWNIxxiQ2PLPKOcATYlxFAcpk=;
        b=ly4PwdFD+EOpshYxUqcGMnxctLABybCHLIjYPcExOgOdnwL+rSMRTt7reZHZdH228x
         IvffS+M0Yy84mkPUJpRMKAYuaLxmqfKpCpP81zXir2Oy8cwQpy1qbQqbhx5Im0OMSYxG
         zbpTmTBkCCQSrVkPg0UMh2hnmLtAig498x3NFMIKNtQ1AdsKX4bVHqt6EX7UM7uWTz94
         hHThKnM6/3m1dhv2UzGuhNgcInStTTLW5r5dT6t4MgfILVRptOMMXtZxwm9OLuxilw1E
         gTeinWv0uxboHugBfgKOe/eCiwsMPv7nqmk27Fimjx6AgbSVDJcZfvqKH7BEd+9RKcDE
         88Mw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=pS078ZcCIx29RU55R2WWNIxxiQ2PLPKOcATYlxFAcpk=;
        b=YOO7yIk8jcE9+/Eq12wRlACJJfMIQF+SJXPx8iGGwtuzrPB0lYSuhWR2DcLkTZ1fce
         t0Ili/XUWC++BMtLxwTvFTcLCmSP0CAyKk8yP8GSy5/u2A0zjdocrk1YWc1/OkBVIMiu
         iRBKaPj/zSwiW+uLJPtBgkCYXXiNT5OUt2CmnIhbhATpmAX1unbeuWLLXXiyHyqMUPFu
         jfyH32VGEV7P7X0ZfGSqVV2ct6oC9wAbPipCr4dBwJ4fKYZWbfbGtM5G4FzHB3Kg72nC
         znelHcZW0VuGOXFEJX7GyXngBZJSXQhZM27VfUDsUe6GG/PJRv0+VgMp49Qyx55t+Mea
         1Wpg==
X-Gm-Message-State: AOAM5329Z1NDDV7wHIXbdjKuFkRNgOAsCiqtKm314SRIKJoiu8JNdQzc
        Nhf2Q+rEZ4P2qT7MMMmrb4o=
X-Google-Smtp-Source: ABdhPJxsvTHkCv4b8La2/7hlcU9Uu31ZWMq96RKnKn42zfJLp5xQMgpJ4LDMMd1MZvVclM2METdG5w==
X-Received: by 2002:a5d:4fca:: with SMTP id h10mr28373914wrw.70.1615811170030;
        Mon, 15 Mar 2021 05:26:10 -0700 (PDT)
Received: from skynet.lan ([80.31.204.166])
        by smtp.gmail.com with ESMTPSA id o7sm18317851wrs.16.2021.03.15.05.26.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 15 Mar 2021 05:26:09 -0700 (PDT)
From:   =?UTF-8?q?=C3=81lvaro=20Fern=C3=A1ndez=20Rojas?= 
        <noltari@gmail.com>
To:     jonas.gorski@gmail.com,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        Nicolas Saenz Julienne <nsaenzjulienne@suse.de>,
        Maxime Ripard <maxime@cerno.tech>,
        =?UTF-8?q?=C3=81lvaro=20Fern=C3=A1ndez=20Rojas?= 
        <noltari@gmail.com>, Stefan Wahren <stefan.wahren@i2se.com>,
        Florian Fainelli <f.fainelli@gmail.com>,
        linux-clk@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     Rob Herring <robh@kernel.org>
Subject: [PATCH v2 3/4] dt-bindings: clock: Add BCM63268 timer binding
Date:   Mon, 15 Mar 2021 13:26:04 +0100
Message-Id: <20210315122605.28437-4-noltari@gmail.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20210315122605.28437-1-noltari@gmail.com>
References: <20210315122605.28437-1-noltari@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Document the Broadcom BCM63268 Clock and Reset controller.

Signed-off-by: Álvaro Fernández Rojas <noltari@gmail.com>
Reviewed-by: Rob Herring <robh@kernel.org>
---
 v2: no changes

 .../clock/brcm,bcm63268-timer-clocks.yaml     | 40 +++++++++++++++++++
 1 file changed, 40 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/clock/brcm,bcm63268-timer-clocks.yaml

diff --git a/Documentation/devicetree/bindings/clock/brcm,bcm63268-timer-clocks.yaml b/Documentation/devicetree/bindings/clock/brcm,bcm63268-timer-clocks.yaml
new file mode 100644
index 000000000000..199818b2fb6d
--- /dev/null
+++ b/Documentation/devicetree/bindings/clock/brcm,bcm63268-timer-clocks.yaml
@@ -0,0 +1,40 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/clock/brcm,bcm63268-timer-clocks.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Broadcom BCM63268 Timer Clock and Reset Device Tree Bindings
+
+maintainers:
+  - Álvaro Fernández Rojas <noltari@gmail.com>
+
+properties:
+  compatible:
+    const: brcm,bcm63268-timer-clocks
+
+  reg:
+    maxItems: 1
+
+  "#clock-cells":
+    const: 1
+
+  "#reset-cells":
+    const: 1
+
+required:
+  - compatible
+  - reg
+  - "#clock-cells"
+  - "#reset-cells"
+
+additionalProperties: false
+
+examples:
+  - |
+    timer_clk: clock-controller@100000ac {
+      compatible = "brcm,bcm63268-timer-clocks";
+      reg = <0x100000ac 0x4>;
+      #clock-cells = <1>;
+      #reset-cells = <1>;
+    };
-- 
2.20.1

