Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 817E833AFC1
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Mar 2021 11:16:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229868AbhCOKPn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 15 Mar 2021 06:15:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52712 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229927AbhCOKPa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 Mar 2021 06:15:30 -0400
Received: from mail-wr1-x429.google.com (mail-wr1-x429.google.com [IPv6:2a00:1450:4864:20::429])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5DE7DC061574
        for <linux-kernel@vger.kernel.org>; Mon, 15 Mar 2021 03:15:30 -0700 (PDT)
Received: by mail-wr1-x429.google.com with SMTP id y16so8381759wrw.3
        for <linux-kernel@vger.kernel.org>; Mon, 15 Mar 2021 03:15:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=lmh4k3+Fsp3ekRFKDIKpQMgAB2T8DdEixm3SBFwZXeE=;
        b=rdgdJn9jeeqha9/196731CP/v3j/l8I0lafaQZDnopau0H1HkJSl+x3OtBELaEPvR5
         IuaugX8LplH+hevOmkrRGzY66p9Nekam5jZmwEIB2XqPKs73m6Yxy8b5ohMs1jzVr/0D
         PyXZ4mvOYEjkpyzqvxI7EjLJfEKlR2qqRkPSXcre+3W4FqGrDhiIc+g/mdB84qHaO7y5
         8I9Nv2jSixUsvO1GJLv2AicRQKzA7tYVmxyGc9SLxWvxtDe5YywlPErkELkHTs2E4ZW+
         AhZgIkH4u2TX2TZ3GEKJ9M6S7ddcqqyZf0sw+FXZta+uagUCaLlF4wkdEndjyDa7+5T0
         2NxA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=lmh4k3+Fsp3ekRFKDIKpQMgAB2T8DdEixm3SBFwZXeE=;
        b=j3gntvdOoI6P6jNguhkABHq7hoL35tT/lDsBbYiMECdkN86w45W4Lz2j+L0P36lJH9
         tu4Xf2QzTeC4/rKe37nuq6X/aVPcf2jBWuOFOu4ysERa7oh8lfr6bvQ00KX8qJV9BlOj
         ofleXHV2SNunF+PdzaPGuIDyu5hrXbytSpSCUPGvLbadwAyyQCPKfxQaN3gdaGHLbael
         BLydUCHRSMyfOLdU1ZPqQi0yC8J+jlAO+iay90ibgEwXHaD1t28lfGy8f2Dhp7Yt0dl5
         UYENwywRw6e0aFDwdW86ACLpl5d+33WaNcatmUlkm3X/JCrAPiNccCYNHAw2zrX46pcZ
         K/kg==
X-Gm-Message-State: AOAM5334EufyXu2hZJh5GkLCIrRdNB+kqcJ3lAS669gxadV7taE7Z3IJ
        LcKMYFDpFgjGgvqL88TR1DE=
X-Google-Smtp-Source: ABdhPJyqBI7S6a0ZYmXPhJO5yu+xHriMrdzzv218uvqWkap9aSt2kdSirdCFSCMWcgVCnJznVYpScw==
X-Received: by 2002:adf:b30f:: with SMTP id j15mr26473782wrd.132.1615803329121;
        Mon, 15 Mar 2021 03:15:29 -0700 (PDT)
Received: from agape.jhs ([5.171.72.229])
        by smtp.gmail.com with ESMTPSA id o13sm20961858wro.15.2021.03.15.03.15.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 15 Mar 2021 03:15:28 -0700 (PDT)
Date:   Mon, 15 Mar 2021 11:15:26 +0100
From:   Fabio Aiuto <fabioaiuto83@gmail.com>
To:     gregkh@linuxfoundation.org
Cc:     devel@driverdev.osuosl.org, linux-kernel@vger.kernel.org
Subject: [PATCH 06/15] staging: rtl8723bs: remove unused code blocks
 conditioned by never set CONFIG_SIGNAL_DISPLAY_DBM
Message-ID: <abfd2f2fa0425d8e5d8618dd64ef40b4974c71b4.1615801721.git.fabioaiuto83@gmail.com>
References: <cover.1615801721.git.fabioaiuto83@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1615801721.git.fabioaiuto83@gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

remove conditional code blocks checked by unused CONFIG_SIGNAL_DISPLAY_DBM

cleaning required in TODO file:

find and remove code blocks guarded by never set CONFIG_FOO defines

Signed-off-by: Fabio Aiuto <fabioaiuto83@gmail.com>
---
 drivers/staging/rtl8723bs/core/rtw_mlme_ext.c |  2 +-
 drivers/staging/rtl8723bs/hal/hal_com.c       |  4 ++--
 .../staging/rtl8723bs/os_dep/ioctl_linux.c    | 21 +++----------------
 3 files changed, 6 insertions(+), 21 deletions(-)

diff --git a/drivers/staging/rtl8723bs/core/rtw_mlme_ext.c b/drivers/staging/rtl8723bs/core/rtw_mlme_ext.c
index 0ca3ddfc8b08..5d0611c5119b 100644
--- a/drivers/staging/rtl8723bs/core/rtw_mlme_ext.c
+++ b/drivers/staging/rtl8723bs/core/rtw_mlme_ext.c
@@ -4211,7 +4211,7 @@ void site_survey(struct adapter *padapter)
 		channel_scan_time_ms = pmlmeext->chan_scan_time;
 
 		set_survey_timer(pmlmeext, channel_scan_time_ms);
-#if defined(CONFIG_SIGNAL_DISPLAY_DBM) && defined(CONFIG_BACKGROUND_NOISE_MONITOR)
+#ifdef CONFIG_BACKGROUND_NOISE_MONITOR
 		{
 			struct noise_info info;
 
diff --git a/drivers/staging/rtl8723bs/hal/hal_com.c b/drivers/staging/rtl8723bs/hal/hal_com.c
index 4a1ca57c2e15..7c65ec60a982 100644
--- a/drivers/staging/rtl8723bs/hal/hal_com.c
+++ b/drivers/staging/rtl8723bs/hal/hal_com.c
@@ -1262,7 +1262,7 @@ void GetHalODMVar(
 )
 {
 	switch (eVariable) {
-#if defined(CONFIG_SIGNAL_DISPLAY_DBM) && defined(CONFIG_BACKGROUND_NOISE_MONITOR)
+#ifdef CONFIG_BACKGROUND_NOISE_MONITOR
 	case HAL_ODM_NOISE_MONITOR:
 		{
 			struct hal_com_data	*pHalData = GET_HAL_DATA(Adapter);
@@ -1313,7 +1313,7 @@ void SetHalODMVar(
 	case HAL_ODM_WIFI_DISPLAY_STATE:
 			ODM_CmnInfoUpdate(podmpriv, ODM_CMNINFO_WIFI_DISPLAY, bSet);
 		break;
-	#if defined(CONFIG_SIGNAL_DISPLAY_DBM) && defined(CONFIG_BACKGROUND_NOISE_MONITOR)
+	#ifdef CONFIG_BACKGROUND_NOISE_MONITOR
 	case HAL_ODM_NOISE_MONITOR:
 		{
 			struct noise_info *pinfo = pValue1;
diff --git a/drivers/staging/rtl8723bs/os_dep/ioctl_linux.c b/drivers/staging/rtl8723bs/os_dep/ioctl_linux.c
index 822e6b650c6b..a52d04582aa1 100644
--- a/drivers/staging/rtl8723bs/os_dep/ioctl_linux.c
+++ b/drivers/staging/rtl8723bs/os_dep/ioctl_linux.c
@@ -313,14 +313,11 @@ static char *translate_scan(struct adapter *padapter,
 	/* Add quality statistics */
 	iwe.cmd = IWEVQUAL;
 	iwe.u.qual.updated = IW_QUAL_QUAL_UPDATED | IW_QUAL_LEVEL_UPDATED
-	#if defined(CONFIG_SIGNAL_DISPLAY_DBM) && defined(CONFIG_BACKGROUND_NOISE_MONITOR)
+	#ifdef CONFIG_BACKGROUND_NOISE_MONITOR
 		| IW_QUAL_NOISE_UPDATED
 	#else
 		| IW_QUAL_NOISE_INVALID
 	#endif
-	#ifdef CONFIG_SIGNAL_DISPLAY_DBM
-		| IW_QUAL_DBM
-	#endif
 	;
 
 	if (check_fwstate(pmlmepriv, _FW_LINKED) == true &&
@@ -333,9 +330,6 @@ static char *translate_scan(struct adapter *padapter,
 	}
 
 
-	#ifdef CONFIG_SIGNAL_DISPLAY_DBM
-	iwe.u.qual.level = (u8)translate_percentage_to_dbm(ss);/* dbm */
-	#else
 	#ifdef CONFIG_SKIP_SIGNAL_SCALE_MAPPING
 	{
 		/* Do signal scale mapping when using percentage as the unit of signal strength, since the scale mapping is skipped in odm */
@@ -347,11 +341,10 @@ static char *translate_scan(struct adapter *padapter,
 	#else
 	iwe.u.qual.level = (u8)ss;/*  */
 	#endif
-	#endif
 
 	iwe.u.qual.qual = (u8)sq;   /*  signal quality */
 
-	#if defined(CONFIG_SIGNAL_DISPLAY_DBM) && defined(CONFIG_BACKGROUND_NOISE_MONITOR)
+	#ifdef CONFIG_BACKGROUND_NOISE_MONITOR
 	{
 		s16 tmp_noise = 0;
 		rtw_hal_get_odm_var(padapter, HAL_ODM_NOISE_MONITOR, &(pnetwork->network.Configuration.DSConfig), &(tmp_noise));
@@ -4728,9 +4721,6 @@ static struct iw_statistics *rtw_get_wireless_stats(struct net_device *dev)
 		piwstats->qual.noise = 0;
 		/* DBG_871X("No link  level:%d, qual:%d, noise:%d\n", tmp_level, tmp_qual, tmp_noise); */
 	} else {
-		#ifdef CONFIG_SIGNAL_DISPLAY_DBM
-		tmp_level = translate_percentage_to_dbm(padapter->recvpriv.signal_strength);
-		#else
 		#ifdef CONFIG_SKIP_SIGNAL_SCALE_MAPPING
 		{
 			/* Do signal scale mapping when using percentage as the unit of signal strength, since the scale mapping is skipped in odm */
@@ -4742,10 +4732,9 @@ static struct iw_statistics *rtw_get_wireless_stats(struct net_device *dev)
 		#else
 		tmp_level = padapter->recvpriv.signal_strength;
 		#endif
-		#endif
 
 		tmp_qual = padapter->recvpriv.signal_qual;
-#if defined(CONFIG_SIGNAL_DISPLAY_DBM) && defined(CONFIG_BACKGROUND_NOISE_MONITOR)
+#ifdef CONFIG_BACKGROUND_NOISE_MONITOR
 		if (rtw_linked_check(padapter)) {
 			struct mlme_ext_priv *pmlmeext = &padapter->mlmeextpriv;
 			struct noise_info info;
@@ -4772,10 +4761,6 @@ static struct iw_statistics *rtw_get_wireless_stats(struct net_device *dev)
 	}
 	piwstats->qual.updated = IW_QUAL_ALL_UPDATED ;/* IW_QUAL_DBM; */
 
-	#ifdef CONFIG_SIGNAL_DISPLAY_DBM
-	piwstats->qual.updated = piwstats->qual.updated | IW_QUAL_DBM;
-	#endif
-
 	return &padapter->iwstats;
 }
 
-- 
2.20.1

