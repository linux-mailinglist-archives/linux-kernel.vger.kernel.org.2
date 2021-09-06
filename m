Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7B36240200D
	for <lists+linux-kernel@lfdr.de>; Mon,  6 Sep 2021 20:58:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245213AbhIFS4w (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 6 Sep 2021 14:56:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36514 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245237AbhIFSze (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Sep 2021 14:55:34 -0400
Received: from mail-ej1-x62d.google.com (mail-ej1-x62d.google.com [IPv6:2a00:1450:4864:20::62d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E9AF2C0617AE
        for <linux-kernel@vger.kernel.org>; Mon,  6 Sep 2021 11:54:28 -0700 (PDT)
Received: by mail-ej1-x62d.google.com with SMTP id u14so15040268ejf.13
        for <linux-kernel@vger.kernel.org>; Mon, 06 Sep 2021 11:54:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=qKuqjYia3ho1J2eduvi6cGeST2WqpIrutveIryjYm4Y=;
        b=F+GYpImdXBhxPcJP4OjxlXqtF+JODMZXXSds2g8pE5KrfPUG7X0tAwSjlflhZPLSa4
         lVE/D4l/FvuCCvIZ07QQZhn+6TbyVAR66SVdeB1XzWgETKiaMtg+90ZE3dndd8zG+oYN
         oI74XrKulO0aM51s/zPmvh0/hUkgQPiWxHM74k0s8K7zLMZZaE+BGzPFwUdRb8By0W6A
         H32o5EWTjTlXYIwCmDP69WCL3knvzGJXgXhYbxdHTFsaBQJ9AP1OsOGSCd8b5tHpb77Z
         TheSdQqw9OT2TKF3puYyp89Qu+oXO4my+eZ8/l345/7rblM6u0ZAo3oFPSGAQWIOHlEK
         hfwQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=qKuqjYia3ho1J2eduvi6cGeST2WqpIrutveIryjYm4Y=;
        b=bUEa4r5dwt/GkYQ5DNMRlEdPpilGPu+jeg99APV8FjI0xX3Qk6yekBnexD3J+00Ihq
         7YBRifbGGBHD9YvBDZMD9CwCCXpSoVMLsMjTJk/ot75pufyfG84RAOl0N1vtcD6UpK0C
         GkmPDfmxG7nvbwB26r55aWcMqE8sQfZ25PmOaTSxp4d7Dpd64580efDBFFb0RQSKi0sl
         UrweJBVrNAHaKr6B0SZk+IELgK+bMrZcAFdbu6k55pCpj0kUGDc17FOOvZ6Uqri9xqre
         +dMrd9jeLQgj+aJuHUkN0RBWrHG7F3kFOt3uc1kNFUHvKJq2UBhI37TuhG8BxalVhdz/
         nf6A==
X-Gm-Message-State: AOAM533fshwNvapOm5IY9PFpwCz9Jvj1mcIruJwyNV5/Z5TpyYnuUvf+
        HqGLsYHvV2jQt1THkUAky40=
X-Google-Smtp-Source: ABdhPJz7HdW/s7B4uGGkec95nneb0qjtwZhuEg4JInEQ/4wW/j9LsGvKzLSIjBCgoJxZT/OhvGSQQA==
X-Received: by 2002:a17:906:914e:: with SMTP id y14mr15013976ejw.223.1630954467545;
        Mon, 06 Sep 2021 11:54:27 -0700 (PDT)
Received: from localhost.localdomain ([2a02:8108:96c0:3b88::8fe1])
        by smtp.gmail.com with ESMTPSA id kk2sm4329128ejc.114.2021.09.06.11.54.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 06 Sep 2021 11:54:27 -0700 (PDT)
From:   Michael Straube <straube.linux@gmail.com>
To:     gregkh@linuxfoundation.org
Cc:     Larry.Finger@lwfinger.net, phil@philpotter.co.uk, martin@kaiser.cx,
        fmdefrancesco@gmail.com, linux-staging@lists.linux.dev,
        linux-kernel@vger.kernel.org,
        Michael Straube <straube.linux@gmail.com>
Subject: [PATCH v2 34/40] staging: r8188eu: remove empty function rtl8188e_start_thread()
Date:   Mon,  6 Sep 2021 20:53:21 +0200
Message-Id: <20210906185327.10326-35-straube.linux@gmail.com>
X-Mailer: git-send-email 2.33.0
In-Reply-To: <20210906185327.10326-1-straube.linux@gmail.com>
References: <20210906185327.10326-1-straube.linux@gmail.com>
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

