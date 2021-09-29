Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 67B2F41C38B
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Sep 2021 13:37:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245706AbhI2LiW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 29 Sep 2021 07:38:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59474 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245664AbhI2LiV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Sep 2021 07:38:21 -0400
Received: from metanate.com (unknown [IPv6:2001:8b0:1628:5005::111])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C6846C06161C
        for <linux-kernel@vger.kernel.org>; Wed, 29 Sep 2021 04:36:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=metanate.com; s=stronger; h=Content-Transfer-Encoding:Message-Id:Date:
        Subject:Cc:To:From:Content-Type:Reply-To:Content-ID:Content-Description:
        In-Reply-To:References; bh=NG/dLqRkfXHdlB4dmK0BgcBIdTMjxPfvn7MfDjTG9OQ=; b=x5
        Y2PoyLwwRVwoZa3v8CwgEkb82mzZvjytFBMCSP08brAFyuNtbc2pdxdKG+Kp8xuFY6BtT1WpMfqD3
        UhJ1x1zfRfYJeGep9A2+apYkxhQIOjrSjZJxzjRxCqqTQDVZ++NN2OC1vzxkkmHwk3ug7h32o/Kc3
        FDFPmfmgaNW0ptDg/rOWUeUU7knZ04JJY9Byl5kfqBDjq68NYZsDmh3/F33ZsTc5eUQQA8HXlakDu
        HfzFTp1bQPrxeuIQKCNqiCgfHbTc1XjXl2PSbi37jIvcWsF0A32Um6Knp/BHclXOgdn7whW8c4pl2
        KpwAyuIbaWnVLf6Rz1ypQrIqdzDyb8qw==;
Received: from [81.174.171.191] (helo=donbot.metanate.com)
        by email.metanate.com with esmtpsa  (TLS1.3) tls TLS_AES_256_GCM_SHA384
        (Exim 4.93)
        (envelope-from <john@metanate.com>)
        id 1mVXsx-00032A-OM; Wed, 29 Sep 2021 12:36:27 +0100
From:   John Keeping <john@metanate.com>
To:     alsa-devel@alsa-project.org
Cc:     John Keeping <john@metanate.com>, Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>, linux-kernel@vger.kernel.org
Subject: [PATCH] ALSA: rawmidi: Fix potential UAF from sequencer destruction
Date:   Wed, 29 Sep 2021 12:36:20 +0100
Message-Id: <20210929113620.2194847-1-john@metanate.com>
X-Mailer: git-send-email 2.33.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Authenticated: YES
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

If the sequencer device outlives the rawmidi device, then
snd_rawmidi_dev_seq_free() will run after release_rawmidi_device() has
freed the snd_rawmidi structure.

This can easily be reproduced with CONFIG_DEBUG_KOBJECT_RELEASE.

Keep a reference to the rawmidi device until the sequencer has been
destroyed in order to avoid this.

Signed-off-by: John Keeping <john@metanate.com>
---
 sound/core/rawmidi.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/sound/core/rawmidi.c b/sound/core/rawmidi.c
index 6f30231bdb88..b015f5f69175 100644
--- a/sound/core/rawmidi.c
+++ b/sound/core/rawmidi.c
@@ -1860,6 +1860,7 @@ static void snd_rawmidi_dev_seq_free(struct snd_seq_device *device)
 	struct snd_rawmidi *rmidi = device->private_data;
 
 	rmidi->seq_dev = NULL;
+	put_device(&rmidi->dev);
 }
 #endif
 
@@ -1936,6 +1937,9 @@ static int snd_rawmidi_dev_register(struct snd_device *device)
 #if IS_ENABLED(CONFIG_SND_SEQUENCER)
 	if (!rmidi->ops || !rmidi->ops->dev_register) { /* own registration mechanism */
 		if (snd_seq_device_new(rmidi->card, rmidi->device, SNDRV_SEQ_DEV_ID_MIDISYNTH, 0, &rmidi->seq_dev) >= 0) {
+			/* Ensure we outlive the sequencer (see snd_rawmidi_dev_seq_free). */
+			get_device(&rmidi->dev);
+
 			rmidi->seq_dev->private_data = rmidi;
 			rmidi->seq_dev->private_free = snd_rawmidi_dev_seq_free;
 			sprintf(rmidi->seq_dev->name, "MIDI %d-%d", rmidi->card->number, rmidi->device);
-- 
2.33.0

