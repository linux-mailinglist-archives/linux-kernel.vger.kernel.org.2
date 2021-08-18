Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C94C23EF780
	for <lists+linux-kernel@lfdr.de>; Wed, 18 Aug 2021 03:27:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235348AbhHRB1u (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 17 Aug 2021 21:27:50 -0400
Received: from mail.kernel.org ([198.145.29.99]:44150 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233027AbhHRB1u (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Aug 2021 21:27:50 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 1B35460F39;
        Wed, 18 Aug 2021 01:27:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1629250036;
        bh=6umufkupZidmynwTF8CLpbrl5W5XUPPk6l7b1ADZ4cc=;
        h=From:To:Cc:Subject:Date:From;
        b=ZAL2F178ez1XrnzI3G2uBkssO/P4/L4VHm4pBBDUZ8HTktG/s0pR2+NxgmiJeUz50
         5UqP2N2X3XvDwCVrnvbvtQBalSb2iGYm+lPD5z57F3fjL8Em4BxHEwVFpWlUuyzx04
         tWcXvXBycUjFoLx/Air89XbbZ7frg9o0WnbYKhfiYabdxLl5DULBCIfv6oUUm9PhOG
         1QsZJ5rcb/V25ipAMv/00cG+tb2vTkUEP9jbHhhUIQtAGlL4RtWoEpR9np5TyjtLgY
         sbhcENgfQ/zRaoTPydJ1Fw1W8qAGxDqI1QdOhAyVotnBIFhfBKrtau5jAX0wmKPKmq
         ddvGx54QLY22g==
From:   Nathan Chancellor <nathan@kernel.org>
To:     Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>
Cc:     alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org,
        Nathan Chancellor <nathan@kernel.org>
Subject: [PATCH 1/2] ALSA: hda/sigmatel - Sink stac_shutup() into stac_suspend()
Date:   Tue, 17 Aug 2021 18:27:04 -0700
Message-Id: <20210818012705.311963-1-nathan@kernel.org>
X-Mailer: git-send-email 2.33.0
MIME-Version: 1.0
X-Patchwork-Bot: notify
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When CONFIG_PM is not set, there is an unused function warning:

sound/pci/hda/patch_sigmatel.c:4383:13: warning: unused function
'stac_shutup' [-Wunused-function]
static void stac_shutup(struct hda_codec *codec)
            ^
1 warning generated.

Sink the contents of stac_shutup() into stac_suspend() since
stac_shutup() is only called in that one location now.

Fixes: 327b34f2a97d ("ALSA: hda: Nuke unused reboot_notify callback")
Signed-off-by: Nathan Chancellor <nathan@kernel.org>
---
 sound/pci/hda/patch_sigmatel.c | 22 +++++++++-------------
 1 file changed, 9 insertions(+), 13 deletions(-)

diff --git a/sound/pci/hda/patch_sigmatel.c b/sound/pci/hda/patch_sigmatel.c
index 3e00116db86e..61df4d33c48f 100644
--- a/sound/pci/hda/patch_sigmatel.c
+++ b/sound/pci/hda/patch_sigmatel.c
@@ -4380,18 +4380,6 @@ static int stac_init(struct hda_codec *codec)
 	return 0;
 }
 
-static void stac_shutup(struct hda_codec *codec)
-{
-	struct sigmatel_spec *spec = codec->spec;
-
-	snd_hda_shutup_pins(codec);
-
-	if (spec->eapd_mask)
-		stac_gpio_set(codec, spec->gpio_mask,
-				spec->gpio_dir, spec->gpio_data &
-				~spec->eapd_mask);
-}
-
 #define stac_free	snd_hda_gen_free
 
 #ifdef CONFIG_SND_PROC_FS
@@ -4444,7 +4432,15 @@ static void stac927x_proc_hook(struct snd_info_buffer *buffer,
 #ifdef CONFIG_PM
 static int stac_suspend(struct hda_codec *codec)
 {
-	stac_shutup(codec);
+	struct sigmatel_spec *spec = codec->spec;
+
+	snd_hda_shutup_pins(codec);
+
+	if (spec->eapd_mask)
+		stac_gpio_set(codec, spec->gpio_mask,
+				spec->gpio_dir, spec->gpio_data &
+				~spec->eapd_mask);
+
 	return 0;
 }
 #else

base-commit: 8fc8e903156f42c66245838441d03607e9067381
-- 
2.33.0

