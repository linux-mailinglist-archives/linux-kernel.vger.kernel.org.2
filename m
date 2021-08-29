Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E7E9B3FAB16
	for <lists+linux-kernel@lfdr.de>; Sun, 29 Aug 2021 13:26:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235233AbhH2L1E (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 29 Aug 2021 07:27:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51616 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235195AbhH2L1A (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 29 Aug 2021 07:27:00 -0400
Received: from mail-wm1-x330.google.com (mail-wm1-x330.google.com [IPv6:2a00:1450:4864:20::330])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ADDE1C061575
        for <linux-kernel@vger.kernel.org>; Sun, 29 Aug 2021 04:26:08 -0700 (PDT)
Received: by mail-wm1-x330.google.com with SMTP id 79-20020a1c0452000000b002e6cf79e572so12615208wme.1
        for <linux-kernel@vger.kernel.org>; Sun, 29 Aug 2021 04:26:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=CfeLwTOP79goKm8oOsJNhwDYJPgyypyJ3ipsm685OhE=;
        b=XwrdOSQTq7Y52GKrI0F5rTdBPhwMJYfK491UeTLfrF/58n603ytHuhogX0vZBG9UNl
         PDLTuqnKvkwygbH1sFbr6i0/DJcqjM/+GOz4GmbxQ4bM9woNr55JCNkOJMidrO3VE+nH
         JLIoBP3k+ZbC+Gk5AOnFEKjZRtUnsqiGZv5TQiIbjVIcML1dr32TRx3FRKLdFMQdmDYJ
         TWKk0xrDqG/dAbsvE/JuYZjC30e8wM8/SsDs6+6df9taBs7bDFTpF7cxzsHQV2f6gJ5v
         8ytX0yzaigTV8tU1Y3rTWdpx1KmvTq6I6zKwJMi8QubpJGYmWSV1AYMlT7ZQJ528P+r+
         /emQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=CfeLwTOP79goKm8oOsJNhwDYJPgyypyJ3ipsm685OhE=;
        b=eHC1oK9vVywlp0vtnBui/1hG4en+ga51OYTPaJmxwCxY1uGudilNEdxx3f0kjjTgO6
         l67oSnQQH/od1DMgiAvnia9urgZatwp86dJRrZRs6Ok+e6Anjrh2x3cK2BNw5RHcc1Ct
         JQLzXsJt2uI/BM8BZn1WBmajq6DVctqyroK9H1JJUefU5VRZv5kbmjMM8RergfQh9RKn
         77JegzMYqdEmY5eNlxYD5YU4UqpzwFqcgZKtAdlqCBa07zlOWSG4Rkel60TzYGZBckCc
         uDu31lgyH3uqo+2G7moJUtIpKCnBqrgvCFQuoAIwQaSP72Uqlf92baec0YozLKAOc+ru
         4kPQ==
X-Gm-Message-State: AOAM533vTvf+IDJyyRdn/BZjLel/w62sZ7gC3T9+P5z5CEWQvRAwFi0L
        mO/Vh8K2VkAQ0JMTjhXdFWo=
X-Google-Smtp-Source: ABdhPJy8Ipi8n8NcVEMVfnWG02/L7oADSPQfOdfOVPhyTZySnJdW16NGA7/D1oZj4kkRW5q78Xc03A==
X-Received: by 2002:a05:600c:3ba3:: with SMTP id n35mr5634517wms.166.1630236367225;
        Sun, 29 Aug 2021 04:26:07 -0700 (PDT)
Received: from localhost.localdomain ([2a02:8108:96c0:3b88::16fa])
        by smtp.gmail.com with ESMTPSA id h8sm15826581wmb.35.2021.08.29.04.26.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 29 Aug 2021 04:26:06 -0700 (PDT)
From:   Michael Straube <straube.linux@gmail.com>
To:     gregkh@linuxfoundation.org
Cc:     Larry.Finger@lwfinger.net, phil@philpotter.co.uk, martin@kaiser.cx,
        fmdefrancesco@gmail.com, linux-staging@lists.linux.dev,
        linux-kernel@vger.kernel.org,
        Michael Straube <straube.linux@gmail.com>
Subject: [PATCH 2/3] staging: r8188eu: convert type of second parameter of rtw_*_decrypt()
Date:   Sun, 29 Aug 2021 13:25:54 +0200
Message-Id: <20210829112555.8726-3-straube.linux@gmail.com>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <20210829112555.8726-1-straube.linux@gmail.com>
References: <20210829112555.8726-1-straube.linux@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Convert the type of the second parameter of the rtw_*_decrypt() functions
to struct recv_frame.

All callers of the functions cast the type to (u8 *) and in the functions
it is casted back to the original type. Changing the type of the second
parameter to struct recv_frame avoids these unnecessary casts and improves
readability.

Signed-off-by: Michael Straube <straube.linux@gmail.com>
---
 drivers/staging/r8188eu/core/rtw_recv.c       |  6 ++---
 drivers/staging/r8188eu/core/rtw_security.c   | 25 ++++++++++---------
 .../staging/r8188eu/include/rtw_security.h    |  6 ++---
 3 files changed, 19 insertions(+), 18 deletions(-)

diff --git a/drivers/staging/r8188eu/core/rtw_recv.c b/drivers/staging/r8188eu/core/rtw_recv.c
index e082edfbaad8..019c5364905b 100644
--- a/drivers/staging/r8188eu/core/rtw_recv.c
+++ b/drivers/staging/r8188eu/core/rtw_recv.c
@@ -418,13 +418,13 @@ static struct recv_frame *decryptor(struct adapter *padapter, struct recv_frame
 		switch (prxattrib->encrypt) {
 		case _WEP40_:
 		case _WEP104_:
-			rtw_wep_decrypt(padapter, (u8 *)precv_frame);
+			rtw_wep_decrypt(padapter, precv_frame);
 			break;
 		case _TKIP_:
-			res = rtw_tkip_decrypt(padapter, (u8 *)precv_frame);
+			res = rtw_tkip_decrypt(padapter, precv_frame);
 			break;
 		case _AES_:
-			res = rtw_aes_decrypt(padapter, (u8 *)precv_frame);
+			res = rtw_aes_decrypt(padapter, precv_frame);
 			break;
 		default:
 			break;
diff --git a/drivers/staging/r8188eu/core/rtw_security.c b/drivers/staging/r8188eu/core/rtw_security.c
index 5168159d8ae7..0836f38ca284 100644
--- a/drivers/staging/r8188eu/core/rtw_security.c
+++ b/drivers/staging/r8188eu/core/rtw_security.c
@@ -134,7 +134,7 @@ void rtw_wep_encrypt(struct adapter *padapter, struct xmit_frame *pxmitframe)
 
 }
 
-void rtw_wep_decrypt(struct adapter  *padapter, u8 *precvframe)
+void rtw_wep_decrypt(struct adapter *padapter, struct recv_frame *precvframe)
 {
 	/*  exclude ICV */
 	struct arc4context	 mycontext;
@@ -142,10 +142,10 @@ void rtw_wep_decrypt(struct adapter  *padapter, u8 *precvframe)
 	u32	keylength;
 	u8	*pframe, *payload, *iv, wepkey[16];
 	u8	 keyindex;
-	struct	rx_pkt_attrib	 *prxattrib = &(((struct recv_frame *)precvframe)->attrib);
+	struct	rx_pkt_attrib	 *prxattrib = &precvframe->attrib;
 	struct	security_priv	*psecuritypriv = &padapter->securitypriv;
 
-	pframe = (unsigned char *)((struct recv_frame *)precvframe)->rx_data;
+	pframe = (unsigned char *)precvframe->rx_data;
 
 	/* start to decrypt recvframe */
 	if ((prxattrib->encrypt == _WEP40_) || (prxattrib->encrypt == _WEP104_)) {
@@ -154,7 +154,7 @@ void rtw_wep_decrypt(struct adapter  *padapter, u8 *precvframe)
 		keylength = psecuritypriv->dot11DefKeylen[keyindex];
 		memcpy(&wepkey[0], iv, 3);
 		memcpy(&wepkey[3], &psecuritypriv->dot11DefKey[keyindex].skey[0], keylength);
-		length = ((struct recv_frame *)precvframe)->len - prxattrib->hdrlen - prxattrib->iv_len;
+		length = precvframe->len - prxattrib->hdrlen - prxattrib->iv_len;
 
 		payload = pframe + prxattrib->iv_len + prxattrib->hdrlen;
 
@@ -580,7 +580,7 @@ u32 rtw_tkip_encrypt(struct adapter *padapter, struct xmit_frame *pxmitframe)
 }
 
 /* The hlen isn't include the IV */
-u32 rtw_tkip_decrypt(struct adapter *padapter, u8 *precvframe)
+u32 rtw_tkip_decrypt(struct adapter *padapter, struct recv_frame *precvframe)
 {																	/*  exclude ICV */
 	u16 pnl;
 	u32 pnh;
@@ -596,11 +596,11 @@ u32 rtw_tkip_decrypt(struct adapter *padapter, u8 *precvframe)
 	u8	*pframe, *payload, *iv, *prwskey;
 	union pn48 dot11txpn;
 	struct	sta_info		*stainfo;
-	struct	rx_pkt_attrib	 *prxattrib = &((struct recv_frame *)precvframe)->attrib;
+	struct	rx_pkt_attrib	 *prxattrib = &precvframe->attrib;
 	struct	security_priv	*psecuritypriv = &padapter->securitypriv;
 	u32		res = _SUCCESS;
 
-	pframe = (unsigned char *)((struct recv_frame *)precvframe)->rx_data;
+	pframe = (unsigned char *)precvframe->rx_data;
 
 	/* 4 start to decrypt recvframe */
 	if (prxattrib->encrypt == _TKIP_) {
@@ -619,7 +619,7 @@ u32 rtw_tkip_decrypt(struct adapter *padapter, u8 *precvframe)
 
 			iv = pframe + prxattrib->hdrlen;
 			payload = pframe + prxattrib->iv_len + prxattrib->hdrlen;
-			length = ((struct recv_frame *)precvframe)->len - prxattrib->hdrlen - prxattrib->iv_len;
+			length = precvframe->len - prxattrib->hdrlen - prxattrib->iv_len;
 
 			GET_TKIP_PN(iv, dot11txpn);
 
@@ -1402,17 +1402,18 @@ static int aes_decipher(u8 *key, uint	hdrlen,
 	return res;
 }
 
-u32	rtw_aes_decrypt(struct adapter *padapter, u8 *precvframe)
+u32 rtw_aes_decrypt(struct adapter *padapter, struct recv_frame *precvframe)
 {	/*  exclude ICV */
 	/* Intermediate Buffers */
 	int		length;
 	u8	*pframe, *prwskey;	/*  *payload,*iv */
 	struct	sta_info		*stainfo;
-	struct	rx_pkt_attrib	 *prxattrib = &((struct recv_frame *)precvframe)->attrib;
+	struct	rx_pkt_attrib	 *prxattrib = &precvframe->attrib;
 	struct	security_priv	*psecuritypriv = &padapter->securitypriv;
 	u32	res = _SUCCESS;
 
-	pframe = (unsigned char *)((struct recv_frame *)precvframe)->rx_data;
+	pframe = (unsigned char *)precvframe->rx_data;
+
 	/* 4 start to encrypt each fragment */
 	if (prxattrib->encrypt == _AES_) {
 		stainfo = rtw_get_stainfo(&padapter->stapriv, &prxattrib->ta[0]);
@@ -1434,7 +1435,7 @@ u32	rtw_aes_decrypt(struct adapter *padapter, u8 *precvframe)
 			} else {
 				prwskey = &stainfo->dot118021x_UncstKey.skey[0];
 			}
-			length = ((struct recv_frame *)precvframe)->len - prxattrib->hdrlen - prxattrib->iv_len;
+			length = precvframe->len - prxattrib->hdrlen - prxattrib->iv_len;
 			res = aes_decipher(prwskey, prxattrib->hdrlen, pframe, length);
 		} else {
 			res = _FAIL;
diff --git a/drivers/staging/r8188eu/include/rtw_security.h b/drivers/staging/r8188eu/include/rtw_security.h
index 4e6d4257b7ba..1fc1a4f30eec 100644
--- a/drivers/staging/r8188eu/include/rtw_security.h
+++ b/drivers/staging/r8188eu/include/rtw_security.h
@@ -333,9 +333,9 @@ void rtw_seccalctkipmic(u8 *key, u8 *header, u8 *data, u32 data_len,
 u32 rtw_aes_encrypt(struct adapter *padapter, struct xmit_frame *pxmitframe);
 u32 rtw_tkip_encrypt(struct adapter *padapter, struct xmit_frame *pxmitframe);
 void rtw_wep_encrypt(struct adapter *padapter, struct xmit_frame *pxmitframe);
-u32 rtw_aes_decrypt(struct adapter *padapter, u8  *precvframe);
-u32 rtw_tkip_decrypt(struct adapter *padapter, u8  *precvframe);
-void rtw_wep_decrypt(struct adapter *padapter, u8  *precvframe);
+u32 rtw_aes_decrypt(struct adapter *padapter, struct recv_frame *precvframe);
+u32 rtw_tkip_decrypt(struct adapter *padapter, struct recv_frame *precvframe);
+void rtw_wep_decrypt(struct adapter *padapter, struct recv_frame *precvframe);
 void rtw_use_tkipkey_handler(void *FunctionContext);
 
 #endif	/* __RTL871X_SECURITY_H_ */
-- 
2.32.0

