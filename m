Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7C8AF3FE9D7
	for <lists+linux-kernel@lfdr.de>; Thu,  2 Sep 2021 09:15:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243192AbhIBHPq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 2 Sep 2021 03:15:46 -0400
Received: from mailgw01.mediatek.com ([60.244.123.138]:35260 "EHLO
        mailgw01.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S231133AbhIBHPp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Sep 2021 03:15:45 -0400
X-UUID: 59fcbcd1a388466bab211785bc791fb5-20210902
X-UUID: 59fcbcd1a388466bab211785bc791fb5-20210902
Received: from mtkcas06.mediatek.inc [(172.21.101.30)] by mailgw01.mediatek.com
        (envelope-from <trevor.wu@mediatek.com>)
        (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-SHA384 256/256)
        with ESMTP id 1633932517; Thu, 02 Sep 2021 15:14:42 +0800
Received: from mtkcas10.mediatek.inc (172.21.101.39) by
 mtkmbs05n1.mediatek.inc (172.21.101.15) with Microsoft SMTP Server (TLS) id
 15.0.1497.2; Thu, 2 Sep 2021 15:14:41 +0800
Received: from mtksdccf07.mediatek.inc (172.21.84.99) by mtkcas10.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Thu, 2 Sep 2021 15:14:41 +0800
From:   Trevor Wu <trevor.wu@mediatek.com>
To:     <broonie@kernel.org>, <tiwai@suse.com>, <matthias.bgg@gmail.com>
CC:     <trevor.wu@mediatek.com>, <alsa-devel@alsa-project.org>,
        <linux-mediatek@lists.infradead.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>
Subject: [PATCH] ASoC: mt8195: remove unnecessary CONFIG_PM
Date:   Thu, 2 Sep 2021 15:14:40 +0800
Message-ID: <20210902071440.6087-1-trevor.wu@mediatek.com>
X-Mailer: git-send-email 2.18.0
MIME-Version: 1.0
Content-Type: text/plain
X-MTK:  N
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The unnecessary conditional inclusion caused the following warning.

>> sound/soc/mediatek/mt8195/mt8195-afe-pcm.c:3260:32: warning: unused
>> variable 'mt8195_afe_pm_ops' [-Wunused-const-variable]
   static const struct dev_pm_ops mt8195_afe_pm_ops = {
                                  ^
   1 warning generated.

Because runtime_pm already handles the case without CONFIG_PM, we
can remove CONFIG_PM condition.

Fixes: 6746cc858259 ("ASoC: mediatek: mt8195: add platform driver")
Signed-off-by: Trevor Wu <trevor.wu@mediatek.com>
Reported-by: kernel test robot <lkp@intel.com>
---
 sound/soc/mediatek/mt8195/mt8195-afe-pcm.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/sound/soc/mediatek/mt8195/mt8195-afe-pcm.c b/sound/soc/mediatek/mt8195/mt8195-afe-pcm.c
index 6635c3f72ecc..f8dd50c8a7da 100644
--- a/sound/soc/mediatek/mt8195/mt8195-afe-pcm.c
+++ b/sound/soc/mediatek/mt8195/mt8195-afe-pcm.c
@@ -3266,9 +3266,7 @@ static struct platform_driver mt8195_afe_pcm_driver = {
 	.driver = {
 		   .name = "mt8195-audio",
 		   .of_match_table = mt8195_afe_pcm_dt_match,
-#ifdef CONFIG_PM
 		   .pm = &mt8195_afe_pm_ops,
-#endif
 	},
 	.probe = mt8195_afe_pcm_dev_probe,
 	.remove = mt8195_afe_pcm_dev_remove,
-- 
2.18.0

