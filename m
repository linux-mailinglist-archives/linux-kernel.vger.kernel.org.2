Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0005D3CA0F7
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Jul 2021 16:52:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238108AbhGOOzH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 15 Jul 2021 10:55:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58144 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238076AbhGOOzF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Jul 2021 10:55:05 -0400
Received: from mail-pj1-x104a.google.com (mail-pj1-x104a.google.com [IPv6:2607:f8b0:4864:20::104a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BB718C06175F
        for <linux-kernel@vger.kernel.org>; Thu, 15 Jul 2021 07:52:11 -0700 (PDT)
Received: by mail-pj1-x104a.google.com with SMTP id s18-20020a17090aba12b029017556bfce53so3692484pjr.5
        for <linux-kernel@vger.kernel.org>; Thu, 15 Jul 2021 07:52:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=G+OSuGiOQklLZymMFCTnttGx/CFqtpqkpXlERNqy3WE=;
        b=gqIJh2s7wmvsRX3Dj0IG07hc4eEq80GIOGi1lQv/P7dMzkW7Ah21y7ZsWZ7/lTiymv
         JZC8xVnlyUXMn0OwUMK+i77E1zy28v8vFyO7q9sJIa3WD4bkekPSNnz1ddPp1yhfmeP4
         s1ZXzMLYjLz1EcH7YOG1RFh1wQP1ukGPHIVmgsKX15LeECtWIRrWqDVMJPA6Gx5M4OEe
         gMhYV/8RbA2AZxHfytn36Uxvob46KtyhbW9tQ2xbGyxzWvHSUqQmCAsU92/4iT6r3Uiw
         r0PY9xhmThnJtgH5/hbwXMvTvjO7UL1wdt0U/oflGeetnn35yDe07v/ZkGU6zRSiogfj
         bWig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=G+OSuGiOQklLZymMFCTnttGx/CFqtpqkpXlERNqy3WE=;
        b=Gby9HMYIzlvyPs/o4BOLas9MyKC5ifPImjpsdzECb/zym7cAt/4Mu2y2Q2TjOqkhUH
         cG2yyNKqYA5tpREyg9axcnVb2enaAdLTFXwpdgVoOecoVNaAIf4bddcGOTFxbHQ1ef/D
         gBkiYmqkHf+GObszTXeLT5zdBB7UpaqsUBBKv6VpGpZhHXKuYpTpn94HbbPbLqXId/u2
         4FIwKAZw4ekH7Ql61dbRuJj2+UJG7HCUgxICgPtRawFpguFD6RcNQA22+KVTizyoX0vc
         GyN585cU4nw3yVCIDK/ZU7qixF1K0SryR4gEHxLBBTYZLAQtpMC0Zd8xTwFP6urSlDwM
         HpSQ==
X-Gm-Message-State: AOAM5316GPpegIe3tulC28ivrnlINGqonZGAvcSi26JSU4LZlArqN0EZ
        /OnjE1bDsQelmUefjDcQoPJVdN92GM1a
X-Google-Smtp-Source: ABdhPJw+PADg00qqa82z+TAch21RdtQtw0XRKi81eKrrsyNFFYQ6eyyU2Vw/R45PWxlKj0Z6vuQG3XwTdoFg
X-Received: from apusaka-p920.tpe.corp.google.com ([2401:fa00:1:10:d9e1:875d:57dd:2e32])
 (user=apusaka job=sendgmr) by 2002:aa7:9e5c:0:b029:32b:4e2a:e549 with SMTP id
 z28-20020aa79e5c0000b029032b4e2ae549mr5136047pfq.68.1626360731307; Thu, 15
 Jul 2021 07:52:11 -0700 (PDT)
Date:   Thu, 15 Jul 2021 22:51:59 +0800
In-Reply-To: <20210715225146.v2.1.I68649745bd11a83265f1e816bf34ecc82775e95a@changeid>
Message-Id: <20210715225146.v2.2.I404c6df9cdab270223c13e867396f440dd4b499d@changeid>
Mime-Version: 1.0
References: <20210715225146.v2.1.I68649745bd11a83265f1e816bf34ecc82775e95a@changeid>
X-Mailer: git-send-email 2.32.0.93.g670b81a890-goog
Subject: [PATCH v2 2/3] Bluetooth: hci_h5: btrtl: Maintain flow control if
 wakeup is enabled
From:   Archie Pusaka <apusaka@google.com>
To:     linux-bluetooth <linux-bluetooth@vger.kernel.org>,
        Marcel Holtmann <marcel@holtmann.org>
Cc:     CrosBT Upstreaming <chromeos-bluetooth-upstreaming@chromium.org>,
        Archie Pusaka <apusaka@chromium.org>,
        Abhishek Pandit-Subedi <abhishekpandit@chromium.org>,
        Hilda Wu <hildawu@realtek.com>,
        Johan Hedberg <johan.hedberg@gmail.com>,
        Luiz Augusto von Dentz <luiz.dentz@gmail.com>,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Archie Pusaka <apusaka@chromium.org>

For chips that doesn't reset on suspend, we need to provide the correct
value of flow_control when it resumes. Therefore, store the flow
control value when reading from the config file to be reused upon
suspend.

Signed-off-by: Archie Pusaka <apusaka@chromium.org>
Reviewed-by: Abhishek Pandit-Subedi <abhishekpandit@chromium.org>
Reviewed-by: Hilda Wu <hildawu@realtek.com>

---

(no changes since v1)

 drivers/bluetooth/hci_h5.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/drivers/bluetooth/hci_h5.c b/drivers/bluetooth/hci_h5.c
index fd672111a048..cbc63b057f33 100644
--- a/drivers/bluetooth/hci_h5.c
+++ b/drivers/bluetooth/hci_h5.c
@@ -54,6 +54,7 @@ enum {
 	H5_RX_ESC,		/* SLIP escape mode */
 	H5_TX_ACK_REQ,		/* Pending ack to send */
 	H5_WAKEUP_DISABLE,	/* Device cannot wake host */
+	H5_HW_FLOW_CONTROL,	/* Use HW flow control */
 };
 
 struct h5 {
@@ -920,6 +921,9 @@ static int h5_btrtl_setup(struct h5 *h5)
 	serdev_device_set_baudrate(h5->hu->serdev, controller_baudrate);
 	serdev_device_set_flow_control(h5->hu->serdev, flow_control);
 
+	if (flow_control)
+		set_bit(H5_HW_FLOW_CONTROL, &h5->flags);
+
 	err = btrtl_download_firmware(h5->hu->hdev, btrtl_dev);
 	/* Give the device some time before the hci-core sends it a reset */
 	usleep_range(10000, 20000);
@@ -1012,7 +1016,11 @@ static int h5_btrtl_resume(struct h5 *h5)
 		queue_work(system_long_wq, &reprobe->work);
 	} else {
 		gpiod_set_value_cansleep(h5->device_wake_gpio, 1);
+
+		if (test_bit(H5_HW_FLOW_CONTROL, &h5->flags))
+			serdev_device_set_flow_control(h5->hu->serdev, true);
 	}
+
 	return 0;
 }
 
-- 
2.32.0.93.g670b81a890-goog

