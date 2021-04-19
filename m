Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2A3D6364668
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Apr 2021 16:49:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240546AbhDSOty (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 19 Apr 2021 10:49:54 -0400
Received: from smtp2.axis.com ([195.60.68.18]:50156 "EHLO smtp2.axis.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S240158AbhDSOtx (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Apr 2021 10:49:53 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=axis.com; q=dns/txt; s=axis-central1; t=1618843764;
  x=1650379764;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=F30/4eiH7brWbI8t9xr+MZ7JMcUC/A1wIc2/IxYEU2A=;
  b=IcZ17gHmk9+8Vu4VYsTWMrNUINf6g7WBwhSqpu4VZB/d83ccJYCfjF9R
   r7l0FjLdWNtsOaNlT7SAzUsUSZt81Ez7W1uVkjGRb7UCa/3i7wlNO5Zn+
   qfpjF9D+jhZNS5oe/NCwe636XGlzv/kEgEIhFsNxUyjCmLeTk9lTqXv7H
   tOBTVjVqRsqDweHiGDVrYZnc0/ts3e5s1un4nf7m3B9KjOACHLIInxrwr
   LfqBg4ejxohwV3UU4fK2D7pXlTYThu25oB4WpoCxvP1fZAZCAoIz3xH/l
   yi3oRxyNyw1UaM8FmpY69q429jr/KCAVfWxXeA2pEfK/QFTnBYSOGqbtt
   A==;
From:   Niklas Carlsson <Niklas.Carlsson@axis.com>
To:     Lars-Peter Clausen <lars@metafoo.de>,
        =?UTF-8?q?Nuno=20S=C3=A1?= <nuno.sa@analog.com>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>
CC:     <kernel@axis.com>, Niklas Carlsson <niklasc@axis.com>,
        <alsa-devel@alsa-project.org>, <linux-kernel@vger.kernel.org>
Subject: [PATCH] ASoC: sigmadsp: Disable cache mechanism for readbacks
Date:   Mon, 19 Apr 2021 16:49:01 +0200
Message-ID: <20210419144901.9441-1-Niklas.Carlsson@axis.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Niklas Carlsson <niklasc@axis.com>

The ALSA control readback functionality only works for non-volatile
controls, i.e. control values that does not change on their own without
driver interaction.

This doesn't work for readbacks since the DSP firmware updates the
control value. Disable the cache mechanism in the driver if the control
name matches the prefix used for readbacks to ensure that the control
value is valid.

Signed-off-by: Niklas Carlsson <niklasc@axis.com>
---
 sound/soc/codecs/sigmadsp.c | 18 ++++++++++++++++--
 1 file changed, 16 insertions(+), 2 deletions(-)

diff --git a/sound/soc/codecs/sigmadsp.c b/sound/soc/codecs/sigmadsp.c
index 76c77dc8ecf7..b992216aee55 100644
--- a/sound/soc/codecs/sigmadsp.c
+++ b/sound/soc/codecs/sigmadsp.c
@@ -24,6 +24,8 @@
 #define SIGMA_FW_CHUNK_TYPE_CONTROL 1
 #define SIGMA_FW_CHUNK_TYPE_SAMPLERATES 2
 
+#define READBACK_CTRL_NAME "ReadBack"
+
 struct sigmadsp_control {
 	struct list_head head;
 	uint32_t samplerates;
@@ -31,6 +33,7 @@ struct sigmadsp_control {
 	unsigned int num_bytes;
 	const char *name;
 	struct snd_kcontrol *kcontrol;
+	bool is_readback;
 	bool cached;
 	uint8_t cache[];
 };
@@ -141,7 +144,8 @@ static int sigmadsp_ctrl_put(struct snd_kcontrol *kcontrol,
 
 	if (ret == 0) {
 		memcpy(ctrl->cache, data, ctrl->num_bytes);
-		ctrl->cached = true;
+		if (!ctrl->is_readback)
+			ctrl->cached = true;
 	}
 
 	mutex_unlock(&sigmadsp->lock);
@@ -164,7 +168,8 @@ static int sigmadsp_ctrl_get(struct snd_kcontrol *kcontrol,
 	}
 
 	if (ret == 0) {
-		ctrl->cached = true;
+		if (!ctrl->is_readback)
+			ctrl->cached = true;
 		memcpy(ucontrol->value.bytes.data, ctrl->cache,
 			ctrl->num_bytes);
 	}
@@ -231,6 +236,15 @@ static int sigma_fw_load_control(struct sigmadsp *sigmadsp,
 	name[name_len] = '\0';
 	ctrl->name = name;
 
+	/*
+	 * Readbacks doesn't work with non-volatile controls, since the
+	 * firmware updates the control value without driver interaction. Mark
+	 * the readbacks to ensure that the values are not cached.
+	 */
+	if (ctrl->name && strncmp(ctrl->name, READBACK_CTRL_NAME,
+				  (sizeof(READBACK_CTRL_NAME) - 1)) == 0)
+		ctrl->is_readback = true;
+
 	ctrl->addr = le16_to_cpu(ctrl_chunk->addr);
 	ctrl->num_bytes = num_bytes;
 	ctrl->samplerates = le32_to_cpu(chunk->samplerates);
-- 
2.20.1

