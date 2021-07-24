Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B92F73D43E7
	for <lists+linux-kernel@lfdr.de>; Sat, 24 Jul 2021 02:17:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233369AbhGWXhH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 23 Jul 2021 19:37:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55794 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232724AbhGWXhG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 23 Jul 2021 19:37:06 -0400
Received: from mail-qk1-x749.google.com (mail-qk1-x749.google.com [IPv6:2607:f8b0:4864:20::749])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8D24AC061575
        for <linux-kernel@vger.kernel.org>; Fri, 23 Jul 2021 17:17:39 -0700 (PDT)
Received: by mail-qk1-x749.google.com with SMTP id bm25-20020a05620a1999b02903a9c3f8b89fso2437296qkb.2
        for <linux-kernel@vger.kernel.org>; Fri, 23 Jul 2021 17:17:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:message-id:mime-version:subject:from:to:cc;
        bh=HOlFjIupBaRC8Gj2HRr1sX5wQQLAab9xCES8dhta9ys=;
        b=ILx4pqCqbGkzhWIJTLtu9nC1m+It4WUw0yZM1Q3U2n7JCxtIkWzPzay+m+X2RL7tLL
         J43O8vOtq3f9YScoL53U0MNLyYvG9logrmR1gkRtiMzm3fF9a2MS76njxQjHiufgSfhS
         9PoM70rrHjJQ/AN9bC3OXw1E1roXQOWEayQBornKkrCpw8HPrBf7u5308KE9UYa/js9L
         tnTlhGUYOoLnW/bwjfi8xAzydX5n+psmkKUmG6y+0CtZbYGVqnZ+SQBCKS5La9aVd3WZ
         Cswd3cO9DNbgszs/u/NiWPlAU6RLmO+5SiJ6Fh3ecGmFhlQzx3G8rc+dyzQ49az0QeAm
         GgQA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:message-id:mime-version:subject:from:to:cc;
        bh=HOlFjIupBaRC8Gj2HRr1sX5wQQLAab9xCES8dhta9ys=;
        b=X4rtjDM31/SCxTfk+3MNYv7OA35oUYcENqvHKkD2xAu+9CkpLlAJO2pNQpXLyVwaBD
         BZzJUTvcytxA4yoGJyVGlmpvKjcn1vOCnU36KrhwhYpSOvW0wdQZrBR9BKaY6iKBwaxm
         9jnZTmYYT89d6JbUFBOK2CiBNsONmJEO8ZdhsaBFoBrAbQKFOPwHBCDathTzXEJ4K/Ro
         AvJWALX5c5rG/jExvTjOFG+Npur+G+rjd+6mF8UHsC4oBdyYwxW7EHwb3mfpY+xT2piB
         Wzy+wRWi5LwXOHpcIybkvGZ3LXeOpkQoKONvoS+Bsm0XQXaiditE5TbE37wHRFQ5UX1l
         w/ag==
X-Gm-Message-State: AOAM532jvsX3PNGxpNZVYXbUgOPfdzOl9zo1nB78mgc903xqqbvaYGda
        S/DZ01E132yKJfwkYerxiY5+q0A9Qr1PxQ8SPA==
X-Google-Smtp-Source: ABdhPJxXDydiKx4ZebBCkBSRRlKUeS0PpaZROv9k4Ocf+GWRrYX4ALpcUwlhCr6StwlF9ZqKEldZImucfpWS8KP+mA==
X-Received: from michaelfsun.mtv.corp.google.com ([2620:15c:202:201:153b:286b:8047:586b])
 (user=michaelfsun job=sendgmr) by 2002:a05:6214:cac:: with SMTP id
 s12mr7031703qvs.29.1627085858563; Fri, 23 Jul 2021 17:17:38 -0700 (PDT)
Date:   Fri, 23 Jul 2021 17:17:31 -0700
Message-Id: <20210723171729.1.I98b1da8cdd72c1f355366f623cb34ddfc0fe40ae@changeid>
Mime-Version: 1.0
X-Mailer: git-send-email 2.32.0.432.gabb21c7263-goog
Subject: [PATCH] Bluetooth: btusb: Add valid le states quirk
From:   Michael Sun <michaelfsun@google.com>
To:     linux-bluetooth@vger.kernel.org
Cc:     chromeos-bluetooth-upstreaming@chromium.org,
        Michael Sun <michaelfsun@google.com>,
        Johan Hedberg <johan.hedberg@gmail.com>,
        Luiz Augusto von Dentz <luiz.dentz@gmail.com>,
        Marcel Holtmann <marcel@holtmann.org>,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add the valid le states quirk for WCN6855 and GarfieldPeak controller
so the 'central-peripheral' role is exposed in userspace.

Signed-off-by: Michael Sun <michaelfsun@google.com>
---

 drivers/bluetooth/btusb.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/drivers/bluetooth/btusb.c b/drivers/bluetooth/btusb.c
index 7b69a97bd0e9..1876a960b3dc 100644
--- a/drivers/bluetooth/btusb.c
+++ b/drivers/bluetooth/btusb.c
@@ -297,7 +297,8 @@ static const struct usb_device_id blacklist_table[] = {
 
 	/* QCA WCN6855 chipset */
 	{ USB_DEVICE(0x0cf3, 0xe600), .driver_info = BTUSB_QCA_WCN6855 |
-						     BTUSB_WIDEBAND_SPEECH },
+						     BTUSB_WIDEBAND_SPEECH |
+						     BTUSB_VALID_LE_STATES },
 
 	/* Broadcom BCM2035 */
 	{ USB_DEVICE(0x0a5c, 0x2009), .driver_info = BTUSB_BCM92035 },
@@ -371,7 +372,8 @@ static const struct usb_device_id blacklist_table[] = {
 	{ USB_DEVICE(0x8087, 0x0032), .driver_info = BTUSB_INTEL_NEWGEN |
 						     BTUSB_WIDEBAND_SPEECH},
 	{ USB_DEVICE(0x8087, 0x0033), .driver_info = BTUSB_INTEL_NEWGEN |
-						     BTUSB_WIDEBAND_SPEECH},
+						     BTUSB_WIDEBAND_SPEECH |
+						     BTUSB_VALID_LE_STATES },
 	{ USB_DEVICE(0x8087, 0x07da), .driver_info = BTUSB_CSR },
 	{ USB_DEVICE(0x8087, 0x07dc), .driver_info = BTUSB_INTEL },
 	{ USB_DEVICE(0x8087, 0x0a2a), .driver_info = BTUSB_INTEL },
-- 
2.32.0.432.gabb21c7263-goog

