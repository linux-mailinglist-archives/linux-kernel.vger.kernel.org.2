Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6253532BD12
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Mar 2021 23:13:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1448053AbhCCPRV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 3 Mar 2021 10:17:21 -0500
Received: from youngberry.canonical.com ([91.189.89.112]:58334 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240619AbhCCK3G (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 Mar 2021 05:29:06 -0500
Received: from 1.general.cking.uk.vpn ([10.172.193.212] helo=localhost)
        by youngberry.canonical.com with esmtpsa (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.86_2)
        (envelope-from <colin.king@canonical.com>)
        id 1lHNeO-0007ZG-6W; Wed, 03 Mar 2021 09:18:36 +0000
From:   Colin King <colin.king@canonical.com>
To:     Timur Tabi <timur@kernel.org>,
        Nicolin Chen <nicoleotsuka@gmail.com>,
        Xiubo Li <Xiubo.Lee@gmail.com>,
        Fabio Estevam <festevam@gmail.com>,
        Shengjiu Wang <shengjiu.wang@gmail.com>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>,
        Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>,
        alsa-devel@alsa-project.org, linuxppc-dev@lists.ozlabs.org
Cc:     kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH][next] ASoC: fsl: fsl_easrc: Fix uninitialized variable st2_mem_alloc
Date:   Wed,  3 Mar 2021 09:18:35 +0000
Message-Id: <20210303091835.5024-1-colin.king@canonical.com>
X-Mailer: git-send-email 2.30.0
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Colin Ian King <colin.king@canonical.com>

A previous cleanup commit removed the ininitialization of st2_mem_alloc.
Fix this by restoring the original behaviour by initializing it to zero.

Addresses-Coverity: ("Uninitialized scalar variable")
Fixes: e80382fe721f ("ASoC: fsl: fsl_easrc: remove useless assignments")
Signed-off-by: Colin Ian King <colin.king@canonical.com>
---
 sound/soc/fsl/fsl_easrc.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/sound/soc/fsl/fsl_easrc.c b/sound/soc/fsl/fsl_easrc.c
index 725a5d3aaa02..e823c9c13764 100644
--- a/sound/soc/fsl/fsl_easrc.c
+++ b/sound/soc/fsl/fsl_easrc.c
@@ -710,7 +710,7 @@ static int fsl_easrc_max_ch_for_slot(struct fsl_asrc_pair *ctx,
 				     struct fsl_easrc_slot *slot)
 {
 	struct fsl_easrc_ctx_priv *ctx_priv = ctx->private;
-	int st1_mem_alloc = 0, st2_mem_alloc;
+	int st1_mem_alloc = 0, st2_mem_alloc = 0;
 	int pf_mem_alloc = 0;
 	int max_channels = 8 - slot->num_channel;
 	int channels = 0;
-- 
2.30.0

