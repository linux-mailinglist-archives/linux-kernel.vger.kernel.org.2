Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 869073237B9
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Feb 2021 08:12:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234352AbhBXHLw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 24 Feb 2021 02:11:52 -0500
Received: from inva021.nxp.com ([92.121.34.21]:33804 "EHLO inva021.nxp.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231717AbhBXHKw (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Feb 2021 02:10:52 -0500
Received: from inva021.nxp.com (localhost [127.0.0.1])
        by inva021.eu-rdc02.nxp.com (Postfix) with ESMTP id 979E92003CE;
        Wed, 24 Feb 2021 08:10:04 +0100 (CET)
Received: from invc005.ap-rdc01.nxp.com (invc005.ap-rdc01.nxp.com [165.114.16.14])
        by inva021.eu-rdc02.nxp.com (Postfix) with ESMTP id 1966120036F;
        Wed, 24 Feb 2021 08:10:01 +0100 (CET)
Received: from localhost.localdomain (shlinux2.ap.freescale.net [10.192.224.44])
        by invc005.ap-rdc01.nxp.com (Postfix) with ESMTP id 8037140319;
        Wed, 24 Feb 2021 08:09:56 +0100 (CET)
From:   Shengjiu Wang <shengjiu.wang@nxp.com>
To:     lgirdwood@gmail.com, broonie@kernel.org, perex@perex.cz,
        tiwai@suse.com, alsa-devel@alsa-project.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH 2/2] ASoC: ak5558: Add MODULE_DEVICE_TABLE
Date:   Wed, 24 Feb 2021 14:57:52 +0800
Message-Id: <1614149872-25510-2-git-send-email-shengjiu.wang@nxp.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1614149872-25510-1-git-send-email-shengjiu.wang@nxp.com>
References: <1614149872-25510-1-git-send-email-shengjiu.wang@nxp.com>
X-Virus-Scanned: ClamAV using ClamSMTP
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add missed MODULE_DEVICE_TABLE for the driver can be loaded
automatically at boot.

Fixes: 920884777480 ("ASoC: ak5558: Add support for AK5558 ADC driver")
Cc: <stable@vger.kernel.org>
Signed-off-by: Shengjiu Wang <shengjiu.wang@nxp.com>
---
 sound/soc/codecs/ak5558.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/sound/soc/codecs/ak5558.c b/sound/soc/codecs/ak5558.c
index 8a32b0139cb0..85bdd0534180 100644
--- a/sound/soc/codecs/ak5558.c
+++ b/sound/soc/codecs/ak5558.c
@@ -419,6 +419,7 @@ static const struct of_device_id ak5558_i2c_dt_ids[] __maybe_unused = {
 	{ .compatible = "asahi-kasei,ak5558"},
 	{ }
 };
+MODULE_DEVICE_TABLE(of, ak5558_i2c_dt_ids);
 
 static struct i2c_driver ak5558_i2c_driver = {
 	.driver = {
-- 
2.27.0

