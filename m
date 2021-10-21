Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0FF0E43650F
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Oct 2021 17:07:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231738AbhJUPJk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 21 Oct 2021 11:09:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48212 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231207AbhJUPJi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Oct 2021 11:09:38 -0400
Received: from mail-wr1-x432.google.com (mail-wr1-x432.google.com [IPv6:2a00:1450:4864:20::432])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A1D45C061348
        for <linux-kernel@vger.kernel.org>; Thu, 21 Oct 2021 08:07:22 -0700 (PDT)
Received: by mail-wr1-x432.google.com with SMTP id s19so39955wra.2
        for <linux-kernel@vger.kernel.org>; Thu, 21 Oct 2021 08:07:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id;
        bh=jPp2ez40Oulq5oAldBcB94cKzrEc4MJ5Yq3ggAE4Sdo=;
        b=KlamjnSAY5WuQM0y/Yj0pi/fSt1fBfaemIGW2igtfXcWr/Zfx7/2HGLdaveBKRsTmn
         zROA7OVJPE5rFryMlTTmHwfKCWgVPoySSdoPfoBzcbEzqQh6SbH2Eimh7peg2EbPiLIn
         0VKn4pXfoG+yGIPEJiE6GARNHiec2f/8qFq9BXSjARiuLFE8W5o5T2UUZIGcT1wQnsWS
         GBEid8v97lgcbVIqJsWEfNChkmO7SZYYIgcvvbn/wk5ZgPQ5po6ICXwKYGA6/337jJYM
         7kI9AH+t+fOh2W4hl395TNv4WUPe5clWXKdNEUxTJs8mvgWTGNz1Xq8YNrClTD3vHqmd
         8onA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=jPp2ez40Oulq5oAldBcB94cKzrEc4MJ5Yq3ggAE4Sdo=;
        b=OzuGIglNSy3Wsvn3QIy8wIrgpV7aKUldsLXZoBAx7dKpWsL5tnVm1FsL2SFNsj7AQR
         I+/3zqk8IklCGTfYubcYEnaQpaTVGdxB6+7J+aypYL3fX88ORk7tYSKTUpYMPhPXWEqv
         gG8t9wUpKkcaXHFTRW/pCTW9iq7AK++EISXH4n5QQzMLB9pkafSY2KY/TzbK6HATxYTM
         QljdcrE5YlEBZdtffpLupdE+OO4IQ0pHWTPxFhsG8YIF/BZEwhH46mNhutvoOYQOHkJz
         YRjNKpzl8PSRFqcgSk2WhSOGxBooLdzsTNnIIaPS4EgEesykHBrV+Tp5zt396Fbo/gVi
         krnA==
X-Gm-Message-State: AOAM532swXrHjCEQulcSsZwOugSrzxzzTHNMd+KXN+4zNOpb1+xHhuMT
        PY4M1ERgkfgNFAKicFQKYjfmbyCUSeI=
X-Google-Smtp-Source: ABdhPJzd6Bk3FS4SqRARok6fPF2y6ZSek6qlZVxGSWf73xVb8Rw6NJvu1sEwiCAJTPzLZPeZLLr1OA==
X-Received: by 2002:adf:bb12:: with SMTP id r18mr7881092wrg.313.1634828841028;
        Thu, 21 Oct 2021 08:07:21 -0700 (PDT)
Received: from lmecxl0524.lme.st.com ([2a04:cec0:10f3:5b93:f8bd:7b81:c866:9456])
        by smtp.gmail.com with ESMTPSA id c15sm5106925wrs.19.2021.10.21.08.07.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 21 Oct 2021 08:07:20 -0700 (PDT)
From:   Etienne Carriere <etienne.carriere@linaro.org>
To:     linux-kernel@vger.kernel.org
Cc:     linux-arm-kernel@lists.infradead.org,
        Sudeep Holla <sudeep.holla@arm.com>,
        Cristian Marussi <cristian.marussi@arm.com>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Etienne Carriere <etienne.carriere@linaro.org>,
        devicetree@vger.kernel.org, Rob Herring <robh+dt@kernel.org>
Subject: [PATCH v5 1/2] dt-bindings: arm: Add OP-TEE transport for SCMI
Date:   Thu, 21 Oct 2021 17:07:16 +0200
Message-Id: <20211021150717.2718-1-etienne.carriere@linaro.org>
X-Mailer: git-send-email 2.17.1
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Introduce compatible "linaro,scmi-optee" for SCMI transport channel
based on an OP-TEE service invocation. The compatible mandates a
channel ID defined with property "linaro,optee-channel-id".

Cc: devicetree@vger.kernel.org
Cc: Rob Herring <robh+dt@kernel.org>
Signed-off-by: Etienne Carriere <etienne.carriere@linaro.org>
---
Changes since v4:
 - Fix sram node name in DTS example: s/-shm-/-sram-/

Changes since v3:
 - Add description for linaro,optee-channel-id in patternProperties
   specifying protocol can optionaly define a dedicated channel id.
 - Fix DTS example (duplicated phandles issue, subnodes ordering)
 - Fix typo in DTS example and description comments.

Changes since v2:
 - Define mandatory property linaro,optee-channel-id
 - Rebased on yaml description file

Changes since v1:
 - Removed modification regarding mboxes property description.
---
 .../bindings/firmware/arm,scmi.yaml           | 66 +++++++++++++++++++
 1 file changed, 66 insertions(+)

diff --git a/Documentation/devicetree/bindings/firmware/arm,scmi.yaml b/Documentation/devicetree/bindings/firmware/arm,scmi.yaml
index 5c4c6782e052..d09ebc80e713 100644
--- a/Documentation/devicetree/bindings/firmware/arm,scmi.yaml
+++ b/Documentation/devicetree/bindings/firmware/arm,scmi.yaml
@@ -38,6 +38,9 @@ properties:
                      The virtio transport only supports a single device.
         items:
           - const: arm,scmi-virtio
+      - description: SCMI compliant firmware with OP-TEE transport
+        items:
+          - const: linaro,scmi-optee
 
   interrupts:
     description:
@@ -83,6 +86,11 @@ properties:
     description:
       SMC id required when using smc or hvc transports
 
+  linaro,optee-channel-id:
+    $ref: /schemas/types.yaml#/definitions/uint32
+    description:
+      Channel specifier required when using OP-TEE transport.
+
   protocol@11:
     type: object
     properties:
@@ -195,6 +203,13 @@ patternProperties:
         minItems: 1
         maxItems: 2
 
+      linaro,optee-channel-id:
+        $ref: /schemas/types.yaml#/definitions/uint32
+        description:
+          Channel specifier required when using OP-TEE transport and
+          protocol has a dedicated communication channel.
+        maxItems: 1
+
     required:
       - reg
 
@@ -226,6 +241,16 @@ else:
       - arm,smc-id
       - shmem
 
+  else:
+    if:
+      properties:
+        compatible:
+          contains:
+            const: linaro,scmi-optee
+    then:
+      required:
+        - linaro,optee-channel-id
+
 examples:
   - |
     firmware {
@@ -340,7 +365,48 @@ examples:
                 reg = <0x11>;
                 #power-domain-cells = <1>;
             };
+        };
+    };
 
+  - |
+    firmware {
+        scmi {
+            compatible = "linaro,scmi-optee";
+            linaro,optee-channel-id = <0>;
+
+            #address-cells = <1>;
+            #size-cells = <0>;
+
+            scmi_dvfs1: protocol@13 {
+                reg = <0x13>;
+                linaro,optee-channel-id = <1>;
+                shmem = <&cpu_optee_lpri0>;
+                #clock-cells = <1>;
+            };
+
+            scmi_clk0: protocol@14 {
+                reg = <0x14>;
+                #clock-cells = <1>;
+            };
+        };
+    };
+
+    soc {
+        #address-cells = <2>;
+        #size-cells = <2>;
+
+        sram@51000000 {
+            compatible = "mmio-sram";
+            reg = <0x0 0x51000000 0x0 0x10000>;
+
+            #address-cells = <1>;
+            #size-cells = <1>;
+            ranges = <0 0x0 0x51000000 0x10000>;
+
+            cpu_optee_lpri0: optee-sram-section@0 {
+                compatible = "arm,scmi-shmem";
+                reg = <0x0 0x80>;
+            };
         };
     };
 
-- 
2.17.1

