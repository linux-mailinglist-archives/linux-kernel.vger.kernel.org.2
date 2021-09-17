Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AAD2840F4B5
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Sep 2021 11:24:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343555AbhIQJZh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 17 Sep 2021 05:25:37 -0400
Received: from smtp-relay-internal-1.canonical.com ([185.125.188.123]:48486
        "EHLO smtp-relay-internal-1.canonical.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S245615AbhIQJVH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Sep 2021 05:21:07 -0400
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com [209.85.128.71])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by smtp-relay-internal-1.canonical.com (Postfix) with ESMTPS id E9C173F4B9
        for <linux-kernel@vger.kernel.org>; Fri, 17 Sep 2021 09:19:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
        s=20210705; t=1631870369;
        bh=v3zufeUBr4GbgUChP1ldLnEXsCACG0UXT8IRgkTK7zc=;
        h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
         MIME-Version;
        b=pw0YB0dvK3j7xzia6WkuxoDpm7jJNwnmqEvQSNW5SCGj8so2C8h08p14Gwtz8oqlO
         sSju3TWJ4Ep5ueMvPO1sPTkQ7NJAY+RUXO2yNf76KoUeMS4WBXo5A/ejEMhCVYEV9D
         W5zDhKHJhNfheeePZjExhYRm66N88M5OER4XK9q+R1lfazpF/Tjjjouxg7x2UrPAI6
         Bhw9WGFntpOZPnNXBjOk98wt7P7GNWWSvM85bmYgS4TO8o/0PqJSAQ2whscbB9G9ht
         Daw8bujD5qKKIEzQ8y4FV3HV6dbdSZ/Vt3xgMzlZWr5j+YMC9MxA0XLvdzYkzOAwyd
         tuZESwdqx3c2w==
Received: by mail-wm1-f71.google.com with SMTP id 5-20020a1c00050000b02902e67111d9f0so4367744wma.4
        for <linux-kernel@vger.kernel.org>; Fri, 17 Sep 2021 02:19:29 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=v3zufeUBr4GbgUChP1ldLnEXsCACG0UXT8IRgkTK7zc=;
        b=S/O8qKMUfGnsASwEoA11NElq53y7Yd3IY5dz7AaPRJhdg5QllC0WLOh0ZiCBnf3RlG
         1GCs2r3D9P3ab+D6fskfRs1rFPQbtQvfAxl/BaA4YwVzEO9+RV210jYCMUVVT5j1HdP1
         va/9u93GUJYd8DHpyIHN2BIrWIANZXHSfVB2e/aBuQ2MrlU0sK8qTT+zAp/Ot6qM05qL
         9nebdUd5aX4CP3LH4ACHofYyMf26mn7jYGgJdw0li/qLxvuKnKpU4YPL2J7Qf5bcTo2C
         dgVJ8AmaBjOMr53CGu50iRfYqTnhTSeerB3Fqrd//IT7kxP1xYCFwdLgV7Uj8nFHFRZv
         g7DA==
X-Gm-Message-State: AOAM532ChtQGYPO1DAYSaHQR6IMnro6kPXL+oBdNKBp0m2wpOqbqc4gt
        ZogsqxRTIiCH/mgs5vaqhN3RuW4PVhqnNX4RJ1WJmGDC7C41JWJmATHpQs/JYRdTENbjnHXl//3
        Ob+rRmdz7ft62azOn0X4gjME3tawabU5K6D6rWBkLoA==
X-Received: by 2002:a1c:2289:: with SMTP id i131mr14022929wmi.113.1631870369638;
        Fri, 17 Sep 2021 02:19:29 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJzOgTUg0ILE+RdpToIOf3sMG9gWSaPzCluuUUN5YLTe+mASPOVCEmyvkPvgT4HprE0vldYWZw==
X-Received: by 2002:a1c:2289:: with SMTP id i131mr14022917wmi.113.1631870369495;
        Fri, 17 Sep 2021 02:19:29 -0700 (PDT)
Received: from localhost.localdomain (lk.84.20.244.219.dc.cable.static.lj-kabel.net. [84.20.244.219])
        by smtp.gmail.com with ESMTPSA id p1sm5678354wmi.30.2021.09.17.02.19.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 17 Sep 2021 02:19:29 -0700 (PDT)
From:   Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
To:     Oliver Neukum <oneukum@suse.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Johan Hovold <johan@kernel.org>, linux-usb@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
Subject: [PATCH 2/3] USB: serial: option: remove duplicate USB device ID
Date:   Fri, 17 Sep 2021 11:18:48 +0200
Message-Id: <20210917091849.18692-2-krzysztof.kozlowski@canonical.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20210917091849.18692-1-krzysztof.kozlowski@canonical.com>
References: <20210917091849.18692-1-krzysztof.kozlowski@canonical.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The device ZTE 0x0094 is already on the list.

Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
---
 drivers/usb/serial/option.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/usb/serial/option.c b/drivers/usb/serial/option.c
index 29c765cc8495..57c5a03a29c1 100644
--- a/drivers/usb/serial/option.c
+++ b/drivers/usb/serial/option.c
@@ -1650,7 +1650,6 @@ static const struct usb_device_id option_ids[] = {
 	{ USB_DEVICE_AND_INTERFACE_INFO(ZTE_VENDOR_ID, 0x0060, 0xff, 0xff, 0xff) },
 	{ USB_DEVICE_AND_INTERFACE_INFO(ZTE_VENDOR_ID, 0x0070, 0xff, 0xff, 0xff) },
 	{ USB_DEVICE_AND_INTERFACE_INFO(ZTE_VENDOR_ID, 0x0073, 0xff, 0xff, 0xff) },
-	{ USB_DEVICE_AND_INTERFACE_INFO(ZTE_VENDOR_ID, 0x0094, 0xff, 0xff, 0xff) },
 	{ USB_DEVICE_AND_INTERFACE_INFO(ZTE_VENDOR_ID, 0x0130, 0xff, 0xff, 0xff),
 	  .driver_info = RSVD(1) },
 	{ USB_DEVICE_AND_INTERFACE_INFO(ZTE_VENDOR_ID, 0x0133, 0xff, 0xff, 0xff),
-- 
2.30.2

