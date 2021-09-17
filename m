Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 719AB40F4B1
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Sep 2021 11:23:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245758AbhIQJXu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 17 Sep 2021 05:23:50 -0400
Received: from smtp-relay-internal-0.canonical.com ([185.125.188.122]:53376
        "EHLO smtp-relay-internal-0.canonical.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S245602AbhIQJVC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Sep 2021 05:21:02 -0400
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com [209.85.128.72])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by smtp-relay-internal-0.canonical.com (Postfix) with ESMTPS id 47F9A402CF
        for <linux-kernel@vger.kernel.org>; Fri, 17 Sep 2021 09:19:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
        s=20210705; t=1631870368;
        bh=+1YWJX9RyvLg00KZKztI7RFTQvcCAVEYbN2RHuXyA+I=;
        h=From:To:Cc:Subject:Date:Message-Id:MIME-Version;
        b=mWaXOawJRust623MykSvT7WZ+W32fQRODM62gRfJLpa8EcmlFoLYV2dK5aX4p+Z52
         0BKCC1LjniXPIM5PkR6zRiuF1ztYAcm7Mz+wP/MhJbmIKD3kjEn32XOR+mW3ZuCpvG
         bk/hM2nvpIvdSvF3tA2BLP24f7/hYBgkFAfTLcuNkoAIbre1338HegEES6HczJfXPf
         q7rxPrIjdVDLUtGj2vUMjlU/qC9c8ssXDrWAhP6A2Y4RduyMrYVWm71kcsdp1PHzmX
         DERTH3iuu5GETDVdgLUg3DaIc4pzDBkcx9P7hGHCDXTwQ6qanq4WtluC9JzhbZHwk3
         8rR2Vn1G8SVdw==
Received: by mail-wm1-f72.google.com with SMTP id m9-20020a05600c4f4900b003057c761567so3507372wmq.1
        for <linux-kernel@vger.kernel.org>; Fri, 17 Sep 2021 02:19:28 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=+1YWJX9RyvLg00KZKztI7RFTQvcCAVEYbN2RHuXyA+I=;
        b=sHS/vf51jpfmHGkkl8J73Lgo871mz7dPlT3/kXkTadeScpydc3mnKAWgM4UP4xsS0p
         TQR0hWsPwWEVAs0DLn9XXKrVSBV5gf0nLF4SX7k5MxwtbKKDqiIt3x5USUkIk6D/ARQh
         DcrQHUn/sC0caJMcFVU775tLrIMA9226n9J2Vm+j2LbgfQvnkdgVtwC3eJ+tml+y2562
         3U4rXhW5S2vPo5KBCOHAEJ8UIh/mcmDzx8cPGwkRFvO1k4RufGe84mfgu25E9jMGHZ95
         tZuZLbTcC573eTt2XxcMiKHDBfSlaUOeJAq4bKED5d3IAeLzzAV/EgMNfeTXh9t7w1a7
         1NqA==
X-Gm-Message-State: AOAM5332YDQNJYxc3XA+rHCfraW0Kjg8xZ6FlmnRkQRnhVNsBwPGzdcY
        aRHOaPrnjhsSivsyKT0RS5dxAsIfv1gI1atYC85dQd+u71hTvMF0dhvqgywMggJfeHuG+NCk9Lg
        5v60mFpBWJ3rA3vRNzSsBCYgIcj2+qGwicE0oSL0WFQ==
X-Received: by 2002:a5d:4ac4:: with SMTP id y4mr10839422wrs.190.1631870367999;
        Fri, 17 Sep 2021 02:19:27 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJzEhFCOGrU+f8EgvjwZKTV2A5qywjz6/x/wSIIWw4VZcBMKN5Eekcs7zJpZG1uuCAkVmCj+AQ==
X-Received: by 2002:a5d:4ac4:: with SMTP id y4mr10839408wrs.190.1631870367851;
        Fri, 17 Sep 2021 02:19:27 -0700 (PDT)
Received: from localhost.localdomain (lk.84.20.244.219.dc.cable.static.lj-kabel.net. [84.20.244.219])
        by smtp.gmail.com with ESMTPSA id p1sm5678354wmi.30.2021.09.17.02.19.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 17 Sep 2021 02:19:27 -0700 (PDT)
From:   Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
To:     Oliver Neukum <oneukum@suse.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Johan Hovold <johan@kernel.org>, linux-usb@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
Subject: [PATCH 1/3] USB: serial: mos7840: remove duplicated 0xac24 device ID
Date:   Fri, 17 Sep 2021 11:18:47 +0200
Message-Id: <20210917091849.18692-1-krzysztof.kozlowski@canonical.com>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

0xac24 device ID is already defined and used via
BANDB_DEVICE_ID_USO9ML2_4.  Remove the duplicate from the list.

Fixes: 27f1281d5f72 ("USB: serial: Extra device/vendor ID for mos7840 driver")
Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
---
 drivers/usb/serial/mos7840.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/drivers/usb/serial/mos7840.c b/drivers/usb/serial/mos7840.c
index d7fe33ca73e4..925067a7978d 100644
--- a/drivers/usb/serial/mos7840.c
+++ b/drivers/usb/serial/mos7840.c
@@ -107,7 +107,6 @@
 #define BANDB_DEVICE_ID_USOPTL4_2P       0xBC02
 #define BANDB_DEVICE_ID_USOPTL4_4        0xAC44
 #define BANDB_DEVICE_ID_USOPTL4_4P       0xBC03
-#define BANDB_DEVICE_ID_USOPTL2_4        0xAC24
 
 /* Interrupt Routine Defines    */
 
@@ -186,7 +185,6 @@ static const struct usb_device_id id_table[] = {
 	{ USB_DEVICE(USB_VENDOR_ID_BANDB, BANDB_DEVICE_ID_USOPTL4_2P) },
 	{ USB_DEVICE(USB_VENDOR_ID_BANDB, BANDB_DEVICE_ID_USOPTL4_4) },
 	{ USB_DEVICE(USB_VENDOR_ID_BANDB, BANDB_DEVICE_ID_USOPTL4_4P) },
-	{ USB_DEVICE(USB_VENDOR_ID_BANDB, BANDB_DEVICE_ID_USOPTL2_4) },
 	{}			/* terminating entry */
 };
 MODULE_DEVICE_TABLE(usb, id_table);
-- 
2.30.2

