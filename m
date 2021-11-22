Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4EA17459358
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Nov 2021 17:47:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240406AbhKVQuH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 22 Nov 2021 11:50:07 -0500
Received: from mailgw01.mediatek.com ([60.244.123.138]:36322 "EHLO
        mailgw01.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S240387AbhKVQuD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 Nov 2021 11:50:03 -0500
X-UUID: ac4f7cbb802e471388ecc782571d467c-20211123
X-UUID: ac4f7cbb802e471388ecc782571d467c-20211123
Received: from mtkcas10.mediatek.inc [(172.21.101.39)] by mailgw01.mediatek.com
        (envelope-from <jiaxin.yu@mediatek.com>)
        (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-SHA384 256/256)
        with ESMTP id 819529126; Tue, 23 Nov 2021 00:46:54 +0800
Received: from mtkexhb01.mediatek.inc (172.21.101.102) by
 mtkmbs07n2.mediatek.inc (172.21.101.141) with Microsoft SMTP Server (TLS) id
 15.0.1497.2; Tue, 23 Nov 2021 00:46:53 +0800
Received: from mtkcas11.mediatek.inc (172.21.101.40) by mtkexhb01.mediatek.inc
 (172.21.101.102) with Microsoft SMTP Server (TLS) id 15.0.1497.2; Tue, 23 Nov
 2021 00:46:53 +0800
Received: from mhfsdcap04.gcn.mediatek.inc (10.17.3.154) by
 mtkcas11.mediatek.inc (172.21.101.73) with Microsoft SMTP Server id
 15.0.1497.2 via Frontend Transport; Tue, 23 Nov 2021 00:46:52 +0800
From:   Jiaxin Yu <jiaxin.yu@mediatek.com>
To:     <broonie@kernel.org>, <matthias.bgg@gmail.com>
CC:     <tzungbi@google.com>, <alsa-devel@alsa-project.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-mediatek@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, Jiaxin Yu <jiaxin.yu@mediatek.com>,
        "kernel test robot" <lkp@intel.com>
Subject: [PATCH] ASoC: mt8192: remove unnecessary CONFIG_PM
Date:   Tue, 23 Nov 2021 00:46:44 +0800
Message-ID: <20211122164644.19442-2-jiaxin.yu@mediatek.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20211122164644.19442-1-jiaxin.yu@mediatek.com>
References: <20211122164644.19442-1-jiaxin.yu@mediatek.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-MTK:  N
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The unnecessary conditional inclusion caused the following warning.

>> sound/soc/mediatek/mt8192/mt8192-afe-pcm.c:2368:32: warning: unused
>> variable 'mt8192_afe_pm_ops' [-Wunused-const-variable]
   static const struct dev_pm_ops mt8192_afe_pm_ops = {

Because runtime_pm already handles the case without CONFIG_PM, we
can remove CONFIG_PM condition.

Signed-off-by: Jiaxin Yu <jiaxin.yu@mediatek.com>
Reported-by: kernel test robot <lkp@intel.com>
---
 sound/soc/mediatek/mt8192/mt8192-afe-pcm.c | 2 --
 1 file changed, 2 deletions(-)

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

