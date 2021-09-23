Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1465D4165BD
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Sep 2021 21:10:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243117AbhIWTLs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 23 Sep 2021 15:11:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57114 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242936AbhIWTLZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Sep 2021 15:11:25 -0400
Received: from mail-wr1-x433.google.com (mail-wr1-x433.google.com [IPv6:2a00:1450:4864:20::433])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A81A6C061757
        for <linux-kernel@vger.kernel.org>; Thu, 23 Sep 2021 12:09:44 -0700 (PDT)
Received: by mail-wr1-x433.google.com with SMTP id t28so6738875wra.7
        for <linux-kernel@vger.kernel.org>; Thu, 23 Sep 2021 12:09:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=1uv2dsYgPSFxfYC8SVvYwtKMS1oJjlcp5nSjskXwXG4=;
        b=HLR1JErO0ogu5WTzZLESftN09bxuNEcXBKhTcM/7O3D3VZNwYdfenbFkil9kYzQbTH
         DOih5GoYxKLOTmUGE/OMqZJ1yaLdfbkHN7cWfaHvNYvE2MTyygTrkDZOQ/LdP8eU/VX4
         rd1lBz/7OHYuCRa/j8rpYk5IYsRJrQ80Gcs7vHPq6hYk4XnAYZW0Xaf9AIaWtujzHRxR
         FAIaobhEDzSKbnlMikb25NaXz6bzWUQVNB98CFfY8UfMqxeCoTvzH4db/FLObgxRN1ZP
         eKsu9RpweSDjMeAiBfQONhzGt8jLpvq3RjgT+i5YqUdsCzNM+KUYRNuabc7+v0b8pTKT
         JN7Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=1uv2dsYgPSFxfYC8SVvYwtKMS1oJjlcp5nSjskXwXG4=;
        b=gQVEZK+aqzk40GZz8Dgto2fucCEGfg5gFydmNgVyUXYxe6tUhOhZR5Yrz7hEC7s9Yt
         eYoGUwHzTFRSRGWAnWOT4JqyGla7bGSHOWWRD/tl+1b1718kt46noPnpDVAWt+PMAtBG
         8Krdwhywuod7cHReb7eq1qkmPPUjqvHk8TgbxC96miBMMhYFPwQVloIAhD6dwBrrC/nx
         k79S9HFwnsWmVaNias8xX22uxcKcxgQFqKstAHzDqZokdvaLT3eq20O3UmTUVmCDtvMx
         ybJIHaSAhi8zdwzOg91aNIFARoB6pOEBtisIK6REdO7+ejPEFMkJXQDYEj3iaEWp3BE3
         MumA==
X-Gm-Message-State: AOAM5309lk6wSUZXPxnGmnNLl0kLvTAeK2I64z2PZi48YP8jxqSAfduG
        1jR7u3A4kiy26xslzHvnqc0=
X-Google-Smtp-Source: ABdhPJwhwzsSkTwDRlyktOHo26HZT5NtLpeybBo9v6yWI3fd+x/C94eENwwo8e/HvgsCbuwmJ5pruQ==
X-Received: by 2002:adf:ded1:: with SMTP id i17mr6969848wrn.83.1632424183270;
        Thu, 23 Sep 2021 12:09:43 -0700 (PDT)
Received: from localhost.localdomain ([2a02:8108:96c0:3b88::cad])
        by smtp.gmail.com with ESMTPSA id e28sm6323591wrc.10.2021.09.23.12.09.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 23 Sep 2021 12:09:42 -0700 (PDT)
From:   Michael Straube <straube.linux@gmail.com>
To:     gregkh@linuxfoundation.org
Cc:     Larry.Finger@lwfinger.net, phil@philpotter.co.uk,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org,
        Michael Straube <straube.linux@gmail.com>
Subject: [PATCH 17/17] staging: r8188eu: remove rtw_tdls_cmd()
Date:   Thu, 23 Sep 2021 21:09:20 +0200
Message-Id: <20210923190920.3580-18-straube.linux@gmail.com>
X-Mailer: git-send-email 2.33.0
In-Reply-To: <20210923190920.3580-1-straube.linux@gmail.com>
References: <20210923190920.3580-1-straube.linux@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Function rtw_tdls_cmd() is not used, remove it.

Signed-off-by: Michael Straube <straube.linux@gmail.com>
---
 drivers/staging/r8188eu/core/rtw_cmd.c    | 5 -----
 drivers/staging/r8188eu/include/rtw_cmd.h | 1 -
 2 files changed, 6 deletions(-)

diff --git a/drivers/staging/r8188eu/core/rtw_cmd.c b/drivers/staging/r8188eu/core/rtw_cmd.c
index 8173756fdeb8..e11aa5929180 100644
--- a/drivers/staging/r8188eu/core/rtw_cmd.c
+++ b/drivers/staging/r8188eu/core/rtw_cmd.c
@@ -902,11 +902,6 @@ u8 rtw_set_chplan_cmd(struct adapter *padapter, u8 chplan, u8 enqueue)
 	return res;
 }
 
-u8 rtw_tdls_cmd(struct adapter *padapter, u8 *addr, u8 option)
-{
-	return _SUCCESS;
-}
-
 static void traffic_status_watchdog(struct adapter *padapter)
 {
 	u8	bEnterPS;
diff --git a/drivers/staging/r8188eu/include/rtw_cmd.h b/drivers/staging/r8188eu/include/rtw_cmd.h
index 6ae0499cd81f..83fbb922db2c 100644
--- a/drivers/staging/r8188eu/include/rtw_cmd.h
+++ b/drivers/staging/r8188eu/include/rtw_cmd.h
@@ -773,7 +773,6 @@ u8 rtw_ps_cmd(struct adapter*padapter);
 u8 rtw_chk_hi_queue_cmd(struct adapter*padapter);
 
 u8 rtw_set_chplan_cmd(struct adapter*padapter, u8 chplan, u8 enqueue);
-u8 rtw_tdls_cmd(struct adapter *padapter, u8 *addr, u8 option);
 
 u8 rtw_c2h_wk_cmd(struct adapter *padapter, u8 *c2h_evt);
 
-- 
2.33.0

