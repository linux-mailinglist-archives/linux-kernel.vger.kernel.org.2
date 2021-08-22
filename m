Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 34B243F3F16
	for <lists+linux-kernel@lfdr.de>; Sun, 22 Aug 2021 13:41:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233672AbhHVLlx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 22 Aug 2021 07:41:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37760 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233423AbhHVLlw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 22 Aug 2021 07:41:52 -0400
Received: from mail-wm1-x32b.google.com (mail-wm1-x32b.google.com [IPv6:2a00:1450:4864:20::32b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C1552C061575
        for <linux-kernel@vger.kernel.org>; Sun, 22 Aug 2021 04:41:11 -0700 (PDT)
Received: by mail-wm1-x32b.google.com with SMTP id l7-20020a1c2507000000b002e6be5d86b3so8874561wml.3
        for <linux-kernel@vger.kernel.org>; Sun, 22 Aug 2021 04:41:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=EGnJb6dK+F7FLCF7zjXaWBGNlnlVYewZwO3r2RfXfdE=;
        b=IQTqEEwIQpEooFMBpIdtXQQ93xAhR+U0K4YYB9ftA6e3dcwo5heF5iQmdZpR1ALN1O
         ErTQUTBoyD6NjbFpcSY7PX0cpL3HsUjTZBBzf9u+W9be5lnaClp3pW064IkcDYaYJ9TN
         qx0iDBktuZc8j9nrrRySbbaYQNS2oaxstsNwytafsj1QtnHUKIeM089GE4oY+ZPPHKbu
         E5WgWNCBrxkTEGagec8R0tsh9ubC2Ff1lmMGjNskQLNOcRYBvC8uYKCZUlDFDPM9GNF2
         SBIf5X3j5noRciaUucXohfhwiEmGUnk9fbX+tGiB78CDqEoO/Xqt9PUBV1BQjq3yXNSN
         /uEQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=EGnJb6dK+F7FLCF7zjXaWBGNlnlVYewZwO3r2RfXfdE=;
        b=Q3S9O+OdGjlKkCEmMpPKJfMEyX6T/fvtSpXCYyvPDuHZ8vUkb+93YS105PMFrVSWkO
         +ch+cirQB8D+qqhjCoJz+Oxw0qvt3jCl2ZPpbJfcbPMtmVYVpK90XeFIg9NyQgo9atXn
         00jH8H5xId66h/iC2yJtgye76u5+jHcH0P6TS4vhUbF01tVllG7XlFKHgT/O2C9eQeUS
         AOX+O+6HYavUXQFDaQY/NV3lOkXNQOZLSVOl97IAGeCfmc6benG6PzzKmn1CNc1ytgNh
         QmBwYO6v6lHDlzWmZyAMF60W2puhpgeHE+nIqKC2+1GOgpPOppnlGX/vfxeX0jr0aWWs
         8EPA==
X-Gm-Message-State: AOAM530GWqp85mZUx8CC05FJfd0ui40s5o6rRAdd/Vv65b8Y+kXJmKyW
        /jtHpXxsm8b6MGldMKvZasI=
X-Google-Smtp-Source: ABdhPJxOXZyTtKO2LUpFsSSs9gAakkNFjU9/cuUW0gO4qJqcbCAj3aW4XAgprShsBZIb0roDKKlMYg==
X-Received: by 2002:a7b:c4d8:: with SMTP id g24mr11701534wmk.38.1629632470471;
        Sun, 22 Aug 2021 04:41:10 -0700 (PDT)
Received: from localhost.localdomain ([2a02:8108:96c0:3b88::687e])
        by smtp.gmail.com with ESMTPSA id q3sm9831235wmf.37.2021.08.22.04.41.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 22 Aug 2021 04:41:10 -0700 (PDT)
From:   Michael Straube <straube.linux@gmail.com>
To:     gregkh@linuxfoundation.org
Cc:     Larry.Finger@lwfinger.net, phil@philpotter.co.uk, martin@kaiser.cx,
        fmdefrancesco@gmail.com, linux-staging@lists.linux.dev,
        linux-kernel@vger.kernel.org,
        Michael Straube <straube.linux@gmail.com>
Subject: [PATCH 1/2] staging: r8188eu: remove dead code
Date:   Sun, 22 Aug 2021 13:40:13 +0200
Message-Id: <20210822114014.21584-1-straube.linux@gmail.com>
X-Mailer: git-send-email 2.32.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

if (0) is never true, remove code that is never executed.

Signed-off-by: Michael Straube <straube.linux@gmail.com>
---
 drivers/staging/r8188eu/core/rtw_led.c | 5 +----
 1 file changed, 1 insertion(+), 4 deletions(-)

diff --git a/drivers/staging/r8188eu/core/rtw_led.c b/drivers/staging/r8188eu/core/rtw_led.c
index 306862aec53a..29c48f1a4fec 100644
--- a/drivers/staging/r8188eu/core/rtw_led.c
+++ b/drivers/staging/r8188eu/core/rtw_led.c
@@ -121,10 +121,7 @@ static void SwLedBlink(struct LED_871x *pLed)
 	}
 
 	if (bStopBlinking) {
-		/* if (padapter->pwrctrlpriv.cpwm >= PS_STATE_S2) */
-		if (0) {
-			SwLedOff(padapter, pLed);
-		} else if ((check_fwstate(pmlmepriv, _FW_LINKED)) && (!pLed->bLedOn)) {
+		if ((check_fwstate(pmlmepriv, _FW_LINKED)) && (!pLed->bLedOn)) {
 			SwLedOn(padapter, pLed);
 		} else if ((check_fwstate(pmlmepriv, _FW_LINKED)) &&  pLed->bLedOn) {
 			SwLedOff(padapter, pLed);
-- 
2.32.0

