Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6FC7038F530
	for <lists+linux-kernel@lfdr.de>; Mon, 24 May 2021 23:52:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233700AbhEXVxm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 24 May 2021 17:53:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48198 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232662AbhEXVxl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 May 2021 17:53:41 -0400
Received: from mail-pj1-x1031.google.com (mail-pj1-x1031.google.com [IPv6:2607:f8b0:4864:20::1031])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3F92FC061574
        for <linux-kernel@vger.kernel.org>; Mon, 24 May 2021 14:52:12 -0700 (PDT)
Received: by mail-pj1-x1031.google.com with SMTP id pi6-20020a17090b1e46b029015cec51d7cdso11951127pjb.5
        for <linux-kernel@vger.kernel.org>; Mon, 24 May 2021 14:52:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=1uWZ+NAHubgjanKEPmNXVpKwJ6EadaqwsLZyvUrqkaY=;
        b=goCM3ND7G1zeMucnRJt8nicQIOO+SOqc1h3FmK4+SIebD7dYEL3fL6HBrJrqQfGmWU
         si34CYLeIRc79Yf39VdhDjFJaDteeIQwMw0LGnJJ3sANRZ2PrUpNuLgOWy29HKPNfeVr
         M5efC8IWweo3GNUZw10VrALniXQ83Ck8IRKfyMY7Hi+q90cp4QRS+R8AnzGLFgqkTwRP
         LkH8V8klJsO1GtM0kozkENo8uaNeJepMvtB9xCNyztim18/PpS5Yh+ltke1WQAgqfYoE
         ZbrKxBpSIA/WShw3b+sBgMgEx15aYV9LmXzIv4dkuwgt1VgOfsCvZ27m4NHaHfN66kNl
         vguA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=1uWZ+NAHubgjanKEPmNXVpKwJ6EadaqwsLZyvUrqkaY=;
        b=rvAjwnqjpIMYPz1ST9ib8mVR5Jm8W0wL+LaiifNb2fqsKAhpkyXIUErQEajwsarIdt
         QnUnwTjmbPuIwxqW2Vv+PswdGBy3YJYU6zJMXiCEAsIiebSqkzoXmzDP2oz27CeiEJTf
         blxk/CB88r4U7ilM0zzsxqNX3fThzJE/+uJZl5JG3LSf2QSvTYk1WhSc8/4hAv2kl2AP
         cHr7asrg/i3Atu64uJO9vLehP6cdcXIVDP23046muLJHBCJdaOAhV0KS6nt6HK+V/RAh
         oBazAHxnqQtYl1P8eFYKmMsfy8f5ON91ljJtLgkshxQ0lCUhxPNZJF4slGYS819rF5Ha
         fWvQ==
X-Gm-Message-State: AOAM532qNBPmRQKwxeqcePHp3TAuIdRWgHWFfTJTQOb/z2uhRj/cwMd6
        NjOjVnhzcUdh2VXzX4XWEiOA1+mbADXQSm8I
X-Google-Smtp-Source: ABdhPJxTsHfRPS5HHKfpkTBhKoiFzNQgGu1KoN2fYoeM+jqUAPcFTYOTWd3c8JymzrI3EHkz93aq5A==
X-Received: by 2002:a17:90a:bd08:: with SMTP id y8mr1323187pjr.8.1621893131421;
        Mon, 24 May 2021 14:52:11 -0700 (PDT)
Received: from nhaiderx-mobl1.gar.corp.intel.com ([2409:4063:2309:9691:60bf:7a61:5dc3:9ca1])
        by smtp.gmail.com with ESMTPSA id n28sm5447800pfq.139.2021.05.24.14.52.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 24 May 2021 14:52:11 -0700 (PDT)
From:   nizamhaider786@gmail.com
To:     lkundrak@v3.sk
Cc:     arnd@arndb.de, gregkh@linuxfoundation.org,
        linux-kernel@vger.kernel.org,
        Nijam Haider <nizamhaider786@gmail.com>
Subject: [PATCH v3 1/2] char: pcmcia: scr24x_cs: Fix failure handling of device_create()
Date:   Tue, 25 May 2021 03:22:01 +0530
Message-Id: <20210524215202.495-1-nizamhaider786@gmail.com>
X-Mailer: git-send-email 2.31.1.windows.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Nijam Haider <nizamhaider786@gmail.com>

Ignored error in device_create() and pcmcia_enable_device()
this patch implements proper error handling.

Signed-off-by: Nijam Haider <nizamhaider786@gmail.com>
---
V2 -> V3: Added description, Changelog and removed whitespace error
V1 -> V2: Split the patch into two parts and addressed review comments
---
 drivers/char/pcmcia/scr24x_cs.c | 11 ++++++++++-
 1 file changed, 10 insertions(+), 1 deletion(-)

diff --git a/drivers/char/pcmcia/scr24x_cs.c b/drivers/char/pcmcia/scr24x_cs.c
index 47feb39af34c..b48e79356611 100644
--- a/drivers/char/pcmcia/scr24x_cs.c
+++ b/drivers/char/pcmcia/scr24x_cs.c
@@ -233,6 +233,7 @@ static int scr24x_probe(struct pcmcia_device *link)
 {
 	struct scr24x_dev *dev;
 	int ret;
+	struct device *dev_ret;
 
 	dev = kzalloc(sizeof(*dev), GFP_KERNEL);
 	if (!dev)
@@ -272,12 +273,20 @@ static int scr24x_probe(struct pcmcia_device *link)
 
 	ret = pcmcia_enable_device(link);
 	if (ret < 0) {
+		cdev_del(&dev->c_dev);
 		pcmcia_disable_device(link);
 		goto err;
 	}
 
-	device_create(scr24x_class, NULL, MKDEV(MAJOR(scr24x_devt), dev->devno),
+	dev_ret = device_create(scr24x_class, NULL, MKDEV(MAJOR(scr24x_devt), dev->devno),
 		      NULL, "scr24x%d", dev->devno);
+	if (IS_ERR(dev_ret)) {
+		dev_err(&link->dev, "device_create failed for %d\n",
+			dev->devno);
+		cdev_del(&dev->c_dev);
+		pcmcia_disable_device(link);
+		goto err;
+	}
 
 	dev_info(&link->dev, "SCR24x Chip Card Interface\n");
 	return 0;
-- 
2.7.4

