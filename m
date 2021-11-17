Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DBC75454135
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Nov 2021 07:48:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233859AbhKQGvO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 17 Nov 2021 01:51:14 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35558 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229474AbhKQGvL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 Nov 2021 01:51:11 -0500
Received: from mail-pj1-x102c.google.com (mail-pj1-x102c.google.com [IPv6:2607:f8b0:4864:20::102c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 534FBC061746;
        Tue, 16 Nov 2021 22:48:13 -0800 (PST)
Received: by mail-pj1-x102c.google.com with SMTP id j6-20020a17090a588600b001a78a5ce46aso4463851pji.0;
        Tue, 16 Nov 2021 22:48:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=0pe+xmC7R36QeEuu6CjLJU5Z7BQjQmQSca7WJDrJ6SI=;
        b=ZuZDB2/beUbFfkwQg39APAxbJkP/fKNDLz4Pnx+0JyjBFotPVh6ff6GwDX5o6CjH02
         bEoHjlq2JH1CG969jGKH9iXgWy8jZkMTK1ToOEv1s3zpwJY3g8pWj9DmA+o9GkNq5Jl+
         83dkfxdYcbvJRwwAjF0HE5veAh+plnJd22DOOiJzOYl59Kuru/ZHz6cmFpzmK+398En6
         Thx7hRi3Y0JS/s5PWGdnvwrdJao2TiXA+FwwWFQOqjhOeow1Nqe7LhlX1DLaizT9UWTy
         wPTnMF7LHTHxvOV5/iTzOVD2wg/C3XMzo8h8FPbKBxchC17D1lF7DT3KTejiGZT4KHP2
         oWCQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=0pe+xmC7R36QeEuu6CjLJU5Z7BQjQmQSca7WJDrJ6SI=;
        b=qS8EEwp7Aj8tDAh37bQlO79y5ZPGAL0eFeqmrJTOSDt0xnxXy0Ej13n2EbV0fmc/TF
         HUaFgroXIYYgLTMnqGrTkTw01SgDAkxne8Hz7mDYAD3WDr9kJJ+nXNsRhrapKEd5S5Nb
         snAA0YxN4Y0jHH0PMjR6VMTPwvokm9BqzSG+g7mePxZljHsntkgRf7SNTbo+WQsUbmkl
         +TpKcm0S1O8REBEHMuAeW72KGqDqpu9/n7zCWxZ6Pr60Y7op5xD1ydwR4DlD/3Z0iwdZ
         TBgeptrDx0BAMWFIyIV4AWdFqKESCIjc9fln9sUQDv+ihMUbbng2Yu3uY5pjcP+OBIK6
         n6Mg==
X-Gm-Message-State: AOAM533q81T96zT+92HGbsPykEC848U9f9tQhzIIgEtLepyvgx7kTZoP
        1y0Y1TW2mohHrEYmGcNeRxQ=
X-Google-Smtp-Source: ABdhPJxXkjVMwfQdMLxtygyb4nMO6WMfBwHLnUwWBPSusMw66SA5lucp5V98FNIiDYNosz74xiI0SQ==
X-Received: by 2002:a17:90a:800a:: with SMTP id b10mr6838023pjn.162.1637131692957;
        Tue, 16 Nov 2021 22:48:12 -0800 (PST)
Received: from scdiu3.sunplus.com ([113.196.136.192])
        by smtp.googlemail.com with ESMTPSA id g1sm20400240pfm.25.2021.11.16.22.48.10
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 16 Nov 2021 22:48:12 -0800 (PST)
From:   Tony Huang <tonyhuang.sunplus@gmail.com>
X-Google-Original-From: Tony Huang <tony.huang@sunplus.com>
To:     robh+dt@kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, derek.kiernan@xilinx.com,
        dragan.cvetic@xilinx.com, arnd@arndb.de, gregkh@linuxfoundation.org
Cc:     wells.lu@sunplus.com, Tony Huang <tony.huang@sunplus.com>
Subject: [PATCH 1/2] dt-binding: misc: Add iop yaml file for Sunplus SP7021
Date:   Wed, 17 Nov 2021 14:48:06 +0800
Message-Id: <1637131687-23000-2-git-send-email-tony.huang@sunplus.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1637131687-23000-1-git-send-email-tony.huang@sunplus.com>
References: <1637131687-23000-1-git-send-email-tony.huang@sunplus.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add iop yaml file for Sunplus SP7021

Signed-off-by: Tony Huang <tony.huang@sunplus.com>
---
 .../devicetree/bindings/misc/sunplus-iop.yaml      | 59 ++++++++++++++++++++++
 MAINTAINERS                                        |  5 ++
 2 files changed, 64 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/misc/sunplus-iop.yaml

diff --git a/Documentation/devicetree/bindings/misc/sunplus-iop.yaml b/Documentation/devicetree/bindings/misc/sunplus-iop.yaml
new file mode 100644
index 0000000..0bd6efe
--- /dev/null
+++ b/Documentation/devicetree/bindings/misc/sunplus-iop.yaml
@@ -0,0 +1,59 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+# Copyright (C) Sunplus Ltd. Co. 2021
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/misc/sunplus-iop.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Sunplus IOP(8051) controller
+
+maintainers:
+  - Tony Huang <tony.huang@sunplus.com>
+
+description: |
+  Processor for I/O control, RTC wake-up procedure management,
+  and cooperation with CPU&PMC in power management.
+
+properties:
+  compatible:
+    enum:
+      - sunplus,sp7021-iop
+
+  reg:
+    items:
+      - description: IOP registers regions
+      - description: PMC registers regions
+
+  reg-names:
+    items:
+      - const: iop
+      - const: iop_pmc
+
+  interrupts:
+    maxItems: 2
+
+  memory-region:
+    maxItems: 1
+
+required:
+  - compatible
+  - reg
+  - reg-names
+  - interrupts
+  - memory-region
+
+additionalProperties: false
+
+examples:
+  - |
+    #include <dt-bindings/interrupt-controller/irq.h>
+    #include <dt-bindings/interrupt-controller/arm-gic.h>
+    iop: iop@9c000400 {
+        compatible = "sunplus,sp7021-iop";
+        reg = <0x9c000400 0x80>, <0x9c003100 0x80>;
+        reg-names = "iop", "iop_pmc";
+        interrupt-parent = <&intc>;
+        interrupts = <41 IRQ_TYPE_LEVEL_HIGH>, <42 IRQ_TYPE_LEVEL_HIGH>;
+        memory-region = <&iop_reserve>;
+    };
+...
diff --git a/MAINTAINERS b/MAINTAINERS
index 3b79fd4..ef7dcbc 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -17945,6 +17945,11 @@ L:	netdev@vger.kernel.org
 S:	Maintained
 F:	drivers/net/ethernet/dlink/sundance.c
 
+SUNPLUS IOP DRIVER
+M:	Tony Huang <tony.huang@sunplus.com>
+S:	Maintained
+F:	Documentation/devicetree/bindings/misc/sunplu-iop.yaml
+
 SUPERH
 M:	Yoshinori Sato <ysato@users.sourceforge.jp>
 M:	Rich Felker <dalias@libc.org>
-- 
2.7.4

