Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C80933F3C69
	for <lists+linux-kernel@lfdr.de>; Sat, 21 Aug 2021 22:23:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229964AbhHUUX4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 21 Aug 2021 16:23:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37596 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229744AbhHUUXz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 21 Aug 2021 16:23:55 -0400
Received: from mail-pj1-x1030.google.com (mail-pj1-x1030.google.com [IPv6:2607:f8b0:4864:20::1030])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 06931C061575
        for <linux-kernel@vger.kernel.org>; Sat, 21 Aug 2021 13:23:15 -0700 (PDT)
Received: by mail-pj1-x1030.google.com with SMTP id gz13-20020a17090b0ecdb0290178c0e0ce8bso11140038pjb.1
        for <linux-kernel@vger.kernel.org>; Sat, 21 Aug 2021 13:23:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:mime-version:content-disposition;
        bh=PQ0kuL9gkx8s1jZqXYLC1xp9qFGx+ag16bv9EFtZWZg=;
        b=R0iXxfxeaWOuIMXxBqJgwpmEs+YrrkoGLezGgjHac7erBTBCmHznlnD8ScyHR7amLv
         GrZhBkuLP+oWanthAX/AAbWk1EEqcImQr7xwrYXDUfC++qZAisGMgAGNgmkx63OnURDY
         knEAqu4eKhxPaYJJ/Wx2eVQVA7r6zhdKf0HTGk5E2NuNN/uHMNPviQmRnzczYZWoHRAt
         lfV3fgDf/r8pJbRipGHsU6Wrhdkf8bxBTwQfLIsBm3v4hvc3YE2xFhAgUrOpkv1dk5cZ
         kPByeWfzkPZM/HKfSZd0EPvIsDXFon0IC2VtOQcd3zjkddMqflyZzimzjnPVinETlyRm
         PxFg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:mime-version
         :content-disposition;
        bh=PQ0kuL9gkx8s1jZqXYLC1xp9qFGx+ag16bv9EFtZWZg=;
        b=qfeT1YTa1kCS6PUoZDetv/nn+ZZbKiXgZc05IyIF8DAYpXZVBXDg+13K/zbULHJgnu
         8jJ06Wlnm5V3iq39kX8Kj84ur4gwxBTA5xG0vgbGR6eu6j18B9T/2dd1l40QaKJWM12K
         pf/0RN2fDhbX+nJFjCJrjuk4q8ihWCcJo8qVMKvKHxBkMzDXiqJB0K71NDtZfo0SLlrR
         vM95f3+52J2q9R159n3wdYid6CKYB0KKlLDNrMfFSFkdI9esI5cxoLuoni+EVNQD4GB7
         1zBnDk0pieelgjUOfLyxrCtjVI+BCOXFDIXjfqkgMonnd8XF7GT/KnGumMu7VXhrTwOc
         folQ==
X-Gm-Message-State: AOAM531kbgkjyQCLZxe0o4NmO6RNSvIfuNyqTlNdWbvUC6iCaUbbTZik
        TCNxgp4dtszHqzZk78PU9OE=
X-Google-Smtp-Source: ABdhPJzzCAc5LCMMermGlZjmy6uhYlmlp/zQj/7BLosZaU2KEqRItb8/yapd4m2Ge6Nkc1MAyX8aRQ==
X-Received: by 2002:a17:902:7897:b0:132:580a:90b4 with SMTP id q23-20020a170902789700b00132580a90b4mr3627046pll.7.1629577395400;
        Sat, 21 Aug 2021 13:23:15 -0700 (PDT)
Received: from user ([106.212.234.168])
        by smtp.gmail.com with ESMTPSA id z4sm70841pjl.53.2021.08.21.13.23.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 21 Aug 2021 13:23:14 -0700 (PDT)
Date:   Sun, 22 Aug 2021 01:53:08 +0530
From:   Saurav Girepunje <saurav.girepunje@gmail.com>
To:     Larry.Finger@lwfinger.net, phil@philpotter.co.uk,
        gregkh@linuxfoundation.org, saurav.girepunje@gmail.com,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org
Cc:     saurav.girepunje@hotmail.com
Subject: [PATCH] staging: r8188eu: core: remove condition with no effect
Message-ID: <YSFgrLUfXzgcT6k4@user>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Remove the condition with no effect (if == else) in rtw_led.c
file.

Signed-off-by: Saurav Girepunje <saurav.girepunje@gmail.com>
---
 drivers/staging/r8188eu/core/rtw_led.c | 5 +----
 1 file changed, 1 insertion(+), 4 deletions(-)

diff --git a/drivers/staging/r8188eu/core/rtw_led.c b/drivers/staging/r8188eu/core/rtw_led.c
index 22d4df9c92a5..76cbd5f19f90 100644
--- a/drivers/staging/r8188eu/core/rtw_led.c
+++ b/drivers/staging/r8188eu/core/rtw_led.c
@@ -148,10 +148,7 @@ static void SwLedBlink(struct LED_871x *pLed)
 			_set_timer(&(pLed->BlinkTimer), LED_BLINK_SLOWLY_INTERVAL);
 			break;
 		case LED_BLINK_WPS:
-			if (pLed->BlinkingLedState == RTW_LED_ON)
-				_set_timer(&(pLed->BlinkTimer), LED_BLINK_LONG_INTERVAL);
-			else
-				_set_timer(&(pLed->BlinkTimer), LED_BLINK_LONG_INTERVAL);
+			_set_timer(&(pLed->BlinkTimer), LED_BLINK_LONG_INTERVAL);
 			break;
 		default:
 			_set_timer(&(pLed->BlinkTimer), LED_BLINK_SLOWLY_INTERVAL);
--
2.30.2

