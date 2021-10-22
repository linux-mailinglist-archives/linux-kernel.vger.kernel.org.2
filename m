Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2E23C437BC2
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Oct 2021 19:19:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233818AbhJVRV5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 22 Oct 2021 13:21:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36828 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233563AbhJVRV4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Oct 2021 13:21:56 -0400
Received: from mail-ed1-x52d.google.com (mail-ed1-x52d.google.com [IPv6:2a00:1450:4864:20::52d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C3382C061764
        for <linux-kernel@vger.kernel.org>; Fri, 22 Oct 2021 10:19:38 -0700 (PDT)
Received: by mail-ed1-x52d.google.com with SMTP id e19so5676292edy.0
        for <linux-kernel@vger.kernel.org>; Fri, 22 Oct 2021 10:19:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=Fc2M2n/Ujvx3JC5y1BrKvmu6wHRj6aoeAosOblV9VJM=;
        b=IXVS0wkk+tc70BvFj8qo4HpjBaFtU+hpDI6eSbtzKsZn0LQaFZ0oaN381B/5zVZH7u
         MghqDZY8IlxAAm9Ys+HHyQhj91owXV7pfL87fXewgTAYq4u1LdqKq8lkOaZOYVbjLbXj
         2Lnuj9c1LRFv70pFzpWW0ut6TVoJMKzNQZlnJQACSk0rxckH1S7Gn2M2g9b79p/Fksm4
         2T1KKWpvfU5hWXY3rj3yKDuXXwIbZyaG2KzflGQwflWQGOn0Obah/FU9h98KiXhLc1+4
         Qleb9NXSjyWNlNhjBr3uDaVIoSOWVGdp5LHbMMZ3P7rG++Q4igloevGFBeNoSAJGSTD8
         qeuA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=Fc2M2n/Ujvx3JC5y1BrKvmu6wHRj6aoeAosOblV9VJM=;
        b=UEOolTsZl9cuZPl3jM0+lphNOYVSwvWFsUhFtw0COIT6h6VXDcRaV2fggb7dgMzoAu
         aP0WZgs9DoOLZLjYpTm6yqQlgH7myHRI4r5y2odlqLpQ+rnSF36FkyJsZay2tOGe1AAx
         Kv1BCZLY43b6yhO8/lxz9l8ExhiAHXP9SbxcIL6DfXdJsfN4C+CGEtC9e0BoYYLgnHWj
         3vVTICm/B4X3KBChBQpfFMBkDMhBEveadRTx7d3FQdlhLXQT+dWpUWcSaXL+DoyQRHIo
         M97+CmWGEs8ZpP7G/790ojzsAoQPFwDITcn9HQLDfAATC30ZYY0fVsEaHqNebf0M2f2N
         dz2g==
X-Gm-Message-State: AOAM533OiF7W7aCzdHqg5chSgWV9bBDgUK76n/vBWkEHhPFqUAaiZu/F
        qvso2DRPocHJK6Wbq3/4m10=
X-Google-Smtp-Source: ABdhPJz5V/REUPGOqVcWfrlMz3cTMrkpBfJzEqLpjTs+k7PbAGcRvB7vkyx9VHXhD5hH1LLb6sgYuQ==
X-Received: by 2002:a05:6402:34d0:: with SMTP id w16mr1658824edc.98.1634923177164;
        Fri, 22 Oct 2021 10:19:37 -0700 (PDT)
Received: from localhost.localdomain.it (host-80-181-148-119.pool80181.interbusiness.it. [80.181.148.119])
        by smtp.gmail.com with ESMTPSA id dd3sm3995446ejb.55.2021.10.22.10.19.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 22 Oct 2021 10:19:36 -0700 (PDT)
From:   "Fabio M. De Francesco" <fmdefrancesco@gmail.com>
To:     Larry Finger <Larry.Finger@lwfinger.net>,
        Phillip Potter <phil@philpotter.co.uk>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org
Cc:     "Fabio M. De Francesco" <fmdefrancesco@gmail.com>
Subject: [PATCH] staging: r8188eu: Use a Mutex instead of a binary Semaphore
Date:   Fri, 22 Oct 2021 19:19:17 +0200
Message-Id: <20211022171917.24363-1-fmdefrancesco@gmail.com>
X-Mailer: git-send-email 2.33.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Use a Mutex instead of a binary Semaphore for the purpose of enforcing
mutual exclusive access to the "pwrctrl_priv" structure.

Mutexes are sleeping locks similar to Semaphores with a 'count' of one
(like binary Semaphores), however they have a simpler interface, more
efficient performance, and additional constraints.

There is no change in the logic of the new code; however it is more
simple because it gets rid of four unnecessary wrappers:
_init_pwrlock(), _enter_pwrlock(),_exit_pwrlock(), _rtw_down_sema().

Actually, there is a change in the state in which the code waits for
acquiring locks, because it makes it in an uninterruptible state
(instead the old code used down_interruptibe()). Interruptible
waits are neither required nor wanted in this driver.

Tested with ASUSTek Computer, Inc. Realtek 8188EUS [USB-N10 Nano].

Signed-off-by: Fabio M. De Francesco <fmdefrancesco@gmail.com>
---
 drivers/staging/r8188eu/core/rtw_pwrctrl.c      | 10 +++++-----
 drivers/staging/r8188eu/include/osdep_service.h |  2 --
 drivers/staging/r8188eu/include/rtw_pwrctrl.h   | 17 +----------------
 drivers/staging/r8188eu/os_dep/osdep_service.c  |  8 --------
 drivers/staging/r8188eu/os_dep/usb_intf.c       |  8 ++++----
 5 files changed, 10 insertions(+), 35 deletions(-)

diff --git a/drivers/staging/r8188eu/core/rtw_pwrctrl.c b/drivers/staging/r8188eu/core/rtw_pwrctrl.c
index 19cac5814ea4..5d595cf2a47e 100644
--- a/drivers/staging/r8188eu/core/rtw_pwrctrl.c
+++ b/drivers/staging/r8188eu/core/rtw_pwrctrl.c
@@ -21,7 +21,7 @@ void ips_enter(struct adapter *padapter)
 		return;
 	}
 
-	_enter_pwrlock(&pwrpriv->lock);
+	mutex_lock(&pwrpriv->lock);
 
 	pwrpriv->bips_processing = true;
 
@@ -42,7 +42,7 @@ void ips_enter(struct adapter *padapter)
 	}
 	pwrpriv->bips_processing = false;
 
-	_exit_pwrlock(&pwrpriv->lock);
+	mutex_unlock(&pwrpriv->lock);
 }
 
 int ips_leave(struct adapter *padapter)
@@ -53,7 +53,7 @@ int ips_leave(struct adapter *padapter)
 	int result = _SUCCESS;
 	int keyid;
 
-	_enter_pwrlock(&pwrpriv->lock);
+	mutex_lock(&pwrpriv->lock);
 
 	if ((pwrpriv->rf_pwrstate == rf_off) && (!pwrpriv->bips_processing)) {
 		pwrpriv->bips_processing = true;
@@ -87,7 +87,7 @@ int ips_leave(struct adapter *padapter)
 		pwrpriv->bpower_saving = false;
 	}
 
-	_exit_pwrlock(&pwrpriv->lock);
+	mutex_unlock(&pwrpriv->lock);
 
 	return result;
 }
@@ -337,7 +337,7 @@ void rtw_init_pwrctrl_priv(struct adapter *padapter)
 {
 	struct pwrctrl_priv *pwrctrlpriv = &padapter->pwrctrlpriv;
 
-	_init_pwrlock(&pwrctrlpriv->lock);
+	mutex_init(&pwrctrlpriv->lock);
 	pwrctrlpriv->rf_pwrstate = rf_on;
 	pwrctrlpriv->ips_enter_cnts = 0;
 	pwrctrlpriv->ips_leave_cnts = 0;
diff --git a/drivers/staging/r8188eu/include/osdep_service.h b/drivers/staging/r8188eu/include/osdep_service.h
index 886a1b6f30b4..efab3a97eb46 100644
--- a/drivers/staging/r8188eu/include/osdep_service.h
+++ b/drivers/staging/r8188eu/include/osdep_service.h
@@ -141,8 +141,6 @@ extern unsigned char RSN_TKIP_CIPHER[4];
 
 void *rtw_malloc2d(int h, int w, int size);
 
-u32  _rtw_down_sema(struct semaphore *sema);
-
 #define rtw_init_queue(q)					\
 	do {							\
 		INIT_LIST_HEAD(&((q)->queue));			\
diff --git a/drivers/staging/r8188eu/include/rtw_pwrctrl.h b/drivers/staging/r8188eu/include/rtw_pwrctrl.h
index 04236e42fbf9..b19ef796ab54 100644
--- a/drivers/staging/r8188eu/include/rtw_pwrctrl.h
+++ b/drivers/staging/r8188eu/include/rtw_pwrctrl.h
@@ -27,21 +27,6 @@ enum power_mgnt {
 	PS_MODE_NUM
 };
 
-static inline void _init_pwrlock(struct semaphore  *plock)
-{
-	sema_init(plock, 1);
-}
-
-static inline void _enter_pwrlock(struct semaphore  *plock)
-{
-	_rtw_down_sema(plock);
-}
-
-static inline void _exit_pwrlock(struct semaphore  *plock)
-{
-	up(plock);
-}
-
 #define LPS_DELAY_TIME	1*HZ /*  1 sec */
 
 /*  RF state. */
@@ -60,7 +45,7 @@ enum { /*  for ips_mode */
 };
 
 struct pwrctrl_priv {
-	struct semaphore lock;
+	struct mutex lock; /* Mutex used to protect struct pwrctrl_priv */
 
 	u8	pwr_mode;
 	u8	smart_ps;
diff --git a/drivers/staging/r8188eu/os_dep/osdep_service.c b/drivers/staging/r8188eu/os_dep/osdep_service.c
index 6bee194fc35d..59bdd0abea7e 100644
--- a/drivers/staging/r8188eu/os_dep/osdep_service.c
+++ b/drivers/staging/r8188eu/os_dep/osdep_service.c
@@ -42,14 +42,6 @@ Otherwise, there will be racing condition.
 Caller must check if the list is empty before calling rtw_list_delete
 */
 
-u32 _rtw_down_sema(struct semaphore *sema)
-{
-	if (down_interruptible(sema))
-		return _FAIL;
-	else
-		return _SUCCESS;
-}
-
 inline u32 rtw_systime_to_ms(u32 systime)
 {
 	return systime * 1000 / HZ;
diff --git a/drivers/staging/r8188eu/os_dep/usb_intf.c b/drivers/staging/r8188eu/os_dep/usb_intf.c
index 7ed9f5f54472..fc74c93272a8 100644
--- a/drivers/staging/r8188eu/os_dep/usb_intf.c
+++ b/drivers/staging/r8188eu/os_dep/usb_intf.c
@@ -233,7 +233,7 @@ static int rtw_suspend(struct usb_interface *pusb_intf, pm_message_t message)
 	rtw_cancel_all_timer(padapter);
 	LeaveAllPowerSaveMode(padapter);
 
-	_enter_pwrlock(&pwrpriv->lock);
+	mutex_lock(&pwrpriv->lock);
 	/* s1. */
 	if (pnetdev) {
 		netif_carrier_off(pnetdev);
@@ -262,7 +262,7 @@ static int rtw_suspend(struct usb_interface *pusb_intf, pm_message_t message)
 	rtw_free_network_queue(padapter, true);
 
 	rtw_dev_unload(padapter);
-	_exit_pwrlock(&pwrpriv->lock);
+	mutex_unlock(&pwrpriv->lock);
 
 	if (check_fwstate(pmlmepriv, _FW_UNDER_SURVEY))
 		rtw_indicate_scan_done(padapter, 1);
@@ -291,7 +291,7 @@ static int rtw_resume(struct usb_interface *pusb_intf)
 	pnetdev = padapter->pnetdev;
 	pwrpriv = &padapter->pwrctrlpriv;
 
-	_enter_pwrlock(&pwrpriv->lock);
+	mutex_lock(&pwrpriv->lock);
 	rtw_reset_drv_sw(padapter);
 	if (pwrpriv)
 		pwrpriv->bkeepfwalive = false;
@@ -303,7 +303,7 @@ static int rtw_resume(struct usb_interface *pusb_intf)
 	netif_device_attach(pnetdev);
 	netif_carrier_on(pnetdev);
 
-	_exit_pwrlock(&pwrpriv->lock);
+	mutex_unlock(&pwrpriv->lock);
 
 	if (padapter->pid[1] != 0) {
 		DBG_88E("pid[1]:%d\n", padapter->pid[1]);
-- 
2.33.1

