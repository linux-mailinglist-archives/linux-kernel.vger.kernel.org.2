Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F33CA403700
	for <lists+linux-kernel@lfdr.de>; Wed,  8 Sep 2021 11:34:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348584AbhIHJfa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 8 Sep 2021 05:35:30 -0400
Received: from inva020.nxp.com ([92.121.34.13]:56156 "EHLO inva020.nxp.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1347584AbhIHJfH (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Sep 2021 05:35:07 -0400
Received: from inva020.nxp.com (localhost [127.0.0.1])
        by inva020.eu-rdc02.nxp.com (Postfix) with ESMTP id 724031A2F17;
        Wed,  8 Sep 2021 11:33:58 +0200 (CEST)
Received: from aprdc01srsp001v.ap-rdc01.nxp.com (aprdc01srsp001v.ap-rdc01.nxp.com [165.114.16.16])
        by inva020.eu-rdc02.nxp.com (Postfix) with ESMTP id 39B571A00A3;
        Wed,  8 Sep 2021 11:33:58 +0200 (CEST)
Received: from localhost.localdomain (shlinux2.ap.freescale.net [10.192.224.44])
        by aprdc01srsp001v.ap-rdc01.nxp.com (Postfix) with ESMTP id 7100A183AD26;
        Wed,  8 Sep 2021 17:33:56 +0800 (+08)
From:   Shengjiu Wang <shengjiu.wang@nxp.com>
To:     ohad@wizery.com, bjorn.andersson@linaro.org,
        mathieu.poirier@linaro.org, robh+dt@kernel.org,
        shawnguo@kernel.org, s.hauer@pengutronix.de, kernel@pengutronix.de,
        festevam@gmail.com, daniel.baluta@nxp.com
Cc:     linux-imx@nxp.com, linux-remoteproc@vger.kernel.org,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, shengjiu.wang@gmail.com
Subject: [PATCH v4 2/4] remoteproc: imx_rproc: Add IMX_RPROC_SCU_API method
Date:   Wed,  8 Sep 2021 17:10:53 +0800
Message-Id: <1631092255-25150-3-git-send-email-shengjiu.wang@nxp.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1631092255-25150-1-git-send-email-shengjiu.wang@nxp.com>
References: <1631092255-25150-1-git-send-email-shengjiu.wang@nxp.com>
X-Virus-Scanned: ClamAV using ClamSMTP
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On i.MX8QM and i.MX8QXP, most devices are controlled
by System Control Unit, so add IMX_RPROC_SCU_API
method for these platform.

Signed-off-by: Shengjiu Wang <shengjiu.wang@nxp.com>
---
 drivers/remoteproc/imx_rproc.h | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/remoteproc/imx_rproc.h b/drivers/remoteproc/imx_rproc.h
index 23d8e808d27f..1c7e2127c758 100644
--- a/drivers/remoteproc/imx_rproc.h
+++ b/drivers/remoteproc/imx_rproc.h
@@ -22,6 +22,8 @@ enum imx_rproc_method {
 	IMX_RPROC_MMIO,
 	/* Through ARM SMCCC */
 	IMX_RPROC_SMC,
+	/* Through System Control Unit API */
+	IMX_RPROC_SCU_API,
 };
 
 struct imx_rproc_dcfg {
-- 
2.17.1

