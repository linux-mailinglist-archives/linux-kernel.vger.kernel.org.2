Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8656F38E75F
	for <lists+linux-kernel@lfdr.de>; Mon, 24 May 2021 15:25:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232879AbhEXN0e (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 24 May 2021 09:26:34 -0400
Received: from szxga04-in.huawei.com ([45.249.212.190]:5759 "EHLO
        szxga04-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232885AbhEXN0a (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 May 2021 09:26:30 -0400
Received: from dggems702-chm.china.huawei.com (unknown [172.30.72.58])
        by szxga04-in.huawei.com (SkyGuard) with ESMTP id 4FpdC91vxczml0H;
        Mon, 24 May 2021 21:21:25 +0800 (CST)
Received: from dggeml759-chm.china.huawei.com (10.1.199.138) by
 dggems702-chm.china.huawei.com (10.3.19.179) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256) id
 15.1.2176.2; Mon, 24 May 2021 21:25:00 +0800
Received: from localhost.localdomain (10.175.102.38) by
 dggeml759-chm.china.huawei.com (10.1.199.138) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id
 15.1.2176.2; Mon, 24 May 2021 21:24:59 +0800
From:   Wei Yongjun <weiyongjun1@huawei.com>
To:     <weiyongjun1@huawei.com>, Shengjiu Wang <shengjiu.wang@nxp.com>,
        "Timur Tabi" <timur@kernel.org>,
        Nicolin Chen <nicoleotsuka@gmail.com>,
        Xiubo Li <Xiubo.Lee@gmail.com>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>, Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>
CC:     <alsa-devel@alsa-project.org>, <linuxppc-dev@lists.ozlabs.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <kernel-janitors@vger.kernel.org>,
        Hulk Robot <hulkci@huawei.com>
Subject: [PATCH -next] ASoC: imx-card: Make some symbols static
Date:   Mon, 24 May 2021 13:35:53 +0000
Message-ID: <20210524133553.2366502-1-weiyongjun1@huawei.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Type:   text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
X-Originating-IP: [10.175.102.38]
X-ClientProxiedBy: dggems701-chm.china.huawei.com (10.3.19.178) To
 dggeml759-chm.china.huawei.com (10.1.199.138)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The sparse tool complains as follows:

sound/soc/fsl/imx-card.c:121:27: warning:
 symbol 'ak4458_fs_mul' was not declared. Should it be static?
sound/soc/fsl/imx-card.c:138:31: warning:
 symbol 'ak4458_tdm_fs_mul' was not declared. Should it be static?
sound/soc/fsl/imx-card.c:149:27: warning:
 symbol 'ak4497_fs_mul' was not declared. Should it be static?
sound/soc/fsl/imx-card.c:166:27: warning:
 symbol 'ak5558_fs_mul' was not declared. Should it be static?
sound/soc/fsl/imx-card.c:180:31: warning:
 symbol 'ak5558_tdm_fs_mul' was not declared. Should it be static?

Those symbols are not used outside of imx-card.c, so marks
them static.

Fixes: aa736700f42f ("ASoC: imx-card: Add imx-card machine driver")
Reported-by: Hulk Robot <hulkci@huawei.com>
Signed-off-by: Wei Yongjun <weiyongjun1@huawei.com>
---
 sound/soc/fsl/imx-card.c | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/sound/soc/fsl/imx-card.c b/sound/soc/fsl/imx-card.c
index ab424735bbfe..58fd0639a069 100644
--- a/sound/soc/fsl/imx-card.c
+++ b/sound/soc/fsl/imx-card.c
@@ -118,7 +118,7 @@ struct imx_card_data {
 	u32 asrc_format;
 };
 
-struct imx_akcodec_fs_mul ak4458_fs_mul[] = {
+static struct imx_akcodec_fs_mul ak4458_fs_mul[] = {
 	/* Normal, < 32kHz */
 	{ .rmin = 8000,   .rmax = 24000,  .wmin = 1024, .wmax = 1024, },
 	/* Normal, 32kHz */
@@ -135,7 +135,7 @@ struct imx_akcodec_fs_mul ak4458_fs_mul[] = {
 	{ .rmin = 705600, .rmax = 768000, .wmin = 16,   .wmax = 64,   },
 };
 
-struct imx_akcodec_tdm_fs_mul ak4458_tdm_fs_mul[] = {
+static struct imx_akcodec_tdm_fs_mul ak4458_tdm_fs_mul[] = {
 	/*
 	 * Table 13	- Audio Interface Format
 	 * For TDM mode, MCLK should is set to
@@ -146,7 +146,7 @@ struct imx_akcodec_tdm_fs_mul ak4458_tdm_fs_mul[] = {
 	{ .min = 512,	.max = 512,	.mul = 1024  }, /* TDM512 */
 };
 
-struct imx_akcodec_fs_mul ak4497_fs_mul[] = {
+static struct imx_akcodec_fs_mul ak4497_fs_mul[] = {
 	/**
 	 * Table 7      - mapping multiplier and speed mode
 	 * Tables 8 & 9 - mapping speed mode and LRCK fs
@@ -163,7 +163,7 @@ struct imx_akcodec_fs_mul ak4497_fs_mul[] = {
  * Auto MCLK selection based on LRCK for Normal Mode
  * (Table 4 from datasheet)
  */
-struct imx_akcodec_fs_mul ak5558_fs_mul[] = {
+static struct imx_akcodec_fs_mul ak5558_fs_mul[] = {
 	{ .rmin = 8000,   .rmax = 32000,  .wmin = 1024, .wmax = 1024, },
 	{ .rmin = 44100,  .rmax = 48000,  .wmin = 512,  .wmax = 512, },
 	{ .rmin = 88200,  .rmax = 96000,  .wmin = 256,  .wmax = 256, },
@@ -177,7 +177,7 @@ struct imx_akcodec_fs_mul ak5558_fs_mul[] = {
  * because of SAI we also add the restriction: MCLK >= 2 * BCLK
  * (Table 9 from datasheet)
  */
-struct imx_akcodec_tdm_fs_mul ak5558_tdm_fs_mul[] = {
+static struct imx_akcodec_tdm_fs_mul ak5558_tdm_fs_mul[] = {
 	{ .min = 128,	.max = 128,	.mul = 256 },
 	{ .min = 256,	.max = 256,	.mul = 512 },
 	{ .min = 512,	.max = 512,	.mul = 1024 },

