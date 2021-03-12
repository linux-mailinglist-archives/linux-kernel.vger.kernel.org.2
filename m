Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D039533830D
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Mar 2021 02:12:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230512AbhCLBLv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 11 Mar 2021 20:11:51 -0500
Received: from lucky1.263xmail.com ([211.157.147.134]:36770 "EHLO
        lucky1.263xmail.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229568AbhCLBLe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 11 Mar 2021 20:11:34 -0500
Received: from localhost (unknown [192.168.167.69])
        by lucky1.263xmail.com (Postfix) with ESMTP id EB479C79CA;
        Fri, 12 Mar 2021 09:11:32 +0800 (CST)
X-MAIL-GRAY: 0
X-MAIL-DELIVERY: 1
X-ADDR-CHECKED4: 1
X-ANTISPAM-LEVEL: 2
X-ABS-CHECKED: 0
Received: from localhost.localdomain (unknown [124.126.19.250])
        by smtp.263.net (postfix) whith ESMTP id P1823T139669744367360S1615511484459024_;
        Fri, 12 Mar 2021 09:11:32 +0800 (CST)
X-IP-DOMAINF: 1
X-UNIQUE-TAG: <b0014230ca93f0285aaf060214237e50>
X-RL-SENDER: penghaob@uniontech.com
X-SENDER: penghaob@uniontech.com
X-LOGIN-NAME: penghaob@uniontech.com
X-FST-TO: gregkh@linuxfoundation.org
X-SENDER-IP: 124.126.19.250
X-ATTACHMENT-NUM: 0
X-System-Flag: 0
From:   Hao Peng <penghaob@uniontech.com>
To:     gregkh@linuxfoundation.org, ross.schm.dev@gmail.com,
        izabela.bakollari@gmail.com, penghaob@uniontech.com
Cc:     devel@driverdev.osuosl.org, linux-kernel@vger.kernel.org
Subject: [PATCH] staging: rtl8723bs: remove extra lines
Date:   Fri, 12 Mar 2021 09:07:52 +0800
Message-Id: <20210312010752.27448-1-penghaob@uniontech.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Remove extra lines in many functions in hal_intf.c.

Signed-off-by: Hao Peng <penghaob@uniontech.com>
---
 drivers/staging/rtl8723bs/hal/hal_intf.c | 7 -------
 1 file changed, 7 deletions(-)

diff --git a/drivers/staging/rtl8723bs/hal/hal_intf.c b/drivers/staging/rtl8723bs/hal/hal_intf.c
index 9fb377633852..e74e9c0608ee 100644
--- a/drivers/staging/rtl8723bs/hal/hal_intf.c
+++ b/drivers/staging/rtl8723bs/hal/hal_intf.c
@@ -111,7 +111,6 @@ uint rtw_hal_init(struct adapter *padapter)
 	RT_TRACE(_module_hal_init_c_, _drv_err_, ("-rtl871x_hal_init:status = 0x%x\n", status));
 
 	return status;
-
 }
 
 uint rtw_hal_deinit(struct adapter *padapter)
@@ -180,7 +179,6 @@ void rtw_hal_enable_interrupt(struct adapter *padapter)
 		padapter->HalFunc.enable_interrupt(padapter);
 	else
 		DBG_871X("%s: HalFunc.enable_interrupt is NULL!\n", __func__);
-
 }
 
 void rtw_hal_disable_interrupt(struct adapter *padapter)
@@ -189,7 +187,6 @@ void rtw_hal_disable_interrupt(struct adapter *padapter)
 		padapter->HalFunc.disable_interrupt(padapter);
 	else
 		DBG_871X("%s: HalFunc.disable_interrupt is NULL!\n", __func__);
-
 }
 
 u8 rtw_hal_check_ips_status(struct adapter *padapter)
@@ -269,7 +266,6 @@ s32	rtw_hal_init_recv_priv(struct adapter *padapter)
 
 void rtw_hal_free_recv_priv(struct adapter *padapter)
 {
-
 	if (padapter->HalFunc.free_recv_priv)
 		padapter->HalFunc.free_recv_priv(padapter);
 }
@@ -358,7 +354,6 @@ void rtw_hal_dm_watchdog(struct adapter *padapter)
 {
 	if (padapter->HalFunc.hal_dm_watchdog)
 		padapter->HalFunc.hal_dm_watchdog(padapter);
-
 }
 
 void rtw_hal_dm_watchdog_in_lps(struct adapter *padapter)
@@ -422,7 +417,6 @@ s32 rtw_hal_macid_sleep(struct adapter *padapter, u32 macid)
 {
 	u8 support;
 
-
 	support = false;
 	rtw_hal_get_def_var(padapter, HAL_DEF_MACID_SLEEP, &support);
 	if (false == support)
@@ -437,7 +431,6 @@ s32 rtw_hal_macid_wakeup(struct adapter *padapter, u32 macid)
 {
 	u8 support;
 
-
 	support = false;
 	rtw_hal_get_def_var(padapter, HAL_DEF_MACID_SLEEP, &support);
 	if (false == support)
-- 
2.20.1



