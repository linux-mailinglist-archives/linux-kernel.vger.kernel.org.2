Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6FEC940F4C0
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Sep 2021 11:26:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343527AbhIQJ1j (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 17 Sep 2021 05:27:39 -0400
Received: from smtp-relay-internal-1.canonical.com ([185.125.188.123]:48716
        "EHLO smtp-relay-internal-1.canonical.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S245549AbhIQJXL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Sep 2021 05:23:11 -0400
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com [209.85.128.72])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by smtp-relay-internal-1.canonical.com (Postfix) with ESMTPS id 810013FE02
        for <linux-kernel@vger.kernel.org>; Fri, 17 Sep 2021 09:21:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
        s=20210705; t=1631870508;
        bh=o7vBhR0EpCJ0RBAVx7tRojMJZmGtoI7hI2etAgBdAnA=;
        h=From:To:Cc:Subject:Date:Message-Id:MIME-Version;
        b=LzLZlHt+ACbfnQcE8DbTwo40+/rxRFJ250ENwtgsoMVY3IUpakGi2eMqBMP5Jvzp0
         /VuGB3SQAFoTxe9bjpMj93vZj0zetH49tfPuo7UVN1qVG7fTUm3+BiQF8nAA5Kqmix
         BGXI0S+/dRUXZBb0v1PBRYE2OdKD5HCHeV0tiyvbuyj/Ch+N1BCWkhTuKrK1ZLkBKa
         /mCgwEPoc8DW6pK6FDrpwre47EXZ3ubdmkSkHJU0DYVONu2YUZJ3aTq0YzWt9cqJQk
         NOuMRaQBMCAAmNQuEw5tPqCOe57/zopifYiw7tLepxTdahH9S1sp4aJRSFo/k3Rixp
         z2YEMg10KDNWA==
Received: by mail-wm1-f72.google.com with SMTP id y12-20020a1c7d0c000000b003077f64d75fso4356429wmc.7
        for <linux-kernel@vger.kernel.org>; Fri, 17 Sep 2021 02:21:48 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=o7vBhR0EpCJ0RBAVx7tRojMJZmGtoI7hI2etAgBdAnA=;
        b=0JhVPwmWWBIB3yS+YAYPMs2KbAf31eN5TK/uA393cbz5yQoLe8c7zocwHGPDvNBxDd
         Yb3F8+/Ht9BDIgv2VMtcD/kOnS6rV6w6LTWdoftS+nGTAeHwBjo4SB7pz5Qc5X4xNxpn
         hSBHlaWlDmMt4yxEhj033KxbjCnJQQ8/xLDvZHunLvglaWyGqA2X8RhhGkJccW7pjFG9
         k4trKDNfnaO3lWZ+2OFCcSukU0Eni21vkOP+g4tk3gz8w5lv2Sfnt4LjoEYJ3t9KVpMq
         sIgYYBj0yAhW/ATcsb6n7GQdEGKdu0fcvSL8nOJEJa3lPUdrY8iU58/I+DwYDrnPl2T2
         FTtw==
X-Gm-Message-State: AOAM530XngxNdvYV7FrZ/4g0dU5UorqZiTmqueQH475E9CfMPD7QyeSP
        vwQEq+B0wQzcssqLrboGKIdFhtr7HdqVRR1TGzQcqVIqDhCHxjhdEB63CGwXssj1IcyIr7wcShA
        +/gC1xLdb4fdLh8s974OyDVwzAsULeKTLrCrPaE3zwA==
X-Received: by 2002:a1c:f60c:: with SMTP id w12mr14328397wmc.3.1631870508059;
        Fri, 17 Sep 2021 02:21:48 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJwSh7nZCh0xloMemj03rh/x1IOY4KIeubxmM6VRIwneWeSzjscQX4mH7jZn/VoYdck4c9qCIw==
X-Received: by 2002:a1c:f60c:: with SMTP id w12mr14328373wmc.3.1631870507862;
        Fri, 17 Sep 2021 02:21:47 -0700 (PDT)
Received: from localhost.localdomain (lk.84.20.244.219.dc.cable.static.lj-kabel.net. [84.20.244.219])
        by smtp.gmail.com with ESMTPSA id n3sm5921163wmi.0.2021.09.17.02.21.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 17 Sep 2021 02:21:47 -0700 (PDT)
From:   Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
To:     Pontus Fuchs <pontus.fuchs@gmail.com>,
        Kalle Valo <kvalo@codeaurora.org>,
        "David S. Miller" <davem@davemloft.net>,
        Jakub Kicinski <kuba@kernel.org>,
        Stanislaw Gruszka <stf_xl@wp.pl>,
        Helmut Schaa <helmut.schaa@googlemail.com>,
        Daniel Drake <dsd@gentoo.org>,
        Ulrich Kunitz <kune@deine-taler.de>,
        linux-wireless@vger.kernel.org, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org, zd1211-devs@lists.sourceforge.net
Cc:     Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
Subject: [PATCH 1/3] zd1211rw: remove duplicate USB device ID
Date:   Fri, 17 Sep 2021 11:21:06 +0200
Message-Id: <20210917092108.19497-1-krzysztof.kozlowski@canonical.com>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The device 0x07b8,0x6001 is already on the list as zd1211 chip. Wiki
https://wireless.wiki.kernel.org/en/users/Drivers/zd1211rw/devices
confirms it is also zd1211, not the zd1211b.

Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
---
 drivers/net/wireless/zydas/zd1211rw/zd_usb.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/net/wireless/zydas/zd1211rw/zd_usb.c b/drivers/net/wireless/zydas/zd1211rw/zd_usb.c
index a7ceef10bf6a..850c26bc9524 100644
--- a/drivers/net/wireless/zydas/zd1211rw/zd_usb.c
+++ b/drivers/net/wireless/zydas/zd1211rw/zd_usb.c
@@ -65,7 +65,6 @@ static const struct usb_device_id usb_ids[] = {
 	{ USB_DEVICE(0x0586, 0x3412), .driver_info = DEVICE_ZD1211B },
 	{ USB_DEVICE(0x0586, 0x3413), .driver_info = DEVICE_ZD1211B },
 	{ USB_DEVICE(0x079b, 0x0062), .driver_info = DEVICE_ZD1211B },
-	{ USB_DEVICE(0x07b8, 0x6001), .driver_info = DEVICE_ZD1211B },
 	{ USB_DEVICE(0x07fa, 0x1196), .driver_info = DEVICE_ZD1211B },
 	{ USB_DEVICE(0x083a, 0x4505), .driver_info = DEVICE_ZD1211B },
 	{ USB_DEVICE(0x083a, 0xe501), .driver_info = DEVICE_ZD1211B },
-- 
2.30.2

