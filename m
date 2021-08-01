Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CF1CA3DCD2B
	for <lists+linux-kernel@lfdr.de>; Sun,  1 Aug 2021 21:05:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232170AbhHATFN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 1 Aug 2021 15:05:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54422 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230341AbhHATE5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 1 Aug 2021 15:04:57 -0400
Received: from mail-wr1-x432.google.com (mail-wr1-x432.google.com [IPv6:2a00:1450:4864:20::432])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E14BFC061796
        for <linux-kernel@vger.kernel.org>; Sun,  1 Aug 2021 12:04:48 -0700 (PDT)
Received: by mail-wr1-x432.google.com with SMTP id h13so5313993wrp.1
        for <linux-kernel@vger.kernel.org>; Sun, 01 Aug 2021 12:04:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=philpotter-co-uk.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=kdV8/s2ZaGPcTKUx15rayYaL1wTrixDIcE4vWJaabZA=;
        b=JrbrLlsAYrGkATQSUcuiwomKZxeBmcauJIKTu00+jlrEkdV01KWPzVQbI1eLZ53ack
         jD5G9Fjct+QaUjVmXLRdGm5adnDZsYIoVXrCs7t+cvwXMfCAtft4/Spmyh3abibtNsXO
         9Ud7ABQVWQyCgyzUhWAFKzMQaVR4ran/nDTAbnf/pF5sZjRBNDsLW0arPh3ytIHY8K7j
         qxLIarH0rXeVk945ReKOzjLuKtdT6N5R0A+QkQ8j2wyUT+HUQuKrGpfuNjY0p9SdxGLg
         77ZeTYjSiVWiaK2SsLFQFb4rHc/Jzba0Pzzf9o/O/QKFfjI11Zl3WRwCznCgDIeZnSjW
         U9sg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=kdV8/s2ZaGPcTKUx15rayYaL1wTrixDIcE4vWJaabZA=;
        b=o18E3sXq5Lp8b1keVtj9ubgvH5lxBQqf7vHPCmNulqFFcNelfYWHQmzqmUVMHFY/2V
         NxGWdkWqfO3N7SuMeE84sDQGRCMuI32sVAfgp4dxIoSW/FGn8Pv4TY8Fg5Lbb9xLpE6n
         +6Dw0bcNWJ3KJJfMUO/jpNyZpUxsucMOiTt/e8iYMoet5u7xEh6IZVAZyUTYhkBGUq4E
         +6TZ9tbjq8JhJACEcFJQMDOrqbkJXOobl/I7Bd5rlvbKXoOQIA/9zbJ+FFWBq0RZ99qe
         q18g/qr6iRT7J4I8JU1d7/sfW9Enss9M0DqCxfx4w9Heid+BQx4W/+PRfxCLeYsFdG/t
         gYzg==
X-Gm-Message-State: AOAM531th7Wk3dpvsWLrOcW2i7yonJxSBCPB7lR14k/8PsyZDOJATxFJ
        KQ8G5jkvmWh6wfnUiy58ypNVfg==
X-Google-Smtp-Source: ABdhPJzRZKWMkdgyLLV5rr5ehzTGnvsBpCYMMPh3BkXCR2VkHdbZl0N+n/agw5mFTPhGxGJfkl37xg==
X-Received: by 2002:a5d:4e91:: with SMTP id e17mr13794723wru.7.1627844687490;
        Sun, 01 Aug 2021 12:04:47 -0700 (PDT)
Received: from localhost.localdomain (3.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.6.1.f.d.0.b.8.0.1.0.0.2.ip6.arpa. [2001:8b0:df16::3])
        by smtp.gmail.com with ESMTPSA id c10sm8196026wmb.40.2021.08.01.12.04.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 01 Aug 2021 12:04:47 -0700 (PDT)
From:   Phillip Potter <phil@philpotter.co.uk>
To:     gregkh@linuxfoundation.org
Cc:     Larry.Finger@lwfinger.net, linux-staging@lists.linux.dev,
        linux-kernel@vger.kernel.org, martin@kaiser.cx
Subject: [PATCH 10/15] staging: r8188eu: remove RT_TRACE calls from core/rtw_security.c
Date:   Sun,  1 Aug 2021 20:04:32 +0100
Message-Id: <20210801190437.82017-11-phil@philpotter.co.uk>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20210801190437.82017-1-phil@philpotter.co.uk>
References: <20210801190437.82017-1-phil@philpotter.co.uk>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Remove RT_TRACE macro calls from core/rtw_security.c, so that ultimately the
macro definition itself can eventually be removed.

Signed-off-by: Phillip Potter <phil@philpotter.co.uk>
---
 drivers/staging/r8188eu/core/rtw_security.c | 37 +--------------------
 1 file changed, 1 insertion(+), 36 deletions(-)

diff --git a/drivers/staging/r8188eu/core/rtw_security.c b/drivers/staging/r8188eu/core/rtw_security.c
index 2c1b9a6dcdf2..1305031c0908 100644
--- a/drivers/staging/r8188eu/core/rtw_security.c
+++ b/drivers/staging/r8188eu/core/rtw_security.c
@@ -170,15 +170,6 @@ void rtw_wep_decrypt(struct adapter  *padapter, u8 *precvframe)
 
 		/* calculate icv and compare the icv */
 		crc.f0 = cpu_to_le32(~crc32_le(~0, payload, length));
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
 
 	return;
@@ -556,8 +547,6 @@ u32	rtw_tkip_encrypt(struct adapter *padapter, u8 *pxmitframe)
 			stainfo = rtw_get_stainfo(&padapter->stapriv, &pattrib->ra[0]);
 
 		if (stainfo != NULL) {
-			RT_TRACE(_module_rtl871x_security_c_, _drv_err_, ("rtw_tkip_encrypt: stainfo!= NULL!!!\n"));
-
 			if (IS_MCAST(pattrib->ra))
 				prwskey = psecuritypriv->dot118021XGrpKey[psecuritypriv->dot118021XGrpKeyid].skey;
 			else
@@ -576,9 +565,6 @@ u32	rtw_tkip_encrypt(struct adapter *padapter, u8 *pxmitframe)
 
 				if ((curfragnum+1) == pattrib->nr_frags) {	/* 4 the last fragment */
 					length = pattrib->last_txcmdsz-pattrib->hdrlen-pattrib->iv_len-pattrib->icv_len;
-					RT_TRACE(_module_rtl871x_security_c_, _drv_info_,
-						 ("pattrib->iv_len=%x, pattrib->icv_len=%x\n",
-						 pattrib->iv_len, pattrib->icv_len));
 					crc.f0 = cpu_to_le32(~crc32_le(~0, payload, length));
 
 					arcfour_init(&mycontext, rc4key, 16);
@@ -597,7 +583,6 @@ u32	rtw_tkip_encrypt(struct adapter *padapter, u8 *pxmitframe)
 				}
 			}
 		} else {
-			RT_TRACE(_module_rtl871x_security_c_, _drv_err_, ("rtw_tkip_encrypt: stainfo==NULL!!!\n"));
 			res = _FAIL;
 		}
 	}
@@ -640,7 +625,6 @@ u32 rtw_tkip_decrypt(struct adapter *padapter, u8 *precvframe)
 				}
 				prwskey = psecuritypriv->dot118021XGrpKey[prxattrib->key_index].skey;
 			} else {
-				RT_TRACE(_module_rtl871x_security_c_, _drv_err_, ("rtw_tkip_decrypt: stainfo!= NULL!!!\n"));
 				prwskey = &stainfo->dot118021x_UncstKey.skey[0];
 			}
 
@@ -666,14 +650,9 @@ u32 rtw_tkip_decrypt(struct adapter *padapter, u8 *precvframe)
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
@@ -1218,8 +1197,6 @@ u32	rtw_aes_encrypt(struct adapter *padapter, u8 *pxmitframe)
 			stainfo = rtw_get_stainfo(&padapter->stapriv, &pattrib->ra[0]);
 
 		if (stainfo != NULL) {
-			RT_TRACE(_module_rtl871x_security_c_, _drv_err_, ("rtw_aes_encrypt: stainfo!= NULL!!!\n"));
-
 			if (IS_MCAST(pattrib->ra))
 				prwskey = psecuritypriv->dot118021XGrpKey[psecuritypriv->dot118021XGrpKeyid].skey;
 			else
@@ -1238,7 +1215,6 @@ u32	rtw_aes_encrypt(struct adapter *padapter, u8 *pxmitframe)
 				}
 			}
 		} else {
-			RT_TRACE(_module_rtl871x_security_c_, _drv_err_, ("rtw_aes_encrypt: stainfo==NULL!!!\n"));
 			res = _FAIL;
 		}
 	}
@@ -1430,9 +1406,6 @@ static int aes_decipher(u8 *key, uint	hdrlen,
 	/* compare the mic */
 	for (i = 0; i < 8; i++) {
 		if (pframe[hdrlen+8+plen-8+i] != message[hdrlen+8+plen-8+i]) {
-			RT_TRACE(_module_rtl871x_security_c_, _drv_err_,
-				 ("aes_decipher:mic check error mic[%d]: pframe(%x)!=message(%x)\n",
-				 i, pframe[hdrlen+8+plen-8+i], message[hdrlen+8+plen-8+i]));
 			DBG_88E("aes_decipher:mic check error mic[%d]: pframe(%x)!=message(%x)\n",
 				i, pframe[hdrlen+8+plen-8+i], message[hdrlen+8+plen-8+i]);
 			res = _FAIL;
@@ -1457,8 +1430,6 @@ u32	rtw_aes_decrypt(struct adapter *padapter, u8 *precvframe)
 	if ((prxattrib->encrypt == _AES_)) {
 		stainfo = rtw_get_stainfo(&padapter->stapriv, &prxattrib->ta[0]);
 		if (stainfo != NULL) {
-			RT_TRACE(_module_rtl871x_security_c_, _drv_err_, ("rtw_aes_decrypt: stainfo!= NULL!!!\n"));
-
 			if (IS_MCAST(prxattrib->ra)) {
 				/* in concurrent we should use sw descrypt in group key, so we remove this message */
 				if (!psecuritypriv->binstallGrpkey) {
@@ -1479,7 +1450,6 @@ u32	rtw_aes_decrypt(struct adapter *padapter, u8 *precvframe)
 			length = ((struct recv_frame *)precvframe)->len-prxattrib->hdrlen-prxattrib->iv_len;
 			res = aes_decipher(prwskey, prxattrib->hdrlen, pframe, length);
 		} else {
-			RT_TRACE(_module_rtl871x_security_c_, _drv_err_, ("rtw_aes_encrypt: stainfo==NULL!!!\n"));
 			res = _FAIL;
 		}
 	}
@@ -1691,10 +1661,5 @@ void rtw_use_tkipkey_handler(void *FunctionContext)
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

