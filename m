Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4DC10361B6F
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Apr 2021 10:34:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240283AbhDPIJP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 16 Apr 2021 04:09:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43324 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240252AbhDPIJK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 16 Apr 2021 04:09:10 -0400
Received: from mail-wm1-x336.google.com (mail-wm1-x336.google.com [IPv6:2a00:1450:4864:20::336])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 03C27C061574;
        Fri, 16 Apr 2021 01:08:46 -0700 (PDT)
Received: by mail-wm1-x336.google.com with SMTP id n127so2019154wmb.5;
        Fri, 16 Apr 2021 01:08:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:mime-version:content-disposition;
        bh=3fxufJIKY9M0ESBy2+S1qlqYMJSKzUOHQ6YV4z83AzU=;
        b=fCkmtgEfV100eUu8UAne1zSXWjUQ3uIRWP1wQCBKCM9aHDsFfiaDJv4lqaQvoI4YEJ
         fMwuEI/ke9t6dDRDRCkCXqD30xrtmZLrqFV9WQjEe4bfuHEgNRMIbI7SDYkF8Zic+OrQ
         y0tFJIaQ8DBcW8dkplQ4Xi2xhByHuqGRs7t2oNpQkuiubzh6mGlm6+Gmn6/dEt2QZXpx
         iq/JvcsFZZMCpmOFbPm7GCpkHH+P0PzCxbgcoZaUYypYtcMB0gw7sEmkkJQ8T17c1IUi
         lI6NhWOgsg6EOkrus1gjB6bl3wOB9kIU+q/2TOqHdvpBIUXcmT5JYWOSLc0BrSv5LlY3
         KThQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:mime-version
         :content-disposition;
        bh=3fxufJIKY9M0ESBy2+S1qlqYMJSKzUOHQ6YV4z83AzU=;
        b=NCITGP03KpqB1dgned9Ir8lvxTho7+gO4AfcY1pVFNT/Pp8ybRY/sMG6k9H7KBgk40
         2ukd+ekXxHJvy/5kHyIZFb2bl1lpcXn3DqZbo2C7QH77zNmNwrT2l88juqvirk7Lntv5
         +EKMMF5NiLJ/BbWAZc1jdczhC+kqzpdufV5cAiGx/bugNaYndbyf78g2GcKLet2tx+BY
         yX5BYOyOV4ZqDwKiZfWplofoUODk+iNQFMf6s+UsmfIKFr8nOwxfmy/pCjQpiSjJviVB
         iGKOjOrhUo0fXA+mGanv5Za/09QTJa1FWxTG4itwm0knfuz7TgjxB2635fNIKCURo8Rj
         Ci5Q==
X-Gm-Message-State: AOAM533wfsBBUzspJccZ/O6fLfX68RXI7/voHFkVGQPHsWvucpj5V4pt
        xwLIQIJKN7RhHMlTb/zVjp6xvBqlQOlXtg==
X-Google-Smtp-Source: ABdhPJz+Aqy2dlorvethG/BD83GHwM/hMdQRX11Z61JhM2x2P2PEAKvIPGP1l9DT/vHP7HTLYUrqfA==
X-Received: by 2002:a7b:c346:: with SMTP id l6mr7026599wmj.34.1618560524809;
        Fri, 16 Apr 2021 01:08:44 -0700 (PDT)
Received: from localhost (200116b8206a30116607e2acfb3e7251.dip.versatel-1u1.de. [2001:16b8:206a:3011:6607:e2ac:fb3e:7251])
        by smtp.gmail.com with ESMTPSA id k11sm5192808wrx.88.2021.04.16.01.08.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 16 Apr 2021 01:08:44 -0700 (PDT)
Date:   Fri, 16 Apr 2021 10:08:43 +0200
From:   Malte Deiseroth <mdeiseroth88@gmail.com>
To:     gregkh@linuxfoundation.org
Cc:     linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] usb: misc: adutux: fix whitespace coding style issue
Message-ID: <20210416080843.GA137657@utop>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Correct missing space error ceckpatch.pl is complaining about.

Signed-off-by: Malte Deiseroth <mdeiseroth88@gmail.com>
---
 drivers/usb/misc/adutux.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/usb/misc/adutux.c b/drivers/usb/misc/adutux.c
index 45a387979935..6d15a097b007 100644
--- a/drivers/usb/misc/adutux.c
+++ b/drivers/usb/misc/adutux.c
@@ -183,10 +183,10 @@ static void adu_interrupt_in_callback(struct urb *urb)
 				dev->interrupt_in_buffer, urb->actual_length);
 
 			dev->read_buffer_length += urb->actual_length;
-			dev_dbg(&dev->udev->dev,"%s reading  %d\n", __func__,
+			dev_dbg(&dev->udev->dev, "%s reading  %d\n", __func__,
 				urb->actual_length);
 		} else {
-			dev_dbg(&dev->udev->dev,"%s : read_buffer overflow\n",
+			dev_dbg(&dev->udev->dev, "%s : read_buffer overflow\n",
 				__func__);
 		}
 	}
@@ -726,7 +726,7 @@ static int adu_probe(struct usb_interface *interface,
 		retval = -EIO;
 		goto error;
 	}
-	dev_dbg(&interface->dev,"serial_number=%s", dev->serial_number);
+	dev_dbg(&interface->dev, "serial_number=%s", dev->serial_number);
 
 	/* we can register the device now, as it is ready */
 	usb_set_intfdata(interface, dev);
-- 
2.27.0

