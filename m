Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 368E6348B61
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Mar 2021 09:17:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229944AbhCYIRT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 25 Mar 2021 04:17:19 -0400
Received: from szxga05-in.huawei.com ([45.249.212.191]:14471 "EHLO
        szxga05-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229744AbhCYIQ5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Mar 2021 04:16:57 -0400
Received: from DGGEMS411-HUB.china.huawei.com (unknown [172.30.72.59])
        by szxga05-in.huawei.com (SkyGuard) with ESMTP id 4F5dFB67lZzwQNl;
        Thu, 25 Mar 2021 16:14:54 +0800 (CST)
Received: from huawei.com (10.175.104.82) by DGGEMS411-HUB.china.huawei.com
 (10.3.19.211) with Microsoft SMTP Server id 14.3.498.0; Thu, 25 Mar 2021
 16:16:47 +0800
From:   Xu Jia <xujia39@huawei.com>
To:     <gregkh@linuxfoundation.org>, <ross.schm.dev@gmail.com>
CC:     <linux-kernel@vger.kernel.org>, <linux-staging@lists.linux.dev>,
        <hulkcommits@huawei.com>
Subject: [PATCH -next] staging: rtl8723bs: core: fix error return
Date:   Thu, 25 Mar 2021 16:30:41 +0800
Message-ID: <20210325083041.1881347-1-xujia39@huawei.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.175.104.82]
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Function rtw_init_bcmc_stainfo() is always return success.
Variable 'ret' set but not used.

Reported-by: Hulk Robot <hulkci@huawei.com>
Signed-off-by: Xu Jia <xujia39@huawei.com>
---
 drivers/staging/rtl8723bs/core/rtw_sta_mgt.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/staging/rtl8723bs/core/rtw_sta_mgt.c b/drivers/staging/rtl8723bs/core/rtw_sta_mgt.c
index f96dd0b40e04..7b578192adf5 100644
--- a/drivers/staging/rtl8723bs/core/rtw_sta_mgt.c
+++ b/drivers/staging/rtl8723bs/core/rtw_sta_mgt.c
@@ -551,7 +551,7 @@ u32 rtw_init_bcmc_stainfo(struct adapter *padapter)
 	psta->mac_id = 1;
 
 exit:
-	return _SUCCESS;
+	return res;
 }
 
 struct sta_info *rtw_get_bcmc_stainfo(struct adapter *padapter)
-- 
2.25.1

