Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BEE3C3B39F5
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Jun 2021 02:08:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233000AbhFYAKv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 24 Jun 2021 20:10:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34252 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232934AbhFYAKb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Jun 2021 20:10:31 -0400
Received: from mail-qv1-xf35.google.com (mail-qv1-xf35.google.com [IPv6:2607:f8b0:4864:20::f35])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BB696C061756
        for <linux-kernel@vger.kernel.org>; Thu, 24 Jun 2021 17:08:10 -0700 (PDT)
Received: by mail-qv1-xf35.google.com with SMTP id f16so4310248qvs.7
        for <linux-kernel@vger.kernel.org>; Thu, 24 Jun 2021 17:08:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=philpotter-co-uk.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=M7CMwbgaLq1F207AcMD6q9WIwa6zEqp22bELH0ZCw5w=;
        b=jJfRGrC7OmQRGd1k/fC0xNg4BuRmv4RaxqOZmwtYNXmtBdwO9Qspl29xQBud5OG4+j
         0r+QjPPFNFkZLdUn8bQSWON/hptktS5CashQoy2IC7Pwkl8/18RSB1rddXYL2Pmd1CSe
         dj9i/3+94E+RCSEOQNgyFkZkd/ktFqTHXalMyr5BNzPeSwU2SeIMQ9qSHutLsQLWIR/l
         xFWiva0ejcV60z94MbwzhZ/CUP4YT/uBUMxTDMfUDDTX+Ew3s6i5ZieMuG29SpiKPodp
         UaxGEywztgcnhdNjE4span9PMZC4ijGQtdGDJRSXHes5ZG4+8D5SWKBZBBdjtyhz0Cdm
         a91g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=M7CMwbgaLq1F207AcMD6q9WIwa6zEqp22bELH0ZCw5w=;
        b=bYMEct7ZKm8u/quMa9f4EGu/pDaVJlifPDIl73/7hiIlzVGEDMRttrV+lFZkalkJWW
         X/0gX98Gxm72niMduZuvFjinVaOtrpHbNeU71jIzx20p5I5TB4ECM8bimDLqjHtYvMAQ
         FlBb6q9wbay0A2w1tyd5yPt5ew1iR663vZ6cVvpxNEupTyhnR9vVOsJb7YEjApZzW9Q0
         avTWCv0J8wv9W2eAQmLEhmAkqlP8Q+umQPP0IsSGee9XH7CPlLg9JPIJ2r9ofQ4YjoD7
         liu1tZqFFWSO3a4FLMbryJPJuTFnv/xgOy4DH482eJBuXjGfnKCB1yZZyb1VObRRipiZ
         8IJQ==
X-Gm-Message-State: AOAM533Ssg2shPFckdrRxog/ydXfnH2a9G6dV8Yt5c7Ofrc/E1n3Y1b3
        AKefhgomMjr9Z7npkXN1XGV9rV9NRNnnug==
X-Google-Smtp-Source: ABdhPJzGLI9c95PNHHqQdG98O+VHepcd/mPy7A3ocqaNBMW8ORigvvAU3aE2890upPGS0k2bE+UwiQ==
X-Received: by 2002:a0c:ff48:: with SMTP id y8mr8319633qvt.29.1624579689919;
        Thu, 24 Jun 2021 17:08:09 -0700 (PDT)
Received: from kerneldevvm.. (5.6.a.8.a.a.b.f.c.9.4.c.a.9.a.a.0.a.1.e.e.d.f.d.0.b.8.0.1.0.0.2.ip6.arpa. [2001:8b0:dfde:e1a0:aa9a:c49c:fbaa:8a65])
        by smtp.gmail.com with ESMTPSA id m187sm3629014qkd.131.2021.06.24.17.08.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 24 Jun 2021 17:08:09 -0700 (PDT)
From:   Phillip Potter <phil@philpotter.co.uk>
To:     gregkh@linuxfoundation.org
Cc:     Larry.Finger@lwfinger.net, dan.carpenter@oracle.com,
        linux-kernel@vger.kernel.org, linux-staging@lists.linux.dev
Subject: [PATCH 06/23] staging: rtl8188eu: remove all RT_TRACE calls from core/rtw_security.c
Date:   Fri, 25 Jun 2021 01:07:39 +0100
Message-Id: <20210625000756.6313-7-phil@philpotter.co.uk>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20210625000756.6313-1-phil@philpotter.co.uk>
References: <20210625000756.6313-1-phil@philpotter.co.uk>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Remove all RT_TRACE calls from core/rtw_security.c as this macro is
unnecessary, and these calls are dubious in terms of necessity.
Removing all calls will ultimately allow the removal of the macro
itself.

Signed-off-by: Phillip Potter <phil@philpotter.co.uk>
---
 drivers/staging/rtl8188eu/core/rtw_security.c | 21 ++-----------------
 1 file changed, 2 insertions(+), 19 deletions(-)

diff --git a/drivers/staging/rtl8188eu/core/rtw_security.c b/drivers/staging/rtl8188eu/core/rtw_security.c
index 2c863facd812..1b2cb6196463 100644
--- a/drivers/staging/rtl8188eu/core/rtw_security.c
+++ b/drivers/staging/rtl8188eu/core/rtw_security.c
@@ -591,8 +591,6 @@ u32	rtw_tkip_encrypt(struct adapter *padapter, struct xmit_frame *pxmitframe)
 			stainfo = rtw_get_stainfo(&padapter->stapriv, &pattrib->ra[0]);
 
 		if (stainfo) {
-			RT_TRACE(_module_rtl871x_security_c_, _drv_err_, ("%s: stainfo!= NULL!!!\n", __func__));
-
 			if (is_multicast_ether_addr(pattrib->ra))
 				prwskey = psecuritypriv->dot118021XGrpKey[psecuritypriv->dot118021XGrpKeyid].skey;
 			else
@@ -611,9 +609,6 @@ u32	rtw_tkip_encrypt(struct adapter *padapter, struct xmit_frame *pxmitframe)
 
 				if ((curfragnum + 1) == pattrib->nr_frags) {	/* 4 the last fragment */
 					length = pattrib->last_txcmdsz - pattrib->hdrlen - pattrib->iv_len - pattrib->icv_len;
-					RT_TRACE(_module_rtl871x_security_c_, _drv_info_,
-						 ("pattrib->iv_len=%x, pattrib->icv_len=%x\n",
-						 pattrib->iv_len, pattrib->icv_len));
 					*((__le32 *)crc) = getcrc32(payload, length);/* modified by Amy*/
 
 					arcfour_init(&mycontext, rc4key, 16);
@@ -631,7 +626,6 @@ u32	rtw_tkip_encrypt(struct adapter *padapter, struct xmit_frame *pxmitframe)
 				}
 			}
 		} else {
-			RT_TRACE(_module_rtl871x_security_c_, _drv_err_, ("%s: stainfo==NULL!!!\n", __func__));
 			res = _FAIL;
 		}
 	}
@@ -668,7 +662,6 @@ u32 rtw_tkip_decrypt(struct adapter *padapter, struct recv_frame *precvframe)
 				}
 				prwskey = psecuritypriv->dot118021XGrpKey[prxattrib->key_index].skey;
 			} else {
-				RT_TRACE(_module_rtl871x_security_c_, _drv_err_, ("%s: stainfo!= NULL!!!\n", __func__));
 				prwskey = &stainfo->dot118021x_UncstKey.skey[0];
 			}
 
@@ -694,14 +687,9 @@ u32 rtw_tkip_decrypt(struct adapter *padapter, struct recv_frame *precvframe)
 			if (crc[3] != payload[length - 1] ||
 			    crc[2] != payload[length - 2] ||
 			    crc[1] != payload[length - 3] ||
-			    crc[0] != payload[length - 4]) {
-				RT_TRACE(_module_rtl871x_security_c_, _drv_err_,
-					 ("rtw_wep_decrypt:icv error crc (%4ph)!=payload (%4ph)\n",
-					 &crc, &payload[length - 4]));
+			    crc[0] != payload[length - 4])
 				res = _FAIL;
-			}
 		} else {
-			RT_TRACE(_module_rtl871x_security_c_, _drv_err_, ("%s: stainfo==NULL!!!\n", __func__));
 			res = _FAIL;
 		}
 	}
@@ -743,10 +731,8 @@ u32 rtw_aes_encrypt(struct adapter *padapter, struct xmit_frame *pxmitframe)
 	else
 		stainfo = rtw_get_stainfo(&padapter->stapriv, &pattrib->ra[0]);
 
-	if (!stainfo) {
-		RT_TRACE(_module_rtl871x_security_c_, _drv_err_, ("%s: stainfo==NULL!!!\n", __func__));
+	if (!stainfo)
 		return _FAIL;
-	}
 
 	crypto_ops = lib80211_get_crypto_ops("CCMP");
 
@@ -771,8 +757,6 @@ u32 rtw_aes_encrypt(struct adapter *padapter, struct xmit_frame *pxmitframe)
 		goto exit_crypto_ops_deinit;
 	}
 
-	RT_TRACE(_module_rtl871x_security_c_, _drv_err_, ("%s: stainfo!= NULL!!!\n", __func__));
-
 	for (curfragnum = 0; curfragnum < pattrib->nr_frags; curfragnum++) {
 		if (curfragnum + 1 == pattrib->nr_frags)
 			length = pattrib->last_txcmdsz;
@@ -877,7 +861,6 @@ u32 rtw_aes_decrypt(struct adapter *padapter, struct recv_frame *precvframe)
 			if (crypto_ops && crypto_private)
 				crypto_ops->deinit(crypto_private);
 		} else {
-			RT_TRACE(_module_rtl871x_security_c_, _drv_err_, ("rtw_aes_encrypt: stainfo==NULL!!!\n"));
 			res = _FAIL;
 		}
 	}
-- 
2.31.1

