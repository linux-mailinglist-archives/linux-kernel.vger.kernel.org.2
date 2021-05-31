Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E9E5F3960F0
	for <lists+linux-kernel@lfdr.de>; Mon, 31 May 2021 16:31:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233768AbhEaOde (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 31 May 2021 10:33:34 -0400
Received: from szxga01-in.huawei.com ([45.249.212.187]:2802 "EHLO
        szxga01-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233223AbhEaNy4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 31 May 2021 09:54:56 -0400
Received: from dggemv711-chm.china.huawei.com (unknown [172.30.72.53])
        by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4FtxTF6Q6ZzWpVJ;
        Mon, 31 May 2021 21:48:33 +0800 (CST)
Received: from dggema762-chm.china.huawei.com (10.1.198.204) by
 dggemv711-chm.china.huawei.com (10.1.198.66) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256) id
 15.1.2176.2; Mon, 31 May 2021 21:53:14 +0800
Received: from huawei.com (10.175.127.227) by dggema762-chm.china.huawei.com
 (10.1.198.204) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2176.2; Mon, 31
 May 2021 21:53:13 +0800
From:   Yu Kuai <yukuai3@huawei.com>
To:     <gregkh@linuxfoundation.org>, <fabioaiuto83@gmail.com>
CC:     <linux-staging@lists.linux.dev>, <linux-kernel@vger.kernel.org>,
        <yukuai3@huawei.com>, <yi.zhang@huawei.com>
Subject: [PATCH V3] staging: rtl8723bs: core: rtw_mlme_ext.c: remove deadcode
Date:   Mon, 31 May 2021 22:02:34 +0800
Message-ID: <20210531140234.3352465-1-yukuai3@huawei.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <YLIk2aE3vE3Vr1E8@kroah.com>
References: <YLIk2aE3vE3Vr1E8@kroah.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.175.127.227]
X-ClientProxiedBy: dggems705-chm.china.huawei.com (10.3.19.182) To
 dggema762-chm.china.huawei.com (10.1.198.204)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

'CHECK_EVENT_SEQ' is not defined anywhere, remove the deadcode.

Signed-off-by: Yu Kuai <yukuai3@huawei.com>
---
Changes in V2:
 - remove dead code to fix unused variable.
 - use a new tittle.

 drivers/staging/rtl8723bs/core/rtw_mlme_ext.c | 13 +------------
 1 file changed, 1 insertion(+), 12 deletions(-)

diff --git a/drivers/staging/rtl8723bs/core/rtw_mlme_ext.c b/drivers/staging/rtl8723bs/core/rtw_mlme_ext.c
index 97b3c2965770..2b95a49ab469 100644
--- a/drivers/staging/rtl8723bs/core/rtw_mlme_ext.c
+++ b/drivers/staging/rtl8723bs/core/rtw_mlme_ext.c
@@ -6006,7 +6006,7 @@ static struct fwevent wlanevents[] = {
 
 u8 mlme_evt_hdl(struct adapter *padapter, unsigned char *pbuf)
 {
-	u8 evt_code, evt_seq;
+	u8 evt_code;
 	u16 evt_sz;
 	uint	*peventbuf;
 	void (*event_callback)(struct adapter *dev, u8 *pbuf);
@@ -6017,19 +6017,8 @@ u8 mlme_evt_hdl(struct adapter *padapter, unsigned char *pbuf)
 
 	peventbuf = (uint *)pbuf;
 	evt_sz = (u16)(*peventbuf&0xffff);
-	evt_seq = (u8)((*peventbuf>>24)&0x7f);
 	evt_code = (u8)((*peventbuf>>16)&0xff);
 
-
-	#ifdef CHECK_EVENT_SEQ
-	/*  checking event sequence... */
-	if (evt_seq != (atomic_read(&pevt_priv->event_seq) & 0x7f)) {
-		pevt_priv->event_seq = (evt_seq+1)&0x7f;
-
-		goto _abort_event_;
-	}
-	#endif
-
 	/*  checking if event code is valid */
 	if (evt_code >= MAX_C2HEVT)
 		goto _abort_event_;
-- 
2.31.1

