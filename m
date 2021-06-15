Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0F76F3A7D3D
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Jun 2021 13:32:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230208AbhFOLen (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 15 Jun 2021 07:34:43 -0400
Received: from szxga01-in.huawei.com ([45.249.212.187]:4786 "EHLO
        szxga01-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229557AbhFOLem (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Jun 2021 07:34:42 -0400
Received: from dggemv711-chm.china.huawei.com (unknown [172.30.72.53])
        by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4G45df6YCJzXg5V;
        Tue, 15 Jun 2021 19:27:34 +0800 (CST)
Received: from dggpemm500019.china.huawei.com (7.185.36.180) by
 dggemv711-chm.china.huawei.com (10.1.198.66) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2176.2; Tue, 15 Jun 2021 19:32:34 +0800
Received: from ubuntu1804.huawei.com (10.67.174.98) by
 dggpemm500019.china.huawei.com (7.185.36.180) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2176.2; Tue, 15 Jun 2021 19:32:34 +0800
From:   Pu Lehui <pulehui@huawei.com>
To:     <lgirdwood@gmail.com>, <broonie@kernel.org>, <perex@perex.cz>,
        <tiwai@suse.com>, <srinivas.kandagatla@linaro.org>,
        <sfr@canb.auug.org.au>
CC:     <alsa-devel@alsa-project.org>, <linux-kernel@vger.kernel.org>,
        <pulehui@huawei.com>, <zhangjinhao2@huawei.com>
Subject: [PATCH -next] ASoC: codecs: wcd938x: constify static struct snd_soc_dai_ops
Date:   Tue, 15 Jun 2021 19:33:24 +0800
Message-ID: <20210615113324.238837-1-pulehui@huawei.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.67.174.98]
X-ClientProxiedBy: dggems703-chm.china.huawei.com (10.3.19.180) To
 dggpemm500019.china.huawei.com (7.185.36.180)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The snd_soc_dai_ops structures is only stored in the ops field of a
snd_soc_dai_driver structure, so make the snd_soc_dai_ops structure
const to allow the compiler to put it in read-only memory.

Signed-off-by: Pu Lehui <pulehui@huawei.com>
---
 sound/soc/codecs/wcd938x.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/sound/soc/codecs/wcd938x.c b/sound/soc/codecs/wcd938x.c
index 2cf6145b7219..8ec9357fd855 100644
--- a/sound/soc/codecs/wcd938x.c
+++ b/sound/soc/codecs/wcd938x.c
@@ -3425,7 +3425,7 @@ static int wcd938x_codec_set_sdw_stream(struct snd_soc_dai *dai,
 
 }
 
-static struct snd_soc_dai_ops wcd938x_sdw_dai_ops = {
+static const struct snd_soc_dai_ops wcd938x_sdw_dai_ops = {
 	.hw_params = wcd938x_codec_hw_params,
 	.hw_free = wcd938x_codec_free,
 	.set_sdw_stream = wcd938x_codec_set_sdw_stream,
-- 
2.17.1

