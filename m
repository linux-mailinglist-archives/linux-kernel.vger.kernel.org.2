Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0DED0388C22
	for <lists+linux-kernel@lfdr.de>; Wed, 19 May 2021 12:54:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239767AbhESKzy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 19 May 2021 06:55:54 -0400
Received: from youngberry.canonical.com ([91.189.89.112]:54828 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238667AbhESKzx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 May 2021 06:55:53 -0400
Received: from 1.general.cking.uk.vpn ([10.172.193.212] helo=localhost)
        by youngberry.canonical.com with esmtpsa  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256
        (Exim 4.93)
        (envelope-from <colin.king@canonical.com>)
        id 1ljJqL-0000Tq-4b; Wed, 19 May 2021 10:54:25 +0000
From:   Colin King <colin.king@canonical.com>
To:     Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>,
        David Henningsson <coding@diwic.se>,
        alsa-devel@alsa-project.org
Cc:     kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH][next] ALSA: rawmidi: fix incorrect array bounds check on clock_names
Date:   Wed, 19 May 2021 11:54:24 +0100
Message-Id: <20210519105424.55221-1-colin.king@canonical.com>
X-Mailer: git-send-email 2.31.1
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Colin Ian King <colin.king@canonical.com>

The array bounds check on clock_names is currently checking the size
of the entire array rather than the number of elements in the array
leading to a potential array bounds read error. Fix this by using
the ARRAY_SIZE macro instead of sizeof.

Addresses-Coverity: ("Out-of-bounds read")
Fixes: 08fdced60ca0 ("ALSA: rawmidi: Add framing mode")
Signed-off-by: Colin Ian King <colin.king@canonical.com>
---
 sound/core/rawmidi.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/sound/core/rawmidi.c b/sound/core/rawmidi.c
index 4a6534db77d6..6c0a4a67ad2e 100644
--- a/sound/core/rawmidi.c
+++ b/sound/core/rawmidi.c
@@ -1679,7 +1679,7 @@ static void snd_rawmidi_proc_info_read(struct snd_info_entry *entry,
 					    buffer_size, avail, xruns);
 				if (substream->framing == SNDRV_RAWMIDI_MODE_FRAMING_TSTAMP) {
 					clock_type = substream->clock_type >> SNDRV_RAWMIDI_MODE_CLOCK_SHIFT;
-					if (!snd_BUG_ON(clock_type >= sizeof(clock_names)))
+					if (!snd_BUG_ON(clock_type >= ARRAY_SIZE(clock_names)))
 						snd_iprintf(buffer,
 							    "  Framing      : tstamp\n"
 							    "  Clock type   : %s\n",
-- 
2.31.1

