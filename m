Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A3CEF34B797
	for <lists+linux-kernel@lfdr.de>; Sat, 27 Mar 2021 15:26:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230478AbhC0OZf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 27 Mar 2021 10:25:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48240 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230180AbhC0OZB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 27 Mar 2021 10:25:01 -0400
Received: from mail-wr1-x435.google.com (mail-wr1-x435.google.com [IPv6:2a00:1450:4864:20::435])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4D88FC0613B1
        for <linux-kernel@vger.kernel.org>; Sat, 27 Mar 2021 07:25:01 -0700 (PDT)
Received: by mail-wr1-x435.google.com with SMTP id b9so8356756wrt.8
        for <linux-kernel@vger.kernel.org>; Sat, 27 Mar 2021 07:25:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=Dvn70d7ZVR8XY9R5o5JpAomHZOvZdMCNh+kZfGyarKQ=;
        b=ln3UTy++bXXqTH+TLRHvdv6UJEaCQjlpOU0SitX1IvHqs5oXAU4CxWmRlJxPTZUNPi
         SQtJW3xlGH1pATI1tfnDKNLZ/WFZxKQ1A0nxG1wstS0PxCYY+2/59UGb43MM9TEjOg81
         5EE3sCbhqERqW0YIb/KasYeJ8bzN/MzMCrRajhW6TMXfebZkSGfo7RD/+dAr04cjh8K2
         mjEpi7bdCm6xFlpNpYmLzD2fo9qneWlIyBbJVzozludC3NpqrnKuQco31vQ1E8qipOHe
         t+op0X3o7NgmJM93yyUpeI0wMVlxrCtYIkA9zbbJfK1PTi744PZ+tkHXcc4BmxnB3+T1
         IMIg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=Dvn70d7ZVR8XY9R5o5JpAomHZOvZdMCNh+kZfGyarKQ=;
        b=CafTcBXNgkXQOnN8GKMQHihyegMfJrWD+qrlBUoHxD5CRH2jp8KerwHYzeZMz1pSOo
         Ezy8C9QxI2YdNacFSCEoRdIPIksY8kO04kSmQIJuaQCyhEOUu00x3+ZZFsbFjFglAKlZ
         n9ba7NRvdh3SgfgBsaBnAuSUpgtEujvgMz578tpIUHA/wC1YwLMfwt2mgkYA4XcbjcSN
         LKYBohgsDjt3n6rjeMmYcj6BV0y1XoaR9jMBgHW8N6iILFHEzZEy7le0ZdeggZCh8W9r
         xpp+1uSJpWCMZO9swqbclJEF/fKOlidosKvlqPkRw2qmtbBwUgzqAIkEUOcBnFvc1JKq
         n/EA==
X-Gm-Message-State: AOAM530URNaYQBhF8AFImwob5825gZbEUZs3MCZ+ptt2nuFhCrD/ymuL
        dxW6pytq+eUDb3/8wjivDmw=
X-Google-Smtp-Source: ABdhPJwXjH5PAU13TKG1WP5GsdrMIjCGw4PJwBTktxJhm37VkaRd4v+zZA4HqH9ef3PP/uwvPsE5Yg==
X-Received: by 2002:adf:e68e:: with SMTP id r14mr19513342wrm.273.1616855100137;
        Sat, 27 Mar 2021 07:25:00 -0700 (PDT)
Received: from agape ([151.46.211.242])
        by smtp.gmail.com with ESMTPSA id x25sm18833839wmj.14.2021.03.27.07.24.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 27 Mar 2021 07:24:59 -0700 (PDT)
From:   Fabio Aiuto <fabioaiuto83@gmail.com>
To:     gregkh@linuxfoundation.org
Cc:     dan.carpenter@oracle.com, david.laight@aculab.com,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org,
        Fabio Aiuto <fabioaiuto83@gmail.com>
Subject: [PATCH v2 09/20] staging: rtl8723bs: put parentheses on macros with complex values in include/rtw_debug.h
Date:   Sat, 27 Mar 2021 15:24:08 +0100
Message-Id: <f36448ddc1553a018f700983b5d436eacaef9cb3.1616854134.git.fabioaiuto83@gmail.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <cover.1616854134.git.fabioaiuto83@gmail.com>
References: <cover.1616854134.git.fabioaiuto83@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

fix the following checkpatch warning:

ERROR: Macros starting with if should be enclosed by a
do - while loop to avoid possible if/else logic defects
+	#define RT_PRINT_DATA(_Comp, _Level,
	_TitleString, _HexData, _HexDataLen)			\

Signed-off-by: Fabio Aiuto <fabioaiuto83@gmail.com>
---
 drivers/staging/rtl8723bs/include/rtw_debug.h | 28 ++++++++++---------
 1 file changed, 15 insertions(+), 13 deletions(-)

diff --git a/drivers/staging/rtl8723bs/include/rtw_debug.h b/drivers/staging/rtl8723bs/include/rtw_debug.h
index d1c557818305..b00f8a6c4312 100644
--- a/drivers/staging/rtl8723bs/include/rtw_debug.h
+++ b/drivers/staging/rtl8723bs/include/rtw_debug.h
@@ -236,19 +236,21 @@
 #if	defined(_dbgdump)
 	#undef RT_PRINT_DATA
 	#define RT_PRINT_DATA(_Comp, _Level, _TitleString, _HexData, _HexDataLen)			\
-		if (((_Comp) & GlobalDebugComponents) && (_Level <= GlobalDebugLevel))	\
-		{									\
-			int __i;								\
-			u8 *ptr = (u8 *)_HexData;				\
-			_dbgdump("%s", DRIVER_PREFIX);						\
-			_dbgdump(_TitleString);						\
-			for (__i = 0; __i < (int)_HexDataLen; __i++)				\
-			{								\
-				_dbgdump("%02X%s", ptr[__i], (((__i + 1) % 4) == 0)?"  ":" ");	\
-				if (((__i + 1) % 16) == 0)	_dbgdump("\n");			\
-			}								\
-			_dbgdump("\n");							\
-		}
+		do { \
+			if (((_Comp) & GlobalDebugComponents) && (_Level <= GlobalDebugLevel))	\
+			{									\
+				int __i;								\
+				u8 *ptr = (u8 *)_HexData;				\
+				_dbgdump("%s", DRIVER_PREFIX);						\
+				_dbgdump(_TitleString);						\
+				for (__i = 0; __i < (int)_HexDataLen; __i++)				\
+				{								\
+					_dbgdump("%02X%s", ptr[__i], (((__i + 1) % 4) == 0)?"  ":" ");	\
+					if (((__i + 1) % 16) == 0)	_dbgdump("\n");			\
+				}								\
+				_dbgdump("\n");							\
+			} \
+		} while (0)
 #endif /* defined(_dbgdump) */
 #endif /* DEBUG_RTL871X */
 
-- 
2.20.1

