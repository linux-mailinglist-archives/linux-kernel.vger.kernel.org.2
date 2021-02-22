Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8E7763219CF
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Feb 2021 15:10:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231669AbhBVOJb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 22 Feb 2021 09:09:31 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45888 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230356AbhBVN3P (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 Feb 2021 08:29:15 -0500
Received: from mail-pg1-x52c.google.com (mail-pg1-x52c.google.com [IPv6:2607:f8b0:4864:20::52c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 62306C06174A;
        Mon, 22 Feb 2021 05:28:33 -0800 (PST)
Received: by mail-pg1-x52c.google.com with SMTP id o38so10203567pgm.9;
        Mon, 22 Feb 2021 05:28:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=Jsm3+HZOmxhPoZR+ypYQW7uBv7hcvxeE5PgZ0juQepE=;
        b=EIrwdlXKGB50caoH7J0gDxitI3FEATlg6kTrQnV0GiQDrJN5Dx/nyT1w6S9wSaR6wa
         tuyfjnxfUsojW6LeMA2zgsDUQ3R/t4ToVeMnRhd8XHMGZzkfYp0AZfwVoZg/3gg8slJE
         oZpPneAW+x+81/ce488k3/1Xt9+GBnxXW6BOYcJiqaMXYACO9Rt4qSRbyse51OI3kDGQ
         0U31AkF158ZMn9ei0TrNMKsihXsC8KzU9yksRy/c1ksvAngSBMUWQnms/aEMDIGNn6FW
         O3zNZPKsYg7Ow58k8roZL9H7S+UNTBBQ+kkLOrrY/bzaT/LMGGShup7aMJr4+aKfMBBx
         p6tA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=Jsm3+HZOmxhPoZR+ypYQW7uBv7hcvxeE5PgZ0juQepE=;
        b=K6/hoJNbzB/38TPqHTIQQLM3qFWoRINug4NwXc0GoMhRcpwMMRbiFlf0br/ePvNVWs
         WOXMYOWOtJv0oXnLrgG39IzzRXTeWMiXw0p4u/g9t4vJ8wietZQEeH+tcvycG4IrHB+g
         a+WqAUnLMgZhh3Fke27knZJNfMAjg9I7mWfgm3kRmSWNZJiDBWu0d8IoZuCF0t7dUUUR
         5FUoo6qcMFFE8JEIuyNFCpuN9gD0dyVosP9d6gD8rSf3BZz1GFOXeOYH5f6QeBcz11mW
         L13aHxJY4y6AiQvcrRom5HhCa4xIIYOgv5ZpoHVa9Nb7RZUjoQERgb00FSoTmomAt2xn
         d88A==
X-Gm-Message-State: AOAM531VMS505DT+0UPKALqbhJGRyO6Ni6xBznn0Vp7pT0SJx8ROHwSM
        am3TEXO7ylA83VAGZPpF80w=
X-Google-Smtp-Source: ABdhPJyhDWSknydPlsa8Dzca37VBQag3krIIEmpumaCA/rNYfjJK+zqMP3jScWrBK2fRy5oi4B0VlQ==
X-Received: by 2002:a62:e10c:0:b029:1ed:b772:5981 with SMTP id q12-20020a62e10c0000b02901edb7725981mr2565370pfh.80.1614000513019;
        Mon, 22 Feb 2021 05:28:33 -0800 (PST)
Received: from nj08008nbu.spreadtrum.com ([117.18.48.82])
        by smtp.gmail.com with ESMTPSA id 141sm19585334pfa.65.2021.02.22.05.28.29
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 22 Feb 2021 05:28:32 -0800 (PST)
From:   Kevin Tang <kevin3.tang@gmail.com>
To:     maarten.lankhorst@linux.intel.com, mripard@kernel.org,
        sean@poorly.run, airlied@linux.ie, daniel@ffwll.ch,
        robh+dt@kernel.org, mark.rutland@arm.com, kevin3.tang@gmail.com
Cc:     orsonzhai@gmail.com, zhang.lyra@gmail.com,
        linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org,
        devicetree@vger.kernel.org
Subject: [PATCH v4 1/6] dt-bindings: display: add Unisoc's drm master bindings
Date:   Mon, 22 Feb 2021 21:28:17 +0800
Message-Id: <20210222132822.7830-2-kevin3.tang@gmail.com>
X-Mailer: git-send-email 2.29.0
In-Reply-To: <20210222132822.7830-1-kevin3.tang@gmail.com>
References: <20210222132822.7830-1-kevin3.tang@gmail.com>
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
description, multi display controllers and corresponding physical interfaces.
For different display scenarios, dpu0 and dpu1 maybe binding to
different encoder.

E.g:
  dpu0 and dpu1 both binding to DSI for dual mipi-dsi display;
  dpu0 binding to DSI for primary display, and dpu1 binding to DP for external display;

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

