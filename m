Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A3F31430B0D
	for <lists+linux-kernel@lfdr.de>; Sun, 17 Oct 2021 19:06:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344329AbhJQRIr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 17 Oct 2021 13:08:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45450 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232018AbhJQRIr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 17 Oct 2021 13:08:47 -0400
Received: from mail-wr1-x431.google.com (mail-wr1-x431.google.com [IPv6:2a00:1450:4864:20::431])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1442FC06161C
        for <linux-kernel@vger.kernel.org>; Sun, 17 Oct 2021 10:06:37 -0700 (PDT)
Received: by mail-wr1-x431.google.com with SMTP id r18so36739260wrg.6
        for <linux-kernel@vger.kernel.org>; Sun, 17 Oct 2021 10:06:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=0fCaUspJ/VUdAic1iTmIc7QqeE5RksidRh973c3Qk4M=;
        b=iXSgDZaqTNHBfZliVp3BZ3lobHwLinkJKPO71D2DjocLFxQklwHYd1JQsEvKxwiALq
         /O9GqpGCwrVNMRsr212X3FzjmWnGPoxjSeN7F1Nw9YvH5/S2JUj6i8C/mXG18skfjtak
         oLY465w4KJqmcfmKE0NLDQ4UgPvCYH0aocORzpBljun8PsXK0tcVH02FLj2rmayPm701
         uKw5Fg8TQMEpIXtihfbyS0LI+SX2Q7jiATPTW5qdd2MqJP5H4w30fcE6h5N/96pnNgYO
         NVH0tx/kO5g4Z5lk6uq9ABbmbr4/JTdKMT7WZSTOlbOfoXKrFK2K/ecYfmksq3BNJI9g
         HXgg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=0fCaUspJ/VUdAic1iTmIc7QqeE5RksidRh973c3Qk4M=;
        b=leJ3Os61bkEptyVycyjh7EDUheGjNMvf4F9Z4XgZAQju4tmPutYh+s4PiAuU250Xcn
         uQsSR8on/s5CXihyhQe2LsfrJXCWQcir6E1U1hiKzifrqp3QfHyE3CwbD5QiX7JdroRF
         +76GE/Lma9COIbB3BEbuy3Ft1Ce7rjmQ5akrXU65Uol6MQWVqDmLT0GCjrGqE5zL8zvn
         4Q1INDwrYG4sYPO1eRZsxvCvrqHnUIZMPFR7L6F3kz0oCTrMsMks9tCksgaYnYKHbq1e
         9Ty72bFssBI6ZwS6feNlWt3irMvBXNBkLci12y8AdzPM2wVk+1A3zV8gKLC0AFPgW8p/
         kCIQ==
X-Gm-Message-State: AOAM533UHz1IL1nYf/kGBQVI2wrvEImnwCMq+5R5ZFZ8ClmBpDqhT5Kc
        2JJCgidBgQ1qUgNKpAgzUxQ3iJfuoF4=
X-Google-Smtp-Source: ABdhPJwptV8jz34KDdp9FKnw71xm3aQR2fR8we2XCT2K2ifnpwsil2y7WyfWWNRbuv/KEeb06WIadw==
X-Received: by 2002:adf:8b9a:: with SMTP id o26mr30517194wra.109.1634490395759;
        Sun, 17 Oct 2021 10:06:35 -0700 (PDT)
Received: from localhost.localdomain ([2a02:8108:96c0:3b88::3de4])
        by smtp.gmail.com with ESMTPSA id f186sm15813352wma.46.2021.10.17.10.06.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 17 Oct 2021 10:06:35 -0700 (PDT)
From:   Michael Straube <straube.linux@gmail.com>
To:     gregkh@linuxfoundation.org
Cc:     Larry.Finger@lwfinger.net, phil@philpotter.co.uk,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org,
        Michael Straube <straube.linux@gmail.com>
Subject: [PATCH v2] staging: r8188eu: remove unnecessary assignment
Date:   Sun, 17 Oct 2021 19:06:29 +0200
Message-Id: <20211017170629.13785-1-straube.linux@gmail.com>
X-Mailer: git-send-email 2.33.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The assignment "pLed->BlinkTimes = 0" is in a code path that is
executed only if pLed->BlinkTimes is 0. Remove this unnecessary
assignment.

Signed-off-by: Michael Straube <straube.linux@gmail.com>
---
v1 -> v2:
Fixed typos in the subject line and commit message.
asignment -> assignment

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

