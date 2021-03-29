Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0FA4334D349
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Mar 2021 17:06:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229873AbhC2PFy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 29 Mar 2021 11:05:54 -0400
Received: from szxga05-in.huawei.com ([45.249.212.191]:15033 "EHLO
        szxga05-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229822AbhC2PFi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 Mar 2021 11:05:38 -0400
Received: from DGGEMS414-HUB.china.huawei.com (unknown [172.30.72.60])
        by szxga05-in.huawei.com (SkyGuard) with ESMTP id 4F8G692hljzPm24;
        Mon, 29 Mar 2021 23:02:57 +0800 (CST)
Received: from localhost (10.174.179.96) by DGGEMS414-HUB.china.huawei.com
 (10.3.19.214) with Microsoft SMTP Server id 14.3.498.0; Mon, 29 Mar 2021
 23:05:26 +0800
From:   YueHaibing <yuehaibing@huawei.com>
To:     <lgirdwood@gmail.com>, <broonie@kernel.org>, <perex@perex.cz>,
        <tiwai@suse.com>, <yuehaibing@huawei.com>
CC:     <alsa-devel@alsa-project.org>, <linux-kernel@vger.kernel.org>
Subject: [PATCH -next] ASoC: dwc: Fix -Wmissing-prototypes warnings
Date:   Mon, 29 Mar 2021 23:05:24 +0800
Message-ID: <20210329150524.18184-1-yuehaibing@huawei.com>
X-Mailer: git-send-email 2.10.2.windows.1
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.174.179.96]
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

while CONFIG_SND_DESIGNWARE_PCM is not set, building with W=1 shows this:

sound/soc/dwc/local.h:127:6: warning: no previous prototype for ‘dw_pcm_push_tx’ [-Wmissing-prototypes]
 void dw_pcm_push_tx(struct dw_i2s_dev *dev) { }
      ^~~~~~~~~~~~~~
sound/soc/dwc/local.h:128:6: warning: no previous prototype for ‘dw_pcm_pop_rx’ [-Wmissing-prototypes]
 void dw_pcm_pop_rx(struct dw_i2s_dev *dev) { }
      ^~~~~~~~~~~~~
sound/soc/dwc/local.h:129:5: warning: no previous prototype for ‘dw_pcm_register’ [-Wmissing-prototypes]
 int dw_pcm_register(struct platform_device *pdev)
     ^~~~~~~~~~~~~~~

Change these to inline functions to fix the warnings.

Signed-off-by: YueHaibing <yuehaibing@huawei.com>
---
 sound/soc/dwc/local.h | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/sound/soc/dwc/local.h b/sound/soc/dwc/local.h
index 91dc70a826f8..1c361eb6127e 100644
--- a/sound/soc/dwc/local.h
+++ b/sound/soc/dwc/local.h
@@ -124,9 +124,9 @@ void dw_pcm_push_tx(struct dw_i2s_dev *dev);
 void dw_pcm_pop_rx(struct dw_i2s_dev *dev);
 int dw_pcm_register(struct platform_device *pdev);
 #else
-void dw_pcm_push_tx(struct dw_i2s_dev *dev) { }
-void dw_pcm_pop_rx(struct dw_i2s_dev *dev) { }
-int dw_pcm_register(struct platform_device *pdev)
+static inline void dw_pcm_push_tx(struct dw_i2s_dev *dev) { }
+static inline void dw_pcm_pop_rx(struct dw_i2s_dev *dev) { }
+static inline int dw_pcm_register(struct platform_device *pdev)
 {
 	return -EINVAL;
 }
-- 
2.17.1

