Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 599EE352937
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Apr 2021 12:02:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234649AbhDBKBy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 2 Apr 2021 06:01:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44600 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234479AbhDBKBw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Apr 2021 06:01:52 -0400
Received: from mail-ed1-x535.google.com (mail-ed1-x535.google.com [IPv6:2a00:1450:4864:20::535])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DFF7FC061788
        for <linux-kernel@vger.kernel.org>; Fri,  2 Apr 2021 03:01:50 -0700 (PDT)
Received: by mail-ed1-x535.google.com with SMTP id o19so4954895edc.3
        for <linux-kernel@vger.kernel.org>; Fri, 02 Apr 2021 03:01:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=RR5dNd1HhsdkjoA6cfLbMXCUCseogWnG0uvtveuJ77U=;
        b=X9iS8Qs6nmfb8zar2KT1iXx0gme2RBy8ebmTRJMGKGhnB4NePun7xVko9xhytF0xLC
         j5V+678gre18YqWALUqKrTqXqhy/TZY/dVEEmkm+vcjxnTYcboUY2v0r4ddsBVTxzqnn
         xuIbZ6gzIGPcAAZcbxl+NfS2SzvrwP8xx2TxVAIKmEMMJ0nYUTT2MB0UlZHQePBEPik3
         0AhtyZ0bJ2wBvJhS0vhvAhYOSPBMK/YuInx/anGSPeB6mXuLHKMDdDa5RYF7oyxbrF34
         oJJMNqLXgm9gzUu8BLOBJZb4kEmlPMcIaCrSBTT7rvxOulTx1NOAn748DMb1qNlBd0aJ
         hVNw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=RR5dNd1HhsdkjoA6cfLbMXCUCseogWnG0uvtveuJ77U=;
        b=FKTerQ3TlXt6lHmUTv7SUB7WYaSjtE6e1y7PbLpCWSpynDhHLP5cUdfzxs2u6uq3sg
         1vWOkkHqjWF1qPhD6usTvkv/4URLGf4bhPCCn0EtpxMT9Ewz9C9YXGlI+zuhcRflTl8a
         ybyNMPpfpCdIymI1YADsoKBLhXvqFsQHUwWaYB/3ackRBhP6r1by53VNGjDXAwOOUnEJ
         kmWbeiE3YsEoEmenQcNlNA5O+JQ2H7FrhXnDUdosepgIK+SYNUT0MB5JVNvHv4ZgBk9C
         0+X+MI42hPOZjjfgOGIB2uScYc/JgrkvpC3WxSgANzRaZEsN6YWxjrzjrTXTlTqbfS+H
         HOdg==
X-Gm-Message-State: AOAM531cOLuIYj11GrCLUeFVs8iTH7un10nctLvopJv8WnkXNGv9EM96
        6F7jlk/1XzgkzbOd2rYhTrTdhUTLt8Y=
X-Google-Smtp-Source: ABdhPJx+BmXlo3RIIuuZ35zgaxdJcfU4m3N40nHgPf9JDgLHUZN+wSEtBGGmJe2MZ+Gfir3mIcWaRw==
X-Received: by 2002:aa7:d0cb:: with SMTP id u11mr14640156edo.163.1617357709638;
        Fri, 02 Apr 2021 03:01:49 -0700 (PDT)
Received: from agape ([5.171.72.128])
        by smtp.gmail.com with ESMTPSA id r19sm5124293edp.52.2021.04.02.03.01.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 02 Apr 2021 03:01:49 -0700 (PDT)
From:   Fabio Aiuto <fabioaiuto83@gmail.com>
To:     gregkh@linuxfoundation.org
Cc:     dan.carpenter@oracle.com, joe@perches.com,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org,
        Fabio Aiuto <fabioaiuto83@gmail.com>
Subject: [PATCH 02/16] staging: rtl8723bs: remove RT_TRACE logs in core/rtw_security.c
Date:   Fri,  2 Apr 2021 12:01:22 +0200
Message-Id: <92918e4fd7fe87864e19a92e7db44e6c904d3fbf.1617356821.git.fabioaiuto83@gmail.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <cover.1617356821.git.fabioaiuto83@gmail.com>
References: <cover.1617356821.git.fabioaiuto83@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

remove all RT_TRACE logs in core/rtw_security.c

Signed-off-by: Fabio Aiuto <fabioaiuto83@gmail.com>
---
 drivers/staging/rtl8723bs/core/rtw_security.c | 41 +------------------
 1 file changed, 2 insertions(+), 39 deletions(-)

diff --git a/drivers/staging/rtl8723bs/core/rtw_security.c b/drivers/staging/rtl8723bs/core/rtw_security.c
index 8a447e149438..6c74c0444abc 100644
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
@@ -739,18 +726,10 @@ u32 rtw_tkip_decrypt(struct adapter *padapter, u8 *precvframe)
 
 			*((u32 *)crc) = le32_to_cpu(getcrc32(payload, length-4));
 
-			if (crc[3] != payload[length-1] || crc[2] != payload[length-2] || crc[1] != payload[length-3] || crc[0] != payload[length-4]) {
-				RT_TRACE(_module_rtl871x_security_c_,
-					 _drv_err_,
-					 ("rtw_wep_decrypt:icv error crc[3](%x)!=payload[length-1](%x) || crc[2](%x)!=payload[length-2](%x) || crc[1](%x)!=payload[length-3](%x) || crc[0](%x)!=payload[length-4](%x)\n",
-						crc[3], payload[length - 1],
-						crc[2], payload[length - 2],
-						crc[1], payload[length - 3],
-						crc[0], payload[length - 4]));
+			if (crc[3] != payload[length - 1] || crc[2] != payload[length - 2] ||
+			    crc[1] != payload[length - 3] || crc[0] != payload[length - 4])
 				res = _FAIL;
-			}
 		} else {
-			RT_TRACE(_module_rtl871x_security_c_, _drv_err_, ("%s: stainfo == NULL!!!\n", __func__));
 			res = _FAIL;
 		}
 	}
@@ -1380,8 +1359,6 @@ u32 rtw_aes_encrypt(struct adapter *padapter, u8 *pxmitframe)
 
 	/* 4 start to encrypt each fragment */
 	if (pattrib->encrypt == _AES_) {
-		RT_TRACE(_module_rtl871x_security_c_, _drv_err_, ("%s: stainfo!= NULL!!!\n", __func__));
-
 		if (IS_MCAST(pattrib->ra))
 			prwskey = psecuritypriv->dot118021XGrpKey[psecuritypriv->dot118021XGrpKeyid].skey;
 		else
@@ -1611,13 +1588,6 @@ static signed int aes_decipher(u8 *key, uint	hdrlen,
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
@@ -1649,10 +1619,6 @@ u32 rtw_aes_decrypt(struct adapter *padapter, u8 *precvframe)
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
@@ -1706,9 +1672,6 @@ u32 rtw_aes_decrypt(struct adapter *padapter, u8 *precvframe)
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

