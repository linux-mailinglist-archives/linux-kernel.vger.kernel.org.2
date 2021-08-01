Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 338D23DCA51
	for <lists+linux-kernel@lfdr.de>; Sun,  1 Aug 2021 08:26:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230386AbhHAG0W (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 1 Aug 2021 02:26:22 -0400
Received: from smtp-relay-canonical-0.canonical.com ([185.125.188.120]:34098
        "EHLO smtp-relay-canonical-0.canonical.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S230356AbhHAG0E (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 1 Aug 2021 02:26:04 -0400
Received: from localhost (1.general.cking.uk.vpn [10.172.193.212])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by smtp-relay-canonical-0.canonical.com (Postfix) with ESMTPSA id 5BF423F10D;
        Sun,  1 Aug 2021 06:25:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
        s=20210705; t=1627799154;
        bh=CzjCXhgl0a3d1ieMBVQ+XZEZoQi8gWaJjxi2fu4cq5E=;
        h=From:To:Cc:Subject:Date:Message-Id:MIME-Version:Content-Type;
        b=l0vqmorMAPZIl0H+3yk13NHRpVICt/c0IN+RqRegnFA+u0JzXwm4dk4mLCtDT2rOp
         CxEdQK8FwEd99CZTNgmKXlzHcPC16tLId1N+7Hgh3M5laWu3nQnXrnypgy2ojYCFPQ
         Dflzt9tyWBBVB7lwGoPaG6MXF2puGBFv2PJtzZamtt7BZOpNeDR7sGbgszKMen+gjJ
         MdnwF+3uE2M9gqJlLa3qwNT0MTIH8aheCZ5qXZcv8lhKDRA8slOEgedO5XHKnDzL7g
         EW0T2pM3VI2400orB+tYgVyqueIEAt9yKsLMHzD2S1hFnyPBDWtQoM4x3ecHKsvkMN
         yxo1jryPTC9hg==
From:   Colin King <colin.king@canonical.com>
To:     Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>,
        alsa-devel@alsa-project.org
Cc:     kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] ALSA: usb-audio: make array static const, makes object smaller
Date:   Sun,  1 Aug 2021 07:25:48 +0100
Message-Id: <20210801062548.137770-1-colin.king@canonical.com>
X-Mailer: git-send-email 2.31.1
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Colin Ian King <colin.king@canonical.com>

Don't populate array names_to_check on the stack but instead it
static.  Makes the object code smaller by 56 bytes.

Before:
   text    data     bss     dec     hex filename
 103512   34380       0  137892   21aa4 ./sound/usb/mixer.o

After:
   text    data     bss     dec     hex filename
 103264   34572       0  137836   21a6c ./sound/usb/mixer.o

gcc version 10.2.0)

Signed-off-by: Colin Ian King <colin.king@canonical.com>
---
 sound/usb/mixer.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/sound/usb/mixer.c b/sound/usb/mixer.c
index f4cdaf1ba44a..aec2499284a5 100644
--- a/sound/usb/mixer.c
+++ b/sound/usb/mixer.c
@@ -1572,8 +1572,9 @@ static size_t append_ctl_name(struct snd_kcontrol *kctl, const char *str)
 static void check_no_speaker_on_headset(struct snd_kcontrol *kctl,
 					struct snd_card *card)
 {
-	const char *names_to_check[] = {
-		"Headset", "headset", "Headphone", "headphone", NULL};
+	static const char *names_to_check[] = {
+		"Headset", "headset", "Headphone", "headphone", NULL
+	};
 	const char **s;
 	bool found = false;
 
-- 
2.31.1

