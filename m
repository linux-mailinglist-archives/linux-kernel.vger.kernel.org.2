Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 83182372C58
	for <lists+linux-kernel@lfdr.de>; Tue,  4 May 2021 16:45:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231526AbhEDOqg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 4 May 2021 10:46:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33570 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231469AbhEDOqf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 May 2021 10:46:35 -0400
Received: from mail-ej1-x636.google.com (mail-ej1-x636.google.com [IPv6:2a00:1450:4864:20::636])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4CAECC061574
        for <linux-kernel@vger.kernel.org>; Tue,  4 May 2021 07:45:39 -0700 (PDT)
Received: by mail-ej1-x636.google.com with SMTP id w3so13592007ejc.4
        for <linux-kernel@vger.kernel.org>; Tue, 04 May 2021 07:45:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=EqDXXfTXjnj2dDr6UQB60p00fAolMCc4POhMLgn/dEo=;
        b=JtYW7tDxCuiYuEsV4BE0K8vdW94TJMHLojX4D9GF7Feji38u5Ab91xXMCW6enM/NN2
         7x89IqiYDqhP2fsVSlregLsVvNqB6OFxfVgg5VQnB0BBNPXKmhbrtACopL44kH6vfF9Z
         /MCG5QC91u3LvDh67dhFKFZ9PTbHkgZPc9aO8DuqVYyEAqs3aDF3y0gzdSPCiPHIN8yP
         Zmn0SmDH1OJ0Z0RpmJM6VZhc0EXxhHAmVDrTs6+aLLOhr/aYV+SNW6+PAdezDBC1AYQ/
         WhcFuoZQeG/WmPYJ/E3JLfojEFnRbjMIYc91ALGlmTHaMdfy6kw3kqIEk8ityFx72nZT
         0nIQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=EqDXXfTXjnj2dDr6UQB60p00fAolMCc4POhMLgn/dEo=;
        b=MLkxRsEABtLuh0/FERkToBwM3rE0Vh+x140tV6sznT8/gaJwnlaEQeIXgWPZhq1bJK
         5gcnGPu2M1UOZGbXu6y2GlSOm7fYNHvuGD2XXukVKJxIfnFU6ytMh+vFOzQb/XOoQ+lv
         V35MWlDYCdXQqMG0G7+4RUzwt1WdWUMEBoJV0E+tJgJodIyaR20LoP2uWGt9qcnlzG5L
         jaqTXDe8ztKzNntR7VpERBwLy27QTOtAf99jHu7YtqplJzSdbfUDZy3tmbSAgquqXJp5
         7izNP7INk7gu8TcNeGclfWR4QQr5JknWkMqfuW2H8AiB51RZSg9iVM8yRCcRwAWF5qqx
         xE/g==
X-Gm-Message-State: AOAM533JTg2jVI4BotVR7d/84f0tMzKWprlhNHTixH6Yv3ErYLgCBmGU
        +DSvSyM9ZEheisr+jNkHQM5noNlplU+JZA==
X-Google-Smtp-Source: ABdhPJwjxgD9kx7zv/FqqX6gzsEunygR8+qOQRwFgS9i2rLmmfccKvh9ss7AdKand7/Rovv7QpuwoA==
X-Received: by 2002:a17:906:aac5:: with SMTP id kt5mr2923244ejb.414.1620139537734;
        Tue, 04 May 2021 07:45:37 -0700 (PDT)
Received: from agape ([5.171.72.210])
        by smtp.gmail.com with ESMTPSA id f7sm1546288ejz.95.2021.05.04.07.45.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 04 May 2021 07:45:37 -0700 (PDT)
From:   Fabio Aiuto <fabioaiuto83@gmail.com>
To:     gregkh@linuxfoundation.org
Cc:     linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: [PATCH v2 3/3] staging: rtl8723bs: use in-kernel aes encryption
Date:   Tue,  4 May 2021 16:45:31 +0200
Message-Id: <bd1f47994d3a1d0f434de5b2095c327f5a25f6ef.1620139318.git.fabioaiuto83@gmail.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <cover.1620139318.git.fabioaiuto83@gmail.com>
References: <cover.1620139318.git.fabioaiuto83@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

replace private aes encryption subroutines with
public in-kernel ones in data frame encryption.

Signed-off-by: Fabio Aiuto <fabioaiuto83@gmail.com>
---
 drivers/staging/rtl8723bs/core/rtw_security.c | 212 +-----------------
 1 file changed, 5 insertions(+), 207 deletions(-)

diff --git a/drivers/staging/rtl8723bs/core/rtw_security.c b/drivers/staging/rtl8723bs/core/rtw_security.c
index 35f8b39d6fdb..4b816cfb9eaf 100644
--- a/drivers/staging/rtl8723bs/core/rtw_security.c
+++ b/drivers/staging/rtl8723bs/core/rtw_security.c
@@ -748,44 +748,6 @@ u32 rtw_tkip_decrypt(struct adapter *padapter, u8 *precvframe)
 
 
 #define MAX_MSG_SIZE	2048
-/*****************************/
-/******** SBOX Table *********/
-/*****************************/
-
-	static const u8 sbox_table[256] = {
-			0x63, 0x7c, 0x77, 0x7b, 0xf2, 0x6b, 0x6f, 0xc5,
-			0x30, 0x01, 0x67, 0x2b, 0xfe, 0xd7, 0xab, 0x76,
-			0xca, 0x82, 0xc9, 0x7d, 0xfa, 0x59, 0x47, 0xf0,
-			0xad, 0xd4, 0xa2, 0xaf, 0x9c, 0xa4, 0x72, 0xc0,
-			0xb7, 0xfd, 0x93, 0x26, 0x36, 0x3f, 0xf7, 0xcc,
-			0x34, 0xa5, 0xe5, 0xf1, 0x71, 0xd8, 0x31, 0x15,
-			0x04, 0xc7, 0x23, 0xc3, 0x18, 0x96, 0x05, 0x9a,
-			0x07, 0x12, 0x80, 0xe2, 0xeb, 0x27, 0xb2, 0x75,
-			0x09, 0x83, 0x2c, 0x1a, 0x1b, 0x6e, 0x5a, 0xa0,
-			0x52, 0x3b, 0xd6, 0xb3, 0x29, 0xe3, 0x2f, 0x84,
-			0x53, 0xd1, 0x00, 0xed, 0x20, 0xfc, 0xb1, 0x5b,
-			0x6a, 0xcb, 0xbe, 0x39, 0x4a, 0x4c, 0x58, 0xcf,
-			0xd0, 0xef, 0xaa, 0xfb, 0x43, 0x4d, 0x33, 0x85,
-			0x45, 0xf9, 0x02, 0x7f, 0x50, 0x3c, 0x9f, 0xa8,
-			0x51, 0xa3, 0x40, 0x8f, 0x92, 0x9d, 0x38, 0xf5,
-			0xbc, 0xb6, 0xda, 0x21, 0x10, 0xff, 0xf3, 0xd2,
-			0xcd, 0x0c, 0x13, 0xec, 0x5f, 0x97, 0x44, 0x17,
-			0xc4, 0xa7, 0x7e, 0x3d, 0x64, 0x5d, 0x19, 0x73,
-			0x60, 0x81, 0x4f, 0xdc, 0x22, 0x2a, 0x90, 0x88,
-			0x46, 0xee, 0xb8, 0x14, 0xde, 0x5e, 0x0b, 0xdb,
-			0xe0, 0x32, 0x3a, 0x0a, 0x49, 0x06, 0x24, 0x5c,
-			0xc2, 0xd3, 0xac, 0x62, 0x91, 0x95, 0xe4, 0x79,
-			0xe7, 0xc8, 0x37, 0x6d, 0x8d, 0xd5, 0x4e, 0xa9,
-			0x6c, 0x56, 0xf4, 0xea, 0x65, 0x7a, 0xae, 0x08,
-			0xba, 0x78, 0x25, 0x2e, 0x1c, 0xa6, 0xb4, 0xc6,
-			0xe8, 0xdd, 0x74, 0x1f, 0x4b, 0xbd, 0x8b, 0x8a,
-			0x70, 0x3e, 0xb5, 0x66, 0x48, 0x03, 0xf6, 0x0e,
-			0x61, 0x35, 0x57, 0xb9, 0x86, 0xc1, 0x1d, 0x9e,
-			0xe1, 0xf8, 0x98, 0x11, 0x69, 0xd9, 0x8e, 0x94,
-			0x9b, 0x1e, 0x87, 0xe9, 0xce, 0x55, 0x28, 0xdf,
-			0x8c, 0xa1, 0x89, 0x0d, 0xbf, 0xe6, 0x42, 0x68,
-			0x41, 0x99, 0x2d, 0x0f, 0xb0, 0x54, 0xbb, 0x16
-		};
 
 /*****************************/
 /**** Function Prototypes ****/
@@ -814,13 +776,7 @@ static void construct_ctr_preload(u8 *ctr_preload,
 				  u8 *pn_vector,
 				  signed int c,
 				  uint frtype); /* for CONFIG_IEEE80211W, none 11w also can use */
-static void xor_128(u8 *a, u8 *b, u8 *out);
-static void xor_32(u8 *a, u8 *b, u8 *out);
-static u8 sbox(u8 a);
-static void next_key(u8 *key, signed int round);
-static void byte_sub(u8 *in, u8 *out);
-static void shift_row(u8 *in, u8 *out);
-static void mix_column(u8 *in, u8 *out);
+
 static void aes128k128d(u8 *key, u8 *data, u8 *ciphertext);
 
 
@@ -829,171 +785,13 @@ static void aes128k128d(u8 *key, u8 *data, u8 *ciphertext);
 /* Performs a 128 bit AES encrypt with  */
 /* 128 bit data.                        */
 /****************************************/
-static void xor_128(u8 *a, u8 *b, u8 *out)
-{
-		signed int i;
-
-		for (i = 0; i < 16; i++)
-			out[i] = a[i] ^ b[i];
-}
-
-
-static void xor_32(u8 *a, u8 *b, u8 *out)
-{
-		signed int i;
-
-		for (i = 0; i < 4; i++)
-			out[i] = a[i] ^ b[i];
-}
-
-
-static u8 sbox(u8 a)
-{
-		return sbox_table[(signed int)a];
-}
-
-
-static void next_key(u8 *key, signed int round)
-{
-		u8 rcon;
-		u8 sbox_key[4];
-		static const u8 rcon_table[12] = {
-			0x01, 0x02, 0x04, 0x08,
-			0x10, 0x20, 0x40, 0x80,
-			0x1b, 0x36, 0x36, 0x36
-		};
-		sbox_key[0] = sbox(key[13]);
-		sbox_key[1] = sbox(key[14]);
-		sbox_key[2] = sbox(key[15]);
-		sbox_key[3] = sbox(key[12]);
-
-		rcon = rcon_table[round];
-
-		xor_32(&key[0], sbox_key, &key[0]);
-		key[0] = key[0] ^ rcon;
-
-		xor_32(&key[4], &key[0], &key[4]);
-		xor_32(&key[8], &key[4], &key[8]);
-		xor_32(&key[12], &key[8], &key[12]);
-}
-
-
-static void byte_sub(u8 *in, u8 *out)
-{
-		signed int i;
-
-		for (i = 0; i < 16; i++)
-			out[i] = sbox(in[i]);
-}
-
-
-static void shift_row(u8 *in, u8 *out)
-{
-		out[0] =  in[0];
-		out[1] =  in[5];
-		out[2] =  in[10];
-		out[3] =  in[15];
-		out[4] =  in[4];
-		out[5] =  in[9];
-		out[6] =  in[14];
-		out[7] =  in[3];
-		out[8] =  in[8];
-		out[9] =  in[13];
-		out[10] = in[2];
-		out[11] = in[7];
-		out[12] = in[12];
-		out[13] = in[1];
-		out[14] = in[6];
-		out[15] = in[11];
-}
-
-static void mix_column(u8 *in, u8 *out)
-{
-		signed int i;
-		u8 add1b[4];
-		u8 add1bf7[4];
-		u8 rotl[4];
-		u8 swap_halfs[4];
-		u8 andf7[4];
-		u8 rotr[4];
-		u8 temp[4];
-		u8 tempb[4];
-
-		for (i = 0; i < 4; i++) {
-			if ((in[i] & 0x80) == 0x80)
-				add1b[i] = 0x1b;
-			else
-				add1b[i] = 0x00;
-		}
-
-		swap_halfs[0] = in[2];    /* Swap halfs */
-		swap_halfs[1] = in[3];
-		swap_halfs[2] = in[0];
-		swap_halfs[3] = in[1];
-
-		rotl[0] = in[3];        /* Rotate left 8 bits */
-		rotl[1] = in[0];
-		rotl[2] = in[1];
-		rotl[3] = in[2];
-
-		andf7[0] = in[0] & 0x7f;
-		andf7[1] = in[1] & 0x7f;
-		andf7[2] = in[2] & 0x7f;
-		andf7[3] = in[3] & 0x7f;
-
-		for (i = 3; i > 0; i--) {  /* logical shift left 1 bit */
-			andf7[i] = andf7[i] << 1;
-			if ((andf7[i-1] & 0x80) == 0x80)
-				andf7[i] = (andf7[i] | 0x01);
-		}
-		andf7[0] = andf7[0] << 1;
-		andf7[0] = andf7[0] & 0xfe;
-
-		xor_32(add1b, andf7, add1bf7);
-
-		xor_32(in, add1bf7, rotr);
-
-		temp[0] = rotr[0];         /* Rotate right 8 bits */
-		rotr[0] = rotr[1];
-		rotr[1] = rotr[2];
-		rotr[2] = rotr[3];
-		rotr[3] = temp[0];
-
-		xor_32(add1bf7, rotr, temp);
-		xor_32(swap_halfs, rotl, tempb);
-		xor_32(temp, tempb, out);
-}
-
 static void aes128k128d(u8 *key, u8 *data, u8 *ciphertext)
 {
-		signed int round;
-		signed int i;
-		u8 intermediatea[16];
-		u8 intermediateb[16];
-		u8 round_key[16];
+	struct crypto_aes_ctx ctx;
 
-		for (i = 0; i < 16; i++)
-			round_key[i] = key[i];
-
-		for (round = 0; round < 11; round++) {
-			if (round == 0) {
-				xor_128(round_key, data, ciphertext);
-				next_key(round_key, round);
-			} else if (round == 10) {
-				byte_sub(ciphertext, intermediatea);
-				shift_row(intermediatea, intermediateb);
-				xor_128(intermediateb, round_key, ciphertext);
-			} else {   /* 1 - 9 */
-				byte_sub(ciphertext, intermediatea);
-				shift_row(intermediatea, intermediateb);
-				mix_column(&intermediateb[0], &intermediatea[0]);
-				mix_column(&intermediateb[4], &intermediatea[4]);
-				mix_column(&intermediateb[8], &intermediatea[8]);
-				mix_column(&intermediateb[12], &intermediatea[12]);
-				xor_128(intermediatea, round_key, ciphertext);
-				next_key(round_key, round);
-			}
-		}
+	aes_expandkey(&ctx, key, 16);
+	aes_encrypt(&ctx, ciphertext, data);
+	memzero_explicit(&ctx, sizeof(ctx));
 }
 
 /************************************************/
-- 
2.20.1

