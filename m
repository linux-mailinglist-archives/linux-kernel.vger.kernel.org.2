Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5337332A035
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Mar 2021 14:07:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1575518AbhCBD4b (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 1 Mar 2021 22:56:31 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36550 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344872AbhCAXCv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Mar 2021 18:02:51 -0500
Received: from mail-lf1-x131.google.com (mail-lf1-x131.google.com [IPv6:2a00:1450:4864:20::131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9D94DC061756;
        Mon,  1 Mar 2021 15:02:08 -0800 (PST)
Received: by mail-lf1-x131.google.com with SMTP id v9so10450424lfa.1;
        Mon, 01 Mar 2021 15:02:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=3mPp40AUhbsnKl/pbYjlZ7ypcuT/iGIJ4xR8gm1e1pQ=;
        b=UYqa36UZPmzn81Z+vlXZrf71q0aNgOFXH8hZPj7fG/RbxSVvhX+UqzaY4p3kRvaLhh
         GJeU3sGpELzvgOYobxeNS8gGFV7SpFFJc4Le+O0ZXYfxqwDwduDuiydrNOUw5t4P9vcB
         GD6hCcJKMqLMGz5/z7ideLnU3clBs7A6N8a7/X13yJEhUH8ggg4H4XeE4U2ZeMVV9if4
         mvMX7V5Wf9jSr08hD+/GXZzRWetUOZvw0busAy0+ZfLmzutGuNc8e+8HPU9f5JScVmCw
         bLAC/AgzK1h+fRSHnVd+y0coOsNzTSAP4l1VgKHbhmu/ntvgzeNqW/3zzbFVHIb7Ebni
         KxxQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=3mPp40AUhbsnKl/pbYjlZ7ypcuT/iGIJ4xR8gm1e1pQ=;
        b=C/82mpq54/wj3S63kwtzbUAeF4ZtILDbPoGBnRCFpQ58o61XplvDaMyTlTr35MvM5o
         lKj/prUQf1AsjcEfjmROD+W2sJpeDrbo5p7pm4K/sROGT++kNO3y0Cz/vwbzXuc/WCfu
         7Y/uNwghykQH30ptBUmOM9cbzMYHvo7r8tyv4bN6kiHyAFOK14fT1Gws63sNNXcUcddV
         9k6lPGyvwPcDkA5aK6Lpo5UbfV2Uan/eVeJAW4UEcdAghz/eaQNrOsGoGZkqLPC/eL21
         8mLNyMM4mScucurc4R8vA+u9BKgRgniWyM5sLVtXMd+jduT1CiyKQzI2+Eq8xJfbpVIt
         2bjw==
X-Gm-Message-State: AOAM532WzANJdXIE2JVg1npzUbv15elJg8qjpR8Vg7gj8ryJy2v83Ebx
        HUJFawlNV6ryveM/KJ4wuuQ=
X-Google-Smtp-Source: ABdhPJyxGuwO7i4pyWRbtBuyqIT6ZddzTc/BEGKMvQ0yrhDI0RdpOIGeiG/g8VYT4wutPvas8wfVAw==
X-Received: by 2002:ac2:5ec1:: with SMTP id d1mr10292008lfq.48.1614639726988;
        Mon, 01 Mar 2021 15:02:06 -0800 (PST)
Received: from localhost.localdomain ([94.103.235.167])
        by smtp.gmail.com with ESMTPSA id x27sm1152071lfn.95.2021.03.01.15.02.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 01 Mar 2021 15:02:06 -0800 (PST)
From:   Pavel Skripkin <paskripkin@gmail.com>
To:     johan@kernel.org, gregkh@linuxfoundation.org
Cc:     linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org,
        Pavel Skripkin <paskripkin@gmail.com>,
        syzbot+59f777bdcbdd7eea5305@syzkaller.appspotmail.com
Subject: [PATCH] usb: serial: io_edgeport: fix memory leak in edge_startup
Date:   Tue,  2 Mar 2021 02:01:52 +0300
Message-Id: <20210301230152.527093-1-paskripkin@gmail.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

sysbot found memory leak in edge_startup().
The problem was that when an error was received from the usb_submit_urb(),
nothing was cleaned up.

Reported-by: syzbot+59f777bdcbdd7eea5305@syzkaller.appspotmail.com
Signed-off-by: Pavel Skripkin <paskripkin@gmail.com>
---
 drivers/usb/serial/io_edgeport.c | 26 ++++++++++++++++----------
 1 file changed, 16 insertions(+), 10 deletions(-)

diff --git a/drivers/usb/serial/io_edgeport.c b/drivers/usb/serial/io_edgeport.c
index a493670c06e6..68401adcffde 100644
--- a/drivers/usb/serial/io_edgeport.c
+++ b/drivers/usb/serial/io_edgeport.c
@@ -3003,26 +3003,32 @@ static int edge_startup(struct usb_serial *serial)
 				response = -ENODEV;
 			}
 
-			usb_free_urb(edge_serial->interrupt_read_urb);
-			kfree(edge_serial->interrupt_in_buffer);
-
-			usb_free_urb(edge_serial->read_urb);
-			kfree(edge_serial->bulk_in_buffer);
-
-			kfree(edge_serial);
-
-			return response;
+			goto error;
 		}
 
 		/* start interrupt read for this edgeport this interrupt will
 		 * continue as long as the edgeport is connected */
 		response = usb_submit_urb(edge_serial->interrupt_read_urb,
 								GFP_KERNEL);
-		if (response)
+		if (response) {
 			dev_err(ddev, "%s - Error %d submitting control urb\n",
 				__func__, response);
+
+			goto error;
+		}
 	}
 	return response;
+
+error:
+	usb_free_urb(edge_serial->interrupt_read_urb);
+	kfree(edge_serial->interrupt_in_buffer);
+
+	usb_free_urb(edge_serial->read_urb);
+	kfree(edge_serial->bulk_in_buffer);
+
+	kfree(edge_serial);
+
+	return response;
 }
 
 
-- 
2.25.1

