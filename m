Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2B91538F756
	for <lists+linux-kernel@lfdr.de>; Tue, 25 May 2021 03:08:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229772AbhEYBJR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 24 May 2021 21:09:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35800 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229571AbhEYBJN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 May 2021 21:09:13 -0400
Received: from mail-il1-x135.google.com (mail-il1-x135.google.com [IPv6:2607:f8b0:4864:20::135])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D08C2C061574;
        Mon, 24 May 2021 18:07:43 -0700 (PDT)
Received: by mail-il1-x135.google.com with SMTP id l15so21500520iln.8;
        Mon, 24 May 2021 18:07:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=iYNgpKhY4WhOSZCwq7VPlCRIlv2afIT+d0mdnVUMXBs=;
        b=gWoBdx8ab4VN6+gKQ/pbpW6tkCMqT6ZeDa14AWTZbLbrNh2pLRratj6ZLLCOQ/uVHw
         VK2wg53zb6era1Ak2Tc6s3E87lJP84/jHVXJtB4VWZSw3TKEi7dPwonJizfO6qs8gvpS
         /5IYe5eO/oFoBU7SJcTxQIK9QaBoAHvHysubQVh3GNw1BtINup3OFzuWZ7B3mxFRotBT
         vOaGbq60qvJTFOMgvrb3rLRQy7nw5DTdVcJSxcJLUoNtlPsHfDGj76hM0MIFec2OqkQg
         cNbXXpSSNFTh3VnlTuXipCu3XvtrGcSsaKlM/HVznatQAntRPerlUg3eschDf0YBuo76
         xK1g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=iYNgpKhY4WhOSZCwq7VPlCRIlv2afIT+d0mdnVUMXBs=;
        b=C95ic3b+bcgTN/Qr3P2XkbeiRyciVn4R8XMg79t4f/e9drtHh3SXtOQSUxFczcGxCb
         Hen99Ndoi1+NRB4R6FFTlbucdFTssDM3A+ykTqZJfkd4aHCGE8Yb9Ah/E0hYXwv0gvfi
         J+BJMjBWjCaFQ8OabFPjzPqd03zArD2oJgePKpkN+SXk6gmw2GMTvpOeNY483pbY9i4Z
         lVSpdvZQVb1pfGYO96ZXvTmM9qLAUnd+5GPgYXRZNR6ZanmMPD5RL+lNVS/lNd51ETUO
         V+GhtmpfzTu9fTu3WbMdiVQjpnZGkqeMm4dIhYPBvu2YSu+QIkjgw1Me0GLYpgLSf5Ny
         /OgA==
X-Gm-Message-State: AOAM533nRpiNeGgSvbx3aJZBNvGD33/qDVQcwTeoIkl0vZIfW72HOyCT
        aUF1JXO70pd2eH6FTs85/OU=
X-Google-Smtp-Source: ABdhPJyyxv8fzPBhzEu5636IC1fCfu87jWxAeBW/obqoRykrUftIHyosEZsCByFoJq6Vi9qAnOdaTw==
X-Received: by 2002:a05:6e02:12c5:: with SMTP id i5mr20034549ilm.101.1621904863110;
        Mon, 24 May 2021 18:07:43 -0700 (PDT)
Received: from aford-IdeaCentre-A730.lan ([2601:448:8400:9e8:599b:b8c7:b3a9:9f1d])
        by smtp.gmail.com with ESMTPSA id w20sm12318413ilj.16.2021.05.24.18.07.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 24 May 2021 18:07:42 -0700 (PDT)
From:   Adam Ford <aford173@gmail.com>
To:     linux-arm-kernel@lists.infradead.org
Cc:     aford@beaconembedded.com, Adam Ford <aford173@gmail.com>,
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
Subject: [PATCH 1/5] dt-bindings: add defines for i.MX8MN power domains
Date:   Mon, 24 May 2021 20:07:28 -0500
Message-Id: <20210525010732.115562-2-aford173@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210525010732.115562-1-aford173@gmail.com>
References: <20210525010732.115562-1-aford173@gmail.com>
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

diff --git a/Documentation/devicetree/bindings/power/fsl,imx-gpcv2.yaml b/Documentation/devicetree/bindings/power/fsl,imx-gpcv2.yaml
index 87b6318bf2b9..01bdda167eef 100644
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

