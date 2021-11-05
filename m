Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B3F69446733
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Nov 2021 17:42:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233242AbhKEQpc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 5 Nov 2021 12:45:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58052 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232930AbhKEQpb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 5 Nov 2021 12:45:31 -0400
Received: from mail-wr1-x42e.google.com (mail-wr1-x42e.google.com [IPv6:2a00:1450:4864:20::42e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8A7ABC061714
        for <linux-kernel@vger.kernel.org>; Fri,  5 Nov 2021 09:42:51 -0700 (PDT)
Received: by mail-wr1-x42e.google.com with SMTP id r8so14610503wra.7
        for <linux-kernel@vger.kernel.org>; Fri, 05 Nov 2021 09:42:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=fftvvpcviCHio0E7043Muy78rSgaoMH1Uvzaam7PMgM=;
        b=G2VrGFCEaT6XvHUKCE+rX86Xhaj+ovGldPhIDH3PgmxUzbREQi4e2M7BkpC/LIvigj
         jSMzApxZ4+itIl73db/SXSxR1ufYwBP8pn+uEBc7ugb2haAdERSWtM14gQ6Qgt8oH8Ud
         MPF3I9FEInJgcwXkKi3QnCHen/4QzBPnbHfr4In2k+5xx+r1hVhIcwQLYuaWT2V8wIDN
         z73f9pLjwocnhrLC3q7nH3c/pK3JyW6NpumByje3L2tT/rq8mX/4m6CuHzRlgALv9iAq
         xnaGEJm41BRjkKg6SqJABwv88dfEka9ms1kq0pKnmLtL8gkU069Xypmu9/c3ouiIwTC4
         9ztA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=fftvvpcviCHio0E7043Muy78rSgaoMH1Uvzaam7PMgM=;
        b=R5pJdwHGH+bug5tsUk4FlXX2OBVh88ag3jQxFjCMYwYvygXYmMHLYnYR/WeEZPWwNi
         oCNF2LilwWr8oj8c6A5NynErF62fCWcoyQd2q8GaMYiXT7kWlIsNeZs2HB6OpTVSx26o
         ZzwSbu07JY7CPaeL4qgcWMYI48K+XdaeCZhz4Z1oBGKYf1HvUb+dUpOBFtl9PVq3l340
         IA2oWHj502G8n0aE+Y0xNa1TDvwEuali1t26GA9mw4tphQ2JqOrQ1NthuuMHFQ1VMMY9
         YQBIfOdFjnWQbZpmI26aJ8hIg/ewyQSvWFmM6bFWt+VbsbyX7pBxK1W4HtZAKUwN6Ejq
         3DKw==
X-Gm-Message-State: AOAM531Cw8LZy2zNnT8zGp9ggJfsz73wsil9nNPOrE5t2gJ9uiWCHxlV
        eTD7GNQzE/6s1AXwtJ2f6dLFfg==
X-Google-Smtp-Source: ABdhPJyUdN9AAQJOIv8BrtNq5PG/GDZV2zRQCb7Jvr1QlnWAG+L7YkDEsD+6MsxQ3kdN9wY05y6Tuw==
X-Received: by 2002:a5d:4d8b:: with SMTP id b11mr49641462wru.393.1636130570115;
        Fri, 05 Nov 2021 09:42:50 -0700 (PDT)
Received: from localhost.localdomain ([95.148.6.174])
        by smtp.gmail.com with ESMTPSA id t189sm8040590wma.8.2021.11.05.09.42.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 05 Nov 2021 09:42:49 -0700 (PDT)
From:   Lee Jones <lee.jones@linaro.org>
To:     lee.jones@linaro.org
Cc:     linux-kernel@vger.kernel.org,
        Dongliang Mu <mudongliangabcd@gmail.com>,
        syzbot+44d53c7255bb1aea22d2@syzkaller.appspotmail.com,
        "David S . Miller" <davem@davemloft.net>
Subject: [PATCH v4.4.y 1/1] usb: hso: fix error handling code of hso_create_net_device
Date:   Fri,  5 Nov 2021 16:42:45 +0000
Message-Id: <20211105164245.2732082-1-lee.jones@linaro.org>
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
index fa3f1b8700aa8..b35a887ba5944 100644
--- a/drivers/net/usb/hso.c
+++ b/drivers/net/usb/hso.c
@@ -2522,7 +2522,7 @@ static struct hso_device *hso_create_net_device(struct usb_interface *interface,
 			   hso_net_init);
 	if (!net) {
 		dev_err(&interface->dev, "Unable to create ethernet device\n");
-		goto exit;
+		goto err_hso_dev;
 	}
 
 	hso_net = netdev_priv(net);
@@ -2535,13 +2535,13 @@ static struct hso_device *hso_create_net_device(struct usb_interface *interface,
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
@@ -2551,21 +2551,21 @@ static struct hso_device *hso_create_net_device(struct usb_interface *interface,
 		hso_net->mux_bulk_rx_urb_pool[i] = usb_alloc_urb(0, GFP_KERNEL);
 		if (!hso_net->mux_bulk_rx_urb_pool[i]) {
 			dev_err(&interface->dev, "Could not allocate rx urb\n");
-			goto exit;
+			goto err_mux_bulk_rx;
 		}
 		hso_net->mux_bulk_rx_buf_pool[i] = kzalloc(MUX_BULK_RX_BUF_SIZE,
 							   GFP_KERNEL);
 		if (!hso_net->mux_bulk_rx_buf_pool[i])
-			goto exit;
+			goto err_mux_bulk_rx;
 	}
 	hso_net->mux_bulk_tx_urb = usb_alloc_urb(0, GFP_KERNEL);
 	if (!hso_net->mux_bulk_tx_urb) {
 		dev_err(&interface->dev, "Could not allocate tx urb\n");
-		goto exit;
+		goto err_mux_bulk_rx;
 	}
 	hso_net->mux_bulk_tx_buf = kzalloc(MUX_BULK_TX_BUF_SIZE, GFP_KERNEL);
 	if (!hso_net->mux_bulk_tx_buf)
-		goto exit;
+		goto err_free_tx_urb;
 
 	add_net_device(hso_dev);
 
@@ -2573,7 +2573,7 @@ static struct hso_device *hso_create_net_device(struct usb_interface *interface,
 	result = register_netdev(net);
 	if (result) {
 		dev_err(&interface->dev, "Failed to register device\n");
-		goto exit;
+		goto err_free_tx_buf;
 	}
 
 	hso_log_port(hso_dev);
@@ -2581,8 +2581,21 @@ static struct hso_device *hso_create_net_device(struct usb_interface *interface,
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

