Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A68E93D3988
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Jul 2021 13:32:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234488AbhGWKvj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 23 Jul 2021 06:51:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51054 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234497AbhGWKvi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 23 Jul 2021 06:51:38 -0400
Received: from mail-pj1-x104a.google.com (mail-pj1-x104a.google.com [IPv6:2607:f8b0:4864:20::104a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CC5F5C061575
        for <linux-kernel@vger.kernel.org>; Fri, 23 Jul 2021 04:32:10 -0700 (PDT)
Received: by mail-pj1-x104a.google.com with SMTP id r11-20020a17090a2e8bb029017382031497so1373198pjd.5
        for <linux-kernel@vger.kernel.org>; Fri, 23 Jul 2021 04:32:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=1UqlY0KgIV9lGcr3KCNCk5kXAgTT0B278rOriYat9o8=;
        b=gQRtLTwI8nohOXOq3a88IKRKxe14x6kRa0CvzJCRTdKMX160cJAjg05T6KBrAzn/KR
         2190O5AjA1BdfzyVwI+UbVGHIKZpV71M9tmI1JGNx3KuJ0CK1PMJcsuVJoOjn+c+fqX0
         yG8r9ACcuFePnyT/J2FY2tK8taUdZsnNPEZw+oxoy4T1vgVSp1krNoI5nXPBF+5ifxF6
         5e7FIgj7jxWAaZbm0VruvahJ21yJexsOgdzbyY6LBobcXpBSa36MAZ/lKkoA3m2pa26A
         mdMzBredelyJtOgWeTZkj+RRfkLCiOoHhT91uDrLEMmvp5+zOY3CvPPSY0NnzH+Hi3Vw
         6lEw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=1UqlY0KgIV9lGcr3KCNCk5kXAgTT0B278rOriYat9o8=;
        b=puVhGz35K1HrBXVYAJlouCDVROQf++ePiyWttxUPETvbDUw4zOfutCXBOSZU9aoCAF
         xz0PsCJP0CNsrR3vmzGjSIl9ChpZVrkmmjFIfgj+WjV4/U6bGfEXb1X2ZyPwGfdjfPPO
         mpe5MaRqcZ8ot1eUrYpgF9Sj9tvQvldEUQj35SzAqm26u6UzOqNL5O1gz3MjPfEeFsiN
         zDHpdQ+BNKA5dkw5Oay7+/fFPXj0KD5wp7YB70ot16Gf8VMGJkytiFsqSPmtkw+QU3xS
         /0kXWi+pMTSWXA/MDJE7YLGwXyCWjFKiH+SZF6In7RVhBtwExyvQFrhFhCCNwTcFcgzc
         48JA==
X-Gm-Message-State: AOAM532dSnAOftMu/RykeTcd1te3rXFmE3cK65ZrpQoQbC8WBstucMFH
        nuMtOgQ5h6beJpxLk+VrJlefImoTQKuS
X-Google-Smtp-Source: ABdhPJxOEDnc3AcVmn7792LuVNovHdsnYWk9IKZHI7i/4BPsFo6Fa2oYrS3WRJDK1X9sTL4l9ylgS1iz1j5s
X-Received: from apusaka-p920.tpe.corp.google.com ([2401:fa00:1:10:ddde:33b:f989:cd76])
 (user=apusaka job=sendgmr) by 2002:a05:6a00:84d:b029:329:a067:b1bf with SMTP
 id q13-20020a056a00084db0290329a067b1bfmr4189827pfk.47.1627039930218; Fri, 23
 Jul 2021 04:32:10 -0700 (PDT)
Date:   Fri, 23 Jul 2021 19:31:56 +0800
In-Reply-To: <20210723193137.v3.1.I68649745bd11a83265f1e816bf34ecc82775e95a@changeid>
Message-Id: <20210723193137.v3.2.I404c6df9cdab270223c13e867396f440dd4b499d@changeid>
Mime-Version: 1.0
References: <20210723193137.v3.1.I68649745bd11a83265f1e816bf34ecc82775e95a@changeid>
X-Mailer: git-send-email 2.32.0.432.gabb21c7263-goog
Subject: [PATCH v3 2/3] Bluetooth: hci_h5: btrtl: Maintain flow control if
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
2.32.0.432.gabb21c7263-goog

