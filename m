Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7B2D93B052D
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Jun 2021 14:50:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231463AbhFVMw0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 22 Jun 2021 08:52:26 -0400
Received: from inva020.nxp.com ([92.121.34.13]:35548 "EHLO inva020.nxp.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229675AbhFVMwY (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Jun 2021 08:52:24 -0400
Received: from inva020.nxp.com (localhost [127.0.0.1])
        by inva020.eu-rdc02.nxp.com (Postfix) with ESMTP id 6C6C21A0E58;
        Tue, 22 Jun 2021 14:50:07 +0200 (CEST)
Received: from invc005.ap-rdc01.nxp.com (invc005.ap-rdc01.nxp.com [165.114.16.14])
        by inva020.eu-rdc02.nxp.com (Postfix) with ESMTP id 65EF81A0E88;
        Tue, 22 Jun 2021 14:50:03 +0200 (CEST)
Received: from localhost.localdomain (shlinux2.ap.freescale.net [10.192.224.44])
        by invc005.ap-rdc01.nxp.com (Postfix) with ESMTP id 199354024D;
        Tue, 22 Jun 2021 20:49:58 +0800 (+08)
From:   Shengjiu Wang <shengjiu.wang@nxp.com>
To:     timur@kernel.org, nicoleotsuka@gmail.com, Xiubo.Lee@gmail.com,
        festevam@gmail.com, broonie@kernel.org, perex@perex.cz,
        tiwai@suse.com, alsa-devel@alsa-project.org
Cc:     linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org
Subject: [PATCH] ASoC: fsl_spdif: Fix unexpected interrupt after suspend
Date:   Tue, 22 Jun 2021 20:31:24 +0800
Message-Id: <1624365084-7934-1-git-send-email-shengjiu.wang@nxp.com>
X-Mailer: git-send-email 2.7.4
X-Virus-Scanned: ClamAV using ClamSMTP
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When system enter suspend, the machine driver suspend callback
function will be called, then the cpu driver trigger callback
(SNDRV_PCM_TRIGGER_SUSPEND) be called, it would disable the
interrupt.

But the machine driver suspend and cpu dai driver suspend order
maybe changed, the cpu dai driver's suspend callback is called before
machine driver's suppend callback, then the interrupt is not cleared
successfully in trigger callback.

So need to clear interrupts in cpu dai driver's suspend callback
to avoid such issue.

Fixes: 9cb2b3796e08 ("ASoC: fsl_spdif: Add pm runtime function")
Signed-off-by: Shengjiu Wang <shengjiu.wang@nxp.com>
---
 sound/soc/fsl/fsl_spdif.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/sound/soc/fsl/fsl_spdif.c b/sound/soc/fsl/fsl_spdif.c
index a9c6b930b04a..8ffb1a6048d6 100644
--- a/sound/soc/fsl/fsl_spdif.c
+++ b/sound/soc/fsl/fsl_spdif.c
@@ -1467,6 +1467,9 @@ static int fsl_spdif_runtime_suspend(struct device *dev)
 	struct fsl_spdif_priv *spdif_priv = dev_get_drvdata(dev);
 	int i;
 
+	/* Disable all the interrupts */
+	regmap_update_bits(spdif_priv->regmap, REG_SPDIF_SIE, 0xffffff, 0);
+
 	regmap_read(spdif_priv->regmap, REG_SPDIF_SRPC,
 			&spdif_priv->regcache_srpc);
 	regcache_cache_only(spdif_priv->regmap, true);
-- 
2.27.0

