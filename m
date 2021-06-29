Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4559C3B77BF
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Jun 2021 20:21:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235110AbhF2SXe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 29 Jun 2021 14:23:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41488 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235066AbhF2SXY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 Jun 2021 14:23:24 -0400
Received: from mail-ed1-x52f.google.com (mail-ed1-x52f.google.com [IPv6:2a00:1450:4864:20::52f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D851BC061766;
        Tue, 29 Jun 2021 11:20:55 -0700 (PDT)
Received: by mail-ed1-x52f.google.com with SMTP id i24so32529866edx.4;
        Tue, 29 Jun 2021 11:20:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=m5VtxKCWi+Hl3p1oi1ZS03GEzAowfOsvM+40k9oMniI=;
        b=Y+G+uJdDNBYT4Q7Fj6e6fjAmVB1gIWmyRMm+xo+ujEmW0znVHuyP+6t95WOGUYgBIk
         X369iiJEJ5fmEF8HGQqsOlZyaGxavaS+5vKhxNWkiqh7Tz0KqHzPDdCqjAqLTJIAha5o
         ZOg4XoNSTv0si8f0ugR6hUkmtwPOsXkVj2qxcocqL5pNI6sNUKiVkMwOAHBmaBy1IaZ6
         Nwb16gzTTM7qB9Vh+MiBodmW6bdPsbTxbjqIhth6Is4hFFYChSpGQbsTHXtH4CyXGUxl
         bV7exAFEK+5HAXiwD/BJpopmBWDDwmrE6UsIPa2EJ6GwwhvFxQsP6NlHC4JtVhP/cbti
         stjw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=m5VtxKCWi+Hl3p1oi1ZS03GEzAowfOsvM+40k9oMniI=;
        b=knvoZoE7+jnE0d5PWL7RE2DNqdqWtAODk85l78xLfkZaNmirMcjX0nzjQS0X1d+OY1
         s1BMtzSuNGMQUUFETTlaEr9nTZaCfNTdgALfSw+r5NF6Jcb3WmiIPxTuPh2KF2tArNw3
         nJOgd77uiE2AxV5/Yw0ZVUzWUAp3Wbc2xmra0gTPbSnDxKFLuY6nVI0C43SvBWDUzbZ8
         M937+aDuvy0R0KkYUKT5AlHzMePSSrRkTblTGESKIVjwuW2upeoboqMlLQjp6E0P8m1b
         2fnUu9sxGqj2Dj8BDe1H1hH5n0A0pKP1Ehfi0D2Y0hibiOR2k+YXx8Ek8oTQ0knmWbZw
         3P0Q==
X-Gm-Message-State: AOAM533gXxlPLpqz8jfQ69VMMeSQm5bjoOYkzXnxiCxywcUxAvXKYZsg
        2QfFbLfK5mW5gkqgScz460A=
X-Google-Smtp-Source: ABdhPJw437VvGfQ3x2+Cd4AjT+O/pCBDfkNNa4zBzDYR/GEYH9iALH4t4kUQoRb70KT+gDAzNojXjA==
X-Received: by 2002:a05:6402:458:: with SMTP id p24mr16269104edw.142.1624990854422;
        Tue, 29 Jun 2021 11:20:54 -0700 (PDT)
Received: from localhost.localdomain (dynamic-2a01-0c23-c0d8-f500-f22f-74ff-fe21-0725.c23.pool.telefonica.de. [2a01:c23:c0d8:f500:f22f:74ff:fe21:725])
        by smtp.googlemail.com with ESMTPSA id v5sm11565678edt.55.2021.06.29.11.20.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 29 Jun 2021 11:20:53 -0700 (PDT)
From:   Martin Blumenstingl <martin.blumenstingl@googlemail.com>
To:     robh+dt@kernel.org, linux-phy@lists.infradead.org,
        devicetree@vger.kernel.org, linux-amlogic@lists.infradead.org
Cc:     kishon@ti.com, vkoul@kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Martin Blumenstingl <martin.blumenstingl@googlemail.com>
Subject: [PATCH v2 1/2] dt-bindings: phy: Add the Amlogic Meson8 HDMI TX PHY bindings
Date:   Tue, 29 Jun 2021 20:20:46 +0200
Message-Id: <20210629182047.893415-2-martin.blumenstingl@googlemail.com>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <20210629182047.893415-1-martin.blumenstingl@googlemail.com>
References: <20210629182047.893415-1-martin.blumenstingl@googlemail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Amlogic Meson8, Meson8b and Meson8m2 all include an identical (or at
least very similar) HDMI TX PHY. The PHY registers are part of the HHI
register area.

Signed-off-by: Martin Blumenstingl <martin.blumenstingl@googlemail.com>
---
 .../phy/amlogic,meson8-hdmi-tx-phy.yaml       | 55 +++++++++++++++++++
 1 file changed, 55 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/phy/amlogic,meson8-hdmi-tx-phy.yaml

diff --git a/Documentation/devicetree/bindings/phy/amlogic,meson8-hdmi-tx-phy.yaml b/Documentation/devicetree/bindings/phy/amlogic,meson8-hdmi-tx-phy.yaml
new file mode 100644
index 000000000000..7faf35c260f3
--- /dev/null
+++ b/Documentation/devicetree/bindings/phy/amlogic,meson8-hdmi-tx-phy.yaml
@@ -0,0 +1,55 @@
+# SPDX-License-Identifier: (GPL-2.0 OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: "http://devicetree.org/schemas/phy/amlogic,meson8-hdmi-tx-phy.yaml#"
+$schema: "http://devicetree.org/meta-schemas/core.yaml#"
+
+title: Amlogic Meson8, Meson8b and Meson8m2 HDMI TX PHY
+
+maintainers:
+  - Martin Blumenstingl <martin.blumenstingl@googlemail.com>
+
+description: |+
+  The HDMI TX PHY node should be the child of a syscon node with the
+  required property:
+
+  compatible = "amlogic,meson-hhi-sysctrl", "simple-mfd", "syscon"
+
+  Refer to the bindings described in
+  Documentation/devicetree/bindings/mfd/syscon.yaml
+
+properties:
+  $nodename:
+    pattern: "^hdmi-phy@[0-9a-f]+$"
+
+  compatible:
+    enum:
+      - amlogic,meson8-hdmi-tx-phy
+      - amlogic,meson8b-hdmi-tx-phy
+      - amlogic,meson8m2-hdmi-tx-phy
+
+  reg:
+    maxItems: 1
+
+  clocks:
+    minItems: 1
+    description:
+      HDMI TMDS clock
+
+  "#phy-cells":
+    const: 0
+
+required:
+  - compatible
+  - "#phy-cells"
+
+additionalProperties: false
+
+examples:
+  - |
+    hdmi_tx_phy: hdmi-phy@3a0 {
+      compatible = "amlogic,meson8-hdmi-tx-phy";
+      reg = <0x3a0 0xc>;
+      clocks = <&tmds_clock>;
+      #phy-cells = <0>;
+    };
-- 
2.32.0

