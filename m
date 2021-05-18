Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2986538809B
	for <lists+linux-kernel@lfdr.de>; Tue, 18 May 2021 21:40:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1351897AbhERTlc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 18 May 2021 15:41:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41192 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1349150AbhERTla (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 May 2021 15:41:30 -0400
Received: from mail-wr1-x436.google.com (mail-wr1-x436.google.com [IPv6:2a00:1450:4864:20::436])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 49EFCC06175F
        for <linux-kernel@vger.kernel.org>; Tue, 18 May 2021 12:40:12 -0700 (PDT)
Received: by mail-wr1-x436.google.com with SMTP id j14so9765605wrq.5
        for <linux-kernel@vger.kernel.org>; Tue, 18 May 2021 12:40:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=w916I/0sjB8ZeTLALSSIwoUKwmWfEbuQ72Hpwd3NOu0=;
        b=imtv0CYo96W3t7tK4e2c0G+asBQh3MxUV4zhTePtdhickz6yO6CV/Uxe+0mDylMgKa
         OOYFukZKU+SLyEhPO2dNddst9TRtn4XyBfw5Uvip/dl4tP8yOMZQV4lMiwa/xVGksInt
         v90XyXqT6Pys9EfGXyaUGJMiUtRKeYPjmY1TMvSBllAsJkypu1reDAprpqraATtzspaZ
         vPutGVyjLKQSsXtkLqeHIlJMXri05RvfeRYYYgBCaDwD3eRCTORRRimvb+/PO6pC3hIk
         DOYLDfuZ3k+SSsFnV/EQXzaa0W2uphkDUjbwX0Ws0leGltYP9wLnVn5/SSF4v3ZeajkG
         nagg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=w916I/0sjB8ZeTLALSSIwoUKwmWfEbuQ72Hpwd3NOu0=;
        b=iZTrAL9mLoqVUDpsDRL7hhvNe9LCSALbJFGu3/vp1ZKS4K1iW8y98WFVHuOFDtR/yK
         p8u4fmNSbvVSdCFn7MhrXOy3ceRP8j5Rsoc2xFG6Kiqbl4HZU0Pue4IbVGV9xYHdrrtx
         TUK0K2h7Gi+QJY3KIY5VpEBZSiWo8LzNPt4KI3gkjMaXU2QCjnhfcz/i+dIlhsbW2mH8
         KuTXv460k6lrja9qSmLtm2AVv6HtUP61NOU8Q/n/T8fUB7EqaqOSPtP97esDx0T2bgyy
         jRsYs/41EZDCnoZnEW9nV2aGjNZTui7fvDEfGsbJn86dJ9QgXSO03s3F2XWq1KuzQ8ru
         WRRQ==
X-Gm-Message-State: AOAM532YOH7WYnOEmF3oi9DGBzW/5EI5NUY2/LkYfs324Q+HGTpYdPEx
        lZ67reVhkG7ZMn60MiW3IM/eOA==
X-Google-Smtp-Source: ABdhPJxqBvFdPKeDHOE6hCEivMK6rdREhcDBBFaoT/XGgJgqhulDWVhyvbfztJUlEUSOEXnTWAQJKA==
X-Received: by 2002:adf:f788:: with SMTP id q8mr9020066wrp.205.1621366810997;
        Tue, 18 May 2021 12:40:10 -0700 (PDT)
Received: from localhost.localdomain ([88.160.162.107])
        by smtp.gmail.com with ESMTPSA id q186sm5484407wme.20.2021.05.18.12.40.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 18 May 2021 12:40:10 -0700 (PDT)
From:   Fabien Parent <fparent@baylibre.com>
To:     Rob Herring <robh+dt@kernel.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Weiyi Lu <weiyi.lu@mediatek.com>
Cc:     mkorpershoek@baylibre.com, Fabien Parent <fparent@baylibre.com>,
        Matthias Brugger <mbrugger@suse.com>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org
Subject: [PATCH 1/2] dt-bindings: power: Add MT8365 power domains
Date:   Tue, 18 May 2021 21:40:07 +0200
Message-Id: <20210518194008.2921469-1-fparent@baylibre.com>
X-Mailer: git-send-email 2.31.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add power domains dt-bindings for MT8365.

Signed-off-by: Fabien Parent <fparent@baylibre.com>
---
 .../power/mediatek,power-controller.yaml      |  2 ++
 include/dt-bindings/power/mt8365-power.h      | 20 +++++++++++++++++++
 2 files changed, 22 insertions(+)
 create mode 100644 include/dt-bindings/power/mt8365-power.h

diff --git a/Documentation/devicetree/bindings/power/mediatek,power-controller.yaml b/Documentation/devicetree/bindings/power/mediatek,power-controller.yaml
index f234a756c193..9a26a2cee7fb 100644
--- a/Documentation/devicetree/bindings/power/mediatek,power-controller.yaml
+++ b/Documentation/devicetree/bindings/power/mediatek,power-controller.yaml
@@ -27,6 +27,7 @@ properties:
       - mediatek,mt8173-power-controller
       - mediatek,mt8183-power-controller
       - mediatek,mt8192-power-controller
+      - mediatek,mt8365-power-controller
 
   '#power-domain-cells':
     const: 1
@@ -64,6 +65,7 @@ patternProperties:
               "include/dt-bindings/power/mt8173-power.h" - for MT8173 type power domain.
               "include/dt-bindings/power/mt8183-power.h" - for MT8183 type power domain.
               "include/dt-bindings/power/mt8192-power.h" - for MT8192 type power domain.
+              "include/dt-bindings/power/mt8365-power.h" - for MT8365 type power domain.
         maxItems: 1
 
       clocks:
diff --git a/include/dt-bindings/power/mt8365-power.h b/include/dt-bindings/power/mt8365-power.h
new file mode 100644
index 000000000000..352440c4b5dd
--- /dev/null
+++ b/include/dt-bindings/power/mt8365-power.h
@@ -0,0 +1,20 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+/*
+ * Copyright (c) 2021 MediaTek Inc.
+ */
+
+#ifndef _DT_BINDINGS_POWER_MT8365_POWER_H
+#define _DT_BINDINGS_POWER_MT8365_POWER_H
+
+#define MT8365_POWER_DOMAIN_DISP	0
+#define MT8365_POWER_DOMAIN_CONN	1
+#define MT8365_POWER_DOMAIN_MFG		2
+#define MT8365_POWER_DOMAIN_AUDIO	3
+#define MT8365_POWER_DOMAIN_CAM		4
+#define MT8365_POWER_DOMAIN_DSP		5
+#define MT8365_POWER_DOMAIN_VDEC	6
+#define MT8365_POWER_DOMAIN_VENC	7
+#define MT8365_POWER_DOMAIN_APU		8
+
+#endif /* _DT_BINDINGS_POWER_MT8365_POWER_H */
+
-- 
2.31.1

