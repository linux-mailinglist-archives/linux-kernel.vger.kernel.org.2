Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8E3BE326A70
	for <lists+linux-kernel@lfdr.de>; Sat, 27 Feb 2021 00:39:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230101AbhBZXht (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 26 Feb 2021 18:37:49 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56060 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230084AbhBZXhq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 Feb 2021 18:37:46 -0500
Received: from mail-lf1-x12e.google.com (mail-lf1-x12e.google.com [IPv6:2a00:1450:4864:20::12e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7BD43C06174A
        for <linux-kernel@vger.kernel.org>; Fri, 26 Feb 2021 15:37:05 -0800 (PST)
Received: by mail-lf1-x12e.google.com with SMTP id m22so16334856lfg.5
        for <linux-kernel@vger.kernel.org>; Fri, 26 Feb 2021 15:37:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=KnW56IPe7cM7eCh2ZZGsMpvgk4gpaWE3V70afPWQ50k=;
        b=i0VsPR9TqJH+J5frRPFJChOV4n5vJP36V+O6vs8sP6XqRJEfn1wyPw1kkG+4WH3FFM
         k5SOHnCGkjyNctAv3xdqUniMrHSnjmqSWILX473ODr/O6AT6qFRxodMSlmjPQywmmbGK
         +iQHWIWnRXQhD0sxJ5sKVyJMPe1oku1QBF3x9Cn1WeioGoocKdewJvBCiDRuji+BOkLK
         aGKH1XQ9B0vGifZn+DEq+sSnnFjsMUSUmo9o7FLjKDWOX7cBtflf/HkggUEtzLusIOVt
         3rDOYvxqgmEkKwD9Fbaf8hqiRzNFihsTj7Nbp6lYQ6tUObWWS1K6B8URR519kzJ8KPoK
         w0RA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=KnW56IPe7cM7eCh2ZZGsMpvgk4gpaWE3V70afPWQ50k=;
        b=Z7psGcSrmBEGz+6yndwQSjLK6p0C+n1XkfdZU5EiKMqbLkcyxn9g3EtPFveHvLsoFf
         xmOTeoA1/RwmUgjve4kuDmOxMbc5ShYIekD5G7GrsFJhpuK584HAARqG6lqgq5SSaBvr
         6Mh/VQSDNfzRIb1Skpfh8kqoow6OhRCQjZm87Tyxvi6Pk6TGE01dYsR5A4RGJvlfD0dW
         /N/FeVZXNEIuvYnZXppgrvUC1uqlXdaOe9p6SMz+98cfoT/COUXOEPV2iHVQeSjz+MMe
         BrCOLy3o1fj7Xy1NmaeYrZRZqPbuIHilZ6uyXtisN10m76Ka4IIwDAMBfO8GxdiSgPZj
         JxEQ==
X-Gm-Message-State: AOAM531C4ggYnCrCiK+uJrndau4qowazBRBIxrj13zkoMIb7y67mRpnl
        9i/3xnH5toivIqXKwVVncaw=
X-Google-Smtp-Source: ABdhPJxJLDHwTi3U5hWQY1ONmdavdzqX6fx63a8+zqaywZkoxuUQ+nevEGg0urxfzv0RzEP0RYUOOg==
X-Received: by 2002:a05:6512:118e:: with SMTP id g14mr2892739lfr.205.1614382623993;
        Fri, 26 Feb 2021 15:37:03 -0800 (PST)
Received: from localhost.localdomain ([94.103.235.59])
        by smtp.gmail.com with ESMTPSA id u13sm1576982lju.37.2021.02.26.15.37.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 26 Feb 2021 15:37:03 -0800 (PST)
From:   Pavel Skripkin <paskripkin@gmail.com>
To:     blacktea322@gmail.com
Cc:     linux-kernel@vger.kernel.org,
        Pavel Skripkin <paskripkin@gmail.com>,
        syzbot+e7f4c64a4248a0340c37@syzkaller.appspotmail.com
Subject: [PATCH] drivers/media/usb/gspca/stv06xx: fix memory leak
Date:   Sat, 27 Feb 2021 02:37:01 +0300
Message-Id: <20210226233701.614487-1-paskripkin@gmail.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Syzbot reported memory leak in hdcs_probe_1x00()[1].
hdcs_probe_1x00() allocates memory for struct hdcs, but if hdcs_init() fails in gspca_dev_probe2()
this memory becomes leaked.

int gspca_dev_probe2(struct usb_interface *intf,
		const struct usb_device_id *id,
		const struct sd_desc *sd_desc,
		int dev_size,
		struct module *module)
{
...

	ret = sd_desc->config(gspca_dev, id);
	if (ret < 0)
		goto out;
	ret = sd_desc->init(gspca_dev);
	if (ret < 0)
		goto out;
...
out:
	if (gspca_dev->input_dev)
		input_unregister_device(gspca_dev->input_dev);
	v4l2_ctrl_handler_free(gspca_dev->vdev.ctrl_handler);
	v4l2_device_unregister(&gspca_dev->v4l2_dev);
	kfree(gspca_dev->usb_buf);
	kfree(gspca_dev);
	return ret;
}

Reported-by: syzbot+e7f4c64a4248a0340c37@syzkaller.appspotmail.com
Signed-off-by: Pavel Skripkin <paskripkin@gmail.com>
Change-Id: Ia198671177ee346de61780813025110c7c491d7a
---
 drivers/media/usb/gspca/stv06xx/stv06xx_hdcs.c | 12 ++++++++----
 1 file changed, 8 insertions(+), 4 deletions(-)

diff --git a/drivers/media/usb/gspca/stv06xx/stv06xx_hdcs.c b/drivers/media/usb/gspca/stv06xx/stv06xx_hdcs.c
index 5a47dcbf1c8e..24df13b33a02 100644
--- a/drivers/media/usb/gspca/stv06xx/stv06xx_hdcs.c
+++ b/drivers/media/usb/gspca/stv06xx/stv06xx_hdcs.c
@@ -485,7 +485,7 @@ static int hdcs_init(struct sd *sd)
 					   stv_bridge_init[i][1]);
 	}
 	if (err < 0)
-		return err;
+		goto error;
 
 	/* sensor soft reset */
 	hdcs_reset(sd);
@@ -496,12 +496,12 @@ static int hdcs_init(struct sd *sd)
 					     stv_sensor_init[i][1]);
 	}
 	if (err < 0)
-		return err;
+		goto error;
 
 	/* Enable continuous frame capture, bit 2: stop when frame complete */
 	err = stv06xx_write_sensor(sd, HDCS_REG_CONFIG(sd), BIT(3));
 	if (err < 0)
-		return err;
+		goto error;
 
 	/* Set PGA sample duration
 	(was 0x7E for the STV602, but caused slow framerate with HDCS-1020) */
@@ -512,9 +512,13 @@ static int hdcs_init(struct sd *sd)
 		err = stv06xx_write_sensor(sd, HDCS_TCTRL,
 				(HDCS_ADC_START_SIG_DUR << 5) | hdcs->psmp);
 	if (err < 0)
-		return err;
+		goto error;
 
 	return hdcs_set_size(sd, hdcs->array.width, hdcs->array.height);
+
+error:
+	kfree(hdcs);
+	return err;
 }
 
 static int hdcs_dump(struct sd *sd)
-- 
2.25.1

