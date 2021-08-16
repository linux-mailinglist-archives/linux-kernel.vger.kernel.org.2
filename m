Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 001C83EDA67
	for <lists+linux-kernel@lfdr.de>; Mon, 16 Aug 2021 18:00:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237804AbhHPQA3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 16 Aug 2021 12:00:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57698 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237414AbhHPQAL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Aug 2021 12:00:11 -0400
Received: from mail-wr1-x433.google.com (mail-wr1-x433.google.com [IPv6:2a00:1450:4864:20::433])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4D0E8C0613C1
        for <linux-kernel@vger.kernel.org>; Mon, 16 Aug 2021 08:59:39 -0700 (PDT)
Received: by mail-wr1-x433.google.com with SMTP id r7so24448151wrs.0
        for <linux-kernel@vger.kernel.org>; Mon, 16 Aug 2021 08:59:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=zCA4RJIVS3HgcT8SVYzD287f0WEZJj5O6hB/6/sNY30=;
        b=Bnj0DUq0KHeVqqmFYhu8aeuGbV6dXdfp0LknMUC0DXdWo0UwgE4fZPHljaeB1bO+Me
         4U3Helh4m+L3eVK+kvnW8gtarDH60qUM0TSAzFQW/Cj4xVX9LCEgNgD43Vjtp3jxNAPy
         aWQ8mZR2BcCpT4KXmARadLlzViud5h+uNGap30SpeE/dPPkySJr9NSUuc75Qt+rOnluO
         +sgashtWHXJ8RM9IEIojDk/otkhDb/+hI2qIzv8ZT4GXKjUaO47Al+TzWev6Xmkf27D4
         wMGDCgSQRtPUGypvDAvXrSK6GC8xhGO+/GDewHBE2NBcQ0arPQEcTM0WA2WFTaCNZTj2
         +0fQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=zCA4RJIVS3HgcT8SVYzD287f0WEZJj5O6hB/6/sNY30=;
        b=DCliDrvS76wt79Y5uwkDvRHuII3B4R97lD0ODvQilhcOMvz92m6ueS3oSmdByto+wE
         ksz6cRrCROk8HLhScAvUhG2FpM2Pzddc9pfpLaUgntwFT/+dgFQ18l5UbUVcDAulOeM4
         Cx5cEaFxC5LwBb91SiL69Hay6NSBN24XxXHU1d07i8KLupAGBVAN1zYYv6QJ5HWwNHNZ
         X5bw3mDoWo842NpddZtN09IIq+gdnw40UnuMb7l9T9wI8ipfffIJKT/uX8gY3PcchBYV
         efhwC7/Udts6jogxl/cKdKJIBRKDtjR8o7r/+NWjDRILlDZDZ8GNi4lOGyJOMJxXU2zV
         xaGg==
X-Gm-Message-State: AOAM531TRXrI3n0nqeN3VF8fT1YFlxiSAkWZyq49/z+L+f3TOs4LVw5N
        o+ahVDz7Y7vvxWikS556inM=
X-Google-Smtp-Source: ABdhPJzdbofmSuWriNUQ4T8xzwT7bsL9SCn9XEOrHV9kCbQB4gLKFL3Wmu+4HwORzA3V7hbY2xQfgQ==
X-Received: by 2002:a5d:6a0d:: with SMTP id m13mr19874670wru.33.1629129577993;
        Mon, 16 Aug 2021 08:59:37 -0700 (PDT)
Received: from localhost.localdomain ([2a02:8108:96c0:3b88::4058])
        by smtp.gmail.com with ESMTPSA id a77sm11589597wmd.31.2021.08.16.08.59.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 16 Aug 2021 08:59:37 -0700 (PDT)
From:   Michael Straube <straube.linux@gmail.com>
To:     gregkh@linuxfoundation.org
Cc:     Larry.Finger@lwfinger.net, phil@philpotter.co.uk, martin@kaiser.cx,
        fmdefrancesco@gmail.com, linux-staging@lists.linux.dev,
        linux-kernel@vger.kernel.org,
        Michael Straube <straube.linux@gmail.com>
Subject: [PATCH 15/23] staging: r8188eu: clean up spacing style issues in core/rtw_pwrctrl.c
Date:   Mon, 16 Aug 2021 17:58:10 +0200
Message-Id: <20210816155818.24005-16-straube.linux@gmail.com>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <20210816155818.24005-1-straube.linux@gmail.com>
References: <20210816155818.24005-1-straube.linux@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Clean up spacing style issues in core/rtw_pwrctrl.c reported by
checkpatch.

CHECK: spaces preferred around that ...
WARNING: space prohibited before semicolon

Signed-off-by: Michael Straube <straube.linux@gmail.com>
---
 drivers/staging/r8188eu/core/rtw_pwrctrl.c | 16 ++++++++--------
 1 file changed, 8 insertions(+), 8 deletions(-)

diff --git a/drivers/staging/r8188eu/core/rtw_pwrctrl.c b/drivers/staging/r8188eu/core/rtw_pwrctrl.c
index 9a00a316674b..34e4c3339b56 100644
--- a/drivers/staging/r8188eu/core/rtw_pwrctrl.c
+++ b/drivers/staging/r8188eu/core/rtw_pwrctrl.c
@@ -108,11 +108,11 @@ static bool rtw_pwr_unassociated_idle(struct adapter *adapter)
 	if (adapter->pwrctrlpriv.ips_deny_time >= jiffies)
 		goto exit;
 
-	if (check_fwstate(pmlmepriv, WIFI_ASOC_STATE|WIFI_SITE_MONITOR) ||
-	    check_fwstate(pmlmepriv, WIFI_UNDER_LINKING|WIFI_UNDER_WPS) ||
+	if (check_fwstate(pmlmepriv, WIFI_ASOC_STATE | WIFI_SITE_MONITOR) ||
+	    check_fwstate(pmlmepriv, WIFI_UNDER_LINKING | WIFI_UNDER_WPS) ||
 	    check_fwstate(pmlmepriv, WIFI_UNDER_WPS) ||
 	    check_fwstate(pmlmepriv, WIFI_AP_STATE) ||
-	    check_fwstate(pmlmepriv, WIFI_ADHOC_MASTER_STATE|WIFI_ADHOC_STATE) ||
+	    check_fwstate(pmlmepriv, WIFI_ADHOC_MASTER_STATE | WIFI_ADHOC_STATE) ||
 #if defined(CONFIG_88EU_P2P)
 	    !rtw_p2p_chk_state(pwdinfo, P2P_STATE_NONE))
 #else
@@ -127,10 +127,10 @@ static bool rtw_pwr_unassociated_idle(struct adapter *adapter)
 		struct wifidirect_info *b_pwdinfo = &buddy->wdinfo;
 		#endif
 
-		if (check_fwstate(b_pmlmepriv, WIFI_ASOC_STATE|WIFI_SITE_MONITOR) ||
-		    check_fwstate(b_pmlmepriv, WIFI_UNDER_LINKING|WIFI_UNDER_WPS) ||
+		if (check_fwstate(b_pmlmepriv, WIFI_ASOC_STATE | WIFI_SITE_MONITOR) ||
+		    check_fwstate(b_pmlmepriv, WIFI_UNDER_LINKING | WIFI_UNDER_WPS) ||
 		    check_fwstate(b_pmlmepriv, WIFI_AP_STATE) ||
-		    check_fwstate(b_pmlmepriv, WIFI_ADHOC_MASTER_STATE|WIFI_ADHOC_STATE) ||
+		    check_fwstate(b_pmlmepriv, WIFI_ADHOC_MASTER_STATE | WIFI_ADHOC_STATE) ||
 #if defined(CONFIG_88EU_P2P)
 		    !rtw_p2p_chk_state(b_pwdinfo, P2P_STATE_NONE))
 #else
@@ -180,7 +180,7 @@ void rtw_ps_processor(struct adapter *padapter)
 	if (!rtw_pwr_unassociated_idle(padapter))
 		goto exit;
 
-	if ((pwrpriv->rf_pwrstate == rf_on) && ((pwrpriv->pwr_state_check_cnts%4) == 0)) {
+	if ((pwrpriv->rf_pwrstate == rf_on) && ((pwrpriv->pwr_state_check_cnts % 4) == 0)) {
 		DBG_88E("==>%s .fw_state(%x)\n", __func__, get_fwstate(pmlmepriv));
 		pwrpriv->change_rfpwrstate = rf_off;
 
@@ -444,7 +444,7 @@ void rtw_init_pwrctrl_priv(struct adapter *padapter)
 
 	pwrctrlpriv->LpsIdleCount = 0;
 	if (padapter->registrypriv.mp_mode == 1)
-		pwrctrlpriv->power_mgnt = PS_MODE_ACTIVE ;
+		pwrctrlpriv->power_mgnt = PS_MODE_ACTIVE;
 	else
 		pwrctrlpriv->power_mgnt = padapter->registrypriv.power_mgnt;/*  PS_MODE_MIN; */
 	pwrctrlpriv->bLeisurePs = (PS_MODE_ACTIVE != pwrctrlpriv->power_mgnt) ? true : false;
-- 
2.32.0

