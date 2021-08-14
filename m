Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D42693EC3BC
	for <lists+linux-kernel@lfdr.de>; Sat, 14 Aug 2021 18:08:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235440AbhHNQJR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 14 Aug 2021 12:09:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42062 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237816AbhHNQJC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 14 Aug 2021 12:09:02 -0400
Received: from mail-ej1-x62a.google.com (mail-ej1-x62a.google.com [IPv6:2a00:1450:4864:20::62a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 45A6FC061292
        for <linux-kernel@vger.kernel.org>; Sat, 14 Aug 2021 09:08:09 -0700 (PDT)
Received: by mail-ej1-x62a.google.com with SMTP id gt38so2804195ejc.13
        for <linux-kernel@vger.kernel.org>; Sat, 14 Aug 2021 09:08:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=jatPwNH/0Yq3VWyyUNES2xrcQ7Q23B3cMA7m1PqwGKw=;
        b=OdKuCFCAl6xHd2V3Meq15Cmuu9u2rXQxGX4WhZCEGmIbSMEoKi81LxSuUYjYoJFxFl
         4kfdFyUTa/XJ6chxidNojWYuiVnZwlspbvZg6yykn/TZ1R+FyAu7LccHKpCbb9ENgo3o
         15DlWBeHyc5iLXZH2DcFgqQVRgGvSKMN4LPd1axcb+Gd1YAygGGKA5SHLplDbW8Hl3aN
         6fps0HKb3MY/Wu+/qHZ6v77u4DcaR+InRlUwPfyq2ceAezyG/d1p6HOmffm81ftU3sCc
         5GKrcdUM8ffIhwshL0zY1PfH6P6amYKQe4rwDEgSddGTVick1Y+GKf2wfb6g5G4F4O35
         iaKw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=jatPwNH/0Yq3VWyyUNES2xrcQ7Q23B3cMA7m1PqwGKw=;
        b=Tu5zYkqOqvHwlPpKQtaFpULOFu9mVo+c87fquGb33RruWf50D1M82CHaUt5lgSeU7d
         t5ctsCf8skjc5e4Sov6OZXsQUiU5mAdTvM5I/wzqoGXYj1c8fpF5fsi22Cpi6fyJWzqE
         9aihUWX2WeUEMcW030cRpURNCuDc1E0Vp6AKX3uO1Thkn2IkflAUgfWFM+vcOyC1IMm/
         4Rn/K7+640KMiuU68wx0hPHWGy81jiwVeG15RCGni52IUiPZqzxOj/BTax5ueSMWQUVY
         d6bkpuMnBvcPJxKO4Tjzt5a8JqJRoa0iEGg8xXFkWuGCUnpwfnD0wY63X8LyKcScw8zH
         YyOA==
X-Gm-Message-State: AOAM530oXPzbQZ7X55jjLGdSif/SN2xhbKnP56FknCPwDG6xHjIcnkIh
        HK3+uarhpN4Ml+v4crrcoUo=
X-Google-Smtp-Source: ABdhPJwwRzJ2CiNCExpL2HqPhfUqDxiYmB1WUbm1hlRrm/mLnGIQQoiVVbCBzjZyLirPJmOHh2YF5A==
X-Received: by 2002:a17:907:265b:: with SMTP id ar27mr8183248ejc.300.1628957287877;
        Sat, 14 Aug 2021 09:08:07 -0700 (PDT)
Received: from localhost.localdomain (host-79-22-109-211.retail.telecomitalia.it. [79.22.109.211])
        by smtp.gmail.com with ESMTPSA id 8sm1893759ejz.88.2021.08.14.09.08.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 14 Aug 2021 09:08:07 -0700 (PDT)
From:   "Fabio M. De Francesco" <fmdefrancesco@gmail.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Larry Finger <Larry.Finger@lwfinger.net>,
        Phillip Potter <phil@philpotter.co.uk>,
        Martin Kaiser <martin@kaiser.cx>,
        Michael Straube <straube.linux@gmail.com>,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org
Cc:     "Fabio M. De Francesco" <fmdefrancesco@gmail.com>
Subject: [PATCH] staging: r8188eu: os_dep: Remove defined but not used variables
Date:   Sat, 14 Aug 2021 18:08:04 +0200
Message-Id: <20210814160804.11634-1-fmdefrancesco@gmail.com>
X-Mailer: git-send-email 2.32.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Remove defined but not used const variables. Issues detected by GCC
running with -Wunused-const-variable option enabled.

Signed-off-by: Fabio M. De Francesco <fmdefrancesco@gmail.com>
---
 drivers/staging/r8188eu/os_dep/ioctl_linux.c | 21 --------------------
 1 file changed, 21 deletions(-)

diff --git a/drivers/staging/r8188eu/os_dep/ioctl_linux.c b/drivers/staging/r8188eu/os_dep/ioctl_linux.c
index 38ee41f9d2ba..d9fdd83218dc 100644
--- a/drivers/staging/r8188eu/os_dep/ioctl_linux.c
+++ b/drivers/staging/r8188eu/os_dep/ioctl_linux.c
@@ -84,11 +84,6 @@ static u32 rtw_rates[] = {1000000, 2000000, 5500000, 11000000,
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
@@ -6666,19 +6661,3 @@ struct iw_handler_def rtw_handlers_def = {
 	.num_private_args = sizeof(rtw_private_args) / sizeof(struct iw_priv_args),
 	.get_wireless_stats = rtw_get_wireless_stats,
 };
-
-/*  copy from net/wireless/wext.c start */
-/* ---------------------------------------------------------------- */
-/*
- * Calculate size of private arguments
- */
-static const char iw_priv_type_size[] = {
-	0,			      /* IW_PRIV_TYPE_NONE */
-	1,			      /* IW_PRIV_TYPE_BYTE */
-	1,			      /* IW_PRIV_TYPE_CHAR */
-	0,			      /* Not defined */
-	sizeof(__u32),		  /* IW_PRIV_TYPE_INT */
-	sizeof(struct iw_freq),	 /* IW_PRIV_TYPE_FLOAT */
-	sizeof(struct sockaddr),	/* IW_PRIV_TYPE_ADDR */
-	0,			      /* Not defined */
-};
-- 
2.32.0

