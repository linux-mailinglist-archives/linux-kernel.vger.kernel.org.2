Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 73E5F3201DF
	for <lists+linux-kernel@lfdr.de>; Sat, 20 Feb 2021 00:35:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229868AbhBSXdl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 19 Feb 2021 18:33:41 -0500
Received: from mga05.intel.com ([192.55.52.43]:58069 "EHLO mga05.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229683AbhBSXde (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 19 Feb 2021 18:33:34 -0500
IronPort-SDR: hM3egxQtuQpbL8HwhvkI+5iTQA7ijNqTKzAXASsxX9EjNemd7iCiGzMp9HRl/eKNzbwx97LEHq
 MuO8K/Zh7UYg==
X-IronPort-AV: E=McAfee;i="6000,8403,9900"; a="268854810"
X-IronPort-AV: E=Sophos;i="5.81,191,1610438400"; 
   d="scan'208";a="268854810"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Feb 2021 15:30:33 -0800
IronPort-SDR: bxr+gzwgM2EC+z4ap7Hb+/HcDrWux+W4ok+Ahl1lfXgyD60R2ze65NVztQwV/6ifUdACv2ULlc
 cdSrRk0p4Pnw==
X-IronPort-AV: E=Sophos;i="5.81,191,1610438400"; 
   d="scan'208";a="496662659"
Received: from lkwerake-mobl1.amr.corp.intel.com (HELO pbossart-mobl3.intel.com) ([10.251.153.34])
  by fmsmga001-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Feb 2021 15:30:31 -0800
From:   Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
To:     alsa-devel@alsa-project.org
Cc:     tiwai@suse.de, broonie@kernel.org, linux-kernel@vger.kernel.org,
        Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>,
        Timur Tabi <timur@kernel.org>,
        Nicolin Chen <nicoleotsuka@gmail.com>,
        Xiubo Li <Xiubo.Lee@gmail.com>,
        Fabio Estevam <festevam@gmail.com>,
        Shengjiu Wang <shengjiu.wang@gmail.com>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>,
        linuxppc-dev@lists.ozlabs.org (open list:FREESCALE SOC SOUND DRIVERS)
Subject: [PATCH 3/9] ASoC: fsl: fsl_easrc: remove useless assignments
Date:   Fri, 19 Feb 2021 17:29:31 -0600
Message-Id: <20210219232937.6440-4-pierre-louis.bossart@linux.intel.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210219232937.6440-1-pierre-louis.bossart@linux.intel.com>
References: <20210219232937.6440-1-pierre-louis.bossart@linux.intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

cppcheck warnings:

sound/soc/fsl/fsl_easrc.c:751:53: style: Variable 'st2_mem_alloc' is
assigned a value that is never used. [unreadVariable]
 int st1_chanxexp, st1_mem_alloc = 0, st2_mem_alloc = 0;
                                                    ^
sound/soc/fsl/fsl_easrc.c:1331:11: style: Variable 'size' is assigned
a value that is never used. [unreadVariable]
 int size = 0;
          ^

Signed-off-by: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
---
 sound/soc/fsl/fsl_easrc.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/sound/soc/fsl/fsl_easrc.c b/sound/soc/fsl/fsl_easrc.c
index 636a702f37a6..725a5d3aaa02 100644
--- a/sound/soc/fsl/fsl_easrc.c
+++ b/sound/soc/fsl/fsl_easrc.c
@@ -710,7 +710,7 @@ static int fsl_easrc_max_ch_for_slot(struct fsl_asrc_pair *ctx,
 				     struct fsl_easrc_slot *slot)
 {
 	struct fsl_easrc_ctx_priv *ctx_priv = ctx->private;
-	int st1_mem_alloc = 0, st2_mem_alloc = 0;
+	int st1_mem_alloc = 0, st2_mem_alloc;
 	int pf_mem_alloc = 0;
 	int max_channels = 8 - slot->num_channel;
 	int channels = 0;
@@ -748,7 +748,7 @@ static int fsl_easrc_config_one_slot(struct fsl_asrc_pair *ctx,
 {
 	struct fsl_asrc *easrc = ctx->asrc;
 	struct fsl_easrc_ctx_priv *ctx_priv = ctx->private;
-	int st1_chanxexp, st1_mem_alloc = 0, st2_mem_alloc = 0;
+	int st1_chanxexp, st1_mem_alloc = 0, st2_mem_alloc;
 	unsigned int reg0, reg1, reg2, reg3;
 	unsigned int addr;
 
@@ -1328,7 +1328,7 @@ static int fsl_easrc_stop_context(struct fsl_asrc_pair *ctx)
 {
 	struct fsl_asrc *easrc = ctx->asrc;
 	int val, i;
-	int size = 0;
+	int size;
 	int retry = 200;
 
 	regmap_read(easrc->regmap, REG_EASRC_CC(ctx->index), &val);
-- 
2.25.1

