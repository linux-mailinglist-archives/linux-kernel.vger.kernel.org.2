Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 99D85456573
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Nov 2021 23:09:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232292AbhKRWMh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 18 Nov 2021 17:12:37 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37172 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231738AbhKRWMW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 Nov 2021 17:12:22 -0500
Received: from mail-wr1-x42c.google.com (mail-wr1-x42c.google.com [IPv6:2a00:1450:4864:20::42c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8E889C06174A
        for <linux-kernel@vger.kernel.org>; Thu, 18 Nov 2021 14:09:21 -0800 (PST)
Received: by mail-wr1-x42c.google.com with SMTP id c4so14325608wrd.9
        for <linux-kernel@vger.kernel.org>; Thu, 18 Nov 2021 14:09:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=sdfkD+pc9t2E2FEHTAc3AOL1hp4T3RviKzD3tWxDWuY=;
        b=Wsv+nYWPG4GTqK5mzDyVvFOEVrw3P6vfchULBBRKIZbcnusLZmW+cqeeqdYbpu8F7I
         An86uNKk1PhYDnBfrRXTCl2xEALAY2ZeLK3/udtX1sHMtrQwpNfgGkE60bY6mBanGP6p
         MOHOGW0DJnAv9GxX2VjFmW3FbhGphkZfsFacA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=sdfkD+pc9t2E2FEHTAc3AOL1hp4T3RviKzD3tWxDWuY=;
        b=mcWyNNGftxaFixW/GgWEuXIo6FpC6GlO/Gks9CHU7KTqUsro+b4+EpRs9ianh+3xL3
         WingPzer5iz/8kU/fMRNnfnP4X2HfTJ0zt5hg69EvNIPOZzvUzqSE5iS8/zj25xt9O8t
         Ke29tdbl1l6GL3QkqdPqPoOVv3ZeeOrEECBCW0UM3MDUSZD4NnpYwYCNahbe6Pp6HfrK
         0Us8Vu7aomR1ht2dlqD1nizU4BVm0w84GOeWg7+aZi30/uBXudjRpoXrx3caqUe/CiPr
         x/p6KvetQo9hvIb3Am2tqBF3TMy7m918JIf58nvBd24qxXiNACNaR/hj+jGawW3bgmLT
         lZew==
X-Gm-Message-State: AOAM531qtrAWP2EXZHBu5fchl/gEovPcEXnX/pyN8K72HvfnuXkjTPtI
        k5UIu6ZI4U/gTVBs9zmsVArfFg==
X-Google-Smtp-Source: ABdhPJz2RoHtxyGv6FbSqLMmrieezZ4R20FtFZHAMwg813Fh0N++MHzcu8KsuC3P8yGmz+GxNob+rQ==
X-Received: by 2002:a5d:6702:: with SMTP id o2mr1073512wru.108.1637273360242;
        Thu, 18 Nov 2021 14:09:20 -0800 (PST)
Received: from beni.c.googlers.com.com (216.131.76.34.bc.googleusercontent.com. [34.76.131.216])
        by smtp.gmail.com with ESMTPSA id f7sm13305180wmg.6.2021.11.18.14.09.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 18 Nov 2021 14:09:20 -0800 (PST)
From:   Ricardo Ribalda <ribalda@chromium.org>
To:     Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        linux-media@vger.kernel.org, linux-kernel@vger.kernel.org,
        Tomasz Figa <tfiga@chromium.org>,
        Sergey Senozhatsky <senozhatsky@chromium.org>,
        "hn . chen" <hn.chen@sunplusit.com>
Cc:     Ricardo Ribalda <ribalda@chromium.org>
Subject: [PATCH 8/8] media: uvcvideo: Fix hw timestampt handling for slow FPS
Date:   Thu, 18 Nov 2021 22:09:13 +0000
Message-Id: <20211118220913.299978-9-ribalda@chromium.org>
X-Mailer: git-send-email 2.34.0.rc2.393.gf8c9666880-goog
In-Reply-To: <20211118220913.299978-1-ribalda@chromium.org>
References: <20211118220913.299978-1-ribalda@chromium.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In UVC 1.5, when working with FPS under 32, there is a chance that the
circular buffer contains two dev_sof overflows, but the clock interpolator
is only capable of handle a single overflow.

Remove all the samples from the circular buffer that are two overflows
old.

Signed-off-by: Ricardo Ribalda <ribalda@chromium.org>
---
 drivers/media/usb/uvc/uvc_video.c | 15 +++++++++++++++
 drivers/media/usb/uvc/uvcvideo.h  |  1 +
 2 files changed, 16 insertions(+)

diff --git a/drivers/media/usb/uvc/uvc_video.c b/drivers/media/usb/uvc/uvc_video.c
index d18bafd824a5d..56ed9ff6719a8 100644
--- a/drivers/media/usb/uvc/uvc_video.c
+++ b/drivers/media/usb/uvc/uvc_video.c
@@ -466,6 +466,20 @@ static void uvc_video_clock_add_sample(struct uvc_clock *clock,
 
 	spin_lock_irqsave(&clock->lock, flags);
 
+	/* Delete last overflows */
+	if (clock->head == clock->last_sof_overflow)
+		clock->last_sof_overflow = -1;
+
+	/* Handle overflows */
+	if (clock->count > 0 && clock->last_sof > sample->dev_sof) {
+		/* Remove data from the last^2 overflows */
+		if (clock->last_sof_overflow != -1)
+			clock->count = (clock->head - clock->last_sof_overflow)
+								% clock->count;
+		clock->last_sof_overflow = clock->head;
+	}
+
+	/* Add sample */
 	memcpy(&clock->samples[clock->head], sample, sizeof(*sample));
 	clock->last_sof = sample->dev_sof;
 	clock->head = (clock->head + 1) % clock->size;
@@ -586,6 +600,7 @@ static void uvc_video_clock_reset(struct uvc_clock *clock)
 	clock->head = 0;
 	clock->count = 0;
 	clock->last_sof = -1;
+	clock->last_sof_overflow = -1;
 	clock->sof_offset = -1;
 }
 
diff --git a/drivers/media/usb/uvc/uvcvideo.h b/drivers/media/usb/uvc/uvcvideo.h
index edc9a34cacdb2..5bfe3d1619c21 100644
--- a/drivers/media/usb/uvc/uvcvideo.h
+++ b/drivers/media/usb/uvc/uvcvideo.h
@@ -643,6 +643,7 @@ struct uvc_streaming {
 		unsigned int head;
 		unsigned int count;
 		unsigned int size;
+		unsigned int last_sof_overflow;
 
 		u16 last_sof;
 		u16 sof_offset;
-- 
2.34.0.rc2.393.gf8c9666880-goog

