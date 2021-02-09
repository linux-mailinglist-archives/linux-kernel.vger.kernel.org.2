Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 90F69314EF0
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Feb 2021 13:33:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230000AbhBIMdF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 9 Feb 2021 07:33:05 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44516 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229919AbhBIMdD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 Feb 2021 07:33:03 -0500
Received: from mail-ej1-x62c.google.com (mail-ej1-x62c.google.com [IPv6:2a00:1450:4864:20::62c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EB92CC061788
        for <linux-kernel@vger.kernel.org>; Tue,  9 Feb 2021 04:32:22 -0800 (PST)
Received: by mail-ej1-x62c.google.com with SMTP id f14so31009343ejc.8
        for <linux-kernel@vger.kernel.org>; Tue, 09 Feb 2021 04:32:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=monstr-eu.20150623.gappssmtp.com; s=20150623;
        h=sender:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=1CWVbWMy02aiBxLkPLcMyfNOVERNn6cRPM0WaMpYN58=;
        b=ZkeuW7GCbZb+mqOTc1rDs0fFr192DetmmFEuKYFD1Sg7O4oYHIAiXM/OQHDvIQicuq
         Ug7fChg1iqXrDKH2mwUxxYXG6ITnT3ZxE7nwTAfW2s77eFTSw+hymgmj23bfADAExKQ9
         +teoZeE0l4Sp7FUBQzg12CtP3FVKtQktx5bQMkopngVR7BNeCCvWZb7zwq1CH8QBLwBT
         xqux0qv8UhUS0kBkyXIx79XaPTUCi2wKnDt5+6RmH41n7GrE28u/Wrt/uJdiLS6ii3Uv
         ci4AnJin+8dK+18oKnmm8F3QA80itqebNDXAgEhjJb0TdOE7NmvbGOd/g0OUKX2Jyzke
         cvcw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
         :mime-version:content-transfer-encoding;
        bh=1CWVbWMy02aiBxLkPLcMyfNOVERNn6cRPM0WaMpYN58=;
        b=cHxSl4T83EL/RqQafvmc1lHnZQX6mtcp6BuJXvX1wFPFBA2Y1BZDs+Y2VFhA9OFWjB
         KmsvfPsEqiWRdyulhJCXVjNRHZ3M5VOGUmq3fTEkTeRDp7MdDiFI7oEaUiLIhfL+YzBW
         3qVmsTg69uzGvT3PfPi9sOx2eBjTrP0Q8dEeaA18VQ8l+scekcYvtF0uTfLLSfacnM1w
         dviptT51nmHB6doqNuvm2pWl8TLBxS6uD/q4eSMYM18AQAvVUow0nvAb71UNQkvUQH3y
         wsCMXfOaIkLbCTdfBHuSm+olcuhJ1qAlVPxXHK+YRRDWqGIoB+bHe07XeHGH+HHQrb30
         wK2w==
X-Gm-Message-State: AOAM530T8LM7P1ZiQtC+vkRt0aMC/qdFQUFe/2frn0E8g8CQwYRBJXRX
        fp1IyxVXvfBJH6oelJlIGoT4BmjBKWmW0A==
X-Google-Smtp-Source: ABdhPJxrml0k+smViydxGYN1l4mfREZt00owdYjiBWzlGWr0xpLAVoXDqabbN1aAB7c7SPB5bX3olQ==
X-Received: by 2002:a17:907:2130:: with SMTP id qo16mr21250551ejb.537.1612873941381;
        Tue, 09 Feb 2021 04:32:21 -0800 (PST)
Received: from localhost (nat-35.starnet.cz. [178.255.168.35])
        by smtp.gmail.com with ESMTPSA id a25sm8522252edt.16.2021.02.09.04.32.20
        (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 09 Feb 2021 04:32:20 -0800 (PST)
Sender: Michal Simek <monstr@monstr.eu>
From:   Michal Simek <michal.simek@xilinx.com>
To:     linux-kernel@vger.kernel.org, monstr@monstr.eu,
        michal.simek@xilinx.com, git@xilinx.com,
        Johan Hovold <johan@kernel.org>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Paul Cercueil <paul@crapouillou.net>, linux-usb@vger.kernel.org
Subject: [PATCH v2] usb: misc: usb3503: Fix logic in usb3503_init()
Date:   Tue,  9 Feb 2021 13:32:19 +0100
Message-Id: <a8547f6fe698014df08cad3bcc9c5d9a7137d8b8.1612873935.git.michal.simek@xilinx.com>
X-Mailer: git-send-email 2.30.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Based on
https://lore.kernel.org/linux-arm-kernel/YCJv59g3Tq2haDSa@kroah.com/
initialization should fail if any registration fails.

Signed-off-by: Michal Simek <michal.simek@xilinx.com>
---

Changes in v2:
- Also remove i2c driver when platform driver registration failed.

 drivers/usb/misc/usb3503.c | 9 +++++++--
 1 file changed, 7 insertions(+), 2 deletions(-)

diff --git a/drivers/usb/misc/usb3503.c b/drivers/usb/misc/usb3503.c
index 48099c6bf04c..330f494cd158 100644
--- a/drivers/usb/misc/usb3503.c
+++ b/drivers/usb/misc/usb3503.c
@@ -409,13 +409,18 @@ static int __init usb3503_init(void)
 	int err;
 
 	err = i2c_add_driver(&usb3503_i2c_driver);
-	if (err != 0)
+	if (err) {
 		pr_err("usb3503: Failed to register I2C driver: %d\n", err);
+		return err;
+	}
 
 	err = platform_driver_register(&usb3503_platform_driver);
-	if (err != 0)
+	if (err) {
 		pr_err("usb3503: Failed to register platform driver: %d\n",
 		       err);
+		i2c_del_driver(&usb3503_i2c_driver);
+		return err;
+	}
 
 	return 0;
 }
-- 
2.30.0

