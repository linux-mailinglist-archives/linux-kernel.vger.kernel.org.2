Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AFFE9407853
	for <lists+linux-kernel@lfdr.de>; Sat, 11 Sep 2021 15:29:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237322AbhIKNae (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 11 Sep 2021 09:30:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49276 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238607AbhIKN3T (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 11 Sep 2021 09:29:19 -0400
Received: from mail-wr1-x431.google.com (mail-wr1-x431.google.com [IPv6:2a00:1450:4864:20::431])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 91616C06139D
        for <linux-kernel@vger.kernel.org>; Sat, 11 Sep 2021 06:27:16 -0700 (PDT)
Received: by mail-wr1-x431.google.com with SMTP id n5so6827256wro.12
        for <linux-kernel@vger.kernel.org>; Sat, 11 Sep 2021 06:27:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=8jv3SaRimBllN++YKlTH+V3/aNHdh4o+a7TE+SifVGM=;
        b=WTmuR1Ic0Dizf8+Liqtye5+Rf8dDv/r2YRyPtxDr6ji160UYi2LV2c5qA56MiC3XP4
         zdOW2iFgiyI3XBrmrMeviCkhmjktz2c+RhDN67jHwl7YUoAPqh4rcusjJ0/z5o7nqIrA
         A9RquTtjgy8SoAuTMYxc2upIapZjH+LDnZ0T5Yil/W//yBmIXvNu5nGNOL1/Q+bVLLd/
         6FThEAPFNMVDm7oHEJ45AtDZWPXyrI2zR8QF/6PEFkE02O+GXGVxm7lXki8Gxwfy0Wbp
         AU1qnjHsrhE6HRPJHcq4oZBjftTwsCZdnNeXijbAKwwsAHTsXV+wQWF8dAGqPHiSNrkA
         KGJg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=8jv3SaRimBllN++YKlTH+V3/aNHdh4o+a7TE+SifVGM=;
        b=5m52uOzc9GFzztsHQbmWZpTU2D86CYBMPM4Oi4rMqg4oUabITTRFhDtlggV3r2wSAr
         XUlRBF2O2s8xhGpHfMWBKDhbYnXIYDdnJIla4t7AuJ92GhAyLBvulZZdCdtahm4g3Tpl
         9Xa9LefL9BgnIGEQZ1vLolg5ie5aRwqFLcQPcPalUVrHOHuhZIvVJlfy5bkDFcKttqEc
         YHH9JLbf35KPEDIZPr3q+L58wKhUW+8T1aAGw/HqnWRf8lrbmSlsDC80WN+qCw40PCJ8
         SPvz1BdBb5tNTa6QLuCZ/iUpjsp2mGvOWHf1Wvnar3I/Ss7cb1VHin2GYNq+sDK29zZQ
         UJFw==
X-Gm-Message-State: AOAM5300nOMhVMwaxDORuMbMqeXgnRWvNTwRo+W9zUwiGkVvLs7i9VgU
        eq0F7ILogA0bBKtHo7SUcyM=
X-Google-Smtp-Source: ABdhPJyzhEh86wwW3pEQrZ5IyDsuL33ZfgoZs/hu2OifhnfFg9OfybAoyO7Hk0ZzwkfbRcrBxaWAKA==
X-Received: by 2002:a05:6000:160d:: with SMTP id u13mr3201239wrb.17.1631366835236;
        Sat, 11 Sep 2021 06:27:15 -0700 (PDT)
Received: from localhost.localdomain ([2a02:8108:96c0:3b88::ae40])
        by smtp.gmail.com with ESMTPSA id 48sm1770253wrc.14.2021.09.11.06.27.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 11 Sep 2021 06:27:14 -0700 (PDT)
From:   Michael Straube <straube.linux@gmail.com>
To:     gregkh@linuxfoundation.org
Cc:     Larry.Finger@lwfinger.net, phil@philpotter.co.uk, martin@kaiser.cx,
        fmdefrancesco@gmail.com, linux-staging@lists.linux.dev,
        linux-kernel@vger.kernel.org,
        Michael Straube <straube.linux@gmail.com>
Subject: [PATCH 12/18] staging: r8188eu: remove unused ODM_SetTimer()
Date:   Sat, 11 Sep 2021 15:26:29 +0200
Message-Id: <20210911132635.30369-13-straube.linux@gmail.com>
X-Mailer: git-send-email 2.33.0
In-Reply-To: <20210911132635.30369-1-straube.linux@gmail.com>
References: <20210911132635.30369-1-straube.linux@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Function ODM_SetTimer() is unused, remove it.

Signed-off-by: Michael Straube <straube.linux@gmail.com>
---
 drivers/staging/r8188eu/hal/odm_interface.c     | 5 -----
 drivers/staging/r8188eu/include/odm_interface.h | 3 ---
 2 files changed, 8 deletions(-)

diff --git a/drivers/staging/r8188eu/hal/odm_interface.c b/drivers/staging/r8188eu/hal/odm_interface.c
index 7fd450575eb4..31888a6dd9a8 100644
--- a/drivers/staging/r8188eu/hal/odm_interface.c
+++ b/drivers/staging/r8188eu/hal/odm_interface.c
@@ -114,11 +114,6 @@ void ODM_sleep_ms(u32 ms)
 	msleep(ms);
 }
 
-void ODM_SetTimer(struct odm_dm_struct *pDM_Odm, struct timer_list *pTimer, u32 msDelay)
-{
-	_set_timer(pTimer, msDelay); /* ms */
-}
-
 void ODM_CancelTimer(struct odm_dm_struct *pDM_Odm, struct timer_list *pTimer)
 {
 	_cancel_timer_ex(pTimer);
diff --git a/drivers/staging/r8188eu/include/odm_interface.h b/drivers/staging/r8188eu/include/odm_interface.h
index f6c23fd9b31b..ce9e4d8b6830 100644
--- a/drivers/staging/r8188eu/include/odm_interface.h
+++ b/drivers/staging/r8188eu/include/odm_interface.h
@@ -104,9 +104,6 @@ void ODM_delay_us(u32 us);
 
 void ODM_sleep_ms(u32 ms);
 
-void ODM_SetTimer(struct odm_dm_struct *pDM_Odm, struct timer_list *pTimer,
-		  u32 msDelay);
-
 void ODM_InitializeTimer(struct odm_dm_struct *pDM_Odm,
 			 struct timer_list *pTimer, void *CallBackFunc,
 			 void *pContext, const char *szID);
-- 
2.33.0

