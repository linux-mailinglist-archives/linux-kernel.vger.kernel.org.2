Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7597A35607A
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Apr 2021 02:53:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245508AbhDGAyA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 6 Apr 2021 20:54:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38738 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233710AbhDGAx7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Apr 2021 20:53:59 -0400
Received: from mail-qv1-xf33.google.com (mail-qv1-xf33.google.com [IPv6:2607:f8b0:4864:20::f33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 653DBC06174A;
        Tue,  6 Apr 2021 17:53:50 -0700 (PDT)
Received: by mail-qv1-xf33.google.com with SMTP id j1so4807681qvp.6;
        Tue, 06 Apr 2021 17:53:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=ptyh8gw1w6IyWNTHb0zoce3G579rmfx+lHr+X9LynKU=;
        b=dxeLbpQY8xWtuTVjUHbi9KZZ2EjeEMvn4N9JABpTB6ITX20+F58k0+V1sSBnxxm2e9
         nzV/H6/BsZ3VSzFuojmSqBiy4s13fcNPQN3NCCDmhYpFkHISGCGwHyAqhgMOW4He/qop
         FkfUqF57n/e75lsxeA82pZKC6mGM3zU86GJhJ1BID6K9KiGv7pKbHSu16dRJBHWKMLoy
         kMpaF2C40Eq9u3t9ToWPttJKM+a8Tc0Y++5A+nsZmLJEClzTK1g6KgE9GSQbzYb3ODhA
         w4M21mwRB0xvE2hOFEMw4J/nJHnihaP5cm8hp2xfFe6Eq/FsAIXK9G2X00RPVhuDosK4
         CelA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=ptyh8gw1w6IyWNTHb0zoce3G579rmfx+lHr+X9LynKU=;
        b=PE8gZ8Li7CZX0J80Gjdi6AGzADeEVwt7MmtSuaJzWf9zhEfMQRoA/QxirNrM9hIgNV
         Ki5o1azqWYx/OnCiXZSpGd+eGiMmlQQgwyMbVXcmm3JP5ROfjXZVdTt3/54S4HVnVCgu
         ojDcMZ6/AJ4tmDsHPF9VvydR6OBvUdiywbNALMU1KpGONpCDeqAbqjD4nIlXVgZz8IDB
         Z+y5mecjECUfihKCPKit0AK1xgH9mBP2bg34AHZstv45T5D3UsbLstVKPtvE9Icb/1HD
         gw5oWIqHNyVDpjvbZZO5gQndBpwpNQlwg9gpl4z/lGwzyrVmnYh/UijDJxhUj4Nuqa2R
         Eerw==
X-Gm-Message-State: AOAM530UrI23nSLP+1gSAAxCqSvB4uG2YoOvPumU0TWuBzODFyyKukPy
        kxd/aMVXpp6zsWlSN/wjE1GX1Rv0HiLvd6LX
X-Google-Smtp-Source: ABdhPJwUwUXhxpD8fvgfn6wtoT4cX6GsKssjRqgTbDzrekmOn4/GLVvfB4kxHg5U432Be8ed6s4ywA==
X-Received: by 2002:a0c:f604:: with SMTP id r4mr951247qvm.3.1617756828588;
        Tue, 06 Apr 2021 17:53:48 -0700 (PDT)
Received: from shaak.xiphos.ca (198-48-202-89.cpe.pppoe.ca. [198.48.202.89])
        by smtp.gmail.com with ESMTPSA id l9sm15776728qtv.65.2021.04.06.17.53.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 06 Apr 2021 17:53:48 -0700 (PDT)
From:   Liam Beguin <liambeguin@gmail.com>
To:     liambeguin@gmail.com, mturquette@baylibre.com, sboyd@kernel.org
Cc:     linux-clk@vger.kernel.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org, robh+dt@kernel.org
Subject: [PATCH v4 0/3] add support for the lmk04832
Date:   Tue,  6 Apr 2021 20:53:27 -0400
Message-Id: <20210407005330.2890430-1-liambeguin@gmail.com>
X-Mailer: git-send-email 2.30.1.489.g328c10930387
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Liam Beguin <lvb@xiphos.com>

Hi,

The LMK04832 is an ultra-high performance clock conditioner with JEDEC
JESD204B support and is also pin compatible with the LMK0482x family of
devices.

This driver adds initial support to configure the LMK04832 clocks using
the clock framework.

This has been tested on a system using JESD204B subclass 1.

At the moment, the VCO rate has to be set manually from the devicetree
and a dclk (or sclk) rate change isn't propagated to the VCO
automatically.

Changes since v1:
- add yaml devicetree documentation,
- add links to datasheet,
- use {u8,u16,u32} instead of Uint_ variants,
- drop redundant debugfs code,
- use a pointer to device_info instead of struct copy,
- add of_device_id table,
- add support for SYSREF digital delay and JESD204B subclass 1

Changes since v2:
- fix dt-bindings documentation, apologies for the broken build
- fix property vendor prefixes
- split dt-bindings into a separate patch

Changes since v3:
- add missing properties in dt-bindings

Thanks for your time,
Liam

Liam Beguin (3):
  clk: add support for the lmk04832
  clk: lmk04832: add support for digital delay
  dt-bindings: clock: add ti,lmk04832 bindings

 .../bindings/clock/ti,lmk04832.yaml           |  209 +++
 drivers/clk/Kconfig                           |    7 +
 drivers/clk/Makefile                          |    1 +
 drivers/clk/clk-lmk04832.c                    | 1595 +++++++++++++++++
 4 files changed, 1812 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/clock/ti,lmk04832.yaml
 create mode 100644 drivers/clk/clk-lmk04832.c

Interdiff against v3:
diff --git a/Documentation/devicetree/bindings/clock/ti,lmk04832.yaml b/Documentation/devicetree/bindings/clock/ti,lmk04832.yaml
index c0d9ab650e80..a9f8b9b720fc 100644
--- a/Documentation/devicetree/bindings/clock/ti,lmk04832.yaml
+++ b/Documentation/devicetree/bindings/clock/ti,lmk04832.yaml
@@ -23,9 +23,20 @@ properties:
   reg:
     maxItems: 1
 
+  '#address-cells':
+    const: 1
+
+  '#size-cells':
+    const: 0
+
   '#clock-cells':
     const: 1
 
+  spi-max-frequency:
+    $ref: /schemas/types.yaml#/definitions/uint32
+    description:
+      Maximum SPI clocking speed of the device in Hz.
+
   clocks:
     items:
       - description: PLL2 reference clock.

base-commit: f40ddce88593482919761f74910f42f4b84c004b
-- 
2.30.1.489.g328c10930387

