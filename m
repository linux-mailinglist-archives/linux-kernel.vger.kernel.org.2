Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3EBC4336937
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Mar 2021 01:50:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229741AbhCKAtk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 10 Mar 2021 19:49:40 -0500
Received: from mga05.intel.com ([192.55.52.43]:15447 "EHLO mga05.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229546AbhCKAtU (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 Mar 2021 19:49:20 -0500
IronPort-SDR: 03qdIgP1H/qRDhJpgee68Icxsn60zSUT6UekM8RiBr+x01LELWBQESdKwHDZle/VNqwXK3izd5
 S73jSaQBSy3A==
X-IronPort-AV: E=McAfee;i="6000,8403,9919"; a="273629857"
X-IronPort-AV: E=Sophos;i="5.81,238,1610438400"; 
   d="scan'208";a="273629857"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Mar 2021 16:49:20 -0800
IronPort-SDR: xjT+db+56M2a0C/cPl5xYfXekIHi8yIzUHQwULkIFBPhKHTd24Xgjn/qDofhFvrXFpATuknXLX
 0aArc4iM1VTQ==
X-IronPort-AV: E=Sophos;i="5.81,238,1610438400"; 
   d="scan'208";a="370386798"
Received: from theer-mobl2.amr.corp.intel.com (HELO pbossart-mobl3.intel.com) ([10.212.101.109])
  by orsmga003-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Mar 2021 16:49:18 -0800
From:   Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
To:     alsa-devel@alsa-project.org
Cc:     tiwai@suse.de, broonie@kernel.org, linux-kernel@vger.kernel.org,
        Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        linux-arm-kernel@lists.infradead.org (moderated list:ARM/Mediatek SoC
        support),
        linux-mediatek@lists.infradead.org (moderated list:ARM/Mediatek SoC
        support)
Subject: [PATCH 2/4] ASoC: mediatek: mt2701: align function prototype
Date:   Wed, 10 Mar 2021 18:49:02 -0600
Message-Id: <20210311004904.121205-3-pierre-louis.bossart@linux.intel.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210311004904.121205-1-pierre-louis.bossart@linux.intel.com>
References: <20210311004904.121205-1-pierre-louis.bossart@linux.intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

cppcheck warnings:

sound/soc/mediatek/mt2701/mt2701-afe-clock-ctrl.c:102:30:
style:inconclusive: Function 'mt2701_afe_enable_i2s' argument 2 names
different: declaration 'path' definition
'i2s_path'. [funcArgNamesDifferent]
     struct mt2701_i2s_path *i2s_path,
                             ^
sound/soc/mediatek/mt2701/mt2701-afe-clock-ctrl.h:21:30: note:
Function 'mt2701_afe_enable_i2s' argument 2 names different:
declaration 'path' definition 'i2s_path'.
     struct mt2701_i2s_path *path,
                             ^
sound/soc/mediatek/mt2701/mt2701-afe-clock-ctrl.c:102:30: note:
Function 'mt2701_afe_enable_i2s' argument 2 names different:
declaration 'path' definition 'i2s_path'.

     struct mt2701_i2s_path *i2s_path,
                             ^
sound/soc/mediatek/mt2701/mt2701-afe-clock-ctrl.c:128:32:
style:inconclusive: Function 'mt2701_afe_disable_i2s' argument 2 names
different: declaration 'path' definition
'i2s_path'. [funcArgNamesDifferent]
       struct mt2701_i2s_path *i2s_path,
                               ^
sound/soc/mediatek/mt2701/mt2701-afe-clock-ctrl.h:24:32: note:
Function 'mt2701_afe_disable_i2s' argument 2 names different:
declaration 'path' definition 'i2s_path'.
       struct mt2701_i2s_path *path,
                               ^
sound/soc/mediatek/mt2701/mt2701-afe-clock-ctrl.c:128:32: note:
Function 'mt2701_afe_disable_i2s' argument 2 names different:
declaration 'path' definition 'i2s_path'.
       struct mt2701_i2s_path *i2s_path,
                               ^

Signed-off-by: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
---
 sound/soc/mediatek/mt2701/mt2701-afe-clock-ctrl.h | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/sound/soc/mediatek/mt2701/mt2701-afe-clock-ctrl.h b/sound/soc/mediatek/mt2701/mt2701-afe-clock-ctrl.h
index 580fead2ab05..0bd82fbda176 100644
--- a/sound/soc/mediatek/mt2701/mt2701-afe-clock-ctrl.h
+++ b/sound/soc/mediatek/mt2701/mt2701-afe-clock-ctrl.h
@@ -18,10 +18,10 @@ int mt2701_afe_enable_clock(struct mtk_base_afe *afe);
 int mt2701_afe_disable_clock(struct mtk_base_afe *afe);
 
 int mt2701_afe_enable_i2s(struct mtk_base_afe *afe,
-			  struct mt2701_i2s_path *path,
+			  struct mt2701_i2s_path *i2s_path,
 			  int dir);
 void mt2701_afe_disable_i2s(struct mtk_base_afe *afe,
-			    struct mt2701_i2s_path *path,
+			    struct mt2701_i2s_path *i2s_path,
 			    int dir);
 int mt2701_afe_enable_mclk(struct mtk_base_afe *afe, int id);
 void mt2701_afe_disable_mclk(struct mtk_base_afe *afe, int id);
-- 
2.25.1

