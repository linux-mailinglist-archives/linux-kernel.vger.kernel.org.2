Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D49393B39FC
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Jun 2021 02:09:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233084AbhFYALQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 24 Jun 2021 20:11:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34274 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232992AbhFYAKo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Jun 2021 20:10:44 -0400
Received: from mail-qk1-x734.google.com (mail-qk1-x734.google.com [IPv6:2607:f8b0:4864:20::734])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E8465C061760
        for <linux-kernel@vger.kernel.org>; Thu, 24 Jun 2021 17:08:23 -0700 (PDT)
Received: by mail-qk1-x734.google.com with SMTP id w21so17286822qkb.9
        for <linux-kernel@vger.kernel.org>; Thu, 24 Jun 2021 17:08:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=philpotter-co-uk.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=jwbRJl5M/LrPIL7wwKSPT7dbiFGB7ju9JcUSHq91UHw=;
        b=u2k06J8IvMTDGJvpozYb4PcMOMnIG83NvzJvA8SkifrhYTC5BMRVJGD0uYp7XCsNrw
         EKd9UPwiBne2NtCBd7pUeeQuoxKTjKOc04dMO0tqo/WwxsAa2zXglxz3aud8kiOXJwcX
         tCXYwG2vBPF9HBt5Sw7pJ5cIBLJAtqhLjvKGYOiMtJ4F3mqa4wyPiN2xUpy0lTlgaYRa
         G20EeaNOAHuAxzddVQBfyt+YsTg68mvqbOEtOupYIFLlwj37gMZ1g2KZD+sX+afsY6Jn
         aoWEVSZaY0LffXNJfFeW4dhMAMcod7+FB2PUJTgspOQOv0d/Rc3T0DMgeZRUKWJzVrFO
         8Nqw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=jwbRJl5M/LrPIL7wwKSPT7dbiFGB7ju9JcUSHq91UHw=;
        b=VJk6O6RcKQ/qr9JVrRR9Z3DsD352u3K1lyRM8mPKCsNo1H2ncV8/tlPHfmXzaMmt12
         1J8EM3nTLW2D9Xaiyx5y19p/H/bbKkEINNv8LLVjby69WRRiyagGk3fMwOrRDDzKn0LB
         ICGxNV6iOZVb/Ajw0Vdwxb84WsQn5EGd/Da20HCxvyXr1OwxTjtJ107j5E68p5i4uk3J
         I095vGbwwHwfwwmxKSGpbaJmJk9qUZXOR3+uvh9+emPI1hZP1LpK8w/+2VoA5Jpt9QlJ
         tpSCIMef4VMJAsqHb4ePz11BlXMjtqAON8H942Lo3JkLDOzrz0OvEUya7WQi1JgE6Gze
         VZoA==
X-Gm-Message-State: AOAM5301aOKEsAJwNs8lN4vR9CT+mgfhLpLwdR7tl9dA2le25KKieA8W
        j+z7Zro3fZpW4gIRNOqkbP9lWQ==
X-Google-Smtp-Source: ABdhPJz0EshZlF2MG6dtdk1X8Q3k7BEq+WR7uziOGaKQGhHdmr6bhIu1D0nE7F+8R4KPfJn36zGZMQ==
X-Received: by 2002:ae9:e806:: with SMTP id a6mr8614268qkg.431.1624579703127;
        Thu, 24 Jun 2021 17:08:23 -0700 (PDT)
Received: from kerneldevvm.. (5.6.a.8.a.a.b.f.c.9.4.c.a.9.a.a.0.a.1.e.e.d.f.d.0.b.8.0.1.0.0.2.ip6.arpa. [2001:8b0:dfde:e1a0:aa9a:c49c:fbaa:8a65])
        by smtp.gmail.com with ESMTPSA id m187sm3629014qkd.131.2021.06.24.17.08.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 24 Jun 2021 17:08:22 -0700 (PDT)
From:   Phillip Potter <phil@philpotter.co.uk>
To:     gregkh@linuxfoundation.org
Cc:     Larry.Finger@lwfinger.net, dan.carpenter@oracle.com,
        linux-kernel@vger.kernel.org, linux-staging@lists.linux.dev
Subject: [PATCH 15/23] staging: rtl8188eu: remove all RT_TRACE calls from core/rtw_pwrctrl.c
Date:   Fri, 25 Jun 2021 01:07:48 +0100
Message-Id: <20210625000756.6313-16-phil@philpotter.co.uk>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20210625000756.6313-1-phil@philpotter.co.uk>
References: <20210625000756.6313-1-phil@philpotter.co.uk>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Remove all RT_TRACE calls from core/rtw_pwrctrl.c as this macro is
unnecessary, and these calls are dubious in terms of necessity.
Removing all calls will ultimately allow the removal of the macro
itself.

Signed-off-by: Phillip Potter <phil@philpotter.co.uk>
---
 drivers/staging/rtl8188eu/core/rtw_pwrctrl.c | 27 +++-----------------
 1 file changed, 3 insertions(+), 24 deletions(-)

diff --git a/drivers/staging/rtl8188eu/core/rtw_pwrctrl.c b/drivers/staging/rtl8188eu/core/rtw_pwrctrl.c
index 95e2eea23e42..cbb34b920ab9 100644
--- a/drivers/staging/rtl8188eu/core/rtw_pwrctrl.c
+++ b/drivers/staging/rtl8188eu/core/rtw_pwrctrl.c
@@ -265,37 +265,22 @@ void rtw_set_rpwm(struct adapter *padapter, u8 pslv)
 			pslv = PS_STATE_S3;
 	}
 
-	if (pwrpriv->rpwm == pslv) {
-		RT_TRACE(_module_rtl871x_pwrctrl_c_, _drv_err_,
-			 ("%s: Already set rpwm[0x%02X], new=0x%02X!\n", __func__, pwrpriv->rpwm, pslv));
+	if (pwrpriv->rpwm == pslv)
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
-		 ("%s: rpwm=0x%02x cpwm=0x%02x\n", __func__, rpwm, pwrpriv->cpwm));
 
 	pwrpriv->rpwm = pslv;
 
@@ -335,14 +320,8 @@ void rtw_set_ps_mode(struct adapter *padapter, u8 ps_mode, u8 smart_ps, u8 bcn_a
 {
 	struct pwrctrl_priv *pwrpriv = &padapter->pwrctrlpriv;
 
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
 		if (ps_mode == PS_MODE_ACTIVE)
-- 
2.31.1

