Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6E0C234A3BC
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Mar 2021 10:10:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229908AbhCZJJ7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 26 Mar 2021 05:09:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38888 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229682AbhCZJJo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 Mar 2021 05:09:44 -0400
Received: from mail-wm1-x32b.google.com (mail-wm1-x32b.google.com [IPv6:2a00:1450:4864:20::32b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AB2B3C0613AA
        for <linux-kernel@vger.kernel.org>; Fri, 26 Mar 2021 02:09:43 -0700 (PDT)
Received: by mail-wm1-x32b.google.com with SMTP id g25so2610890wmh.0
        for <linux-kernel@vger.kernel.org>; Fri, 26 Mar 2021 02:09:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=7XGapRiKO4+2TXKmvx4B6Rzd3Ql3zL4BqJCvy9W6Mn4=;
        b=fRh0leJUoB7JDSCojU69M8j/A7INx0lsOIQa6VF5D73P8FOkpfzLzV5M1TT5to3ghk
         fF6fAThjhLmcu4xVZAJtQ543bEAaBwv4sQKRO9IH6h6B4/iWBrGGcTU7jzIaNgnWjHPi
         f8GNqXcP1fzBGcReMCQZr+K/W2jsfIzQ7nghgUOOdjaXpzW0/vyYAct4hYhcV2FOt4kN
         hftxmWffdsXIabjiJiGZ+2XnydkJPpYCozDpn1ZctEdy6ev09kh2w+HwLCWBgkw2wh8g
         lcZr2UJfg/4uKNrlcSRDfQGb+aezbPUep9UC0Vxj1+KTcZrn3+NL4VYrmPw1AVH9/rJs
         B9Sg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=7XGapRiKO4+2TXKmvx4B6Rzd3Ql3zL4BqJCvy9W6Mn4=;
        b=ku5D2gAfhcIbYhDYCuY3vB3gsvAeGWwDs+gn/pC+iTQqmzIV+vQwC3289EXVVLpf3c
         xhOYT22LrrUKXofYrcFeQNlBJ5DMcA+8ZeDnTEGUMMb3xi2L5ERNPQyxUZPEECoTzGNl
         wJOUUrYVMXl2UkCe+kO0DFI39pNgjqPs73H+lgaNwA0w9zaBL52QepcMQoAAq2jfVpI8
         WCYitfF6XppYh/VS949cxB2A2SCdsLc0lhvyYjFVh6Iu9YWezAW/MGWfPKaJNF3yr/Pv
         r+8X3N831IB35Qf523sufCXER1tXmU3ebqUXoyQxOHFnOY8vVpF6mfO2Mx6wy49exNgl
         X3ew==
X-Gm-Message-State: AOAM533Ywc2VyhTpugD0jNhjJTtaYoo7CGpIv1joonJjTO2w9qt+BZWu
        X1A39gRVW/K3/ZgSBFUk7Mg=
X-Google-Smtp-Source: ABdhPJzWU0i1JZnNa67EmsMv65O5YUxz3f7r38QpwriYWrmyJPZ+minpcNFt7NqP1AO9uQ0GT33o0w==
X-Received: by 2002:a05:600c:d1:: with SMTP id u17mr12142844wmm.64.1616749782403;
        Fri, 26 Mar 2021 02:09:42 -0700 (PDT)
Received: from agape ([5.171.81.75])
        by smtp.gmail.com with ESMTPSA id k12sm11853569wrx.7.2021.03.26.02.09.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 26 Mar 2021 02:09:42 -0700 (PDT)
From:   Fabio Aiuto <fabioaiuto83@gmail.com>
To:     gregkh@linuxfoundation.org
Cc:     linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org,
        Fabio Aiuto <fabioaiuto83@gmail.com>
Subject: [PATCH 01/15] staging: rtl8723bs: inlcude macros in a do..while loop in core/rtw_security.c
Date:   Fri, 26 Mar 2021 10:09:08 +0100
Message-Id: <2e02f646ab3f8058b159d6d790e202a0e4744af8.1616748885.git.fabioaiuto83@gmail.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <cover.1616748885.git.fabioaiuto83@gmail.com>
References: <cover.1616748885.git.fabioaiuto83@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

fix the following checkpatch warning:

ERROR: Macros starting with if should be enclosed by a do - while
loop to avoid possible if/else logic defects
33: FILE: drivers/staging/rtl8723bs/core/rtw_security.c:33:
+#define WEP_SW_ENC_CNT_INC(sec, ra) \
--
ERROR: Macros starting with if should be enclosed by a do - while
loop to avoid possible if/else logic defects
41: FILE: drivers/staging/rtl8723bs/core/rtw_security.c:41:
+#define WEP_SW_DEC_CNT_INC(sec, ra) \
--
ERROR: Macros starting with if should be enclosed by a do - while
loop to avoid possible if/else logic defects
49: FILE: drivers/staging/rtl8723bs/core/rtw_security.c:49:
+#define TKIP_SW_ENC_CNT_INC(sec, ra) \
--
ERROR: Macros starting with if should be enclosed by a do - while
loop to avoid possible if/else logic defects
57: FILE: drivers/staging/rtl8723bs/core/rtw_security.c:57:
+#define TKIP_SW_DEC_CNT_INC(sec, ra) \
--
ERROR: Macros starting with if should be enclosed by a do - while
loop to avoid possible if/else logic defects
65: FILE: drivers/staging/rtl8723bs/core/rtw_security.c:65:
+#define AES_SW_ENC_CNT_INC(sec, ra) \
--
ERROR: Macros starting with if should be enclosed by a do - while
loop to avoid possible if/else logic defects
73: FILE: drivers/staging/rtl8723bs/core/rtw_security.c:73:
+#define AES_SW_DEC_CNT_INC(sec, ra) \
--
ERROR: Macros with multiple statements should be enclosed in a
do - while loop
2082: FILE: drivers/staging/rtl8723bs/core/rtw_security.c:2082:
+#define ROUND(i, d, s) \

Signed-off-by: Fabio Aiuto <fabioaiuto83@gmail.com>
---
 drivers/staging/rtl8723bs/core/rtw_security.c | 94 +++++++++++--------
 1 file changed, 54 insertions(+), 40 deletions(-)

diff --git a/drivers/staging/rtl8723bs/core/rtw_security.c b/drivers/staging/rtl8723bs/core/rtw_security.c
index 44e2b362c867..c92984fcf42d 100644
--- a/drivers/staging/rtl8723bs/core/rtw_security.c
+++ b/drivers/staging/rtl8723bs/core/rtw_security.c
@@ -31,52 +31,64 @@ const char *security_type_str(u8 value)
 
 #ifdef DBG_SW_SEC_CNT
 #define WEP_SW_ENC_CNT_INC(sec, ra) \
-	if (is_broadcast_mac_addr(ra)) \
-		sec->wep_sw_enc_cnt_bc++; \
-	else if (is_multicast_mac_addr(ra)) \
-		sec->wep_sw_enc_cnt_mc++; \
-	else \
-		sec->wep_sw_enc_cnt_uc++;
+	do { \
+		if (is_broadcast_mac_addr(ra)) \
+			sec->wep_sw_enc_cnt_bc++; \
+		else if (is_multicast_mac_addr(ra)) \
+			sec->wep_sw_enc_cnt_mc++; \
+		else \
+			sec->wep_sw_enc_cnt_uc++; \
+	} while (0)
 
 #define WEP_SW_DEC_CNT_INC(sec, ra) \
-	if (is_broadcast_mac_addr(ra)) \
-		sec->wep_sw_dec_cnt_bc++; \
-	else if (is_multicast_mac_addr(ra)) \
-		sec->wep_sw_dec_cnt_mc++; \
-	else \
-		sec->wep_sw_dec_cnt_uc++;
+	do { \
+		if (is_broadcast_mac_addr(ra)) \
+			sec->wep_sw_dec_cnt_bc++; \
+		else if (is_multicast_mac_addr(ra)) \
+			sec->wep_sw_dec_cnt_mc++; \
+		else \
+			sec->wep_sw_dec_cnt_uc++; \
+	} while (0)
 
 #define TKIP_SW_ENC_CNT_INC(sec, ra) \
-	if (is_broadcast_mac_addr(ra)) \
-		sec->tkip_sw_enc_cnt_bc++; \
-	else if (is_multicast_mac_addr(ra)) \
-		sec->tkip_sw_enc_cnt_mc++; \
-	else \
-		sec->tkip_sw_enc_cnt_uc++;
+	do { \
+		if (is_broadcast_mac_addr(ra)) \
+			sec->tkip_sw_enc_cnt_bc++; \
+		else if (is_multicast_mac_addr(ra)) \
+			sec->tkip_sw_enc_cnt_mc++; \
+		else \
+			sec->tkip_sw_enc_cnt_uc++; \
+	} while (0)
 
 #define TKIP_SW_DEC_CNT_INC(sec, ra) \
-	if (is_broadcast_mac_addr(ra)) \
-		sec->tkip_sw_dec_cnt_bc++; \
-	else if (is_multicast_mac_addr(ra)) \
-		sec->tkip_sw_dec_cnt_mc++; \
-	else \
-		sec->tkip_sw_dec_cnt_uc++;
+	do { \
+		if (is_broadcast_mac_addr(ra)) \
+			sec->tkip_sw_dec_cnt_bc++; \
+		else if (is_multicast_mac_addr(ra)) \
+			sec->tkip_sw_dec_cnt_mc++; \
+		else \
+			sec->tkip_sw_dec_cnt_uc++; \
+	} while (0)
 
 #define AES_SW_ENC_CNT_INC(sec, ra) \
-	if (is_broadcast_mac_addr(ra)) \
-		sec->aes_sw_enc_cnt_bc++; \
-	else if (is_multicast_mac_addr(ra)) \
-		sec->aes_sw_enc_cnt_mc++; \
-	else \
-		sec->aes_sw_enc_cnt_uc++;
+	do { \
+		if (is_broadcast_mac_addr(ra)) \
+			sec->aes_sw_enc_cnt_bc++; \
+		else if (is_multicast_mac_addr(ra)) \
+			sec->aes_sw_enc_cnt_mc++; \
+		else \
+			sec->aes_sw_enc_cnt_uc++; \
+	} while (0)
 
 #define AES_SW_DEC_CNT_INC(sec, ra) \
-	if (is_broadcast_mac_addr(ra)) \
-		sec->aes_sw_dec_cnt_bc++; \
-	else if (is_multicast_mac_addr(ra)) \
-		sec->aes_sw_dec_cnt_mc++; \
-	else \
-		sec->aes_sw_dec_cnt_uc++;
+	do { \
+		if (is_broadcast_mac_addr(ra)) \
+			sec->aes_sw_dec_cnt_bc++; \
+		else if (is_multicast_mac_addr(ra)) \
+			sec->aes_sw_dec_cnt_mc++; \
+		else \
+			sec->aes_sw_dec_cnt_uc++; \
+	} while (0)
 #else
 #define WEP_SW_ENC_CNT_INC(sec, ra)
 #define WEP_SW_DEC_CNT_INC(sec, ra)
@@ -2080,10 +2092,12 @@ static void rijndaelEncrypt(u32 rk[/*44*/], u8 pt[16], u8 ct[16])
 	s3 = GETU32(pt + 12) ^ rk[3];
 
 #define ROUND(i, d, s) \
-d##0 = TE0(s##0) ^ TE1(s##1) ^ TE2(s##2) ^ TE3(s##3) ^ rk[4 * i]; \
-d##1 = TE0(s##1) ^ TE1(s##2) ^ TE2(s##3) ^ TE3(s##0) ^ rk[4 * i + 1]; \
-d##2 = TE0(s##2) ^ TE1(s##3) ^ TE2(s##0) ^ TE3(s##1) ^ rk[4 * i + 2]; \
-d##3 = TE0(s##3) ^ TE1(s##0) ^ TE2(s##1) ^ TE3(s##2) ^ rk[4 * i + 3]
+	do { \
+		d##0 = TE0(s##0) ^ TE1(s##1) ^ TE2(s##2) ^ TE3(s##3) ^ rk[4 * i]; \
+		d##1 = TE0(s##1) ^ TE1(s##2) ^ TE2(s##3) ^ TE3(s##0) ^ rk[4 * i + 1]; \
+		d##2 = TE0(s##2) ^ TE1(s##3) ^ TE2(s##0) ^ TE3(s##1) ^ rk[4 * i + 2]; \
+		d##3 = TE0(s##3) ^ TE1(s##0) ^ TE2(s##1) ^ TE3(s##2) ^ rk[4 * i + 3]; \
+	} while (0)
 
 	/* Nr - 1 full rounds: */
 	r = Nr >> 1;
-- 
2.20.1

