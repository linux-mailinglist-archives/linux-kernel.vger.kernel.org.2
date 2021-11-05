Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 57346446734
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Nov 2021 17:43:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233338AbhKEQpj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 5 Nov 2021 12:45:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58088 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232930AbhKEQpi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 5 Nov 2021 12:45:38 -0400
Received: from mail-wm1-x32d.google.com (mail-wm1-x32d.google.com [IPv6:2a00:1450:4864:20::32d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E3BB8C061714
        for <linux-kernel@vger.kernel.org>; Fri,  5 Nov 2021 09:42:58 -0700 (PDT)
Received: by mail-wm1-x32d.google.com with SMTP id a20-20020a1c7f14000000b003231d13ee3cso9955612wmd.3
        for <linux-kernel@vger.kernel.org>; Fri, 05 Nov 2021 09:42:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=2LaFxAyiWOhU4WhH+gJn2JlkMKiYeke8XTSsrsf3uN4=;
        b=myF95Nx0DEj6Yg6oz4+t2ACNhTyGdZMX0zDhF2YiW9VCxwSux4BNmrMd6la+qw9pkF
         9364Ckxp2wC25dTer7S6b6a7zgeDpeYXgLhwv4dUfkLw3gNWY43fJ+MLPho0+wFdtas5
         y+ECFYHl2v9UKjwKQzVowbY6J6L5Fpp4IvTU7f653ecrbENfwfH5BTQwn9ZTmW9i5vcc
         pKJI0aExNDXoqEdaOw/oqTd+dnkcRS8Y9WdtfwWmJCfqltFwAnN47/xSC95g34tsbdJX
         Chc/Mh6gIGaYzFxde1zuYvwjh+OFjVJpyVn0IgYZye0iVMtE9PUUsBRaRF7c7UTemhIf
         h4YA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=2LaFxAyiWOhU4WhH+gJn2JlkMKiYeke8XTSsrsf3uN4=;
        b=kunXG0Ce3l/Sl8szkJQo7JynTK7A5JXkznrCWGzBXoyEgfAne10NzIXsv9d97gdwPT
         qHewVq0KV5Qzu1RbdaS7T7iCXfYPxzmTMQowD+ehKxDdHMqWFF3Udlx198ywmYzozclE
         x+bQXTHamgjYn3d98EY84ZxMYiLbiLbJGOBX2lMAuNODd9gulqAx6gqvOObfKQzPlojL
         WDd7tcQF2fbbqJ713UeCgVRC5r6/sCXZvKnUrZOSXXVSlO3G6YzEP3S7JRyH38I9dw8y
         Yj0JwkPo6yCUGvklAEds8shwWy0zKrAVxzeDNczoeyXCq/5FsCcST9y0FcInj2TEOEbX
         7PzA==
X-Gm-Message-State: AOAM530BKgXXZW4ppGD1PBnG3Qlpe6z/Kcum9fHdba3zNDGlu8nqdyIw
        3USPhBY7xJgPEPy5uMBBUp4WqA==
X-Google-Smtp-Source: ABdhPJxlI5ylXPVLEsQI7pTTo+C1Ywq///L1tIlKVdusKMvlko2ve+LmPU5YE0RLPZGRfwBqBnzhJQ==
X-Received: by 2002:a05:600c:245:: with SMTP id 5mr16559403wmj.166.1636130577557;
        Fri, 05 Nov 2021 09:42:57 -0700 (PDT)
Received: from localhost.localdomain ([95.148.6.174])
        by smtp.gmail.com with ESMTPSA id s26sm6189993wmc.0.2021.11.05.09.42.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 05 Nov 2021 09:42:57 -0700 (PDT)
From:   Lee Jones <lee.jones@linaro.org>
To:     lee.jones@linaro.org
Cc:     linux-kernel@vger.kernel.org,
        Dongliang Mu <mudongliangabcd@gmail.com>,
        syzbot+44d53c7255bb1aea22d2@syzkaller.appspotmail.com,
        "David S . Miller" <davem@davemloft.net>
Subject: [PATCH v4.9.y 1/1] usb: hso: fix error handling code of hso_create_net_device
Date:   Fri,  5 Nov 2021 16:42:53 +0000
Message-Id: <20211105164253.2732124-1-lee.jones@linaro.org>
X-Mailer: git-send-email 2.34.0.rc0.344.g81b53c2807-goog
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Dongliang Mu <mudongliangabcd@gmail.com>

[ Upstream commit a6ecfb39ba9d7316057cea823b196b734f6b18ca ]

The current error handling code of hso_create_net_device is
hso_free_net_device, no matter which errors lead to. For example,
WARNING in hso_free_net_device [1].

Fix this by refactoring the error handling code of
hso_create_net_device by handling different errors by different code.

[1] https://syzkaller.appspot.com/bug?id=66eff8d49af1b28370ad342787413e35bbe76efe

Reported-by: syzbot+44d53c7255bb1aea22d2@syzkaller.appspotmail.com
Fixes: 5fcfb6d0bfcd ("hso: fix bailout in error case of probe")
Signed-off-by: Dongliang Mu <mudongliangabcd@gmail.com>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Lee Jones <lee.jones@linaro.org>
---
 drivers/net/usb/hso.c | 33 +++++++++++++++++++++++----------
 1 file changed, 23 insertions(+), 10 deletions(-)

diff --git a/drivers/net/usb/hso.c b/drivers/net/usb/hso.c
index fc1ba1e808e1a..a3a3d4b40a7cc 100644
--- a/drivers/net/usb/hso.c
+++ b/drivers/net/usb/hso.c
@@ -2512,7 +2512,7 @@ static struct hso_device *hso_create_net_device(struct usb_interface *interface,
 			   hso_net_init);
 	if (!net) {
 		dev_err(&interface->dev, "Unable to create ethernet device\n");
-		goto exit;
+		goto err_hso_dev;
 	}
 
 	hso_net = netdev_priv(net);
@@ -2525,13 +2525,13 @@ static struct hso_device *hso_create_net_device(struct usb_interface *interface,
 				      USB_DIR_IN);
 	if (!hso_net->in_endp) {
 		dev_err(&interface->dev, "Can't find BULK IN endpoint\n");
-		goto exit;
+		goto err_net;
 	}
 	hso_net->out_endp = hso_get_ep(interface, USB_ENDPOINT_XFER_BULK,
 				       USB_DIR_OUT);
 	if (!hso_net->out_endp) {
 		dev_err(&interface->dev, "Can't find BULK OUT endpoint\n");
-		goto exit;
+		goto err_net;
 	}
 	SET_NETDEV_DEV(net, &interface->dev);
 	SET_NETDEV_DEVTYPE(net, &hso_type);
@@ -2540,18 +2540,18 @@ static struct hso_device *hso_create_net_device(struct usb_interface *interface,
 	for (i = 0; i < MUX_BULK_RX_BUF_COUNT; i++) {
 		hso_net->mux_bulk_rx_urb_pool[i] = usb_alloc_urb(0, GFP_KERNEL);
 		if (!hso_net->mux_bulk_rx_urb_pool[i])
-			goto exit;
+			goto err_mux_bulk_rx;
 		hso_net->mux_bulk_rx_buf_pool[i] = kzalloc(MUX_BULK_RX_BUF_SIZE,
 							   GFP_KERNEL);
 		if (!hso_net->mux_bulk_rx_buf_pool[i])
-			goto exit;
+			goto err_mux_bulk_rx;
 	}
 	hso_net->mux_bulk_tx_urb = usb_alloc_urb(0, GFP_KERNEL);
 	if (!hso_net->mux_bulk_tx_urb)
-		goto exit;
+		goto err_mux_bulk_rx;
 	hso_net->mux_bulk_tx_buf = kzalloc(MUX_BULK_TX_BUF_SIZE, GFP_KERNEL);
 	if (!hso_net->mux_bulk_tx_buf)
-		goto exit;
+		goto err_free_tx_urb;
 
 	add_net_device(hso_dev);
 
@@ -2559,7 +2559,7 @@ static struct hso_device *hso_create_net_device(struct usb_interface *interface,
 	result = register_netdev(net);
 	if (result) {
 		dev_err(&interface->dev, "Failed to register device\n");
-		goto exit;
+		goto err_free_tx_buf;
 	}
 
 	hso_log_port(hso_dev);
@@ -2567,8 +2567,21 @@ static struct hso_device *hso_create_net_device(struct usb_interface *interface,
 	hso_create_rfkill(hso_dev, interface);
 
 	return hso_dev;
-exit:
-	hso_free_net_device(hso_dev);
+
+err_free_tx_buf:
+	remove_net_device(hso_dev);
+	kfree(hso_net->mux_bulk_tx_buf);
+err_free_tx_urb:
+	usb_free_urb(hso_net->mux_bulk_tx_urb);
+err_mux_bulk_rx:
+	for (i = 0; i < MUX_BULK_RX_BUF_COUNT; i++) {
+		usb_free_urb(hso_net->mux_bulk_rx_urb_pool[i]);
+		kfree(hso_net->mux_bulk_rx_buf_pool[i]);
+	}
+err_net:
+	free_netdev(net);
+err_hso_dev:
+	kfree(hso_dev);
 	return NULL;
 }
 
-- 
2.34.0.rc0.344.g81b53c2807-goog

