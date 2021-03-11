Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 08C9C336934
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Mar 2021 01:50:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229704AbhCKAtj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 10 Mar 2021 19:49:39 -0500
Received: from mga05.intel.com ([192.55.52.43]:15447 "EHLO mga05.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229517AbhCKAtS (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 Mar 2021 19:49:18 -0500
IronPort-SDR: u/Uvc38HqgqgqeDhTdCJEJXyER3KLtGF5s3m7avFMfkn+Furar4kMqVRiI+kF3sxsxAzNRvYft
 EDWbFnHbZQLA==
X-IronPort-AV: E=McAfee;i="6000,8403,9919"; a="273629852"
X-IronPort-AV: E=Sophos;i="5.81,238,1610438400"; 
   d="scan'208";a="273629852"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Mar 2021 16:49:17 -0800
IronPort-SDR: J9Y1cPxBOqkMSqBlXVxAyMKHdXz3bOTZ6QWhFCYOJFXIkotC51XUhFBTXSIS5uELwiYy1VkrGk
 BC79uQFsu+/g==
X-IronPort-AV: E=Sophos;i="5.81,238,1610438400"; 
   d="scan'208";a="370386789"
Received: from theer-mobl2.amr.corp.intel.com (HELO pbossart-mobl3.intel.com) ([10.212.101.109])
  by orsmga003-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Mar 2021 16:49:16 -0800
From:   Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
To:     alsa-devel@alsa-project.org
Cc:     tiwai@suse.de, broonie@kernel.org, linux-kernel@vger.kernel.org,
        Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Lumi Lee <lumi.lee@mediatek.com>,
        linux-arm-kernel@lists.infradead.org (moderated list:ARM/Mediatek SoC
        support),
        linux-mediatek@lists.infradead.org (moderated list:ARM/Mediatek SoC
        support)
Subject: [PATCH 1/4] ASoC: mediatek: mtk-btcvsd: remove useless assignment
Date:   Wed, 10 Mar 2021 18:49:01 -0600
Message-Id: <20210311004904.121205-2-pierre-louis.bossart@linux.intel.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210311004904.121205-1-pierre-louis.bossart@linux.intel.com>
References: <20210311004904.121205-1-pierre-louis.bossart@linux.intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

cppcheck warning:

sound/soc/mediatek/common/mtk-btcvsd.c:783:34: style: Variable 'avail'
is assigned a value that is never used. [unreadVariable]
 int written_size = count, avail = 0, cur_write_idx, write_size, cont;
                                 ^

Signed-off-by: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
---
 sound/soc/mediatek/common/mtk-btcvsd.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/sound/soc/mediatek/common/mtk-btcvsd.c b/sound/soc/mediatek/common/mtk-btcvsd.c
index a554c57b6460..f85b5ea180ec 100644
--- a/sound/soc/mediatek/common/mtk-btcvsd.c
+++ b/sound/soc/mediatek/common/mtk-btcvsd.c
@@ -780,7 +780,7 @@ static ssize_t mtk_btcvsd_snd_write(struct mtk_btcvsd_snd *bt,
 				    char __user *buf,
 				    size_t count)
 {
-	int written_size = count, avail = 0, cur_write_idx, write_size, cont;
+	int written_size = count, avail, cur_write_idx, write_size, cont;
 	unsigned int cur_buf_ofs = 0;
 	unsigned long flags;
 	unsigned int packet_size = bt->tx->packet_size;
-- 
2.25.1

