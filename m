Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2A85B3DB735
	for <lists+linux-kernel@lfdr.de>; Fri, 30 Jul 2021 12:37:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238513AbhG3Khx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 30 Jul 2021 06:37:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38536 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238492AbhG3Khu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 30 Jul 2021 06:37:50 -0400
Received: from mail-ej1-x629.google.com (mail-ej1-x629.google.com [IPv6:2a00:1450:4864:20::629])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3C225C061765
        for <linux-kernel@vger.kernel.org>; Fri, 30 Jul 2021 03:37:45 -0700 (PDT)
Received: by mail-ej1-x629.google.com with SMTP id v21so16033795ejg.1
        for <linux-kernel@vger.kernel.org>; Fri, 30 Jul 2021 03:37:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=MgsWzzbcQyrTVc3BV2XqdCjkBlM2G8uCjruEIe4LQ28=;
        b=YVdWOAKkQgBjWnHEcDNcl+VXJbGFdBDE/wW83c9/2I4MWxJcC+ObfmCEA5vViKkiPQ
         Q8nhDKNgvX3tTdlRznk++QHFzeAarrEJBNfW3+vklbW+3jLfun68gNwWE/yCbOW7Bb/m
         d6mlh60JytiMownjXqHuV73Mw7Ik2wUbhkue5laoGWh+V0eovulKf1Z9U1GZDv0EOvOg
         xBeV8spLb+13BhEeW66gf0fTOZrrNvTqbqcddNTBRkIPyg6IuSYkhQ3YSZ313XRSEI6D
         OYeZngKUJARv274nscSZrtrVHbrqbC7eCpDteydELwoWBG8CCDK+q3st15u9XxBVR+MX
         zPWg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=MgsWzzbcQyrTVc3BV2XqdCjkBlM2G8uCjruEIe4LQ28=;
        b=rZh0fGDzqEBrm94Bal04o8H2y76t1aCrGvQCUUtdeHMMF+wg3fodOMOUSoZEFXNDni
         RTlW3JON8hhgy/W3jrU+41DCt/Emqe1/vH5qUWAgyQZijKHrAGKccFgJkwQ0dVdJhiBv
         Yrv8ieieTpmik49OnojmNCv7+m0/OZ9sqjIbhNrgBLgir1TlaUrGTkp0M5E9EDlv++fs
         E8Dpl+ok7Aw3Lyu4vMryWoGqZFSq9gGzZYif1r6YQrtBKdqnhl6aiSlD7Xtjihe/tRs0
         FU2QhaF9rysFtnwf11E8M9vLPgl1JCWQDdd6F5p53GnWOy4LKQe2GqNCWeylgS18BTiA
         Olgw==
X-Gm-Message-State: AOAM531TTnpx0w0D4xKn4VmjXYuGuGSQMP1HK44mABjFqGQ9M224hAh1
        fEeQlttttmzguJsxlfsPLLc=
X-Google-Smtp-Source: ABdhPJxuCN1WBgN8BQIZdgCb8zxZjOJZ5ow8Jb1x2yyVV6xhEvRmIOtHMI31iODsbgoSGG2VrJCQNg==
X-Received: by 2002:a17:907:990d:: with SMTP id ka13mr1961192ejc.392.1627641463860;
        Fri, 30 Jul 2021 03:37:43 -0700 (PDT)
Received: from localhost.localdomain (host-79-26-32-124.retail.telecomitalia.it. [79.26.32.124])
        by smtp.gmail.com with ESMTPSA id v17sm493436edc.47.2021.07.30.03.37.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 30 Jul 2021 03:37:43 -0700 (PDT)
From:   "Fabio M. De Francesco" <fmdefrancesco@gmail.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Larry Finger <Larry.Finger@lwfinger.net>,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org
Cc:     "Fabio M. De Francesco" <fmdefrancesco@gmail.com>
Subject: [PATCH 1/2] staging: r8188eu: Replace a custom function with crc32_le()
Date:   Fri, 30 Jul 2021 12:37:15 +0200
Message-Id: <20210730103716.27210-2-fmdefrancesco@gmail.com>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <20210730103716.27210-1-fmdefrancesco@gmail.com>
References: <20210730103716.27210-1-fmdefrancesco@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Use crc32_le() in place of the custom getcrc32().

Signed-off-by: Fabio M. De Francesco <fmdefrancesco@gmail.com>
---
 drivers/staging/r8188eu/core/rtw_security.c | 74 ++++++++++-----------
 1 file changed, 35 insertions(+), 39 deletions(-)

diff --git a/drivers/staging/r8188eu/core/rtw_security.c b/drivers/staging/r8188eu/core/rtw_security.c
index 5df970994e23..9625beea4b3c 100644
--- a/drivers/staging/r8188eu/core/rtw_security.c
+++ b/drivers/staging/r8188eu/core/rtw_security.c
@@ -111,29 +111,15 @@ static void crc32_init(void)
 	}
 }
 
-static __le32 getcrc32(u8 *buf, int len)
-{
-	u8 *p;
-	u32  crc;
-
-	if (bcrc32initialized == 0)
-		crc32_init();
-
-	crc = 0xffffffff;       /* preload shift register, per CRC-32 spec */
-
-	for (p = buf; len > 0; ++p, --len)
-		crc = crc32_table[(crc ^ *p) & 0xff] ^ (crc >> 8);
-
-	return cpu_to_le32(~crc);    /* transmit complement, per CRC-32 spec */
-}
-
 /*
 	Need to consider the fragment  situation
 */
 void rtw_wep_encrypt(struct adapter *padapter, u8 *pxmitframe)
 {	/*  exclude ICV */
-
-	unsigned char	crc[4];
+	union {
+		__le32 f0;
+		u8 f1[4];
+	} crc;
 	struct arc4context	 mycontext;
 
 	int	curfragnum, length;
@@ -167,17 +153,17 @@ void rtw_wep_encrypt(struct adapter *padapter, u8 *pxmitframe)
 			if ((curfragnum+1) == pattrib->nr_frags) {	/* the last fragment */
 				length = pattrib->last_txcmdsz-pattrib->hdrlen-pattrib->iv_len-pattrib->icv_len;
 
-				*((__le32 *)crc) = getcrc32(payload, length);
+				crc.f0 = cpu_to_le32(~crc32_le(~0, payload, length));
 
 				arcfour_init(&mycontext, wepkey, 3+keylength);
 				arcfour_encrypt(&mycontext, payload, payload, length);
-				arcfour_encrypt(&mycontext, payload+length, crc, 4);
+				arcfour_encrypt(&mycontext, payload+length, crc.f1, 4);
 			} else {
 				length = pxmitpriv->frag_len-pattrib->hdrlen-pattrib->iv_len-pattrib->icv_len;
-				*((__le32 *)crc) = getcrc32(payload, length);
+				crc.f0 = cpu_to_le32(~crc32_le(~0, payload, length));
 				arcfour_init(&mycontext, wepkey, 3+keylength);
 				arcfour_encrypt(&mycontext, payload, payload, length);
-				arcfour_encrypt(&mycontext, payload+length, crc, 4);
+				arcfour_encrypt(&mycontext, payload+length, crc.f1, 4);
 
 				pframe += pxmitpriv->frag_len;
 				pframe = (u8 *)RND4((size_t)(pframe));
@@ -190,7 +176,10 @@ void rtw_wep_encrypt(struct adapter *padapter, u8 *pxmitframe)
 void rtw_wep_decrypt(struct adapter  *padapter, u8 *precvframe)
 {
 	/*  exclude ICV */
-	u8	crc[4];
+	union {
+		__le32 f0;
+		u8 f1[4];
+	} crc;
 	struct arc4context	 mycontext;
 	int	length;
 	u32	keylength;
@@ -217,12 +206,12 @@ void rtw_wep_decrypt(struct adapter  *padapter, u8 *precvframe)
 		arcfour_encrypt(&mycontext, payload, payload,  length);
 
 		/* calculate icv and compare the icv */
-		*((__le32 *)crc) = getcrc32(payload, length - 4);
+		crc.f0 = cpu_to_le32(~crc32_le(~0, payload, length));
 
-		if (crc[3] != payload[length-1] ||
-		    crc[2] != payload[length-2] ||
-		    crc[1] != payload[length-3] ||
-		    crc[0] != payload[length-4]) {
+		if (crc.f1[3] != payload[length-1] ||
+		    crc.f1[2] != payload[length-2] ||
+		    crc.f1[1] != payload[length-3] ||
+		    crc.f1[0] != payload[length-4]) {
 			RT_TRACE(_module_rtl871x_security_c_, _drv_err_,
 				 ("rtw_wep_decrypt:icv error crc (%4ph)!=payload (%4ph)\n",
 				 &crc, &payload[length-4]));
@@ -574,7 +563,10 @@ u32	rtw_tkip_encrypt(struct adapter *padapter, u8 *pxmitframe)
 	u32	pnh;
 	u8	rc4key[16];
 	u8   ttkey[16];
-	u8	crc[4];
+	union {
+		__le32 f0;
+		u8 f1[4];
+	} crc;
 	u8   hw_hdr_offset = 0;
 	struct arc4context mycontext;
 	int			curfragnum, length;
@@ -624,17 +616,18 @@ u32	rtw_tkip_encrypt(struct adapter *padapter, u8 *pxmitframe)
 					RT_TRACE(_module_rtl871x_security_c_, _drv_info_,
 						 ("pattrib->iv_len=%x, pattrib->icv_len=%x\n",
 						 pattrib->iv_len, pattrib->icv_len));
-					*((__le32 *)crc) = getcrc32(payload, length);/* modified by Amy*/
+					crc.f0 = cpu_to_le32(~crc32_le(~0, payload, length));
 
 					arcfour_init(&mycontext, rc4key, 16);
 					arcfour_encrypt(&mycontext, payload, payload, length);
-					arcfour_encrypt(&mycontext, payload+length, crc, 4);
+					arcfour_encrypt(&mycontext, payload+length, crc.f1, 4);
 				} else {
 					length = pxmitpriv->frag_len-pattrib->hdrlen-pattrib->iv_len-pattrib->icv_len ;
-					*((__le32 *)crc) = getcrc32(payload, length);/* modified by Amy*/
+					crc.f0 = cpu_to_le32(~crc32_le(~0, payload, length));
+
 					arcfour_init(&mycontext, rc4key, 16);
 					arcfour_encrypt(&mycontext, payload, payload, length);
-					arcfour_encrypt(&mycontext, payload+length, crc, 4);
+					arcfour_encrypt(&mycontext, payload+length, crc.f1, 4);
 
 					pframe += pxmitpriv->frag_len;
 					pframe = (u8 *)RND4((size_t)(pframe));
@@ -656,7 +649,10 @@ u32 rtw_tkip_decrypt(struct adapter *padapter, u8 *precvframe)
 	u32 pnh;
 	u8   rc4key[16];
 	u8   ttkey[16];
-	u8	crc[4];
+	union {
+		__le32 f0;
+		u8 f1[4];
+	} crc;
 	struct arc4context mycontext;
 	int			length;
 
@@ -702,12 +698,12 @@ u32 rtw_tkip_decrypt(struct adapter *padapter, u8 *precvframe)
 			arcfour_init(&mycontext, rc4key, 16);
 			arcfour_encrypt(&mycontext, payload, payload, length);
 
-			*((__le32 *)crc) = getcrc32(payload, length-4);
+			crc.f0 = cpu_to_le32(~crc32_le(~0, payload, length));
 
-			if (crc[3] != payload[length-1] ||
-			    crc[2] != payload[length-2] ||
-			    crc[1] != payload[length-3] ||
-			    crc[0] != payload[length-4]) {
+			if (crc.f1[3] != payload[length-1] ||
+			    crc.f1[2] != payload[length-2] ||
+			    crc.f1[1] != payload[length-3] ||
+			    crc.f1[0] != payload[length-4]) {
 				RT_TRACE(_module_rtl871x_security_c_, _drv_err_,
 					 ("rtw_wep_decrypt:icv error crc (%4ph)!=payload (%4ph)\n",
 					 &crc, &payload[length-4]));
-- 
2.32.0

