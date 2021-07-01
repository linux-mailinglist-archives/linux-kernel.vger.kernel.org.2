Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 52E003B938C
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Jul 2021 16:47:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232431AbhGAOtq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 1 Jul 2021 10:49:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37218 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229900AbhGAOtp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Jul 2021 10:49:45 -0400
Received: from mail-wr1-x432.google.com (mail-wr1-x432.google.com [IPv6:2a00:1450:4864:20::432])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D500AC061762
        for <linux-kernel@vger.kernel.org>; Thu,  1 Jul 2021 07:47:13 -0700 (PDT)
Received: by mail-wr1-x432.google.com with SMTP id g7so8560290wri.7
        for <linux-kernel@vger.kernel.org>; Thu, 01 Jul 2021 07:47:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=2SY0TCyX0d4BuF/HPv+siMhswvjAmIedZMktaAD9ovU=;
        b=u2Xernl74Yji61o8FpP1QFlZJ3MDeUgpGyYjHnFF6lX4yEuqCtkn1J/WZjBTUphlgg
         bYww79V5TefMavQ01JP5Td4vycf/QBjlmelOHA+pXAfZq5S7TRW68Lu5Xni6PL44cpmy
         quMQGZTnYYuPthHONXRsmEswsoSpgXV73f+jWPToiAM4iggxNVfTAWVpUkqcjIac62Ve
         lN/KG6keQ/J7RieQTNmLTp2tgl6xM/XNIrnT1wPAoMMoKkRR0Bk2my7JXqWSymFOExWE
         Nd6DjQ+s5hcmB8AjTgJMeBDQr632N8tRYRXC1jYZUidOSu0ROzNm6xEepoGgo8hl6thg
         eZ1g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=2SY0TCyX0d4BuF/HPv+siMhswvjAmIedZMktaAD9ovU=;
        b=hQ/w6OCjG8q+cZrN8Vy/apsDvFBvVqiu7UorFSt8G6v/cv86uWu58o0Kex55RsuBLS
         aQYgm82JtvrOmnkH/ffoQwUFulehwBQX0BtPWHCxtQ4GtYoBDAQR7zmJBgKXDX0GBdUs
         01QtsPwCIRLSOXHkOiUgzHFGFze4znKWHevZsBcYy/JGr5eHOvg9wXuLGVEgqq0oecmp
         oP3w/c2zLZEXu/S0iJp5n+agpCLgZosDDbgYO2JNGTlXyZIWzjn5hfE1lZATatSRSSWi
         ZlhsFUiL+wVe8hszijlHqsuf/rfeDxqBcR97kIPLkAb/0Q1/eu4GVHRq7J2al/CSzk+m
         XiEA==
X-Gm-Message-State: AOAM5302bU6pMg3akOGTKEsYzEwCZ5lXDjOwYqmuG6jBPMyPIISF9yrG
        zxaLjq4H5TmwohLTUJUpZDZ5BzQLUMSx8g==
X-Google-Smtp-Source: ABdhPJwGbi8LLGy8LLTlbNJxGlQ3lktPv9icFHs9LJ4Kjya9Z5ESb+kfsvfPba1fbGy1DShHuOJP0w==
X-Received: by 2002:a5d:4983:: with SMTP id r3mr26391wrq.184.1625150832202;
        Thu, 01 Jul 2021 07:47:12 -0700 (PDT)
Received: from linux.local (host-80-181-152-252.pool80181.interbusiness.it. [80.181.152.252])
        by smtp.gmail.com with ESMTPSA id y8sm18587wrr.76.2021.07.01.07.47.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 01 Jul 2021 07:47:11 -0700 (PDT)
From:   "Fabio M. De Francesco" <fmdefrancesco@gmail.com>
To:     Larry Finger <Larry.Finger@lwfinger.net>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org
Cc:     "Fabio M. De Francesco" <fmdefrancesco@gmail.com>
Subject: [PATCH] staging: rtl8188eu: Remove an unused variable and some lines of code
Date:   Thu,  1 Jul 2021 16:47:07 +0200
Message-Id: <20210701144707.22820-1-fmdefrancesco@gmail.com>
X-Mailer: git-send-email 2.32.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Remove set but unused iw_operation_mode[]. Remove all the lines of 
code from the function rtw_wx_set_rate, except the "return 0;" line 
to not break userland code that somewhat uses this IOCTL.

Signed-off-by: Fabio M. De Francesco <fmdefrancesco@gmail.com>
---
 .../staging/rtl8188eu/os_dep/ioctl_linux.c    | 72 -------------------
 1 file changed, 72 deletions(-)

diff --git a/drivers/staging/rtl8188eu/os_dep/ioctl_linux.c b/drivers/staging/rtl8188eu/os_dep/ioctl_linux.c
index b958a8d882b0..a66d8838c034 100644
--- a/drivers/staging/rtl8188eu/os_dep/ioctl_linux.c
+++ b/drivers/staging/rtl8188eu/os_dep/ioctl_linux.c
@@ -46,11 +46,6 @@ static u32 rtw_rates[] = {1000000, 2000000, 5500000, 11000000,
 	6000000, 9000000, 12000000, 18000000, 24000000, 36000000,
 	48000000, 54000000};
 
-static const char * const iw_operation_mode[] = {
-	"Auto", "Ad-Hoc", "Managed",  "Master", "Repeater",
-	"Secondary", "Monitor"
-};
-
 void indicate_wx_scan_complete_event(struct adapter *padapter)
 {
 	union iwreq_data wrqu;
@@ -1266,73 +1261,6 @@ static int rtw_wx_set_rate(struct net_device *dev,
 			   struct iw_request_info *a,
 			   union iwreq_data *wrqu, char *extra)
 {
-	int i;
-	u8 datarates[NumRates];
-	u32	target_rate = wrqu->bitrate.value;
-	u32	fixed = wrqu->bitrate.fixed;
-	u32	ratevalue = 0;
-	u8 mpdatarate[NumRates] = {11, 10, 9, 8, 7, 6, 5, 4, 3, 2, 1, 0, 0xff};
-
-	if (target_rate == -1) {
-		ratevalue = 11;
-		goto set_rate;
-	}
-	target_rate /= 100000;
-
-	switch (target_rate) {
-	case 10:
-		ratevalue = 0;
-		break;
-	case 20:
-		ratevalue = 1;
-		break;
-	case 55:
-		ratevalue = 2;
-		break;
-	case 60:
-		ratevalue = 3;
-		break;
-	case 90:
-		ratevalue = 4;
-		break;
-	case 110:
-		ratevalue = 5;
-		break;
-	case 120:
-		ratevalue = 6;
-		break;
-	case 180:
-		ratevalue = 7;
-		break;
-	case 240:
-		ratevalue = 8;
-		break;
-	case 360:
-		ratevalue = 9;
-		break;
-	case 480:
-		ratevalue = 10;
-		break;
-	case 540:
-		ratevalue = 11;
-		break;
-	default:
-		ratevalue = 11;
-		break;
-	}
-
-set_rate:
-
-	for (i = 0; i < NumRates; i++) {
-		if (ratevalue == mpdatarate[i]) {
-			datarates[i] = mpdatarate[i];
-			if (fixed == 0)
-				break;
-		} else {
-			datarates[i] = 0xff;
-		}
-	}
-
 	return 0;
 }
 
-- 
2.32.0

