Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CF1D1402042
	for <lists+linux-kernel@lfdr.de>; Mon,  6 Sep 2021 21:07:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344039AbhIFTGb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 6 Sep 2021 15:06:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38504 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1343526AbhIFTEL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Sep 2021 15:04:11 -0400
Received: from mail-ej1-x632.google.com (mail-ej1-x632.google.com [IPv6:2a00:1450:4864:20::632])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C7337C0613C1
        for <linux-kernel@vger.kernel.org>; Mon,  6 Sep 2021 12:03:06 -0700 (PDT)
Received: by mail-ej1-x632.google.com with SMTP id me10so15092474ejb.11
        for <linux-kernel@vger.kernel.org>; Mon, 06 Sep 2021 12:03:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=iEzDdyzAFFu2bR5f0c3Tr73sdtBpa1SXUiajkJlqtqo=;
        b=oCWD0EZgpZb9yKwmJ1UUF0XlvAGzOB1JuDgS7TQQhnpabqYDVjlc3NdLtxxd6piV7Y
         MJ9SaHUymGC0j28N5Bc5pZVV10d78+MH4xlHy/FLb+5HRvGlSsS9Zajvv+ld7vNtUk/I
         0YyMd32dkyu2rIWKHvQcG+V+Y+spieJ8XViDhystR46ddhEmeMSTtZm80wv8nwqWF6qp
         6WUj+scaVSiXFvGEkTSBx+MQlmLP7qW2ShVH1nF/TJU3KRV92X7qo04Wl2FJuSgqMIRs
         +R46Kp9voWgyHJ7ZksM7IdBDBdwG/UZHaRbFmUHSd7lN/yL4mJ8pkLTNJqYh+OBPzN3Q
         Xddg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=iEzDdyzAFFu2bR5f0c3Tr73sdtBpa1SXUiajkJlqtqo=;
        b=I7vzhKt2K4I/rqzkp2aDI1WqOdp7Sn7M3ipyuqbwdKrob8Wyc84T/Jdy2QzkO6ysPr
         iqzaDRnKz7ZVWLzOi1M3IORwh9IdfOBDLq3i2NfW0BIkFy68ojDD6jj0JayPA9m38ip9
         qUFUUKhcE6EfRJcEU3sfuswllI8/5q2kK2YTU5uQtuV9Kq+UgATj/4T1Z81LnNiYXV0d
         /GNMNFyPMS8uGvEbJdAIl6jKG3pHJG0Ac+KWJPbAaj8CFE4YsB8ufjANKijQY/C2CBuK
         QT5PTsL5WCHlGgBqdOKI2k7d1zF4EGYta2EmaNF6ahiEvZPLNTWPu14Eycsemxkq3XJn
         gVZA==
X-Gm-Message-State: AOAM5327XRscBTluY70zYGlM1HFyQkq09KqA4jqGenJ9OGGSUlnU772f
        r3Jn7vO81/mFZrlSuNrTasE=
X-Google-Smtp-Source: ABdhPJzuJhjGgKsfpbj3ZkO6bF3+sAZRqiAjhDYHmUhchpk6bJUezSmR6azKOw2EAxW9Zb70vuA64A==
X-Received: by 2002:a17:906:fb19:: with SMTP id lz25mr15122371ejb.162.1630954985392;
        Mon, 06 Sep 2021 12:03:05 -0700 (PDT)
Received: from localhost.localdomain ([2a02:8108:96c0:3b88::8fe1])
        by smtp.gmail.com with ESMTPSA id k15sm4372018ejb.92.2021.09.06.12.03.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 06 Sep 2021 12:03:05 -0700 (PDT)
From:   Michael Straube <straube.linux@gmail.com>
To:     gregkh@linuxfoundation.org
Cc:     Larry.Finger@lwfinger.net, phil@philpotter.co.uk, martin@kaiser.cx,
        fmdefrancesco@gmail.com, linux-staging@lists.linux.dev,
        linux-kernel@vger.kernel.org,
        Michael Straube <straube.linux@gmail.com>
Subject: [PATCH v3 27/40] staging: r8188eu: remove empty comments
Date:   Mon,  6 Sep 2021 21:02:10 +0200
Message-Id: <20210906190223.11396-28-straube.linux@gmail.com>
X-Mailer: git-send-email 2.33.0
In-Reply-To: <20210906190223.11396-1-straube.linux@gmail.com>
References: <20210906190223.11396-1-straube.linux@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Remove empty comments.

Signed-off-by: Michael Straube <straube.linux@gmail.com>
---
 drivers/staging/r8188eu/core/rtw_efuse.c | 12 +++++-------
 1 file changed, 5 insertions(+), 7 deletions(-)

diff --git a/drivers/staging/r8188eu/core/rtw_efuse.c b/drivers/staging/r8188eu/core/rtw_efuse.c
index bae9a32ec27e..9196a7925940 100644
--- a/drivers/staging/r8188eu/core/rtw_efuse.c
+++ b/drivers/staging/r8188eu/core/rtw_efuse.c
@@ -25,10 +25,9 @@ u8 fakeBTEfuseInitMap[EFUSE_BT_MAX_MAP_LEN] = {0};
 u8 fakeBTEfuseModifiedMap[EFUSE_BT_MAX_MAP_LEN] = {0};
 /*------------------------Define local variable------------------------------*/
 
-/*  */
 #define REG_EFUSE_CTRL		0x0030
 #define EFUSE_CTRL			REG_EFUSE_CTRL		/*  E-Fuse Control. */
-/*  */
+
 static bool Efuse_Read1ByteFromFakeContent(struct adapter *pAdapter,
 					   u16 Offset,
 					   u8 *Value)
@@ -364,14 +363,14 @@ u8 rtw_efuse_access(struct adapter *padapter, u8 write, u16 start_addr, u16 cnts
 
 	return res;
 }
-/*  */
+
 u16 efuse_GetMaxSize(struct adapter *padapter)
 {
 	u16 max_size;
 	rtl8188e_EFUSE_GetEfuseDefinition(padapter, EFUSE_WIFI, TYPE_AVAILABLE_EFUSE_BYTES_TOTAL, (void *)&max_size, false);
 	return max_size;
 }
-/*  */
+
 u8 efuse_GetCurrentSize(struct adapter *padapter, u16 *size)
 {
 	rtl8188e_EfusePowerSwitch(padapter, false, true);
@@ -380,7 +379,7 @@ u8 efuse_GetCurrentSize(struct adapter *padapter, u16 *size)
 
 	return _SUCCESS;
 }
-/*  */
+
 u8 rtw_efuse_map_read(struct adapter *padapter, u16 addr, u16 cnts, u8 *data)
 {
 	u16 mapLen = 0;
@@ -416,7 +415,7 @@ u8 rtw_BT_efuse_map_read(struct adapter *padapter, u16 addr, u16 cnts, u8 *data)
 
 	return _SUCCESS;
 }
-/*  */
+
 u8 rtw_efuse_map_write(struct adapter *padapter, u16 addr, u16 cnts, u8 *data)
 {
 	u8 offset, word_en;
@@ -508,7 +507,6 @@ u8 rtw_efuse_map_write(struct adapter *padapter, u16 addr, u16 cnts, u8 *data)
 	return ret;
 }
 
-/*  */
 u8 rtw_BT_efuse_map_write(struct adapter *padapter, u16 addr, u16 cnts, u8 *data)
 {
 	u8 offset, word_en;
-- 
2.33.0

