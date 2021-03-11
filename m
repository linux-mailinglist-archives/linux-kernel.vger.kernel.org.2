Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6FA0F336C61
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Mar 2021 07:42:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230289AbhCKGmZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 11 Mar 2021 01:42:25 -0500
Received: from lucky1.263xmail.com ([211.157.147.131]:56386 "EHLO
        lucky1.263xmail.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230475AbhCKGmT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 11 Mar 2021 01:42:19 -0500
Received: from localhost (unknown [192.168.167.13])
        by lucky1.263xmail.com (Postfix) with ESMTP id 75780B9537;
        Thu, 11 Mar 2021 14:42:17 +0800 (CST)
X-MAIL-GRAY: 0
X-MAIL-DELIVERY: 1
X-ADDR-CHECKED4: 1
X-ANTISPAM-LEVEL: 2
X-ABS-CHECKED: 0
Received: from localhost.localdomain (unknown [124.126.19.250])
        by smtp.263.net (postfix) whith ESMTP id P13096T140547930396416S1615444930647858_;
        Thu, 11 Mar 2021 14:42:17 +0800 (CST)
X-IP-DOMAINF: 1
X-UNIQUE-TAG: <d8c1f2d985e4f62e926dd6d185b2772d>
X-RL-SENDER: penghaob@uniontech.com
X-SENDER: penghaob@uniontech.com
X-LOGIN-NAME: penghaob@uniontech.com
X-FST-TO: gregkh@linuxfoundation.org
X-SENDER-IP: 124.126.19.250
X-ATTACHMENT-NUM: 0
X-System-Flag: 0
From:   Hao Peng <penghaob@uniontech.com>
To:     gregkh@linuxfoundation.org, ross.schm.dev@gmail.com,
        izabela.bakollari@gmail.com
Cc:     devel@driverdev.osuosl.org, linux-kernel@vger.kernel.org,
        Hao Peng <penghaob@uniontech.com>
Subject: [PATCH] staging: rtl8723bs: add initial value
Date:   Thu, 11 Mar 2021 14:38:38 +0800
Message-Id: <20210311063838.19756-1-penghaob@uniontech.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add initial value for some uninitialized variable and array.

Signed-off-by: Hao Peng <penghaob@uniontech.com>
---
 drivers/staging/rtl8723bs/core/rtw_ap.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/staging/rtl8723bs/core/rtw_ap.c b/drivers/staging/rtl8723bs/core/rtw_ap.c
index b6f944b37b08..ceea160db38a 100644
--- a/drivers/staging/rtl8723bs/core/rtw_ap.c
+++ b/drivers/staging/rtl8723bs/core/rtw_ap.c
@@ -206,8 +206,8 @@ void expire_timeout_chk(struct adapter *padapter)
 	struct sta_info *psta = NULL;
 	struct sta_priv *pstapriv = &padapter->stapriv;
 	u8 chk_alive_num = 0;
-	char chk_alive_list[NUM_STA];
-	int i;
+	char chk_alive_list[NUM_STA] = {0};
+	int i = 0;
 
 	spin_lock_bh(&pstapriv->auth_list_lock);
 
@@ -308,7 +308,7 @@ void expire_timeout_chk(struct adapter *padapter)
 				}
 			}
 			if (pmlmeext->active_keep_alive_check) {
-				int stainfo_offset;
+				int stainfo_offset = 0;
 
 				stainfo_offset = rtw_stainfo_offset(pstapriv, psta);
 				if (stainfo_offset_valid(stainfo_offset))
-- 
2.20.1



