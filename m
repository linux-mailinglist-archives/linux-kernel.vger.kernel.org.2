Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A178E3BBD9E
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Jul 2021 15:42:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231215AbhGENof (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 5 Jul 2021 09:44:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42270 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230414AbhGENoe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Jul 2021 09:44:34 -0400
Received: from mail-ej1-x632.google.com (mail-ej1-x632.google.com [IPv6:2a00:1450:4864:20::632])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6BC1BC061574
        for <linux-kernel@vger.kernel.org>; Mon,  5 Jul 2021 06:41:57 -0700 (PDT)
Received: by mail-ej1-x632.google.com with SMTP id hr1so25717522ejc.1
        for <linux-kernel@vger.kernel.org>; Mon, 05 Jul 2021 06:41:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=9JHSRbS7NzwHOfcGTHTpIoJzU8cGwqoybTQ0iNhpmp8=;
        b=V00TjrjEPngzpp26pcn5bMd8IyM2kRvIpqIyvPL4/YXEIofYPCqaD1gdzSEA/6VjJw
         norapAyVzg6NV0t7kmFhOfmWwO4aPd94feeqG6PvZ3NDFC3sSQwX2ai0PV1N0kvAcbHL
         QjarAg79J2Sek5cPRI1OeBAYohaBocNWdBB4Y9YgtNBUAx9dN/+R4v1wxBy+rgxnz5sb
         ZFd7ZbZuOtf+qCWrglEEmSz9PM/d7G7+LzIIW5IXj72c9J6DZEbWGtWf76NmC4Ygjx1L
         6uYBiGD+TlzDwk0C7nRdkt6y3HDOGcHVZH48fvtqvsSBu8xhlYtNPKHNyDdwQ7zM9Bpy
         Oniw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=9JHSRbS7NzwHOfcGTHTpIoJzU8cGwqoybTQ0iNhpmp8=;
        b=XzhGMn0jgBDFkMpdi06FoUMOV4S4Ehk7KHjFWA1NR3oPz66L6YTY2CpIUwLUptPa0D
         63I7jZ8JLFg7S+BEl+VCSD8/Ksk6jsvt7VQqK9dgEabrqJqGLr56X/4sGxRJBpN4G+jz
         N0ux4/52fG161lfjJzMudfEbIJbPhOnDkv6Z0w/W9hbpop22ius6h2criTwaaIaIuS6+
         1sdp6EdJuTARgPZbFRfiG5EZefXGwlKNW6e4IyxUI5amwJzhC7rl0URM8Wb7RAGbxm7o
         LjC75saAXLx331HfY1kqkIskrtombf8/cboGMwAsEDqSsKg/7eJ3MbkqzHXjxMxbY9fT
         aYuQ==
X-Gm-Message-State: AOAM532sIzRhV7vicVgmtNYVpQEjLpJdQM3KDRBJ4DOaHQZMS3TEHgHJ
        Zskf3IYEDkSj+BMe4+wwLhA=
X-Google-Smtp-Source: ABdhPJy7HtDdoNPcI9gmDtyg+rKd2ud+Mw/9PYbnSCPNP9O+2wdbCZjJMD1SBlmsWz0UW3Gm85ybng==
X-Received: by 2002:a17:906:2bdb:: with SMTP id n27mr13478817ejg.312.1625492516004;
        Mon, 05 Jul 2021 06:41:56 -0700 (PDT)
Received: from linux.local (host-80-181-152-252.retail.telecomitalia.it. [80.181.152.252])
        by smtp.gmail.com with ESMTPSA id u4sm4369663eje.81.2021.07.05.06.41.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 05 Jul 2021 06:41:55 -0700 (PDT)
From:   "Fabio M. De Francesco" <fmdefrancesco@gmail.com>
To:     Larry Finger <Larry.Finger@lwfinger.net>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Dan Carpenter <dan.carpenter@oracle.com>,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org
Cc:     "Fabio M. De Francesco" <fmdefrancesco@gmail.com>
Subject: [PATCH v2] staging: rtl8188eu: Remove an unused variable and some lines of code
Date:   Mon,  5 Jul 2021 15:41:51 +0200
Message-Id: <20210705134151.15143-1-fmdefrancesco@gmail.com>
X-Mailer: git-send-email 2.32.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Remove set but unused iw_operation_mode[]. This driver doesn't support
SIOCSIWRATE.  It just returns zero and does nothing.  Change it to
return -ENOTSUPP instead.  (This is an API change but we don't expect it
to break anything).

Suggested-by: Dan Carpenter <dan.carpenter@oracle.com>
Signed-off-by: Fabio M. De Francesco <fmdefrancesco@gmail.com>
---

v1->v2: Delete rtw_wx_set_rate() and its association with command
SIOCSIWRATE as suggested by Dan Carpenter <dan.carpenter@oracle.com>

 .../staging/rtl8188eu/os_dep/ioctl_linux.c    | 80 -------------------
 1 file changed, 80 deletions(-)

diff --git a/drivers/staging/rtl8188eu/os_dep/ioctl_linux.c b/drivers/staging/rtl8188eu/os_dep/ioctl_linux.c
index b958a8d882b0..eef8ed71cdef 100644
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
@@ -1262,80 +1257,6 @@ static int rtw_wx_get_essid(struct net_device *dev,
 	return 0;
 }
 
-static int rtw_wx_set_rate(struct net_device *dev,
-			   struct iw_request_info *a,
-			   union iwreq_data *wrqu, char *extra)
-{
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
-	return 0;
-}
-
 static int rtw_wx_get_rate(struct net_device *dev,
 			   struct iw_request_info *info,
 			   union iwreq_data *wrqu, char *extra)
@@ -2715,7 +2636,6 @@ static iw_handler rtw_handlers[] = {
 	IW_HANDLER(SIOCSIWESSID, rtw_wx_set_essid),
 	IW_HANDLER(SIOCGIWESSID, rtw_wx_get_essid),
 	IW_HANDLER(SIOCGIWNICKN, rtw_wx_get_nick),
-	IW_HANDLER(SIOCSIWRATE, rtw_wx_set_rate),
 	IW_HANDLER(SIOCGIWRATE, rtw_wx_get_rate),
 	IW_HANDLER(SIOCSIWRTS, rtw_wx_set_rts),
 	IW_HANDLER(SIOCGIWRTS, rtw_wx_get_rts),
-- 
2.32.0

