Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 471373576B2
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Apr 2021 23:22:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232677AbhDGVWT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 7 Apr 2021 17:22:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54250 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232568AbhDGVVr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Apr 2021 17:21:47 -0400
Received: from mail-wm1-x329.google.com (mail-wm1-x329.google.com [IPv6:2a00:1450:4864:20::329])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C3B67C0613D7;
        Wed,  7 Apr 2021 14:21:31 -0700 (PDT)
Received: by mail-wm1-x329.google.com with SMTP id 12so151605wmf.5;
        Wed, 07 Apr 2021 14:21:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=C+Sv7ebyhZdmYr8zuNmK8przgQqiTzBeblvn6JjaT24=;
        b=XKD8B7qsQuuWd1cNL5YOrIfkh/B80SxKacpgd/mGcX8L7wxF5vEB6F3IZKHOJZ+tSi
         VgxkXjROxu8DOyLlyfrsjSXCk8XuS12BOqOJRtaP0M1S4kwlJYskhOH2zkAwoyy8xtx7
         cQEcpzBok0YoUup3YateFoVWofliJr13HcV7TPH1fS/sEredskpOhrqGzCMqssc5t6JW
         aGSizURYMPrnBzP/30BAT/UpdJvsT8wHsAMkHHiw4y1tP2knBZd1/0pbzz02wEqlsp6o
         oIeajgMDgofsI/9yD2UrnbS/F4HGUGAANXYqCbQ55+zVtFk/I4zPQzSmlcZf0+C+YJuu
         XEAQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=C+Sv7ebyhZdmYr8zuNmK8przgQqiTzBeblvn6JjaT24=;
        b=I0ndKaHXPEVHYaFRrjlr8h1U8kL6fsnq3gFc2HK7G1oq0EX0RkxVrqIv4K4OAGqJDT
         WuY/GIzdP5gsJsJoIfWTH62i0dzK62K2/hd2qClxe1gnbyB8YvYBDiVz9mciqz6lZjSf
         9RE+5SNf+9qkDj03h867hZ9TYefJiBroF7L3AEUkS+5T2ojz0ldNfZWvfeQjS9VX+DRv
         AKR/lhR9NHX4wcdKHkTOLwDkOdHizwhnIb3qzQ9fEVd6AbCWODEqA6fHGZC0br6HY06c
         fJvrfBjQ6g6Q4KO0RpbY+TcNU0T+qsFQeU6AP0XzumZaZhpMN4tgIqP0j0HTBlEt5U+2
         GxLg==
X-Gm-Message-State: AOAM533CH5bZZ2OrMLJgzLbp/8w2No5AHxZHIkmMirY5f674IKkp7mxO
        6gArTIiFc3BH7zaHBmsUIPM=
X-Google-Smtp-Source: ABdhPJzEcI7EbB2e2oDATbJrtla4jwk4IkNB5X15tDJWQzL9U1sVz37qdbX+D8tXFi4fuBGD9a6Ojw==
X-Received: by 2002:a1c:6a13:: with SMTP id f19mr2241444wmc.145.1617830490525;
        Wed, 07 Apr 2021 14:21:30 -0700 (PDT)
Received: from adgra-XPS-15-9570.home (2a01cb0008bd270041a0a0f4308eafc0.ipv6.abo.wanadoo.fr. [2a01:cb00:8bd:2700:41a0:a0f4:308e:afc0])
        by smtp.gmail.com with ESMTPSA id l14sm17173952wrm.77.2021.04.07.14.21.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 07 Apr 2021 14:21:30 -0700 (PDT)
From:   Adrien Grassein <adrien.grassein@gmail.com>
Cc:     robh+dt@kernel.org, shawnguo@kernel.org, s.hauer@pengutronix.de,
        kernel@pengutronix.de, festevam@gmail.com, linux-imx@nxp.com,
        l.stach@pengutronix.de, Anson.Huang@nxp.com, krzk@kernel.org,
        peng.fan@nxp.com, aisheng.dong@nxp.com, qiangqing.zhang@nxp.com,
        alice.guo@nxp.com, aford173@gmail.com, agx@sigxcpu.org,
        andrew.smirnov@gmail.com, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Adrien Grassein <adrien.grassein@gmail.com>
Subject: [PATCH v1 4/7] dt-bindings: power: fsl,imx-gpcv2: add definitions for i.MX8MM
Date:   Wed,  7 Apr 2021 23:21:19 +0200
Message-Id: <20210407212122.626137-5-adrien.grassein@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210407212122.626137-1-adrien.grassein@gmail.com>
References: <20210407212122.626137-1-adrien.grassein@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
To:     unlisted-recipients:; (no To-header on input)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Update documentation for i.MX8MM.

Signed-off-by: Adrien Grassein <adrien.grassein@gmail.com>
---
 .../bindings/power/fsl,imx-gpcv2.yaml         |  7 +++++--
 include/dt-bindings/power/imx8mm-power.h      | 21 +++++++++++++++++++
 2 files changed, 26 insertions(+), 2 deletions(-)
 create mode 100644 include/dt-bindings/power/imx8mm-power.h

diff --git a/Documentation/devicetree/bindings/power/fsl,imx-gpcv2.yaml b/Documentation/devicetree/bindings/power/fsl,imx-gpcv2.yaml
index a96e6dbf1858..04928a173698 100644
--- a/Documentation/devicetree/bindings/power/fsl,imx-gpcv2.yaml
+++ b/Documentation/devicetree/bindings/power/fsl,imx-gpcv2.yaml
@@ -26,6 +26,7 @@ properties:
     enum:
       - fsl,imx7d-gpc
       - fsl,imx8mq-gpc
+      - fsl,imx8mm-pgc
 
   reg:
     maxItems: 1
@@ -52,8 +53,10 @@ properties:
           reg:
             description: |
               Power domain index. Valid values are defined in
-              include/dt-bindings/power/imx7-power.h for fsl,imx7d-gpc and
-              include/dt-bindings/power/imx8m-power.h for fsl,imx8mq-gpc
+              include/dt-bindings/power/imx7-power.h for fsl,imx7d-gpc,
+              include/dt-bindings/power/imx8m-power.h for fsl,imx8mq-gpc and
+              include/dt-bindings/power/imx8mm-power.h for fsl,imx8mm-gpc
+
             maxItems: 1
 
           clocks:
diff --git a/include/dt-bindings/power/imx8mm-power.h b/include/dt-bindings/power/imx8mm-power.h
new file mode 100644
index 000000000000..bec25fd32394
--- /dev/null
+++ b/include/dt-bindings/power/imx8mm-power.h
@@ -0,0 +1,21 @@
+/* SPDX-License-Identifier: (GPL-2.0 OR MIT) */
+/*
+ *  Copyright (C) 2021 Adrien Grassein <adrien.grassein@gmail.com>
+ */
+
+#ifndef __DT_BINDINGS_IMX8MM_POWER_H__
+#define __DT_BINDINGS_IMX8MM_POWER_H__
+
+#define IMX8MM_POWER_DOMAIN_HSIOMIX	0
+#define IMX8MM_POWER_DOMAIN_PCIE1	1
+#define IMX8MM_POWER_DOMAIN_USB_OTG1	2
+#define IMX8MM_POWER_DOMAIN_USB_OTG2	3
+#define IMX8MM_POWER_DOMAIN_GPU		4
+#define IMX8MM_POWER_DOMAIN_VPU		5
+#define IMX8MM_POWER_DOMAIN_VPU_G1	6
+#define IMX8MM_POWER_DOMAIN_VPU_G2	7
+#define IMX8MM_POWER_DOMAIN_VPU_H1	8
+#define IMX8MM_POWER_DOMAIN_DISPLAY	9
+#define IMX8MM_POWER_DOMAIN_MIPI	10
+
+#endif
-- 
2.25.1

