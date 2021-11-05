Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5A13944675B
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Nov 2021 17:54:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234098AbhKEQ4a (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 5 Nov 2021 12:56:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60598 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234090AbhKEQ40 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 5 Nov 2021 12:56:26 -0400
Received: from mail-pl1-x62f.google.com (mail-pl1-x62f.google.com [IPv6:2607:f8b0:4864:20::62f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7FBEBC061205
        for <linux-kernel@vger.kernel.org>; Fri,  5 Nov 2021 09:53:46 -0700 (PDT)
Received: by mail-pl1-x62f.google.com with SMTP id y1so11412496plk.10
        for <linux-kernel@vger.kernel.org>; Fri, 05 Nov 2021 09:53:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:subject:date:message-id:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=lw3syTyl3QqLO29zLcWWRiGYqMVOb7lRsimsIo5QZQI=;
        b=EYNJQo8oY4YQdKtotJz2ACvtjZlQbJH0MbT7hl1u4TJdfjiSrCp+NbsVXkcCa21Zpx
         GyveAAknMlwKA0cRiu29+skMKKvYwjZF+6rcBW+2r5RmXyFxodNyOpGZRCyAr4Rnrgwi
         yN7kLDwY8+1giGqYJ3uSxh1ncdJSsf/3dKXXp7pJRxWmJz3YnHdU2JtgkRRmwYYLh8L9
         7VEuaAUqNKzGVU28KkiB/aV9MrEZky5tcyg9HV5VtF52WtDijsX+kJ3P+VbjaUIrlnMX
         B+8LZLqLvZSXT5+m09BCyC5FPtC6nX35MncTGucxo1E71S+iZoWP1i3qFJgPcvSPVWw4
         EMwg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=lw3syTyl3QqLO29zLcWWRiGYqMVOb7lRsimsIo5QZQI=;
        b=gwWRJTtE2jXIuLhvFegh/4417hnOMx5BeRMO3oajnj8tDXDJq3Z6wel69QIKGlc2ZA
         29tw2gFeZOGIyURoezKePTx6vKcmiTt64m7MZ0GrWENdzu3NzXp8h8jHayESTcLnTJj+
         h1w7hZROj47LL/LFkCi8O8RpZvFGbMmVR+stwq7o67V94dEiASTcQ5v08P5Xdd4CehfG
         xek+rGpdIRCbBwxb/WUsnTYlvDO5qwqxsiYXGm8yklSEJMZgQSx8ANnmm5NqXFz2Ejdt
         gey8vVsdX3k/HVb/rB9HCnOSs+Vyhr0mY2l6KhNMd3dypNt6ck8TEiIsatSX7e2tKffu
         GEyw==
X-Gm-Message-State: AOAM533udN9dJsVN+fgxj9kIGj9IeEp6xbcokntGTENmab57jXGPw08E
        VAhkZf/0WpKwhSYTLwqa7h4=
X-Google-Smtp-Source: ABdhPJyGCBcbqSIiQ8r8ja5/bhzaW2JyKiS6HqAQ4B3kB157FrkOroJ75RQNBHVGdFC8RBSnEqWazQ==
X-Received: by 2002:a17:90b:3717:: with SMTP id mg23mr31743831pjb.107.1636131226006;
        Fri, 05 Nov 2021 09:53:46 -0700 (PDT)
Received: from localhost.localdomain ([2001:4490:4409:3406:a18f:7c45:2f81:cea2])
        by smtp.gmail.com with ESMTPSA id s30sm8524425pfg.17.2021.11.05.09.53.42
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 05 Nov 2021 09:53:45 -0700 (PDT)
From:   Saurav Girepunje <saurav.girepunje@gmail.com>
To:     gregkh@linuxfoundation.org, fabioaiuto83@gmail.com,
        saurav.girepunje@gmail.com, dan.carpenter@oracle.com,
        shreyaskumar1035@gmail.com, ross.schm.dev@gmail.com,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: [PATCH 1/2] staging: rtl8723bs: core: remove unused variable pAdapter
Date:   Fri,  5 Nov 2021 22:23:29 +0530
Message-Id: <20211105165330.78524-2-saurav.girepunje@gmail.com>
X-Mailer: git-send-email 2.33.0
In-Reply-To: <20211105165330.78524-1-saurav.girepunje@gmail.com>
References: <saurav.girepunje@gmail.com>
 <20211105165330.78524-1-saurav.girepunje@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Remove the unused variable pAdapter from Efuse_Read1ByteFromFakeContent
This variable is not used in the function.

Signed-off-by: Saurav Girepunje <saurav.girepunje@gmail.com>
---
 drivers/staging/rtl8723bs/core/rtw_efuse.c | 7 ++-----
 1 file changed, 2 insertions(+), 5 deletions(-)

diff --git a/drivers/staging/rtl8723bs/core/rtw_efuse.c b/drivers/staging/rtl8723bs/core/rtw_efuse.c
index 430e2d81924c..bd057e041a08 100644
--- a/drivers/staging/rtl8723bs/core/rtw_efuse.c
+++ b/drivers/staging/rtl8723bs/core/rtw_efuse.c
@@ -31,10 +31,7 @@ u8 fakeBTEfuseModifiedMap[EFUSE_BT_MAX_MAP_LEN] = {0};
 #define EFUSE_CTRL			REG_EFUSE_CTRL		/*  E-Fuse Control. */
 
 static bool
-Efuse_Read1ByteFromFakeContent(
-	struct adapter *padapter,
-	u16 	Offset,
-	u8 *Value)
+Efuse_Read1ByteFromFakeContent(u16 Offset, u8 *Value)
 {
 	if (Offset >= EFUSE_MAX_HW_SIZE)
 		return false;
@@ -250,7 +247,7 @@ bool		bPseudoTest)
 	u8 readbyte;
 
 	if (bPseudoTest)
-		return Efuse_Read1ByteFromFakeContent(padapter, addr, data);
+		return Efuse_Read1ByteFromFakeContent(addr, data);
 
 	/*  <20130121, Kordan> For SMIC EFUSE specificatoin. */
 	/* 0x34[11]: SW force PGMEN input of efuse to high. (for the bank selected by 0x34[9:8]) */
-- 
2.33.0

