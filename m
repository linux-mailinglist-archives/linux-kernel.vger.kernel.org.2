Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2A1AC3EB186
	for <lists+linux-kernel@lfdr.de>; Fri, 13 Aug 2021 09:32:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239448AbhHMHca (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 13 Aug 2021 03:32:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53806 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239435AbhHMHc2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 Aug 2021 03:32:28 -0400
Received: from mail-wr1-x429.google.com (mail-wr1-x429.google.com [IPv6:2a00:1450:4864:20::429])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 17068C061756
        for <linux-kernel@vger.kernel.org>; Fri, 13 Aug 2021 00:32:02 -0700 (PDT)
Received: by mail-wr1-x429.google.com with SMTP id x10so5668398wrt.8
        for <linux-kernel@vger.kernel.org>; Fri, 13 Aug 2021 00:32:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=oWgTAW0kExPJoTtfAVDIWDbUQSLrhJpY47hv1up2zc8=;
        b=ng9LrTs5VkR1F72sPWin2RUKSgK9af2K0bcwTilEqgTW3GcSSPnksnhriQUCL8uw5q
         +PSbho4VguP7pd2Pm76z0hYHjcESbvgeCoTB1paroM/gtUCkUsrrzroa0gAX3BYHtf90
         RSrFD5OfpTvXCKzSSEjwlxbvu1Mrp4bqIYUpVK9L4lTxGJt0GQO9EpQJNgn8Q6nzELMC
         mDEVpmGvCYc0M/8M1i4OfNpISC1UHG2nKOQjY69VSW7X7wcsX5eq1rCI04SBMmTZ+4wI
         cbIk6NTtdc2Z2U+Pv9RV/ZrIylylbNhmQJTtQTEX3uEocBa6Mna2ui459zq+EKwQD4g7
         deSw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=oWgTAW0kExPJoTtfAVDIWDbUQSLrhJpY47hv1up2zc8=;
        b=RSA96G4JUTIlhIl+GERNsFK5vrkuTvuGQ7YgiZnOhvXgXcuaHWei4YGplB3oRw/VY3
         /z4vSGW8KglkG4RYvLF25xj7y7A7Kc9LlV/14xhI8rO62WY9reLjVjPveLr+NORcbzCL
         GGZt3d+oTNpR8PCYPA+kc0K1HYF52EkrZepirm6/dBco8WTwzoPuNu8vrzs92c1K/zWZ
         R+D1sOOT45kltTtO8nWKsbfu317FCM3ReA7xH12Xz0dYJ2MzMPBS8V3cbeokcjvCHxQt
         o118Ncoz+Tp8qmD6VI4e4ZRt1MF1X74C3+LLgCWrepRudF60lxcFwaFd9tzonwYCuSqf
         3reA==
X-Gm-Message-State: AOAM5339Tl5fB7juOdSwg0izOnCVxeuUbtUKMVagbSvESkqTIrlxcwPa
        hSxZy/6dDGTKmiFB+bZOGj0=
X-Google-Smtp-Source: ABdhPJwEvmRvLanBtFnrUxA+a4iec6OsIVZaG8ShuJBzMKfTjReWis6H2uIQA9ohZQXkLCAK+j4shQ==
X-Received: by 2002:a5d:5985:: with SMTP id n5mr1425047wri.394.1628839920745;
        Fri, 13 Aug 2021 00:32:00 -0700 (PDT)
Received: from localhost.localdomain ([2a02:8108:96c0:3b88::2571])
        by smtp.gmail.com with ESMTPSA id k12sm697406wrd.75.2021.08.13.00.32.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 13 Aug 2021 00:32:00 -0700 (PDT)
From:   Michael Straube <straube.linux@gmail.com>
To:     gregkh@linuxfoundation.org
Cc:     Larry.Finger@lwfinger.net, phil@philpotter.co.uk, martin@kaiser.cx,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org,
        Michael Straube <straube.linux@gmail.com>
Subject: [PATCH 1/4] staging: r8188eu: remove 5GHz code from Hal_GetChnlGroup88E()
Date:   Fri, 13 Aug 2021 09:31:06 +0200
Message-Id: <20210813073109.25609-2-straube.linux@gmail.com>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <20210813073109.25609-1-straube.linux@gmail.com>
References: <20210813073109.25609-1-straube.linux@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Remove 5GHz code from Hal_GetChnlGroup88E().

Signed-off-by: Michael Straube <straube.linux@gmail.com>
---
 .../staging/r8188eu/hal/rtl8188e_hal_init.c   | 62 +++++--------------
 1 file changed, 14 insertions(+), 48 deletions(-)

diff --git a/drivers/staging/r8188eu/hal/rtl8188e_hal_init.c b/drivers/staging/r8188eu/hal/rtl8188e_hal_init.c
index f0560c15387c..634a0a022727 100644
--- a/drivers/staging/r8188eu/hal/rtl8188e_hal_init.c
+++ b/drivers/staging/r8188eu/hal/rtl8188e_hal_init.c
@@ -2062,54 +2062,20 @@ static void Hal_ReadPowerValueFromPROM_8188E(struct txpowerinfo24g *pwrInfo24G,
 
 static u8 Hal_GetChnlGroup88E(u8 chnl, u8 *pGroup)
 {
-	u8 bIn24G = true;
-
-	if (chnl <= 14) {
-		bIn24G = true;
-
-		if (chnl < 3)			/*  Channel 1-2 */
-			*pGroup = 0;
-		else if (chnl < 6)		/*  Channel 3-5 */
-			*pGroup = 1;
-		else	 if (chnl < 9)		/*  Channel 6-8 */
-			*pGroup = 2;
-		else if (chnl < 12)		/*  Channel 9-11 */
-			*pGroup = 3;
-		else if (chnl < 14)		/*  Channel 12-13 */
-			*pGroup = 4;
-		else if (chnl == 14)		/*  Channel 14 */
-			*pGroup = 5;
-	} else {
-		bIn24G = false;
-
-		if (chnl <= 40)
-			*pGroup = 0;
-		else if (chnl <= 48)
-			*pGroup = 1;
-		else	 if (chnl <= 56)
-			*pGroup = 2;
-		else if (chnl <= 64)
-			*pGroup = 3;
-		else if (chnl <= 104)
-			*pGroup = 4;
-		else if (chnl <= 112)
-			*pGroup = 5;
-		else if (chnl <= 120)
-			*pGroup = 5;
-		else if (chnl <= 128)
-			*pGroup = 6;
-		else if (chnl <= 136)
-			*pGroup = 7;
-		else if (chnl <= 144)
-			*pGroup = 8;
-		else if (chnl <= 153)
-			*pGroup = 9;
-		else if (chnl <= 161)
-			*pGroup = 10;
-		else if (chnl <= 177)
-			*pGroup = 11;
-	}
-	return bIn24G;
+	if (chnl < 3)			/*  Channel 1-2 */
+		*pGroup = 0;
+	else if (chnl < 6)		/*  Channel 3-5 */
+		*pGroup = 1;
+	else if (chnl < 9)		/*  Channel 6-8 */
+		*pGroup = 2;
+	else if (chnl < 12)		/*  Channel 9-11 */
+		*pGroup = 3;
+	else if (chnl < 14)		/*  Channel 12-13 */
+		*pGroup = 4;
+	else if (chnl == 14)		/*  Channel 14 */
+		*pGroup = 5;
+
+	return true;
 }
 
 void Hal_ReadPowerSavingMode88E(struct adapter *padapter, u8 *hwinfo, bool AutoLoadFail)
-- 
2.32.0

