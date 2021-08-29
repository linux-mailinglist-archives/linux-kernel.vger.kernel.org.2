Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AE72A3FAA3A
	for <lists+linux-kernel@lfdr.de>; Sun, 29 Aug 2021 11:01:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234867AbhH2JCQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 29 Aug 2021 05:02:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47660 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234584AbhH2JCP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 29 Aug 2021 05:02:15 -0400
Received: from mail-pj1-x1036.google.com (mail-pj1-x1036.google.com [IPv6:2607:f8b0:4864:20::1036])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F0791C061575
        for <linux-kernel@vger.kernel.org>; Sun, 29 Aug 2021 02:01:23 -0700 (PDT)
Received: by mail-pj1-x1036.google.com with SMTP id f11-20020a17090aa78b00b0018e98a7cddaso7907549pjq.4
        for <linux-kernel@vger.kernel.org>; Sun, 29 Aug 2021 02:01:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:mime-version:content-disposition;
        bh=4UhAzAPVc+icCp7Y2EezPOc71pObAloaN9xXjYM1qls=;
        b=MdjTjxH8zJRW8uWJWPTAZK1RSHyGcYMLiQabXQY/zKTEAt9ixk8Qiovp+36Zabc2Qm
         2UiOf5rnkOGqf1qd5LPLm+9vhcLRJUOn7z2Q+yMyuPDdqQPYXqEs5+JWGBcWvD0NMr/o
         BQ2hPynd0ivspYkVbnGqOBk6feCtleyN5N8J/3O2tX6TjxEkWCZ22Ppiin8JaJ2YoK5u
         VW/CHpEp1ImTl5kTTJhHpW+S6a1LNG/xVIbn4UUeTnq845S5K75Yhaf8/E5IJ/1aqiXF
         doGnbgADJf1bZWTCAVPBExMWDnyrv5aTt4zY0UxRho8PO9y4UlbBQNNiomHEM7486E1K
         az1g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:mime-version
         :content-disposition;
        bh=4UhAzAPVc+icCp7Y2EezPOc71pObAloaN9xXjYM1qls=;
        b=JfKCDld4nVn43Xhn/PWmvzOuzZbiQGFrDEq+YmZbt3cfpScKTDWcFuBTHcj/gbYYVG
         fVUTw/ASJ6liaxBBbdFfisGLwb3U+R/NCPT/WGWK6eiNLBGWTts9QAhu4RtvNLs5cvRP
         3BJhOJpO4HRup9iaOkhBDDqN277/mCtuwp+q82SS8W/RabbiLEommpimxiB6WV+bxo3T
         VxZkocw1ZhwlNYKOtlD2flmtpBx6BGGoCds/sdwWVoPURaN/pbNDVEJ8oDIDFq0M5HeO
         iWWHypxxYKGVhWqnDQ7CeATDslPIy1iDSh+KNxRHUJxcqXp/UmuRaci07EzswlYR5vkD
         UtJQ==
X-Gm-Message-State: AOAM530Nm4dPIrKrnAVvHv+Q0mm4WaeJ2IfRUqQ+6EBQYejvB/In/Z84
        vH1oCk4Y+Hw2EUx55F8Byb8=
X-Google-Smtp-Source: ABdhPJyhVNmjEHSADuxEbsj5bOgEqE9c1xAjyTeT0qaF9+UN0Qzyo3McstdapWEB8c48mI54qsgyEw==
X-Received: by 2002:a17:90a:1b07:: with SMTP id q7mr20143146pjq.100.1630227683234;
        Sun, 29 Aug 2021 02:01:23 -0700 (PDT)
Received: from user ([117.98.200.228])
        by smtp.gmail.com with ESMTPSA id 130sm909293pfy.175.2021.08.29.02.01.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 29 Aug 2021 02:01:22 -0700 (PDT)
Date:   Sun, 29 Aug 2021 14:31:15 +0530
From:   Saurav Girepunje <saurav.girepunje@gmail.com>
To:     Larry.Finger@lwfinger.net, phil@philpotter.co.uk,
        gregkh@linuxfoundation.org, straube.linux@gmail.com,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org
Cc:     saurav.girepunje@hotmail.com
Subject: [PATCH] staging: r8188eu: core: remove condition with no effect
Message-ID: <YStM2wxtkDAnRemt@user>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Remove the condition with no effect (if == else) and group multiple
cases which execute same statement in rtw_mlme_ext.c

Signed-off-by: Saurav Girepunje <saurav.girepunje@gmail.com>
---
 drivers/staging/r8188eu/core/rtw_mlme_ext.c | 9 ---------
 1 file changed, 9 deletions(-)

diff --git a/drivers/staging/r8188eu/core/rtw_mlme_ext.c b/drivers/staging/r8188eu/core/rtw_mlme_ext.c
index 5a472a4954b0..4178b3c1ff57 100644
--- a/drivers/staging/r8188eu/core/rtw_mlme_ext.c
+++ b/drivers/staging/r8188eu/core/rtw_mlme_ext.c
@@ -453,17 +453,8 @@ void mgt_dispatcher(struct adapter *padapter, struct recv_frame *precv_frame)
 		fallthrough;
 	case WIFI_ASSOCREQ:
 	case WIFI_REASSOCREQ:
-		_mgt_dispatcher(padapter, ptable, precv_frame);
-		break;
 	case WIFI_PROBEREQ:
-		if (check_fwstate(pmlmepriv, WIFI_AP_STATE))
-			_mgt_dispatcher(padapter, ptable, precv_frame);
-		else
-			_mgt_dispatcher(padapter, ptable, precv_frame);
-		break;
 	case WIFI_BEACON:
-		_mgt_dispatcher(padapter, ptable, precv_frame);
-		break;
 	case WIFI_ACTION:
 		_mgt_dispatcher(padapter, ptable, precv_frame);
 		break;
--
2.32.0

