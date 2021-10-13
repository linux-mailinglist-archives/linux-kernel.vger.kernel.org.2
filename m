Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7E35F42B310
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Oct 2021 05:04:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237059AbhJMDGY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 12 Oct 2021 23:06:24 -0400
Received: from inva021.nxp.com ([92.121.34.21]:40428 "EHLO inva021.nxp.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229571AbhJMDGX (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Oct 2021 23:06:23 -0400
Received: from inva021.nxp.com (localhost [127.0.0.1])
        by inva021.eu-rdc02.nxp.com (Postfix) with ESMTP id C07B6201F6E;
        Wed, 13 Oct 2021 05:04:19 +0200 (CEST)
Received: from aprdc01srsp001v.ap-rdc01.nxp.com (aprdc01srsp001v.ap-rdc01.nxp.com [165.114.16.16])
        by inva021.eu-rdc02.nxp.com (Postfix) with ESMTP id 8088D2026D3;
        Wed, 13 Oct 2021 05:04:19 +0200 (CEST)
Received: from localhost.localdomain (shlinux2.ap.freescale.net [10.192.224.44])
        by aprdc01srsp001v.ap-rdc01.nxp.com (Postfix) with ESMTP id B550D183AD0B;
        Wed, 13 Oct 2021 11:04:17 +0800 (+08)
From:   Shengjiu Wang <shengjiu.wang@nxp.com>
To:     ohad@wizery.com, bjorn.andersson@linaro.org,
        mathieu.poirier@linaro.org, shawnguo@kernel.org,
        s.hauer@pengutronix.de, kernel@pengutronix.de, festevam@gmail.com,
        linux-imx@nxp.com, linux-remoteproc@vger.kernel.org
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        shengjiu.wang@gmail.com
Subject: [PATCH] remoteproc: imx_dsp_rproc: Correct the comment style of copyright
Date:   Wed, 13 Oct 2021 10:39:09 +0800
Message-Id: <1634092749-3707-1-git-send-email-shengjiu.wang@nxp.com>
X-Mailer: git-send-email 2.7.4
X-Virus-Scanned: ClamAV using ClamSMTP
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Change '//' on copyright line to C style comments.

Fixes: ec0e5549f358 ("remoteproc: imx_dsp_rproc: Add remoteproc driver for DSP on i.MX")
Reported-by: Mathieu Poirier <mathieu.poirier@linaro.org>
Signed-off-by: Shengjiu Wang <shengjiu.wang@nxp.com>
---
 drivers/remoteproc/imx_dsp_rproc.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/remoteproc/imx_dsp_rproc.c b/drivers/remoteproc/imx_dsp_rproc.c
index 63749cfcf22f..6f306fbd3448 100644
--- a/drivers/remoteproc/imx_dsp_rproc.c
+++ b/drivers/remoteproc/imx_dsp_rproc.c
@@ -1,5 +1,5 @@
 // SPDX-License-Identifier: GPL-2.0-only
-// Copyright 2021 NXP
+/* Copyright 2021 NXP */
 
 #include <dt-bindings/firmware/imx/rsrc.h>
 #include <linux/arm-smccc.h>
-- 
2.17.1

