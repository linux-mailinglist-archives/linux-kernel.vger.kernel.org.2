Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 07B1135AE2C
	for <lists+linux-kernel@lfdr.de>; Sat, 10 Apr 2021 16:22:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235089AbhDJOWF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 10 Apr 2021 10:22:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54740 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234941AbhDJOVV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 10 Apr 2021 10:21:21 -0400
Received: from mail-ej1-x62d.google.com (mail-ej1-x62d.google.com [IPv6:2a00:1450:4864:20::62d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D8234C061343
        for <linux-kernel@vger.kernel.org>; Sat, 10 Apr 2021 07:21:05 -0700 (PDT)
Received: by mail-ej1-x62d.google.com with SMTP id r12so13058202ejr.5
        for <linux-kernel@vger.kernel.org>; Sat, 10 Apr 2021 07:21:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=bIfCpRzZUpXirgKl1gCFnYnBbKjxAWQCu96s2HjUGIE=;
        b=N+XvGNzm8M9loYIWss15cm9NCPztCfXaLnmIErKUXufJyWPfh75M0LEv/vnLhqeQaN
         G/0xcyhSmdsb+vgk0etpL4ro53iaZzub1M7RbQuwwKK//REHgLAQCFwTHko9pWR3C/Qk
         VUogp7qW4homD6likv242aiATMkFjG2ySSJKqoZ0F8mQilnuWQdtyD+1bmfl1X9nw87g
         G/ABHiNLxIih9W2ngFl74128DWetEN3nc1u6duKwoOtYEHbGA5Dg0E/BB00gVMCaIVBH
         0j9ysAOfYAsXVSncZDM7a3DHHfoFNpR/aFSEN6E94w1UOxBKcM+8biAc8H7kPThopaFM
         oFqA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=bIfCpRzZUpXirgKl1gCFnYnBbKjxAWQCu96s2HjUGIE=;
        b=K3OK4R28rxjq+YiHDmV9OS1twhc9Kg2EeDqj3vtjnqWSsD3tF9i/P7K07jGckTdFz5
         W+ZIo0eRxq5Pp7z4ygoN5OhAfkzuoapPdo52A7L+GORjzYbIh169zqtqVs3ab02X4D9V
         ULcu2qUjnRxrh/lKHkmWQ3k0wjvwxtFanARC2CZU07/3ys1V4dS3h3+U+A8xqbxV5+L3
         u5TkwcsaK6cd7rNYuiuZHy5Cq2JF18RmhwMEyYAmPVcXLedwXPOLMwnbxHSzNbApL+5y
         WPM+dn+QolBoVt3Y56cJS/pYQRZLm0tWpCcqufDOk9t/W8ksTaCyTLa6fQMk0ca7V31+
         TYtQ==
X-Gm-Message-State: AOAM533bP2rN7T7BkoWdliDGd69HvV++TBPiaW0V22jngLuXGP6QHlbt
        frq7lCZM6/YewKht11JHdqvDfx+Z3UhlpA==
X-Google-Smtp-Source: ABdhPJxO82dvZHLf2ql9dCjZxCFbN+2l1MNQdLpOnmy7Lwg54GlCS3geTiRO1/YdKZo4MHFWUBudRQ==
X-Received: by 2002:a17:906:489b:: with SMTP id v27mr20226261ejq.1.1618064464334;
        Sat, 10 Apr 2021 07:21:04 -0700 (PDT)
Received: from agape ([5.171.81.28])
        by smtp.gmail.com with ESMTPSA id c19sm3205259edu.20.2021.04.10.07.21.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 10 Apr 2021 07:21:04 -0700 (PDT)
From:   Fabio Aiuto <fabioaiuto83@gmail.com>
To:     gregkh@linuxfoundation.org
Cc:     linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: [PATCH 15/25] staging: rtl8723bs: fix comparison to null
Date:   Sat, 10 Apr 2021 16:20:28 +0200
Message-Id: <2c7557a465aeda7fb6989df30c6250f9ec56ebe1.1618064274.git.fabioaiuto83@gmail.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <cover.1618064274.git.fabioaiuto83@gmail.com>
References: <cover.1618064274.git.fabioaiuto83@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

fix following post-commit hook checkpatch issues:

CHECK: Comparison to NULL could be written "!pmlmepriv->wps_probe_req_ie"
348: FILE: drivers/staging/rtl8723bs/os_dep/ioctl_cfg80211.c:1319:
+			if (pmlmepriv->wps_probe_req_ie == NULL)

CHECK: Comparison to NULL could be written "!dvobj"
459: FILE: drivers/staging/rtl8723bs/os_dep/sdio_intf.c:184:
+	if (dvobj == NULL)

CHECK: Comparison to NULL could be written "!padapter"
470: FILE: drivers/staging/rtl8723bs/os_dep/sdio_intf.c:231:
+	if (padapter == NULL)

CHECK: Comparison to NULL could be written "!padapter"
481: FILE: drivers/staging/rtl8723bs/os_dep/sdio_intf.c:240:
+	if (padapter == NULL)

CHECK: Comparison to NULL could be written "!padapter"
492: FILE: drivers/staging/rtl8723bs/os_dep/sdio_intf.c:256:
+	if (padapter == NULL)

Signed-off-by: Fabio Aiuto <fabioaiuto83@gmail.com>
---
 drivers/staging/rtl8723bs/os_dep/ioctl_cfg80211.c | 2 +-
 drivers/staging/rtl8723bs/os_dep/sdio_intf.c      | 8 ++++----
 2 files changed, 5 insertions(+), 5 deletions(-)

diff --git a/drivers/staging/rtl8723bs/os_dep/ioctl_cfg80211.c b/drivers/staging/rtl8723bs/os_dep/ioctl_cfg80211.c
index c85fd9e9e394..601a16074ee3 100644
--- a/drivers/staging/rtl8723bs/os_dep/ioctl_cfg80211.c
+++ b/drivers/staging/rtl8723bs/os_dep/ioctl_cfg80211.c
@@ -1316,7 +1316,7 @@ static int rtw_cfg80211_set_probe_req_wpsp2pie(struct adapter *padapter, char *b
 			}
 
 			pmlmepriv->wps_probe_req_ie = rtw_malloc(wps_ielen);
-			if (pmlmepriv->wps_probe_req_ie == NULL)
+			if (!pmlmepriv->wps_probe_req_ie)
 				return -EINVAL;
 
 			memcpy(pmlmepriv->wps_probe_req_ie, wps_ie, wps_ielen);
diff --git a/drivers/staging/rtl8723bs/os_dep/sdio_intf.c b/drivers/staging/rtl8723bs/os_dep/sdio_intf.c
index 34c5eff02b2f..a8ef95ab14da 100644
--- a/drivers/staging/rtl8723bs/os_dep/sdio_intf.c
+++ b/drivers/staging/rtl8723bs/os_dep/sdio_intf.c
@@ -181,7 +181,7 @@ static struct dvobj_priv *sdio_dvobj_init(struct sdio_func *func)
 	struct sdio_data *psdio;
 
 	dvobj = devobj_init();
-	if (dvobj == NULL)
+	if (!dvobj)
 		goto exit;
 
 	sdio_set_drvdata(func, dvobj);
@@ -228,7 +228,7 @@ void rtw_set_hal_ops(struct adapter *padapter)
 
 static void sd_intf_start(struct adapter *padapter)
 {
-	if (padapter == NULL)
+	if (!padapter)
 		return;
 
 	/*  hal dep */
@@ -237,7 +237,7 @@ static void sd_intf_start(struct adapter *padapter)
 
 static void sd_intf_stop(struct adapter *padapter)
 {
-	if (padapter == NULL)
+	if (!padapter)
 		return;
 
 	/*  hal dep */
@@ -253,7 +253,7 @@ static struct adapter *rtw_sdio_if1_init(struct dvobj_priv *dvobj, const struct
 	struct sdio_data *psdio = &dvobj->intf_data;
 
 	padapter = vzalloc(sizeof(*padapter));
-	if (padapter == NULL)
+	if (!padapter)
 		goto exit;
 
 	padapter->dvobj = dvobj;
-- 
2.20.1

