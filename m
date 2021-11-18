Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D70A845656E
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Nov 2021 23:09:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231915AbhKRWM3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 18 Nov 2021 17:12:29 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37176 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231639AbhKRWMW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 Nov 2021 17:12:22 -0500
Received: from mail-wr1-x42c.google.com (mail-wr1-x42c.google.com [IPv6:2a00:1450:4864:20::42c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D9B54C061759
        for <linux-kernel@vger.kernel.org>; Thu, 18 Nov 2021 14:09:20 -0800 (PST)
Received: by mail-wr1-x42c.google.com with SMTP id d27so14357003wrb.6
        for <linux-kernel@vger.kernel.org>; Thu, 18 Nov 2021 14:09:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=nI+S0BW0IqKIYyqIwvbthiGB5Xvy9IARrMVLFLvVlqA=;
        b=TeP8zWgcUO3rnIFtkqnNP5TPabNuL8ggRhpYjKvnbxYlDC7zPprjX9uvPr5pVTYSrJ
         lfPXK+nO4NaU3axsRXk9Ggl1ODoDJgtizL5xzQFozKW0SoTIqZUknWZZmcw1jlk5nj3h
         f+1mKUTeUdzagvkMKncOES1nLv8bFHrh/TbwA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=nI+S0BW0IqKIYyqIwvbthiGB5Xvy9IARrMVLFLvVlqA=;
        b=rWcVqpGQQAeHBgcCUgOjovJJIZ6XZPiB061iocs/zuJgrIBn9UZ8AZ6RQ3kCypD3Zm
         NV2gvpi1QqiKkeXBZHsSs2wrwgVMLedBzeyKPurEHoqi18N8mtfBrQdDYRwIXGxtPBJn
         Y/32nhkx8ZsXnM9aivQ/fogM1Qc4tx54Pp+VeGd5wtSKUhSR4V2SoUb3XYRCzqJzZckj
         OlmPHKQu8Te/9O06Dwsc/5121olMDQmdVBedrgQjdQLGaj2NzaVSi5ENSlLkZotgUgAV
         Idk2a8jJxnP+nlx40GWW476N2m21fs1bDXjxJjV4LvJJSXvJHay7bVpZfVsWLJPxLvSH
         cVxw==
X-Gm-Message-State: AOAM533kFBCZnoWMV2niVUHOC3h7sH6PQbPkmiTeybpx4ZiMri9HfjhK
        QROP7X4yVpvji9Hp6MfrNlkmog==
X-Google-Smtp-Source: ABdhPJzAUCy9NTm3cCuTdaKT53fDVPV8ilkJ3H3cTDwUCIhR1Lp60jheKGTiElFXr+AIjwYfoN68LA==
X-Received: by 2002:adf:fd4c:: with SMTP id h12mr980912wrs.429.1637273359363;
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
Subject: [PATCH 6/8] media: uvcvideo: Allow hw clock updates with buffers not full
Date:   Thu, 18 Nov 2021 22:09:11 +0000
Message-Id: <20211118220913.299978-7-ribalda@chromium.org>
X-Mailer: git-send-email 2.34.0.rc2.393.gf8c9666880-goog
In-Reply-To: <20211118220913.299978-1-ribalda@chromium.org>
References: <20211118220913.299978-1-ribalda@chromium.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

With UVC 1.5 we get as little as one clock sample per frame. Which means
that it takes 32 frames to move from the software timestamp to the
hardware timestamp method.

This results in abrupt changes in the timestamping after 32 frames (~1
second), resulting in noticeable artifacts when used for encoding.

With this patch we modify the update algorithm to work with whatever
amount of values are available.

Signed-off-by: Ricardo Ribalda <ribalda@chromium.org>
---
 drivers/media/usb/uvc/uvc_video.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/media/usb/uvc/uvc_video.c b/drivers/media/usb/uvc/uvc_video.c
index 3a2717e2c92c0..22b2bab0af5d9 100644
--- a/drivers/media/usb/uvc/uvc_video.c
+++ b/drivers/media/usb/uvc/uvc_video.c
@@ -734,10 +734,10 @@ void uvc_video_clock_update(struct uvc_streaming *stream,
 
 	spin_lock_irqsave(&clock->lock, flags);
 
-	if (clock->count < clock->size)
+	if (clock->count < 2)
 		goto done;
 
-	first = &clock->samples[clock->head];
+	first = &clock->samples[(clock->head - clock->count) % clock->size];
 	last = &clock->samples[(clock->head - 1) % clock->size];
 
 	/* First step, PTS to SOF conversion. */
-- 
2.34.0.rc2.393.gf8c9666880-goog

