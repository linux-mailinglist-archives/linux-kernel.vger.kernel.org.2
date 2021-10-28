Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 200DD43E2F4
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Oct 2021 16:01:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231169AbhJ1OC7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 28 Oct 2021 10:02:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52892 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231140AbhJ1OCn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Oct 2021 10:02:43 -0400
Received: from mail-wm1-x32d.google.com (mail-wm1-x32d.google.com [IPv6:2a00:1450:4864:20::32d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7C0F0C061767
        for <linux-kernel@vger.kernel.org>; Thu, 28 Oct 2021 07:00:16 -0700 (PDT)
Received: by mail-wm1-x32d.google.com with SMTP id m42so5904725wms.2
        for <linux-kernel@vger.kernel.org>; Thu, 28 Oct 2021 07:00:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id;
        bh=hwlpnlC96Iq4yd/qa1MHN9OndDMbSpFJ5nBOkRygT0Y=;
        b=v7pv9yFdFEbIlIWFU/23dm3MCFkl8dcEEeRSQjwKDYEhnFoP9/1S063RARz44GmDaM
         40KEujEAQO6COS4Rz8mlTArmgDPA3OhB1K5E61MyOzEpzqxBBgVfniWqSoUyYA18VHo3
         pAuhcAVtaJidD75t441nDkL5XG1fxRqhrXKZ1U21rNXagDk/redDafmM7oAyl4xBCuDF
         Lm4VOHYbzxVhgDpWe/jhXEsDLhlWj46LXveTHSjJVfHUv5vFbk1vE3V5zUhcF+BH9fdh
         HFefdkS0jhlXyv2KIiqYy3+/j8UiFC//gGtLbwLyP/hradZcqaftkZzGLhyz6b5CzywF
         XDtA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=hwlpnlC96Iq4yd/qa1MHN9OndDMbSpFJ5nBOkRygT0Y=;
        b=E1S2Ea1/Q6KIbkbICFBmJLtD/m6JPtXw3t6gtnou+yxnDwGejXEjw07RC7v8PI0aJz
         9t0zliURRDcGPcWr2Av8URNnWlZofLssIeBZWIYoRZe1pIe89FeZx0kofV6UHTeCd+C+
         Qp/OmvQyxM8eWG48zUaZmQGBxoJCVnPH3U6cgnyQP7UFYiK7nHZdpyeX0EgR2oPFqFN+
         APVFHp3JMfkWcYkU0Z2awI3fUbbojMxRuxMYBLInPT4oFhua9OaZ3AQtJSLjetm2lGtS
         6dLls8qzd7aPYGB5IYPAT692RsyE1pSi4LEoVFgnzegoHkfIs6AhWMUpwArU1GoDfUTI
         eScA==
X-Gm-Message-State: AOAM533DYWH2d+qSnbMeY5HV/m1JX6+v1LzONdo0nzhn/fs8AfdaV4r7
        dZyOBgUWYbyxPE57ScTKqh8wo7Nlat8oVw==
X-Google-Smtp-Source: ABdhPJwJ+02NUgidXxf8pb1dMVqiMmu/FPmh0/EQ6EzWDLAPhjrT5qeOq6Kx6tIoctfu2ZLbpqUuIg==
X-Received: by 2002:a05:600c:4f96:: with SMTP id n22mr4773500wmq.168.1635429614704;
        Thu, 28 Oct 2021 07:00:14 -0700 (PDT)
Received: from lmecxl0524.lme.st.com ([80.215.4.29])
        by smtp.gmail.com with ESMTPSA id s3sm6205693wmh.30.2021.10.28.07.00.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 28 Oct 2021 07:00:14 -0700 (PDT)
From:   Etienne Carriere <etienne.carriere@linaro.org>
To:     linux-kernel@vger.kernel.org
Cc:     linux-arm-kernel@lists.infradead.org,
        Sudeep Holla <sudeep.holla@arm.com>,
        Cristian Marussi <cristian.marussi@arm.com>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Etienne Carriere <etienne.carriere@linaro.org>,
        devicetree@vger.kernel.org, Rob Herring <robh+dt@kernel.org>
Subject: [PATCH v8 1/2] dt-bindings: arm: Add OP-TEE transport for SCMI
Date:   Thu, 28 Oct 2021 16:00:08 +0200
Message-Id: <20211028140009.23331-1-etienne.carriere@linaro.org>
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
Changes since v6:
 - Remove maxItems from linaro,optee-channel-id description

No change since v5

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
 .../bindings/firmware/arm,scmi.yaml           | 65 +++++++++++++++++++
 1 file changed, 65 insertions(+)

diff --git a/Documentation/devicetree/bindings/firmware/arm,scmi.yaml b/Documentation/devicetree/bindings/firmware/arm,scmi.yaml
index 5c4c6782e052..eae15df36eef 100644
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
@@ -195,6 +203,12 @@ patternProperties:
         minItems: 1
         maxItems: 2
 
+      linaro,optee-channel-id:
+        $ref: /schemas/types.yaml#/definitions/uint32
+        description:
+          Channel specifier required when using OP-TEE transport and
+          protocol has a dedicated communication channel.
+
     required:
       - reg
 
@@ -226,6 +240,16 @@ else:
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
@@ -340,7 +364,48 @@ examples:
                 reg = <0x11>;
                 #power-domain-cells = <1>;
             };
+        };
+    };
+
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

