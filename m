Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 471903E2014
	for <lists+linux-kernel@lfdr.de>; Fri,  6 Aug 2021 02:40:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243032AbhHFAlL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 5 Aug 2021 20:41:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40460 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242824AbhHFAk7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Aug 2021 20:40:59 -0400
Received: from mail-wm1-x336.google.com (mail-wm1-x336.google.com [IPv6:2a00:1450:4864:20::336])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 29693C06179B
        for <linux-kernel@vger.kernel.org>; Thu,  5 Aug 2021 17:40:44 -0700 (PDT)
Received: by mail-wm1-x336.google.com with SMTP id x17so4461289wmc.5
        for <linux-kernel@vger.kernel.org>; Thu, 05 Aug 2021 17:40:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=philpotter-co-uk.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=GzAalOOTuBO4XEijeAdtdHjWTbg8VwNu8lu94mqSzqE=;
        b=Qvy7SYKiQdgsUT9+m7uND7BsbXU07s1zcM7MxCDI7PD9eoZ4V+EGiqDuyS1yVIyfSR
         /Lq9/N4s0Dcvz0+a2x24r3YZjkAuzSESjsdsTaQZWc0hofZHpLKCXo/j5rthR56gwGRE
         LPeXn/AFYFilzfpKIiNre1YlDsT77/tp+G5KcVSfE1JMbndkx6989C1tvjqv8p79olVw
         e35YHM/BAO9dfvTnl8xWme7YI17C7kHytLTzFS/3zwE19gLJejTvKbmSE1X11O7II25Q
         W6qS2KaLFSxEVBi+BAMD5Fyks+5XMHSfPOx3AZQGOAaf0WxPfhWE6baM88TCLLQMpD9F
         IyRA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=GzAalOOTuBO4XEijeAdtdHjWTbg8VwNu8lu94mqSzqE=;
        b=iUdCxYaFuybWTHNEj6xu5AtEJSL+jNCmNLraArgoelCSBEWr3Uf3m000GIzucGd5QI
         rViiWXxrfIE8iXJ50b0ew82hzklZP+GQYfWh9C6AIgpUlnIWWq95pxpL+Yxl0UBKNTOm
         snPj+Kv/IRHJkaV/qGnOkpjzEBLgicDgpjbXRhcS85K4ssZgJfKVi8E5BBCMw1hBWl6H
         mfh6ZXY2/HGA2FySvzKEUGQgwaVTKZZNW675cEvwVFgpz++VZO2m/8cKGeK5nnafu7T7
         td1/BJ2xkAcKJkivLqJ1ljSW/toCQg6RjIgoY08O9F2s1l48uP20prkOg8keex63vjkB
         TEpw==
X-Gm-Message-State: AOAM532aKe3GUzSLU+RIq10AyEO+3rm0NxGXPCvl1YXan91lWDFtufYK
        9M/VFhWfxbxD7ZrfapgBCSRX/Q==
X-Google-Smtp-Source: ABdhPJxzXk2sxp2wB8B8QXTALU/4FsDAczh/SGo4HpqJXs0C1AEa2A3eyy3sslaj2CW+g0cWJDUZlA==
X-Received: by 2002:a05:600c:4fc4:: with SMTP id o4mr16635885wmq.109.1628210442777;
        Thu, 05 Aug 2021 17:40:42 -0700 (PDT)
Received: from localhost.localdomain (3.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.6.1.f.d.0.b.8.0.1.0.0.2.ip6.arpa. [2001:8b0:df16::3])
        by smtp.gmail.com with ESMTPSA id y19sm10727181wmq.5.2021.08.05.17.40.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 05 Aug 2021 17:40:42 -0700 (PDT)
From:   Phillip Potter <phil@philpotter.co.uk>
To:     gregkh@linuxfoundation.org
Cc:     Larry.Finger@lwfinger.net, linux-staging@lists.linux.dev,
        linux-kernel@vger.kernel.org, martin@kaiser.cx
Subject: [PATCH v2 06/11] staging: r8188eu: remove RT_TRACE calls from core/rtw_security.c
Date:   Fri,  6 Aug 2021 01:40:29 +0100
Message-Id: <20210806004034.82233-7-phil@philpotter.co.uk>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20210806004034.82233-1-phil@philpotter.co.uk>
References: <20210806004034.82233-1-phil@philpotter.co.uk>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Remove RT_TRACE macro calls from core/rtw_security.c, so that ultimately the
macro definition itself can eventually be removed.

Signed-off-by: Phillip Potter <phil@philpotter.co.uk>
---
 drivers/staging/r8188eu/core/rtw_security.c | 44 +--------------------
 1 file changed, 1 insertion(+), 43 deletions(-)

diff --git a/drivers/staging/r8188eu/core/rtw_security.c b/drivers/staging/r8188eu/core/rtw_security.c
index 08a5a1975d11..6cacf7d01626 100644
--- a/drivers/staging/r8188eu/core/rtw_security.c
+++ b/drivers/staging/r8188eu/core/rtw_security.c
@@ -139,10 +139,6 @@ void rtw_wep_encrypt(struct adapter *padapter, u8 *pxmitframe)
 void rtw_wep_decrypt(struct adapter  *padapter, u8 *precvframe)
 {
 	/*  exclude ICV */
-	union {
-		__le32 f0;
-		u8 f1[4];
-	} crc;
 	struct arc4context	 mycontext;
 	int	length;
 	u32	keylength;
@@ -167,18 +163,6 @@ void rtw_wep_decrypt(struct adapter  *padapter, u8 *precvframe)
 		/* decrypt payload include icv */
 		arcfour_init(&mycontext, wepkey, 3+keylength);
 		arcfour_encrypt(&mycontext, payload, payload,  length);
-
-		/* calculate icv and compare the icv */
-		crc.f0 = cpu_to_le32(~crc32_le(~0, payload, length));
-
-		if (crc.f1[3] != payload[length-1] ||
-		    crc.f1[2] != payload[length-2] ||
-		    crc.f1[1] != payload[length-3] ||
-		    crc.f1[0] != payload[length-4]) {
-			RT_TRACE(_module_rtl871x_security_c_, _drv_err_,
-				 ("rtw_wep_decrypt:icv error crc (%4ph)!=payload (%4ph)\n",
-				 &crc, &payload[length-4]));
-		}
 	}
 }
 
@@ -554,8 +538,6 @@ u32	rtw_tkip_encrypt(struct adapter *padapter, u8 *pxmitframe)
 			stainfo = rtw_get_stainfo(&padapter->stapriv, &pattrib->ra[0]);
 
 		if (stainfo) {
-			RT_TRACE(_module_rtl871x_security_c_, _drv_err_, ("rtw_tkip_encrypt: stainfo!= NULL!!!\n"));
-
 			if (IS_MCAST(pattrib->ra))
 				prwskey = psecuritypriv->dot118021XGrpKey[psecuritypriv->dot118021XGrpKeyid].skey;
 			else
@@ -574,9 +556,6 @@ u32	rtw_tkip_encrypt(struct adapter *padapter, u8 *pxmitframe)
 
 				if ((curfragnum+1) == pattrib->nr_frags) {	/* 4 the last fragment */
 					length = pattrib->last_txcmdsz-pattrib->hdrlen-pattrib->iv_len-pattrib->icv_len;
-					RT_TRACE(_module_rtl871x_security_c_, _drv_info_,
-						 ("pattrib->iv_len=%x, pattrib->icv_len=%x\n",
-						 pattrib->iv_len, pattrib->icv_len));
 					crc.f0 = cpu_to_le32(~crc32_le(~0, payload, length));
 
 					arcfour_init(&mycontext, rc4key, 16);
@@ -595,7 +574,6 @@ u32	rtw_tkip_encrypt(struct adapter *padapter, u8 *pxmitframe)
 				}
 			}
 		} else {
-			RT_TRACE(_module_rtl871x_security_c_, _drv_err_, ("rtw_tkip_encrypt: stainfo==NULL!!!\n"));
 			res = _FAIL;
 		}
 	}
@@ -638,7 +616,6 @@ u32 rtw_tkip_decrypt(struct adapter *padapter, u8 *precvframe)
 				}
 				prwskey = psecuritypriv->dot118021XGrpKey[prxattrib->key_index].skey;
 			} else {
-				RT_TRACE(_module_rtl871x_security_c_, _drv_err_, ("rtw_tkip_decrypt: stainfo!= NULL!!!\n"));
 				prwskey = &stainfo->dot118021x_UncstKey.skey[0];
 			}
 
@@ -664,14 +641,9 @@ u32 rtw_tkip_decrypt(struct adapter *padapter, u8 *precvframe)
 			if (crc.f1[3] != payload[length-1] ||
 			    crc.f1[2] != payload[length-2] ||
 			    crc.f1[1] != payload[length-3] ||
-			    crc.f1[0] != payload[length-4]) {
-				RT_TRACE(_module_rtl871x_security_c_, _drv_err_,
-					 ("rtw_wep_decrypt:icv error crc (%4ph)!=payload (%4ph)\n",
-					 &crc, &payload[length-4]));
+			    crc.f1[0] != payload[length-4])
 				res = _FAIL;
-			}
 		} else {
-			RT_TRACE(_module_rtl871x_security_c_, _drv_err_, ("rtw_tkip_decrypt: stainfo==NULL!!!\n"));
 			res = _FAIL;
 		}
 	}
@@ -1216,8 +1188,6 @@ u32	rtw_aes_encrypt(struct adapter *padapter, u8 *pxmitframe)
 			stainfo = rtw_get_stainfo(&padapter->stapriv, &pattrib->ra[0]);
 
 		if (stainfo) {
-			RT_TRACE(_module_rtl871x_security_c_, _drv_err_, ("rtw_aes_encrypt: stainfo!= NULL!!!\n"));
-
 			if (IS_MCAST(pattrib->ra))
 				prwskey = psecuritypriv->dot118021XGrpKey[psecuritypriv->dot118021XGrpKeyid].skey;
 			else
@@ -1236,7 +1206,6 @@ u32	rtw_aes_encrypt(struct adapter *padapter, u8 *pxmitframe)
 				}
 			}
 		} else {
-			RT_TRACE(_module_rtl871x_security_c_, _drv_err_, ("rtw_aes_encrypt: stainfo==NULL!!!\n"));
 			res = _FAIL;
 		}
 	}
@@ -1428,9 +1397,6 @@ static int aes_decipher(u8 *key, uint	hdrlen,
 	/* compare the mic */
 	for (i = 0; i < 8; i++) {
 		if (pframe[hdrlen+8+plen-8+i] != message[hdrlen+8+plen-8+i]) {
-			RT_TRACE(_module_rtl871x_security_c_, _drv_err_,
-				 ("aes_decipher:mic check error mic[%d]: pframe(%x)!=message(%x)\n",
-				 i, pframe[hdrlen+8+plen-8+i], message[hdrlen+8+plen-8+i]));
 			DBG_88E("aes_decipher:mic check error mic[%d]: pframe(%x)!=message(%x)\n",
 				i, pframe[hdrlen+8+plen-8+i], message[hdrlen+8+plen-8+i]);
 			res = _FAIL;
@@ -1455,8 +1421,6 @@ u32	rtw_aes_decrypt(struct adapter *padapter, u8 *precvframe)
 	if (prxattrib->encrypt == _AES_) {
 		stainfo = rtw_get_stainfo(&padapter->stapriv, &prxattrib->ta[0]);
 		if (stainfo) {
-			RT_TRACE(_module_rtl871x_security_c_, _drv_err_, ("rtw_aes_decrypt: stainfo!= NULL!!!\n"));
-
 			if (IS_MCAST(prxattrib->ra)) {
 				/* in concurrent we should use sw descrypt in group key, so we remove this message */
 				if (!psecuritypriv->binstallGrpkey) {
@@ -1477,7 +1441,6 @@ u32	rtw_aes_decrypt(struct adapter *padapter, u8 *precvframe)
 			length = ((struct recv_frame *)precvframe)->len-prxattrib->hdrlen-prxattrib->iv_len;
 			res = aes_decipher(prwskey, prxattrib->hdrlen, pframe, length);
 		} else {
-			RT_TRACE(_module_rtl871x_security_c_, _drv_err_, ("rtw_aes_encrypt: stainfo==NULL!!!\n"));
 			res = _FAIL;
 		}
 	}
@@ -1689,10 +1652,5 @@ void rtw_use_tkipkey_handler(void *FunctionContext)
 {
 	struct adapter *padapter = (struct adapter *)FunctionContext;
 
-	RT_TRACE(_module_rtl871x_security_c_, _drv_err_, ("^^^rtw_use_tkipkey_handler ^^^\n"));
-
 	padapter->securitypriv.busetkipkey = true;
-
-	RT_TRACE(_module_rtl871x_security_c_, _drv_err_, ("^^^rtw_use_tkipkey_handler padapter->securitypriv.busetkipkey=%d^^^\n", padapter->securitypriv.busetkipkey));
-
 }
-- 
2.31.1

