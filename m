Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1841634FD1E
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Mar 2021 11:41:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234742AbhCaJkX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 31 Mar 2021 05:40:23 -0400
Received: from szxga04-in.huawei.com ([45.249.212.190]:15123 "EHLO
        szxga04-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234720AbhCaJkM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 31 Mar 2021 05:40:12 -0400
Received: from DGGEMS410-HUB.china.huawei.com (unknown [172.30.72.59])
        by szxga04-in.huawei.com (SkyGuard) with ESMTP id 4F9LpP0tcWz1BFv9;
        Wed, 31 Mar 2021 17:38:05 +0800 (CST)
Received: from huawei.com (10.175.103.91) by DGGEMS410-HUB.china.huawei.com
 (10.3.19.210) with Microsoft SMTP Server id 14.3.498.0; Wed, 31 Mar 2021
 17:40:08 +0800
From:   Yang Yingliang <yangyingliang@huawei.com>
To:     <linux-kernel@vger.kernel.org>, <linux-staging@lists.linux.dev>
CC:     <gregkh@linuxfoundation.org>
Subject: [PATCH -next] staging: rtl8723bs: os_dep: remove unused variable 'ret'
Date:   Wed, 31 Mar 2021 17:42:47 +0800
Message-ID: <20210331094247.2169606-1-yangyingliang@huawei.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.175.103.91]
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

GCC reports the following warning with W=1:

drivers/staging/rtl8723bs/os_dep/recv_linux.c:101:6: warning:
 variable ‘ret’ set but not used [-Wunused-but-set-variable]
  101 |  int ret;
      |      ^~~

This variable is not used in function , this commit
remove it to fix the warning.

Fixes: de69e2b3f105 ("staging: rtl8723bs: remove DBG_COUNTER calls from os_dep/recv_linux.c")
Reported-by: Hulk Robot <hulkci@huawei.com>
Signed-off-by: Yang Yingliang <yangyingliang@huawei.com>
---
 drivers/staging/rtl8723bs/os_dep/recv_linux.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/staging/rtl8723bs/os_dep/recv_linux.c b/drivers/staging/rtl8723bs/os_dep/recv_linux.c
index fbdbcd04d44a..f6a9482be8e3 100644
--- a/drivers/staging/rtl8723bs/os_dep/recv_linux.c
+++ b/drivers/staging/rtl8723bs/os_dep/recv_linux.c
@@ -98,7 +98,6 @@ struct sk_buff *rtw_os_alloc_msdu_pkt(union recv_frame *prframe, u16 nSubframe_L
 void rtw_os_recv_indicate_pkt(struct adapter *padapter, struct sk_buff *pkt, struct rx_pkt_attrib *pattrib)
 {
 	struct mlme_priv *pmlmepriv = &padapter->mlmepriv;
-	int ret;
 
 	/* Indicate the packets to upper layer */
 	if (pkt) {
@@ -140,7 +139,7 @@ void rtw_os_recv_indicate_pkt(struct adapter *padapter, struct sk_buff *pkt, str
 
 		pkt->ip_summed = CHECKSUM_NONE;
 
-		ret = rtw_netif_rx(padapter->pnetdev, pkt);
+		rtw_netif_rx(padapter->pnetdev, pkt);
 	}
 }
 
-- 
2.25.1

