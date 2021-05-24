Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AF15B38F257
	for <lists+linux-kernel@lfdr.de>; Mon, 24 May 2021 19:36:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233527AbhEXRiV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 24 May 2021 13:38:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46834 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232983AbhEXRiU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 May 2021 13:38:20 -0400
Received: from mail-pf1-x432.google.com (mail-pf1-x432.google.com [IPv6:2607:f8b0:4864:20::432])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CD71DC061574
        for <linux-kernel@vger.kernel.org>; Mon, 24 May 2021 10:36:50 -0700 (PDT)
Received: by mail-pf1-x432.google.com with SMTP id f22so13024921pfn.0
        for <linux-kernel@vger.kernel.org>; Mon, 24 May 2021 10:36:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:mime-version:content-disposition;
        bh=aE0iQJWz3axz8pF6095x9rK/n7tnpnSurvnaFSIQj8o=;
        b=YrXVnXcfSwt5QnDj262YSEd1ENwB6g2QmZoeEPKL1B5oEsiw1CjPy6y6051sv0xpEj
         Y1cCdF2vpziIlWYbZAhQZiWqoRQ9OtIqHDiPWA6/bRFJMuASR+rqJ5ul27u9bBwY1XHa
         edFpnnTOq8KOg7KlV5w28fEXxyL/7icCBymLEEmJ7koo9Hl/ng3IE59lF60hBekYwTrB
         tqU1MlDrpB/h+gwF1PNg14aAghJt3iaQxGAtZfwyb7PiI98NX5ljM/sl344mCGZeRnEk
         pc/z5gXcgpGXNFUfw4mX2pMI1fqt6Y/e6r4rSHiBcUFigkCA4vI0e/Uhe8ICvz0Oc4Tz
         C0gA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:mime-version
         :content-disposition;
        bh=aE0iQJWz3axz8pF6095x9rK/n7tnpnSurvnaFSIQj8o=;
        b=o9rE6CVnv5GJfLLw3KmNqsLCLIB46hs+74e6ENlZgsLjo0yKA/iCg/97oFiGAJbZ2h
         O8yfVCVaHzfzmPnUIsj18TGgiT4XVfl6x6tQUbi6f+sgf84mOeoa1hD39hLYzQAQwwaw
         /QPLoiyiY45CynSje8AG/Ehn1YZHFQiLNQztlMqGBLOHPY/rkxixbo/+AbSZ6d7LabNS
         ViZmAfW+rctpDABzNvl6vwWwPeHGSRuHShyRfLtXE7JEMJfRoMxaCb1NombVu4qWJvVx
         ImmThyI6wN3wPJtyik3jTByW4Xe7MaPAB1SzhlaV6clYMyNQF+eew+JjoSmWL7ZsVZ0X
         KPUQ==
X-Gm-Message-State: AOAM532o2lKkOnKCMyQ6lqzu1mwkx8qSCEgiuXqui+sBpFuRoAnlEe4f
        YkgHnfAla08LvAfQ27eqrX8=
X-Google-Smtp-Source: ABdhPJy0q11L7l2xXWJxsf5+Q1oi9FNRJsdIZyEtXD1nJZh7r+SRNLa1ZW1O1cH133Lcskrdzfgxyw==
X-Received: by 2002:a62:d0c2:0:b029:2d9:529f:f4ef with SMTP id p185-20020a62d0c20000b02902d9529ff4efmr26270999pfg.41.1621877810401;
        Mon, 24 May 2021 10:36:50 -0700 (PDT)
Received: from hyeyoo ([183.99.11.150])
        by smtp.gmail.com with ESMTPSA id x29sm11951643pgl.49.2021.05.24.10.36.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 24 May 2021 10:36:49 -0700 (PDT)
Date:   Tue, 25 May 2021 02:36:44 +0900
From:   Hyeonggon Yoo <42.hyeyoo@gmail.com>
To:     Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Hyeonggon Yoo <42.hyeyoo@gmail.com>,
        Oliver Neukum <oneukum@suse.com>,
        Vasily Khoruzhick <anarsoul@gmail.com>
Cc:     alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org
Subject: [PATCH] ALSA: line6: Improve poor error handling in
 line6_init_cap_control
Message-ID: <20210524173644.GA116662@hyeyoo>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

line6_init_cap_control doesn't free resources properly when allocations
like kmalloc, usb_alloc_urb fails. It can cause memory leak when some
allocations succeed, and then an error occurs.

This patch makes line6_init_cap_control to properly free the resources,
freeing previously allocated resources when there's an error.

Signed-off-by: Hyeonggon Yoo <42.hyeyoo@gmail.com>
---
 sound/usb/line6/driver.c | 36 +++++++++++++++++++++++++++---------
 1 file changed, 27 insertions(+), 9 deletions(-)

diff --git a/sound/usb/line6/driver.c b/sound/usb/line6/driver.c
index 9602929b7de9..6991cb855023 100644
--- a/sound/usb/line6/driver.c
+++ b/sound/usb/line6/driver.c
@@ -688,34 +688,52 @@ static int line6_init_cap_control(struct usb_line6 *line6)
 
 	/* initialize USB buffers: */
 	line6->buffer_listen = kmalloc(LINE6_BUFSIZE_LISTEN, GFP_KERNEL);
-	if (!line6->buffer_listen)
-		return -ENOMEM;
+	if (!line6->buffer_listen) {
+		ret = -ENOMEM;
+		goto fail_ret;
+	}
 
 	line6->urb_listen = usb_alloc_urb(0, GFP_KERNEL);
-	if (!line6->urb_listen)
-		return -ENOMEM;
+	if (!line6->urb_listen) {
+		ret = -ENOMEM;
+		goto fail1;
+	}
 
 	if (line6->properties->capabilities & LINE6_CAP_CONTROL_MIDI) {
 		line6->buffer_message = kmalloc(LINE6_MIDI_MESSAGE_MAXLEN, GFP_KERNEL);
-		if (!line6->buffer_message)
-			return -ENOMEM;
+		if (!line6->buffer_message) {
+			ret = -ENOMEM;
+			goto fail2;
+		}
 
 		ret = line6_init_midi(line6);
 		if (ret < 0)
-			return ret;
+			goto fail3;
 	} else {
 		ret = line6_hwdep_init(line6);
 		if (ret < 0)
-			return ret;
+			goto fail2;
 	}
 
 	ret = line6_start_listen(line6);
 	if (ret < 0) {
 		dev_err(line6->ifcdev, "cannot start listening: %d\n", ret);
-		return ret;
+		if (line6->properties->capabilities & LINE6_CAP_CONTROL_MIDI)
+			goto fail3;
+		else
+			goto fail2;
 	}
 
 	return 0;
+
+fail3:
+	kfree(line6->buffer_message);
+fail2:
+	usb_free_urb(line6->urb_listen);
+fail1:
+	kfree(line6->buffer_listen);
+fail_ret:
+	return ret;
 }
 
 static void line6_startup_work(struct work_struct *work)
-- 
2.25.1

