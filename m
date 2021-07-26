Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E71313D65BE
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Jul 2021 19:28:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240774AbhGZQrg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 26 Jul 2021 12:47:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41318 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240507AbhGZQra (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Jul 2021 12:47:30 -0400
Received: from mail-ej1-x62c.google.com (mail-ej1-x62c.google.com [IPv6:2a00:1450:4864:20::62c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4E9D0C0068AE;
        Mon, 26 Jul 2021 10:18:23 -0700 (PDT)
Received: by mail-ej1-x62c.google.com with SMTP id hp25so17407440ejc.11;
        Mon, 26 Jul 2021 10:18:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=o+RqgTUgMKqnDrEgLgnoBoRlpOtwLUFaR9Eyi34Ya74=;
        b=ZQTj6N85FWr2yQVxXoP7KF8H1bNwbDUiG0M9BsE5JAmjlxzVZxKs1wKSXch1XR9wMX
         ji50swyBkhmNszyJFZeSVJy2LtMMr/EQuMfsYsD6GIV9htVdFHzyY3F2XVvE0E+fGTg/
         FPNu5BQ95aM3bW8sQd8eQA1Xh1xMI5etkNOsLwpET6s+wJmkftdf4RmpWNvd9NT5+Gcj
         2rVMqLoL4YQwym5hFnP009di9BKbVJkl0REVHQ7qgGcScv85YNEoS5ZjyYp2dipkqakP
         Cmus5PuRVR7TTc6gl93FcLbblRJZns7TrTswIL9Twu2AtTH46C1on51rsf69eVdGcryP
         gObg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
         :in-reply-to:references:mime-version:content-transfer-encoding;
        bh=o+RqgTUgMKqnDrEgLgnoBoRlpOtwLUFaR9Eyi34Ya74=;
        b=ZX9s2YwHJJFIL6wnh+UBKUX7dqI2PwwMjR1JTNJWifD1yyZrtBlCGe1gqShiUIMAjX
         9mh4fAWG+6e6werULc3YwbUdsVRiLq6j20PJdOE1pIacCS6m3nkTxsLvH3/gViOpcnLv
         eRdYYwUfZfUYisgOvHHvpcG/a4nNBC6zliL97CLWa2P5rxkmwMv1CH/cJ6zz0DgbH+gk
         ylyJGn3u1A8h3wvn3hkz9bFiPlBoVbibDSQRoQlL+r6sODJ8MXt+UKIp14I/HZaJ8KPR
         kFJK+st+gzks3JUmMCljyhAyzTcumBOV54rqCqO9OV9H1VV+sgJfDj5+oIVJLAfTF7sT
         74hQ==
X-Gm-Message-State: AOAM530f5ENOmkTSQwE+9CkYa7RNr6QgcN/31WuVXk+7Ywhkar5hZ3LH
        ViMEA7JzpREGfFqxqmf1D2I=
X-Google-Smtp-Source: ABdhPJzUpmF28NarbeUv+J/mAkoodeqgfWPa4GOATRr3oVDqyoCPHJrZMWU6ZGoUXrmgHXM0nkOGiQ==
X-Received: by 2002:a17:906:c006:: with SMTP id e6mr18245052ejz.510.1627319901954;
        Mon, 26 Jul 2021 10:18:21 -0700 (PDT)
Received: from stitch.. ([2a01:4262:1ab:c:132c:4c2b:f8ab:5392])
        by smtp.gmail.com with ESMTPSA id e7sm195932edk.3.2021.07.26.10.18.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 26 Jul 2021 10:18:21 -0700 (PDT)
Sender: Emil Renner Berthing <emil.renner.berthing@gmail.com>
From:   Emil Renner Berthing <kernel@esmil.dk>
To:     Jean Delvare <jdelvare@suse.com>,
        Guenter Roeck <linux@roeck-us.net>,
        Rob Herring <robh+dt@kernel.org>,
        Jonathan Corbet <corbet@lwn.net>,
        Samin Guo <samin.guo@starfivetech.com>
Cc:     Emil Renner Berthing <kernel@esmil.dk>,
        linux-hwmon@vger.kernel.org, devicetree@vger.kernel.org,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
        Rob Herring <robh@kernel.org>
Subject: [PATCH v3 1/2] dt-bindings: hwmon: add starfive,jh7100-temp bindings
Date:   Mon, 26 Jul 2021 19:18:01 +0200
Message-Id: <20210726171802.1052716-2-kernel@esmil.dk>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <20210726171802.1052716-1-kernel@esmil.dk>
References: <20210726171802.1052716-1-kernel@esmil.dk>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add bindings for the temperature sensor on the StarFive JH7100 SoC.

Signed-off-by: Emil Renner Berthing <kernel@esmil.dk>
Reviewed-by: Rob Herring <robh@kernel.org>
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

