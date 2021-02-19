Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D967031FCA0
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Feb 2021 17:02:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229967AbhBSQCM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 19 Feb 2021 11:02:12 -0500
Received: from inva020.nxp.com ([92.121.34.13]:35672 "EHLO inva020.nxp.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229766AbhBSQBs (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 19 Feb 2021 11:01:48 -0500
Received: from inva020.nxp.com (localhost [127.0.0.1])
        by inva020.eu-rdc02.nxp.com (Postfix) with ESMTP id B225C1A0041;
        Fri, 19 Feb 2021 17:00:58 +0100 (CET)
Received: from inva024.eu-rdc02.nxp.com (inva024.eu-rdc02.nxp.com [134.27.226.22])
        by inva020.eu-rdc02.nxp.com (Postfix) with ESMTP id A589F1A023B;
        Fri, 19 Feb 2021 17:00:58 +0100 (CET)
Received: from fsr-ub1664-175.ea.freescale.net (fsr-ub1664-175.ea.freescale.net [10.171.82.40])
        by inva024.eu-rdc02.nxp.com (Postfix) with ESMTP id 081BD2042F;
        Fri, 19 Feb 2021 17:00:58 +0100 (CET)
From:   Abel Vesa <abel.vesa@nxp.com>
To:     Rob Herring <robh@kernel.org>, Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <kernel@pengutronix.de>,
        Lucas Stach <l.stach@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>,
        Chanwoo Choi <cw00.choi@samsung.com>,
        Georgi Djakov <djakov@kernel.org>,
        Dong Aisheng <aisheng.dong@nxp.com>,
        Peng Fan <peng.fan@nxp.com>,
        Martin Kepplinger <martink@posteo.de>,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-clk@vger.kernel.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Cc:     NXP Linux Team <linux-imx@nxp.com>, Abel Vesa <abel.vesa@nxp.com>
Subject: [RFC 02/19] dt-bindings: interconnect: imx8mq: Add missing pl301 and SAI ids
Date:   Fri, 19 Feb 2021 17:59:59 +0200
Message-Id: <1613750416-11901-3-git-send-email-abel.vesa@nxp.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1613750416-11901-1-git-send-email-abel.vesa@nxp.com>
References: <1613750416-11901-1-git-send-email-abel.vesa@nxp.com>
X-Virus-Scanned: ClamAV using ClamSMTP
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

According to the bus diagram, there are two more pl301s that need to
be added here. The pl301_per_m which is an intermediary node between
pl301_main and its masters: usdhc1, usdhc2 and sdma. The pl301_wakeup
is an intermediary node between pl301_main and its masters, in this case
all the SAIs.

Signed-off-by: Abel Vesa <abel.vesa@nxp.com>
---
 include/dt-bindings/interconnect/imx8mq.h | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/include/dt-bindings/interconnect/imx8mq.h b/include/dt-bindings/interconnect/imx8mq.h
index 1a4cae7f8be2..1953de8af5cb 100644
--- a/include/dt-bindings/interconnect/imx8mq.h
+++ b/include/dt-bindings/interconnect/imx8mq.h
@@ -44,5 +44,14 @@
 #define IMX8MQ_ICM_PCIE1	26
 #define IMX8MQ_ICM_PCIE2	27
 #define IMX8MQ_ICN_MAIN		28
+#define IMX8MQ_ICN_PER_M	30
+
+#define IMX8MQ_ICN_WAKEUP	31
+#define IMX8MQ_ICM_SAI1		32
+#define IMX8MQ_ICM_SAI2		33
+#define IMX8MQ_ICM_SAI3		34
+#define IMX8MQ_ICM_SAI4		35
+#define IMX8MQ_ICM_SAI5		36
+#define IMX8MQ_ICM_SAI6		37
 
 #endif /* __DT_BINDINGS_INTERCONNECT_IMX8MQ_H */
-- 
2.29.2

