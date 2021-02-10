Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9F08A316BF9
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Feb 2021 18:01:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232797AbhBJRAz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 10 Feb 2021 12:00:55 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45872 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232307AbhBJRAr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 Feb 2021 12:00:47 -0500
Received: from mail-wr1-x433.google.com (mail-wr1-x433.google.com [IPv6:2a00:1450:4864:20::433])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 11894C061574
        for <linux-kernel@vger.kernel.org>; Wed, 10 Feb 2021 09:00:08 -0800 (PST)
Received: by mail-wr1-x433.google.com with SMTP id v15so3388433wrx.4
        for <linux-kernel@vger.kernel.org>; Wed, 10 Feb 2021 09:00:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=philpotter-co-uk.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=f52jNubWeppUFK3CjhLaeqlhm2HiQ/lG/LaNbIAx5C0=;
        b=X4/N6zuXTfQvs2QxG/bCYsPdqmCOvANyCoWdsxoN+Ldu2i+XuwbIzX8INTQDm9RX+J
         efcjAMwDdeEGzALl7TdJfCvWr0LMS3pGWuoYuLuXcQUxf5aMN+qmX7VXOaJtWsel2jNB
         Sm09FHgIrK20fXWcbBsAwjVh03N2RLszTsjVbd2klGYillyD0UJySnaZCzKY1eaZzrVB
         wCqFfZInZxYPwym544GxvSDZxev72YhaIVV16Y9vn9N4xLiyQBO3+M0JZg5escWWqfg3
         TIIWg9FZKK+Rpke2AzeSkQmmnSIsQHohC8TmpRCaxraw4WUKa3Wxglw6vnDlBxnOCDUv
         8a1w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=f52jNubWeppUFK3CjhLaeqlhm2HiQ/lG/LaNbIAx5C0=;
        b=m75r3ldFPy68vyL757BXdhF+a2N5pERFO0hij+BnfdOAFJKeLgXaXBLRubULcROIqk
         VNJwKaBEJ9Wafn6duWXPm04UVMY/bH+qM0Gxcn2qVAYT/aaOlulKLfpNvKW1A+aLojev
         0hhua+Vrn4GaMSEt/FKXgwYUl9owEGW/NEU1fdE4qyEEGbarqi9GNmlV6S9DuPFNBd5D
         kRsIW1Jd9gnfXGtyaHBeqvdDtGddSaKQRtz7sBhKrD7aK/8g7lDv94QFf8pZ0fhBXbQt
         cjsEbdYlhBrnYd+CmKztLY6nWAUBU9kJUJX5RxMWdfETrrms1hJQ0mEZUGNrD/faJF2C
         WmVA==
X-Gm-Message-State: AOAM5329LL4rhI7iIZNOQzzuOumjcYPuoYQ3HciCrn5N1zeCCryuOUZK
        MEkiLkCs+tGPQ5RnSOeSRA99XyLKx4KwZQ==
X-Google-Smtp-Source: ABdhPJx5EvknDyldDtZ0k46H95CbsUhT1EhdFUe30CLTxNqUN4lrBz2Qc0lI24T/Eg3f+n2NiCUZ/Q==
X-Received: by 2002:adf:f8c8:: with SMTP id f8mr4710717wrq.132.1612976406806;
        Wed, 10 Feb 2021 09:00:06 -0800 (PST)
Received: from localhost.localdomain (2.0.5.1.1.6.3.8.5.c.c.3.f.b.d.3.0.0.0.0.6.1.f.d.0.b.8.0.1.0.0.2.ip6.arpa. [2001:8b0:df16:0:3dbf:3cc5:8361:1502])
        by smtp.gmail.com with ESMTPSA id x4sm4120335wrn.64.2021.02.10.09.00.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 10 Feb 2021 09:00:06 -0800 (PST)
From:   Phillip Potter <phil@philpotter.co.uk>
To:     gregkh@linuxfoundation.org
Cc:     luk@wybcz.pl, devel@driverdev.osuosl.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH] staging: rtl8723bs: cleanup macros within include/rtw_debug.h
Date:   Wed, 10 Feb 2021 17:00:03 +0000
Message-Id: <20210210170003.100880-1-phil@philpotter.co.uk>
X-Mailer: git-send-email 2.29.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Remove do/while loops from DBG_871X, MSG_8192C and DBG_8192C. Also
fix opening brace placements and trailing single statement layout within
RT_PRINT_DATA, as well as making newline character placement more
consistent and removing camel case where possible. Finally, add
parentheses for DBG_COUNTER definition.

This fixes 3 checkpatch warnings, 5 checkpatch errors and 3 checkpatch
checks.

Signed-off-by: Phillip Potter <phil@philpotter.co.uk>
---
 drivers/staging/rtl8723bs/include/rtw_debug.h | 40 +++++++++----------
 1 file changed, 19 insertions(+), 21 deletions(-)

diff --git a/drivers/staging/rtl8723bs/include/rtw_debug.h b/drivers/staging/rtl8723bs/include/rtw_debug.h
index c90adfb87261..d06ac9540cf7 100644
--- a/drivers/staging/rtl8723bs/include/rtw_debug.h
+++ b/drivers/staging/rtl8723bs/include/rtw_debug.h
@@ -201,19 +201,16 @@
 #ifdef DEBUG
 #if	defined(_dbgdump)
 	#undef DBG_871X
-	#define DBG_871X(...)     do {\
-		_dbgdump(DRIVER_PREFIX __VA_ARGS__);\
-	} while (0)
+	#define DBG_871X(...)\
+		_dbgdump(DRIVER_PREFIX __VA_ARGS__)
 
 	#undef MSG_8192C
-	#define MSG_8192C(...)     do {\
-		_dbgdump(DRIVER_PREFIX __VA_ARGS__);\
-	} while (0)
+	#define MSG_8192C(...)\
+		_dbgdump(DRIVER_PREFIX __VA_ARGS__)
 
 	#undef DBG_8192C
-	#define DBG_8192C(...)     do {\
-		_dbgdump(DRIVER_PREFIX __VA_ARGS__);\
-	} while (0)
+	#define DBG_8192C(...)\
+		_dbgdump(DRIVER_PREFIX __VA_ARGS__)
 #endif /* defined(_dbgdump) */
 #endif /* DEBUG */
 
@@ -235,25 +232,26 @@
 
 #if	defined(_dbgdump)
 	#undef RT_PRINT_DATA
-	#define RT_PRINT_DATA(_Comp, _Level, _TitleString, _HexData, _HexDataLen)			\
-		if (((_Comp) & GlobalDebugComponents) && (_Level <= GlobalDebugLevel))	\
-		{									\
+	#define RT_PRINT_DATA(_comp, _level, _title_string, _hex_data, _hex_data_len)		\
+	do {											\
+		if (((_comp) & GlobalDebugComponents) && ((_level) <= GlobalDebugLevel)) {	\
 			int __i;								\
-			u8 *ptr = (u8 *)_HexData;				\
+			u8 *ptr = (u8 *)_hex_data;						\
 			_dbgdump("%s", DRIVER_PREFIX);						\
-			_dbgdump(_TitleString);						\
-			for (__i = 0; __i < (int)_HexDataLen; __i++)				\
-			{								\
+			_dbgdump(_title_string);						\
+			for (__i = 0; __i < (int)_hex_data_len; __i++) {			\
 				_dbgdump("%02X%s", ptr[__i], (((__i + 1) % 4) == 0)?"  ":" ");	\
-				if (((__i + 1) % 16) == 0)	_dbgdump("\n");			\
-			}								\
-			_dbgdump("\n");							\
-		}
+				if (((__i + 1) % 16) == 0)					\
+					_dbgdump("\n");						\
+			}									\
+			_dbgdump("\n");								\
+		}										\
+	} while (0)
 #endif /* defined(_dbgdump) */
 #endif /* DEBUG_RTL871X */
 
 #ifdef CONFIG_DBG_COUNTER
-#define DBG_COUNTER(counter) counter++
+#define DBG_COUNTER(counter) ((counter)++)
 #else
 #define DBG_COUNTER(counter) do {} while (0)
 #endif
-- 
2.29.2

