Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7E75C353854
	for <lists+linux-kernel@lfdr.de>; Sun,  4 Apr 2021 16:10:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231194AbhDDOKK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 4 Apr 2021 10:10:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37452 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231139AbhDDOKB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 4 Apr 2021 10:10:01 -0400
Received: from mail-wm1-x333.google.com (mail-wm1-x333.google.com [IPv6:2a00:1450:4864:20::333])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E2E9DC061756
        for <linux-kernel@vger.kernel.org>; Sun,  4 Apr 2021 07:09:56 -0700 (PDT)
Received: by mail-wm1-x333.google.com with SMTP id w203-20020a1c49d40000b029010c706d0642so6523037wma.0
        for <linux-kernel@vger.kernel.org>; Sun, 04 Apr 2021 07:09:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=SnlRqa1pV52c6wUAyz/EYgtXOO506MKaz/mlftdWmZc=;
        b=ACyO75JeMhqnGnGJ8pi2h8uFeTXnEtGoQlYpz6ZqAsRCy3NkE+9DJheryfCil9jUE1
         4FaUtfEMdmrdMfcrgyCtHk4uqwY47bI+8RyiYgxDthPCm9izWIJXPm38DjpqPvY61EYg
         EZA5VDbv1T1xAqQi1kArAVO6ZCPp6EFkXMlX6vuHgBY/yTL3HhVf0rqPiHLwIR/51B0u
         u1MHqsjVpn/jMI8uUCuf8vuaKhPeOQEwUfjr6RCRQ5szeszSY5kaIlmwCOTbTMe52fti
         VBgZ+bb5VW9qD2Ld8hjhbsdmWFh8te9o8/BjJ83hAnwNOSKFGmlcLZ2nhEQxzUDV5azC
         3IAA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=SnlRqa1pV52c6wUAyz/EYgtXOO506MKaz/mlftdWmZc=;
        b=oCOn/HJ8Dy1M6rb49imScBo3OPQaeiHrmOYgJpPhU6zxt/orC5l/9xY/e5BaoX5vBU
         L4PMyKnekYh5+kOu82rFc1QTmlKQ4geHnLQHVEwYaHwMfxx/aaqU/k5lGVEiJpOQ4Ze0
         KAv4kH+Tr7o6LhECYbZtzzWEeYvH2MhFECLOelOCoifGYzIXrMumTL5Bt/Bravkue0hR
         TaUYKck9R2j6scYSw1780ifk4H+oitJDVMvjGwGN0QkKhMXZCGZ8Q7bnpb5zI9sgSqrF
         Q3Z1gWZWFWGis9+LHSiwm7h2CyRCFxcI5PDV/+JLTaiV2l4IdtIltbp/NqtpHPc/lV8u
         4HcQ==
X-Gm-Message-State: AOAM531W4kAEYVX2I7LUj0AzndYfd8OKK1+koQ6yvexvGj4VJZHYDeNT
        OWUxLl1fe4tpocpNQsh1rcQ=
X-Google-Smtp-Source: ABdhPJyC4TzNXhj5WnKlIWv5JASK0ssJWOKv6cft7g4tC2dAAj1Fc3Y46vbcg+onSMTtfsx1n+xcRQ==
X-Received: by 2002:a05:600c:ac2:: with SMTP id c2mr21099456wmr.23.1617545395698;
        Sun, 04 Apr 2021 07:09:55 -0700 (PDT)
Received: from agape ([5.171.81.112])
        by smtp.gmail.com with ESMTPSA id m5sm8380797wrx.83.2021.04.04.07.09.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 04 Apr 2021 07:09:55 -0700 (PDT)
From:   Fabio Aiuto <fabioaiuto83@gmail.com>
To:     gregkh@linuxfoundation.org
Cc:     dan.carpenter@oracle.com, joe@perches.com,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org,
        Fabio Aiuto <fabioaiuto83@gmail.com>
Subject: [PATCH v4 03/30] staging: rtl8723bs: remove RT_TRACE logs in core/rtw_security.c
Date:   Sun,  4 Apr 2021 16:09:19 +0200
Message-Id: <14207c2b7ea789e8b0f3bd37d2758e979eff997c.1617545239.git.fabioaiuto83@gmail.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <cover.1617545239.git.fabioaiuto83@gmail.com>
References: <cover.1617545239.git.fabioaiuto83@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Remove all of the RT_TRACE logs in the core/rtw_security.c file as they
currently do nothing as they require the code to be modified by
hand in order to be turned on. This obviously has not happened
since the code was merged. Moreover it relies on an unneeded
private log level tracing which overrides the in-kernel public one,
so just remove them as they are unused.

Signed-off-by: Fabio Aiuto <fabioaiuto83@gmail.com>
---
 drivers/staging/rtl8723bs/core/rtw_security.c | 40 +------------------
 1 file changed, 1 insertion(+), 39 deletions(-)

diff --git a/drivers/staging/rtl8723bs/core/rtw_security.c b/drivers/staging/rtl8723bs/core/rtw_security.c
index 8a447e149438..689419a76d94 100644
--- a/drivers/staging/rtl8723bs/core/rtw_security.c
+++ b/drivers/staging/rtl8723bs/core/rtw_security.c
@@ -236,16 +236,6 @@ void rtw_wep_decrypt(struct adapter  *padapter, u8 *precvframe)
 		/* calculate icv and compare the icv */
 		*((u32 *)crc) = le32_to_cpu(getcrc32(payload, length-4));
 
-		if (crc[3] != payload[length-1] || crc[2] != payload[length-2] || crc[1] != payload[length-3] || crc[0] != payload[length-4]) {
-			RT_TRACE(_module_rtl871x_security_c_,
-				 _drv_err_,
-				 ("%s:icv error crc[3](%x)!=payload[length-1](%x) || crc[2](%x)!=payload[length-2](%x) || crc[1](%x)!=payload[length-3](%x) || crc[0](%x)!=payload[length-4](%x)\n",
-					__func__,
-					crc[3], payload[length - 1],
-					crc[2], payload[length - 2],
-					crc[1], payload[length - 3],
-					crc[0], payload[length - 4]));
-		}
 	}
 }
 
@@ -609,8 +599,6 @@ u32 rtw_tkip_encrypt(struct adapter *padapter, u8 *pxmitframe)
 	if (pattrib->encrypt == _TKIP_) {
 
 		{
-			RT_TRACE(_module_rtl871x_security_c_, _drv_err_, ("%s: stainfo!= NULL!!!\n", __func__));
-
 			if (IS_MCAST(pattrib->ra))
 				prwskey = psecuritypriv->dot118021XGrpKey[psecuritypriv->dot118021XGrpKeyid].skey;
 			else
@@ -631,7 +619,6 @@ u32 rtw_tkip_encrypt(struct adapter *padapter, u8 *pxmitframe)
 
 				if ((curfragnum+1) == pattrib->nr_frags) {	/* 4 the last fragment */
 					length = pattrib->last_txcmdsz-pattrib->hdrlen-pattrib->iv_len-pattrib->icv_len;
-					RT_TRACE(_module_rtl871x_security_c_, _drv_info_, ("pattrib->iv_len =%x, pattrib->icv_len =%x\n", pattrib->iv_len, pattrib->icv_len));
 					*((__le32 *)crc) = getcrc32(payload, length);/* modified by Amy*/
 
 					arcfour_init(&mycontext, rc4key, 16);
@@ -739,18 +726,9 @@ u32 rtw_tkip_decrypt(struct adapter *padapter, u8 *precvframe)
 
 			*((u32 *)crc) = le32_to_cpu(getcrc32(payload, length-4));
 
-			if (crc[3] != payload[length-1] || crc[2] != payload[length-2] || crc[1] != payload[length-3] || crc[0] != payload[length-4]) {
-				RT_TRACE(_module_rtl871x_security_c_,
-					 _drv_err_,
-					 ("rtw_wep_decrypt:icv error crc[3](%x)!=payload[length-1](%x) || crc[2](%x)!=payload[length-2](%x) || crc[1](%x)!=payload[length-3](%x) || crc[0](%x)!=payload[length-4](%x)\n",
-						crc[3], payload[length - 1],
-						crc[2], payload[length - 2],
-						crc[1], payload[length - 3],
-						crc[0], payload[length - 4]));
+			if (crc[3] != payload[length-1] || crc[2] != payload[length-2] || crc[1] != payload[length-3] || crc[0] != payload[length-4])
 				res = _FAIL;
-			}
 		} else {
-			RT_TRACE(_module_rtl871x_security_c_, _drv_err_, ("%s: stainfo == NULL!!!\n", __func__));
 			res = _FAIL;
 		}
 	}
@@ -1380,8 +1358,6 @@ u32 rtw_aes_encrypt(struct adapter *padapter, u8 *pxmitframe)
 
 	/* 4 start to encrypt each fragment */
 	if (pattrib->encrypt == _AES_) {
-		RT_TRACE(_module_rtl871x_security_c_, _drv_err_, ("%s: stainfo!= NULL!!!\n", __func__));
-
 		if (IS_MCAST(pattrib->ra))
 			prwskey = psecuritypriv->dot118021XGrpKey[psecuritypriv->dot118021XGrpKeyid].skey;
 		else
@@ -1611,13 +1587,6 @@ static signed int aes_decipher(u8 *key, uint	hdrlen,
 	/* compare the mic */
 	for (i = 0; i < 8; i++) {
 		if (pframe[hdrlen+8+plen-8+i] != message[hdrlen+8+plen-8+i]) {
-			RT_TRACE(_module_rtl871x_security_c_,
-				 _drv_err_,
-				 ("%s:mic check error mic[%d]: pframe(%x) != message(%x)\n",
-					__func__,
-					i,
-					pframe[hdrlen + 8 + plen - 8 + i],
-					message[hdrlen + 8 + plen - 8 + i]));
 			DBG_871X("%s:mic check error mic[%d]: pframe(%x) != message(%x)\n",
 					__func__,
 					i,
@@ -1649,10 +1618,6 @@ u32 rtw_aes_decrypt(struct adapter *padapter, u8 *precvframe)
 	if (prxattrib->encrypt == _AES_) {
 		stainfo = rtw_get_stainfo(&padapter->stapriv, &prxattrib->ta[0]);
 		if (stainfo) {
-			RT_TRACE(_module_rtl871x_security_c_,
-				 _drv_err_,
-				 ("%s: stainfo!= NULL!!!\n", __func__));
-
 			if (IS_MCAST(prxattrib->ra)) {
 				static unsigned long start;
 				static u32 no_gkey_bc_cnt;
@@ -1706,9 +1671,6 @@ u32 rtw_aes_decrypt(struct adapter *padapter, u8 *precvframe)
 			res = aes_decipher(prwskey, prxattrib->hdrlen, pframe, length);
 
 		} else {
-			RT_TRACE(_module_rtl871x_security_c_,
-				 _drv_err_,
-				 ("%s: stainfo == NULL!!!\n", __func__));
 			res = _FAIL;
 		}
 	}
-- 
2.20.1

