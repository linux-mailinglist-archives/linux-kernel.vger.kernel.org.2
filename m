Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 866AA3C9561
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Jul 2021 02:56:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231576AbhGOA7Y (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 14 Jul 2021 20:59:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37470 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231407AbhGOA7X (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Jul 2021 20:59:23 -0400
Received: from mail-wr1-x42c.google.com (mail-wr1-x42c.google.com [IPv6:2a00:1450:4864:20::42c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 81D6EC06175F
        for <linux-kernel@vger.kernel.org>; Wed, 14 Jul 2021 17:56:30 -0700 (PDT)
Received: by mail-wr1-x42c.google.com with SMTP id f9so5406831wrq.11
        for <linux-kernel@vger.kernel.org>; Wed, 14 Jul 2021 17:56:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:mime-version:content-disposition;
        bh=gSBGqDMM3Jz7qv5xcKdOnajx3PDMhN4qp53yDYdoaRU=;
        b=TZTYDeobReI0lDgoPR6N8gFO8LN1w4DsdXGUhDLn1nrJzQf+Xs0tP0mW0cLjRVIM+G
         G90WjIGjw12EZiffyjbsbkl186cn8MzGRF6nbrGbScN78/O5Spu7AWkA6w6AQplLRcrA
         l+FSln1FteHsKdHKBjJZZf9TCcXPDmDARD0FKHAOCVXKhEEf3Xq0R7Wrw9+yAKghlIhd
         af7FAPq5NPYqnLsTqsws7qTZ60EkSO5FrF2uXWQ/6F2JVbv7Hir8BGDkw2tysLmq/1/4
         K1SVZPIytbtXqlbFBjK2cgBMiF4fuqPxYbPw6TbjbKPcVmpw2tdvci7BCay9hs2VNnq7
         CfCg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:mime-version
         :content-disposition;
        bh=gSBGqDMM3Jz7qv5xcKdOnajx3PDMhN4qp53yDYdoaRU=;
        b=KcxI7LheYyHAQVyxZ3hcKozWzg0LT4zdCoLhRTbJr2Kwge+DirhQST3VIbq2gnWryL
         i3aLte6qFBU8tNEFHgSVrO3+agZX7LASd3wfffQsfALTWznWHEJ5ZdRQiDqCvyak5mIm
         h4AATZM4xUP3vYo7Y4TD2C3k2AhJx6FW3S5Cjh1lWrBM44g7GzLvqV2lUaLQxcIGL8cZ
         SaBzd24FX3I8PREOOXaf3Yf3SseFc5EVfPCEfT24XCkjDiHfHH6YshdB3Rj3fVtwAhsH
         eK5UfQAX7tzovjqGvx4Ync4yn9LGti+IjE197ik6XaD/JD3HPoZrM80qZNvY3xZJS53y
         MMtw==
X-Gm-Message-State: AOAM530yRXB+RYPftlt+inBoJrBWdQT6A3NxtPNUSSinjxtZN579iUCS
        xiXW5SrVK8RqXodwpmT8GejE9uuLCGM=
X-Google-Smtp-Source: ABdhPJz8WKBFCdSljGyrcHfmuKAd2NQ/pQWZ3gjNWrVIIw8NUt4dycZyqTTRwc3+UQYiTpG9tzZoZg==
X-Received: by 2002:adf:a183:: with SMTP id u3mr897426wru.175.1626310589080;
        Wed, 14 Jul 2021 17:56:29 -0700 (PDT)
Received: from pc ([196.235.28.219])
        by smtp.gmail.com with ESMTPSA id p2sm3352888wmg.6.2021.07.14.17.56.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 14 Jul 2021 17:56:28 -0700 (PDT)
Date:   Thu, 15 Jul 2021 01:56:25 +0100
From:   Salah Triki <salah.triki@gmail.com>
To:     perex@perex.cz, tiwai@suse.com
Cc:     alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org
Subject: [PATCH] sound: usb: line6: free allocated urbs on failure
Message-ID: <20210715005625.GA1997259@pc>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Free allocated urbs on failure in order to prevent memory leaks.

Signed-off-by: Salah Triki <salah.triki@gmail.com>
---
 sound/usb/line6/capture.c | 22 ++++++++++++++++++----
 1 file changed, 18 insertions(+), 4 deletions(-)

diff --git a/sound/usb/line6/capture.c b/sound/usb/line6/capture.c
index 970c9bdce0b2..345b75ede5d5 100644
--- a/sound/usb/line6/capture.c
+++ b/sound/usb/line6/capture.c
@@ -258,6 +258,7 @@ int line6_create_audio_in_urbs(struct snd_line6_pcm *line6pcm)
 {
 	struct usb_line6 *line6 = line6pcm->line6;
 	int i;
+	int ret;
 
 	line6pcm->in.urbs = kcalloc(line6->iso_buffers, sizeof(struct urb *),
 				    GFP_KERNEL);
@@ -272,8 +273,10 @@ int line6_create_audio_in_urbs(struct snd_line6_pcm *line6pcm)
 		urb = line6pcm->in.urbs[i] =
 		    usb_alloc_urb(LINE6_ISO_PACKETS, GFP_KERNEL);
 
-		if (urb == NULL)
-			return -ENOMEM;
+		if (urb == NULL) {
+			ret = -ENOMEM;
+			goto enomem;
+		}
 
 		urb->dev = line6->usbdev;
 		urb->pipe =
@@ -286,9 +289,20 @@ int line6_create_audio_in_urbs(struct snd_line6_pcm *line6pcm)
 		urb->interval = LINE6_ISO_INTERVAL;
 		urb->error_count = 0;
 		urb->complete = audio_in_callback;
-		if (usb_urb_ep_type_check(urb))
-			return -EINVAL;
+		if (usb_urb_ep_type_check(urb)) {
+			ret = -EINVAL;
+			goto einval;
+		}
 	}
 
 	return 0;
+
+enomem:
+	i--;
+
+einval:
+	while (i >= 0)
+		usb_free_urb(line6pcm->in.urbs[i--]);
+
+	return ret;
 }
-- 
2.25.1

