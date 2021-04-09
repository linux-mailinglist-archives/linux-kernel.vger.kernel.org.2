Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3C08935943B
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Apr 2021 06:58:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229987AbhDIE5u (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 9 Apr 2021 00:57:50 -0400
Received: from szxga06-in.huawei.com ([45.249.212.32]:16426 "EHLO
        szxga06-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229526AbhDIE5o (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Apr 2021 00:57:44 -0400
Received: from DGGEMS407-HUB.china.huawei.com (unknown [172.30.72.60])
        by szxga06-in.huawei.com (SkyGuard) with ESMTP id 4FGm6Q0PZ2zlWqH;
        Fri,  9 Apr 2021 12:55:42 +0800 (CST)
Received: from ubuntu1804.huawei.com (10.67.174.98) by
 DGGEMS407-HUB.china.huawei.com (10.3.19.207) with Microsoft SMTP Server id
 14.3.498.0; Fri, 9 Apr 2021 12:57:23 +0800
From:   Pu Lehui <pulehui@huawei.com>
To:     <gregkh@linuxfoundation.org>, <fabioaiuto83@gmail.com>,
        <ross.schm.dev@gmail.com>, <marcocesati@gmail.com>
CC:     <linux-staging@lists.linux.dev>, <linux-kernel@vger.kernel.org>,
        <pulehui@huawei.com>
Subject: [PATCH -next] staging: rtl8723bs: remove unused variable pwrctl
Date:   Fri, 9 Apr 2021 12:57:28 +0800
Message-ID: <20210409045728.125852-1-pulehui@huawei.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.67.174.98]
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

GCC reports the following warning with W=1:

drivers/staging/rtl8723bs/hal/rtl8723b_cmd.c:532:23: warning:
 variable 'pwrctl' set but not used [-Wunused-but-set-variable]
   532 |  struct pwrctrl_priv *pwrctl;
       |                       ^~~~~~

This variable is not used so remove it to fix the warning.

Signed-off-by: Pu Lehui <pulehui@huawei.com>
---
 drivers/staging/rtl8723bs/hal/rtl8723b_cmd.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/drivers/staging/rtl8723bs/hal/rtl8723b_cmd.c b/drivers/staging/rtl8723bs/hal/rtl8723b_cmd.c
index f2ab878babcb..f8c6028f89f3 100644
--- a/drivers/staging/rtl8723bs/hal/rtl8723b_cmd.c
+++ b/drivers/staging/rtl8723bs/hal/rtl8723b_cmd.c
@@ -529,7 +529,6 @@ static void rtl8723b_set_FwRsvdPagePkt(
 	struct xmit_priv *pxmitpriv;
 	struct mlme_ext_priv *pmlmeext;
 	struct mlme_ext_info *pmlmeinfo;
-	struct pwrctrl_priv *pwrctl;
 	struct mlme_priv *pmlmepriv = &padapter->mlmepriv;
 	u32 BeaconLength = 0, PSPollLength = 0;
 	u32 NullDataLength = 0, QosNullLength = 0, BTQosNullLength = 0;
@@ -544,7 +543,6 @@ static void rtl8723b_set_FwRsvdPagePkt(
 	pxmitpriv = &padapter->xmitpriv;
 	pmlmeext = &padapter->mlmeextpriv;
 	pmlmeinfo = &pmlmeext->mlmext_info;
-	pwrctl = adapter_to_pwrctl(padapter);
 
 	RsvdPageNum = BCNQ_PAGE_NUM_8723B + WOWLAN_PAGE_NUM_8723B;
 	MaxRsvdPageBufSize = RsvdPageNum*PageSize;
-- 
2.17.1

