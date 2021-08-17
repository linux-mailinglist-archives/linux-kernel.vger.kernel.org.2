Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CC35D3EF002
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Aug 2021 18:12:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229983AbhHQQMm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 17 Aug 2021 12:12:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51520 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229696AbhHQQMk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Aug 2021 12:12:40 -0400
Received: from mail-ed1-x52b.google.com (mail-ed1-x52b.google.com [IPv6:2a00:1450:4864:20::52b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 92F3BC061764
        for <linux-kernel@vger.kernel.org>; Tue, 17 Aug 2021 09:12:07 -0700 (PDT)
Received: by mail-ed1-x52b.google.com with SMTP id g21so18457834edw.4
        for <linux-kernel@vger.kernel.org>; Tue, 17 Aug 2021 09:12:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=lV5/yBJAE61dtnQkRvtjI+pYiYb2DR7Vqp0AekIo3ec=;
        b=VOXnKmjFnFmS1xfKUWg3NtHjtWJEbd6idd3gAUR/1VBdcSTc8oC4UM+b4nayT8eW4g
         7jHHzs2TDIfGlnegUD2E9dJ6Npla5VNgRnWWjPCYRZqUK54TW24BsjiD0h+UoSdokOTf
         Ec3SRY5zEXEfFlXiB/DvCxHHmWV1uEBm2mJfU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=lV5/yBJAE61dtnQkRvtjI+pYiYb2DR7Vqp0AekIo3ec=;
        b=Ta4B0dYCkt/ca9z5b3aBey8NQKEeeAnJvYZ+QrIY+ukWn1b73ttpRAVmoKttDdPYwb
         Hn07UitCnMcEFJ9HhRBrEjmB1YSso8i+kuPCBbM/uIVI6xUsSgtMIm1fMIsy/9VeMLBI
         c660YMjMzT28fLc2Xx42Alq1dpjVMUsb2x0zDu+xiphgCzxgBCcS9myuq+cTDgAd2Zj4
         yuwZCemqwUHtgmO5p40mz663Za1qQYgAGIDkB86Y8q403L3FhmbiYcxmhWgW5anWfn1f
         UbXzrEvop5VquHgi66/p4ZT46Dp7TQKcnv1Zjp2O33kXETWZDBkQbNikQ6kqwf4jvXGv
         Boqw==
X-Gm-Message-State: AOAM5336rmvsPzgPnxeevf7CHmx/V2poKhu11nzgYjUYecf4KSj6gC8S
        YcIDjF9mSvWtGVR0wzMeJEuzeUKIeJSQQg==
X-Google-Smtp-Source: ABdhPJzkrrlqxI3kGBOiaOnn1xEGGmjshJ1ndvFgiALEGi1Tv7L8akzppYHNOJtc9v1+4uctkfssaQ==
X-Received: by 2002:a50:9b06:: with SMTP id o6mr5085509edi.284.1629216726174;
        Tue, 17 Aug 2021 09:12:06 -0700 (PDT)
Received: from alco.lan (80.71.134.83.ipv4.parknet.dk. [80.71.134.83])
        by smtp.gmail.com with ESMTPSA id b3sm945080ejb.7.2021.08.17.09.12.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 17 Aug 2021 09:12:05 -0700 (PDT)
From:   Ricardo Ribalda <ribalda@chromium.org>
To:     Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        linux-media@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Ricardo Ribalda <ribalda@chromium.org>
Subject: [PATCH] media: uvcvideo: Support borderline implementation of hw timestamping
Date:   Tue, 17 Aug 2021 18:12:02 +0200
Message-Id: <20210817161202.49560-1-ribalda@chromium.org>
X-Mailer: git-send-email 2.33.0.rc1.237.g0d66db33f3-goog
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Some cameras do not set pts and src if there is no camera data in the
buffer. They do this without clearing the PTS and SCR bits of the
header. This is probably done due to a strict/borderline interpretation
of the standard:

"STC must be captured when the first video data of a video frame is put
on the USB bus."

Eg:
buffer: 0xa7755c00 len 000012 header:0x8c stc 00000000 sof 0000 pts 00000000
buffer: 0xa7755c00 len 000012 header:0x8c stc 00000000 sof 0000 pts 00000000
buffer: 0xa7755c00 len 000668 header:0x8c stc 73779dba sof 070c pts 7376d37a

Support those cameras by only decoding the clock if there is camera data
in the buffer.

Signed-off-by: Ricardo Ribalda <ribalda@chromium.org>
---
 drivers/media/usb/uvc/uvc_video.c | 12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/drivers/media/usb/uvc/uvc_video.c b/drivers/media/usb/uvc/uvc_video.c
index e16464606b14..6d0e474671a2 100644
--- a/drivers/media/usb/uvc/uvc_video.c
+++ b/drivers/media/usb/uvc/uvc_video.c
@@ -490,6 +490,18 @@ uvc_video_clock_decode(struct uvc_streaming *stream, struct uvc_buffer *buf,
 	if (len < header_size)
 		return;
 
+	/*
+	 * Some cameras when there is no camera data in a buffer, do not
+	 * handle properly the pts and scr. This can be due to an borderline
+	 * interpretation of the standard: "STC must be captured when the
+	 * first video data of a video frame is put on the USB bus."
+	 * Due to their internal design, their firmware cannot clear the
+	 * UVC_STREAM_PTS and UVC_STREAM_SCR bits. Which forces us to use the
+	 * length of the buffer to decide if pts and scr are valid or not.
+	 */
+	if (len == header_size)
+		return;
+
 	/* Extract the timestamps:
 	 *
 	 * - store the frame PTS in the buffer structure
-- 
2.33.0.rc1.237.g0d66db33f3-goog

