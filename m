Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EB88C40203C
	for <lists+linux-kernel@lfdr.de>; Mon,  6 Sep 2021 21:07:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244995AbhIFTGQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 6 Sep 2021 15:06:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38542 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1343618AbhIFTER (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Sep 2021 15:04:17 -0400
Received: from mail-ej1-x62c.google.com (mail-ej1-x62c.google.com [IPv6:2a00:1450:4864:20::62c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BF760C0617AF
        for <linux-kernel@vger.kernel.org>; Mon,  6 Sep 2021 12:03:11 -0700 (PDT)
Received: by mail-ej1-x62c.google.com with SMTP id t19so15108071ejr.8
        for <linux-kernel@vger.kernel.org>; Mon, 06 Sep 2021 12:03:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=qKuqjYia3ho1J2eduvi6cGeST2WqpIrutveIryjYm4Y=;
        b=XC1BGzMP3Kvpx3LssWGvEu/CSVQrBvsuOu7QyXhEqaifsT8vzmg24DKWowZtwY+0X+
         ZLU4WD0TwuvStZpJ+l4uxDQO3iP5LwcN0CiDkvmB3At+Bo/m23kypsmklw97rRLW0K0Z
         J5f3aqQuO/YX1T+CwDnNcDHUcLJcgh3Cg8XJ6pk2y3qwIjX3OLkdw4379dkcAKvxWuXG
         znzSQ3kppLmy95kyJm06S29vYimj/kowFYcM5Cd2VOX4lJBC6rHILIL7t/hvi8GOEXxv
         6FGH0IUQCXC2m+SHmaZWCoxu8Qvfc5nbfgT/sHXqxeA5MvbDah7vBnVy9kKOxCmsv331
         spjw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=qKuqjYia3ho1J2eduvi6cGeST2WqpIrutveIryjYm4Y=;
        b=PNGIcIxh+9YNQrB7uOeJLBTMce3aklZtHmuOkQoN47kERlqBQ9aGHA8P1UJjvmr9oV
         bVtpBjOoTTsjKaMx0WBTCB2/AkvLWLZYQW/6J+9RmmS6LHemznMdcYwsPVSE6vPdzB49
         XMRwXfdRllrhn1SuZ8m73TYx5aBLdpFQdTylV6xQ0GtzBurb0ixWaSld9gOdYqOvdsU7
         6fS9AsORNaio+aeyJh1cCrgQVmIao/HvbIZ46BSl29+xNJOsQWDFvXY74vrSrt0PT3Gb
         6Is3pk7LCPW0XK1E9BSYU8ZM13unebLMF2XLu0jNGYiASDJn+TbBY9TJY8DDToK++R+7
         ZJNg==
X-Gm-Message-State: AOAM5335TTCD0bnK3Wnr6YZrLzzWSM+ICwf/aGL5BSq4kt20CBPuYV8B
        iKcw1XjV6LVPbYSNnnE0Yto=
X-Google-Smtp-Source: ABdhPJwYLXqMibos69iUBgEWzCJf45tbSV0KkvVZrNUusuxiHTNj7Q/tf7RbTF9+TquA2lv4J/+SWQ==
X-Received: by 2002:a17:906:700f:: with SMTP id n15mr15029778ejj.319.1630954990365;
        Mon, 06 Sep 2021 12:03:10 -0700 (PDT)
Received: from localhost.localdomain ([2a02:8108:96c0:3b88::8fe1])
        by smtp.gmail.com with ESMTPSA id k15sm4372018ejb.92.2021.09.06.12.03.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 06 Sep 2021 12:03:10 -0700 (PDT)
From:   Michael Straube <straube.linux@gmail.com>
To:     gregkh@linuxfoundation.org
Cc:     Larry.Finger@lwfinger.net, phil@philpotter.co.uk, martin@kaiser.cx,
        fmdefrancesco@gmail.com, linux-staging@lists.linux.dev,
        linux-kernel@vger.kernel.org,
        Michael Straube <straube.linux@gmail.com>
Subject: [PATCH v3 34/40] staging: r8188eu: remove empty function rtl8188e_start_thread()
Date:   Mon,  6 Sep 2021 21:02:17 +0200
Message-Id: <20210906190223.11396-35-straube.linux@gmail.com>
X-Mailer: git-send-email 2.33.0
In-Reply-To: <20210906190223.11396-1-straube.linux@gmail.com>
References: <20210906190223.11396-1-straube.linux@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Remove empty function rtl8188e_start_thread() and related code.

Signed-off-by: Michael Straube <straube.linux@gmail.com>
---
 drivers/staging/r8188eu/hal/hal_intf.c          | 7 -------
 drivers/staging/r8188eu/hal/rtl8188e_hal_init.c | 5 -----
 drivers/staging/r8188eu/include/hal_intf.h      | 2 --
 drivers/staging/r8188eu/include/rtl8188e_hal.h  | 1 -
 drivers/staging/r8188eu/os_dep/os_intfs.c       | 1 -
 5 files changed, 16 deletions(-)

diff --git a/drivers/staging/r8188eu/hal/hal_intf.c b/drivers/staging/r8188eu/hal/hal_intf.c
index e723742dab51..3ea581fb2c7e 100644
--- a/drivers/staging/r8188eu/hal/hal_intf.c
+++ b/drivers/staging/r8188eu/hal/hal_intf.c
@@ -151,13 +151,6 @@ void rtw_hal_update_ra_mask(struct adapter *adapt, u32 mac_id, u8 rssi_level)
 	}
 }
 
-/*	Start specifical interface thread		*/
-void rtw_hal_start_thread(struct adapter *adapt)
-{
-	if (adapt->HalFunc.run_thread)
-		adapt->HalFunc.run_thread(adapt);
-}
-
 /*	Start specifical interface thread		*/
 void rtw_hal_stop_thread(struct adapter *adapt)
 {
diff --git a/drivers/staging/r8188eu/hal/rtl8188e_hal_init.c b/drivers/staging/r8188eu/hal/rtl8188e_hal_init.c
index 84449d8111c0..fc420cbec5de 100644
--- a/drivers/staging/r8188eu/hal/rtl8188e_hal_init.c
+++ b/drivers/staging/r8188eu/hal/rtl8188e_hal_init.c
@@ -1748,10 +1748,6 @@ void rtl8188e_clone_haldata(struct adapter *dst_adapter, struct adapter *src_ada
 	memcpy(dst_adapter->HalData, src_adapter->HalData, dst_adapter->hal_data_sz);
 }
 
-void rtl8188e_start_thread(struct adapter *padapter)
-{
-}
-
 void rtl8188e_stop_thread(struct adapter *padapter)
 {
 }
@@ -1770,7 +1766,6 @@ void rtl8188e_set_hal_ops(struct hal_ops *pHalFunc)
 {
 	pHalFunc->free_hal_data = &rtl8188e_free_hal_data;
 
-	pHalFunc->run_thread = &rtl8188e_start_thread;
 	pHalFunc->cancel_thread = &rtl8188e_stop_thread;
 
 	pHalFunc->read_bbreg = &rtl8188e_PHY_QueryBBReg;
diff --git a/drivers/staging/r8188eu/include/hal_intf.h b/drivers/staging/r8188eu/include/hal_intf.h
index 2c6a3d1f0077..caee83ed962d 100644
--- a/drivers/staging/r8188eu/include/hal_intf.h
+++ b/drivers/staging/r8188eu/include/hal_intf.h
@@ -153,7 +153,6 @@ struct hal_ops {
 				       u32 mac_id, u8 rssi_level);
 	void	(*SetBeaconRelatedRegistersHandler)(struct adapter *padapter);
 
-	void	(*run_thread)(struct adapter *adapter);
 	void	(*cancel_thread)(struct adapter *adapter);
 
 	s32	(*hal_xmit)(struct adapter *padapter,
@@ -237,7 +236,6 @@ void	rtw_hal_free_recv_priv(struct adapter *padapter);
 void rtw_hal_update_ra_mask(struct adapter *padapter, u32 mac_id, u8 level);
 void	rtw_hal_clone_data(struct adapter *dst_adapt,
 			   struct adapter *src_adapt);
-void	rtw_hal_start_thread(struct adapter *padapter);
 void	rtw_hal_stop_thread(struct adapter *padapter);
 
 void rtw_hal_bcn_related_reg_setting(struct adapter *padapter);
diff --git a/drivers/staging/r8188eu/include/rtl8188e_hal.h b/drivers/staging/r8188eu/include/rtl8188e_hal.h
index bb5620a9b17b..5947708594d2 100644
--- a/drivers/staging/r8188eu/include/rtl8188e_hal.h
+++ b/drivers/staging/r8188eu/include/rtl8188e_hal.h
@@ -439,7 +439,6 @@ void rtl8188e_set_hal_ops(struct hal_ops *pHalFunc);
 void rtl8188e_read_chip_version(struct adapter *padapter);
 
 void rtl8188e_clone_haldata(struct adapter *dst, struct adapter *src);
-void rtl8188e_start_thread(struct adapter *padapter);
 void rtl8188e_stop_thread(struct adapter *padapter);
 
 void rtw_IOL_cmd_tx_pkt_buf_dump(struct adapter  *Adapter, int len);
diff --git a/drivers/staging/r8188eu/os_dep/os_intfs.c b/drivers/staging/r8188eu/os_dep/os_intfs.c
index 28f6028d7335..c18f6a7237c7 100644
--- a/drivers/staging/r8188eu/os_dep/os_intfs.c
+++ b/drivers/staging/r8188eu/os_dep/os_intfs.c
@@ -733,7 +733,6 @@ u32 rtw_start_drv_threads(struct adapter *padapter)
 	else
 		_rtw_down_sema(&padapter->cmdpriv.terminate_cmdthread_sema); /* wait for cmd_thread to run */
 
-	rtw_hal_start_thread(padapter);
 	return _status;
 }
 
-- 
2.33.0

