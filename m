Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 29FBA352E4B
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Apr 2021 19:31:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235444AbhDBRai (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 2 Apr 2021 13:30:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57078 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235198AbhDBRaY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Apr 2021 13:30:24 -0400
Received: from mail-wr1-x42b.google.com (mail-wr1-x42b.google.com [IPv6:2a00:1450:4864:20::42b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 73D29C061788
        for <linux-kernel@vger.kernel.org>; Fri,  2 Apr 2021 10:30:23 -0700 (PDT)
Received: by mail-wr1-x42b.google.com with SMTP id x16so5298852wrn.4
        for <linux-kernel@vger.kernel.org>; Fri, 02 Apr 2021 10:30:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=G+7cGt9orzyceDNPCThHGV/AvN1uPkejCS9eIhzEPOA=;
        b=FHBSdhgfHUXBiycBnExTUPmDi5c8aSdn8EWLYl+nMonijLHGOq3tyQCTIZfOaRlmH2
         isgIwH2sOOiO2ySRrw/VZTeASalUPZPZQxc+1NKvdQpAm1gEJCwtaSYkLTMQeHGGd+aA
         ySJEqpQ6gt9Rd7hihp1+SIg3fEhpjKQugOqFqwU6M0Oy6SI6sdjHbO9dCQCxTPOmb3z/
         qco8LnH+0/nVbIlc8FofMAHKlrSJc3FIWm6pEFSVRg1wfJlXTmxllgqgNzJps554tnRh
         fNfjUxf+00w6hiLIg+3watCnSh8q2UWIFQnrYiI0nTXB1Y4tjfcou0DWtwTFHWAYWMjF
         i1oQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=G+7cGt9orzyceDNPCThHGV/AvN1uPkejCS9eIhzEPOA=;
        b=ArZRK6I/1Cr4fWV6zkS8DIc445124FbS0S/xOLpIauWzays3whfyhIN7hEidPc1RAb
         VHfFcqBD4NqPPHFrmjRfF2EJqcZoraLFrhLPeB/TD1FtxbyWogh5BhPGirPMGuiviOmH
         fq6/E+sKaJRDxmW/++PxjpXqzElQJ6CxD7RlTg12YbB4lljckI4ip9nUzTQ7n8larhqZ
         W1VVj44EarEF8iNobgjSLTLbj8N1rLiKSVxVJZXiQJKcFaWNMbJ8I4t2Jv+w8wtKOz7A
         cSyxhfQM8VDbrj0zcY7MNt9qGv9F4lQXlNqw4PbSAdJxgkitVn3sa7bve4cTC7KSO2rn
         XyfA==
X-Gm-Message-State: AOAM531ePivLVUYS8FJumd0fiNTG/Bz2qwq8GjScZaT9qgiGcy61pxKF
        A0sHrjLh/WDYmYxFbnCLoyy9lTng5keIBw==
X-Google-Smtp-Source: ABdhPJwO0oTP6gv37JHW1dWKeMEggVQVyMfL4VpqyrhZjuusBFrc4TwnuYKkwZnzE00aKkKp/C7kmQ==
X-Received: by 2002:a5d:638f:: with SMTP id p15mr16170030wru.220.1617384622214;
        Fri, 02 Apr 2021 10:30:22 -0700 (PDT)
Received: from agape ([5.171.81.4])
        by smtp.gmail.com with ESMTPSA id q207sm16205871wme.36.2021.04.02.10.30.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 02 Apr 2021 10:30:21 -0700 (PDT)
From:   Fabio Aiuto <fabioaiuto83@gmail.com>
To:     gregkh@linuxfoundation.org
Cc:     dan.carpenter@oracle.com, joe@perches.com,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org,
        Fabio Aiuto <fabioaiuto83@gmail.com>
Subject: [PATCH v2 03/30] staging: rtl8723bs: remove RT_TRACE logs in core/rtw_security.c
Date:   Fri,  2 Apr 2021 19:29:45 +0200
Message-Id: <020d723bcd1764b222282956a8a157e5f25a620e.1617384172.git.fabioaiuto83@gmail.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <cover.1617384172.git.fabioaiuto83@gmail.com>
References: <cover.1617384172.git.fabioaiuto83@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

remove all RT_TRACE logs in core/rtw_security.c

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

