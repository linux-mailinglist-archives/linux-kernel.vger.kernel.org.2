Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AFFB4363702
	for <lists+linux-kernel@lfdr.de>; Sun, 18 Apr 2021 19:32:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232154AbhDRRdL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 18 Apr 2021 13:33:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55610 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229783AbhDRRdK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 18 Apr 2021 13:33:10 -0400
Received: from mail-pg1-x529.google.com (mail-pg1-x529.google.com [IPv6:2607:f8b0:4864:20::529])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0D300C06174A
        for <linux-kernel@vger.kernel.org>; Sun, 18 Apr 2021 10:32:42 -0700 (PDT)
Received: by mail-pg1-x529.google.com with SMTP id f29so22624729pgm.8
        for <linux-kernel@vger.kernel.org>; Sun, 18 Apr 2021 10:32:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:date:to:cc:subject:message-id:mime-version:content-disposition;
        bh=AOU4sFlQzuUDId/4lsftUubI13w4y5BA/4YL9lGoNIE=;
        b=UDOWUj/BNmeQSx/IgyaGqDTmjZZszrVkDuNdr4y66X9r562Y+OY1cj1s5J936A/huy
         HSN5s1Cnru8Wu0vRluiQoRVnI30VApfE7lJFeTjHz1d0qbWv/oeAXtp6nJSwM7zJJoYg
         PCbwG8eVjPAtz9nbASXV2Uk7/pJnMsqyK9VzADmdyykFiCwHJ/LEX2knOiNBEwPzxYSt
         3dbv3vs3ms4DTQ6dT90qU1cXffjeTRcIX8LPEBn7rXnTkHPKSAqeCepJOEt9Z+44+Yw9
         YDhCy9zRTJKmMI+P+jRJCP+YW96FOZ7FpUzeMcJ4VEIlFmH9u9w45bH5JcmQt9kGjgAx
         lKSQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:date:to:cc:subject:message-id:mime-version
         :content-disposition;
        bh=AOU4sFlQzuUDId/4lsftUubI13w4y5BA/4YL9lGoNIE=;
        b=mvOv04l8kTib6jV4zbocxkYMYgfgna2KQcLO5Hb3b99mB76hUA2V4nUzGWCtWJJPPv
         ByUnxL2L/AYYd8lxHnKv3Sro7uImKLyRY01y/8rMh+sFw+SmnemXnCt5NIx+DrCnSHZ8
         vSzAt34Mu2SUeclSSAsSXfGpBSXF+pDfPPlUfQRtM1vdFAJ380LuSmmpI2yXtGMG/xy/
         UPmdT0MdKGx6np2tCnlAJAyinsjBQmgvMxh3qOW49ylkIp9KY87EBQOAqhD7rM8Q9y7n
         iPUgyg74jnXLMutT/LygHB6baeSd0tswfw5aiCgti3qPm99RdHXOyXd/PD33bOiadp8d
         KJ5A==
X-Gm-Message-State: AOAM533W0lMcavQQpf92JCqHRvpeJbAIE9u8rUYKyFkNDO+1qyQ0cHf9
        DQ2vyf1mYs7d6qt5VBmokew=
X-Google-Smtp-Source: ABdhPJwYtFD5FMK8qCddAiscQgeKoiR6Bcb9l4vBJZaJ2WSQjn0NaD71yQrqcqB8shkmFR89ZoS4Cg==
X-Received: by 2002:a05:6a00:1585:b029:203:6bc9:3ca6 with SMTP id u5-20020a056a001585b02902036bc93ca6mr16579043pfk.79.1618767161520;
        Sun, 18 Apr 2021 10:32:41 -0700 (PDT)
Received: from user ([2001:4490:4409:d07c:b4ac:39e7:e05c:f39b])
        by smtp.gmail.com with ESMTPSA id s40sm9411038pfw.100.2021.04.18.10.32.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 18 Apr 2021 10:32:41 -0700 (PDT)
From:   Saurav Girepunje <saurav.girepunje@gmail.com>
X-Google-Original-From: Saurav Girepunje <saurav.girepunje@google.com>
Date:   Sun, 18 Apr 2021 23:02:33 +0530
To:     gregkh@linuxfoundation.org, fabioaiuto83@gmail.com,
        hello@bryanbrattlof.com, hdegoede@redhat.com,
        saurav.girepunje@google.com, john.oldman@polehill.co.uk,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org
Cc:     saurav.girepunje@hotmail.com
Subject: [PATCH] staging: rtl8723bs: os_dep: remove multiple return
Message-ID: <20210418173233.GA59153@user>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

on sdio_intf.c rtw_sdio_suspend call we have multiple
return which can replace by goto exit. As in all the places
return value is 0.

Signed-off-by: Saurav Girepunje <saurav.girepunje@google.com>
---
 drivers/staging/rtl8723bs/os_dep/sdio_intf.c | 9 ++++++---
 1 file changed, 6 insertions(+), 3 deletions(-)

diff --git a/drivers/staging/rtl8723bs/os_dep/sdio_intf.c b/drivers/staging/rtl8723bs/os_dep/sdio_intf.c
index a9a9631dd23c..3e566cf97f6e 100644
--- a/drivers/staging/rtl8723bs/os_dep/sdio_intf.c
+++ b/drivers/staging/rtl8723bs/os_dep/sdio_intf.c
@@ -445,14 +445,17 @@ static int rtw_sdio_suspend(struct device *dev)
 	struct debug_priv *pdbgpriv = &psdpriv->drv_dbg;
 
 	if (padapter->bDriverStopped)
-		return 0;
+		goto exit;
 
 	if (pwrpriv->bInSuspend) {
 		pdbgpriv->dbg_suspend_error_cnt++;
-		return 0;
+		goto exit;
 	}
 
-	return rtw_suspend_common(padapter);
+	rtw_suspend_common(padapter);
+exit:
+
+	return 0;
 }
 
 static int rtw_resume_process(struct adapter *padapter)
-- 
2.25.1

