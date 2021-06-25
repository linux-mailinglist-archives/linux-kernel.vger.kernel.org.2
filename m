Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2EC583B492E
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Jun 2021 21:17:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229774AbhFYTT0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 25 Jun 2021 15:19:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37202 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229531AbhFYTTZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 Jun 2021 15:19:25 -0400
Received: from mail-qv1-xf2f.google.com (mail-qv1-xf2f.google.com [IPv6:2607:f8b0:4864:20::f2f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0D26EC061574
        for <linux-kernel@vger.kernel.org>; Fri, 25 Jun 2021 12:17:04 -0700 (PDT)
Received: by mail-qv1-xf2f.google.com with SMTP id fq1so5266245qvb.1
        for <linux-kernel@vger.kernel.org>; Fri, 25 Jun 2021 12:17:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=philpotter-co-uk.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=tjRJr+e18S6nikGnuoS3L8XMimjCLVhD37WeToZEo9Y=;
        b=03aTi0PFKc0Prlcrtf7XgUk/8cP0a5fdNM3jqPHAET4pSpH2q3WSunAQTScKepcy51
         qSxkoB/sfhiiOoSUA4dgXP5uMxJPxylUkCw8TbtBs4bKmUNSsKQku+Wjqm6PkFuhw1LB
         mloxdPn+tPwHAIPdsylmpyNZXGECz43XgB+JtmqfKeF56TQer/gcA7QSX4S2yvjkzrPM
         toj3kDI/PNFd2qKzx97ooPSobdhb6WouxIM5MZnAleKzNIx1a4jNxRetqdXoplDdECAo
         V0hZPNkXgN1zXpJ08mQw0sjuniBZWGwESg99US6/akweD9JjkQigl1uZH/gR3uxyy9lc
         oEsw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=tjRJr+e18S6nikGnuoS3L8XMimjCLVhD37WeToZEo9Y=;
        b=Bd8OFRT3rWUoG8TeWNcIdw5Rn3uoA7q7f1xn/fZppBTTw+4DTcbiEYiGziGfxu0Ztq
         +1qkPAkI7llRKYIah4GdVdlFCfTIyfQnVRaRBGSrXaGhwoCEvXeiqvqvu/DOL29x2Uym
         +FBtO4vzO0lgE8qsV7gPMaQ/2egsU8zxhB5o3jGm1OLC1IooQ5wwi4kWp+AsNrDQY5fC
         x38kEFXx8LJcsGkjH9KTRZHc8GN5neVYlrzh/HBwV2uwW6ZKR50+8JS/mMbKb63p5XB/
         4EuSn4c+6hjW3iUfjI5XbfvDIpccYBxRSAqGWzfI01NwKJA1qYM2k8CAxa7dxEoIOC9Z
         S3QQ==
X-Gm-Message-State: AOAM530E0nlxAE6IY/q4Cqur0BoDTSlRJVlbsDZQmxgGve8DZOuzPugo
        bB1I7hAZ6ZOVIpHUfN+JPMXJVw==
X-Google-Smtp-Source: ABdhPJzdngKbtkYLE1qQ9oCYAiAZfdjlHeHYU71eVFro4uQIuUY/CVSCQvRKrqrG77G8aqigBhXLVg==
X-Received: by 2002:a0c:ba05:: with SMTP id w5mr12968041qvf.60.1624648623121;
        Fri, 25 Jun 2021 12:17:03 -0700 (PDT)
Received: from kerneldevvm.. (5.6.a.8.a.a.b.f.c.9.4.c.a.9.a.a.0.a.1.e.e.d.f.d.0.b.8.0.1.0.0.2.ip6.arpa. [2001:8b0:dfde:e1a0:aa9a:c49c:fbaa:8a65])
        by smtp.gmail.com with ESMTPSA id 126sm5777917qkd.115.2021.06.25.12.17.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 25 Jun 2021 12:17:02 -0700 (PDT)
From:   Phillip Potter <phil@philpotter.co.uk>
To:     gregkh@linuxfoundation.org
Cc:     Larry.Finger@lwfinger.net, dan.carpenter@oracle.com,
        linux-kernel@vger.kernel.org, linux-staging@lists.linux.dev
Subject: [PATCH] staging: rtl8188eu: remove rtw_wx_set_rate handler function
Date:   Fri, 25 Jun 2021 20:16:58 +0100
Message-Id: <20210625191658.1299-1-phil@philpotter.co.uk>
X-Mailer: git-send-email 2.31.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Remove rtw_wx_set_rate handler function, which currently handles the
SIOCSIWRATE wext ioctl. This function (although containing a lot of
code) set nothing outside its own local variables, and did nothing other
than call a now removed debugging statement repeatedly. Removing it and
leaving its associated entry in rtw_handlers as NULL is therefore the
better option. Removing this function also fixes a kernel test robot
warning.

Reported-by: kernel test robot <lkp@intel.com>
Signed-off-by: Phillip Potter <phil@philpotter.co.uk>
---
 .../staging/rtl8188eu/os_dep/ioctl_linux.c    | 75 -------------------
 1 file changed, 75 deletions(-)

diff --git a/drivers/staging/rtl8188eu/os_dep/ioctl_linux.c b/drivers/staging/rtl8188eu/os_dep/ioctl_linux.c
index b958a8d882b0..d4dce8ef0322 100644
--- a/drivers/staging/rtl8188eu/os_dep/ioctl_linux.c
+++ b/drivers/staging/rtl8188eu/os_dep/ioctl_linux.c
@@ -1262,80 +1262,6 @@ static int rtw_wx_get_essid(struct net_device *dev,
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
@@ -2715,7 +2641,6 @@ static iw_handler rtw_handlers[] = {
 	IW_HANDLER(SIOCSIWESSID, rtw_wx_set_essid),
 	IW_HANDLER(SIOCGIWESSID, rtw_wx_get_essid),
 	IW_HANDLER(SIOCGIWNICKN, rtw_wx_get_nick),
-	IW_HANDLER(SIOCSIWRATE, rtw_wx_set_rate),
 	IW_HANDLER(SIOCGIWRATE, rtw_wx_get_rate),
 	IW_HANDLER(SIOCSIWRTS, rtw_wx_set_rts),
 	IW_HANDLER(SIOCGIWRTS, rtw_wx_get_rts),
-- 
2.31.1

