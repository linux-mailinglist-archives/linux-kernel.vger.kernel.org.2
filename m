Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5AFB632E4DF
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Mar 2021 10:33:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229642AbhCEJcf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 5 Mar 2021 04:32:35 -0500
Received: from inva021.nxp.com ([92.121.34.21]:55192 "EHLO inva021.nxp.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229608AbhCEJcU (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 5 Mar 2021 04:32:20 -0500
Received: from inva021.nxp.com (localhost [127.0.0.1])
        by inva021.eu-rdc02.nxp.com (Postfix) with ESMTP id DBC7D2013FB;
        Fri,  5 Mar 2021 10:32:18 +0100 (CET)
Received: from invc005.ap-rdc01.nxp.com (invc005.ap-rdc01.nxp.com [165.114.16.14])
        by inva021.eu-rdc02.nxp.com (Postfix) with ESMTP id 9FCB62013FE;
        Fri,  5 Mar 2021 10:32:13 +0100 (CET)
Received: from localhost.localdomain (shlinux2.ap.freescale.net [10.192.224.44])
        by invc005.ap-rdc01.nxp.com (Postfix) with ESMTP id 72E5A40249;
        Fri,  5 Mar 2021 10:32:07 +0100 (CET)
From:   Shengjiu Wang <shengjiu.wang@nxp.com>
To:     timur@kernel.org, nicoleotsuka@gmail.com, Xiubo.Lee@gmail.com,
        festevam@gmail.com, broonie@kernel.org, perex@perex.cz,
        tiwai@suse.com, alsa-devel@alsa-project.org
Cc:     linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org
Subject: [PATCH] ASoC: fsl_asrc_dma: request dma channel from specific controller
Date:   Fri,  5 Mar 2021 17:19:37 +0800
Message-Id: <1614935977-21638-1-git-send-email-shengjiu.wang@nxp.com>
X-Mailer: git-send-email 2.7.4
X-Virus-Scanned: ClamAV using ClamSMTP
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Robin Gong <yibin.gong@nxp.com>

Request dma channel from specific dma controller instead of generic
dma controller list, otherwise, may get the wrong dma controller
if there are multi dma controllers such as i.MX8MP.

Signed-off-by: Robin Gong <yibin.gong@nxp.com>
Signed-off-by: Shengjiu Wang <shengjiu.wang@nxp.com>
---
 sound/soc/fsl/fsl_asrc_dma.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/sound/soc/fsl/fsl_asrc_dma.c b/sound/soc/fsl/fsl_asrc_dma.c
index 29f91cdecbc3..c313a26c8f95 100644
--- a/sound/soc/fsl/fsl_asrc_dma.c
+++ b/sound/soc/fsl/fsl_asrc_dma.c
@@ -141,6 +141,7 @@ static int fsl_asrc_dma_hw_params(struct snd_soc_component *component,
 	struct dma_slave_config config_fe, config_be;
 	enum asrc_pair_index index = pair->index;
 	struct device *dev = component->dev;
+	struct device_node *of_dma_node;
 	int stream = substream->stream;
 	struct imx_dma_data *tmp_data;
 	struct snd_soc_dpcm *dpcm;
@@ -231,8 +232,10 @@ static int fsl_asrc_dma_hw_params(struct snd_soc_component *component,
 		pair->dma_data.priority = tmp_data->priority;
 		dma_release_channel(tmp_chan);
 
+		of_dma_node = pair->dma_chan[!dir]->device->dev->of_node;
 		pair->dma_chan[dir] =
-			dma_request_channel(mask, filter, &pair->dma_data);
+			__dma_request_channel(&mask, filter, &pair->dma_data,
+					      of_dma_node);
 		pair->req_dma_chan = true;
 	} else {
 		pair->dma_chan[dir] = tmp_chan;
-- 
2.27.0

