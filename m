Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4FBD33408D0
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Mar 2021 16:27:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231855AbhCRP1Q (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 18 Mar 2021 11:27:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38760 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231744AbhCRP0r (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 Mar 2021 11:26:47 -0400
Received: from mail-wm1-x331.google.com (mail-wm1-x331.google.com [IPv6:2a00:1450:4864:20::331])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8CA5AC06174A
        for <linux-kernel@vger.kernel.org>; Thu, 18 Mar 2021 08:26:47 -0700 (PDT)
Received: by mail-wm1-x331.google.com with SMTP id z6-20020a1c4c060000b029010f13694ba2so3600749wmf.5
        for <linux-kernel@vger.kernel.org>; Thu, 18 Mar 2021 08:26:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=LunxAGqca0bvCLdPnUiavGbIARk+BPOf+do3dcl5T4A=;
        b=I5eqpvvvIuyc8kGK/icE7OpW1t5dzmc4/ruuj6xFcfBOeXaPgh6NV4qT7INAzyWxEv
         EDMHCbP2HkJzvzgadxlsCor+w2XH1VxnxLaFWojCZqfQQoJqmRohtmP0C/LoeCLih3vf
         GHjGAHFAryqcIGxQlHO1xYfx2KGNh7f2vwG+8dtDUu/4ff3gq6rxLD+Vt++IXk50iAWa
         /uSFpf838Y8iU8wyPMZTpSsZSfOLN+/0wlgrNMGn/YrMzhnYKntYGCoFECaISyDusFtH
         j1TOZrresAmj3GmlGheJpR56+7/vE9jofzT7VePTtBanrcyv64NExYrWS9lcnF462W0s
         bZ5w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=LunxAGqca0bvCLdPnUiavGbIARk+BPOf+do3dcl5T4A=;
        b=KCo/yXrAjen3+2RNJFMScxyb/LF58yaJWvP5ZSUOw6Eo9U2YxAa5+w9HiTJbK8cBLE
         TRzrn9qPkTM9HxxomBJlv73McUCocuUUmDWjT5hn4jgfWyAJ5+I9x9IW6zuYGxHxzP3o
         m2tIrN+PAhT1kLJcKTeoklXFzM+NhGX/7TOk1Aao59R/TGEiqqGB7n9iZJILV67JSXLd
         /MAT+GVfB5YUsw27fcgHMbCWpeyUh+iN0GiJPhFuKLLtwHrq/c7cfNbcnqnN6xlr6kLw
         8XwOhtowHIOShPcu0dSu2eo4vnTiWVS5BD+thWl1BN2cY+LX0y9+sQW4W3+9QneMKIa5
         wf9Q==
X-Gm-Message-State: AOAM530jtYrtzinFK5JL0GvW9+kIFkfbnI/koM02zJZANea1DFkpBJBp
        dd/sxf6kyg4osx/owd+61MY=
X-Google-Smtp-Source: ABdhPJzKD4re/uQln+p6c1TorPkgCTTLriNtZWFHUumjJE6Is2YhCNG/ibB8rm7SJJCZXpg9bvRmOA==
X-Received: by 2002:a7b:cbcd:: with SMTP id n13mr4127054wmi.112.1616081206361;
        Thu, 18 Mar 2021 08:26:46 -0700 (PDT)
Received: from agape ([151.46.162.59])
        by smtp.gmail.com with ESMTPSA id e1sm3601410wrd.44.2021.03.18.08.26.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 18 Mar 2021 08:26:46 -0700 (PDT)
From:   Fabio Aiuto <fabioaiuto83@gmail.com>
To:     gregkh@linuxfoundation.org
Cc:     devel@driverdev.osuosl.org, linux-kernel@vger.kernel.org,
        Fabio Aiuto <fabioaiuto83@gmail.com>
Subject: [PATCH 02/15] staging: rtl8723bs: remove unnecessary logging in core/rtw_mlme.c
Date:   Thu, 18 Mar 2021 16:25:57 +0100
Message-Id: <20210318152610.16758-3-fabioaiuto83@gmail.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20210318152610.16758-1-fabioaiuto83@gmail.com>
References: <YFMb+7jjmj7Oty8B@kroah.com>
 <20210318152610.16758-1-fabioaiuto83@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

fix the following checkpatch.pl issues:

WARNING: Unnecessary ftrace-like logging - prefer using ftrace
1134: FILE: drivers/staging/rtl8723bs/core/rtw_mlme.c:1134:
+		DBG_871X("%s\n", __func__);
--
WARNING: Unnecessary ftrace-like logging - prefer using ftrace
1223: FILE: drivers/staging/rtl8723bs/core/rtw_mlme.c:1223:
+	DBG_871X("%s\n", __func__);
--
WARNING: Unnecessary ftrace-like logging - prefer using ftrace
1528: FILE: drivers/staging/rtl8723bs/core/rtw_mlme.c:1528:
+	DBG_871X("%s\n", __func__);

Signed-off-by: Fabio Aiuto <fabioaiuto83@gmail.com>
---
 drivers/staging/rtl8723bs/core/rtw_mlme.c | 6 +-----
 1 file changed, 1 insertion(+), 5 deletions(-)

diff --git a/drivers/staging/rtl8723bs/core/rtw_mlme.c b/drivers/staging/rtl8723bs/core/rtw_mlme.c
index 725f699abda9..368f0cdea65c 100644
--- a/drivers/staging/rtl8723bs/core/rtw_mlme.c
+++ b/drivers/staging/rtl8723bs/core/rtw_mlme.c
@@ -1131,8 +1131,6 @@ static struct sta_info *rtw_joinbss_update_stainfo(struct adapter *padapter, str
 
 	if (psta) { /* update ptarget_sta */
 
-		DBG_871X("%s\n", __func__);
-
 		psta->aid  = pnetwork->join_res;
 
 		update_sta_info(padapter, psta);
@@ -1220,8 +1218,6 @@ static void rtw_joinbss_update_network(struct adapter *padapter, struct wlan_net
 	struct mlme_priv *pmlmepriv = &(padapter->mlmepriv);
 	struct wlan_network  *cur_network = &(pmlmepriv->cur_network);
 
-	DBG_871X("%s\n", __func__);
-
 	RT_TRACE(_module_rtl871x_mlme_c_, _drv_info_, ("\nfw_state:%x, BSSID:%pM\n"
 		, get_fwstate(pmlmepriv), MAC_ARG(pnetwork->network.MacAddress)));
 
@@ -1525,7 +1521,7 @@ void rtw_stassoc_event_callback(struct adapter *adapter, u8 *pbuf)
 	psta->qos_option = 0;
 	psta->mac_id = (uint)pstassoc->cam_id;
 	/* psta->aid = (uint)pstassoc->cam_id; */
-	DBG_871X("%s\n", __func__);
+
 	/* for ad-hoc mode */
 	rtw_hal_set_odm_var(adapter, HAL_ODM_STA_INFO, psta, true);
 
-- 
2.20.1

