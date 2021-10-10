Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 525DC4280D3
	for <lists+linux-kernel@lfdr.de>; Sun, 10 Oct 2021 13:30:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231775AbhJJLca (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 10 Oct 2021 07:32:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51554 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231556AbhJJLc3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 10 Oct 2021 07:32:29 -0400
X-Greylist: delayed 594 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Sun, 10 Oct 2021 04:30:29 PDT
Received: from mail.hahnjo.de (backus.hahnjo.de [IPv6:2a03:4000:2a:2c1::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D8C8FC061570
        for <linux-kernel@vger.kernel.org>; Sun, 10 Oct 2021 04:30:28 -0700 (PDT)
Received: from Jonas-Dell.home (unknown [IPv6:2a01:cb15:40c:c100:cf0a:528a:fee7:c993])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.hahnjo.de (Postfix) with ESMTPSA id DC73B51CFA5A;
        Sun, 10 Oct 2021 13:20:30 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=hahnjo.de; s=default;
        t=1633864831; bh=euYIU/P6O7NV+xmb08ycljLE1YgZeMPZ2GgVpN+dqMA=;
        h=From:To:Cc:Subject:Date;
        b=XWbJ7Y7a2jQ9Yp0JEXe6ThLSU9ktxeGpsnmk246SYaIMJ2xX0PKwRKqfDcy6TH6rx
         ClR6mfLDWRr0iZRez547/rd/5n3bDXY9eAUL6ZpfagGzXSUmGx9usuyALiyRLcQg2J
         +6UGfY1qNyBmD7e0zEGtd+r3rBuvVkI7rCMv/NXX6JNzSbGCGkH+CY1hCpGO/BgIBC
         Y1Jp0SnPBDB1WvUpmrwMlBabnVlXU+NYWLpSLJNn3QhRFoJq5DraQ9LcTkQhQuCanr
         5+Qk5e9c52C83BrLkILHADHvVlyEufT3BdLqKGTKJ4EAxIlLsU+BvQ6k7avlvUwV5G
         gG08Xe3Cvf2qQ==
From:   Jonas Hahnfeld <hahnjo@hahnjo.de>
To:     Takashi Iwai <tiwai@suse.com>, Jaroslav Kysela <perex@perex.cz>
Cc:     alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org,
        Jonas Hahnfeld <hahnjo@hahnjo.de>
Subject: [PATCH] ALSA: usb-audio: Add quirk for VF0770
Date:   Sun, 10 Oct 2021 13:19:47 +0200
Message-Id: <20211010111947.5796-1-hahnjo@hahnjo.de>
X-Mailer: git-send-email 2.33.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The device advertises 8 formats, but only a rate of 48kHz is honored
by the hardware and 24 bits give chopped audio, so only report the
one working combination. This fixes out-of-the-box audio experience
with PipeWire which otherwise attempts to choose S24_3LE (while
PulseAudio defaulted to S16_LE).

Signed-off-by: Jonas Hahnfeld <hahnjo@hahnjo.de>
---
 sound/usb/quirks-table.h | 39 +++++++++++++++++++++++++++++++++++++++
 1 file changed, 39 insertions(+)

diff --git a/sound/usb/quirks-table.h b/sound/usb/quirks-table.h
index e03043f7dad3..be5c2bc26a1d 100644
--- a/sound/usb/quirks-table.h
+++ b/sound/usb/quirks-table.h
@@ -77,6 +77,45 @@
 /* E-Mu 0204 USB */
 { USB_DEVICE_VENDOR_SPEC(0x041e, 0x3f19) },
 
+/*
+ * Creative Technology, Ltd Live! Cam Sync HD [VF0770]
+ * The device advertises 8 formats, but only a rate of 48kHz is honored by the
+ * hardware and 24 bits give chopped audio, so only report the one working
+ * combination.
+ */
+{
+	USB_DEVICE(0x041e, 0x4095),
+	.driver_info = (unsigned long) &(const struct snd_usb_audio_quirk) {
+		.ifnum = QUIRK_ANY_INTERFACE,
+		.type = QUIRK_COMPOSITE,
+		.data = &(const struct snd_usb_audio_quirk[]) {
+			{
+				.ifnum = 2,
+				.type = QUIRK_AUDIO_STANDARD_MIXER,
+			},
+			{
+				.ifnum = 3,
+				.type = QUIRK_AUDIO_FIXED_ENDPOINT,
+				.data = &(const struct audioformat) {
+					.formats = SNDRV_PCM_FMTBIT_S16_LE,
+					.channels = 2,
+					.fmt_bits = 16,
+					.iface = 3,
+					.altsetting = 4,
+					.altset_idx = 4,
+					.endpoint = 0x82,
+					.ep_attr = 0x05,
+					.rates = SNDRV_PCM_RATE_48000,
+					.rate_min = 48000,
+					.rate_max = 48000,
+					.nr_rates = 1,
+					.rate_table = (unsigned int[]) { 48000 },
+				},
+			},
+		},
+	},
+},
+
 /*
  * HP Wireless Audio
  * When not ignored, causes instability issues for some users, forcing them to
-- 
2.33.0

