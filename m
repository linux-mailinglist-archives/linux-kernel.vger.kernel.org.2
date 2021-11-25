Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0C3D645D3EA
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Nov 2021 05:26:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240258AbhKYE3o (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 24 Nov 2021 23:29:44 -0500
Received: from mailgw01.mediatek.com ([60.244.123.138]:58334 "EHLO
        mailgw01.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S239315AbhKYE1n (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Nov 2021 23:27:43 -0500
X-UUID: d7268dbebc954e7fb2a094e9e93a9b8d-20211125
X-UUID: d7268dbebc954e7fb2a094e9e93a9b8d-20211125
Received: from mtkexhb01.mediatek.inc [(172.21.101.102)] by mailgw01.mediatek.com
        (envelope-from <jiaxin.yu@mediatek.com>)
        (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-SHA384 256/256)
        with ESMTP id 1768316012; Thu, 25 Nov 2021 12:24:28 +0800
Received: from mtkcas10.mediatek.inc (172.21.101.39) by
 mtkmbs10n2.mediatek.inc (172.21.101.183) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id 15.2.792.3;
 Thu, 25 Nov 2021 12:24:27 +0800
Received: from mhfsdcap04.gcn.mediatek.inc (10.17.3.154) by
 mtkcas10.mediatek.inc (172.21.101.73) with Microsoft SMTP Server id
 15.0.1497.2 via Frontend Transport; Thu, 25 Nov 2021 12:24:26 +0800
From:   Jiaxin Yu <jiaxin.yu@mediatek.com>
To:     <broonie@kernel.org>, <matthias.bgg@gmail.com>,
        <tzungbi@google.com>, <garlic.tseng@mediatek.com>,
        <kaichieh.chuang@mediatek.com>
CC:     <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-mediatek@lists.infradead.org>,
        <alsa-devel@alsa-project.org>,
        "Jiaxin Yu" <jiaxin.yu@mediatek.com>,
        kernel test robot <lkp@intel.com>
Subject: [PATCH] ASoC: mediatek: remove unnecessary CONFIG_PM
Date:   Thu, 25 Nov 2021 12:24:22 +0800
Message-ID: <20211125042422.2349-1-jiaxin.yu@mediatek.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-MTK:  N
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The unnecessary conditional inclusion caused the following warning.

Such as:
>> sound/soc/mediatek/mt8192/mt8192-afe-pcm.c:2368:32: warning: unused
>> variable 'mt8192_afe_pm_ops' [-Wunused-const-variable]
   static const struct dev_pm_ops mt8192_afe_pm_ops = {

Because runtime_pm already handles the case without CONFIG_PM, we
can remove CONFIG_PM condition.

Signed-off-by: Jiaxin Yu <jiaxin.yu@mediatek.com>
Reported-by: kernel test robot <lkp@intel.com>
---
 sound/soc/mediatek/mt2701/mt2701-afe-pcm.c       | 2 --
 sound/soc/mediatek/mt6797/mt6797-afe-pcm.c       | 2 --
 sound/soc/mediatek/mt8173/mt8173-max98090.c      | 2 --
 sound/soc/mediatek/mt8173/mt8173-rt5650-rt5514.c | 2 --
 sound/soc/mediatek/mt8173/mt8173-rt5650-rt5676.c | 2 --
 sound/soc/mediatek/mt8173/mt8173-rt5650.c        | 2 --
 sound/soc/mediatek/mt8183/mt8183-afe-pcm.c       | 2 --
 sound/soc/mediatek/mt8192/mt8192-afe-pcm.c       | 2 --
 8 files changed, 16 deletions(-)

diff --git a/sound/soc/mediatek/mt2701/mt2701-afe-pcm.c b/sound/soc/mediatek/mt2701/mt2701-afe-pcm.c
index bc3d0466472b..0f178de92a0f 100644
--- a/sound/soc/mediatek/mt2701/mt2701-afe-pcm.c
+++ b/sound/soc/mediatek/mt2701/mt2701-afe-pcm.c
@@ -1474,9 +1474,7 @@ static struct platform_driver mt2701_afe_pcm_driver = {
 	.driver = {
 		   .name = "mt2701-audio",
 		   .of_match_table = mt2701_afe_pcm_dt_match,
-#ifdef CONFIG_PM
 		   .pm = &mt2701_afe_pm_ops,
-#endif
 	},
 	.probe = mt2701_afe_pcm_dev_probe,
 	.remove = mt2701_afe_pcm_dev_remove,
diff --git a/sound/soc/mediatek/mt6797/mt6797-afe-pcm.c b/sound/soc/mediatek/mt6797/mt6797-afe-pcm.c
index 3d68e4726ea2..fb4abec9aa5f 100644
--- a/sound/soc/mediatek/mt6797/mt6797-afe-pcm.c
+++ b/sound/soc/mediatek/mt6797/mt6797-afe-pcm.c
@@ -901,9 +901,7 @@ static struct platform_driver mt6797_afe_pcm_driver = {
 	.driver = {
 		   .name = "mt6797-audio",
 		   .of_match_table = mt6797_afe_pcm_dt_match,
-#ifdef CONFIG_PM
 		   .pm = &mt6797_afe_pm_ops,
-#endif
 	},
 	.probe = mt6797_afe_pcm_dev_probe,
 	.remove = mt6797_afe_pcm_dev_remove,
diff --git a/sound/soc/mediatek/mt8173/mt8173-max98090.c b/sound/soc/mediatek/mt8173/mt8173-max98090.c
index fc94314bfc02..2408c9d3d9b3 100644
--- a/sound/soc/mediatek/mt8173/mt8173-max98090.c
+++ b/sound/soc/mediatek/mt8173/mt8173-max98090.c
@@ -193,9 +193,7 @@ static struct platform_driver mt8173_max98090_driver = {
 	.driver = {
 		   .name = "mt8173-max98090",
 		   .of_match_table = mt8173_max98090_dt_match,
-#ifdef CONFIG_PM
 		   .pm = &snd_soc_pm_ops,
-#endif
 	},
 	.probe = mt8173_max98090_dev_probe,
 };
diff --git a/sound/soc/mediatek/mt8173/mt8173-rt5650-rt5514.c b/sound/soc/mediatek/mt8173/mt8173-rt5650-rt5514.c
index 0f28dc2217c0..e6e824f3d24a 100644
--- a/sound/soc/mediatek/mt8173/mt8173-rt5650-rt5514.c
+++ b/sound/soc/mediatek/mt8173/mt8173-rt5650-rt5514.c
@@ -231,9 +231,7 @@ static struct platform_driver mt8173_rt5650_rt5514_driver = {
 	.driver = {
 		   .name = "mtk-rt5650-rt5514",
 		   .of_match_table = mt8173_rt5650_rt5514_dt_match,
-#ifdef CONFIG_PM
 		   .pm = &snd_soc_pm_ops,
-#endif
 	},
 	.probe = mt8173_rt5650_rt5514_dev_probe,
 };
diff --git a/sound/soc/mediatek/mt8173/mt8173-rt5650-rt5676.c b/sound/soc/mediatek/mt8173/mt8173-rt5650-rt5676.c
index 077c6ee06780..ba6fe3d90bfc 100644
--- a/sound/soc/mediatek/mt8173/mt8173-rt5650-rt5676.c
+++ b/sound/soc/mediatek/mt8173/mt8173-rt5650-rt5676.c
@@ -298,9 +298,7 @@ static struct platform_driver mt8173_rt5650_rt5676_driver = {
 	.driver = {
 		   .name = "mtk-rt5650-rt5676",
 		   .of_match_table = mt8173_rt5650_rt5676_dt_match,
-#ifdef CONFIG_PM
 		   .pm = &snd_soc_pm_ops,
-#endif
 	},
 	.probe = mt8173_rt5650_rt5676_dev_probe,
 };
diff --git a/sound/soc/mediatek/mt8173/mt8173-rt5650.c b/sound/soc/mediatek/mt8173/mt8173-rt5650.c
index 2cbf679f5c74..9b933cce0b20 100644
--- a/sound/soc/mediatek/mt8173/mt8173-rt5650.c
+++ b/sound/soc/mediatek/mt8173/mt8173-rt5650.c
@@ -336,9 +336,7 @@ static struct platform_driver mt8173_rt5650_driver = {
 	.driver = {
 		   .name = "mtk-rt5650",
 		   .of_match_table = mt8173_rt5650_dt_match,
-#ifdef CONFIG_PM
 		   .pm = &snd_soc_pm_ops,
-#endif
 	},
 	.probe = mt8173_rt5650_dev_probe,
 };
diff --git a/sound/soc/mediatek/mt8183/mt8183-afe-pcm.c b/sound/soc/mediatek/mt8183/mt8183-afe-pcm.c
index 14e77df06b01..86c8a523fe9e 100644
--- a/sound/soc/mediatek/mt8183/mt8183-afe-pcm.c
+++ b/sound/soc/mediatek/mt8183/mt8183-afe-pcm.c
@@ -1279,9 +1279,7 @@ static struct platform_driver mt8183_afe_pcm_driver = {
 	.driver = {
 		   .name = "mt8183-audio",
 		   .of_match_table = mt8183_afe_pcm_dt_match,
-#ifdef CONFIG_PM
 		   .pm = &mt8183_afe_pm_ops,
-#endif
 	},
 	.probe = mt8183_afe_pcm_dev_probe,
 	.remove = mt8183_afe_pcm_dev_remove,
diff --git a/sound/soc/mediatek/mt8192/mt8192-afe-pcm.c b/sound/soc/mediatek/mt8192/mt8192-afe-pcm.c
index 31c280339c50..e1e4ca931551 100644
--- a/sound/soc/mediatek/mt8192/mt8192-afe-pcm.c
+++ b/sound/soc/mediatek/mt8192/mt8192-afe-pcm.c
@@ -2381,9 +2381,7 @@ static struct platform_driver mt8192_afe_pcm_driver = {
 	.driver = {
 		   .name = "mt8192-audio",
 		   .of_match_table = mt8192_afe_pcm_dt_match,
-#ifdef CONFIG_PM
 		   .pm = &mt8192_afe_pm_ops,
-#endif
 	},
 	.probe = mt8192_afe_pcm_dev_probe,
 	.remove = mt8192_afe_pcm_dev_remove,
-- 
2.25.1

