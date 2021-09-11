Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D313E4078BC
	for <lists+linux-kernel@lfdr.de>; Sat, 11 Sep 2021 16:17:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236408AbhIKOR3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 11 Sep 2021 10:17:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60814 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236234AbhIKORV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 11 Sep 2021 10:17:21 -0400
Received: from viti.kaiser.cx (viti.kaiser.cx [IPv6:2a01:238:43fe:e600:cd0c:bd4a:7a3:8e9f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 646D1C061574
        for <linux-kernel@vger.kernel.org>; Sat, 11 Sep 2021 07:16:08 -0700 (PDT)
Received: from dslb-084-059-243-091.084.059.pools.vodafone-ip.de ([84.59.243.91] helo=martin-debian-2.paytec.ch)
        by viti.kaiser.cx with esmtpsa (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.89)
        (envelope-from <martin@kaiser.cx>)
        id 1mP3nY-0006bt-Hl; Sat, 11 Sep 2021 16:16:04 +0200
From:   Martin Kaiser <martin@kaiser.cx>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Larry Finger <Larry.Finger@lwfinger.net>,
        Phillip Potter <phil@philpotter.co.uk>,
        Michael Straube <straube.linux@gmail.com>,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org,
        Martin Kaiser <martin@kaiser.cx>
Subject: [PATCH 07/12] staging: r8188eu: _free_pwrlock is empty
Date:   Sat, 11 Sep 2021 16:15:16 +0200
Message-Id: <20210911141521.24901-8-martin@kaiser.cx>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20210911141521.24901-1-martin@kaiser.cx>
References: <20210911141521.24901-1-martin@kaiser.cx>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Remove the empty _free_pwrlock function and rtw_free_pwrctrl_priv,
which is just a wrapper around _free_pwrlock.

Signed-off-by: Martin Kaiser <martin@kaiser.cx>
---
 drivers/staging/r8188eu/core/rtw_pwrctrl.c    | 8 --------
 drivers/staging/r8188eu/include/rtw_pwrctrl.h | 4 ----
 drivers/staging/r8188eu/os_dep/os_intfs.c     | 2 --
 3 files changed, 14 deletions(-)

diff --git a/drivers/staging/r8188eu/core/rtw_pwrctrl.c b/drivers/staging/r8188eu/core/rtw_pwrctrl.c
index 5b4cd8e738db..0c4ca90a534f 100644
--- a/drivers/staging/r8188eu/core/rtw_pwrctrl.c
+++ b/drivers/staging/r8188eu/core/rtw_pwrctrl.c
@@ -391,14 +391,6 @@ void rtw_init_pwrctrl_priv(struct adapter *padapter)
 	timer_setup(&pwrctrlpriv->pwr_state_check_timer, pwr_state_check_handler, 0);
 }
 
-void rtw_free_pwrctrl_priv(struct adapter *adapter)
-{
-	struct pwrctrl_priv *pwrctrlpriv = &adapter->pwrctrlpriv;
-
-	_free_pwrlock(&pwrctrlpriv->lock);
-
-}
-
 inline void rtw_set_ips_deny(struct adapter *padapter, u32 ms)
 {
 	struct pwrctrl_priv *pwrpriv = &padapter->pwrctrlpriv;
diff --git a/drivers/staging/r8188eu/include/rtw_pwrctrl.h b/drivers/staging/r8188eu/include/rtw_pwrctrl.h
index bd05d1dfe77e..d89a11062fea 100644
--- a/drivers/staging/r8188eu/include/rtw_pwrctrl.h
+++ b/drivers/staging/r8188eu/include/rtw_pwrctrl.h
@@ -50,10 +50,6 @@ static inline void _init_pwrlock(struct semaphore  *plock)
 	sema_init(plock, 1);
 }
 
-static inline void _free_pwrlock(struct semaphore  *plock)
-{
-}
-
 static inline void _enter_pwrlock(struct semaphore  *plock)
 {
 	_rtw_down_sema(plock);
diff --git a/drivers/staging/r8188eu/os_dep/os_intfs.c b/drivers/staging/r8188eu/os_dep/os_intfs.c
index 306377fe8bfc..3367c7cfc033 100644
--- a/drivers/staging/r8188eu/os_dep/os_intfs.c
+++ b/drivers/staging/r8188eu/os_dep/os_intfs.c
@@ -933,8 +933,6 @@ u8 rtw_free_drv_sw(struct adapter *padapter)
 
 	_rtw_free_recv_priv(&padapter->recvpriv);
 
-	rtw_free_pwrctrl_priv(padapter);
-
 	rtl8188e_free_hal_data(padapter);
 
 	/* free the old_pnetdev */
-- 
2.20.1

