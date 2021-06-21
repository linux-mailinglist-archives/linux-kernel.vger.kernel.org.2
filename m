Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 94F033AE420
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Jun 2021 09:25:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230335AbhFUH1f (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 21 Jun 2021 03:27:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46808 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230397AbhFUH12 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Jun 2021 03:27:28 -0400
Received: from mail-pg1-x536.google.com (mail-pg1-x536.google.com [IPv6:2607:f8b0:4864:20::536])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2D25AC061767
        for <linux-kernel@vger.kernel.org>; Mon, 21 Jun 2021 00:25:14 -0700 (PDT)
Received: by mail-pg1-x536.google.com with SMTP id i34so7803454pgl.9
        for <linux-kernel@vger.kernel.org>; Mon, 21 Jun 2021 00:25:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=amarulasolutions.com; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=/pGjb2AmXz+lBmXRvuYK+0My7OEKqfzWIwfNjkS45hA=;
        b=B9B52vgxd/J4eTdK7UlVsZJ7csp6Wy5F6P2A20Mfw0H1RRWpOrSZaJTujs3hnlfzCz
         lquOWxd8ZvszDgJBt5LkR7OIgGAYPjCdylfqn/O2NYN4AtmxpZNGZJgy/JPcPkMTY5hX
         nywtvsNF2KIYxRwwwQnWW7ejXPXt/r/tOk/hU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=/pGjb2AmXz+lBmXRvuYK+0My7OEKqfzWIwfNjkS45hA=;
        b=J7gOpt4zZeCx0Via/6nWWIIGLXX71ewM3HqniZk5z+DlXzyWcu1DwzoyrSHykcRmWx
         Dep0g4KzBwRr4BAp2aPLiP9kflqhjVoErfd0CBoai8ksvtlZEsxHKXyYQicN3TuoT3S2
         ZUCf6wg2YCScj5dNTtckYBl/azIYH4KPbarJDtWlAA5ZrbLOc0lHECH1/GzjSYAUzgQK
         7rxL+FjRPVNb960gXXqDoDOojuGDtTHmmW/ZXdkE75QAorrVAkT81sUzyl1zsUM42ria
         bOX8om01/lIDiYHAXhjD5GaH9evGoIa73vSwKtx8JkEP6C027CYkzw5zWLtibstJUsDd
         DlXg==
X-Gm-Message-State: AOAM533Tqy249ymRxgSRzTk7KLV4Mev1oDqWv8hj04s+NTCUjQDrNit9
        1n7yHFmloAm/Zn78LCGcJit4Ew==
X-Google-Smtp-Source: ABdhPJxo+t1TLHHi1OZRYJMnwd/WKQz+bnqZydSgYB9/egnda8r4P1VP3GSrFWZ7KhGsl+nW3aljHQ==
X-Received: by 2002:a63:ed17:: with SMTP id d23mr22382992pgi.107.1624260313749;
        Mon, 21 Jun 2021 00:25:13 -0700 (PDT)
Received: from localhost.localdomain ([2405:201:c00a:a884:139:e97f:a55d:7f66])
        by smtp.gmail.com with ESMTPSA id 21sm13951294pfh.103.2021.06.21.00.25.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 21 Jun 2021 00:25:13 -0700 (PDT)
From:   Jagan Teki <jagan@amarulasolutions.com>
To:     Peng Fan <peng.fan@nxp.com>, Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Tomasz Figa <t.figa@samsung.com>,
        Fancy Fang <chen.fang@nxp.com>
Cc:     devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        dri-devel@lists.freedesktop.org, linux-phy@lists.infradead.org,
        linux-kernel@vger.kernel.org, NXP Linux Team <linux-imx@nxp.com>,
        linux-amarula@amarulasolutions.com,
        Anthony Brandon <anthony@amarulasolutions.com>,
        Francis Laniel <francis.laniel@amarulasolutions.com>,
        Matteo Lisi <matteo.lisi@engicam.com>,
        Milco Pratesi <milco.pratesi@engicam.com>,
        Jagan Teki <jagan@amarulasolutions.com>
Subject: [RFC PATCH 5/9] soc: imx8mm: blk-ctl: Add MIPI DPHY reset enable
Date:   Mon, 21 Jun 2021 12:54:20 +0530
Message-Id: <20210621072424.111733-6-jagan@amarulasolutions.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210621072424.111733-1-jagan@amarulasolutions.com>
References: <20210621072424.111733-1-jagan@amarulasolutions.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add MIPI DPHY reset enable pin in blk-ctl driver for i.MX8MM.

Signed-off-by: Jagan Teki <jagan@amarulasolutions.com>
---
 drivers/soc/imx/blk-ctl-imx8mm.c         | 4 ++++
 include/dt-bindings/power/imx8mm-power.h | 5 +++--
 2 files changed, 7 insertions(+), 2 deletions(-)

diff --git a/drivers/soc/imx/blk-ctl-imx8mm.c b/drivers/soc/imx/blk-ctl-imx8mm.c
index 5ca8d6c52917..a9d900754faf 100644
--- a/drivers/soc/imx/blk-ctl-imx8mm.c
+++ b/drivers/soc/imx/blk-ctl-imx8mm.c
@@ -25,6 +25,7 @@
 #define MEDIA_BLK_MIPI_CSI_I_PRESETN_SFT_EN			BIT(4)
 #define MEDIA_BLK_CAMERA_PIXEL_RESET_N_SFT_EN			BIT(3)
 #define MEDIA_BLK_CSI_BRIDGE_SFT_EN				GENMASK(2, 0)
+#define MEDIA_BLK_GPR_MIPI_M_RESETN				BIT(17)
 
 #define MEDIA_BLK_BUS_PD_MASK					BIT(12)
 #define MEDIA_BLK_MIPI_CSI_PD_MASK				GENMASK(11, 10)
@@ -41,6 +42,9 @@ static struct imx_blk_ctl_hw imx8mm_dispmix_blk_ctl_pds[] = {
 	IMX_BLK_CTL_PD("MIPI_DSI", "mipi", IMX8MM_BLK_CTL_PD_DISPMIX_MIPI_DSI, 0x4,
 		       MEDIA_BLK_MIPI_DSI_PD_MASK, 0, MEDIA_BLK_MIPI_DSI_I_PRESETN_SFT_EN,
 		       IMX_BLK_CTL_PD_RESET),
+	IMX_BLK_CTL_PD("DPHY", "dphy", IMX8MM_BLK_CTL_PD_DISPMIX_MIPI_DPHY, 0x4,
+		       MEDIA_BLK_MIPI_DSI_PD_MASK, 0x8, MEDIA_BLK_GPR_MIPI_M_RESETN,
+		       IMX_BLK_CTL_PD_RESET),
 	IMX_BLK_CTL_PD("MIPI_CSI", "mipi", IMX8MM_BLK_CTL_PD_DISPMIX_MIPI_CSI, 0x4,
 		       MEDIA_BLK_MIPI_CSI_PD_MASK, 0,
 		       MEDIA_BLK_MIPI_CSI_I_PRESETN_SFT_EN | MEDIA_BLK_CAMERA_PIXEL_RESET_N_SFT_EN,
diff --git a/include/dt-bindings/power/imx8mm-power.h b/include/dt-bindings/power/imx8mm-power.h
index a10266befa9c..8becb123e191 100644
--- a/include/dt-bindings/power/imx8mm-power.h
+++ b/include/dt-bindings/power/imx8mm-power.h
@@ -27,7 +27,8 @@
 #define IMX8MM_BLK_CTL_PD_DISPMIX_CSI_BRIDGE	0
 #define IMX8MM_BLK_CTL_PD_DISPMIX_LCDIF		1
 #define IMX8MM_BLK_CTL_PD_DISPMIX_MIPI_DSI	2
-#define IMX8MM_BLK_CTL_PD_DISPMIX_MIPI_CSI	3
-#define IMX8MM_BLK_CTL_PD_DISPMIX_MAX		4
+#define IMX8MM_BLK_CTL_PD_DISPMIX_MIPI_DPHY	3
+#define IMX8MM_BLK_CTL_PD_DISPMIX_MIPI_CSI	4
+#define IMX8MM_BLK_CTL_PD_DISPMIX_MAX		5
 
 #endif
-- 
2.25.1

