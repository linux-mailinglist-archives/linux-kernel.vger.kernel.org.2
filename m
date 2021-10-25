Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 26166439278
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Oct 2021 11:35:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232592AbhJYJh2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 25 Oct 2021 05:37:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56806 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232582AbhJYJhZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Oct 2021 05:37:25 -0400
Received: from mail-pj1-x1036.google.com (mail-pj1-x1036.google.com [IPv6:2607:f8b0:4864:20::1036])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CE13CC061767;
        Mon, 25 Oct 2021 02:35:03 -0700 (PDT)
Received: by mail-pj1-x1036.google.com with SMTP id t5-20020a17090a4e4500b001a0a284fcc2so10953840pjl.2;
        Mon, 25 Oct 2021 02:35:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=pL2wYs0FKur1p37EfD6cIh4PXL/x/Qnvjj6a9pn8Rhw=;
        b=GZTlyD5SFsCx5JmILsskLqqU39Sr2F/Kyho2MyNKkmwpM/JLYu/j4HpmWzmG+s5gNO
         v9/u1XlodTjLEcFPSZLK/SsPsY4t6orDOelk0Pq5N9PAc2KVxIIzqKU0I2VVSm16yK+C
         qypcQrNZKhmM1YHgSIZD0wY/wWCjTDtWQK0sjIGtjRkVoyVPofX+i0g2MWe4OaMJoUzi
         jtLHVdRfV1eXNj3AiE3SVWF8m7iwaO2tlp1haXEz8w6gOjqUQMITOSY0/MkQovY2DWyz
         Q0ixEzTj3kc2LglqZ9rKAuGRxjD56NKY4SbgnhHQsbudfAqRIMpxa0dK10RSyHt8ChCu
         3uYw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=pL2wYs0FKur1p37EfD6cIh4PXL/x/Qnvjj6a9pn8Rhw=;
        b=eFSxMmMwqwrgymvt+JZZGh3EIhnvGN/d7BQECGeMmJ1T7UTC6iFyxUPXrPDO+W+afo
         JnrS3fI39Iz8PCE7gj3oa2BTWrtDdShQ4tYV+m74mMLtHogMjHUg0TGxrUeyTocClHXy
         ZsM/CWfzbIpAQD0ycL9KHpJbXY7lGMktjFp0m7Ifpwb5x7mXOA5SJZJeUY6erRlyi3Nt
         w6nLB5BTEofD03wqjJUiEF10sbf+InWWolRiKrJgKCqe4ao4Bb2D4dyzLFUocYvMxFcd
         zE2uWkg1FymDcS6B5WPCB6w4dVvanIJiL9IzVQ4SFD3lMdUzRw6/7Hsk3Npm7NF9ZMbm
         VbMQ==
X-Gm-Message-State: AOAM532EztyDzvG0Hojz8NUUc7wDmqghT2IjNAG1FEQW7ikkCv3NAX65
        mtjNKERc5/t7bd2hWhDB21I=
X-Google-Smtp-Source: ABdhPJxf1o32siCRI1IYyrqxQHuurps25UZou4vNu9Y9eBfLGQ2ZCOLTxn1cH5dKBeRH91Zxd0Sm4w==
X-Received: by 2002:a17:902:d4d0:b0:140:1bd6:a84f with SMTP id o16-20020a170902d4d000b001401bd6a84fmr15477792plg.20.1635154503358;
        Mon, 25 Oct 2021 02:35:03 -0700 (PDT)
Received: from nj08008nbu.spreadtrum.com ([240e:47a:878:6a2:e0f0:8dca:6977:afd5])
        by smtp.gmail.com with ESMTPSA id c9sm15446100pgq.58.2021.10.25.02.34.52
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 25 Oct 2021 02:35:02 -0700 (PDT)
From:   Kevin Tang <kevin3.tang@gmail.com>
To:     maarten.lankhorst@linux.intel.com, mripard@kernel.org,
        sean@poorly.run, airlied@linux.ie, daniel@ffwll.ch,
        robh+dt@kernel.org, mark.rutland@arm.com, kevin3.tang@gmail.com,
        pony1.wu@gmail.com
Cc:     orsonzhai@gmail.com, zhang.lyra@gmail.com,
        linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org,
        devicetree@vger.kernel.org
Subject: [PATCH v7 1/6] dt-bindings: display: add Unisoc's drm master bindings
Date:   Mon, 25 Oct 2021 17:34:13 +0800
Message-Id: <20211025093418.20545-2-kevin3.tang@gmail.com>
X-Mailer: git-send-email 2.29.0
In-Reply-To: <20211025093418.20545-1-kevin3.tang@gmail.com>
References: <20211025093418.20545-1-kevin3.tang@gmail.com>
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

