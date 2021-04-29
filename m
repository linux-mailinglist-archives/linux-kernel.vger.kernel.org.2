Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D7E7836F1C9
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Apr 2021 23:16:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237247AbhD2VRc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 29 Apr 2021 17:17:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46034 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233284AbhD2VRa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Apr 2021 17:17:30 -0400
Received: from mail-il1-x12f.google.com (mail-il1-x12f.google.com [IPv6:2607:f8b0:4864:20::12f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A5407C06138B;
        Thu, 29 Apr 2021 14:16:43 -0700 (PDT)
Received: by mail-il1-x12f.google.com with SMTP id c15so7608777ilj.1;
        Thu, 29 Apr 2021 14:16:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=2yoj5H+QCx6bc+UM4nyFoXNp2IJ9VP/R50NAmY/87kc=;
        b=NWVvCJOUY1TRFUi91NRJDzxsqZsP5JqiA4xLNNf0Cj0VTaU6+fzqazEw99O02ZZCH+
         Yq+PIS0TfzCVxY/0QdzsgD1moqX/0zVytssSbEM5iXa15IPNGNne8VvNA7hhcjMYSiv0
         JS4YSKqQ6+8lvil6ImnNAQ6wFh0Myq37xvXzIwafR94Wd1ATGXfQezv1pu3WhondW3tl
         XfdBe5ukIsx2/uzaM0Cyt7D3ikCUhNrMDXgopU+jEWPl79XuBHgtg4lVDkyt6Qr/VfBu
         AIn6Q6+yypGAi386pl5IXCIuCGiB/rCv752p4/o2cYiaf7/M7ZZvqkcOuJQ+vIVYa/OR
         M7uA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=2yoj5H+QCx6bc+UM4nyFoXNp2IJ9VP/R50NAmY/87kc=;
        b=gjK1ygQWra6rRD6lrOWV+mrCmUsmQ4McNvGdZsQdLAhGq7eZImWjeT0lDHXCWmusR1
         9UbO7/Bpng9tgh9Fbapon/FHYelg1pcsZAlSZ8tzpRA9OvhIe/29cls0lLM6DFa4QEs0
         2PgeO70N/Uwta3SLme2doj8vLZf0Wvnw45cn9lxkHchM0NzWiXGuHtBC0EkNZP2qHBwf
         cECoRmdkfZuwK/7+akoqvbF36hPxErN7bnHuy0ThspmXVXwq8qj+6FBRVXdS6mkDNiDL
         7tDpxdLahZ2BJ+1SbjIgo61GIwlCglrqfjCr0ipEgc8+KVhv41hovjzzFWmZxdBNG71D
         ZnJQ==
X-Gm-Message-State: AOAM531O4Em62hsdaVMi4t3/wK+P7nU2FFp87nnBophFEKJ/mh+QAMTP
        HXTW/uHywNZ5aM/mKyIjYXA=
X-Google-Smtp-Source: ABdhPJxffJBBOfq8QcNh7YQYQkt4hfOhbEItSfrLfjvnrmLhr64mYbChqPN3378MerLyXNvl6pGP4Q==
X-Received: by 2002:a92:cec3:: with SMTP id z3mr1368665ilq.179.1619731002946;
        Thu, 29 Apr 2021 14:16:42 -0700 (PDT)
Received: from aford-IdeaCentre-A730.lan ([2601:448:8400:9e8:8a74:d2ad:27b:e619])
        by smtp.gmail.com with ESMTPSA id q11sm1808076ile.56.2021.04.29.14.16.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 29 Apr 2021 14:16:42 -0700 (PDT)
From:   Adam Ford <aford173@gmail.com>
To:     linux-arm-kernel@lists.infradead.org
Cc:     peng.fan@oss.nxp.com, marex@denx.de, frieder.schrempf@kontron.de,
        tharvey@gateworks.com, aford@beaconembedded.com,
        Adam Ford <aford173@gmail.com>,
        Krzysztof Kozlowski <krzk@kernel.org>,
        Rob Herring <robh@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>,
        NXP Linux Team <linux-imx@nxp.com>,
        Andrey Smirnov <andrew.smirnov@gmail.com>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH V3 1/5] dt-bindings: add defines for i.MX8MN power domains
Date:   Thu, 29 Apr 2021 16:16:20 -0500
Message-Id: <20210429211625.1835702-2-aford173@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210429211625.1835702-1-aford173@gmail.com>
References: <20210429211625.1835702-1-aford173@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The i.MX8M Nano has a similar power domain controller to that of the
mini, but it isn't fully compatible, so it needs a separate binding
and power domain tables.

Add the bindings and tables.

Signed-off-by: Adam Ford <aford173@gmail.com>
Reviewed-by: Krzysztof Kozlowski <krzk@kernel.org>
Acked-by: Rob Herring <robh@kernel.org>
---
V3:  Rebase on series starting https://lkml.org/lkml/2021/4/29/72
V2:  No change

diff --git a/Documentation/devicetree/bindings/power/fsl,imx-gpcv2.yaml b/Documentation/devicetree/bindings/power/fsl,imx-gpcv2.yaml
index d3539569d45f..a87c44c15ace 100644
--- a/Documentation/devicetree/bindings/power/fsl,imx-gpcv2.yaml
+++ b/Documentation/devicetree/bindings/power/fsl,imx-gpcv2.yaml
@@ -25,6 +25,7 @@ properties:
   compatible:
     enum:
       - fsl,imx7d-gpc
+      - fsl,imx8mn-gpc
       - fsl,imx8mq-gpc
       - fsl,imx8mm-gpc
 
diff --git a/include/dt-bindings/power/imx8mn-power.h b/include/dt-bindings/power/imx8mn-power.h
new file mode 100644
index 000000000000..102ee85a9b62
--- /dev/null
+++ b/include/dt-bindings/power/imx8mn-power.h
@@ -0,0 +1,15 @@
+/* SPDX-License-Identifier: (GPL-2.0 OR MIT) */
+/*
+ *  Copyright (C) 2020 Compass Electronics Group, LLC
+ */
+
+#ifndef __DT_BINDINGS_IMX8MN_POWER_H__
+#define __DT_BINDINGS_IMX8MN_POWER_H__
+
+#define IMX8MN_POWER_DOMAIN_HSIOMIX	0
+#define IMX8MN_POWER_DOMAIN_OTG1	1
+#define IMX8MN_POWER_DOMAIN_GPUMIX	2
+#define IMX8MN_POWER_DOMAIN_DISPMIX	3
+#define IMX8MN_POWER_DOMAIN_MIPI	4
+
+#endif
-- 
2.25.1

