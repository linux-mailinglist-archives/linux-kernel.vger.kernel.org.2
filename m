Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 96893391CAD
	for <lists+linux-kernel@lfdr.de>; Wed, 26 May 2021 18:06:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234811AbhEZQHy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 26 May 2021 12:07:54 -0400
Received: from youngberry.canonical.com ([91.189.89.112]:34446 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235382AbhEZQHw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 May 2021 12:07:52 -0400
Received: from 1.general.cking.uk.vpn ([10.172.193.212] helo=localhost)
        by youngberry.canonical.com with esmtpsa  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256
        (Exim 4.93)
        (envelope-from <colin.king@canonical.com>)
        id 1llw2y-0006jH-K7; Wed, 26 May 2021 16:06:16 +0000
From:   Colin King <colin.king@canonical.com>
To:     Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>,
        Connor McAdams <conmanx360@gmail.com>,
        alsa-devel@alsa-project.org
Cc:     kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH][next] ALSA: hda/ca0132: Make a const array static, makes object smaller
Date:   Wed, 26 May 2021 17:06:16 +0100
Message-Id: <20210526160616.3764119-1-colin.king@canonical.com>
X-Mailer: git-send-email 2.31.1
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Colin Ian King <colin.king@canonical.com>

Don't populate the const array dsp_dma_stream_ids the stack but instead
make it static. Makes the object code smaller by 21 bytes.

Before:
   text    data     bss     dec     hex filename
 189012   70376     192  259580   3f5fc ./sound/pci/hda/patch_ca0132.o

After:
   text    data     bss     dec     hex filename
 188927   70440     192  259559   3f5e7 ./sound/pci/hda/patch_ca0132.o

(gcc version 10.3.0)

Signed-off-by: Colin Ian King <colin.king@canonical.com>
---
 sound/pci/hda/patch_ca0132.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/sound/pci/hda/patch_ca0132.c b/sound/pci/hda/patch_ca0132.c
index 49b4fdd2feab..b66e7bdbf483 100644
--- a/sound/pci/hda/patch_ca0132.c
+++ b/sound/pci/hda/patch_ca0132.c
@@ -7598,7 +7598,7 @@ static void ca0132_alt_free_active_dma_channels(struct hda_codec *codec)
  */
 static void ca0132_alt_start_dsp_audio_streams(struct hda_codec *codec)
 {
-	const unsigned int dsp_dma_stream_ids[] = { 0x0c, 0x03, 0x04 };
+	static const unsigned int dsp_dma_stream_ids[] = { 0x0c, 0x03, 0x04 };
 	struct ca0132_spec *spec = codec->spec;
 	unsigned int i, tmp;
 
-- 
2.31.1

