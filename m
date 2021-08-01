Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0DE1E3DCC84
	for <lists+linux-kernel@lfdr.de>; Sun,  1 Aug 2021 17:52:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232134AbhHAPwO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 1 Aug 2021 11:52:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34024 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232017AbhHAPwL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 1 Aug 2021 11:52:11 -0400
Received: from mail-pj1-x102d.google.com (mail-pj1-x102d.google.com [IPv6:2607:f8b0:4864:20::102d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4FBF0C06175F
        for <linux-kernel@vger.kernel.org>; Sun,  1 Aug 2021 08:52:02 -0700 (PDT)
Received: by mail-pj1-x102d.google.com with SMTP id g23-20020a17090a5797b02901765d605e14so21351801pji.5
        for <linux-kernel@vger.kernel.org>; Sun, 01 Aug 2021 08:52:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=xHYz6uN9LUWOmvY1GgfHO4Y8UXl1Yz9tQPohZSg/xdA=;
        b=DIVTihfQx7ZoyF6uyVetp28JcN9ffC3/WRCuobr8y+uj5C1IXeaj0tGzXnLZQdyIzz
         Q2Ia91APyDM+kAiL4nO6TNczvhaRF9BDpPA/Dcw2ZpcwKd0TsJwPceAKJDCSS8UfP3FB
         nBpJFPR91l/Efd3YBzYgI0JANeJ+Kxr34XT4d98rvgKJynnsuREKt8bWit600vIbaIjW
         RuC6fUrTgkKpkXKKvnHGnhVJFVUzqHjMBVGILSDgcyRNFj8weeGGgWixNoVg2x5SUOvU
         RuTJuQ7w64Qxy/hEUaH9pB1w4d6PjA91W47m/Nq6QawzpIrtqx+0sDEdENvLM8dBIfMe
         glLQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=xHYz6uN9LUWOmvY1GgfHO4Y8UXl1Yz9tQPohZSg/xdA=;
        b=gjFNDqqNfMkBcxPHTah1rrf5SIADNlZICxB2egZpZ4LUCMQDYEmEB2XUuw1W+5OHiE
         SfiwhXqEZsmVFXnnuDISBS+7A/7XAGrvBcsdgGoeHO75ouSQVeeHQdkXiUrEodRJmNOm
         8wFDKBZDv9HCl5lTgIhyLrZr93Q9bDolj7eSGAgzC1jt/BkGs0Pr0HeiH0A6O/wauSQL
         nHdDMfSlWTcDCJj5k8lULYwR3338N+FGlDHYlxP1xgpEc8zz1g/geTG+FdrximCkZQU+
         WsweqWSY0KSTlFNPUOKSvsfzLy3DCT1QzXRjyhkPfcYNmv8VEJc5KpQ4dDX2PYOnfIpf
         EWwA==
X-Gm-Message-State: AOAM532CR1Hyh/0dKM6kCYUBC1OTMw5F9NjeqdNiH8QEqGtGokdshi+K
        hrI+ER9kBCsp9newr2QAowowG42jb73DHw==
X-Google-Smtp-Source: ABdhPJzRpZdLWngsKXPlPYXZ3ycUcVxOFOUrjpmiy1xtLZie17+yQVXoPRofZuvjmKHrUthDPtyLWg==
X-Received: by 2002:a62:3342:0:b029:3b7:6395:a93 with SMTP id z63-20020a6233420000b02903b763950a93mr5305787pfz.71.1627833121661;
        Sun, 01 Aug 2021 08:52:01 -0700 (PDT)
Received: from jm.lan (1-171-223-196.dynamic-ip.hinet.net. [1.171.223.196])
        by smtp.gmail.com with ESMTPSA id n33sm9579563pgm.55.2021.08.01.08.51.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 01 Aug 2021 08:52:00 -0700 (PDT)
From:   Jhih-Ming Huang <fbihjmeric@gmail.com>
To:     gregkh@linuxfoundation.org, fabioaiuto83@gmail.com,
        ross.schm.dev@gmail.com, maqianga@uniontech.com,
        marcocesati@gmail.com, linux-staging@lists.linux.dev,
        linux-kernel@vger.kernel.org
Cc:     Jhih-Ming Huang <fbihjmeric@gmail.com>,
        kernel test robot <lkp@intel.com>
Subject: [PATCH v7] rtw_security: fix cast to restricted __le32
Date:   Sun,  1 Aug 2021 23:51:52 +0800
Message-Id: <20210801155152.242089-1-fbihjmeric@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <YOIGbc2ymnWrThVK@kroah.com>
References: <YOIGbc2ymnWrThVK@kroah.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch fixes the sparse warning of fix cast to restricted __le32.

There was a change for replacing private CRC-32 routines with in kernel
ones.
However, the author used le32_to_cpu to convert crc32_le(), and we
should use cpu_to_le32.

Reported-by: kernel test robot <lkp@intel.com>
Signed-off-by: Jhih-Ming Huang <fbihjmeric@gmail.com>
---
 changes from v6:
   using get_unaligned_le32 to get the value and comparing it with crc,
   instead of using memcmp with raw pointers.

 drivers/staging/rtl8723bs/core/rtw_security.c | 12 +++---------
 1 file changed, 3 insertions(+), 9 deletions(-)

diff --git a/drivers/staging/rtl8723bs/core/rtw_security.c b/drivers/staging/rtl8723bs/core/rtw_security.c
index a99f439328f1..ff79e1aacd1a 100644
--- a/drivers/staging/rtl8723bs/core/rtw_security.c
+++ b/drivers/staging/rtl8723bs/core/rtw_security.c
@@ -92,7 +92,6 @@ void rtw_wep_encrypt(struct adapter *padapter, u8 *pxmitframe)
 void rtw_wep_decrypt(struct adapter  *padapter, u8 *precvframe)
 {
 	/*  exclude ICV */
-	u8 crc[4];
 	signed int	length;
 	u32 keylength;
 	u8 *pframe, *payload, *iv, wepkey[16];
@@ -119,10 +118,6 @@ void rtw_wep_decrypt(struct adapter  *padapter, u8 *precvframe)
 		/* decrypt payload include icv */
 		arc4_setkey(ctx, wepkey, 3 + keylength);
 		arc4_crypt(ctx, payload, payload,  length);
-
-		/* calculate icv and compare the icv */
-		*((u32 *)crc) = le32_to_cpu(~crc32_le(~0, payload, length - 4));
-
 	}
 }
 
@@ -537,7 +532,7 @@ u32 rtw_tkip_decrypt(struct adapter *padapter, u8 *precvframe)
 	u32 pnh;
 	u8   rc4key[16];
 	u8   ttkey[16];
-	u8 crc[4];
+	__le32 crc;
 	signed int			length;
 
 	u8 *pframe, *payload, *iv, *prwskey;
@@ -618,10 +613,9 @@ u32 rtw_tkip_decrypt(struct adapter *padapter, u8 *precvframe)
 			arc4_setkey(ctx, rc4key, 16);
 			arc4_crypt(ctx, payload, payload, length);
 
-			*((u32 *)crc) = le32_to_cpu(~crc32_le(~0, payload, length - 4));
+			crc = cpu_to_le32(~crc32_le(~0, payload, length - 4));
 
-			if (crc[3] != payload[length - 1] || crc[2] != payload[length - 2] ||
-			    crc[1] != payload[length - 3] || crc[0] != payload[length - 4])
+			if (crc != get_unaligned_le32(payload + length - 4))
 				res = _FAIL;
 		} else {
 			res = _FAIL;
-- 
2.32.0

