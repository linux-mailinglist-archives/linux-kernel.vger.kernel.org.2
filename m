Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B5370394B49
	for <lists+linux-kernel@lfdr.de>; Sat, 29 May 2021 11:20:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229716AbhE2JWE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 29 May 2021 05:22:04 -0400
Received: from szxga01-in.huawei.com ([45.249.212.187]:2094 "EHLO
        szxga01-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229559AbhE2JWE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 29 May 2021 05:22:04 -0400
Received: from dggemv703-chm.china.huawei.com (unknown [172.30.72.53])
        by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4FsbWS6d96zWpSZ;
        Sat, 29 May 2021 17:15:48 +0800 (CST)
Received: from dggema762-chm.china.huawei.com (10.1.198.204) by
 dggemv703-chm.china.huawei.com (10.3.19.46) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256) id
 15.1.2176.2; Sat, 29 May 2021 17:20:26 +0800
Received: from huawei.com (10.175.127.227) by dggema762-chm.china.huawei.com
 (10.1.198.204) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2176.2; Sat, 29
 May 2021 17:20:26 +0800
From:   Yu Kuai <yukuai3@huawei.com>
To:     <gregkh@linuxfoundation.org>
CC:     <linux-staging@lists.linux.dev>, <linux-kernel@vger.kernel.org>,
        <yukuai3@huawei.com>, <yi.zhang@huawei.com>
Subject: [PATCH] staging: rtl8723bs: core: rtw_mlme_ext.c: move the declaration and initialization of 'evt_seq' inside ifdef macro
Date:   Sat, 29 May 2021 17:29:48 +0800
Message-ID: <20210529092948.3134775-1-yukuai3@huawei.com>
X-Mailer: git-send-email 2.25.4
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.175.127.227]
X-ClientProxiedBy: dggems703-chm.china.huawei.com (10.3.19.180) To
 dggema762-chm.china.huawei.com (10.1.198.204)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

'evt_seq' is only used if 'CHECK_ENENT_SEQ' is defined, however,
it's declared and initialized even if 'CHECK_ENENT_SEQ' is not
defined. Thus gcc will report following warning if
'CHECK_ENENT_SEQ' is not defined:

drivers/staging/rtl8723bs/core/rtw_mlme_ext.c:6009:15: warning:
 variable ‘evt_seq’ set but not used [-Wunused-but-set-variable]
 6009 |  u8 evt_code, evt_seq;

Thus move the declaration and initialization of 'evt_seq' inside
ifdef macro to fix it.

Signed-off-by: Yu Kuai <yukuai3@huawei.com>
---
 drivers/staging/rtl8723bs/core/rtw_mlme_ext.c | 12 +++++++-----
 1 file changed, 7 insertions(+), 5 deletions(-)

diff --git a/drivers/staging/rtl8723bs/core/rtw_mlme_ext.c b/drivers/staging/rtl8723bs/core/rtw_mlme_ext.c
index 97b3c2965770..e883371cc96d 100644
--- a/drivers/staging/rtl8723bs/core/rtw_mlme_ext.c
+++ b/drivers/staging/rtl8723bs/core/rtw_mlme_ext.c
@@ -6006,7 +6006,10 @@ static struct fwevent wlanevents[] = {
 
 u8 mlme_evt_hdl(struct adapter *padapter, unsigned char *pbuf)
 {
-	u8 evt_code, evt_seq;
+#ifdef CHECK_EVENT_SEQ
+	u8 evt_seq;
+#endif
+	u8 evt_code;
 	u16 evt_sz;
 	uint	*peventbuf;
 	void (*event_callback)(struct adapter *dev, u8 *pbuf);
@@ -6017,18 +6020,17 @@ u8 mlme_evt_hdl(struct adapter *padapter, unsigned char *pbuf)
 
 	peventbuf = (uint *)pbuf;
 	evt_sz = (u16)(*peventbuf&0xffff);
-	evt_seq = (u8)((*peventbuf>>24)&0x7f);
 	evt_code = (u8)((*peventbuf>>16)&0xff);
 
-
-	#ifdef CHECK_EVENT_SEQ
+#ifdef CHECK_EVENT_SEQ
 	/*  checking event sequence... */
+	evt_seq = (u8)((*peventbuf>>24)&0x7f);
 	if (evt_seq != (atomic_read(&pevt_priv->event_seq) & 0x7f)) {
 		pevt_priv->event_seq = (evt_seq+1)&0x7f;
 
 		goto _abort_event_;
 	}
-	#endif
+#endif
 
 	/*  checking if event code is valid */
 	if (evt_code >= MAX_C2HEVT)
-- 
2.25.4

