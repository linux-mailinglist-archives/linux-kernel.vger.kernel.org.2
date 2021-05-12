Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A231437B498
	for <lists+linux-kernel@lfdr.de>; Wed, 12 May 2021 05:37:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230157AbhELDiY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 11 May 2021 23:38:24 -0400
Received: from szxga04-in.huawei.com ([45.249.212.190]:2712 "EHLO
        szxga04-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229848AbhELDiX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 May 2021 23:38:23 -0400
Received: from DGGEMS414-HUB.china.huawei.com (unknown [172.30.72.59])
        by szxga04-in.huawei.com (SkyGuard) with ESMTP id 4Fg0lZ2QzCz1BHkn;
        Wed, 12 May 2021 11:34:34 +0800 (CST)
Received: from linux-lmwb.huawei.com (10.175.103.112) by
 DGGEMS414-HUB.china.huawei.com (10.3.19.214) with Microsoft SMTP Server id
 14.3.498.0; Wed, 12 May 2021 11:37:05 +0800
From:   Zou Wei <zou_wei@huawei.com>
To:     <cezary.rojewski@intel.com>, <liam.r.girdwood@linux.intel.com>,
        <yang.jie@linux.intel.com>, <broonie@kernel.org>, <perex@perex.cz>,
        <tiwai@suse.com>, <kuninori.morimoto.gx@renesas.com>,
        <kai.vehmanen@linux.intel.com>, <brent.lu@intel.com>,
        <ranjani.sridharan@linux.intel.com>, <yong.zhi@intel.com>,
        <dharageswari.r@intel.com>, <sathyanarayana.nujella@intel.com>,
        <fred.oh@linux.intel.com>, <tzungbi@google.com>
CC:     <alsa-devel@alsa-project.org>, <linux-kernel@vger.kernel.org>,
        Zou Wei <zou_wei@huawei.com>
Subject: [PATCH -next] ASoC: intel/boards: add missing MODULE_DEVICE_TABLE
Date:   Wed, 12 May 2021 11:54:07 +0800
Message-ID: <1620791647-16024-1-git-send-email-zou_wei@huawei.com>
X-Mailer: git-send-email 2.6.2
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.175.103.112]
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch adds missing MODULE_DEVICE_TABLE definition which generates
correct modalias for automatic loading of this driver when it is built
as an external module.

Reported-by: Hulk Robot <hulkci@huawei.com>
Signed-off-by: Zou Wei <zou_wei@huawei.com>
---
 sound/soc/intel/boards/sof_da7219_max98373.c | 1 +
 sound/soc/intel/boards/sof_rt5682.c          | 1 +
 2 files changed, 2 insertions(+)

diff --git a/sound/soc/intel/boards/sof_da7219_max98373.c b/sound/soc/intel/boards/sof_da7219_max98373.c
index f3cb077..8d1ad89 100644
--- a/sound/soc/intel/boards/sof_da7219_max98373.c
+++ b/sound/soc/intel/boards/sof_da7219_max98373.c
@@ -440,6 +440,7 @@ static const struct platform_device_id board_ids[] = {
 	},
 	{ }
 };
+MODULE_DEVICE_TABLE(platform, board_ids);
 
 static struct platform_driver audio = {
 	.probe = audio_probe,
diff --git a/sound/soc/intel/boards/sof_rt5682.c b/sound/soc/intel/boards/sof_rt5682.c
index 58548ea..cf1d053 100644
--- a/sound/soc/intel/boards/sof_rt5682.c
+++ b/sound/soc/intel/boards/sof_rt5682.c
@@ -968,6 +968,7 @@ static const struct platform_device_id board_ids[] = {
 	},
 	{ }
 };
+MODULE_DEVICE_TABLE(platform, board_ids);
 
 static struct platform_driver sof_audio = {
 	.probe = sof_audio_probe,
-- 
2.6.2

