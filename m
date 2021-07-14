Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 69D2D3C7F2B
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Jul 2021 09:13:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238253AbhGNHQn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 14 Jul 2021 03:16:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45532 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238244AbhGNHQn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Jul 2021 03:16:43 -0400
Received: from mail-qk1-x74a.google.com (mail-qk1-x74a.google.com [IPv6:2607:f8b0:4864:20::74a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 146A5C061574
        for <linux-kernel@vger.kernel.org>; Wed, 14 Jul 2021 00:13:52 -0700 (PDT)
Received: by mail-qk1-x74a.google.com with SMTP id a6-20020a37b1060000b02903b488f9d348so582861qkf.20
        for <linux-kernel@vger.kernel.org>; Wed, 14 Jul 2021 00:13:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=XTdrZ0dJFn1DaDa3LqHGHs3jtPZhxu1jdfiB7BtKgFo=;
        b=o7gIoRrnyXaH5I79tSNE/yWeSaLTBnVkThvhwXgKspB0bcJbBqSf7lmAqvuzVZHlK5
         GLv4babRtNAlx+IBFYehVNkprisSBvFPg27fuKeFqWiuHg/S0uyWcQVnFcv6rqSZ3VY8
         XyzGP1li9RxJwYX+X6aGYnnJRr/NthmMAFvPjdbyukGCIY78UP61luOLBbtxALhGW5Ob
         6Dpw3yRc/YL4zSfqedHQ3b74fwy8C+u1Gjqys4AhsE9SXJ51qDrVJBeWHn4iRvQXEMx8
         A5J8XxZkSkhFSxYumsZvuS2u4lNEwbSH6lql0Ma0jCHYAJiXZTS4U2K3DINovGizcOPJ
         Bl+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=XTdrZ0dJFn1DaDa3LqHGHs3jtPZhxu1jdfiB7BtKgFo=;
        b=BJ0QKpc0K6ZeTXx6SZDNbI+7CB5jcByLnEplcUbtGpAkYAz2D5tbOOqGzMfoalsYBf
         ONfZlHWGkfvsVNUIFGqg9iiC/lwtca5G05SnZRZfEF5R0W/YpgeK0oDMIXuOLmI6zdHh
         AKlzYaNLU6wE1rxoaYpjN+L7f/roLMdga+kDk8AmCZn0JNtYHlolMHyf9FEqoA+uPGzj
         7B1yVvWqxYc7qyX8Fx6dobzDYtRwBF3+qBQ1SPW9l+tuDe6VcJ2UdZXCnvQWUDq5q2rK
         R1YBXZ5pGdpXpVGTOVA8DKfwqazEdvAgpKKGMLh3vOLjdAuFj6DiLpq6IqviLgh7Qz7f
         R4KA==
X-Gm-Message-State: AOAM530x6TcTJMLfsoA0FuTz4iBEQA5X8tKCZOCKPeokuQdzaBTYpW94
        feQno1nqEoVXyg+nGQFyfAJQcMP7U9Eb
X-Google-Smtp-Source: ABdhPJy8p7BkWUFja6u2+iuoz5FX+Add8fSQBRbgL/BXdoPiti4032Scw6UwbWF2CwpEaJWyZ07HJyMAkJr+
X-Received: from apusaka-p920.tpe.corp.google.com ([2401:fa00:1:10:ecf5:ef03:eb15:e989])
 (user=apusaka job=sendgmr) by 2002:a05:6214:e6e:: with SMTP id
 jz14mr9102781qvb.55.1626246831175; Wed, 14 Jul 2021 00:13:51 -0700 (PDT)
Date:   Wed, 14 Jul 2021 15:13:39 +0800
In-Reply-To: <20210714151332.1.I68649745bd11a83265f1e816bf34ecc82775e95a@changeid>
Message-Id: <20210714151332.2.I404c6df9cdab270223c13e867396f440dd4b499d@changeid>
Mime-Version: 1.0
References: <20210714151332.1.I68649745bd11a83265f1e816bf34ecc82775e95a@changeid>
X-Mailer: git-send-email 2.32.0.93.g670b81a890-goog
Subject: [PATCH 2/3] Bluetooth: hci_h5: btrtl: Maintain flow control if wakeup
 is enabled
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

 drivers/bluetooth/hci_h5.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/drivers/bluetooth/hci_h5.c b/drivers/bluetooth/hci_h5.c
index 947246569434..67fcf192d5c5 100644
--- a/drivers/bluetooth/hci_h5.c
+++ b/drivers/bluetooth/hci_h5.c
@@ -54,6 +54,7 @@ enum {
 	H5_RX_ESC,		/* SLIP escape mode */
 	H5_TX_ACK_REQ,		/* Pending ack to send */
 	H5_WAKEUP_DISABLE,	/* Device cannot wake host */
+	H5_HW_FLOW_CONTROL,	/* Use HW flow control */
 };
 
 struct h5 {
@@ -923,6 +924,9 @@ static int h5_btrtl_setup(struct h5 *h5)
 	serdev_device_set_baudrate(h5->hu->serdev, controller_baudrate);
 	serdev_device_set_flow_control(h5->hu->serdev, flow_control);
 
+	if (flow_control)
+		set_bit(H5_HW_FLOW_CONTROL, &h5->flags);
+
 	err = btrtl_download_firmware(h5->hu->hdev, btrtl_dev);
 	/* Give the device some time before the hci-core sends it a reset */
 	usleep_range(10000, 20000);
@@ -1015,7 +1019,11 @@ static int h5_btrtl_resume(struct h5 *h5)
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

