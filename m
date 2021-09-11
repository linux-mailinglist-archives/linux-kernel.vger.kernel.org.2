Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 57A984078BD
	for <lists+linux-kernel@lfdr.de>; Sat, 11 Sep 2021 16:17:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236481AbhIKORb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 11 Sep 2021 10:17:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60818 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236254AbhIKORV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 11 Sep 2021 10:17:21 -0400
Received: from viti.kaiser.cx (viti.kaiser.cx [IPv6:2a01:238:43fe:e600:cd0c:bd4a:7a3:8e9f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 212D4C061574
        for <linux-kernel@vger.kernel.org>; Sat, 11 Sep 2021 07:16:09 -0700 (PDT)
Received: from dslb-084-059-243-091.084.059.pools.vodafone-ip.de ([84.59.243.91] helo=martin-debian-2.paytec.ch)
        by viti.kaiser.cx with esmtpsa (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.89)
        (envelope-from <martin@kaiser.cx>)
        id 1mP3nZ-0006bt-Eo; Sat, 11 Sep 2021 16:16:05 +0200
From:   Martin Kaiser <martin@kaiser.cx>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Larry Finger <Larry.Finger@lwfinger.net>,
        Phillip Potter <phil@philpotter.co.uk>,
        Michael Straube <straube.linux@gmail.com>,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org,
        Martin Kaiser <martin@kaiser.cx>
Subject: [PATCH 08/12] staging: r8188eu: remove unused pwrctrl definitions
Date:   Sat, 11 Sep 2021 16:15:17 +0200
Message-Id: <20210911141521.24901-9-martin@kaiser.cx>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20210911141521.24901-1-martin@kaiser.cx>
References: <20210911141521.24901-1-martin@kaiser.cx>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Remove a bunch of unused defines and macros and an unused struct
from rtw_pwrctrl.h.

Signed-off-by: Martin Kaiser <martin@kaiser.cx>
---
 drivers/staging/r8188eu/include/rtw_pwrctrl.h | 44 -------------------
 1 file changed, 44 deletions(-)

diff --git a/drivers/staging/r8188eu/include/rtw_pwrctrl.h b/drivers/staging/r8188eu/include/rtw_pwrctrl.h
index d89a11062fea..97102c1ec553 100644
--- a/drivers/staging/r8188eu/include/rtw_pwrctrl.h
+++ b/drivers/staging/r8188eu/include/rtw_pwrctrl.h
@@ -7,18 +7,6 @@
 #include "osdep_service.h"
 #include "drv_types.h"
 
-#define FW_PWR0		0
-#define FW_PWR1		1
-#define FW_PWR2		2
-#define FW_PWR3		3
-#define HW_PWR0		7
-#define HW_PWR1		6
-#define HW_PWR2		2
-#define HW_PWR3		0
-#define HW_PWR4		8
-
-#define FW_PWRMSK	0x7
-
 #define XMIT_ALIVE	BIT(0)
 #define RECV_ALIVE	BIT(1)
 #define CMD_ALIVE	BIT(2)
@@ -39,12 +27,6 @@ enum power_mgnt {
 	PS_MODE_NUM
 };
 
-struct reportpwrstate_parm {
-	unsigned char mode;
-	unsigned char state; /* the CPWM value */
-	unsigned short rsvd;
-};
-
 static inline void _init_pwrlock(struct semaphore  *plock)
 {
 	sema_init(plock, 1);
@@ -62,10 +44,6 @@ static inline void _exit_pwrlock(struct semaphore  *plock)
 
 #define LPS_DELAY_TIME	1*HZ /*  1 sec */
 
-#define EXE_PWR_NONE	0x01
-#define EXE_PWR_IPS		0x02
-#define EXE_PWR_LPS		0x04
-
 /*  RF state. */
 enum rt_rf_power_state {
 	rf_on,		/*  RF is on after RFSleep or RFOff */
@@ -75,26 +53,6 @@ enum rt_rf_power_state {
 	rf_max
 };
 
-/*  RF Off Level for IPS or HW/SW radio off */
-#define	RT_RF_OFF_LEVL_ASPM		BIT(0)	/* PCI ASPM */
-#define	RT_RF_OFF_LEVL_CLK_REQ		BIT(1)	/* PCI clock request */
-#define	RT_RF_OFF_LEVL_PCI_D3		BIT(2)	/* PCI D3 mode */
-#define	RT_RF_OFF_LEVL_HALT_NIC		BIT(3)	/* NIC halt, re-init hw param*/
-#define	RT_RF_OFF_LEVL_FREE_FW		BIT(4)	/* FW free, re-download the FW*/
-#define	RT_RF_OFF_LEVL_FW_32K		BIT(5)	/* FW in 32k */
-#define	RT_RF_PS_LEVEL_ALWAYS_ASPM	BIT(6)	/* Always enable ASPM and Clock
-						 * Req in initialization. */
-#define	RT_RF_LPS_DISALBE_2R		BIT(30)	/* When LPS is on, disable 2R
-						 * if no packet is RX or TX. */
-#define	RT_RF_LPS_LEVEL_ASPM		BIT(31)	/* LPS with ASPM */
-
-#define	RT_IN_PS_LEVEL(ppsc, _PS_FLAG)				\
-	((ppsc->cur_ps_level & _PS_FLAG) ? true : false)
-#define	RT_CLEAR_PS_LEVEL(ppsc, _PS_FLAG)			\
-	(ppsc->cur_ps_level &= (~(_PS_FLAG)))
-#define	RT_SET_PS_LEVEL(ppsc, _PS_FLAG)				\
-	(ppsc->cur_ps_level |= _PS_FLAG)
-
 enum _PS_BBRegBackup_ {
 	PSBBREG_RF0 = 0,
 	PSBBREG_RF1,
@@ -210,8 +168,6 @@ int _rtw_pwr_wakeup(struct adapter *adapter, u32 ips_defer_ms,
 		    const char *caller);
 #define rtw_pwr_wakeup(adapter)						\
 	 _rtw_pwr_wakeup(adapter, RTW_PWR_STATE_CHK_INTERVAL, __func__)
-#define rtw_pwr_wakeup_ex(adapter, ips_deffer_ms)			\
-	 _rtw_pwr_wakeup(adapter, ips_deffer_ms, __func__)
 int rtw_pm_set_ips(struct adapter *adapter, u8 mode);
 int rtw_pm_set_lps(struct adapter *adapter, u8 mode);
 
-- 
2.20.1

