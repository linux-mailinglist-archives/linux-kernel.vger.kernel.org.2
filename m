Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7E7163F3F17
	for <lists+linux-kernel@lfdr.de>; Sun, 22 Aug 2021 13:41:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233725AbhHVLly (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 22 Aug 2021 07:41:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37766 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233643AbhHVLlx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 22 Aug 2021 07:41:53 -0400
Received: from mail-wm1-x332.google.com (mail-wm1-x332.google.com [IPv6:2a00:1450:4864:20::332])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 83BCCC061575
        for <linux-kernel@vger.kernel.org>; Sun, 22 Aug 2021 04:41:12 -0700 (PDT)
Received: by mail-wm1-x332.google.com with SMTP id l24-20020a05600c089800b002e71a10130eso5636768wmp.5
        for <linux-kernel@vger.kernel.org>; Sun, 22 Aug 2021 04:41:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=L3+/t+M4NdbuQEywJSiSAtkeuUZUxnSjSeon08Uk4D4=;
        b=uFZ6GRjQqJCWSKzx3M+yIrVffXPmRu+XZeyH40iRzyNkat01pe/8kL6w1v8vAza+kL
         b6DkvMqtDckvtvplgB5V5o6MgrpWWp9p+KONAqMA/ZcUsNwjbahPyjpHttQYRc1xKXkT
         RSWCsAeyw2NxKUuT1DBeIx2xdmgDlqKwEm+2RND907OLlE6+3dY7lso7LFt0x3GWl8CP
         YNiWr7iVnUVo2Np+YlGbMneXaCAzo3buNP7rRCRJEVCmJpbk8Avvr5XsSfOb2szQHkaJ
         bTZlPNojzDY2L0MLJZZP9pvZs0Orm6n8Bwb2PF+t2zA6THdo9RKZHAbnpZqUlIxqlP9/
         sGuA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=L3+/t+M4NdbuQEywJSiSAtkeuUZUxnSjSeon08Uk4D4=;
        b=WPtRDlhtPPu0QQ1ivMhk8JnBcoEmuVgx6XgZ95R/8prZE0pVoA4Isgk4XMIA2c8CrW
         Xkr9DX1gOpcNyV6BmGX1Hf6Mbj+KHrQ4MTD/8++tC/PKz6AL23SKI3fR3rCN/sHbHjcr
         Q5RPc5PI2v3rnS3CbgRr/kLJhs7LqAq9mKT8atBKxXg6q8PDAM7PrRURWjLX18cEUWnO
         U0gb4CnurxPcBKapaI0dtKIw3BEqVy57qnXqr9SvLYEKgBI/O2bpxPwa1iFvPYWTTnhW
         IpdcnRGj1yVjoMv6yfFNu04cMl7PAKNA87jg3Mdbx3HDZyOs+lmicpyszz3Uc7waU+Ac
         kDow==
X-Gm-Message-State: AOAM532WxnNh69LQQNiTHvo0rzQCSlZLtA8JKEwUYr1wxD+MH0BGUzV3
        zNnkULzqXnNt/HyNNsTql4A=
X-Google-Smtp-Source: ABdhPJwEh3fDTlvjD2ciXWaWgQjABCYPEgZ9AbYHWy5g6n5HZu3U8x2Ylk/pajojj8avm5WVVcZMgQ==
X-Received: by 2002:a7b:c442:: with SMTP id l2mr12047673wmi.131.1629632471190;
        Sun, 22 Aug 2021 04:41:11 -0700 (PDT)
Received: from localhost.localdomain ([2a02:8108:96c0:3b88::687e])
        by smtp.gmail.com with ESMTPSA id q3sm9831235wmf.37.2021.08.22.04.41.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 22 Aug 2021 04:41:10 -0700 (PDT)
From:   Michael Straube <straube.linux@gmail.com>
To:     gregkh@linuxfoundation.org
Cc:     Larry.Finger@lwfinger.net, phil@philpotter.co.uk, martin@kaiser.cx,
        fmdefrancesco@gmail.com, linux-staging@lists.linux.dev,
        linux-kernel@vger.kernel.org,
        Michael Straube <straube.linux@gmail.com>
Subject: [PATCH 2/2] staging: r8188eu: remove unnecessary parentheses
Date:   Sun, 22 Aug 2021 13:40:14 +0200
Message-Id: <20210822114014.21584-2-straube.linux@gmail.com>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <20210822114014.21584-1-straube.linux@gmail.com>
References: <20210822114014.21584-1-straube.linux@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Remove unnecessary parentheses to improve readability.

Signed-off-by: Michael Straube <straube.linux@gmail.com>
---
 drivers/staging/r8188eu/core/rtw_led.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/staging/r8188eu/core/rtw_led.c b/drivers/staging/r8188eu/core/rtw_led.c
index 29c48f1a4fec..cd27873c3e63 100644
--- a/drivers/staging/r8188eu/core/rtw_led.c
+++ b/drivers/staging/r8188eu/core/rtw_led.c
@@ -121,9 +121,9 @@ static void SwLedBlink(struct LED_871x *pLed)
 	}
 
 	if (bStopBlinking) {
-		if ((check_fwstate(pmlmepriv, _FW_LINKED)) && (!pLed->bLedOn)) {
+		if (check_fwstate(pmlmepriv, _FW_LINKED) && !pLed->bLedOn) {
 			SwLedOn(padapter, pLed);
-		} else if ((check_fwstate(pmlmepriv, _FW_LINKED)) &&  pLed->bLedOn) {
+		} else if (check_fwstate(pmlmepriv, _FW_LINKED) && pLed->bLedOn) {
 			SwLedOff(padapter, pLed);
 		}
 		pLed->BlinkTimes = 0;
-- 
2.32.0

