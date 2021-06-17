Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B51D53AB20A
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Jun 2021 13:12:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232389AbhFQLOX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 17 Jun 2021 07:14:23 -0400
Received: from szxga03-in.huawei.com ([45.249.212.189]:7352 "EHLO
        szxga03-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231501AbhFQLOU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Jun 2021 07:14:20 -0400
Received: from dggemv703-chm.china.huawei.com (unknown [172.30.72.53])
        by szxga03-in.huawei.com (SkyGuard) with ESMTP id 4G5K6L397xz6yGm;
        Thu, 17 Jun 2021 19:08:10 +0800 (CST)
Received: from dggemi762-chm.china.huawei.com (10.1.198.148) by
 dggemv703-chm.china.huawei.com (10.3.19.46) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256) id
 15.1.2176.2; Thu, 17 Jun 2021 19:12:10 +0800
Received: from linux-lmwb.huawei.com (10.175.103.112) by
 dggemi762-chm.china.huawei.com (10.1.198.148) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id
 15.1.2176.2; Thu, 17 Jun 2021 19:12:09 +0800
From:   Zou Wei <zou_wei@huawei.com>
To:     <lgirdwood@gmail.com>, <broonie@kernel.org>, <perex@perex.cz>,
        <tiwai@suse.com>, <thierry.reding@gmail.com>,
        <jonathanh@nvidia.com>
CC:     <alsa-devel@alsa-project.org>, <linux-tegra@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, Zou Wei <zou_wei@huawei.com>
Subject: [PATCH -next] ASoC: tegra: Fix missing clk_disable_unprepare() on error path
Date:   Thu, 17 Jun 2021 19:30:39 +0800
Message-ID: <1623929439-4289-1-git-send-email-zou_wei@huawei.com>
X-Mailer: git-send-email 2.6.2
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.175.103.112]
X-ClientProxiedBy: dggems702-chm.china.huawei.com (10.3.19.179) To
 dggemi762-chm.china.huawei.com (10.1.198.148)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fix the missing clk_disable_unprepare() before return
from tegra_machine_hw_params() in the error handling case.

Reported-by: Hulk Robot <hulkci@huawei.com>
Signed-off-by: Zou Wei <zou_wei@huawei.com>
---
 sound/soc/tegra/tegra_asoc_machine.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/sound/soc/tegra/tegra_asoc_machine.c b/sound/soc/tegra/tegra_asoc_machine.c
index a53aec3..397f326 100644
--- a/sound/soc/tegra/tegra_asoc_machine.c
+++ b/sound/soc/tegra/tegra_asoc_machine.c
@@ -306,6 +306,7 @@ static int tegra_machine_hw_params(struct snd_pcm_substream *substream,
 
 	err = snd_soc_dai_set_sysclk(codec_dai, clk_id, mclk, SND_SOC_CLOCK_IN);
 	if (err < 0) {
+		clk_disable_unprepare(machine->clk_cdev1);
 		dev_err(card->dev, "codec_dai clock not set: %d\n", err);
 		return err;
 	}
@@ -523,8 +524,10 @@ int tegra_asoc_machine_probe(struct platform_device *pdev)
 	}
 
 	err = devm_snd_soc_register_card(dev, card);
-	if (err)
+	if (err) {
+		clk_disable_unprepare(machine->clk_cdev1);
 		return err;
+	}
 
 	return 0;
 }
-- 
2.6.2

