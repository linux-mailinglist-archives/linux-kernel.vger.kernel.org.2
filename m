Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C7CE034B79F
	for <lists+linux-kernel@lfdr.de>; Sat, 27 Mar 2021 15:26:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231168AbhC0OZy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 27 Mar 2021 10:25:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48312 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230287AbhC0OZS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 27 Mar 2021 10:25:18 -0400
Received: from mail-wm1-x335.google.com (mail-wm1-x335.google.com [IPv6:2a00:1450:4864:20::335])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ACE8DC0613B1
        for <linux-kernel@vger.kernel.org>; Sat, 27 Mar 2021 07:25:17 -0700 (PDT)
Received: by mail-wm1-x335.google.com with SMTP id n11-20020a05600c4f8bb029010e5cf86347so6981848wmq.1
        for <linux-kernel@vger.kernel.org>; Sat, 27 Mar 2021 07:25:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=aC2MQBdK86VOmvvorPF4ZeUskMEWXrm4ks1AVcEG2P4=;
        b=uIlIprkC927ILa8LaiWjskayz79eJ41t3D+91kN5bmBwIZXoL2RR8IvGQz+Oe7dATA
         tmVwyDFdYm6R0SBiJLycVY5bqAVbqP6jKQWD/mRaLjLb8y9Fu8raUrauGFTtpgJl23ye
         mv15O3gnfYF9+BHB4AW/A6XDHDR3jII3/ZLn02E60MLhX8EBaB1B+3O/tIrZwN2rQEUC
         U5QxQop+H5VKAlo7OHn67apuOF+0kgNy+n25p3n2ehj5TDBLN7ivh1687XoFZqYoiLSt
         1aZwMS41pJtcT4iZepmGf3lg78WBiCWyrsFba0uhwSpY1Ma6NBts4FABddlQnuKhHesb
         wJtQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=aC2MQBdK86VOmvvorPF4ZeUskMEWXrm4ks1AVcEG2P4=;
        b=Y42A5FQJBt64anO+8s1wsbcbcUvbIMu4wQvfOwGupc/NUOSU7xyfHUQGjwpi5RTLCO
         Xw6Lb/b67rxIDnIwVjx+GU429VMJmJEm9TUrtKfLbwAAOoBS7qPy27PqS/nhP5inYlvX
         nRafXfAJb0SoC7OSkQZRyjNzg0YVhUqPGei1ITc7atKOuiYI4+0SIE/56Jn6Rylzc1NE
         RHcnNoQd94Ak9ZaqSe88WWivO0/4Prj+RWAQXH6u0c7s6yNAh0DqKFxnozusCu+twgCM
         a4JQ21HH+GKxZUCW9TJc0sDuFM73cUrE3HDSvrnbvozL0xuTxDXLaS1x/KtF7AynIC4E
         2lBg==
X-Gm-Message-State: AOAM5317R6F20Dr+AkSxjKUMGv9L2vBUb0V2Zg+WhVCZbTKMuBHC6Hme
        3neJjCYCQvU4ylE6XF8dUUg=
X-Google-Smtp-Source: ABdhPJw/Po0vJ+I/da7K8qbrOKYw0vyvzJO7/yhIgUKjEguENQOrh2qG8pv1mHBeMc5ze1ftvHPmpQ==
X-Received: by 2002:a7b:cdf7:: with SMTP id p23mr17636215wmj.26.1616855116474;
        Sat, 27 Mar 2021 07:25:16 -0700 (PDT)
Received: from agape ([151.46.211.242])
        by smtp.gmail.com with ESMTPSA id s83sm16732187wmf.26.2021.03.27.07.25.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 27 Mar 2021 07:25:16 -0700 (PDT)
From:   Fabio Aiuto <fabioaiuto83@gmail.com>
To:     gregkh@linuxfoundation.org
Cc:     dan.carpenter@oracle.com, david.laight@aculab.com,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org,
        Fabio Aiuto <fabioaiuto83@gmail.com>
Subject: [PATCH v2 16/20] staging: rtl8723bs: put parentheses on macros with complex values in include/wifi.h
Date:   Sat, 27 Mar 2021 15:24:15 +0100
Message-Id: <99d3e605501c1792035e7403d6da86243e6b48cb.1616854134.git.fabioaiuto83@gmail.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <cover.1616854134.git.fabioaiuto83@gmail.com>
References: <cover.1616854134.git.fabioaiuto83@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

fix the following checkpatch warnings:

ERROR: Macros with complex values should be enclosed in parentheses
114: FILE: drivers/staging/rtl8723bs/include/wifi.h:114:
+#define SetToDs(pbuf)	\
--
ERROR: Macros with complex values should be enclosed in parentheses
122: FILE: drivers/staging/rtl8723bs/include/wifi.h:122:
+#define SetFrDs(pbuf)	\
--
ERROR: Macros with complex values should be enclosed in parentheses
132: FILE: drivers/staging/rtl8723bs/include/wifi.h:132:
+#define SetMFrag(pbuf)	\
--
ERROR: Macros with complex values should be enclosed in parentheses
137: FILE: drivers/staging/rtl8723bs/include/wifi.h:137:
+#define ClearMFrag(pbuf)	\
--
ERROR: Macros with complex values should be enclosed in parentheses
145: FILE: drivers/staging/rtl8723bs/include/wifi.h:145:
+#define ClearRetry(pbuf)	\
--
ERROR: Macros with complex values should be enclosed in parentheses
148: FILE: drivers/staging/rtl8723bs/include/wifi.h:148:
+#define SetPwrMgt(pbuf)	\
--
ERROR: Macros with complex values should be enclosed in parentheses
153: FILE: drivers/staging/rtl8723bs/include/wifi.h:153:
+#define ClearPwrMgt(pbuf)	\
--
ERROR: Macros with complex values should be enclosed in parentheses
156: FILE: drivers/staging/rtl8723bs/include/wifi.h:156:
+#define SetMData(pbuf)	\
--
ERROR: Macros with complex values should be enclosed in parentheses
161: FILE: drivers/staging/rtl8723bs/include/wifi.h:161:
+#define ClearMData(pbuf)	\
--
ERROR: Macros with complex values should be enclosed in parentheses
164: FILE: drivers/staging/rtl8723bs/include/wifi.h:164:
+#define SetPrivacy(pbuf)	\
--
ERROR: Macros with complex values should be enclosed in parentheses
220: FILE: drivers/staging/rtl8723bs/include/wifi.h:220:
+#define SetDuration(pbuf, dur) \
--
ERROR: Macros with complex values should be enclosed in parentheses
224: FILE: drivers/staging/rtl8723bs/include/wifi.h:224:
+#define SetPriority(pbuf, tid)	\
--
ERROR: Macros with complex values should be enclosed in parentheses
229: FILE: drivers/staging/rtl8723bs/include/wifi.h:229:
+#define SetEOSP(pbuf, eosp)	\
--
ERROR: Macros with complex values should be enclosed in parentheses
232: FILE: drivers/staging/rtl8723bs/include/wifi.h:232:
+#define SetAckpolicy(pbuf, ack)	\

Signed-off-by: Fabio Aiuto <fabioaiuto83@gmail.com>
---
 drivers/staging/rtl8723bs/include/wifi.h | 28 ++++++++++++------------
 1 file changed, 14 insertions(+), 14 deletions(-)

diff --git a/drivers/staging/rtl8723bs/include/wifi.h b/drivers/staging/rtl8723bs/include/wifi.h
index 4f8d08c00694..69e714a6d87c 100644
--- a/drivers/staging/rtl8723bs/include/wifi.h
+++ b/drivers/staging/rtl8723bs/include/wifi.h
@@ -98,48 +98,48 @@ enum {
 #define _ORDER_			BIT(15)
 
 #define SetToDs(pbuf)	\
-	*(__le16 *)(pbuf) |= cpu_to_le16(_TO_DS_)
+	(*(__le16 *)(pbuf) |= cpu_to_le16(_TO_DS_))
 
 #define GetToDs(pbuf)	(((*(__le16 *)(pbuf)) & cpu_to_le16(_TO_DS_)) != 0)
 
 #define SetFrDs(pbuf)	\
-	*(__le16 *)(pbuf) |= cpu_to_le16(_FROM_DS_)
+	(*(__le16 *)(pbuf) |= cpu_to_le16(_FROM_DS_))
 
 #define GetFrDs(pbuf)	(((*(__le16 *)(pbuf)) & cpu_to_le16(_FROM_DS_)) != 0)
 
 #define get_tofr_ds(pframe)	((GetToDs(pframe) << 1) | GetFrDs(pframe))
 
 #define SetMFrag(pbuf)	\
-	*(__le16 *)(pbuf) |= cpu_to_le16(_MORE_FRAG_)
+	(*(__le16 *)(pbuf) |= cpu_to_le16(_MORE_FRAG_))
 
 #define GetMFrag(pbuf)	(((*(__le16 *)(pbuf)) & cpu_to_le16(_MORE_FRAG_)) != 0)
 
 #define ClearMFrag(pbuf)	\
-	*(__le16 *)(pbuf) &= (~cpu_to_le16(_MORE_FRAG_))
+	(*(__le16 *)(pbuf) &= (~cpu_to_le16(_MORE_FRAG_)))
 
 #define GetRetry(pbuf)	(((*(__le16 *)(pbuf)) & cpu_to_le16(_RETRY_)) != 0)
 
 #define ClearRetry(pbuf)	\
-	*(__le16 *)(pbuf) &= (~cpu_to_le16(_RETRY_))
+	(*(__le16 *)(pbuf) &= (~cpu_to_le16(_RETRY_)))
 
 #define SetPwrMgt(pbuf)	\
-	*(__le16 *)(pbuf) |= cpu_to_le16(_PWRMGT_)
+	(*(__le16 *)(pbuf) |= cpu_to_le16(_PWRMGT_))
 
 #define GetPwrMgt(pbuf)	(((*(__le16 *)(pbuf)) & cpu_to_le16(_PWRMGT_)) != 0)
 
 #define ClearPwrMgt(pbuf)	\
-	*(__le16 *)(pbuf) &= (~cpu_to_le16(_PWRMGT_))
+	(*(__le16 *)(pbuf) &= (~cpu_to_le16(_PWRMGT_)))
 
 #define SetMData(pbuf)	\
-	*(__le16 *)(pbuf) |= cpu_to_le16(_MORE_DATA_)
+	(*(__le16 *)(pbuf) |= cpu_to_le16(_MORE_DATA_))
 
 #define GetMData(pbuf)	(((*(__le16 *)(pbuf)) & cpu_to_le16(_MORE_DATA_)) != 0)
 
 #define ClearMData(pbuf)	\
-	*(__le16 *)(pbuf) &= (~cpu_to_le16(_MORE_DATA_))
+	(*(__le16 *)(pbuf) &= (~cpu_to_le16(_MORE_DATA_)))
 
 #define SetPrivacy(pbuf)	\
-	*(__le16 *)(pbuf) |= cpu_to_le16(_PRIVACY_)
+	(*(__le16 *)(pbuf) |= cpu_to_le16(_PRIVACY_))
 
 #define GetPrivacy(pbuf)					\
 	(((*(__le16 *)(pbuf)) & cpu_to_le16(_PRIVACY_)) != 0)
@@ -191,19 +191,19 @@ enum {
 	} while (0)
 
 #define SetDuration(pbuf, dur) \
-	*(__le16 *)((size_t)(pbuf) + 2) = cpu_to_le16(0xffff & (dur))
+	(*(__le16 *)((size_t)(pbuf) + 2) = cpu_to_le16(0xffff & (dur)))
 
 
 #define SetPriority(pbuf, tid)	\
-	*(__le16 *)(pbuf) |= cpu_to_le16(tid & 0xf)
+	(*(__le16 *)(pbuf) |= cpu_to_le16(tid & 0xf))
 
 #define GetPriority(pbuf)	((le16_to_cpu(*(__le16 *)(pbuf))) & 0xf)
 
 #define SetEOSP(pbuf, eosp)	\
-		*(__le16 *)(pbuf) |= cpu_to_le16((eosp & 1) << 4)
+		(*(__le16 *)(pbuf) |= cpu_to_le16((eosp & 1) << 4))
 
 #define SetAckpolicy(pbuf, ack)	\
-	*(__le16 *)(pbuf) |= cpu_to_le16((ack & 3) << 5)
+	(*(__le16 *)(pbuf) |= cpu_to_le16((ack & 3) << 5))
 
 #define GetAckpolicy(pbuf) (((le16_to_cpu(*(__le16 *)pbuf)) >> 5) & 0x3)
 
-- 
2.20.1

