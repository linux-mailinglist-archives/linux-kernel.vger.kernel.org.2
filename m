Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D7F8B3AA302
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Jun 2021 20:16:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231723AbhFPSST (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 16 Jun 2021 14:18:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48056 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231599AbhFPSSO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Jun 2021 14:18:14 -0400
Received: from mail-ed1-x52c.google.com (mail-ed1-x52c.google.com [IPv6:2a00:1450:4864:20::52c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0EAA1C06175F;
        Wed, 16 Jun 2021 11:16:06 -0700 (PDT)
Received: by mail-ed1-x52c.google.com with SMTP id b11so379996edy.4;
        Wed, 16 Jun 2021 11:16:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=iFHbHNL8aARZIdIs1Si1a8lzKbqAKunaBKMyM5zoCYc=;
        b=JwKsVxqZRSTi5ZxZzs/eX9EYninAH+fl3MKr6gJWnCV9PEOqevy3/TUMAQOYp1X2KA
         hrJwdFOXUYOo43/gTX7Rff0Ks2RyGBJ8MRL5Z3kk2qIX+poGaE8LFaCvEmj+zQUnl7J0
         Wpx7cEip6Z8vJ2YcWD+ypOLUVKCTYjRnW6rfW+vjlMXGtPpTqpT6eBjWEnZeF/dGAoNm
         Rt6pPVpS03eyIOxAdrDEDM7TmPzi7GkUA6LgInAgeNrAV5k8mccUEKHdRgmz90Utm0fE
         fBt9zEbH1LQs2taE2cqiLwoplX3RoyFVRmzCfv41hQBfNtHtJlf8Qh97Wie7yd69YAFd
         29uA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
         :in-reply-to:references:mime-version:content-transfer-encoding;
        bh=iFHbHNL8aARZIdIs1Si1a8lzKbqAKunaBKMyM5zoCYc=;
        b=mrOgTJmtjEbs5x8putVmbTjw/xjNbPdefvdAS3FAAK3BZdNgdHf9LC2EJ0fyAaHwWU
         8euu4Ds+VNb0LwpuBCYMV5sjyg8ERUWJTbQVOHDehXVqK9CmMRaNp51SU2pJ0rKVHaVD
         eW3hRoCJ0XEEReID/UsYSnwVqNa2r/wpYdGaZ6T8RoPwvWGTVihU8rulhjQXXONTnuXl
         y8qnNvCBqGR2pf2PEVSy+H+oCYPfsfO3Qyx/RCqNEzQdIiFqAmKqDOOGJs1GkdLprjJU
         777+vVCogyd9nHgCis4lI1mI9dRWeGpJhMx8rdAPwo2hmq/OEEPz1T9c+6kECdS7iUp4
         JtKw==
X-Gm-Message-State: AOAM533RhACIfmXGbRYKdaTj8R3T7iWqjkvXdc/OKCpMooHTZrNA7S6r
        fM5X9HtcPkf9sP83kMClt3s=
X-Google-Smtp-Source: ABdhPJyicGVe2nDPoDMh8yNZ0pz2xzs1PJm7Snp+vaSTQ7irFjWX0VpwaTAGLCpQBvwMpZBdvLdSMg==
X-Received: by 2002:a05:6402:b6f:: with SMTP id cb15mr1289922edb.25.1623867364582;
        Wed, 16 Jun 2021 11:16:04 -0700 (PDT)
Received: from stitch.. ([82.192.166.82])
        by smtp.gmail.com with ESMTPSA id p10sm2439599edy.86.2021.06.16.11.16.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 16 Jun 2021 11:16:04 -0700 (PDT)
Sender: Emil Renner Berthing <emil.renner.berthing@gmail.com>
From:   Emil Renner Berthing <kernel@esmil.dk>
To:     Jean Delvare <jdelvare@suse.com>,
        Guenter Roeck <linux@roeck-us.net>,
        Rob Herring <robh+dt@kernel.org>,
        Samin Guo <samin.guo@starfivetech.com>
Cc:     Emil Renner Berthing <kernel@esmil.dk>,
        linux-hwmon@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v1 1/2] dt-bindings: hwmon: add starfive,jh7100-temp bindings
Date:   Wed, 16 Jun 2021 20:15:44 +0200
Message-Id: <20210616181545.496149-2-kernel@esmil.dk>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <20210616181545.496149-1-kernel@esmil.dk>
References: <20210616181545.496149-1-kernel@esmil.dk>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add bindings for the temperature sensor on the StarFive JH7100 SoC.

Signed-off-by: Emil Renner Berthing <kernel@esmil.dk>
---
 .../bindings/hwmon/starfive,jh7100-temp.yaml  | 43 +++++++++++++++++++
 1 file changed, 43 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/hwmon/starfive,jh7100-temp.yaml

diff --git a/Documentation/devicetree/bindings/hwmon/starfive,jh7100-temp.yaml b/Documentation/devicetree/bindings/hwmon/starfive,jh7100-temp.yaml
new file mode 100644
index 000000000000..5ca52c08d142
--- /dev/null
+++ b/Documentation/devicetree/bindings/hwmon/starfive,jh7100-temp.yaml
@@ -0,0 +1,43 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/hwmon/starfive,jh7100-temp.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: StarFive JH7100 Temperature Sensor
+
+maintainers:
+  - Emil Renner Berthing <kernel@esmil.dk>
+
+description: |
+  StarFive Technology Co. JH7100 embedded temperature sensor
+
+properties:
+  compatible:
+    enum:
+      - starfive,jh7100-temp
+
+  reg:
+    maxItems: 1
+
+  '#thermal-sensor-cells':
+    const: 0
+
+  interrupts:
+    maxItems: 1
+
+required:
+  - compatible
+  - reg
+  - interrupts
+
+additionalProperties: false
+
+examples:
+  - |
+    tmon: tmon@124a0000 {
+        compatible = "starfive,jh7100-temp";
+        reg = <0x124a0000 0x10000>;
+        #thermal-sensor-cells = <0>;
+        interrupts = <122>;
+    };
-- 
2.32.0

