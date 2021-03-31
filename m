Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1A3B134FD22
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Mar 2021 11:41:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234815AbhCaJk1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 31 Mar 2021 05:40:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39636 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234723AbhCaJkR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 31 Mar 2021 05:40:17 -0400
Received: from mail-ej1-x634.google.com (mail-ej1-x634.google.com [IPv6:2a00:1450:4864:20::634])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8A2DDC061574
        for <linux-kernel@vger.kernel.org>; Wed, 31 Mar 2021 02:40:17 -0700 (PDT)
Received: by mail-ej1-x634.google.com with SMTP id u5so29090206ejn.8
        for <linux-kernel@vger.kernel.org>; Wed, 31 Mar 2021 02:40:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=EOd2VJooCVoEiBmjBW7G58vH0HOhKflugc8+m2NKCTM=;
        b=vaDGrBBU8lahs5xbCyKMHnaqeesduOiyCB/BJr1px9I/1D/ChRR044R6dE56RC012C
         9njw54rJMqWskE6oaimcnM2ihMEPZpQ7pzQihKVA9PHGcQnZX+5UpFTzZhI49dvZkfon
         ZhJbyi3Y/6IsB/gql8vJPIzi3c/VfKGGBOveLpRVIZVOeBhtTOqETeJ7tecCz7uZpfcW
         WWqgfL99/zmqa3u1vWJZClP5x65lcGUB9d2i/UdLGSp6I3fkkDXedmr4aiMkJq2tIWZl
         6rbKKLEWZ6fyQhkBinXMF3yX2k2jDsye71mP/WXSu2y5uyW7xXhqVuk4vRpJMUUqfN3Z
         sV7Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=EOd2VJooCVoEiBmjBW7G58vH0HOhKflugc8+m2NKCTM=;
        b=t1thvfjqJPfZpY4XhDee3RsdMuQ+u8xuK7cAhM6xz2vzlnEWUcjgW8yqpI8wLLGLwv
         dLG2yXd6w+I+2/5p08wgZ1DkUiZAXSFK67KNsrdLU9xZFYmuE+25oWLHntMJX19zLf/9
         MNVkXaY9LmvyLaCHKY3K7vJVMZFspkLvYqjRuMgGcKn+jX+l+PjEoTQ4eLNj7gn72P36
         lIcoBLQrK3rIA2pvrhgNkL+8CWQzI+DN9iacNLGgQSMieGykrTV2k6G4zYF6yKs4rBgd
         Kbw4w1JttnM1QvKSQgTZ8oLbSVXChsKwWIEWZVJWXi7oM/AnoK5+OBNsLfUIVNMgk8p+
         E5vQ==
X-Gm-Message-State: AOAM532rRgWmYdxZZVb7VIpohSUr9DJHcSnYz6M4hITfRu7eao60OapX
        4K/tDExnZqiSSAJh/gOIdsjyd75aUqI75Q==
X-Google-Smtp-Source: ABdhPJxmX838mmtzreh2tD3z6mA8tHKEkwO8kRwjX4UghnejZNgM52meCeFKsOgIGXkQoGVzHIvYZQ==
X-Received: by 2002:a17:906:1352:: with SMTP id x18mr2463421ejb.545.1617183616296;
        Wed, 31 Mar 2021 02:40:16 -0700 (PDT)
Received: from agape ([5.171.73.44])
        by smtp.gmail.com with ESMTPSA id mc10sm828852ejb.56.2021.03.31.02.40.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 31 Mar 2021 02:40:16 -0700 (PDT)
From:   Fabio Aiuto <fabioaiuto83@gmail.com>
To:     gregkh@linuxfoundation.org
Cc:     joe@perches.com, linux-staging@lists.linux.dev,
        linux-kernel@vger.kernel.org, Fabio Aiuto <fabioaiuto83@gmail.com>
Subject: [PATCH 02/40] staging: rtl8723bs: replace RT_TRACE with public printk wrappers in core/rtw_security.c
Date:   Wed, 31 Mar 2021 11:39:30 +0200
Message-Id: <ccf35a6c05b91d7de847288cd20d803ac009e0d8.1617183374.git.fabioaiuto83@gmail.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <cover.1617183374.git.fabioaiuto83@gmail.com>
References: <cover.1617183374.git.fabioaiuto83@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

replace private macro RT_TRACE for tracing with in-kernel
pr_* printk wrappers

Signed-off-by: Fabio Aiuto <fabioaiuto83@gmail.com>
---
 drivers/staging/rtl8723bs/core/rtw_security.c | 38 ++++++++-----------
 1 file changed, 16 insertions(+), 22 deletions(-)

diff --git a/drivers/staging/rtl8723bs/core/rtw_security.c b/drivers/staging/rtl8723bs/core/rtw_security.c
index 8a447e149438..5bdde7b8de01 100644
--- a/drivers/staging/rtl8723bs/core/rtw_security.c
+++ b/drivers/staging/rtl8723bs/core/rtw_security.c
@@ -237,14 +237,13 @@ void rtw_wep_decrypt(struct adapter  *padapter, u8 *precvframe)
 		*((u32 *)crc) = le32_to_cpu(getcrc32(payload, length-4));
 
 		if (crc[3] != payload[length-1] || crc[2] != payload[length-2] || crc[1] != payload[length-3] || crc[0] != payload[length-4]) {
-			RT_TRACE(_module_rtl871x_security_c_,
-				 _drv_err_,
-				 ("%s:icv error crc[3](%x)!=payload[length-1](%x) || crc[2](%x)!=payload[length-2](%x) || crc[1](%x)!=payload[length-3](%x) || crc[0](%x)!=payload[length-4](%x)\n",
+			pr_err("%s %s:icv error crc[3](%x)!=payload[length-1](%x) || crc[2](%x)!=payload[length-2](%x) || crc[1](%x)!=payload[length-3](%x) || crc[0](%x)!=payload[length-4](%x)\n",
+					DRIVER_PREFIX,
 					__func__,
 					crc[3], payload[length - 1],
 					crc[2], payload[length - 2],
 					crc[1], payload[length - 3],
-					crc[0], payload[length - 4]));
+					crc[0], payload[length - 4]);
 		}
 	}
 }
@@ -609,7 +608,7 @@ u32 rtw_tkip_encrypt(struct adapter *padapter, u8 *pxmitframe)
 	if (pattrib->encrypt == _TKIP_) {
 
 		{
-			RT_TRACE(_module_rtl871x_security_c_, _drv_err_, ("%s: stainfo!= NULL!!!\n", __func__));
+			pr_err("%s %s: stainfo!= NULL!!!\n", DRIVER_PREFIX, __func__);
 
 			if (IS_MCAST(pattrib->ra))
 				prwskey = psecuritypriv->dot118021XGrpKey[psecuritypriv->dot118021XGrpKeyid].skey;
@@ -631,7 +630,8 @@ u32 rtw_tkip_encrypt(struct adapter *padapter, u8 *pxmitframe)
 
 				if ((curfragnum+1) == pattrib->nr_frags) {	/* 4 the last fragment */
 					length = pattrib->last_txcmdsz-pattrib->hdrlen-pattrib->iv_len-pattrib->icv_len;
-					RT_TRACE(_module_rtl871x_security_c_, _drv_info_, ("pattrib->iv_len =%x, pattrib->icv_len =%x\n", pattrib->iv_len, pattrib->icv_len));
+					pr_info("%s %s: pattrib->iv_len =%x, pattrib->icv_len =%x\n",
+						DRIVER_PREFIX, __func__, pattrib->iv_len, pattrib->icv_len);
 					*((__le32 *)crc) = getcrc32(payload, length);/* modified by Amy*/
 
 					arcfour_init(&mycontext, rc4key, 16);
@@ -740,17 +740,16 @@ u32 rtw_tkip_decrypt(struct adapter *padapter, u8 *precvframe)
 			*((u32 *)crc) = le32_to_cpu(getcrc32(payload, length-4));
 
 			if (crc[3] != payload[length-1] || crc[2] != payload[length-2] || crc[1] != payload[length-3] || crc[0] != payload[length-4]) {
-				RT_TRACE(_module_rtl871x_security_c_,
-					 _drv_err_,
-					 ("rtw_wep_decrypt:icv error crc[3](%x)!=payload[length-1](%x) || crc[2](%x)!=payload[length-2](%x) || crc[1](%x)!=payload[length-3](%x) || crc[0](%x)!=payload[length-4](%x)\n",
+				pr_err("%s %s:icv error crc[3](%x)!=payload[length-1](%x) || crc[2](%x)!=payload[length-2](%x) || crc[1](%x)!=payload[length-3](%x) || crc[0](%x)!=payload[length-4](%x)\n",
+						DRIVER_PREFIX, __func__,
 						crc[3], payload[length - 1],
 						crc[2], payload[length - 2],
 						crc[1], payload[length - 3],
-						crc[0], payload[length - 4]));
+						crc[0], payload[length - 4]);
 				res = _FAIL;
 			}
 		} else {
-			RT_TRACE(_module_rtl871x_security_c_, _drv_err_, ("%s: stainfo == NULL!!!\n", __func__));
+			pr_err("%s %s: stainfo == NULL!!!\n", DRIVER_PREFIX, __func__);
 			res = _FAIL;
 		}
 	}
@@ -1380,7 +1379,7 @@ u32 rtw_aes_encrypt(struct adapter *padapter, u8 *pxmitframe)
 
 	/* 4 start to encrypt each fragment */
 	if (pattrib->encrypt == _AES_) {
-		RT_TRACE(_module_rtl871x_security_c_, _drv_err_, ("%s: stainfo!= NULL!!!\n", __func__));
+		pr_err("%s %s: stainfo!= NULL!!!\n", DRIVER_PREFIX, __func__);
 
 		if (IS_MCAST(pattrib->ra))
 			prwskey = psecuritypriv->dot118021XGrpKey[psecuritypriv->dot118021XGrpKeyid].skey;
@@ -1611,13 +1610,12 @@ static signed int aes_decipher(u8 *key, uint	hdrlen,
 	/* compare the mic */
 	for (i = 0; i < 8; i++) {
 		if (pframe[hdrlen+8+plen-8+i] != message[hdrlen+8+plen-8+i]) {
-			RT_TRACE(_module_rtl871x_security_c_,
-				 _drv_err_,
-				 ("%s:mic check error mic[%d]: pframe(%x) != message(%x)\n",
+			pr_err("%s %s:mic check error mic[%d]: pframe(%x) != message(%x)\n",
+					DRIVER_PREFIX,
 					__func__,
 					i,
 					pframe[hdrlen + 8 + plen - 8 + i],
-					message[hdrlen + 8 + plen - 8 + i]));
+					message[hdrlen + 8 + plen - 8 + i]);
 			DBG_871X("%s:mic check error mic[%d]: pframe(%x) != message(%x)\n",
 					__func__,
 					i,
@@ -1649,9 +1647,7 @@ u32 rtw_aes_decrypt(struct adapter *padapter, u8 *precvframe)
 	if (prxattrib->encrypt == _AES_) {
 		stainfo = rtw_get_stainfo(&padapter->stapriv, &prxattrib->ta[0]);
 		if (stainfo) {
-			RT_TRACE(_module_rtl871x_security_c_,
-				 _drv_err_,
-				 ("%s: stainfo!= NULL!!!\n", __func__));
+			pr_err("%s %s: stainfo!= NULL!!!\n", DRIVER_PREFIX, __func__);
 
 			if (IS_MCAST(prxattrib->ra)) {
 				static unsigned long start;
@@ -1706,9 +1702,7 @@ u32 rtw_aes_decrypt(struct adapter *padapter, u8 *precvframe)
 			res = aes_decipher(prwskey, prxattrib->hdrlen, pframe, length);
 
 		} else {
-			RT_TRACE(_module_rtl871x_security_c_,
-				 _drv_err_,
-				 ("%s: stainfo == NULL!!!\n", __func__));
+			pr_err("%s %s: stainfo == NULL!!!\n", DRIVER_PREFIX, __func__);
 			res = _FAIL;
 		}
 	}
-- 
2.20.1

