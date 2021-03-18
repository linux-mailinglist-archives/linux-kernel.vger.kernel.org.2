Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 199533408D2
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Mar 2021 16:27:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231881AbhCRP1U (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 18 Mar 2021 11:27:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38784 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231803AbhCRP0x (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 Mar 2021 11:26:53 -0400
Received: from mail-wr1-x42c.google.com (mail-wr1-x42c.google.com [IPv6:2a00:1450:4864:20::42c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 23AF9C06174A
        for <linux-kernel@vger.kernel.org>; Thu, 18 Mar 2021 08:26:53 -0700 (PDT)
Received: by mail-wr1-x42c.google.com with SMTP id v11so5967990wro.7
        for <linux-kernel@vger.kernel.org>; Thu, 18 Mar 2021 08:26:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=MUnZPR9KH0cya06g4iCxL1syilN/kEp01BxfNl+HC9M=;
        b=uw1GTq65IGa2H8mq5fGQpyTGrg5ePQzskJTS1qt8BewmrN2wqFD3rZ3dJ/lvzGj8o4
         wvOAB+0XzoakbPYhqKKqDS+Q0lPqgt8vsjmjuonlLOGLqwRSP1ChJ+//+cO/XOQc/RlD
         Hogz41WW5DFNV83Ej8kydFck0TQHvRPj44A3aIDOb+sm4LH5vKCM+GHQxVY1s+kW9E+s
         X7k26soZ1seZbvz9dK8PXyOqKH+NchazmfAEU0ZTUGh38VQ/1Dtu+kGcVnqefDh1qz6K
         Hakg7td6uFlrr0EZhFrWejFz/kxolx4YYqPKr6aSfrYMQFKybDmLlJ0KS/uYFcom395j
         pTHA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=MUnZPR9KH0cya06g4iCxL1syilN/kEp01BxfNl+HC9M=;
        b=AAjkNIo+E4+MPpUZSf+BqO+i8QwECq390IchuHr2eu/nErh17UnZHPIQJ/WF+6Qg1/
         OOs0/4g+WRa2N2I0OXaeb5m3FSLFARphWO5bWAH0PFwplQ8nRVtvsPO03Lz8DZj8kMoh
         il73joBTdMTaWAJuwen6cjDS2CHfgbqnTAUihXlTHfpkQ/08wZRiaAxhEF1uqrRjYEij
         X0y2y8LLFFl+Apki8FZEzoAsZ1/1mISlfzGCdBAZfXlHsJlT8YSVHNuFNWui25vufD+n
         m9JH/fQIEN4FFw1Kesde04foFCmUe74jl16D58QpKeK66dF1IomLATNmHZCHSEakUyu8
         hddg==
X-Gm-Message-State: AOAM532cu4NMu8qLV2iRkfoLmce90SrDNki/WlnYmIShmIX90/qttcCW
        2Nr635uQWk6K2UlHddk98FQ=
X-Google-Smtp-Source: ABdhPJxRstMxhMoa/t/Nuivxd/u0UkhL0TG8AVb7D+zDFU9SiYmq7xZfSdHXflhdO+/GFasfhW53Xw==
X-Received: by 2002:a5d:65cd:: with SMTP id e13mr10484538wrw.334.1616081211975;
        Thu, 18 Mar 2021 08:26:51 -0700 (PDT)
Received: from agape ([151.46.162.59])
        by smtp.gmail.com with ESMTPSA id l8sm3442773wrx.83.2021.03.18.08.26.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 18 Mar 2021 08:26:51 -0700 (PDT)
From:   Fabio Aiuto <fabioaiuto83@gmail.com>
To:     gregkh@linuxfoundation.org
Cc:     devel@driverdev.osuosl.org, linux-kernel@vger.kernel.org,
        Fabio Aiuto <fabioaiuto83@gmail.com>
Subject: [PATCH 04/15] staging: rtl8723bs: remove unnecessary logging in core/rtw_pwrctrl.c
Date:   Thu, 18 Mar 2021 16:25:59 +0100
Message-Id: <20210318152610.16758-5-fabioaiuto83@gmail.com>
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
185: FILE: drivers/staging/rtl8723bs/core/rtw_pwrctrl.c:185:
+		DBG_871X("==>%s\n", __func__);
--
WARNING: Unnecessary ftrace-like logging - prefer using ftrace
606: FILE: drivers/staging/rtl8723bs/core/rtw_pwrctrl.c:606:
+	DBG_871X("%s.....\n", __func__);
--
WARNING: Unnecessary ftrace-like logging - prefer using ftrace
753: FILE: drivers/staging/rtl8723bs/core/rtw_pwrctrl.c:753:
+	/* DBG_871X("%s\n", __func__); */

Signed-off-by: Fabio Aiuto <fabioaiuto83@gmail.com>
---
 drivers/staging/rtl8723bs/core/rtw_pwrctrl.c | 5 -----
 1 file changed, 5 deletions(-)

diff --git a/drivers/staging/rtl8723bs/core/rtw_pwrctrl.c b/drivers/staging/rtl8723bs/core/rtw_pwrctrl.c
index 2e6c522b74e3..908591a8f3c2 100644
--- a/drivers/staging/rtl8723bs/core/rtw_pwrctrl.c
+++ b/drivers/staging/rtl8723bs/core/rtw_pwrctrl.c
@@ -182,7 +182,6 @@ void rtw_ps_processor(struct adapter *padapter)
 		goto exit;
 
 	if ((pwrpriv->rf_pwrstate == rf_on) && ((pwrpriv->pwr_state_check_cnts%4) == 0)) {
-		DBG_871X("==>%s\n", __func__);
 		pwrpriv->change_rfpwrstate = rf_off;
 		{
 			ips_enter(padapter);
@@ -603,8 +602,6 @@ void LeaveAllPowerSaveModeDirect(struct adapter *Adapter)
 	struct mlme_priv *pmlmepriv = &(Adapter->mlmepriv);
 	struct pwrctrl_priv *pwrpriv = adapter_to_pwrctl(Adapter);
 
-	DBG_871X("%s.....\n", __func__);
-
 	if (Adapter->bSurpriseRemoved) {
 		DBG_871X(FUNC_ADPT_FMT ": bSurpriseRemoved =%d Skip!\n",
 			FUNC_ADPT_ARG(Adapter), Adapter->bSurpriseRemoved);
@@ -750,8 +747,6 @@ static void cpwm_event_callback(struct work_struct *work)
 	struct adapter *adapter = dvobj->if1;
 	struct reportpwrstate_parm report;
 
-	/* DBG_871X("%s\n", __func__); */
-
 	report.state = PS_STATE_S2;
 	cpwm_int_hdl(adapter, &report);
 }
-- 
2.20.1

