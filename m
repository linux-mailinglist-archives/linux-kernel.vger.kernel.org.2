Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 48B8140F4CA
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Sep 2021 11:27:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343636AbhIQJ2W (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 17 Sep 2021 05:28:22 -0400
Received: from smtp-relay-internal-1.canonical.com ([185.125.188.123]:48786
        "EHLO smtp-relay-internal-1.canonical.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1343505AbhIQJYn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Sep 2021 05:24:43 -0400
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com [209.85.221.72])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by smtp-relay-internal-1.canonical.com (Postfix) with ESMTPS id 6AB763F4BE
        for <linux-kernel@vger.kernel.org>; Fri, 17 Sep 2021 09:22:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
        s=20210705; t=1631870561;
        bh=sKqaN3dAa3OzIkq2x9fGW8/ov3xbVPisMuBMh0bt1ds=;
        h=From:To:Cc:Subject:Date:Message-Id:MIME-Version;
        b=f5KTWRF1ipa3ga0acSLOyXUHH0yRvApZOT9qkNqPPcLHO/NC7F4BAhrAgtLIw3atO
         u3zmEkiFx5m/J/EC/lU14Q+PTlxNoBLrn4OrTeYAeEZJzvY4NETolcDeh/GNmlKEFC
         VzTTms4z1QQ1C4Yb3/lLxM7gqh4EuR/VY0TgAJBKqiLoKfmPwzP++ZDZq60fkZaGB4
         qOe85zPKeg4/5IZTp4ddhAKdnoOGvaUpqwKHYmx7+3JB0amn0dAYjlK9ReXgNdrvie
         QZuUDKbzBGEPmjpHOSqP1Y6VqLiwSFnu6NNi4ProWwOWayG/LK0tKs8xICz3RGwclV
         8+GLtFq+SFE1Q==
Received: by mail-wr1-f72.google.com with SMTP id e1-20020adfa741000000b0015e424fdd01so3012685wrd.11
        for <linux-kernel@vger.kernel.org>; Fri, 17 Sep 2021 02:22:41 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=sKqaN3dAa3OzIkq2x9fGW8/ov3xbVPisMuBMh0bt1ds=;
        b=qO0GWOFmyzd6KTTCVQuUr8auOOCOxlP0shs/zykpGYSgqlnDRkewM3OGOkvHWtAxAU
         94EaH1boTxivAmD9ybCowhn+sx34+OJ2F0hA3MD3tRLJct/nKwRRpSX6pgzZkpidKXgE
         WPSgQ0KgbUiscBlF6IR2fiGbj2BOwVDulgakbl7/ESahnh/YHcikttq7Fodv+UlhjgkT
         RvrDMqfWlYJks5ZGXavneR+thFAhT8o6+2qz6rLRtJgPqgxeiF3BH27wrBOMLRv2hOLA
         yKmoXhkE9UO8WnE5X94oIBjyKTsiiApI/pLYH0etmLdUEGo8Y6CodUR4qZKoxcM4oDXj
         WCaA==
X-Gm-Message-State: AOAM530GAd7OlGzcf/+6755RNCm2WnuxYteTMAwaBpwXMpnvOxs4gQZN
        ku8T5lL80RTHgvvRmsOPWB4fAnZCgyvsrksTJ2887neH7INTPPp28KFY+eLyvzgyXH7KMxoWcfq
        KYe8IwLvB3T1qXTSvDaQe6XTgJuwJtkTrIqUdPixXVw==
X-Received: by 2002:adf:fe0e:: with SMTP id n14mr11013138wrr.236.1631870560755;
        Fri, 17 Sep 2021 02:22:40 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJwOKIr4nUWuCKxSsVsGtcawKvqxo1EmKH/JAYikoJ7Ssjb8mXSyFAeCUDJ+zD7DS/EpQfPCmA==
X-Received: by 2002:adf:fe0e:: with SMTP id n14mr11013120wrr.236.1631870560606;
        Fri, 17 Sep 2021 02:22:40 -0700 (PDT)
Received: from localhost.localdomain (lk.84.20.244.219.dc.cable.static.lj-kabel.net. [84.20.244.219])
        by smtp.gmail.com with ESMTPSA id l21sm5656704wmh.31.2021.09.17.02.22.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 17 Sep 2021 02:22:40 -0700 (PDT)
From:   Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
To:     linux-kernel@vger.kernel.org
Cc:     Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-staging@lists.linux.dev
Subject: [PATCH] wlan-ng: remove duplicate USB device ID
Date:   Fri, 17 Sep 2021 11:22:06 +0200
Message-Id: <20210917092206.19677-1-krzysztof.kozlowski@canonical.com>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The device 0x2821,0x3300 is already on the list.

Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
---
 drivers/staging/wlan-ng/prism2usb.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/staging/wlan-ng/prism2usb.c b/drivers/staging/wlan-ng/prism2usb.c
index 4b08dc1da4f9..dc0749b8eff7 100644
--- a/drivers/staging/wlan-ng/prism2usb.c
+++ b/drivers/staging/wlan-ng/prism2usb.c
@@ -34,14 +34,13 @@ static const struct usb_device_id usb_prism_tbl[] = {
 	PRISM_DEV(0x04f1, 0x3009, "JVC MP-XP7250 Builtin USB WLAN Adapter"),
 	PRISM_DEV(0x0846, 0x4110, "NetGear MA111"),
 	PRISM_DEV(0x03f3, 0x0020, "Adaptec AWN-8020 USB WLAN Adapter"),
-	PRISM_DEV(0x2821, 0x3300, "ASUS-WL140 Wireless USB Adapter"),
+	PRISM_DEV(0x2821, 0x3300, "ASUS-WL140 / Hawking HighDB Wireless USB Adapter"),
 	PRISM_DEV(0x2001, 0x3700, "DWL-122 Wireless USB Adapter"),
 	PRISM_DEV(0x2001, 0x3702, "DWL-120 Rev F Wireless USB Adapter"),
 	PRISM_DEV(0x50c2, 0x4013, "Averatec USB WLAN Adapter"),
 	PRISM_DEV(0x2c02, 0x14ea, "Planex GW-US11H WLAN USB Adapter"),
 	PRISM_DEV(0x124a, 0x168b, "Airvast PRISM3 WLAN USB Adapter"),
 	PRISM_DEV(0x083a, 0x3503, "T-Sinus 111 USB WLAN Adapter"),
-	PRISM_DEV(0x2821, 0x3300, "Hawking HighDB USB Adapter"),
 	PRISM_DEV(0x0411, 0x0044, "Melco WLI-USB-KB11 11Mbps WLAN Adapter"),
 	PRISM_DEV(0x1668, 0x6106, "ROPEX FreeLan 802.11b USB Adapter"),
 	PRISM_DEV(0x124a, 0x4017, "Pheenet WL-503IA 802.11b USB Adapter"),
-- 
2.30.2

