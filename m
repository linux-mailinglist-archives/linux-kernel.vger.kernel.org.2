Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5F49E377A25
	for <lists+linux-kernel@lfdr.de>; Mon, 10 May 2021 04:32:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230152AbhEJCdh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 9 May 2021 22:33:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45484 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229977AbhEJCdg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 9 May 2021 22:33:36 -0400
Received: from mail-pl1-x62c.google.com (mail-pl1-x62c.google.com [IPv6:2607:f8b0:4864:20::62c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9208DC061573;
        Sun,  9 May 2021 19:32:31 -0700 (PDT)
Received: by mail-pl1-x62c.google.com with SMTP id b15so2208565plh.10;
        Sun, 09 May 2021 19:32:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=3fuoFRHs9de/EFAgzJGEliLd6nu5MCTkTqOJM1BxOvo=;
        b=n9vOt9/ZNuS6Ih8n5lfVTKokS0LAyYvKe7j03Mito2p65BoDqMIQAPAH2yLDsod3Y1
         Ykh8haa4M2z28rjDeUfUgOEsX/wElhRkiEMLeI00NIQo0GqoU5BPQ0wme0z8LOIK+g30
         nwVvd6eYY01jUa7WLVVU/tLq0H2j6RXz/4+abKvFUlsk0pTYww+VO4UfsFnHmScKydXw
         74xVgMSIca8ibe0bICoz+/7kYxK7m0T2eNI7z2ursqdV/B4YSxW70/xX8z2AbLtlKI+M
         3E+a8Lg0EmPxMjwTKTeSD10dS9F+/iosbXPrCROVpPXeFdi9t80hMbZQLcsTrjIej9UR
         PqCA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=3fuoFRHs9de/EFAgzJGEliLd6nu5MCTkTqOJM1BxOvo=;
        b=X6EueqIQYAbms4Od6Us49iw9PHWJqML/VMaSI4zkg0uY3lJm6tQyhbs5bnwm5MIJaV
         POejUtsRHXyIomgLHX0AqKOc98h1xkbLGPxUxxpxAc7IxoUKhyr5fBi2ST9MMJ5rKcwy
         NW/bYx84B5SnOXGl6ZgkhrAfE782ceYofLDkCXh/CsrA+1VI7GY2nE9GXRT6wTQF/Y9s
         zafADMNrOtA4+yEfABDvqdCrH9t7zi0NQT1PqoMy+p3XfjTuRcG9mP7+wVe2QDlRk9Fc
         Q2kzX0lrwAJN72gmBw9/R4wKgEcnEJjqjHvWztCLLZESqddILycTVITk7mQljemYDK3U
         RVVg==
X-Gm-Message-State: AOAM530oaXCq0TiK8C9t9JbQiS1r8hGzBh3s9bF5Juxm3GUspOTLt8oa
        otThuqookiOPgL3yhS13siU+dh95vCFCZNkyBCs=
X-Google-Smtp-Source: ABdhPJwtRWeuuj7+FFxYhg8N7VHj21VLc9AI08l9FRy2O6b2bUlvPWUflhi5r1X7GKloQatYubSKVw==
X-Received: by 2002:a17:90b:4b45:: with SMTP id mi5mr39619973pjb.197.1620613951049;
        Sun, 09 May 2021 19:32:31 -0700 (PDT)
Received: from LinuxTest-8928.adlinktech.com (210-59-165-169.HINET-IP.hinet.net. [210.59.165.169])
        by smtp.googlemail.com with ESMTPSA id t10sm17921985pju.18.2021.05.09.19.32.29
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 09 May 2021 19:32:30 -0700 (PDT)
From:   Zolton Jheng <s6668c2t@gmail.com>
To:     johan@kernel.org
Cc:     gregkh@linuxfoundation.org, linux-usb@vger.kernel.org,
        linux-kernel@vger.kernel.org, Zolton Jheng <s6668c2t@gmail.com>
Subject: [PATCH] USB: serial: pl2303: add device id for ADLINK ND-6530 GC device
Date:   Mon, 10 May 2021 10:32:00 +0800
Message-Id: <1620613920-3968-1-git-send-email-s6668c2t@gmail.com>
X-Mailer: git-send-email 2.7.4
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This is adds the device id for the ADLINK ND-6530 which is a
pl2303gc based device

Signed-off-by: Zolton Jheng <s6668c2t@gmail.com>
---
 drivers/usb/serial/pl2303.c | 1 +
 drivers/usb/serial/pl2303.h | 1 +
 2 files changed, 2 insertions(+)

diff --git a/drivers/usb/serial/pl2303.c b/drivers/usb/serial/pl2303.c
index eed9acd..f2895c2 100644
--- a/drivers/usb/serial/pl2303.c
+++ b/drivers/usb/serial/pl2303.c
@@ -113,6 +113,7 @@ static const struct usb_device_id id_table[] = {
 	{ USB_DEVICE(SONY_VENDOR_ID, SONY_QN3USB_PRODUCT_ID) },
 	{ USB_DEVICE(SANWA_VENDOR_ID, SANWA_PRODUCT_ID) },
 	{ USB_DEVICE(ADLINK_VENDOR_ID, ADLINK_ND6530_PRODUCT_ID) },
+	{ USB_DEVICE(ADLINK_VENDOR_ID, ADLINK_ND6530GC_PRODUCT_ID) },
 	{ USB_DEVICE(SMART_VENDOR_ID, SMART_PRODUCT_ID) },
 	{ USB_DEVICE(AT_VENDOR_ID, AT_VTKIT3_PRODUCT_ID) },
 	{ }					/* Terminating entry */
diff --git a/drivers/usb/serial/pl2303.h b/drivers/usb/serial/pl2303.h
index 0f681dd..6097ee8 100644
--- a/drivers/usb/serial/pl2303.h
+++ b/drivers/usb/serial/pl2303.h
@@ -158,6 +158,7 @@
 /* ADLINK ND-6530 RS232,RS485 and RS422 adapter */
 #define ADLINK_VENDOR_ID		0x0b63
 #define ADLINK_ND6530_PRODUCT_ID	0x6530
+#define ADLINK_ND6530GC_PRODUCT_ID	0x653a
 
 /* SMART USB Serial Adapter */
 #define SMART_VENDOR_ID	0x0b8c
-- 
2.7.4

