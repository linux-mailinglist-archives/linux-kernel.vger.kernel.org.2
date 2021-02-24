Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 151443237B8
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Feb 2021 08:12:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231154AbhBXHLk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 24 Feb 2021 02:11:40 -0500
Received: from inva020.nxp.com ([92.121.34.13]:47842 "EHLO inva020.nxp.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S234157AbhBXHKv (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Feb 2021 02:10:51 -0500
Received: from inva020.nxp.com (localhost [127.0.0.1])
        by inva020.eu-rdc02.nxp.com (Postfix) with ESMTP id 533AB1A0257;
        Wed, 24 Feb 2021 08:10:03 +0100 (CET)
Received: from invc005.ap-rdc01.nxp.com (invc005.ap-rdc01.nxp.com [165.114.16.14])
        by inva020.eu-rdc02.nxp.com (Postfix) with ESMTP id DBC501A00AD;
        Wed, 24 Feb 2021 08:09:59 +0100 (CET)
Received: from localhost.localdomain (shlinux2.ap.freescale.net [10.192.224.44])
        by invc005.ap-rdc01.nxp.com (Postfix) with ESMTP id BD67740324;
        Wed, 24 Feb 2021 08:09:55 +0100 (CET)
From:   Shengjiu Wang <shengjiu.wang@nxp.com>
To:     lgirdwood@gmail.com, broonie@kernel.org, perex@perex.cz,
        tiwai@suse.com, alsa-devel@alsa-project.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH 1/2] ASoC: ak4458: Add MODULE_DEVICE_TABLE
Date:   Wed, 24 Feb 2021 14:57:51 +0800
Message-Id: <1614149872-25510-1-git-send-email-shengjiu.wang@nxp.com>
X-Mailer: git-send-email 2.7.4
X-Virus-Scanned: ClamAV using ClamSMTP
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add missed MODULE_DEVICE_TABLE for the driver can be loaded
automatically at boot.

Fixes: 08660086eff9 ("ASoC: ak4458: Add support for AK4458 DAC driver")
Cc: <stable@vger.kernel.org>
Signed-off-by: Shengjiu Wang <shengjiu.wang@nxp.com>
---
 sound/soc/codecs/ak4458.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/sound/soc/codecs/ak4458.c b/sound/soc/codecs/ak4458.c
index 472caad17012..85a1d00894a9 100644
--- a/sound/soc/codecs/ak4458.c
+++ b/sound/soc/codecs/ak4458.c
@@ -812,6 +812,7 @@ static const struct of_device_id ak4458_of_match[] = {
 	{ .compatible = "asahi-kasei,ak4497", .data = &ak4497_drvdata},
 	{ },
 };
+MODULE_DEVICE_TABLE(of, ak4458_of_match);
 
 static struct i2c_driver ak4458_i2c_driver = {
 	.driver = {
-- 
2.27.0

