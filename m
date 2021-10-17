Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2FD3F430AE6
	for <lists+linux-kernel@lfdr.de>; Sun, 17 Oct 2021 18:53:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344279AbhJQQxL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 17 Oct 2021 12:53:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41944 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344273AbhJQQxK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 17 Oct 2021 12:53:10 -0400
Received: from mail-wm1-x32f.google.com (mail-wm1-x32f.google.com [IPv6:2a00:1450:4864:20::32f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 38A48C06161C
        for <linux-kernel@vger.kernel.org>; Sun, 17 Oct 2021 09:51:00 -0700 (PDT)
Received: by mail-wm1-x32f.google.com with SMTP id s198-20020a1ca9cf000000b0030d6986ea9fso6459373wme.1
        for <linux-kernel@vger.kernel.org>; Sun, 17 Oct 2021 09:50:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=UZeVnNCmW5EyaPMj60KfsQo7kwwc+3LgC2qvi+RyQlo=;
        b=I10ALzmYuQSVIkoaVW9ciNkm/ET7sZtHXyT51uXtjXLZZIPpWNAwizgV62EnyDFjUN
         B3POG3muifaAleDji4ORbqlsBMATCUo+4tvSDN4FfDs2Ys/VJLZXIajKfMIsHs3z/7x9
         KG8CiJFYC6RadgmZT9xUObOXzUNN6msDl3sYcFOIq0uzxaWF7JQIv46nH4+A6OFZ2BYV
         bJGiFZciPBdKawTA6DjlOMgMZ8fcCC+40qP1dUKcrGrqXsKLIzFXdHDlsWdEwg7QUjDJ
         dcj9Culszto3GfUeHwlNHyFWGIi7gVgfh2OBE9/5FMnyT3kxcY5iHaYVKz3mMyhPctL7
         pwEw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=UZeVnNCmW5EyaPMj60KfsQo7kwwc+3LgC2qvi+RyQlo=;
        b=TdxlU/eXTY8sF4cRymRT4cGKX+dqNum28veFYBQIs5wXn9ZIGKl+UiA/Dk7xAjWRTA
         tOw+RgCo5ir1uGBJL9e8TPcY5aio+VtSwLPMBNDffY3OC5NSYDxOTS4pVnI4CyU1/CPe
         er3cY4PupqwibuzTNWnRpPKAGyFd94icaP/SU7pPpP9VJ7zlpGR8KLqc4oLi95UNXs+s
         mg2qj74B86sDzZGR69DESTtg1xzY9F0yTd2ddXhIVlIQx9qQXotjFFSQs2oMkxPkeQm+
         ObsBnrtWnAan6hpuvhMSxKroA/vBk6JsbIjhYHLqt1jHXnPYJ69/peLwDGhJhgCjqvMD
         vX2g==
X-Gm-Message-State: AOAM532FW6OmspCKeAR44Dz1xdDKamFWQs/J+JPkbxe5+tAcgEs375Xa
        nYYVgnLNEyXc/HX4QaU9MiMxlKEUAPQ=
X-Google-Smtp-Source: ABdhPJwycNnkDcN6ezgCoYR+2+ScM82E0WaX2bP2GyDF9tKW1sNC49D3xGRV3D7sHvBWB54JCyzdDA==
X-Received: by 2002:a05:600c:4fcd:: with SMTP id o13mr40360450wmq.158.1634489458610;
        Sun, 17 Oct 2021 09:50:58 -0700 (PDT)
Received: from localhost.localdomain ([2a02:8108:96c0:3b88::3de4])
        by smtp.gmail.com with ESMTPSA id p18sm11249489wrt.54.2021.10.17.09.50.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 17 Oct 2021 09:50:58 -0700 (PDT)
From:   Michael Straube <straube.linux@gmail.com>
To:     gregkh@linuxfoundation.org
Cc:     Larry.Finger@lwfinger.net, phil@philpotter.co.uk,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org,
        Michael Straube <straube.linux@gmail.com>
Subject: [PATCH] staging: r8188eu: remove unnecessary asignment
Date:   Sun, 17 Oct 2021 18:50:49 +0200
Message-Id: <20211017165049.8061-1-straube.linux@gmail.com>
X-Mailer: git-send-email 2.33.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The asignment "pLed->BlinkTimes = 0" is in a code path that is
executed only if pLed->BlinkTimes is 0. Remove this unnecessary
asignment.

Signed-off-by: Michael Straube <straube.linux@gmail.com>
---
 drivers/staging/r8188eu/core/rtw_led.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/staging/r8188eu/core/rtw_led.c b/drivers/staging/r8188eu/core/rtw_led.c
index 09d8c4e85863..0e3453639a8b 100644
--- a/drivers/staging/r8188eu/core/rtw_led.c
+++ b/drivers/staging/r8188eu/core/rtw_led.c
@@ -142,7 +142,6 @@ static void SwLedBlink1(struct LED_871x *pLed)
 					pLed->BlinkingLedState = RTW_LED_ON;
 				_set_timer(&pLed->BlinkTimer, LED_BLINK_NO_LINK_INTERVAL_ALPHA);
 			}
-			pLed->BlinkTimes = 0;
 			pLed->bLedBlinkInProgress = false;
 		} else {
 			if (pLed->bLedOn)
-- 
2.33.0

