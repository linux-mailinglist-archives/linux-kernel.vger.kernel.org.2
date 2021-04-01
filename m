Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 984CC351175
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Apr 2021 11:08:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233730AbhDAJHv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 1 Apr 2021 05:07:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33074 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233496AbhDAJHa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Apr 2021 05:07:30 -0400
Received: from mail-ed1-x533.google.com (mail-ed1-x533.google.com [IPv6:2a00:1450:4864:20::533])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 24724C0613E6
        for <linux-kernel@vger.kernel.org>; Thu,  1 Apr 2021 02:07:30 -0700 (PDT)
Received: by mail-ed1-x533.google.com with SMTP id bx7so1086756edb.12
        for <linux-kernel@vger.kernel.org>; Thu, 01 Apr 2021 02:07:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=Y8KbK2adWOITzic3uSCbYPwpSyouNdBB+luO12NuLOU=;
        b=i7zMwDQY5gr9rLiPrivN3dZZmP/NhvM1rEOV/q61kRrDNSnbVebx7wAhNAI0z7FTZq
         KnnsWfoScLavc0WL6XmRXYtWfib6t44RPTf6rKMNFZX4WHPFImkeLewZA/1kJR0+mi0u
         +018ECIVKCouHnrTcjiCIpy+3Vj9Kw2oK4BmJcX6/ft5dlNE9KmHYcuhs5A8u0UvG1pa
         xDGt14+7WG2i0umuQHHEG8VvDcQhR3fSA049jcqw26aIeVkq0UvjpSSkfqCZQTixDiyv
         dyMdJ1OxvEgrlywNS0VjWljdtA2noYe/TSFEvhD95Lv0A948w2fBoZY2kPatx1hD/aqD
         cEfQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=Y8KbK2adWOITzic3uSCbYPwpSyouNdBB+luO12NuLOU=;
        b=YnN/9I+N6HfeqUu7kDm4r3LHqAARRIxcxNU54mVvQYsc4VzR3e7m+XM7af3djppwfb
         ZKYAfxCW8Y/mXbTTLX3xKsTq+0n9yXhCDipL/vB9jpgL5y48UAP3kPXShGOMh/fdtrBz
         xZhcefyLwm/jFCbcH/beFO3Em8OnDD6TU2M/bAItnQMZoZpFVg8JoVEY/eTqcxa6d4dz
         IjBR2p18L0GBwz81mTFEdFwEJtOhukxH8ccxLovwvmnZe0okh7UjgvJVtPSBWNsFrvec
         RSqO1fBHDAEfvYCaanbxzkYA+XovhuIYFqTugAeLkM6khrqMusY0Tp/PxzcJ+ciQexC5
         qweA==
X-Gm-Message-State: AOAM531Ui0/beOpEuLfElG9E4ooUbzKPVM4aLcg/SRt4/iwBiJJUPUSe
        m2IzCURvKusUaZYaKWI57zrWXn2f4h/fQw==
X-Google-Smtp-Source: ABdhPJxMjTcBO+tDVIriTELG8sJrabR5JYuN71hy5jWsEKX6qPx1Wz6Wq47LzDe7A4hfOXoPPyTjFw==
X-Received: by 2002:a05:6402:34c8:: with SMTP id w8mr9096736edc.235.1617268048964;
        Thu, 01 Apr 2021 02:07:28 -0700 (PDT)
Received: from agape ([5.171.80.247])
        by smtp.gmail.com with ESMTPSA id jx22sm2420778ejc.105.2021.04.01.02.07.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 01 Apr 2021 02:07:28 -0700 (PDT)
From:   Fabio Aiuto <fabioaiuto83@gmail.com>
To:     gregkh@linuxfoundation.org
Cc:     joe@perches.com, linux-staging@lists.linux.dev,
        linux-kernel@vger.kernel.org, Fabio Aiuto <fabioaiuto83@gmail.com>
Subject: [PATCH v2 2/2] staging: rtl8723bs: remove unused macro RT_PRINT_DATA
Date:   Thu,  1 Apr 2021 11:07:22 +0200
Message-Id: <a7d11ff4f0c069fac8b66e9c50a846d004ee2a4a.1617267827.git.fabioaiuto83@gmail.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <cover.1617267827.git.fabioaiuto83@gmail.com>
References: <cover.1617267827.git.fabioaiuto83@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

remove unused macro declaration: RT_PRINT_DATA

Signed-off-by: Fabio Aiuto <fabioaiuto83@gmail.com>
---
 drivers/staging/rtl8723bs/include/rtw_debug.h | 20 -------------------
 1 file changed, 20 deletions(-)

diff --git a/drivers/staging/rtl8723bs/include/rtw_debug.h b/drivers/staging/rtl8723bs/include/rtw_debug.h
index d1c557818305..d3c77798a5eb 100644
--- a/drivers/staging/rtl8723bs/include/rtw_debug.h
+++ b/drivers/staging/rtl8723bs/include/rtw_debug.h
@@ -132,7 +132,6 @@
 #endif
 
 #define RT_TRACE(_Comp, _Level, Fmt) do {} while (0)
-#define RT_PRINT_DATA(_Comp, _Level, _TitleString, _HexData, _HexDataLen) do {} while (0)
 
 #define DBG_871X(x, ...) do {} while (0)
 #define MSG_8192C(x, ...) do {} while (0)
@@ -231,25 +230,6 @@
 	} while (0)
 
 #endif /* defined(_dbgdump) && defined(_MODULE_DEFINE_) */
-
-
-#if	defined(_dbgdump)
-	#undef RT_PRINT_DATA
-	#define RT_PRINT_DATA(_Comp, _Level, _TitleString, _HexData, _HexDataLen)			\
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
-#endif /* defined(_dbgdump) */
 #endif /* DEBUG_RTL871X */
 
 void dump_drv_version(void *sel);
-- 
2.20.1

