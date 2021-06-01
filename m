Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0EC2939718F
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Jun 2021 12:35:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233409AbhFAKg7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 1 Jun 2021 06:36:59 -0400
Received: from youngberry.canonical.com ([91.189.89.112]:40017 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231610AbhFAKgx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Jun 2021 06:36:53 -0400
Received: from 1.general.cking.uk.vpn ([10.172.193.212] helo=localhost)
        by youngberry.canonical.com with esmtpsa  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256
        (Exim 4.93)
        (envelope-from <colin.king@canonical.com>)
        id 1lo1jm-0000fi-9e; Tue, 01 Jun 2021 10:35:06 +0000
From:   Colin King <colin.king@canonical.com>
To:     Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>, alsa-devel@alsa-project.org
Cc:     kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] ASoC: topology: Fix spelling mistake "vesion" -> "version"
Date:   Tue,  1 Jun 2021 11:35:06 +0100
Message-Id: <20210601103506.9477-1-colin.king@canonical.com>
X-Mailer: git-send-email 2.31.1
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Colin Ian King <colin.king@canonical.com>

There are spelling mistakes in comments. Fix them.

Signed-off-by: Colin Ian King <colin.king@canonical.com>
---
 sound/soc/soc-topology.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/sound/soc/soc-topology.c b/sound/soc/soc-topology.c
index 5e65b72910e9..0a24d0d409d2 100644
--- a/sound/soc/soc-topology.c
+++ b/sound/soc/soc-topology.c
@@ -1881,7 +1881,7 @@ static void stream_caps_new_ver(struct snd_soc_tplg_stream_caps *dest,
  * @src: older version of pcm as a source
  * @pcm: latest version of pcm created from the source
  *
- * Support from vesion 4. User should free the returned pcm manually.
+ * Support from version 4. User should free the returned pcm manually.
  */
 static int pcm_new_ver(struct soc_tplg *tplg,
 		       struct snd_soc_tplg_pcm *src,
@@ -2069,7 +2069,7 @@ static void set_link_hw_format(struct snd_soc_dai_link *link,
  * @src: old version of phyical link config as a source
  * @link: latest version of physical link config created from the source
  *
- * Support from vesion 4. User need free the returned link config manually.
+ * Support from version 4. User need free the returned link config manually.
  */
 static int link_new_ver(struct soc_tplg *tplg,
 			struct snd_soc_tplg_link_config *src,
@@ -2380,7 +2380,7 @@ static int soc_tplg_dai_elems_load(struct soc_tplg *tplg,
  * @src: old version of manifest as a source
  * @manifest: latest version of manifest created from the source
  *
- * Support from vesion 4. Users need free the returned manifest manually.
+ * Support from version 4. Users need free the returned manifest manually.
  */
 static int manifest_new_ver(struct soc_tplg *tplg,
 			    struct snd_soc_tplg_manifest *src,
-- 
2.31.1

