Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 52F2D3511DE
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Apr 2021 11:23:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233914AbhDAJWT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 1 Apr 2021 05:22:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36156 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233604AbhDAJV3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Apr 2021 05:21:29 -0400
Received: from mail-ej1-x633.google.com (mail-ej1-x633.google.com [IPv6:2a00:1450:4864:20::633])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 21521C0613E6
        for <linux-kernel@vger.kernel.org>; Thu,  1 Apr 2021 02:21:29 -0700 (PDT)
Received: by mail-ej1-x633.google.com with SMTP id u9so1834457ejj.7
        for <linux-kernel@vger.kernel.org>; Thu, 01 Apr 2021 02:21:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=qJ+z4GRvp6xWxohaneI4U12MnMDZcA/OioXqlPie9qY=;
        b=rCVt77+reOsA/dWJBqoxfV1jUjmLt+xbWbCTARPBHR4240Ua/5OW+LpObXDI1G+6Uo
         iJ8XVypWKHCw9iedqKfuvWxNi9GUGAX88vPdMYEOAno2v5XTGBMgBIx5tEaKL7C4e2gL
         RiblNbE3Yku2yi4m+Cfi5r1cFOE2M6uF32vSS0xObhlAU9XDMoeFZ1prcBki14YlgT73
         vHQM7DAI4QgvGU6A/obU2d3DqCCRlNGy35JhJ/nePID1h1z5RjpSapzi2Nhqf0bq9gWX
         zxR3c67A+DdsiyMaoZuHoZS2cYikYnZlMSto36ch1ApfEz4rVXjfqs3ZT1Xb/KNqor93
         HNlw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=qJ+z4GRvp6xWxohaneI4U12MnMDZcA/OioXqlPie9qY=;
        b=jHyvTFy4LBeygVjQVvZptn2jL9DCVClXfeBUWzG3l71WjBuEzrvnavMGQWw48q1FKu
         fbQn0K1avW4KJLt7+UuTXtTmzJ/vAfIPGAq7QL7Y/PIxj1Fg4ewYFRNV1vzgjPElOEjo
         lmO4m7BwsKOUsDMcalSbTkBgP23r6CejMmy4aJTZEaPIE7s9qyhDAmIkubTTX15jQhdM
         wasJyaXyC+IxrsKQd12eHUW/Bvk1D9s7Uc8yc69zuf0pVU4Sey/uvlSdx7NBaR/GtbJ7
         AvRnRq5OeWvEKr9LS5mzi5pxm7q3wtM7PkxV2sHQpM8edfzSAhrc02shWlzr/1ymXDt6
         aUCg==
X-Gm-Message-State: AOAM530Oxg877i+5+mVk67Lffp6ubm0VFgB3tx2R1/Ja6wORkSUOkrVl
        bKEQFtpunnv3F/fqbOBJKos=
X-Google-Smtp-Source: ABdhPJw/pWNPXv6A3kHzubX4nM6TbC9Zet2PurRvTwasVdftlhIo3z+IsHi/euUtVWvAgcEn1EMnYg==
X-Received: by 2002:a17:906:f84b:: with SMTP id ks11mr7999251ejb.296.1617268887934;
        Thu, 01 Apr 2021 02:21:27 -0700 (PDT)
Received: from agape ([5.171.80.247])
        by smtp.gmail.com with ESMTPSA id m14sm3220528edr.13.2021.04.01.02.21.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 01 Apr 2021 02:21:27 -0700 (PDT)
From:   Fabio Aiuto <fabioaiuto83@gmail.com>
To:     gregkh@linuxfoundation.org
Cc:     joe@perches.com, dan.carpenter@oracle.com,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org,
        Fabio Aiuto <fabioaiuto83@gmail.com>
Subject: [PATCH 03/49] staging: rtl8723bs: remove RT_TRACE logs in core/rtw_security.c
Date:   Thu,  1 Apr 2021 11:20:33 +0200
Message-Id: <2afb6539b2d96fec99e484123be222a39fe446b0.1617268327.git.fabioaiuto83@gmail.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <cover.1617268327.git.fabioaiuto83@gmail.com>
References: <cover.1617268327.git.fabioaiuto83@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

remove all RT_TRACE logs in core/rtw_security.c

Signed-off-by: Fabio Aiuto <fabioaiuto83@gmail.com>
---
 drivers/staging/rtl8723bs/core/rtw_security.c | 35 -------------------
 1 file changed, 35 deletions(-)

diff --git a/drivers/staging/rtl8723bs/core/rtw_security.c b/drivers/staging/rtl8723bs/core/rtw_security.c
index 8a447e149438..c91a1eef40b3 100644
--- a/drivers/staging/rtl8723bs/core/rtw_security.c
+++ b/drivers/staging/rtl8723bs/core/rtw_security.c
@@ -237,14 +237,6 @@ void rtw_wep_decrypt(struct adapter  *padapter, u8 *precvframe)
 		*((u32 *)crc) = le32_to_cpu(getcrc32(payload, length-4));
 
 		if (crc[3] != payload[length-1] || crc[2] != payload[length-2] || crc[1] != payload[length-3] || crc[0] != payload[length-4]) {
-			RT_TRACE(_module_rtl871x_security_c_,
-				 _drv_err_,
-				 ("%s:icv error crc[3](%x)!=payload[length-1](%x) || crc[2](%x)!=payload[length-2](%x) || crc[1](%x)!=payload[length-3](%x) || crc[0](%x)!=payload[length-4](%x)\n",
-					__func__,
-					crc[3], payload[length - 1],
-					crc[2], payload[length - 2],
-					crc[1], payload[length - 3],
-					crc[0], payload[length - 4]));
 		}
 	}
 }
@@ -609,8 +601,6 @@ u32 rtw_tkip_encrypt(struct adapter *padapter, u8 *pxmitframe)
 	if (pattrib->encrypt == _TKIP_) {
 
 		{
-			RT_TRACE(_module_rtl871x_security_c_, _drv_err_, ("%s: stainfo!= NULL!!!\n", __func__));
-
 			if (IS_MCAST(pattrib->ra))
 				prwskey = psecuritypriv->dot118021XGrpKey[psecuritypriv->dot118021XGrpKeyid].skey;
 			else
@@ -631,7 +621,6 @@ u32 rtw_tkip_encrypt(struct adapter *padapter, u8 *pxmitframe)
 
 				if ((curfragnum+1) == pattrib->nr_frags) {	/* 4 the last fragment */
 					length = pattrib->last_txcmdsz-pattrib->hdrlen-pattrib->iv_len-pattrib->icv_len;
-					RT_TRACE(_module_rtl871x_security_c_, _drv_info_, ("pattrib->iv_len =%x, pattrib->icv_len =%x\n", pattrib->iv_len, pattrib->icv_len));
 					*((__le32 *)crc) = getcrc32(payload, length);/* modified by Amy*/
 
 					arcfour_init(&mycontext, rc4key, 16);
@@ -740,17 +729,9 @@ u32 rtw_tkip_decrypt(struct adapter *padapter, u8 *precvframe)
 			*((u32 *)crc) = le32_to_cpu(getcrc32(payload, length-4));
 
 			if (crc[3] != payload[length-1] || crc[2] != payload[length-2] || crc[1] != payload[length-3] || crc[0] != payload[length-4]) {
-				RT_TRACE(_module_rtl871x_security_c_,
-					 _drv_err_,
-					 ("rtw_wep_decrypt:icv error crc[3](%x)!=payload[length-1](%x) || crc[2](%x)!=payload[length-2](%x) || crc[1](%x)!=payload[length-3](%x) || crc[0](%x)!=payload[length-4](%x)\n",
-						crc[3], payload[length - 1],
-						crc[2], payload[length - 2],
-						crc[1], payload[length - 3],
-						crc[0], payload[length - 4]));
 				res = _FAIL;
 			}
 		} else {
-			RT_TRACE(_module_rtl871x_security_c_, _drv_err_, ("%s: stainfo == NULL!!!\n", __func__));
 			res = _FAIL;
 		}
 	}
@@ -1380,8 +1361,6 @@ u32 rtw_aes_encrypt(struct adapter *padapter, u8 *pxmitframe)
 
 	/* 4 start to encrypt each fragment */
 	if (pattrib->encrypt == _AES_) {
-		RT_TRACE(_module_rtl871x_security_c_, _drv_err_, ("%s: stainfo!= NULL!!!\n", __func__));
-
 		if (IS_MCAST(pattrib->ra))
 			prwskey = psecuritypriv->dot118021XGrpKey[psecuritypriv->dot118021XGrpKeyid].skey;
 		else
@@ -1611,13 +1590,6 @@ static signed int aes_decipher(u8 *key, uint	hdrlen,
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
@@ -1649,10 +1621,6 @@ u32 rtw_aes_decrypt(struct adapter *padapter, u8 *precvframe)
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
@@ -1706,9 +1674,6 @@ u32 rtw_aes_decrypt(struct adapter *padapter, u8 *precvframe)
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

