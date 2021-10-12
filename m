Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BF8A042ADA1
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Oct 2021 22:09:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234399AbhJLULo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 12 Oct 2021 16:11:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53960 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233112AbhJLULn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Oct 2021 16:11:43 -0400
Received: from mail.hahnjo.de (backus.hahnjo.de [IPv6:2a03:4000:2a:2c1::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0A9BCC061570
        for <linux-kernel@vger.kernel.org>; Tue, 12 Oct 2021 13:09:40 -0700 (PDT)
Received: from Jonas-Dell.home (unknown [IPv6:2a01:cb15:40c:c100:cf0a:528a:fee7:c993])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.hahnjo.de (Postfix) with ESMTPSA id A03AB51F1F0C;
        Tue, 12 Oct 2021 22:09:37 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=hahnjo.de; s=default;
        t=1634069377; bh=b8hZSY2MK2PXZiqaOmVdMaiI0ze11hyOkpJDFUIeKyE=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References;
        b=mCsIxojajVnqD36LN4MxtqN3KcuyPDq5VRf3bgydFQy2WaDP/r3O7mwtYGgGhh4DU
         BUhv9l6+uIywNmc18DOA1YZqSiFjCPBfqNI6RC8cN5raV5LmobL+/YPdrW2bRkuDWz
         zgFcP5gD+znBA4fdBVzllsefqf/ttziCPMzR9XoazdVUBeEYtrtzFsZj73TKZjA82h
         HDvx6/ZWLNva2k5Kydvd4ML1V52MVpP5T66tDI3f2kRe7M93L89ha1OAf8hfjlVv29
         FEQ3D3KwkSKjVrKqloaHZtzUNqUvtXkHABdnYS4tU0lY7OIStGTzwnb7F18arMz1hg
         L5Oj426jQBqAA==
From:   Jonas Hahnfeld <hahnjo@hahnjo.de>
To:     Takashi Iwai <tiwai@suse.com>
Cc:     Jaroslav Kysela <perex@perex.cz>, alsa-devel@alsa-project.org,
        linux-kernel@vger.kernel.org, Jonas Hahnfeld <hahnjo@hahnjo.de>
Subject: [PATCH v2] ALSA: usb-audio: Add quirk for VF0770
Date:   Tue, 12 Oct 2021 22:09:07 +0200
Message-Id: <20211012200906.3492-1-hahnjo@hahnjo.de>
X-Mailer: git-send-email 2.33.0
In-Reply-To: <s5hk0ii397m.wl-tiwai@suse.de>
References: <s5hk0ii397m.wl-tiwai@suse.de>
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
v2: added terminator entry

 sound/usb/quirks-table.h | 42 ++++++++++++++++++++++++++++++++++++++++
 1 file changed, 42 insertions(+)

diff --git a/sound/usb/quirks-table.h b/sound/usb/quirks-table.h
index e03043f7dad3..de18fff69280 100644
--- a/sound/usb/quirks-table.h
+++ b/sound/usb/quirks-table.h
@@ -77,6 +77,48 @@
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
+			{
+				.ifnum = -1
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

