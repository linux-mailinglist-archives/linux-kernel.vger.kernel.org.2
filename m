Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2008C3F22D5
	for <lists+linux-kernel@lfdr.de>; Fri, 20 Aug 2021 00:13:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236105AbhHSWNb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 19 Aug 2021 18:13:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38414 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235805AbhHSWNX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Aug 2021 18:13:23 -0400
Received: from mail-wr1-x432.google.com (mail-wr1-x432.google.com [IPv6:2a00:1450:4864:20::432])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 18E1CC061575
        for <linux-kernel@vger.kernel.org>; Thu, 19 Aug 2021 15:12:47 -0700 (PDT)
Received: by mail-wr1-x432.google.com with SMTP id x10so11197245wrt.8
        for <linux-kernel@vger.kernel.org>; Thu, 19 Aug 2021 15:12:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=bfM84zXCOdXc1+Lkek74AkG2TwziRP5G2VD2oktI7qs=;
        b=kQ5tvTivSmwyos+c1R04f8IceSoo5ROepdwGpAf2Aa5vzbh7dR0jKWmII1uZFIoc5P
         yC/HIBjarmXkvUUwLjHLzkChhmUDClAFhCU7VPEZTW9fLWq0z3aHKUgeGpHDWXijG1w3
         G/Mq+E+X9tf+iHOZann60QZMUhAhqsOmJI0melV1Jl20h8Atga1Vld07RVWbMW2AAfXC
         ftpgXdkc98YlPnpzB2Cjzdx7as62wxSXzjC5aXRhTEsclpVVThbVMeSWHHAlY7EZutB4
         Gy0L+6fqKwZJ3pn078DgkrZvfkOQ9MgAf7iLD+zeKdzvRCY/1QzpsqhWkvjzXpCGX+tm
         JBGw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=bfM84zXCOdXc1+Lkek74AkG2TwziRP5G2VD2oktI7qs=;
        b=VGoafkx3m+HTPjpXLDp/iJvMSEWVZpusgCK3ijyqF16WovBJr6ARvUvjpSHCVwqxmd
         xP4uCX1dmpbeIU0aNMf01HHSgQz55VwNDxQHTzdKLsJiJ6fbYiZ8aRRkaKH8yV8yyu70
         Hms1VDYwHccDgMwpK4tjoGPi4GOzoFGivqNhD+qyclZ8dXs6IHRJgppP1tHAcFRMKCEh
         zY0SV0+4/TdrZJ0hKq/l//JI9Byt/1YMbAvN8UqVsCvFVDr/QRie2TiNtXGJuPkIx3J7
         41wnOzxpp4pHRLyMwxiqE//uudmxNyN+3n/MsIbvzivZE9csgBE+eFhKoKVqquCUC8LS
         CtbQ==
X-Gm-Message-State: AOAM532hYVkNjvAYhdH317aiFVkorAhaVmTZmNkAQLkFnT86iMQ8z1b5
        56/MUT1RcfZSLQof4ZhSaak=
X-Google-Smtp-Source: ABdhPJyGQj9TuVNW2MhpgZDELqTataXm/YjC+6uXV9P7uGeZaKXx6VswYkt7Oj7RACtpcW6LuPL4UQ==
X-Received: by 2002:adf:a309:: with SMTP id c9mr6215218wrb.99.1629411165684;
        Thu, 19 Aug 2021 15:12:45 -0700 (PDT)
Received: from localhost.localdomain (host-79-22-100-164.retail.telecomitalia.it. [79.22.100.164])
        by smtp.gmail.com with ESMTPSA id v12sm4168833wrq.59.2021.08.19.15.12.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 19 Aug 2021 15:12:45 -0700 (PDT)
From:   "Fabio M. De Francesco" <fmdefrancesco@gmail.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Larry Finger <Larry.Finger@lwfinger.net>,
        Phillip Potter <phil@philpotter.co.uk>,
        Martin Kaiser <martin@kaiser.cx>,
        Michael Straube <straube.linux@gmail.com>,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org
Cc:     "Fabio M. De Francesco" <fmdefrancesco@gmail.com>
Subject: [PATCH v3] staging: r8188eu: Remove _enter/_exit_critical_mutex()
Date:   Fri, 20 Aug 2021 00:12:41 +0200
Message-Id: <20210819221241.31987-1-fmdefrancesco@gmail.com>
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

Signed-off-by: Fabio M. De Francesco <fmdefrancesco@gmail.com>
---

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
index 5325fe41fbee..873b54c1715f 100644
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
index 953fa05dc30c..a93d5cfe4635 100644
--- a/drivers/staging/r8188eu/hal/usb_ops_linux.c
+++ b/drivers/staging/r8188eu/hal/usb_ops_linux.c
@@ -32,7 +32,7 @@ static int usbctrl_vendorreq(struct intf_hdl *pintfhdl, u16 value, void *pdata,
 		goto exit;
 	}
 
-	_enter_critical_mutex(&dvobjpriv->usb_vendor_req_mutex, NULL);
+	mutex_lock(&dvobjpriv->usb_vendor_req_mutex);
 
 	/*  Acquire IO memory for vendorreq */
 	pIo_buf = dvobjpriv->usb_vendor_req_buf;
@@ -96,7 +96,7 @@ static int usbctrl_vendorreq(struct intf_hdl *pintfhdl, u16 value, void *pdata,
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
index 1aa65925e1da..e675e4e9550e 100644
--- a/drivers/staging/r8188eu/os_dep/os_intfs.c
+++ b/drivers/staging/r8188eu/os_dep/os_intfs.c
@@ -1065,9 +1065,9 @@ int netdev_open(struct net_device *pnetdev)
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

