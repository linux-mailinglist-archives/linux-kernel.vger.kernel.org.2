Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5D6EA399C84
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Jun 2021 10:26:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229764AbhFCI2l (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 3 Jun 2021 04:28:41 -0400
Received: from mail-m121144.qiye.163.com ([115.236.121.144]:13934 "EHLO
        mail-m121144.qiye.163.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229479AbhFCI2k (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Jun 2021 04:28:40 -0400
Received: from vivo-HP-ProDesk-680-G4-PCI-MT.vivo.xyz (unknown [58.250.176.229])
        by mail-m121144.qiye.163.com (Hmail) with ESMTPA id E6A66AC0217;
        Thu,  3 Jun 2021 16:26:53 +0800 (CST)
From:   Wan Jiabing <wanjiabing@vivo.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Fabio Aiuto <fabioaiuto83@gmail.com>,
        Ross Schmidt <ross.schm.dev@gmail.com>,
        Qiang Ma <maqianga@uniontech.com>,
        Marco Cesati <marcocesati@gmail.com>,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org
Cc:     Wan Jiabing <wanjiabing@vivo.com>
Subject: [PATCH] staging: rtl8723bs: core: fix some incorrect type warnings
Date:   Thu,  3 Jun 2021 16:24:59 +0800
Message-Id: <1622708703-8561-1-git-send-email-wanjiabing@vivo.com>
X-Mailer: git-send-email 2.7.4
X-HM-Spam-Status: e1kfGhgUHx5ZQUtXWQgYFAkeWUFZS1VLWVdZKFlBSE83V1ktWUFJV1kPCR
        oVCBIfWUFZQx1DHlZNHh9OGkNOSktISENVEwETFhoSFyQUDg9ZV1kWGg8SFR0UWUFZT0tIVUpKS0
        hKQ1VLWQY+
X-HM-Sender-Digest: e1kMHhlZQR0aFwgeV1kSHx4VD1lBWUc6Mwg6FAw5Cz8cQhQsLAIBARku
        Q08KCy1VSlVKTUlJTEtDQ0pPTklMVTMWGhIXVQwaFRESGhkSFRw7DRINFFUYFBZFWVdZEgtZQVlO
        Q1VJTktVSkxNVUlJQllXWQgBWUFOTUlPNwY+
X-HM-Tid: 0a79d0fb817bb039kuuue6a66ac0217
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fix some "incorrect type in assignment" in rtw_security.c.

The sparse warings:
drivers/staging//rtl8723bs/core/rtw_security.c:72:50: warning: incorrect type in assignment
drivers/staging//rtl8723bs/core/rtw_security.c:72:50:    expected restricted __le32 [usertype]
drivers/staging//rtl8723bs/core/rtw_security.c:72:50:    got unsigned int
drivers/staging//rtl8723bs/core/rtw_security.c:80:50: warning: incorrect type in assignment
drivers/staging//rtl8723bs/core/rtw_security.c:80:50:    expected restricted __le32 [usertype]
drivers/staging//rtl8723bs/core/rtw_security.c:80:50:    got unsigned int
drivers/staging//rtl8723bs/core/rtw_security.c:124:33: warning: cast to restricted __le32
drivers/staging//rtl8723bs/core/rtw_security.c:509:58: warning: incorrect type in assignment
drivers/staging//rtl8723bs/core/rtw_security.c:509:58:    expected restricted __le32 [usertype]
drivers/staging//rtl8723bs/core/rtw_security.c:509:58:    got unsigned int
drivers/staging//rtl8723bs/core/rtw_security.c:517:58: warning: incorrect type in assignment
drivers/staging//rtl8723bs/core/rtw_security.c:517:58:    expected restricted __le32 [usertype]
drivers/staging//rtl8723bs/core/rtw_security.c:517:58:    got unsigned int
drivers/staging//rtl8723bs/core/rtw_security.c:621:41: warning: cast to restricted __le32

Signed-off-by: Wan Jiabing <wanjiabing@vivo.com>
---
 drivers/staging/rtl8723bs/core/rtw_security.c | 14 +++++++-------
 1 file changed, 7 insertions(+), 7 deletions(-)

diff --git a/drivers/staging/rtl8723bs/core/rtw_security.c b/drivers/staging/rtl8723bs/core/rtw_security.c
index a99f439..4760999 100644
--- a/drivers/staging/rtl8723bs/core/rtw_security.c
+++ b/drivers/staging/rtl8723bs/core/rtw_security.c
@@ -36,7 +36,7 @@ const char *security_type_str(u8 value)
 void rtw_wep_encrypt(struct adapter *padapter, u8 *pxmitframe)
 {																	/*  exclude ICV */
 
-	unsigned char crc[4];
+	u8 crc[4];
 
 	signed int	curfragnum, length;
 	u32 keylength;
@@ -69,7 +69,7 @@ void rtw_wep_encrypt(struct adapter *padapter, u8 *pxmitframe)
 
 				length = pattrib->last_txcmdsz-pattrib->hdrlen-pattrib->iv_len-pattrib->icv_len;
 
-				*((__le32 *)crc) = ~crc32_le(~0, payload, length);
+				*((__le32 *)crc) = cpu_to_le32(~crc32_le(~0, payload, length));
 
 				arc4_setkey(ctx, wepkey, 3 + keylength);
 				arc4_crypt(ctx, payload, payload, length);
@@ -77,7 +77,7 @@ void rtw_wep_encrypt(struct adapter *padapter, u8 *pxmitframe)
 
 			} else {
 				length = pxmitpriv->frag_len-pattrib->hdrlen-pattrib->iv_len-pattrib->icv_len;
-				*((__le32 *)crc) = ~crc32_le(~0, payload, length);
+				*((__le32 *)crc) = cpu_to_le32(~crc32_le(~0, payload, length));
 				arc4_setkey(ctx, wepkey, 3 + keylength);
 				arc4_crypt(ctx, payload, payload, length);
 				arc4_crypt(ctx, payload + length, crc, 4);
@@ -121,7 +121,7 @@ void rtw_wep_decrypt(struct adapter  *padapter, u8 *precvframe)
 		arc4_crypt(ctx, payload, payload,  length);
 
 		/* calculate icv and compare the icv */
-		*((u32 *)crc) = le32_to_cpu(~crc32_le(~0, payload, length - 4));
+		*((__le32 *)crc) = cpu_to_le32(~crc32_le(~0, payload, length - 4));
 
 	}
 }
@@ -506,7 +506,7 @@ u32 rtw_tkip_encrypt(struct adapter *padapter, u8 *pxmitframe)
 
 				if ((curfragnum+1) == pattrib->nr_frags) {	/* 4 the last fragment */
 					length = pattrib->last_txcmdsz-pattrib->hdrlen-pattrib->iv_len-pattrib->icv_len;
-					*((__le32 *)crc) = ~crc32_le(~0, payload, length);
+					*((__le32 *)crc) = cpu_to_le32(~crc32_le(~0, payload, length));
 
 					arc4_setkey(ctx, rc4key, 16);
 					arc4_crypt(ctx, payload, payload, length);
@@ -514,7 +514,7 @@ u32 rtw_tkip_encrypt(struct adapter *padapter, u8 *pxmitframe)
 
 				} else {
 					length = pxmitpriv->frag_len-pattrib->hdrlen-pattrib->iv_len-pattrib->icv_len;
-					*((__le32 *)crc) = ~crc32_le(~0, payload, length);
+					*((__le32 *)crc) = cpu_to_le32(~crc32_le(~0, payload, length));
 
 					arc4_setkey(ctx, rc4key, 16);
 					arc4_crypt(ctx, payload, payload, length);
@@ -618,7 +618,7 @@ u32 rtw_tkip_decrypt(struct adapter *padapter, u8 *precvframe)
 			arc4_setkey(ctx, rc4key, 16);
 			arc4_crypt(ctx, payload, payload, length);
 
-			*((u32 *)crc) = le32_to_cpu(~crc32_le(~0, payload, length - 4));
+			*((__le32 *)crc) = cpu_to_le32(~crc32_le(~0, payload, length - 4));
 
 			if (crc[3] != payload[length - 1] || crc[2] != payload[length - 2] ||
 			    crc[1] != payload[length - 3] || crc[0] != payload[length - 4])
-- 
2.7.4

