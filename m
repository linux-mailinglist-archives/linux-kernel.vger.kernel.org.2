Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6A35934A3C6
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Mar 2021 10:11:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230203AbhCZJKl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 26 Mar 2021 05:10:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38964 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229991AbhCZJKA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 Mar 2021 05:10:00 -0400
Received: from mail-wm1-x32f.google.com (mail-wm1-x32f.google.com [IPv6:2a00:1450:4864:20::32f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8DC02C0613AA
        for <linux-kernel@vger.kernel.org>; Fri, 26 Mar 2021 02:09:59 -0700 (PDT)
Received: by mail-wm1-x32f.google.com with SMTP id t5-20020a1c77050000b029010e62cea9deso2598905wmi.0
        for <linux-kernel@vger.kernel.org>; Fri, 26 Mar 2021 02:09:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=Dvn70d7ZVR8XY9R5o5JpAomHZOvZdMCNh+kZfGyarKQ=;
        b=PNBvGfdgN33huUF+/83LrlKOWwvHGSImBAKLAH37Ti8wSDUhHrkUUtwSp8MgnA9SEf
         FZacgtSlII1BklZCpuDEW6/RiW2JdMBMoIGa3qbNAghAdBxFgn8Zb1qFI35WMuXESyhv
         k87YY4B5zHauLxUE5+VnB/fQSe1MK/+Qy6NPGQSbd8NzH2fj2jZJpHOqr4CO45tWKBWD
         TJa3vkQlMfo9LKiAYX4oUivZyRSetTqn2CKAmDVVE6lN2Tbj6hAqappuAp+0traEZe+b
         2wWQubE3jJg6u8+TIRmUrIE0ZDC8m46Ex+nzF9ZFPEbzMqRZRqHAU4UZFzU6xUdx+NBu
         Pf6w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=Dvn70d7ZVR8XY9R5o5JpAomHZOvZdMCNh+kZfGyarKQ=;
        b=dq87nn1c+1S9GB3igJjxqqWw6ulmH/W9YGtd+kN8KDWmxIuoZ/8Dorj1QyUeUzVvyy
         wFNrn+E4K1FxPU4EviYOQx4bb4vIfU40vvhDhMXyMDty/j7ZofEVT8Okl2BwKZH0MEyT
         ggL/bcbULP9uOUqBlL7/k/yP8QP9CuwlllAbQsh3FvUR2WhYek5IGCyx/6WHEfTD2Sp1
         Edz+P3oHgejC2SuQv74OCfVeznUn/0JYwBH1VPi3CkzLoApG1F8ES5pd7KYIUxSg00JO
         JbaLD+Eo0O7QPrXDwC+Dv4JgitBCPi5Dy3Uk518jRbQjY6cSQw36uAuZmessNI/TIBPP
         EadA==
X-Gm-Message-State: AOAM532x2VXtMg6kLQqOLfbKFh4wD5PWlQc/r0yqKohs2Nfz05BG00GD
        xngaBw3rEfCALkLrNwKbNHk=
X-Google-Smtp-Source: ABdhPJwql02n0mzlCutgORDc5N4gBV7SJ79caZIcgxCSRZbItA/vgM3x52XK63E+Y2bxyv0iEA4Vxg==
X-Received: by 2002:a05:600c:2946:: with SMTP id n6mr12002150wmd.52.1616749798339;
        Fri, 26 Mar 2021 02:09:58 -0700 (PDT)
Received: from agape ([5.171.81.75])
        by smtp.gmail.com with ESMTPSA id j30sm12255611wrj.62.2021.03.26.02.09.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 26 Mar 2021 02:09:58 -0700 (PDT)
From:   Fabio Aiuto <fabioaiuto83@gmail.com>
To:     gregkh@linuxfoundation.org
Cc:     linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org,
        Fabio Aiuto <fabioaiuto83@gmail.com>
Subject: [PATCH 11/15] staging: rtl8723bs: put parentheses on macros with complex values in include/rtw_debug.h
Date:   Fri, 26 Mar 2021 10:09:18 +0100
Message-Id: <0634873fdf3b0ff61e61fa8cd9a74c5959a50efa.1616748885.git.fabioaiuto83@gmail.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <cover.1616748885.git.fabioaiuto83@gmail.com>
References: <cover.1616748885.git.fabioaiuto83@gmail.com>
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

