Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A8A8638C95C
	for <lists+linux-kernel@lfdr.de>; Fri, 21 May 2021 16:42:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235524AbhEUOn1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 21 May 2021 10:43:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44566 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230336AbhEUOnZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 May 2021 10:43:25 -0400
Received: from mail-ej1-x632.google.com (mail-ej1-x632.google.com [IPv6:2a00:1450:4864:20::632])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 24FCDC061574
        for <linux-kernel@vger.kernel.org>; Fri, 21 May 2021 07:42:01 -0700 (PDT)
Received: by mail-ej1-x632.google.com with SMTP id f18so680344ejq.10
        for <linux-kernel@vger.kernel.org>; Fri, 21 May 2021 07:42:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=J9SKo3NdGGBNovIrQCqMGuOHB6KkkTbrheBEMJXD0tM=;
        b=erkxw1RrQ11ukOtS5y3enOxrVQWqCFSEhTWhvRZpHralUu9dmOLzlpFi+RDUjqGbP8
         kqm84lzHdle7KSnSUpPVoHzSdZpuZDdyBt6outjt56jJvBTN8m31IjlKbwOLV4XlM+KD
         7h2fIAc1gRm2faPrEwRKlaEOH2wR+WA9FhiTdfQ6wSD10/D3Ly5jvgjazXkH9AjDbTnM
         ga+cs8q7gR7m7IPzxLbYUyN19vPa6PAyR88XAVh44gxXOqrVpL/JtygEjTh+QRKCkREu
         AfW6TE5f8n/6CIIeQxQvhsaihhSCmze+9pNREoINpYMkyl6S0IL6GYmwXS1k+YzyzKxr
         R+gw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=J9SKo3NdGGBNovIrQCqMGuOHB6KkkTbrheBEMJXD0tM=;
        b=JZ7K2TkKDr5IyKp8JXXgk6+Gi0G+J4kFfOlK5XMFim5eNXSlbUA4bdMyM7G3G5cMFC
         AAHdk3xLGpU+DdupD3CotcYBlwKiNLO1n5/+i3CcP013Zrc4cbhcQUuiPz92VgxacCaY
         gRTqJxEd5px5iYPKAQmqFs0CwqUFCdCb83Zh0h4SWCTrulF1AR6iDRhvHGJHUCpE5Dmj
         SoZXiuR3+8zLw/4YNKVquSkZEnHz/8q7zRaOLvgDTGWCwZfD0SttuLQxc7nMt8tjBQBb
         EirG/DneXdpvNc0HwInXw3c4yR3ko1LZyO5Hx4JwAvz9TN2aXn0VZk/qSvmniDQTNtPX
         IL/g==
X-Gm-Message-State: AOAM532HCAtJc/G6ZX/7mfip1GwVc6IW0V/O3Uzmb/kobl0JycHJmeZX
        21Nzh0H6xYceXeiu2YrUNKI=
X-Google-Smtp-Source: ABdhPJy3GwopMX6WLD88OU2cJB+4XnpgJlTQanXQbXIFkP2XDHec7z0Dqseiqxm3tfvID0UzEOdyWg==
X-Received: by 2002:a17:906:13db:: with SMTP id g27mr10795477ejc.88.1621608119699;
        Fri, 21 May 2021 07:41:59 -0700 (PDT)
Received: from agape ([109.52.244.91])
        by smtp.gmail.com with ESMTPSA id dk21sm3672277ejb.54.2021.05.21.07.41.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 21 May 2021 07:41:59 -0700 (PDT)
From:   Fabio Aiuto <fabioaiuto83@gmail.com>
To:     gregkh@linuxfoundation.org
Cc:     linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org,
        kernel test robot <lkp@intel.com>
Subject: [PATCH] staging: rtl8723bs: moved contexts for arc4 encryption in struct security_priv
Date:   Fri, 21 May 2021 16:41:58 +0200
Message-Id: <20210521144158.2440-1-fabioaiuto83@gmail.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

moved struct arc4_ctx in struct security_priv to avoid stack allocation
inside encryption routines.

this has been done to fix the following 0-DAY issues:

>> drivers/staging/rtl8723bs/core/rtw_security.c:89:6: warning:
stack frame size of 1120 bytes in function 'rtw_wep_encrypt'
[-Wframe-$
   void rtw_wep_encrypt(struct adapter *padapter, u8 *pxmitframe)
        ^
>> drivers/staging/rtl8723bs/core/rtw_security.c:145:6:
warning: stack frame size of 1088 bytes in function 'rtw_wep_decrypt'
[-Wframe$
   void rtw_wep_decrypt(struct adapter  *padapter, u8 *precvframe)
        ^
>> drivers/staging/rtl8723bs/core/rtw_security.c:514:5:
warning: stack frame size of 1136 bytes in function 'rtw_tkip_encrypt'
[-Wfram$
   u32 rtw_tkip_encrypt(struct adapter *padapter, u8 *pxmitframe)
       ^
>> drivers/staging/rtl8723bs/core/rtw_security.c:586:5:
warning: stack frame size of 1104 bytes in function 'rtw_tkip_decrypt'
[-Wfram$
   u32 rtw_tkip_decrypt(struct adapter *padapter, u8 *precvframe)
       ^

Reported-by: kernel test robot <lkp@intel.com>
Signed-off-by: Fabio Aiuto <fabioaiuto83@gmail.com>
---
 drivers/staging/rtl8723bs/core/rtw_security.c | 41 +++++++++----------
 .../staging/rtl8723bs/include/rtw_security.h  |  3 ++
 2 files changed, 23 insertions(+), 21 deletions(-)

diff --git a/drivers/staging/rtl8723bs/core/rtw_security.c b/drivers/staging/rtl8723bs/core/rtw_security.c
index 5ff8926c1865..a99f439328f1 100644
--- a/drivers/staging/rtl8723bs/core/rtw_security.c
+++ b/drivers/staging/rtl8723bs/core/rtw_security.c
@@ -8,7 +8,6 @@
 #include <drv_types.h>
 #include <rtw_debug.h>
 #include <crypto/aes.h>
-#include <crypto/arc4.h>
 
 static const char * const _security_type_str[] = {
 	"N/A",
@@ -38,7 +37,6 @@ void rtw_wep_encrypt(struct adapter *padapter, u8 *pxmitframe)
 {																	/*  exclude ICV */
 
 	unsigned char crc[4];
-	struct arc4_ctx	mycontext;
 
 	signed int	curfragnum, length;
 	u32 keylength;
@@ -49,6 +47,7 @@ void rtw_wep_encrypt(struct adapter *padapter, u8 *pxmitframe)
 	struct pkt_attrib *pattrib = &((struct xmit_frame *)pxmitframe)->attrib;
 	struct security_priv *psecuritypriv = &padapter->securitypriv;
 	struct xmit_priv *pxmitpriv = &padapter->xmitpriv;
+	struct arc4_ctx *ctx = &psecuritypriv->xmit_arc4_ctx;
 
 	if (((struct xmit_frame *)pxmitframe)->buf_addr == NULL)
 		return;
@@ -72,16 +71,16 @@ void rtw_wep_encrypt(struct adapter *padapter, u8 *pxmitframe)
 
 				*((__le32 *)crc) = ~crc32_le(~0, payload, length);
 
-				arc4_setkey(&mycontext, wepkey, 3 + keylength);
-				arc4_crypt(&mycontext, payload, payload, length);
-				arc4_crypt(&mycontext, payload + length, crc, 4);
+				arc4_setkey(ctx, wepkey, 3 + keylength);
+				arc4_crypt(ctx, payload, payload, length);
+				arc4_crypt(ctx, payload + length, crc, 4);
 
 			} else {
 				length = pxmitpriv->frag_len-pattrib->hdrlen-pattrib->iv_len-pattrib->icv_len;
 				*((__le32 *)crc) = ~crc32_le(~0, payload, length);
-				arc4_setkey(&mycontext, wepkey, 3 + keylength);
-				arc4_crypt(&mycontext, payload, payload, length);
-				arc4_crypt(&mycontext, payload + length, crc, 4);
+				arc4_setkey(ctx, wepkey, 3 + keylength);
+				arc4_crypt(ctx, payload, payload, length);
+				arc4_crypt(ctx, payload + length, crc, 4);
 
 				pframe += pxmitpriv->frag_len;
 				pframe = (u8 *)round_up((SIZE_PTR)(pframe), 4);
@@ -94,13 +93,13 @@ void rtw_wep_decrypt(struct adapter  *padapter, u8 *precvframe)
 {
 	/*  exclude ICV */
 	u8 crc[4];
-	struct arc4_ctx	 mycontext;
 	signed int	length;
 	u32 keylength;
 	u8 *pframe, *payload, *iv, wepkey[16];
 	u8  keyindex;
 	struct	rx_pkt_attrib	 *prxattrib = &(((union recv_frame *)precvframe)->u.hdr.attrib);
 	struct	security_priv *psecuritypriv = &padapter->securitypriv;
+	struct arc4_ctx *ctx = &psecuritypriv->recv_arc4_ctx;
 
 	pframe = (unsigned char *)((union recv_frame *)precvframe)->u.hdr.rx_data;
 
@@ -118,8 +117,8 @@ void rtw_wep_decrypt(struct adapter  *padapter, u8 *precvframe)
 		payload = pframe+prxattrib->iv_len+prxattrib->hdrlen;
 
 		/* decrypt payload include icv */
-		arc4_setkey(&mycontext, wepkey, 3 + keylength);
-		arc4_crypt(&mycontext, payload, payload,  length);
+		arc4_setkey(ctx, wepkey, 3 + keylength);
+		arc4_crypt(ctx, payload, payload,  length);
 
 		/* calculate icv and compare the icv */
 		*((u32 *)crc) = le32_to_cpu(~crc32_le(~0, payload, length - 4));
@@ -467,7 +466,6 @@ u32 rtw_tkip_encrypt(struct adapter *padapter, u8 *pxmitframe)
 	u8   ttkey[16];
 	u8 crc[4];
 	u8   hw_hdr_offset = 0;
-	struct arc4_ctx mycontext;
 	signed int			curfragnum, length;
 
 	u8 *pframe, *payload, *iv, *prwskey;
@@ -475,6 +473,7 @@ u32 rtw_tkip_encrypt(struct adapter *padapter, u8 *pxmitframe)
 	struct pkt_attrib *pattrib = &((struct xmit_frame *)pxmitframe)->attrib;
 	struct security_priv *psecuritypriv = &padapter->securitypriv;
 	struct xmit_priv *pxmitpriv = &padapter->xmitpriv;
+	struct arc4_ctx *ctx = &psecuritypriv->xmit_arc4_ctx;
 	u32 res = _SUCCESS;
 
 	if (((struct xmit_frame *)pxmitframe)->buf_addr == NULL)
@@ -509,17 +508,17 @@ u32 rtw_tkip_encrypt(struct adapter *padapter, u8 *pxmitframe)
 					length = pattrib->last_txcmdsz-pattrib->hdrlen-pattrib->iv_len-pattrib->icv_len;
 					*((__le32 *)crc) = ~crc32_le(~0, payload, length);
 
-					arc4_setkey(&mycontext, rc4key, 16);
-					arc4_crypt(&mycontext, payload, payload, length);
-					arc4_crypt(&mycontext, payload + length, crc, 4);
+					arc4_setkey(ctx, rc4key, 16);
+					arc4_crypt(ctx, payload, payload, length);
+					arc4_crypt(ctx, payload + length, crc, 4);
 
 				} else {
 					length = pxmitpriv->frag_len-pattrib->hdrlen-pattrib->iv_len-pattrib->icv_len;
 					*((__le32 *)crc) = ~crc32_le(~0, payload, length);
 
-					arc4_setkey(&mycontext, rc4key, 16);
-					arc4_crypt(&mycontext, payload, payload, length);
-					arc4_crypt(&mycontext, payload + length, crc, 4);
+					arc4_setkey(ctx, rc4key, 16);
+					arc4_crypt(ctx, payload, payload, length);
+					arc4_crypt(ctx, payload + length, crc, 4);
 
 					pframe += pxmitpriv->frag_len;
 					pframe = (u8 *)round_up((SIZE_PTR)(pframe), 4);
@@ -539,7 +538,6 @@ u32 rtw_tkip_decrypt(struct adapter *padapter, u8 *precvframe)
 	u8   rc4key[16];
 	u8   ttkey[16];
 	u8 crc[4];
-	struct arc4_ctx mycontext;
 	signed int			length;
 
 	u8 *pframe, *payload, *iv, *prwskey;
@@ -547,6 +545,7 @@ u32 rtw_tkip_decrypt(struct adapter *padapter, u8 *precvframe)
 	struct sta_info *stainfo;
 	struct rx_pkt_attrib *prxattrib = &((union recv_frame *)precvframe)->u.hdr.attrib;
 	struct security_priv *psecuritypriv = &padapter->securitypriv;
+	struct arc4_ctx *ctx = &psecuritypriv->recv_arc4_ctx;
 	u32 res = _SUCCESS;
 
 	pframe = (unsigned char *)((union recv_frame *)precvframe)->u.hdr.rx_data;
@@ -616,8 +615,8 @@ u32 rtw_tkip_decrypt(struct adapter *padapter, u8 *precvframe)
 
 			/* 4 decrypt payload include icv */
 
-			arc4_setkey(&mycontext, rc4key, 16);
-			arc4_crypt(&mycontext, payload, payload, length);
+			arc4_setkey(ctx, rc4key, 16);
+			arc4_crypt(ctx, payload, payload, length);
 
 			*((u32 *)crc) = le32_to_cpu(~crc32_le(~0, payload, length - 4));
 
diff --git a/drivers/staging/rtl8723bs/include/rtw_security.h b/drivers/staging/rtl8723bs/include/rtw_security.h
index 83b711c5df0b..a68b73858462 100644
--- a/drivers/staging/rtl8723bs/include/rtw_security.h
+++ b/drivers/staging/rtl8723bs/include/rtw_security.h
@@ -7,6 +7,7 @@
 #ifndef __RTW_SECURITY_H_
 #define __RTW_SECURITY_H_
 
+#include <crypto/arc4.h>
 
 #define _NO_PRIVACY_		0x0
 #define _WEP40_				0x1
@@ -127,6 +128,8 @@ struct security_priv {
 	u8 wps_ie[MAX_WPS_IE_LEN];/* added in assoc req */
 	int wps_ie_len;
 
+	struct arc4_ctx xmit_arc4_ctx;
+	struct arc4_ctx recv_arc4_ctx;
 
 	u8 binstallGrpkey;
 	u8 binstallBIPkey;
-- 
2.20.1

