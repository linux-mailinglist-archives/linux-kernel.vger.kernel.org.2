Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 54192324FD3
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Feb 2021 13:23:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233804AbhBYMWF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 25 Feb 2021 07:22:05 -0500
Received: from inva021.nxp.com ([92.121.34.21]:57174 "EHLO inva021.nxp.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232600AbhBYMVg (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Feb 2021 07:21:36 -0500
Received: from inva021.nxp.com (localhost [127.0.0.1])
        by inva021.eu-rdc02.nxp.com (Postfix) with ESMTP id 96293200C0F;
        Thu, 25 Feb 2021 13:20:48 +0100 (CET)
Received: from invc005.ap-rdc01.nxp.com (invc005.ap-rdc01.nxp.com [165.114.16.14])
        by inva021.eu-rdc02.nxp.com (Postfix) with ESMTP id 51FFD200C38;
        Thu, 25 Feb 2021 13:20:43 +0100 (CET)
Received: from localhost.localdomain (shlinux2.ap.freescale.net [10.192.224.44])
        by invc005.ap-rdc01.nxp.com (Postfix) with ESMTP id 97A4340291;
        Thu, 25 Feb 2021 13:20:36 +0100 (CET)
From:   Shengjiu Wang <shengjiu.wang@nxp.com>
To:     lgirdwood@gmail.com, broonie@kernel.org, perex@perex.cz,
        tiwai@suse.com, pierre-louis.bossart@linux.intel.com,
        stephan@gerhold.net, guennadi.liakhovetski@linux.intel.com,
        kai.vehmanen@linux.intel.com, alsa-devel@alsa-project.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH] ASoC: simple-card: Add dummy dai support simple sound card
Date:   Thu, 25 Feb 2021 20:08:32 +0800
Message-Id: <1614254912-15746-1-git-send-email-shengjiu.wang@nxp.com>
X-Mailer: git-send-email 2.7.4
X-Virus-Scanned: ClamAV using ClamSMTP
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

If sound card doesn't need specific codec device, just
dummy codec is enough, then we can link the dummy component
directly.

In this case, user needs to specify below setting in
devicetree. Previously the sound-dai is a node of codec,
now we check if it is zero before parsing the node, zero
means dummy component is specified.

	simple-audio-card,codec {
		sound-dai = <0>;
	};

Signed-off-by: Shengjiu Wang <shengjiu.wang@nxp.com>
---
 sound/soc/generic/simple-card.c | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/sound/soc/generic/simple-card.c b/sound/soc/generic/simple-card.c
index c262281bc64d..8b0cabd1bad1 100644
--- a/sound/soc/generic/simple-card.c
+++ b/sound/soc/generic/simple-card.c
@@ -34,10 +34,19 @@ static int asoc_simple_parse_dai(struct device_node *node,
 {
 	struct of_phandle_args args;
 	int ret;
+	u32 val;
 
 	if (!node)
 		return 0;
 
+	ret = of_property_read_u32(node, DAI, &val);
+	if (val == 0) {
+		dlc->of_node       = NULL;
+		dlc->dai_name      = "snd-soc-dummy-dai";
+		dlc->name          = "snd-soc-dummy";
+		return 0;
+	}
+
 	/*
 	 * Get node via "sound-dai = <&phandle port>"
 	 * it will be used as xxx_of_node on soc_bind_dai_link()
-- 
2.27.0

