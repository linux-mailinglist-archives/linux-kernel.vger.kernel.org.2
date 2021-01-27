Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0CBEC306260
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Jan 2021 18:44:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344116AbhA0Rng (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 27 Jan 2021 12:43:36 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57798 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344068AbhA0Rlc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Jan 2021 12:41:32 -0500
Received: from bhuna.collabora.co.uk (bhuna.collabora.co.uk [IPv6:2a00:1098:0:82:1000:25:2eeb:e3e3])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F02EFC06174A;
        Wed, 27 Jan 2021 09:40:51 -0800 (PST)
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (Authenticated sender: sre)
        with ESMTPSA id 0799A1F44AA3
Received: by jupiter.universe (Postfix, from userid 1000)
        id F2FCF4800C0; Wed, 27 Jan 2021 18:40:47 +0100 (CET)
From:   Sebastian Reichel <sebastian.reichel@collabora.com>
To:     Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>
Cc:     Rob Herring <robh+dt@kernel.org>,
        Fabio Estevam <festevam@gmail.com>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        NXP Linux Team <linux-imx@nxp.com>,
        linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Sebastian Reichel <sebastian.reichel@collabora.com>,
        kernel@collabora.com
Subject: [PATCH 2/2] soc: imx: add i.MX51/i.MX53 unique id support
Date:   Wed, 27 Jan 2021 18:40:24 +0100
Message-Id: <20210127174024.170408-3-sebastian.reichel@collabora.com>
X-Mailer: git-send-email 2.29.2
In-Reply-To: <20210127174024.170408-1-sebastian.reichel@collabora.com>
References: <20210127174024.170408-1-sebastian.reichel@collabora.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

i.MX51 and i.MX53 SoCs have a 64-bit SoC unique ID stored in IIM,
which can be used as SoC serial number. The same feature is already
implemented for i.MX6/i.MX7, so this complements support to earlier
SoCs.

Signed-off-by: Sebastian Reichel <sebastian.reichel@collabora.com>
---
 drivers/soc/imx/soc-imx.c | 12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/drivers/soc/imx/soc-imx.c b/drivers/soc/imx/soc-imx.c
index 01bfea1cb64a..0738c0f36792 100644
--- a/drivers/soc/imx/soc-imx.c
+++ b/drivers/soc/imx/soc-imx.c
@@ -13,6 +13,8 @@
 #include <soc/imx/cpu.h>
 #include <soc/imx/revision.h>
 
+#define IIM_UID		0x820
+
 #define OCOTP_UID_H	0x420
 #define OCOTP_UID_L	0x410
 
@@ -32,6 +34,7 @@ static int __init imx_soc_device_init(void)
 	u64 soc_uid = 0;
 	u32 val;
 	int ret;
+	int i;
 
 	if (of_machine_is_compatible("fsl,ls1021a"))
 		return 0;
@@ -68,9 +71,11 @@ static int __init imx_soc_device_init(void)
 		soc_id = "i.MX35";
 		break;
 	case MXC_CPU_MX51:
+		ocotp_compat = "fsl,imx51-iim";
 		soc_id = "i.MX51";
 		break;
 	case MXC_CPU_MX53:
+		ocotp_compat = "fsl,imx53-iim";
 		soc_id = "i.MX53";
 		break;
 	case MXC_CPU_IMX6SL:
@@ -153,6 +158,13 @@ static int __init imx_soc_device_init(void)
 			regmap_read(ocotp, OCOTP_ULP_UID_1, &val);
 			soc_uid <<= 16;
 			soc_uid |= val & 0xffff;
+		} else if (__mxc_cpu_type == MXC_CPU_MX51 ||
+			   __mxc_cpu_type == MXC_CPU_MX53) {
+			for (i=0; i < 8; i++) {
+				regmap_read(ocotp, IIM_UID + i*4, &val);
+				soc_uid <<= 8;
+				soc_uid |= (val & 0xff);
+			}
 		} else {
 			regmap_read(ocotp, OCOTP_UID_H, &val);
 			soc_uid = val;
-- 
2.29.2

