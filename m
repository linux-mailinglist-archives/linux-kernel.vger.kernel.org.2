Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 37C9F3EB710
	for <lists+linux-kernel@lfdr.de>; Fri, 13 Aug 2021 16:53:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240910AbhHMOxm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 13 Aug 2021 10:53:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41900 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240850AbhHMOxl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 Aug 2021 10:53:41 -0400
Received: from mail-pj1-x1029.google.com (mail-pj1-x1029.google.com [IPv6:2607:f8b0:4864:20::1029])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4F829C0613A4;
        Fri, 13 Aug 2021 07:53:13 -0700 (PDT)
Received: by mail-pj1-x1029.google.com with SMTP id 28-20020a17090a031cb0290178dcd8a4d1so11283013pje.0;
        Fri, 13 Aug 2021 07:53:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=pL2wYs0FKur1p37EfD6cIh4PXL/x/Qnvjj6a9pn8Rhw=;
        b=h7cENKxZEnoofdhZJ03Qq8eNuRX0S3Me4Jps+pVeFVBcQ0XPvsOwdv6flA1v7aPDrA
         dSfY1AiCUCphwPswRuc2n8le3NNp/7hKWFbqo/FNvBNP3thY8Fx8YLw9ECfT37gWgiuk
         1vr3Yr6BsbZvn6n2ICtC80pgtRvERmcWDKB/xkQy4W0IkHBhvmV279oBu2N4VNaV62ip
         cHCSGNGTCBTK4XivsEyNUkq8np5NcN5MizbsjCfwyojaaGRWkNlhMOoKm6yuwwe6dmWE
         CYAovDMOBj0YdtTOtfO5tKHW1qdsxHwgXlIhqa03dV5fwx2QV1j3uo7XfNGD0EVm7SNB
         +48Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=pL2wYs0FKur1p37EfD6cIh4PXL/x/Qnvjj6a9pn8Rhw=;
        b=kxZve5l0MaGv1NUOjffMe8gnQQgUdhvzJeHDHXO3nJQSL7AoHi9xxxTslkzlx6tqRR
         ehg13MPc2Hga3bbkUV5XQunH+gWncmv3x+wpT5XHO436phWR1RL9bjePpVUPuuXr2Rf8
         mQkKmVghvqKinyM4ZNsTNawuXpIN8fhpRevZgQIpCceLXWlsLazLgzTnop9NXh557gcO
         /tfoedjrDmiqNtERDtqB7ESDgps5rAGyafyndH8dSxdSnyYvriavF3D2E6fEmwzuemQG
         YGdQXDRofzHYxhrk2DhbJs+8jI2LxgSZUIqKtN5ebdGI4VYc2iQoomUmEwyl+/b1WcS6
         ik8Q==
X-Gm-Message-State: AOAM531bgUY1wvJRRTFn3hoFl7BmXm9HbY33q9SiGA6dBVCNuPsjLJmv
        lcfMv4JufZqNXaK8REj11Gw=
X-Google-Smtp-Source: ABdhPJxaLK8LOm5wpEdxBUPzSmm8Vj9ZBJ+E8vXwPUTThKILurLluyq8CTdziFAJ2+iQv8rlPiwuKg==
X-Received: by 2002:a17:902:bd47:b029:12b:fbb7:1f9d with SMTP id b7-20020a170902bd47b029012bfbb71f9dmr2422488plx.22.1628866392911;
        Fri, 13 Aug 2021 07:53:12 -0700 (PDT)
Received: from nj08008nbu.spreadtrum.com ([117.18.48.102])
        by smtp.gmail.com with ESMTPSA id e12sm2524787pfc.214.2021.08.13.07.53.09
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 13 Aug 2021 07:53:12 -0700 (PDT)
From:   Kevin Tang <kevin3.tang@gmail.com>
To:     maarten.lankhorst@linux.intel.com, mripard@kernel.org,
        sean@poorly.run, airlied@linux.ie, daniel@ffwll.ch,
        robh+dt@kernel.org, mark.rutland@arm.com, kevin3.tang@gmail.com,
        pony1.wu@gmail.com
Cc:     orsonzhai@gmail.com, zhang.lyra@gmail.com,
        linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org,
        devicetree@vger.kernel.org
Subject: [PATCH v6 1/6] dt-bindings: display: add Unisoc's drm master bindings
Date:   Fri, 13 Aug 2021 22:52:57 +0800
Message-Id: <20210813145302.3933-2-kevin3.tang@gmail.com>
X-Mailer: git-send-email 2.29.0
In-Reply-To: <20210813145302.3933-1-kevin3.tang@gmail.com>
References: <20210813145302.3933-1-kevin3.tang@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Kevin Tang <kevin.tang@unisoc.com>

The Unisoc DRM master device is a virtual device needed to list all
DPU devices or other display interface nodes that comprise the
graphics subsystem

Unisoc's display pipeline have several components as below
description, multi display controllers and corresponding physical
interfaces.
For different display scenarios, dpu0 and dpu1 maybe binding to
different encoder.

E.g:
  dpu0 and dpu1 both binding to DSI for dual mipi-dsi display;
  dpu0 binding to DSI for primary display, and dpu1 binding to DP for
  external display;

Cc: Orson Zhai <orsonzhai@gmail.com>
Cc: Chunyan Zhang <zhang.lyra@gmail.com>
Signed-off-by: Kevin Tang <kevin.tang@unisoc.com>
Reviewed-by: Rob Herring <robh@kernel.org>
---
 .../display/sprd/sprd,display-subsystem.yaml  | 64 +++++++++++++++++++
 1 file changed, 64 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/display/sprd/sprd,display-subsystem.yaml

diff --git a/Documentation/devicetree/bindings/display/sprd/sprd,display-subsystem.yaml b/Documentation/devicetree/bindings/display/sprd/sprd,display-subsystem.yaml
new file mode 100644
index 000000000..3d107e943
--- /dev/null
+++ b/Documentation/devicetree/bindings/display/sprd/sprd,display-subsystem.yaml
@@ -0,0 +1,64 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/display/sprd/sprd,display-subsystem.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Unisoc DRM master device
+
+maintainers:
+  - Kevin Tang <kevin.tang@unisoc.com>
+
+description: |
+  The Unisoc DRM master device is a virtual device needed to list all
+  DPU devices or other display interface nodes that comprise the
+  graphics subsystem.
+
+  Unisoc's display pipeline have several components as below description,
+  multi display controllers and corresponding physical interfaces.
+  For different display scenarios, dpu0 and dpu1 maybe binding to different
+  encoder.
+
+  E.g:
+  dpu0 and dpu1 both binding to DSI for dual mipi-dsi display;
+  dpu0 binding to DSI for primary display, and dpu1 binding to DP for external display;
+
+          +-----------------------------------------+
+          |                                         |
+          |                            +---------+  |
+  +----+  |   +----+    +---------+    |DPHY/CPHY|  |   +------+
+  |    +----->+dpu0+--->+MIPI|DSI +--->+Combo    +----->+Panel0|
+  |AXI |  |   +----+    +---------+    +---------+  |   +------+
+  |    |  |                  ^                      |
+  |    |  |                  |                      |
+  |    |  |      +-----------+                      |
+  |    |  |      |                                  |
+  |APB |  |   +--+-+    +-----------+    +---+      |   +------+
+  |    +----->+dpu1+--->+DisplayPort+--->+PHY+--------->+Panel1|
+  |    |  |   +----+    +-----------+    +---+      |   +------+
+  +----+  |                                         |
+          +-----------------------------------------+
+
+properties:
+  compatible:
+    const: sprd,display-subsystem
+
+  ports:
+    $ref: /schemas/types.yaml#/definitions/phandle-array
+    description:
+      Should contain a list of phandles pointing to display interface port
+      of DPU devices.
+
+required:
+  - compatible
+  - ports
+
+additionalProperties: false
+
+examples:
+  - |
+    display-subsystem {
+        compatible = "sprd,display-subsystem";
+        ports = <&dpu_out>;
+    };
+
-- 
2.29.0

