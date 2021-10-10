Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CA69142821A
	for <lists+linux-kernel@lfdr.de>; Sun, 10 Oct 2021 16:58:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232793AbhJJPAp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 10 Oct 2021 11:00:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40890 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232517AbhJJPAn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 10 Oct 2021 11:00:43 -0400
Received: from mail-wr1-x436.google.com (mail-wr1-x436.google.com [IPv6:2a00:1450:4864:20::436])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4228EC061570
        for <linux-kernel@vger.kernel.org>; Sun, 10 Oct 2021 07:58:45 -0700 (PDT)
Received: by mail-wr1-x436.google.com with SMTP id y3so13896882wrl.1
        for <linux-kernel@vger.kernel.org>; Sun, 10 Oct 2021 07:58:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=MqK3l8sBXI165m7hKMkX26e1F/q0I04cghfQSDOeQac=;
        b=FCpOiY1j+gvRE/slvAcfxlOM3H/p4/AiyESmlMmGj1rguIoPMoHA0UiBCkMqhehfZk
         PZGEW4kbQcyQBK1Ng0D2yPCgN+gGWk9eEdIqLMPOcKcBHGquE4ssV2Z5o58iNEf5dXjZ
         Qzop2GElGcCXyo8RgeSCbU0tKMjPrN6UY626K2gqn+a34AavKqnsRJ9OE0RDvTFxg7Bj
         QIPGQ6H8mxfCXDduV13tprkwErdH6Tp2VvhXPtzrLfYUtQ8b5sOe6EOvuZMOyeRqaesP
         8ZXUmqUehJ+5xcxxr3iJu+3vp4uI4WfWxnsYk5jc/AifygydDeveZ0mkuSGEhIGJKjqf
         U96w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=MqK3l8sBXI165m7hKMkX26e1F/q0I04cghfQSDOeQac=;
        b=3Oj+TZ8hwRr6S/K6x5tvw9ZdvIxpU/FOZpuIcUk5zAjdrNn4kOpJehqcuXoTkAw+X9
         7tRMKjCQ/IBPFT4JJ3eTjcSaWzjjcajYs7Ub+YDCJDmpGKW5fKr7Eod7Dd/IYlGfdU0H
         bXKQ7f/i16NrivpFKVfpmSUSQ3BIRIJVL6BFnsGLrEU2EWCZA0Pnjt1OANPPK9EHGc7b
         r2OibL+cn7+wkGg99UG/FIWG6QIBqMFZbwfaE7kLCa6smLmc8pnqgAjC19EZjpIeWJ1w
         24v/7EnEQ0TxOale1vJ4t2SnkbBg9QXuh41U/YHtWx5hVlYLPjuYC7khCP4mR8D3zUiF
         CTeQ==
X-Gm-Message-State: AOAM532roMBM4CRLDpbW0wcKJzWt13HiY0x2wwh4F8CWR8wllCkSFPs0
        dSco6B19nudteeeFhEpPbSk=
X-Google-Smtp-Source: ABdhPJyvOmBc9TQ/1ExTHbVIO4TZmmUwVUYUq2pmbkdXRNo0azXzotTd+rUKxWMBdhIvlhAMmVd59g==
X-Received: by 2002:adf:9b8e:: with SMTP id d14mr18464075wrc.288.1633877923853;
        Sun, 10 Oct 2021 07:58:43 -0700 (PDT)
Received: from localhost.localdomain ([31.127.144.202])
        by smtp.gmail.com with ESMTPSA id d8sm5162850wrz.84.2021.10.10.07.58.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 10 Oct 2021 07:58:43 -0700 (PDT)
From:   William Overton <willovertonuk@gmail.com>
To:     tiwai@suse.com
Cc:     perex@perex.cz, linux-kernel@vger.kernel.org,
        alsa-devel@alsa-project.org,
        William Overton <willovertonuk@gmail.com>
Subject: [PATCH] Sound: Add support for the Pioneer DJM 750MK2 Mixer/Soundcard
Date:   Sun, 10 Oct 2021 15:58:41 +0100
Message-Id: <20211010145841.11907-1-willovertonuk@gmail.com>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The kernel already has support for very similar Pioneer djm products and this work is based on that.

Added device to quirks-table.h and added control info to mixer_quirks.c.

Tested on my hardware and all working.

Signed-off-by: William Overton <willovertonuk@gmail.com>
---
 sound/usb/mixer_quirks.c | 34 +++++++++++++++++++++++
 sound/usb/quirks-table.h | 58 ++++++++++++++++++++++++++++++++++++++++
 2 files changed, 92 insertions(+)

diff --git a/sound/usb/mixer_quirks.c b/sound/usb/mixer_quirks.c
index 46082dc57be0..d489c1de3bae 100644
--- a/sound/usb/mixer_quirks.c
+++ b/sound/usb/mixer_quirks.c
@@ -2795,6 +2795,7 @@ static int snd_bbfpro_controls_create(struct usb_mixer_interface *mixer)
 #define SND_DJM_750_IDX		0x1
 #define SND_DJM_850_IDX		0x2
 #define SND_DJM_900NXS2_IDX	0x3
+#define SND_DJM_750MK2_IDX	0x4
 
 
 #define SND_DJM_CTL(_name, suffix, _default_value, _windex) { \
@@ -2984,10 +2985,40 @@ static const struct snd_djm_ctl snd_djm_ctls_900nxs2[] = {
 	SND_DJM_CTL("Ch5 Input",   900nxs2_cap5, 3, SND_DJM_WINDEX_CAP)
 };
 
+// DJM-750MK2
+static const u16 snd_djm_opts_750mk2_cap1[] = {
+	0x0100, 0x0102, 0x0103, 0x0106, 0x0107, 0x0108, 0x0109, 0x010a };
+static const u16 snd_djm_opts_750mk2_cap2[] = {
+	0x0200, 0x0202, 0x0203, 0x0206, 0x0207, 0x0208, 0x0209, 0x020a };
+static const u16 snd_djm_opts_750mk2_cap3[] = {
+	0x0300, 0x0302, 0x0303, 0x0306, 0x0307, 0x0308, 0x0309, 0x030a };
+static const u16 snd_djm_opts_750mk2_cap4[] = {
+	0x0400, 0x0402, 0x0403, 0x0406, 0x0407, 0x0408, 0x0409, 0x040a };
+static const u16 snd_djm_opts_750mk2_cap5[] = {
+	0x0507, 0x0508, 0x0509, 0x050a, 0x0511, 0x0512, 0x0513, 0x0514 };
+
+static const u16 snd_djm_opts_750mk2_pb1[] = { 0x0100, 0x0101, 0x0104 };
+static const u16 snd_djm_opts_750mk2_pb2[] = { 0x0200, 0x0201, 0x0204 };
+static const u16 snd_djm_opts_750mk2_pb3[] = { 0x0300, 0x0301, 0x0304 };
+
+
+static const struct snd_djm_ctl snd_djm_ctls_750mk2[] = {
+	SND_DJM_CTL("Capture Level", cap_level, 0, SND_DJM_WINDEX_CAPLVL),
+	SND_DJM_CTL("Ch1 Input",   750mk2_cap1, 2, SND_DJM_WINDEX_CAP),
+	SND_DJM_CTL("Ch2 Input",   750mk2_cap2, 2, SND_DJM_WINDEX_CAP),
+	SND_DJM_CTL("Ch3 Input",   750mk2_cap3, 2, SND_DJM_WINDEX_CAP),
+	SND_DJM_CTL("Ch4 Input",   750mk2_cap4, 2, SND_DJM_WINDEX_CAP),
+	SND_DJM_CTL("Ch5 Input",   750mk2_cap5, 3, SND_DJM_WINDEX_CAP),
+	SND_DJM_CTL("Ch1 Output",   750mk2_pb1, 0, SND_DJM_WINDEX_PB),
+	SND_DJM_CTL("Ch2 Output",   750mk2_pb2, 1, SND_DJM_WINDEX_PB),
+	SND_DJM_CTL("Ch3 Output",   750mk2_pb3, 2, SND_DJM_WINDEX_PB)
+};
+
 
 static const struct snd_djm_device snd_djm_devices[] = {
 	SND_DJM_DEVICE(250mk2),
 	SND_DJM_DEVICE(750),
+	SND_DJM_DEVICE(750mk2),
 	SND_DJM_DEVICE(850),
 	SND_DJM_DEVICE(900nxs2)
 };
@@ -3235,6 +3266,9 @@ int snd_usb_mixer_apply_create_quirk(struct usb_mixer_interface *mixer)
 	case USB_ID(0x08e4, 0x017f): /* Pioneer DJ DJM-750 */
 		err = snd_djm_controls_create(mixer, SND_DJM_750_IDX);
 		break;
+	case USB_ID(0x2b73, 0x001b): /* Pioneer DJ DJM-750MK2 */
+		err = snd_djm_controls_create(mixer, SND_DJM_750MK2_IDX);
+		break;
 	case USB_ID(0x08e4, 0x0163): /* Pioneer DJ DJM-850 */
 		err = snd_djm_controls_create(mixer, SND_DJM_850_IDX);
 		break;
diff --git a/sound/usb/quirks-table.h b/sound/usb/quirks-table.h
index e03043f7dad3..bc0116273e94 100644
--- a/sound/usb/quirks-table.h
+++ b/sound/usb/quirks-table.h
@@ -3850,6 +3850,64 @@ YAMAHA_DEVICE(0x7010, "UB99"),
 		}
 	}
 },
+{
+	/*
+	 * Pioneer DJ DJM-750MK2
+	 * 10 channels playback & 12 channels capture @ 48kHz S24LE
+	 */
+	USB_DEVICE_VENDOR_SPEC(0x2b73, 0x001b),
+	.driver_info = (unsigned long) &(const struct snd_usb_audio_quirk) {
+		.ifnum = QUIRK_ANY_INTERFACE,
+		.type = QUIRK_COMPOSITE,
+		.data = (const struct snd_usb_audio_quirk[]) {
+			{
+				.ifnum = 0,
+				.type = QUIRK_AUDIO_FIXED_ENDPOINT,
+				.data = &(const struct audioformat) {
+					.formats = SNDRV_PCM_FMTBIT_S24_3LE,
+					.channels = 10,
+					.iface = 0,
+					.altsetting = 1,
+					.altset_idx = 1,
+					.endpoint = 0x01,
+					.ep_attr = USB_ENDPOINT_XFER_ISOC|
+					    USB_ENDPOINT_SYNC_ASYNC,
+					.rates = SNDRV_PCM_RATE_48000,
+					.rate_min = 48000,
+					.rate_max = 48000,
+					.nr_rates = 1,
+					.rate_table = (unsigned int[]) {
+						48000
+					}
+				}
+			},
+			{
+				.ifnum = 0,
+				.type = QUIRK_AUDIO_FIXED_ENDPOINT,
+				.data = &(const struct audioformat) {
+					.formats = SNDRV_PCM_FMTBIT_S24_3LE,
+					.channels = 12,
+					.iface = 0,
+					.altsetting = 1,
+					.altset_idx = 1,
+					.endpoint = 0x82,
+					.ep_idx = 1,
+					.ep_attr = USB_ENDPOINT_XFER_ISOC|
+						USB_ENDPOINT_SYNC_ASYNC|
+						USB_ENDPOINT_USAGE_IMPLICIT_FB,
+					.rates = SNDRV_PCM_RATE_48000,
+					.rate_min = 48000,
+					.rate_max = 48000,
+					.nr_rates = 1,
+					.rate_table = (unsigned int[]) { 48000 }
+				}
+			},
+			{
+				.ifnum = -1
+			}
+		}
+	}
+},
 {
 	/*
 	 * Pioneer DJ DJM-850
-- 
2.30.2

