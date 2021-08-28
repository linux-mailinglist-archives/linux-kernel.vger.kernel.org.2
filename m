Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8149E3FA584
	for <lists+linux-kernel@lfdr.de>; Sat, 28 Aug 2021 13:37:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234102AbhH1Lhz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 28 Aug 2021 07:37:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50254 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233892AbhH1Lhx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 28 Aug 2021 07:37:53 -0400
Received: from mail-ej1-x62d.google.com (mail-ej1-x62d.google.com [IPv6:2a00:1450:4864:20::62d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C073BC061756
        for <linux-kernel@vger.kernel.org>; Sat, 28 Aug 2021 04:37:02 -0700 (PDT)
Received: by mail-ej1-x62d.google.com with SMTP id a25so19751686ejv.6
        for <linux-kernel@vger.kernel.org>; Sat, 28 Aug 2021 04:37:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=9i2MZ6ryE+MCfj7gRcpOOFHN1PhXuatvSgRLYw0l6po=;
        b=RB9B2G9SbhqgAL6Jt9rBGFQ+uLZGmdn+P1j8CV4zSQ1VhKW2QVJq9dMK+ZIpK0gnzQ
         //BSC+zE7ykstC+xg6+yI39aaO/8ZOIUYpXeRoWbxzr+s4PnkSoioiv9MuEtBQUjt4lJ
         84eOmtii9ZRbsVtJDcBzYx+BO5NZTkHs0HseEpM1tVSQtVASpy2+Vp6H6N/be27Urmnb
         0bfMpqj0DRvfe+sRf35xzcITgfxdTljbkQvJ+GeYUmV24LwBkMwJ710riT3OhDdpRRNY
         xqXjAGHIOgV6BYpl1dJoXJOgauoUyJhTscX2oOJASAdbp6shxj83tB/nGpECu9j+pPt3
         6o5w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=9i2MZ6ryE+MCfj7gRcpOOFHN1PhXuatvSgRLYw0l6po=;
        b=jeBm28pyWCywwIZPmgpJj6imVqQcWgV1zxkTkYCZWXQg7UU/a854rByBfGkGNzU7rK
         ifaY1IRSfuZJ5xsS0zP2oGqailEfGi6lc62cE52SlT0m1WzlR6W4vmRuCgwsaaDqAvY2
         JaWQHmK16F8UkKOFnvtqa7gAKbHhcoZUQ4d4GcsVvpnLFixY4Q0PXZV7FrEXNu1KB2bb
         S4CYWW6U661vQreyo7qiFtY6TbGtUrFBu8CWs9qjmfUG8UlYX5WNCB1UeEofaz8frV+6
         81xcxjU663O8QA2EENgOdL8kpEHeCJS/ozYiSTCqFS0oakRELFlzlfsmBZOoec6AEmGy
         yCyA==
X-Gm-Message-State: AOAM532YmCsB47I1Bg2T0KVsaQzFgRKy50NjrIMHvmCtOBIGWMtVXhT9
        bZSNVvzPKeY+OWn18+df2SIQ8tj0hew=
X-Google-Smtp-Source: ABdhPJymAN8bqsqwAy8uk9GsLPGFXXiNv/J5LMBM55jhEhsfSIiJvUq0eaJWw0kaA7fReoH1do4p/Q==
X-Received: by 2002:a17:906:a044:: with SMTP id bg4mr15045786ejb.312.1630150621294;
        Sat, 28 Aug 2021 04:37:01 -0700 (PDT)
Received: from localhost.localdomain (host-79-22-100-164.retail.telecomitalia.it. [79.22.100.164])
        by smtp.gmail.com with ESMTPSA id q14sm4102081ejc.93.2021.08.28.04.36.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 28 Aug 2021 04:37:00 -0700 (PDT)
From:   "Fabio M. De Francesco" <fmdefrancesco@gmail.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Larry Finger <Larry.Finger@lwfinger.net>,
        Phillip Potter <phil@philpotter.co.uk>,
        Martin Kaiser <martin@kaiser.cx>,
        Michael Straube <straube.linux@gmail.com>,
        Pavel Skripkin <paskripkin@gmail.com>,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org,
        Aakash Hemadri <aakashhemadri123@gmail.com>
Cc:     "Fabio M. De Francesco" <fmdefrancesco@gmail.com>
Subject: [PATCH v5] staging: r8188eu: Remove _enter/_exit_critical_mutex()
Date:   Sat, 28 Aug 2021 13:36:56 +0200
Message-Id: <20210828113656.6963-1-fmdefrancesco@gmail.com>
X-Mailer: git-send-email 2.32.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Remove _enter_critical_mutex() and _exit_critical_mutex(). They are
unnecessary wrappers, respectively to mutex_lock_interruptible() and
to mutex_unlock(). They also have an odd interface that takes an unused
argument named pirqL of type unsigned long.
The original code enters the critical section if the mutex API is
interrupted while waiting to acquire the lock; therefore it could lead
to a race condition. Use mutex_lock() because it is uninterruptible and
so avoid that above-mentioned potential race condition.

Tested-by: Pavel Skripkin <paskripkin@gmail.com>
Reviewed-by: Pavel Skripkin <paskripkin@gmail.com>
Signed-off-by: Fabio M. De Francesco <fmdefrancesco@gmail.com>
---

v5: Fix a typo in the subject line. Reported by Aakash Hemadri.

v4: Tested and reviewed by Pavel Skripkin. No changes to the code.

v3: Assume that the original authors don't expect that
mutex_lock_interruptible() can be really interrupted and then lead to 
a potential race condition. Furthermore, Greg Kroah-Hartman makes me
notice that "[] one almost never needs interruptable locks in a driver".
Therefore, replace the calls to mutex_lock_interruptible() with calls to
mutex_lock() since the latter is uninterruptible and avoid race
conditions without the necessity to handle -EINTR errors.

v2: Ignore return values from Mutexes API because the original authors
don't check and manage return errors from mutex_lock_interruptible(). 

 drivers/staging/r8188eu/core/rtw_mlme_ext.c     |  4 ++--
 drivers/staging/r8188eu/hal/usb_ops_linux.c     |  4 ++--
 drivers/staging/r8188eu/include/osdep_service.h | 13 -------------
 drivers/staging/r8188eu/os_dep/os_intfs.c       |  4 ++--
 4 files changed, 6 insertions(+), 19 deletions(-)

diff --git a/drivers/staging/r8188eu/core/rtw_mlme_ext.c b/drivers/staging/r8188eu/core/rtw_mlme_ext.c
index 5a472a4954b0..3df02bd0db89 100644
--- a/drivers/staging/r8188eu/core/rtw_mlme_ext.c
+++ b/drivers/staging/r8188eu/core/rtw_mlme_ext.c
@@ -4359,7 +4359,7 @@ s32 dump_mgntframe_and_wait_ack(struct adapter *padapter, struct xmit_frame *pmg
 	if (padapter->bSurpriseRemoved || padapter->bDriverStopped)
 		return -1;
 
-	_enter_critical_mutex(&pxmitpriv->ack_tx_mutex, NULL);
+	mutex_lock(&pxmitpriv->ack_tx_mutex);
 	pxmitpriv->ack_tx = true;
 
 	pmgntframe->ack_report = 1;
@@ -4368,7 +4368,7 @@ s32 dump_mgntframe_and_wait_ack(struct adapter *padapter, struct xmit_frame *pmg
 	}
 
 	pxmitpriv->ack_tx = false;
-	_exit_critical_mutex(&pxmitpriv->ack_tx_mutex, NULL);
+	mutex_unlock(&pxmitpriv->ack_tx_mutex);
 
 	return ret;
 }
diff --git a/drivers/staging/r8188eu/hal/usb_ops_linux.c b/drivers/staging/r8188eu/hal/usb_ops_linux.c
index 0cf69033c529..065b0d8e030a 100644
--- a/drivers/staging/r8188eu/hal/usb_ops_linux.c
+++ b/drivers/staging/r8188eu/hal/usb_ops_linux.c
@@ -29,7 +29,7 @@ static int usbctrl_vendorreq(struct intf_hdl *pintfhdl, u16 value, void *pdata,
 		goto exit;
 	}
 
-	_enter_critical_mutex(&dvobjpriv->usb_vendor_req_mutex, NULL);
+	mutex_lock(&dvobjpriv->usb_vendor_req_mutex);
 
 	/*  Acquire IO memory for vendorreq */
 	pIo_buf = dvobjpriv->usb_vendor_req_buf;
@@ -92,7 +92,7 @@ static int usbctrl_vendorreq(struct intf_hdl *pintfhdl, u16 value, void *pdata,
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
index 8d0158f4a45d..6821dcdf1523 100644
--- a/drivers/staging/r8188eu/os_dep/os_intfs.c
+++ b/drivers/staging/r8188eu/os_dep/os_intfs.c
@@ -1062,9 +1062,9 @@ int netdev_open(struct net_device *pnetdev)
 	int ret;
 	struct adapter *padapter = (struct adapter *)rtw_netdev_priv(pnetdev);
 
-	_enter_critical_mutex(padapter->hw_init_mutex, NULL);
+	mutex_lock(padapter->hw_init_mutex);
 	ret = _netdev_open(pnetdev);
-	_exit_critical_mutex(padapter->hw_init_mutex, NULL);
+	mutex_unlock(padapter->hw_init_mutex);
 	return ret;
 }
 
-- 
2.32.0

