Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3F24144720D
	for <lists+linux-kernel@lfdr.de>; Sun,  7 Nov 2021 08:42:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235134AbhKGHoy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 7 Nov 2021 02:44:54 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57704 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235004AbhKGHos (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 7 Nov 2021 02:44:48 -0500
Received: from mail-wm1-x32a.google.com (mail-wm1-x32a.google.com [IPv6:2a00:1450:4864:20::32a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2F2FCC061570;
        Sun,  7 Nov 2021 00:42:06 -0700 (PDT)
Received: by mail-wm1-x32a.google.com with SMTP id 71so10491958wma.4;
        Sun, 07 Nov 2021 00:42:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=OJp/wZiERGVBUU7HIuspGPpojRpXm2e3BfdSR6ZgDTc=;
        b=PP0yCHrPUsuBD3zKIXVoPdLYQJwcdFQrEACEv/HmWaSTnmRGe8xw3bBQFxKu0b7bVM
         NwhbsiTtmfhpQJqjjSeCdRpQVyFv3hXUgFIjkmrhqfuHGEOQcVT4IxYA1TN087pJjcve
         /bGSpiYgYrnscBv8HLgh8fa5tk7/7cOWIc0dKwm+ebIRp/h4+22jDt9O2SD+RjmYAOu2
         ygI/iD9fBxr/YIpx8zDtbmdJ/861DXBC5wFg7kWcUYeL4SUOHbqQPnZ5ZZkN3oroe8LK
         IZgcT1GyPDXVgeJXGpWlUNAQMywhrtHXpg+zRB9hv9yyqEpd+gQZWLJsxZnf7/7mbGMv
         cJ3Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=OJp/wZiERGVBUU7HIuspGPpojRpXm2e3BfdSR6ZgDTc=;
        b=RMYG8G0Y7fXlIpNwaRsNHIFn59nHdLWEc4X9mJssLfrvCCtsJZkMeVD+9dYLjA/s34
         SFTHDwzseN/nDInmxupazHe3VRu9x963tB4U+E4P09Y8nYbjsAEWSGauXhJU3qSGKD1U
         Jbx5ei8Qat3YWD0exYAjH+YV7BP/UlpF2Z4TH70ua8k+yVB03tb7LEoSufasNkfHOfGG
         4BPWtWFtuv3hdb+fKMPfRKNOIgdDK/WPAHufzTd4HNCUPVLzxSleRTu0E9Cq7udjIga/
         Ei2QIdoBpUR/Z+lt2IcEamEr23ZOQIDvaODAa7XkOUj+A9oYilxI1EIwl3HquwCbVtYJ
         +JuA==
X-Gm-Message-State: AOAM530WkQzRy0QXYWsWUeA71S1xx/jQdYcnRZpHCcCA0t/Eu3zqasTP
        PvAiHkZlnH+EgFtsAjgJ+rFyquVH2AxiFw==
X-Google-Smtp-Source: ABdhPJwFV2uyo9fINU7WHNoT0sKrZNhrhElgzc60E2wNGxZJG6LSejSb2gQx+gNvO4hNqJUXh4++TA==
X-Received: by 2002:a7b:c084:: with SMTP id r4mr45972882wmh.117.1636270924550;
        Sun, 07 Nov 2021 00:42:04 -0700 (PDT)
Received: from localhost.localdomain (252.red-83-54-181.dynamicip.rima-tde.net. [83.54.181.252])
        by smtp.gmail.com with ESMTPSA id e12sm15353352wrq.20.2021.11.07.00.42.03
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 07 Nov 2021 00:42:04 -0700 (PDT)
From:   Sergio Paracuellos <sergio.paracuellos@gmail.com>
To:     linux-clk@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, sboyd@kernel.org, john@phrozen.org,
        linux-staging@lists.linux.dev, gregkh@linuxfoundation.org,
        neil@brown.name, Rob Herring <robh@kernel.org>
Subject: [PATCH v5 2/4] dt-bindings: clock: mediatek,mt7621-sysc: add '#reset-cells' property
Date:   Sun,  7 Nov 2021 08:41:58 +0100
Message-Id: <20211107074200.18911-3-sergio.paracuellos@gmail.com>
X-Mailer: git-send-email 2.33.0
In-Reply-To: <20211107074200.18911-1-sergio.paracuellos@gmail.com>
References: <20211107074200.18911-1-sergio.paracuellos@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Make system controller a reset provider for all the peripherals in the
MT7621 SoC adding '#reset-cells' property.

Acked-by: Rob Herring <robh@kernel.org>
Signed-off-by: Sergio Paracuellos <sergio.paracuellos@gmail.com>
---
 .../bindings/clock/mediatek,mt7621-sysc.yaml         | 12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/Documentation/devicetree/bindings/clock/mediatek,mt7621-sysc.yaml b/Documentation/devicetree/bindings/clock/mediatek,mt7621-sysc.yaml
index 915f84efd763..0c0b0ae5e2ac 100644
--- a/Documentation/devicetree/bindings/clock/mediatek,mt7621-sysc.yaml
+++ b/Documentation/devicetree/bindings/clock/mediatek,mt7621-sysc.yaml
@@ -22,6 +22,11 @@ description: |
 
   The clocks are provided inside a system controller node.
 
+  This node is also a reset provider for all the peripherals.
+
+  Reset related bits are defined in:
+  [2]: <include/dt-bindings/reset/mt7621-reset.h>.
+
 properties:
   compatible:
     items:
@@ -37,6 +42,12 @@ properties:
       clocks.
     const: 1
 
+  "#reset-cells":
+    description:
+      The first cell indicates the reset bit within the register, see
+      [2] for available resets.
+    const: 1
+
   ralink,memctl:
     $ref: /schemas/types.yaml#/definitions/phandle
     description:
@@ -61,6 +72,7 @@ examples:
       compatible = "mediatek,mt7621-sysc", "syscon";
       reg = <0x0 0x100>;
       #clock-cells = <1>;
+      #reset-cells = <1>;
       ralink,memctl = <&memc>;
       clock-output-names = "xtal", "cpu", "bus",
                            "50m", "125m", "150m",
-- 
2.33.0

