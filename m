Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DFBCB4068EA
	for <lists+linux-kernel@lfdr.de>; Fri, 10 Sep 2021 11:13:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232035AbhIJJOQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 10 Sep 2021 05:14:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42674 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231952AbhIJJON (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Sep 2021 05:14:13 -0400
Received: from mail-pl1-x62f.google.com (mail-pl1-x62f.google.com [IPv6:2607:f8b0:4864:20::62f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 017C2C061574
        for <linux-kernel@vger.kernel.org>; Fri, 10 Sep 2021 02:13:03 -0700 (PDT)
Received: by mail-pl1-x62f.google.com with SMTP id d17so730330plr.12
        for <linux-kernel@vger.kernel.org>; Fri, 10 Sep 2021 02:13:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=date:from:to:cc:subject:message-id:mime-version:content-disposition;
        bh=k7ctWDVw89Lf1PI2rAfyUGOTaXG/9yXMupyPGuXqQ+U=;
        b=qU4Yi/8GJA2a8/5wb+Ebuw+bxuMHatq9SzDFV8qtKA21cN+yYzYmJdMScaaIjTM7Hf
         WWMP2L9oYcJaq8kW23o8JTo5PXgrbN2Bt5StyAhvXjlMG5awjcI1oR68/NM6tOi0/LyW
         57YwBQtQwWrV7IfDfSDAgfjRvAFhZH2q+s8/yqqlWCuIqcojY7bPQB4v2AIsOLobsmTS
         DLYxj9duPnC3qxDJ8xukokLJ2Hbrj64Te3JK0Q6/k2ZITyQy++ts8Nr246W1/XAZZiER
         AScjndUVeJ4zX/kW4wvKc6U3KuTKlHZTyZcVDQPzTN18uIb4uAtlbNGQRpllA8K8HJJX
         /V6g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:mime-version
         :content-disposition;
        bh=k7ctWDVw89Lf1PI2rAfyUGOTaXG/9yXMupyPGuXqQ+U=;
        b=TUkgD6P7BSMxfFdz6fO9VHZEKRJyvdjjKHrGID0aSSm1F8GrEFGLgVtFMb+RYU2iN3
         TfNoKAvyiblEgQv0q1qgDVfbc9X0rsxGwtL0yJGD3Mcplz1rJmUr39FiD0uVnX1ta0NW
         SF7BxnakZKW2dfA+9qpRDogz0uiN3qD2OqYhIkVvJSXFiPlo+IhQZyUtMnww6WnNId3q
         LJW+EW2pXO3xN/Rb3wecbrIrkt5HVqzcbNPanKrHZDZF1NohYrxz8a00sbYIIHrAj7kb
         i8VSVAlA0toKwasiNWq4pTq96iEDIaYZat4LJbB+yB/dlgUwo4q2UyE1qgUVtc2MBOkD
         /88A==
X-Gm-Message-State: AOAM5313zqeJeOzxsAqKo9mqz1GEOfUujJ3ofQsKTdSxwk5PG+HZKjln
        i3O5Aw9lCI8muh7N9PMnes0N2pord/OOMw==
X-Google-Smtp-Source: ABdhPJzK4ERSsO2vWrsAtsYfGV2bAEMIEucHpw3x4oFKtaNa1vlvgCT+EV87i9EslSe+cp61JUQlig==
X-Received: by 2002:a17:90a:2bc1:: with SMTP id n1mr8374922pje.100.1631265182404;
        Fri, 10 Sep 2021 02:13:02 -0700 (PDT)
Received: from user ([117.98.200.228])
        by smtp.gmail.com with ESMTPSA id y12sm4460939pjm.42.2021.09.10.02.12.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 10 Sep 2021 02:13:01 -0700 (PDT)
Date:   Fri, 10 Sep 2021 14:42:56 +0530
From:   Saurav Girepunje <saurav.girepunje@gmail.com>
To:     Larry.Finger@lwfinger.net, phil@philpotter.co.uk,
        gregkh@linuxfoundation.org, saurav.girepunje@gmail.com,
        straube.linux@gmail.com, martin@kaiser.cx, nathan@kernel.org,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org
Cc:     saurav.girepunje@hotmail.com
Subject: [PATCH v3] staging: r8188eu: os_dep: simplifiy the rtw_resume
 function
Message-ID: <YTshmPcZr/aVclHK@user>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Remove unused variable ret and pwrpriv.
Remove the condition with no effect (if == else) in usb_intf.c
file.
Remove rtw_resume_process() and move whole thing to rtw_resume().
Remove the padapter NULL check which couldn't NULL in rtw_resume function.

Signed-off-by: Saurav Girepunje <saurav.girepunje@gmail.com>
---

ChangeLog V3:
- Remove the padapter NULL check.

ChangeLog V2:
- Remove rtw_resume_process() and move whole thing to rtw_resume().

 drivers/staging/r8188eu/include/usb_osintf.h |  2 --
 drivers/staging/r8188eu/os_dep/usb_intf.c    | 20 ++------------------
 2 files changed, 2 insertions(+), 20 deletions(-)

diff --git a/drivers/staging/r8188eu/include/usb_osintf.h b/drivers/staging/r8188eu/include/usb_osintf.h
index d1a1f739309c..34229b1cb081 100644
--- a/drivers/staging/r8188eu/include/usb_osintf.h
+++ b/drivers/staging/r8188eu/include/usb_osintf.h
@@ -24,6 +24,4 @@ void *scdb_findEntry(struct adapter *priv, unsigned char *macAddr,
 void nat25_db_expire(struct adapter *priv);
 int nat25_db_handle(struct adapter *priv, struct sk_buff *skb, int method);

-int rtw_resume_process(struct adapter *padapter);
-
 #endif
diff --git a/drivers/staging/r8188eu/os_dep/usb_intf.c b/drivers/staging/r8188eu/os_dep/usb_intf.c
index bb85ab77fd26..309291d6a98e 100644
--- a/drivers/staging/r8188eu/os_dep/usb_intf.c
+++ b/drivers/staging/r8188eu/os_dep/usb_intf.c
@@ -493,18 +493,6 @@ static int rtw_resume(struct usb_interface *pusb_intf)
 {
 	struct dvobj_priv *dvobj = usb_get_intfdata(pusb_intf);
 	struct adapter *padapter = dvobj->if1;
-	struct pwrctrl_priv *pwrpriv = &padapter->pwrctrlpriv;
-	int ret = 0;
-
-	if (pwrpriv->bInternalAutoSuspend)
-		ret = rtw_resume_process(padapter);
-	else
-		ret = rtw_resume_process(padapter);
-	return ret;
-}
-
-int rtw_resume_process(struct adapter *padapter)
-{
 	struct net_device *pnetdev;
 	struct pwrctrl_priv *pwrpriv = NULL;
 	int ret = -1;
@@ -512,12 +500,8 @@ int rtw_resume_process(struct adapter *padapter)

 	DBG_88E("==> %s (%s:%d)\n", __func__, current->comm, current->pid);

-	if (padapter) {
-		pnetdev = padapter->pnetdev;
-		pwrpriv = &padapter->pwrctrlpriv;
-	} else {
-		goto exit;
-	}
+	pnetdev = padapter->pnetdev;
+	pwrpriv = &padapter->pwrctrlpriv;

 	_enter_pwrlock(&pwrpriv->lock);
 	rtw_reset_drv_sw(padapter);
--
2.32.0

