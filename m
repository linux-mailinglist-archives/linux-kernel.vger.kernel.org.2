Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B33593184CD
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Feb 2021 06:27:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229639AbhBKFYV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 11 Feb 2021 00:24:21 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36454 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229690AbhBKFX4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 11 Feb 2021 00:23:56 -0500
Received: from mail-pj1-x102a.google.com (mail-pj1-x102a.google.com [IPv6:2607:f8b0:4864:20::102a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D8DD9C06178B
        for <linux-kernel@vger.kernel.org>; Wed, 10 Feb 2021 21:22:36 -0800 (PST)
Received: by mail-pj1-x102a.google.com with SMTP id z9so2772766pjl.5
        for <linux-kernel@vger.kernel.org>; Wed, 10 Feb 2021 21:22:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=0x0f.com; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=AogpeLuC6h2kbFRYh8jcxM2VMpLXaY9SBeWFYBbrCSA=;
        b=qemjCONMGzAQ0NwTu3cqoW70NuUDn+rAE++LbZMHgRYAkzC3ZjriXPCHEL1nsC+e8k
         XlkeRggIgE9Y1wJcFeFWB0SXButixlGaBGIRn/qgK3XKgWtEUgaJBtOfSKHKOkRpnAy9
         HJJrybQubhkyq8srL5lq26fpkNB4K8I88ydcA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=AogpeLuC6h2kbFRYh8jcxM2VMpLXaY9SBeWFYBbrCSA=;
        b=oj3bPolCoKig0VqcCTwI1m0I6fzbcBuTv/7Vk/r62vN0cbJ99oN4ISfP2Gxiq9z6WX
         M9Eo2H1zmvWynPoC397ieP8+nQ/LWFfd28WVvNMt6OjcOs2zlSIdchzzT47FfLCfWTTO
         pWXVui0XdTIQ48G1TDhGWwyzZTi5iFuP2iVjcUxREnIht3d2wKxQZeWamA+qzw8B6OhM
         AoMz/vQiMzaBmD75SJSl6jTRdXw6gh1IPOxvKlHE6Cfy+7WO+sSalUYz+pFlhIS+hLKR
         MLn7s2K23jAUZXgYeb0v5o+PCQbcZAwBoHARWR4JmpQGCCk8r6XrGc1PxtsAqn7aFp2r
         gjDw==
X-Gm-Message-State: AOAM533razerpUsoEVrMFosvaxYYR0inI2M3fzyb5fERfyIZt393lFJg
        i8CeMj35ERwfKk51jeRuXMtvog==
X-Google-Smtp-Source: ABdhPJy2wFjME1q+iuw0xrlRvsS0mzOVToh4DLZZpe6O9KBDNwverFfIK2xGmM4pNCocfDDhCQ9WNQ==
X-Received: by 2002:a17:90a:bf0c:: with SMTP id c12mr2446478pjs.36.1613020956478;
        Wed, 10 Feb 2021 21:22:36 -0800 (PST)
Received: from shiro.work (p345188-ipngn200408sizuokaden.shizuoka.ocn.ne.jp. [124.98.97.188])
        by smtp.googlemail.com with ESMTPSA id o21sm3493511pjp.42.2021.02.10.21.22.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 10 Feb 2021 21:22:36 -0800 (PST)
From:   Daniel Palmer <daniel@0x0f.com>
To:     linux-clk@vger.kernel.org, sboyd@kernel.org,
        devicetree@vger.kernel.org
Cc:     w@1wt.eu, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        Daniel Palmer <daniel@0x0f.com>
Subject: [PATCH v2 2/7] dt-bindings: clk: mstar msc313 mpll binding description
Date:   Thu, 11 Feb 2021 14:22:01 +0900
Message-Id: <20210211052206.2955988-3-daniel@0x0f.com>
X-Mailer: git-send-email 2.30.0.rc2
In-Reply-To: <20210211052206.2955988-1-daniel@0x0f.com>
References: <20210211052206.2955988-1-daniel@0x0f.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add a binding description for the MStar/SigmaStar MPLL clock block.

Signed-off-by: Daniel Palmer <daniel@0x0f.com>
---
 .../bindings/clock/mstar,msc313-mpll.yaml     | 46 +++++++++++++++++++
 MAINTAINERS                                   |  1 +
 2 files changed, 47 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/clock/mstar,msc313-mpll.yaml

diff --git a/Documentation/devicetree/bindings/clock/mstar,msc313-mpll.yaml b/Documentation/devicetree/bindings/clock/mstar,msc313-mpll.yaml
new file mode 100644
index 000000000000..0df5d75d4ebc
--- /dev/null
+++ b/Documentation/devicetree/bindings/clock/mstar,msc313-mpll.yaml
@@ -0,0 +1,46 @@
+# SPDX-License-Identifier: (GPL-2.0 OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/clock/mstar,msc313-mpll.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: MStar/Sigmastar MSC313 MPLL
+
+maintainers:
+  - Daniel Palmer <daniel@thingy.jp>
+
+description: |
+  The MStar/SigmaStar MSC313 and later ARMv7 chips have an MPLL block that
+  takes the external xtal input and multiplies it to create a high
+  frequency clock and divides that down into a number of clocks that
+  peripherals use.
+
+properties:
+  compatible:
+    const: mstar,msc313-mpll
+
+  "#clock-cells":
+    const: 1
+
+  clocks:
+    maxItems: 1
+
+  reg:
+    maxItems: 1
+
+required:
+  - compatible
+  - "#clock-cells"
+  - clocks
+  - reg
+
+additionalProperties: false
+
+examples:
+  - |
+    mpll@206000 {
+        compatible = "mstar,msc313-mpll";
+        reg = <0x206000 0x200>;
+        #clock-cells = <1>;
+        clocks = <&xtal>;
+    };
diff --git a/MAINTAINERS b/MAINTAINERS
index 0622ff96ca2a..d004436c8860 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -2145,6 +2145,7 @@ L:	linux-arm-kernel@lists.infradead.org (moderated for non-subscribers)
 S:	Maintained
 W:	http://linux-chenxing.org/
 F:	Documentation/devicetree/bindings/arm/mstar/*
+F:	Documentation/devicetree/bindings/clock/mstar,msc313-mpll.yaml
 F:	Documentation/devicetree/bindings/gpio/mstar,msc313-gpio.yaml
 F:	arch/arm/boot/dts/mstar-*
 F:	arch/arm/mach-mstar/
-- 
2.30.0.rc2

