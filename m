Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9A7CA456570
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Nov 2021 23:09:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232201AbhKRWMb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 18 Nov 2021 17:12:31 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37170 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231646AbhKRWMW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 Nov 2021 17:12:22 -0500
Received: from mail-wr1-x42d.google.com (mail-wr1-x42d.google.com [IPv6:2a00:1450:4864:20::42d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 60ED6C06173E
        for <linux-kernel@vger.kernel.org>; Thu, 18 Nov 2021 14:09:21 -0800 (PST)
Received: by mail-wr1-x42d.google.com with SMTP id b12so14350541wrh.4
        for <linux-kernel@vger.kernel.org>; Thu, 18 Nov 2021 14:09:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=Fihs8jw7WlalpbpMtbvcw67CN6Vwoe3A9qXFfFyJTLQ=;
        b=GpBva+f2jEpaOQ6imWuQ8tI8JQyObpVfQIeLRCeW9dygLyaYgNLbsfoDIiXrq+U+W+
         Z7Qykoouw/vpTp2gBKmbZ7D/uFwNNaQfxwyGRZ7hZWSysPA1RIaeLQuSyyhxu99vrSA3
         HOvOG1OwZCXGeIGXl2qeItradBBHDjc+5tloI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=Fihs8jw7WlalpbpMtbvcw67CN6Vwoe3A9qXFfFyJTLQ=;
        b=kskkw5cCTYfjFYALAamSON3GYVwZepkkTFi3Vr4NDR/Sx3IGW1x8TxtW0PDsxevLY+
         uHQHHTbnkMnAyabdA7heIN1/mHX+Ns9q185gOIO/AnR3Q6OI9/tPFJCELofwl928dQwL
         3BHNAw3kHUmr/cQvJJpkEzb4Gn3Cy2EtRBwdJbvZ5Twz2mkvutH8Wf3tqiatvJ8A7Hl6
         VFz2pfFDYWuXNc1Ygw12N4rM7oYJ3LPCELemgx/uQpXqStrAdwc021iD336FwyJiO8Oq
         yRwOTLn8Xt0yNyelLmdfmbDDhXLqof9BPxSA2356hUxUN8XGHTWbeTATve9blZywy+Ay
         7O6Q==
X-Gm-Message-State: AOAM533HgARaHMbXzrlWPV/aiVlGxG7bwb54jwl8eyDH9Q9IHLuBjBai
        12eOZlUJa4dedshYGby+YLVR5g==
X-Google-Smtp-Source: ABdhPJylcYUVFPsiw5MhTcyb66ucIroTggDo+Y8HAesRIFAmhGX2V8mwV1mJvIzx8jl+REIdeKGq3g==
X-Received: by 2002:a05:6000:188b:: with SMTP id a11mr1074617wri.326.1637273359946;
        Thu, 18 Nov 2021 14:09:19 -0800 (PST)
Received: from beni.c.googlers.com.com (216.131.76.34.bc.googleusercontent.com. [34.76.131.216])
        by smtp.gmail.com with ESMTPSA id f7sm13305180wmg.6.2021.11.18.14.09.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 18 Nov 2021 14:09:19 -0800 (PST)
From:   Ricardo Ribalda <ribalda@chromium.org>
To:     Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        linux-media@vger.kernel.org, linux-kernel@vger.kernel.org,
        Tomasz Figa <tfiga@chromium.org>,
        Sergey Senozhatsky <senozhatsky@chromium.org>,
        "hn . chen" <hn.chen@sunplusit.com>
Cc:     Ricardo Ribalda <ribalda@chromium.org>
Subject: [PATCH 7/8] media: uvcvideo: Refactor clock circular buffer
Date:   Thu, 18 Nov 2021 22:09:12 +0000
Message-Id: <20211118220913.299978-8-ribalda@chromium.org>
X-Mailer: git-send-email 2.34.0.rc2.393.gf8c9666880-goog
In-Reply-To: <20211118220913.299978-1-ribalda@chromium.org>
References: <20211118220913.299978-1-ribalda@chromium.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Move the addition to the buffer into its own function and remove the
stream dependency to all the clock functions.

Signed-off-by: Ricardo Ribalda <ribalda@chromium.org>
---
 drivers/media/usb/uvc/uvc_video.c | 81 ++++++++++++++-----------------
 1 file changed, 37 insertions(+), 44 deletions(-)

diff --git a/drivers/media/usb/uvc/uvc_video.c b/drivers/media/usb/uvc/uvc_video.c
index 22b2bab0af5d9..d18bafd824a5d 100644
--- a/drivers/media/usb/uvc/uvc_video.c
+++ b/drivers/media/usb/uvc/uvc_video.c
@@ -459,18 +459,29 @@ static inline ktime_t uvc_video_get_time(void)
 		return ktime_get_real();
 }
 
+static void uvc_video_clock_add_sample(struct uvc_clock *clock,
+				       const struct uvc_clock_sample *sample)
+{
+	unsigned long flags;
+
+	spin_lock_irqsave(&clock->lock, flags);
+
+	memcpy(&clock->samples[clock->head], sample, sizeof(*sample));
+	clock->last_sof = sample->dev_sof;
+	clock->head = (clock->head + 1) % clock->size;
+	clock->count = min(clock->count + 1, clock->size);
+
+	spin_unlock_irqrestore(&clock->lock, flags);
+}
+
 static void
 uvc_video_clock_decode(struct uvc_streaming *stream, struct uvc_buffer *buf,
 		       const u8 *data, int len)
 {
-	struct uvc_clock_sample *sample;
+	struct uvc_clock_sample sample;
 	unsigned int header_size;
 	bool has_pts = false;
 	bool has_scr = false;
-	unsigned long flags;
-	ktime_t time;
-	u16 host_sof;
-	u16 dev_sof;
 
 	switch (data[1] & (UVC_STREAM_PTS | UVC_STREAM_SCR)) {
 	case UVC_STREAM_PTS | UVC_STREAM_SCR:
@@ -523,20 +534,19 @@ uvc_video_clock_decode(struct uvc_streaming *stream, struct uvc_buffer *buf,
 	 * only the first one will match the host_sof.
 	 */
 	if (stream->dev->quirks & UVC_QUIRK_INVALID_DEVICE_SOF)
-		dev_sof = usb_get_current_frame_number(stream->dev->udev);
+		sample.dev_sof =
+			usb_get_current_frame_number(stream->dev->udev);
 	else
-		dev_sof = get_unaligned_le16(&data[header_size - 2]);
+		sample.dev_sof = get_unaligned_le16(&data[header_size - 2]);
 
-	if (dev_sof == stream->clock.last_sof)
+	if (sample.dev_sof == stream->clock.last_sof)
 		return;
 
-	stream->clock.last_sof = dev_sof;
-
 	if (stream->dev->quirks & UVC_QUIRK_INVALID_DEVICE_SOF)
-		host_sof = dev_sof;
+		sample.host_sof = sample.dev_sof;
 	else
-		host_sof = usb_get_current_frame_number(stream->dev->udev);
-	time = uvc_video_get_time();
+		sample.host_sof = usb_get_current_frame_number(stream->dev->udev);
+	sample.host_time = uvc_video_get_time();
 
 	/* The UVC specification allows device implementations that can't obtain
 	 * the USB frame number to keep their own frame counters as long as they
@@ -558,46 +568,29 @@ uvc_video_clock_decode(struct uvc_streaming *stream, struct uvc_buffer *buf,
 	 * the 8 LSBs of the delta are kept.
 	 */
 	if (stream->clock.sof_offset == (u16)-1) {
-		u16 delta_sof = (host_sof - dev_sof) & 255;
+		u16 delta_sof = (sample.host_sof - sample.dev_sof) & 255;
 		if (delta_sof >= 10)
 			stream->clock.sof_offset = delta_sof;
 		else
 			stream->clock.sof_offset = 0;
 	}
 
-	dev_sof = (dev_sof + stream->clock.sof_offset) & 2047;
-
-	spin_lock_irqsave(&stream->clock.lock, flags);
-
-	sample = &stream->clock.samples[stream->clock.head];
-	sample->dev_stc = get_unaligned_le32(&data[header_size - 6]);
-	sample->dev_sof = dev_sof;
-	sample->host_sof = host_sof;
-	sample->host_time = time;
-
-	/* Update the sliding window head and count. */
-	stream->clock.head = (stream->clock.head + 1) % stream->clock.size;
+	sample.dev_sof = (sample.dev_sof + stream->clock.sof_offset) & 2047;
+	sample.dev_stc = get_unaligned_le32(&data[header_size - 6]);
 
-	if (stream->clock.count < stream->clock.size)
-		stream->clock.count++;
-
-	spin_unlock_irqrestore(&stream->clock.lock, flags);
+	uvc_video_clock_add_sample(&stream->clock, &sample);
 }
 
-static void uvc_video_clock_reset(struct uvc_streaming *stream)
+static void uvc_video_clock_reset(struct uvc_clock *clock)
 {
-	struct uvc_clock *clock = &stream->clock;
-
 	clock->head = 0;
 	clock->count = 0;
 	clock->last_sof = -1;
 	clock->sof_offset = -1;
 }
 
-static int uvc_video_clock_init(struct uvc_streaming *stream)
+static int uvc_video_clock_init(struct uvc_clock *clock)
 {
-	struct uvc_clock *clock = &stream->clock;
-
 	spin_lock_init(&clock->lock);
 	clock->size = 32;
 
@@ -606,15 +599,15 @@ static int uvc_video_clock_init(struct uvc_streaming *stream)
 	if (clock->samples == NULL)
 		return -ENOMEM;
 
-	uvc_video_clock_reset(stream);
+	uvc_video_clock_reset(clock);
 
 	return 0;
 }
 
-static void uvc_video_clock_cleanup(struct uvc_streaming *stream)
+static void uvc_video_clock_cleanup(struct uvc_clock *clock)
 {
-	kfree(stream->clock.samples);
-	stream->clock.samples = NULL;
+	kfree(clock->samples);
+	clock->samples = NULL;
 }
 
 /*
@@ -2057,7 +2050,7 @@ int uvc_video_resume(struct uvc_streaming *stream, int reset)
 
 	stream->frozen = 0;
 
-	uvc_video_clock_reset(stream);
+	uvc_video_clock_reset(&stream->clock);
 
 	if (!uvc_queue_streaming(&stream->queue))
 		return 0;
@@ -2186,7 +2179,7 @@ int uvc_video_start_streaming(struct uvc_streaming *stream)
 {
 	int ret;
 
-	ret = uvc_video_clock_init(stream);
+	ret = uvc_video_clock_init(&stream->clock);
 	if (ret < 0)
 		return ret;
 
@@ -2204,7 +2197,7 @@ int uvc_video_start_streaming(struct uvc_streaming *stream)
 error_video:
 	usb_set_interface(stream->dev->udev, stream->intfnum, 0);
 error_commit:
-	uvc_video_clock_cleanup(stream);
+	uvc_video_clock_cleanup(&stream->clock);
 
 	return ret;
 }
@@ -2231,5 +2224,5 @@ void uvc_video_stop_streaming(struct uvc_streaming *stream)
 		usb_clear_halt(stream->dev->udev, pipe);
 	}
 
-	uvc_video_clock_cleanup(stream);
+	uvc_video_clock_cleanup(&stream->clock);
 }
-- 
2.34.0.rc2.393.gf8c9666880-goog

