Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BB18B452B7E
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Nov 2021 08:21:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230113AbhKPHXn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 16 Nov 2021 02:23:43 -0500
Received: from smtp-out1.suse.de ([195.135.220.28]:35994 "EHLO
        smtp-out1.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230101AbhKPHXd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Nov 2021 02:23:33 -0500
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out1.suse.de (Postfix) with ESMTP id 50000218BB;
        Tue, 16 Nov 2021 07:20:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1637047232; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
        bh=luNYYzOS/uuARkMUMeG14L2zXQ8urGZIj7LHqL+nYHg=;
        b=kYRbekm9joAy9KTq5Ym9dbfYnlTuhCoN5SpOLaupxSQqOHNTt7/kNnhhr/io/q7/p6Fp5q
        EBx2AOdNe1p/9GakXxlBNkfFESneNH4cnUqbUuC3Vwuss+IxHH95jLuZC6LCrI5V1t6yDh
        p96/BPP0/GQNaEuyVXNwrIPJtrOqpws=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1637047232;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
        bh=luNYYzOS/uuARkMUMeG14L2zXQ8urGZIj7LHqL+nYHg=;
        b=q3TZwGMcDyEk8ZRGqGN7kwPdaHN3IouVZtpZn0GjKHPSw18FdDtFduEMQZSjMtwnu9cdV8
        hqYg70iH9m7oYkAA==
Received: from alsa1.nue.suse.com (alsa1.suse.de [10.160.4.42])
        by relay2.suse.de (Postfix) with ESMTP id 39AD0A3B81;
        Tue, 16 Nov 2021 07:20:32 +0000 (UTC)
From:   Takashi Iwai <tiwai@suse.de>
To:     greybus-dev@lists.linaro.org
Cc:     Johan Hovold <johan@kernel.org>, Alex Elder <elder@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-kernel@vger.kernel.org
Subject: [PATCH] staging: greybus: Add missing rwsem around snd_ctl_remove() calls
Date:   Tue, 16 Nov 2021 08:20:27 +0100
Message-Id: <20211116072027.18466-1-tiwai@suse.de>
X-Mailer: git-send-email 2.26.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

snd_ctl_remove() has to be called with card->controls_rwsem held (when
called after the card instantiation).  This patch adds the missing
rwsem calls around it.

Fixes: 510e340efe0c ("staging: greybus: audio: Add helper APIs for dynamic audio modules")
Signed-off-by: Takashi Iwai <tiwai@suse.de>
---
 drivers/staging/greybus/audio_helper.c | 8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)

diff --git a/drivers/staging/greybus/audio_helper.c b/drivers/staging/greybus/audio_helper.c
index 1ed4772d2771..843760675876 100644
--- a/drivers/staging/greybus/audio_helper.c
+++ b/drivers/staging/greybus/audio_helper.c
@@ -192,7 +192,11 @@ int gbaudio_remove_component_controls(struct snd_soc_component *component,
 				      unsigned int num_controls)
 {
 	struct snd_card *card = component->card->snd_card;
+	int err;
 
-	return gbaudio_remove_controls(card, component->dev, controls,
-				       num_controls, component->name_prefix);
+	down_write(&card->controls_rwsem);
+	err = gbaudio_remove_controls(card, component->dev, controls,
+				      num_controls, component->name_prefix);
+	up_write(&card->controls_rwsem);
+	return err;
 }
-- 
2.31.1

