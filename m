Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5BF313EDA6B
	for <lists+linux-kernel@lfdr.de>; Mon, 16 Aug 2021 18:00:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238425AbhHPQAm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 16 Aug 2021 12:00:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57676 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237344AbhHPQAO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Aug 2021 12:00:14 -0400
Received: from mail-wr1-x434.google.com (mail-wr1-x434.google.com [IPv6:2a00:1450:4864:20::434])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4759AC0613CF
        for <linux-kernel@vger.kernel.org>; Mon, 16 Aug 2021 08:59:41 -0700 (PDT)
Received: by mail-wr1-x434.google.com with SMTP id f5so24292941wrm.13
        for <linux-kernel@vger.kernel.org>; Mon, 16 Aug 2021 08:59:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=1s8dLgoviy6QmkI3DKlYyNVShitZYgEcDxDTH96VU8I=;
        b=kl7o/FMYhH4E3YmlrzWK3F+lOUFDZ5mo8/3/a5UxfdJQZKx7JHzxruzbTI+3wqKS77
         dU6qndOCSlxBn+4ajRF261nlpopcgJoYeiAaRGZ7Eo8wr07LKZi/2jauK5LFxuy9pm2h
         e9q7XDbTVbK8zAM1use4Wp60Eql/3AoxXpKFlzws3Jln67MUwIgIA5/O5B6g+E5p4BGz
         Y2yi0nz4cSCWbHyLPuGThU9OG314ZnWkty55Tjbr1mosPxjEPtm4N76fe4RSOp6mJblz
         7J5Q6QNgRS7tnv/WsI4SgesIW1RPhQzGUPv5AhV5teQ/icvQ9qNTLbWoAi8m6IxSyKp0
         vduQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=1s8dLgoviy6QmkI3DKlYyNVShitZYgEcDxDTH96VU8I=;
        b=SABVrkCHVXpr5e3RqWpV47tLJiAI29c/ZBzjZUIIcX2DZE9MhHnYl+IBo4l3BKTg1o
         aiXLVD36zFb7PcaK72Ae7gK1s9BOVznBrsHtAq75r9fiXjTd+tlcnItOfzZoxOliAuTG
         /KudRyFcmNbviy3z6hCqFGWcRXRbjAYfMgrOuWSC6KiQwQ3lfz6+50N2DY7hq1poHOgd
         TtvOn63m3b+v2Hc9yYJ5lu9j2j1gbKN1ISpmuHbMRzUEJI5WdRltwyAHsdsUHlXApm8o
         bYZ0NKyxdio/2+9JmGe14XjvCD0oLwtFl/5qivXQVOnGJdvrSFdOznC7TdBvcR2lHPs8
         FPWQ==
X-Gm-Message-State: AOAM531C1etwIlLGoV0wEfe4gMBhpd9fqI1J9+hfute0AvGm10Lnjiuo
        0kUnKIgQKGWNiYDrZZnrS+o=
X-Google-Smtp-Source: ABdhPJxkUiY00K7hkiMtrAhd+ufVYd89m2oM6nxhqAYgYD3cNxtDw0/2kjhf0ce9vdBnuWw109W+Vg==
X-Received: by 2002:a5d:6108:: with SMTP id v8mr7742003wrt.96.1629129579843;
        Mon, 16 Aug 2021 08:59:39 -0700 (PDT)
Received: from localhost.localdomain ([2a02:8108:96c0:3b88::4058])
        by smtp.gmail.com with ESMTPSA id a77sm11589597wmd.31.2021.08.16.08.59.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 16 Aug 2021 08:59:39 -0700 (PDT)
From:   Michael Straube <straube.linux@gmail.com>
To:     gregkh@linuxfoundation.org
Cc:     Larry.Finger@lwfinger.net, phil@philpotter.co.uk, martin@kaiser.cx,
        fmdefrancesco@gmail.com, linux-staging@lists.linux.dev,
        linux-kernel@vger.kernel.org,
        Michael Straube <straube.linux@gmail.com>
Subject: [PATCH 17/23] staging: r8188eu: clean up spacing style issues in core/rtw_security.c
Date:   Mon, 16 Aug 2021 17:58:12 +0200
Message-Id: <20210816155818.24005-18-straube.linux@gmail.com>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <20210816155818.24005-1-straube.linux@gmail.com>
References: <20210816155818.24005-1-straube.linux@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Clean up spacing style issues in core/rtw_security.c reported by
checkpatch.

CHECK: spaces preferred around that ...
CHECK: No space is necessary after a cast
WARNING: space prohibited before semicolon

Signed-off-by: Michael Straube <straube.linux@gmail.com>
---
 drivers/staging/r8188eu/core/rtw_security.c | 188 ++++++++++----------
 1 file changed, 94 insertions(+), 94 deletions(-)

diff --git a/drivers/staging/r8188eu/core/rtw_security.c b/drivers/staging/r8188eu/core/rtw_security.c
index 845301476e8b..b9ab4b20ed8e 100644
--- a/drivers/staging/r8188eu/core/rtw_security.c
+++ b/drivers/staging/r8188eu/core/rtw_security.c
@@ -108,25 +108,25 @@ void rtw_wep_encrypt(struct adapter *padapter, u8 *pxmitframe)
 		keylength = psecuritypriv->dot11DefKeylen[psecuritypriv->dot11PrivacyKeyIndex];
 
 		for (curfragnum = 0; curfragnum < pattrib->nr_frags; curfragnum++) {
-			iv = pframe+pattrib->hdrlen;
+			iv = pframe + pattrib->hdrlen;
 			memcpy(&wepkey[0], iv, 3);
 			memcpy(&wepkey[3], &psecuritypriv->dot11DefKey[psecuritypriv->dot11PrivacyKeyIndex].skey[0], keylength);
-			payload = pframe+pattrib->iv_len+pattrib->hdrlen;
+			payload = pframe + pattrib->iv_len + pattrib->hdrlen;
 
-			if ((curfragnum+1) == pattrib->nr_frags) {	/* the last fragment */
-				length = pattrib->last_txcmdsz-pattrib->hdrlen-pattrib->iv_len-pattrib->icv_len;
+			if ((curfragnum + 1) == pattrib->nr_frags) {	/* the last fragment */
+				length = pattrib->last_txcmdsz - pattrib->hdrlen - pattrib->iv_len - pattrib->icv_len;
 
 				crc.f0 = cpu_to_le32(~crc32_le(~0, payload, length));
 
-				arcfour_init(&mycontext, wepkey, 3+keylength);
+				arcfour_init(&mycontext, wepkey, 3 + keylength);
 				arcfour_encrypt(&mycontext, payload, payload, length);
-				arcfour_encrypt(&mycontext, payload+length, crc.f1, 4);
+				arcfour_encrypt(&mycontext, payload + length, crc.f1, 4);
 			} else {
-				length = pxmitpriv->frag_len-pattrib->hdrlen-pattrib->iv_len-pattrib->icv_len;
+				length = pxmitpriv->frag_len - pattrib->hdrlen - pattrib->iv_len - pattrib->icv_len;
 				crc.f0 = cpu_to_le32(~crc32_le(~0, payload, length));
-				arcfour_init(&mycontext, wepkey, 3+keylength);
+				arcfour_init(&mycontext, wepkey, 3 + keylength);
 				arcfour_encrypt(&mycontext, payload, payload, length);
-				arcfour_encrypt(&mycontext, payload+length, crc.f1, 4);
+				arcfour_encrypt(&mycontext, payload + length, crc.f1, 4);
 
 				pframe += pxmitpriv->frag_len;
 				pframe = (u8 *)RND4((size_t)(pframe));
@@ -151,17 +151,17 @@ void rtw_wep_decrypt(struct adapter  *padapter, u8 *precvframe)
 
 	/* start to decrypt recvframe */
 	if ((prxattrib->encrypt == _WEP40_) || (prxattrib->encrypt == _WEP104_)) {
-		iv = pframe+prxattrib->hdrlen;
+		iv = pframe + prxattrib->hdrlen;
 		keyindex = prxattrib->key_index;
 		keylength = psecuritypriv->dot11DefKeylen[keyindex];
 		memcpy(&wepkey[0], iv, 3);
 		memcpy(&wepkey[3], &psecuritypriv->dot11DefKey[keyindex].skey[0], keylength);
-		length = ((struct recv_frame *)precvframe)->len-prxattrib->hdrlen-prxattrib->iv_len;
+		length = ((struct recv_frame *)precvframe)->len - prxattrib->hdrlen - prxattrib->iv_len;
 
-		payload = pframe+prxattrib->iv_len+prxattrib->hdrlen;
+		payload = pframe + prxattrib->iv_len + prxattrib->hdrlen;
 
 		/* decrypt payload include icv */
-		arcfour_init(&mycontext, wepkey, 3+keylength);
+		arcfour_init(&mycontext, wepkey, 3 + keylength);
 		arcfour_encrypt(&mycontext, payload, payload,  length);
 	}
 }
@@ -175,7 +175,7 @@ static u32 secmicgetuint32(u8 *p)
 	u32 res = 0;
 
 	for (i = 0; i < 4; i++)
-		res |= ((u32)(*p++)) << (8*i);
+		res |= ((u32)(*p++)) << (8 * i);
 
 	return res;
 }
@@ -186,7 +186,7 @@ static void secmicputuint32(u8 *p, u32 val)
 	long i;
 
 	for (i = 0; i < 4; i++) {
-		*p++ = (u8) (val & 0xff);
+		*p++ = (u8)(val & 0xff);
 		val >>= 8;
 	}
 
@@ -218,7 +218,7 @@ void rtw_secmicappendbyte(struct mic_data *pmicdata, u8 b)
 {
 
 	/*  Append the byte to our word-sized buffer */
-	pmicdata->M |= ((unsigned long)b) << (8*pmicdata->nBytesInM);
+	pmicdata->M |= ((unsigned long)b) << (8 * pmicdata->nBytesInM);
 	pmicdata->nBytesInM++;
 	/*  Process the word if it is full. */
 	if (pmicdata->nBytesInM >= 4) {
@@ -263,7 +263,7 @@ void rtw_secgetmic(struct mic_data *pmicdata, u8 *dst)
 		rtw_secmicappendbyte(pmicdata, 0);
 	/*  The appendByte function has already computed the result. */
 	secmicputuint32(dst, pmicdata->L);
-	secmicputuint32(dst+4, pmicdata->R);
+	secmicputuint32(dst + 4, pmicdata->R);
 	/*  Reset to the empty message. */
 	secmicclear(pmicdata);
 
@@ -278,15 +278,15 @@ void rtw_seccalctkipmic(u8 *key, u8 *header, u8 *data, u32 data_len, u8 *mic_cod
 	priority[0] = pri;
 
 	/* Michael MIC pseudo header: DA, SA, 3 x 0, Priority */
-	if (header[1]&1) {   /* ToDS == 1 */
+	if (header[1] & 1) {   /* ToDS == 1 */
 		rtw_secmicappend(&micdata, &header[16], 6);  /* DA */
-		if (header[1]&2)  /* From Ds == 1 */
+		if (header[1] & 2)  /* From Ds == 1 */
 			rtw_secmicappend(&micdata, &header[24], 6);
 		else
 			rtw_secmicappend(&micdata, &header[10], 6);
 	} else {	/* ToDS == 0 */
 		rtw_secmicappend(&micdata, &header[4], 6);   /* DA */
-		if (header[1]&2)  /* From Ds == 1 */
+		if (header[1] & 2)  /* From Ds == 1 */
 			rtw_secmicappend(&micdata, &header[16], 6);
 		else
 			rtw_secmicappend(&micdata, &header[10], 6);
@@ -308,7 +308,7 @@ void rtw_seccalctkipmic(u8 *key, u8 *header, u8 *data, u32 data_len, u8 *mic_cod
 #define  Mk16(hi, lo) ((lo) ^ (((u16)(hi)) << 8))
 
 /* select the Nth 16-bit word of the temporal key unsigned char array TK[]   */
-#define  TK16(N)     Mk16(tk[2*(N)+1], tk[2*(N)])
+#define  TK16(N)     Mk16(tk[2 * (N) + 1], tk[2 * (N)])
 
 /* S-box lookup: 16 bits --> 16 bits */
 #define _S_(v16)     (Sbox1[0][Lo8(v16)] ^ Sbox1[1][Hi8(v16)])
@@ -424,11 +424,11 @@ static void phase1(u16 *p1k, const u8 *tk, const u8 *ta, u32 iv32)
 	/* Now compute an unbalanced Feistel cipher with 80-bit block */
 	/* size on the 80-bit block P1K[], using the 128-bit key TK[] */
 	for (i = 0; i < PHASE1_LOOP_CNT; i++) { /* Each add operation here is mod 2**16 */
-		p1k[0] += _S_(p1k[4] ^ TK16((i&1)+0));
-		p1k[1] += _S_(p1k[0] ^ TK16((i&1)+2));
-		p1k[2] += _S_(p1k[1] ^ TK16((i&1)+4));
-		p1k[3] += _S_(p1k[2] ^ TK16((i&1)+6));
-		p1k[4] += _S_(p1k[3] ^ TK16((i&1)+0));
+		p1k[0] += _S_(p1k[4] ^ TK16((i & 1) + 0));
+		p1k[1] += _S_(p1k[0] ^ TK16((i & 1) + 2));
+		p1k[2] += _S_(p1k[1] ^ TK16((i & 1) + 4));
+		p1k[3] += _S_(p1k[2] ^ TK16((i & 1) + 6));
+		p1k[4] += _S_(p1k[3] ^ TK16((i & 1) + 0));
 		p1k[4] +=  (unsigned short)i;   /* avoid "slide attacks" */
 	}
 
@@ -495,8 +495,8 @@ static void phase2(u8 *rc4key, const u8 *tk, const u16 *p1k, u16 iv16)
 
 	/* Copy 96 bits of PPK[0..5] to RC4KEY[4..15]  (little-endian)       */
 	for (i = 0; i < 6; i++) {
-		rc4key[4+2*i] = Lo8(PPK[i]);
-		rc4key[5+2*i] = Hi8(PPK[i]);
+		rc4key[4 + 2 * i] = Lo8(PPK[i]);
+		rc4key[5 + 2 * i] = Hi8(PPK[i]);
 	}
 
 }
@@ -544,30 +544,30 @@ u32	rtw_tkip_encrypt(struct adapter *padapter, u8 *pxmitframe)
 				prwskey = &stainfo->dot118021x_UncstKey.skey[0];
 
 			for (curfragnum = 0; curfragnum < pattrib->nr_frags; curfragnum++) {
-				iv = pframe+pattrib->hdrlen;
-				payload = pframe+pattrib->iv_len+pattrib->hdrlen;
+				iv = pframe + pattrib->hdrlen;
+				payload = pframe + pattrib->iv_len + pattrib->hdrlen;
 
 				GET_TKIP_PN(iv, dot11txpn);
 
 				pnl = (u16)(dot11txpn.val);
-				pnh = (u32)(dot11txpn.val>>16);
+				pnh = (u32)(dot11txpn.val >> 16);
 				phase1((u16 *)&ttkey[0], prwskey, &pattrib->ta[0], pnh);
 				phase2(&rc4key[0], prwskey, (u16 *)&ttkey[0], pnl);
 
-				if ((curfragnum+1) == pattrib->nr_frags) {	/* 4 the last fragment */
-					length = pattrib->last_txcmdsz-pattrib->hdrlen-pattrib->iv_len-pattrib->icv_len;
+				if ((curfragnum + 1) == pattrib->nr_frags) {	/* 4 the last fragment */
+					length = pattrib->last_txcmdsz - pattrib->hdrlen - pattrib->iv_len - pattrib->icv_len;
 					crc.f0 = cpu_to_le32(~crc32_le(~0, payload, length));
 
 					arcfour_init(&mycontext, rc4key, 16);
 					arcfour_encrypt(&mycontext, payload, payload, length);
-					arcfour_encrypt(&mycontext, payload+length, crc.f1, 4);
+					arcfour_encrypt(&mycontext, payload + length, crc.f1, 4);
 				} else {
-					length = pxmitpriv->frag_len-pattrib->hdrlen-pattrib->iv_len-pattrib->icv_len ;
+					length = pxmitpriv->frag_len - pattrib->hdrlen - pattrib->iv_len - pattrib->icv_len;
 					crc.f0 = cpu_to_le32(~crc32_le(~0, payload, length));
 
 					arcfour_init(&mycontext, rc4key, 16);
 					arcfour_encrypt(&mycontext, payload, payload, length);
-					arcfour_encrypt(&mycontext, payload+length, crc.f1, 4);
+					arcfour_encrypt(&mycontext, payload + length, crc.f1, 4);
 
 					pframe += pxmitpriv->frag_len;
 					pframe = (u8 *)RND4((size_t)(pframe));
@@ -619,14 +619,14 @@ u32 rtw_tkip_decrypt(struct adapter *padapter, u8 *precvframe)
 				prwskey = &stainfo->dot118021x_UncstKey.skey[0];
 			}
 
-			iv = pframe+prxattrib->hdrlen;
-			payload = pframe+prxattrib->iv_len+prxattrib->hdrlen;
-			length = ((struct recv_frame *)precvframe)->len-prxattrib->hdrlen-prxattrib->iv_len;
+			iv = pframe + prxattrib->hdrlen;
+			payload = pframe + prxattrib->iv_len + prxattrib->hdrlen;
+			length = ((struct recv_frame *)precvframe)->len - prxattrib->hdrlen - prxattrib->iv_len;
 
 			GET_TKIP_PN(iv, dot11txpn);
 
 			pnl = (u16)(dot11txpn.val);
-			pnh = (u32)(dot11txpn.val>>16);
+			pnh = (u32)(dot11txpn.val >> 16);
 
 			phase1((u16 *)&ttkey[0], prwskey, &prxattrib->ta[0], pnh);
 			phase2(&rc4key[0], prwskey, (unsigned short *)&ttkey[0], pnl);
@@ -638,10 +638,10 @@ u32 rtw_tkip_decrypt(struct adapter *padapter, u8 *precvframe)
 
 			crc.f0 = cpu_to_le32(~crc32_le(~0, payload, length));
 
-			if (crc.f1[3] != payload[length-1] ||
-			    crc.f1[2] != payload[length-2] ||
-			    crc.f1[1] != payload[length-3] ||
-			    crc.f1[0] != payload[length-4])
+			if (crc.f1[3] != payload[length - 1] ||
+			    crc.f1[2] != payload[length - 2] ||
+			    crc.f1[1] != payload[length - 3] ||
+			    crc.f1[0] != payload[length - 4])
 				res = _FAIL;
 		} else {
 			res = _FAIL;
@@ -832,7 +832,7 @@ static void mix_column(u8 *in, u8 *out)
 
 	for (i = 3; i > 0; i--) {    /* logical shift left 1 bit */
 		andf7[i] = andf7[i] << 1;
-		if ((andf7[i-1] & 0x80) == 0x80)
+		if ((andf7[i - 1] & 0x80) == 0x80)
 			andf7[i] = (andf7[i] | 0x01);
 	}
 	andf7[0] = andf7[0] << 1;
@@ -906,8 +906,8 @@ static void construct_mic_iv(u8 *mic_iv, int qc_exists, int a4_exists, u8 *mpdu,
 		mic_iv[i] = mpdu[i + 8];	/* mic_iv[2:7] = A2[0:5] = mpdu[10:15] */
 	for (i = 8; i < 14; i++)
 		mic_iv[i] = pn_vector[13 - i];	/* mic_iv[8:13] = PN[5:0] */
-	mic_iv[14] = (unsigned char) (payload_length / 256);
-	mic_iv[15] = (unsigned char) (payload_length % 256);
+	mic_iv[14] = (unsigned char)(payload_length / 256);
+	mic_iv[15] = (unsigned char)(payload_length % 256);
 
 }
 
@@ -962,7 +962,7 @@ static void construct_mic_header2(u8 *mic_header2, u8 *mpdu, int a4_exists, int
 
 	if (!qc_exists && a4_exists) {
 		for (i = 0; i < 6; i++)
-			mic_header2[8+i] = mpdu[24+i];   /* A4 */
+			mic_header2[8 + i] = mpdu[24 + i];   /* A4 */
 	}
 
 	if (qc_exists && !a4_exists) {
@@ -972,7 +972,7 @@ static void construct_mic_header2(u8 *mic_header2, u8 *mpdu, int a4_exists, int
 
 	if (qc_exists && a4_exists) {
 		for (i = 0; i < 6; i++)
-			mic_header2[8+i] = mpdu[24+i];   /* A4 */
+			mic_header2[8 + i] = mpdu[24 + i];   /* A4 */
 
 		mic_header2[14] = mpdu[30] & 0x0f;
 		mic_header2[15] = mpdu[31] & 0x00;
@@ -1003,8 +1003,8 @@ static void construct_ctr_preload(u8 *ctr_preload, int a4_exists, int qc_exists,
 		ctr_preload[i] = mpdu[i + 8];		       /* ctr_preload[2:7] = A2[0:5] = mpdu[10:15] */
 	for (i = 8; i < 14; i++)
 		ctr_preload[i] =    pn_vector[13 - i];	  /* ctr_preload[8:13] = PN[5:0] */
-	ctr_preload[14] =  (unsigned char) (c / 256); /* Ctr */
-	ctr_preload[15] =  (unsigned char) (c % 256);
+	ctr_preload[14] =  (unsigned char)(c / 256); /* Ctr */
+	ctr_preload[15] =  (unsigned char)(c % 256);
 
 }
 
@@ -1040,7 +1040,7 @@ static int aes_cipher(u8 *key, uint hdrlen, u8 *pframe, uint plen)
 	uint	frtype  = GetFrameType(pframe);
 	uint	frsubtype  = GetFrameSubType(pframe);
 
-	frsubtype = frsubtype>>4;
+	frsubtype = frsubtype >> 4;
 
 	memset((void *)mic_iv, 0, 16);
 	memset((void *)mic_header1, 0, 16);
@@ -1068,11 +1068,11 @@ static int aes_cipher(u8 *key, uint hdrlen, u8 *pframe, uint plen)
 	}
 
 	pn_vector[0] = pframe[hdrlen];
-	pn_vector[1] = pframe[hdrlen+1];
-	pn_vector[2] = pframe[hdrlen+4];
-	pn_vector[3] = pframe[hdrlen+5];
-	pn_vector[4] = pframe[hdrlen+6];
-	pn_vector[5] = pframe[hdrlen+7];
+	pn_vector[1] = pframe[hdrlen + 1];
+	pn_vector[2] = pframe[hdrlen + 4];
+	pn_vector[3] = pframe[hdrlen + 5];
+	pn_vector[4] = pframe[hdrlen + 6];
+	pn_vector[5] = pframe[hdrlen + 7];
 
 	construct_mic_iv(mic_iv, qc_exists, a4_exists, pframe, plen, pn_vector);
 
@@ -1114,11 +1114,11 @@ static int aes_cipher(u8 *key, uint hdrlen, u8 *pframe, uint plen)
 
 	/* Insert MIC into payload */
 	for (j = 0; j < 8; j++)
-		pframe[payload_index+j] = mic[j]; /* message[payload_index+j] = mic[j]; */
+		pframe[payload_index + j] = mic[j]; /* message[payload_index+j] = mic[j]; */
 
 	payload_index = hdrlen + 8;
 	for (i = 0; i < num_blocks; i++) {
-		construct_ctr_preload(ctr_preload, a4_exists, qc_exists, pframe, pn_vector, i+1);
+		construct_ctr_preload(ctr_preload, a4_exists, qc_exists, pframe, pn_vector, i + 1);
 		aes128k128d(key, ctr_preload, aes_out);
 		bitwise_xor(aes_out, &pframe[payload_index], chain_buffer);
 		for (j = 0; j < 16; j++)
@@ -1127,12 +1127,12 @@ static int aes_cipher(u8 *key, uint hdrlen, u8 *pframe, uint plen)
 
 	if (payload_remainder > 0) {    /* If there is a short final block, then pad it,*/
 					/* encrypt it and copy the unpadded part back   */
-		construct_ctr_preload(ctr_preload, a4_exists, qc_exists, pframe, pn_vector, num_blocks+1);
+		construct_ctr_preload(ctr_preload, a4_exists, qc_exists, pframe, pn_vector, num_blocks + 1);
 
 		for (j = 0; j < 16; j++)
 			padded_buffer[j] = 0x00;
 		for (j = 0; j < payload_remainder; j++)
-			padded_buffer[j] = pframe[payload_index+j];
+			padded_buffer[j] = pframe[payload_index + j];
 		aes128k128d(key, ctr_preload, aes_out);
 		bitwise_xor(aes_out, padded_buffer, chain_buffer);
 		for (j = 0; j < payload_remainder; j++)
@@ -1144,7 +1144,7 @@ static int aes_cipher(u8 *key, uint hdrlen, u8 *pframe, uint plen)
 	for (j = 0; j < 16; j++)
 		padded_buffer[j] = 0x00;
 	for (j = 0; j < 8; j++)
-		padded_buffer[j] = pframe[j+hdrlen+8+plen];
+		padded_buffer[j] = pframe[j + hdrlen + 8 + plen];
 
 	aes128k128d(key, ctr_preload, aes_out);
 	bitwise_xor(aes_out, padded_buffer, chain_buffer);
@@ -1193,12 +1193,12 @@ u32	rtw_aes_encrypt(struct adapter *padapter, u8 *pxmitframe)
 			else
 				prwskey = &stainfo->dot118021x_UncstKey.skey[0];
 			for (curfragnum = 0; curfragnum < pattrib->nr_frags; curfragnum++) {
-				if ((curfragnum+1) == pattrib->nr_frags) {	/* 4 the last fragment */
-					length = pattrib->last_txcmdsz-pattrib->hdrlen-pattrib->iv_len-pattrib->icv_len;
+				if ((curfragnum + 1) == pattrib->nr_frags) {	/* 4 the last fragment */
+					length = pattrib->last_txcmdsz - pattrib->hdrlen - pattrib->iv_len - pattrib->icv_len;
 
 					aes_cipher(prwskey, pattrib->hdrlen, pframe, length);
 				} else {
-					length = pxmitpriv->frag_len-pattrib->hdrlen-pattrib->iv_len-pattrib->icv_len ;
+					length = pxmitpriv->frag_len - pattrib->hdrlen - pattrib->iv_len - pattrib->icv_len;
 
 					aes_cipher(prwskey, pattrib->hdrlen, pframe, length);
 					pframe += pxmitpriv->frag_len;
@@ -1236,7 +1236,7 @@ static int aes_decipher(u8 *key, uint	hdrlen,
 	uint	frtype  = GetFrameType(pframe);
 	uint	frsubtype  = GetFrameSubType(pframe);
 
-	frsubtype = frsubtype>>4;
+	frsubtype = frsubtype >> 4;
 
 	memset((void *)mic_iv, 0, 16);
 	memset((void *)mic_header1, 0, 16);
@@ -1248,16 +1248,16 @@ static int aes_decipher(u8 *key, uint	hdrlen,
 
 	/* start to decrypt the payload */
 
-	num_blocks = (plen-8) / 16; /* plen including llc, payload_length and mic) */
+	num_blocks = (plen - 8) / 16; /* plen including llc, payload_length and mic) */
 
-	payload_remainder = (plen-8) % 16;
+	payload_remainder = (plen - 8) % 16;
 
 	pn_vector[0]  = pframe[hdrlen];
-	pn_vector[1]  = pframe[hdrlen+1];
-	pn_vector[2]  = pframe[hdrlen+4];
-	pn_vector[3]  = pframe[hdrlen+5];
-	pn_vector[4]  = pframe[hdrlen+6];
-	pn_vector[5]  = pframe[hdrlen+7];
+	pn_vector[1]  = pframe[hdrlen + 1];
+	pn_vector[2]  = pframe[hdrlen + 4];
+	pn_vector[3]  = pframe[hdrlen + 5];
+	pn_vector[4]  = pframe[hdrlen + 6];
+	pn_vector[5]  = pframe[hdrlen + 7];
 
 	if ((hdrlen == WLAN_HDR_A3_LEN) || (hdrlen ==  WLAN_HDR_A3_QOS_LEN))
 		a4_exists = 0;
@@ -1283,7 +1283,7 @@ static int aes_decipher(u8 *key, uint	hdrlen,
 	payload_index = hdrlen + 8; /*  8 is for extiv */
 
 	for (i = 0; i < num_blocks; i++) {
-		construct_ctr_preload(ctr_preload, a4_exists, qc_exists, pframe, pn_vector, i+1);
+		construct_ctr_preload(ctr_preload, a4_exists, qc_exists, pframe, pn_vector, i + 1);
 
 		aes128k128d(key, ctr_preload, aes_out);
 		bitwise_xor(aes_out, &pframe[payload_index], chain_buffer);
@@ -1294,12 +1294,12 @@ static int aes_decipher(u8 *key, uint	hdrlen,
 
 	if (payload_remainder > 0) {    /* If there is a short final block, then pad it,*/
 					/* encrypt it and copy the unpadded part back   */
-		construct_ctr_preload(ctr_preload, a4_exists, qc_exists, pframe, pn_vector, num_blocks+1);
+		construct_ctr_preload(ctr_preload, a4_exists, qc_exists, pframe, pn_vector, num_blocks + 1);
 
 		for (j = 0; j < 16; j++)
 			padded_buffer[j] = 0x00;
 		for (j = 0; j < payload_remainder; j++)
-			padded_buffer[j] = pframe[payload_index+j];
+			padded_buffer[j] = pframe[payload_index + j];
 		aes128k128d(key, ctr_preload, aes_out);
 		bitwise_xor(aes_out, padded_buffer, chain_buffer);
 		for (j = 0; j < payload_remainder; j++)
@@ -1307,22 +1307,22 @@ static int aes_decipher(u8 *key, uint	hdrlen,
 	}
 
 	/* start to calculate the mic */
-	if ((hdrlen+plen+8) <= MAX_MSG_SIZE)
-		memcpy(message, pframe, (hdrlen + plen+8)); /* 8 is for ext iv len */
+	if ((hdrlen + plen + 8) <= MAX_MSG_SIZE)
+		memcpy(message, pframe, (hdrlen + plen + 8)); /* 8 is for ext iv len */
 
 	pn_vector[0] = pframe[hdrlen];
-	pn_vector[1] = pframe[hdrlen+1];
-	pn_vector[2] = pframe[hdrlen+4];
-	pn_vector[3] = pframe[hdrlen+5];
-	pn_vector[4] = pframe[hdrlen+6];
-	pn_vector[5] = pframe[hdrlen+7];
-	construct_mic_iv(mic_iv, qc_exists, a4_exists, message, plen-8, pn_vector);
+	pn_vector[1] = pframe[hdrlen + 1];
+	pn_vector[2] = pframe[hdrlen + 4];
+	pn_vector[3] = pframe[hdrlen + 5];
+	pn_vector[4] = pframe[hdrlen + 6];
+	pn_vector[5] = pframe[hdrlen + 7];
+	construct_mic_iv(mic_iv, qc_exists, a4_exists, message, plen - 8, pn_vector);
 
 	construct_mic_header1(mic_header1, hdrlen, message);
 	construct_mic_header2(mic_header2, message, a4_exists, qc_exists);
 
-	payload_remainder = (plen-8) % 16;
-	num_blocks = (plen-8) / 16;
+	payload_remainder = (plen - 8) % 16;
+	num_blocks = (plen - 8) / 16;
 
 	/* Find start of payload */
 	payload_index = (hdrlen + 8);
@@ -1356,11 +1356,11 @@ static int aes_decipher(u8 *key, uint	hdrlen,
 
 	/* Insert MIC into payload */
 	for (j = 0; j < 8; j++)
-		message[payload_index+j] = mic[j];
+		message[payload_index + j] = mic[j];
 
 	payload_index = hdrlen + 8;
 	for (i = 0; i < num_blocks; i++) {
-		construct_ctr_preload(ctr_preload, a4_exists, qc_exists, message, pn_vector, i+1);
+		construct_ctr_preload(ctr_preload, a4_exists, qc_exists, message, pn_vector, i + 1);
 		aes128k128d(key, ctr_preload, aes_out);
 		bitwise_xor(aes_out, &message[payload_index], chain_buffer);
 		for (j = 0; j < 16; j++)
@@ -1369,12 +1369,12 @@ static int aes_decipher(u8 *key, uint	hdrlen,
 
 	if (payload_remainder > 0) { /* If there is a short final block, then pad it,*/
 		/* encrypt it and copy the unpadded part back   */
-		construct_ctr_preload(ctr_preload, a4_exists, qc_exists, message, pn_vector, num_blocks+1);
+		construct_ctr_preload(ctr_preload, a4_exists, qc_exists, message, pn_vector, num_blocks + 1);
 
 		for (j = 0; j < 16; j++)
 			padded_buffer[j] = 0x00;
 		for (j = 0; j < payload_remainder; j++)
-			padded_buffer[j] = message[payload_index+j];
+			padded_buffer[j] = message[payload_index + j];
 		aes128k128d(key, ctr_preload, aes_out);
 		bitwise_xor(aes_out, padded_buffer, chain_buffer);
 		for (j = 0; j < payload_remainder; j++)
@@ -1387,7 +1387,7 @@ static int aes_decipher(u8 *key, uint	hdrlen,
 	for (j = 0; j < 16; j++)
 		padded_buffer[j] = 0x00;
 	for (j = 0; j < 8; j++)
-		padded_buffer[j] = message[j+hdrlen+8+plen-8];
+		padded_buffer[j] = message[j + hdrlen + 8 + plen - 8];
 
 	aes128k128d(key, ctr_preload, aes_out);
 	bitwise_xor(aes_out, padded_buffer, chain_buffer);
@@ -1396,9 +1396,9 @@ static int aes_decipher(u8 *key, uint	hdrlen,
 
 	/* compare the mic */
 	for (i = 0; i < 8; i++) {
-		if (pframe[hdrlen+8+plen-8+i] != message[hdrlen+8+plen-8+i]) {
+		if (pframe[hdrlen + 8 + plen - 8 + i] != message[hdrlen + 8 + plen - 8 + i]) {
 			DBG_88E("aes_decipher:mic check error mic[%d]: pframe(%x)!=message(%x)\n",
-				i, pframe[hdrlen+8+plen-8+i], message[hdrlen+8+plen-8+i]);
+				i, pframe[hdrlen + 8 + plen - 8 + i], message[hdrlen + 8 + plen - 8 + i]);
 			res = _FAIL;
 		}
 	}
@@ -1438,7 +1438,7 @@ u32	rtw_aes_decrypt(struct adapter *padapter, u8 *precvframe)
 			} else {
 				prwskey = &stainfo->dot118021x_UncstKey.skey[0];
 			}
-			length = ((struct recv_frame *)precvframe)->len-prxattrib->hdrlen-prxattrib->iv_len;
+			length = ((struct recv_frame *)precvframe)->len - prxattrib->hdrlen - prxattrib->iv_len;
 			res = aes_decipher(prwskey, prxattrib->hdrlen, pframe, length);
 		} else {
 			res = _FAIL;
-- 
2.32.0

