Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0BBCD3DCD24
	for <lists+linux-kernel@lfdr.de>; Sun,  1 Aug 2021 21:04:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230419AbhHATE6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 1 Aug 2021 15:04:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54376 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229748AbhHATEw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 1 Aug 2021 15:04:52 -0400
Received: from mail-wm1-x331.google.com (mail-wm1-x331.google.com [IPv6:2a00:1450:4864:20::331])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D6EBFC06175F
        for <linux-kernel@vger.kernel.org>; Sun,  1 Aug 2021 12:04:42 -0700 (PDT)
Received: by mail-wm1-x331.google.com with SMTP id i10-20020a05600c354ab029025a0f317abfso2673284wmq.3
        for <linux-kernel@vger.kernel.org>; Sun, 01 Aug 2021 12:04:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=philpotter-co-uk.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=+b7DvgC7u+StUqnb2po30CalNYFbCbOTH7JaOe05Dw4=;
        b=imTALs21FYY2u/2l1pIGtxYv5Ezkf+z9T01ex4ya7u5tc45K+f53+dbXVRRthT7o7i
         miWNBmS8lfDjCTczetx7ur4SOFIdwJ/xEKQfpr7yBoZxwMEqJP3NJef0Ir+gI+Yb3YZl
         2nNzVg5rTBS8Y6/KY211KO6mjBH6kJc4GbV9bFqlNVLG1VjsZEsb240iy52CjFG5rwiI
         fv1qyn0h5HBGnCnn1QjqNvmnMUUwD0ZHZtKJCJwpuH3VcwfVUhRdLR9Sxm2Ajkw2S3By
         /4ZfpTRKgkM3+oWzePeYgvW2M4itD/ONs/Ct9XDRTuhCEjoExytDsGGCB6OLwYeniBZ5
         V8Xw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=+b7DvgC7u+StUqnb2po30CalNYFbCbOTH7JaOe05Dw4=;
        b=XVwfJobOF9cuGGkKWDe6JmpJXa371RhfR8skZ0yxqD3g1HcbUmJStL3ZOfQeEYr7Po
         aAk0P3/sA9arora3oP8X9DGW+yIVVsJKcWxHlXmQFdxiRWjUhyIO9BEWTwQYGwkihzzZ
         lSE57ZoAZ5xsyGBO7maOqdnJHHt7hpfbJ3lnCpMih1eh44IxgHHBXdBEwYGtHAeZM1z0
         FlT8RNPDLTEaJUAAP0kzcplAJuHsKB+UXG2Xuv2F+vk5zCpyN1wU+gX6JHx0qblz5BGZ
         b62UMYUVDlBpcgPS8jf6wKdJkYIzFnqnm+mVwndnWsg25f7LzcEkdb5v/kPP807Y64TE
         3XDQ==
X-Gm-Message-State: AOAM532sKYkfEsDW0fk1WuagP5pWxlNtR6EpaN17dCSlBx34SyTGb4hT
        9SrufUPB16yAxwBtVLoUW7Vi99TUpq9l9BEc
X-Google-Smtp-Source: ABdhPJxck77daerY6wbgS076FYTbxo7N0H6AYYKPJ4EJQjnfaLfZfVvF4i4CNLWpsaac/t/S/W+ShQ==
X-Received: by 2002:a7b:c1c7:: with SMTP id a7mr13126627wmj.53.1627844681397;
        Sun, 01 Aug 2021 12:04:41 -0700 (PDT)
Received: from localhost.localdomain (3.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.6.1.f.d.0.b.8.0.1.0.0.2.ip6.arpa. [2001:8b0:df16::3])
        by smtp.gmail.com with ESMTPSA id c10sm8196026wmb.40.2021.08.01.12.04.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 01 Aug 2021 12:04:41 -0700 (PDT)
From:   Phillip Potter <phil@philpotter.co.uk>
To:     gregkh@linuxfoundation.org
Cc:     Larry.Finger@lwfinger.net, linux-staging@lists.linux.dev,
        linux-kernel@vger.kernel.org, martin@kaiser.cx
Subject: [PATCH 02/15] staging: r8188eu: remove RT_TRACE calls from core/rtw_pwrctrl.c
Date:   Sun,  1 Aug 2021 20:04:24 +0100
Message-Id: <20210801190437.82017-3-phil@philpotter.co.uk>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20210801190437.82017-1-phil@philpotter.co.uk>
References: <20210801190437.82017-1-phil@philpotter.co.uk>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Remove RT_TRACE macro calls from core/rtw_pwrctrl.c, so that ultimately the
macro definition itself can eventually be removed.

Signed-off-by: Phillip Potter <phil@philpotter.co.uk>
---
 drivers/staging/r8188eu/core/rtw_pwrctrl.c | 27 +++-------------------
 1 file changed, 3 insertions(+), 24 deletions(-)

diff --git a/drivers/staging/r8188eu/core/rtw_pwrctrl.c b/drivers/staging/r8188eu/core/rtw_pwrctrl.c
index d67eeb045002..fa0d8bef11ca 100644
--- a/drivers/staging/r8188eu/core/rtw_pwrctrl.c
+++ b/drivers/staging/r8188eu/core/rtw_pwrctrl.c
@@ -219,37 +219,22 @@ void rtw_set_rpwm(struct adapter *padapter, u8 pslv)
 			pslv = PS_STATE_S3;
 	}
 
-	if ((pwrpriv->rpwm == pslv)) {
-		RT_TRACE(_module_rtl871x_pwrctrl_c_, _drv_err_,
-			 ("%s: Already set rpwm[0x%02X], new=0x%02X!\n", __func__, pwrpriv->rpwm, pslv));
+	if ((pwrpriv->rpwm == pslv))
 		return;
-	}
 
 	if ((padapter->bSurpriseRemoved) ||
 	    (!padapter->hw_init_completed)) {
-		RT_TRACE(_module_rtl871x_pwrctrl_c_, _drv_err_,
-			 ("%s: SurpriseRemoved(%d) hw_init_completed(%d)\n",
-			 __func__, padapter->bSurpriseRemoved, padapter->hw_init_completed));
-
 		pwrpriv->cpwm = PS_STATE_S4;
 
 		return;
 	}
 
 	if (padapter->bDriverStopped) {
-		RT_TRACE(_module_rtl871x_pwrctrl_c_, _drv_err_,
-			 ("%s: change power state(0x%02X) when DriverStopped\n", __func__, pslv));
-
-		if (pslv < PS_STATE_S2) {
-			RT_TRACE(_module_rtl871x_pwrctrl_c_, _drv_err_,
-				 ("%s: Reject to enter PS_STATE(0x%02X) lower than S2 when DriverStopped!!\n", __func__, pslv));
+		if (pslv < PS_STATE_S2)
 			return;
-		}
 	}
 
 	rpwm = pslv | pwrpriv->tog;
-	RT_TRACE(_module_rtl871x_pwrctrl_c_, _drv_notice_,
-		 ("rtw_set_rpwm: rpwm=0x%02x cpwm=0x%02x\n", rpwm, pwrpriv->cpwm));
 
 	pwrpriv->rpwm = pslv;
 
@@ -294,14 +279,8 @@ void rtw_set_ps_mode(struct adapter *padapter, u8 ps_mode, u8 smart_ps, u8 bcn_a
 	struct wifidirect_info	*pwdinfo = &(padapter->wdinfo);
 #endif /* CONFIG_88EU_P2P */
 
-	RT_TRACE(_module_rtl871x_pwrctrl_c_, _drv_notice_,
-		 ("%s: PowerMode=%d Smart_PS=%d\n",
-		  __func__, ps_mode, smart_ps));
-
-	if (ps_mode > PM_Card_Disable) {
-		RT_TRACE(_module_rtl871x_pwrctrl_c_, _drv_err_, ("ps_mode:%d error\n", ps_mode));
+	if (ps_mode > PM_Card_Disable)
 		return;
-	}
 
 	if (pwrpriv->pwr_mode == ps_mode) {
 		if (PS_MODE_ACTIVE == ps_mode)
-- 
2.31.1

