Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F0B3B3F19C4
	for <lists+linux-kernel@lfdr.de>; Thu, 19 Aug 2021 14:50:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239629AbhHSMu5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 19 Aug 2021 08:50:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48426 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238400AbhHSMux (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Aug 2021 08:50:53 -0400
Received: from mail-ej1-x635.google.com (mail-ej1-x635.google.com [IPv6:2a00:1450:4864:20::635])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E41A6C061575
        for <linux-kernel@vger.kernel.org>; Thu, 19 Aug 2021 05:50:16 -0700 (PDT)
Received: by mail-ej1-x635.google.com with SMTP id bq25so12636329ejb.11
        for <linux-kernel@vger.kernel.org>; Thu, 19 Aug 2021 05:50:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=dlk61iWrvdXGSmZ6Z0iCNse6iHDCWylNCH2RB7n2MT8=;
        b=itDdcR8SpGo0HQ1jFTHOmvo4REOsaCxgJQwemJN3AG2IqoB1oK7WHW4jnxZoIuASkd
         dqjNNQihM1cTpV0I39Q2x2aYZjJEf4Z/rPrsFWFiOBN691dqh6HzCcMy7Wepc0S17jZQ
         PKiBm1GYnZz9kFL+nTPc4NOBWSxfMPMxoX9Q5zm7mHIewnnN4MlxYd/HeIimwdIzPRsK
         NIKSNHZlSx5pxJ6iyD+kFmhGBb53/WHNK9E6eXJ3Hn+shGro+JrJ7dU/YnJXhVvS7uL0
         vhEgvgn4AeKdb72eZlLAkgpMGGz959nbsmQ3an7gqbJnE1qOgOkRhLvhGZ+38HqaTf/z
         8P+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=dlk61iWrvdXGSmZ6Z0iCNse6iHDCWylNCH2RB7n2MT8=;
        b=RQZ8dYM4ur1y5YINIIHkYr6N9q3IXxhXeIWK/3uYXhSysk4uHbmzyIrSvET5rEJWHn
         bPKJmWWBQm18I2HiFXlqZl2isEeJZQuVVeyef4ptQZDzRhBdT10hm4kYrRimjheaJ/28
         Ey0+fR/Z3mi/Xb2Sw5aEUxI++qchRVcSNa7LyYEn/hUzAMgdx8g81kU19ugdFEgkJGTz
         xlFZIAo84g07E/uThPP3765LmTpPtqyFVw2j2u4sc0Dvs12etwncw4rGee5OA5FbCIjs
         p46yrBo7YxSCzKVCZ+vmuhg0HcG+wDEZlwA41DHemRCRYjCdUM2L11AGM+lbnYvbOAnH
         IQtQ==
X-Gm-Message-State: AOAM532DYvyQM+ZKrhnFqeuMwzdiNaWsycTbLxPPAq0s0rwyXgQeqiO+
        h6gGJKJo3LU3E7ongL84hAE=
X-Google-Smtp-Source: ABdhPJxsZqqHQws3NT6BwHUlVngOL38XOjoRGkOZBH6lWJVyQVAqO66Ikcjbodt1+J3MmlUvL/Qa2w==
X-Received: by 2002:a17:906:a018:: with SMTP id p24mr15546269ejy.349.1629377415458;
        Thu, 19 Aug 2021 05:50:15 -0700 (PDT)
Received: from localhost.localdomain.it (host-79-22-100-164.retail.telecomitalia.it. [79.22.100.164])
        by smtp.gmail.com with ESMTPSA id c8sm1222305ejp.124.2021.08.19.05.50.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 19 Aug 2021 05:50:14 -0700 (PDT)
From:   "Fabio M. De Francesco" <fmdefrancesco@gmail.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Larry Finger <Larry.Finger@lwfinger.net>,
        Phillip Potter <phil@philpotter.co.uk>,
        Martin Kaiser <martin@kaiser.cx>,
        Michael Straube <straube.linux@gmail.com>,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org
Cc:     "Fabio M. De Francesco" <fmdefrancesco@gmail.com>
Subject: [PATCH v2] staging: r8188eu: Remove _enter/_exit_critical_mutex()
Date:   Thu, 19 Aug 2021 14:49:55 +0200
Message-Id: <20210819124955.25540-1-fmdefrancesco@gmail.com>
X-Mailer: git-send-email 2.32.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Remove _enter_critical_mutex() and _exit_critical_mutex(). They are
unnecessary wrappers, respectively to mutex_lock_interruptible() and
to mutex_unlock(). They also have an odd interface that takes an
unused argument named pirqL of type unsigned long.
Replace them with the in-kernel API. Ignore return values as it was
in the old code.

Signed-off-by: Fabio M. De Francesco <fmdefrancesco@gmail.com>
---

v2: Ignore return values from Mutexes API.

 drivers/staging/r8188eu/core/rtw_mlme_ext.c     |  5 +++--
 drivers/staging/r8188eu/hal/usb_ops_linux.c     |  5 +++--
 drivers/staging/r8188eu/include/osdep_service.h | 13 -------------
 drivers/staging/r8188eu/os_dep/os_intfs.c       |  5 +++--
 4 files changed, 9 insertions(+), 19 deletions(-)

diff --git a/drivers/staging/r8188eu/core/rtw_mlme_ext.c b/drivers/staging/r8188eu/core/rtw_mlme_ext.c
index 5325fe41fbee..9f53cab33333 100644
--- a/drivers/staging/r8188eu/core/rtw_mlme_ext.c
+++ b/drivers/staging/r8188eu/core/rtw_mlme_ext.c
@@ -4359,7 +4359,8 @@ s32 dump_mgntframe_and_wait_ack(struct adapter *padapter, struct xmit_frame *pmg
 	if (padapter->bSurpriseRemoved || padapter->bDriverStopped)
 		return -1;
 
-	_enter_critical_mutex(&pxmitpriv->ack_tx_mutex, NULL);
+	if (mutex_lock_interruptible(&pxmitpriv->ack_tx_mutex))
+		;	/*ignore return value */
 	pxmitpriv->ack_tx = true;
 
 	pmgntframe->ack_report = 1;
@@ -4368,7 +4369,7 @@ s32 dump_mgntframe_and_wait_ack(struct adapter *padapter, struct xmit_frame *pmg
 	}
 
 	pxmitpriv->ack_tx = false;
-	_exit_critical_mutex(&pxmitpriv->ack_tx_mutex, NULL);
+	mutex_unlock(&pxmitpriv->ack_tx_mutex);
 
 	return ret;
 }
diff --git a/drivers/staging/r8188eu/hal/usb_ops_linux.c b/drivers/staging/r8188eu/hal/usb_ops_linux.c
index 953fa05dc30c..120d6e2c6065 100644
--- a/drivers/staging/r8188eu/hal/usb_ops_linux.c
+++ b/drivers/staging/r8188eu/hal/usb_ops_linux.c
@@ -32,7 +32,8 @@ static int usbctrl_vendorreq(struct intf_hdl *pintfhdl, u16 value, void *pdata,
 		goto exit;
 	}
 
-	_enter_critical_mutex(&dvobjpriv->usb_vendor_req_mutex, NULL);
+	if (mutex_lock_interruptible(&dvobjpriv->usb_vendor_req_mutex))
+		;	/* ignore return value */
 
 	/*  Acquire IO memory for vendorreq */
 	pIo_buf = dvobjpriv->usb_vendor_req_buf;
@@ -96,7 +97,7 @@ static int usbctrl_vendorreq(struct intf_hdl *pintfhdl, u16 value, void *pdata,
 			break;
 	}
 release_mutex:
-	_exit_critical_mutex(&dvobjpriv->usb_vendor_req_mutex, NULL);
+	mutex_unlock(&dvobjpriv->usb_vendor_req_mutex);
 exit:
 	return status;
 }
diff --git a/drivers/staging/r8188eu/include/osdep_service.h b/drivers/staging/r8188eu/include/osdep_service.h
index 029aa4e92c9b..bb92b9d74bd7 100644
--- a/drivers/staging/r8188eu/include/osdep_service.h
+++ b/drivers/staging/r8188eu/include/osdep_service.h
@@ -56,19 +56,6 @@ static inline struct list_head *get_list_head(struct __queue *queue)
 	return (&(queue->queue));
 }
 
-static inline int _enter_critical_mutex(struct mutex *pmutex, unsigned long *pirqL)
-{
-	int ret;
-
-	ret = mutex_lock_interruptible(pmutex);
-	return ret;
-}
-
-static inline void _exit_critical_mutex(struct mutex *pmutex, unsigned long *pirqL)
-{
-		mutex_unlock(pmutex);
-}
-
 static inline void rtw_list_delete(struct list_head *plist)
 {
 	list_del_init(plist);
diff --git a/drivers/staging/r8188eu/os_dep/os_intfs.c b/drivers/staging/r8188eu/os_dep/os_intfs.c
index 1aa65925e1da..3823042256a6 100644
--- a/drivers/staging/r8188eu/os_dep/os_intfs.c
+++ b/drivers/staging/r8188eu/os_dep/os_intfs.c
@@ -1065,9 +1065,10 @@ int netdev_open(struct net_device *pnetdev)
 	int ret;
 	struct adapter *padapter = (struct adapter *)rtw_netdev_priv(pnetdev);
 
-	_enter_critical_mutex(padapter->hw_init_mutex, NULL);
+	if (mutex_lock_interruptible(padapter->hw_init_mutex))
+		;	/* ignore return value */
 	ret = _netdev_open(pnetdev);
-	_exit_critical_mutex(padapter->hw_init_mutex, NULL);
+	mutex_unlock(padapter->hw_init_mutex);
 	return ret;
 }
 
-- 
2.32.0

