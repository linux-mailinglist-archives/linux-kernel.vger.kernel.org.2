Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BA1D734FD01
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Mar 2021 11:35:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234805AbhCaJe6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 31 Mar 2021 05:34:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38332 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234838AbhCaJeX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 31 Mar 2021 05:34:23 -0400
Received: from mail-ej1-x636.google.com (mail-ej1-x636.google.com [IPv6:2a00:1450:4864:20::636])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ECA33C061760
        for <linux-kernel@vger.kernel.org>; Wed, 31 Mar 2021 02:34:22 -0700 (PDT)
Received: by mail-ej1-x636.google.com with SMTP id a7so29053019ejs.3
        for <linux-kernel@vger.kernel.org>; Wed, 31 Mar 2021 02:34:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=nJLOt94s3l6Fobf6ZPtXQMWeNkPKhv/UBfAhGZDQK4c=;
        b=FM+yqdyhKqo/+jLtBo0PUMiH1tfrS9whjhQTsrwYVd6zQbGiX/8FGnZX+9B7FGcv+d
         eg0VamjlsVJFn+kVuzo7/e3j2i68Xl7NzMVgU68mqVRbcsxhoU5rJqcbBz0m50fbOJ8A
         BCngCEwkTM8RJWO8Zw/PZIxXjSYYHNqvXKKEznhi05nZOeKaLgmzNQjUEDT+Ybvcc/7f
         fXXiT0cLDL7NO0F2a7tMAiQQ0nPsqCj/1wNU1wND5LIsm9d/gqkA1J0OV843lD6jm8qq
         jYiuj1r9P7q4xsiUvnwJRlW6ADv+tNnDFVoVX7Bs/xnx3kOEpZ/KrXOCafsqzcsFNI1a
         wdWQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=nJLOt94s3l6Fobf6ZPtXQMWeNkPKhv/UBfAhGZDQK4c=;
        b=HpoOYPx4KbF9HeZq2uBZyOoAaKVlmTSXA8WlfBRz9YstjtGWoR1R9QR5kSWMqcqz49
         82wVtIEuJxz80TjwbPOnC8zuQNp+rlFGxZOfe6O2sTLelvIrs2bydLgI8e6bjD5mQ/HS
         Y9IFw+JgmYj2Y0nzrfKliuQ5l+NU+8Ir4BReCnNxWO1YLm289XGKj/QJigVcA6ZO1LBB
         Ok5H8+dDIfuCwz+s3r9c+ON2FC8iQrJBSTalTmOd1rXoKshk8T+ZkdYR/bx9TE163dm9
         Bb4QMuHgX/dzznhuevNYWonySBninfUtNPyuuozptOxGI/erE2L4731I0f6dhqJdg0z+
         kLfA==
X-Gm-Message-State: AOAM533mbiFBVpPjRcrgVQNoV2q3TdaesK73x55mV/O8ZiXJ+JmqFlr9
        SVQMkF84fcfOrk3LeHnEdJ7/Lawn4rc21w==
X-Google-Smtp-Source: ABdhPJxHn1CzN8QRRB1addIFq7ulFiTS5vS6eKmQJi2R3RDkXBT3AP1z5iu6oB0JyrTgUrOUaKA2+g==
X-Received: by 2002:a17:906:4117:: with SMTP id j23mr2623040ejk.10.1617183261777;
        Wed, 31 Mar 2021 02:34:21 -0700 (PDT)
Received: from agape ([5.171.73.44])
        by smtp.gmail.com with ESMTPSA id w24sm1095489edt.44.2021.03.31.02.34.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 31 Mar 2021 02:34:21 -0700 (PDT)
From:   Fabio Aiuto <fabioaiuto83@gmail.com>
To:     gregkh@linuxfoundation.org
Cc:     joe@perches.com, linux-staging@lists.linux.dev,
        linux-kernel@vger.kernel.org, Fabio Aiuto <fabioaiuto83@gmail.com>
Subject: [PATCH 2/2] staging: rtl8723bs: remove unused macro RT_PRINT_DATA
Date:   Wed, 31 Mar 2021 11:34:07 +0200
Message-Id: <1367a38513774e80a3ce32947ae80506576b2e94.1617183040.git.fabioaiuto83@gmail.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <cover.1617183040.git.fabioaiuto83@gmail.com>
References: <cover.1617183040.git.fabioaiuto83@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

remove unused macro declaration: RT_PRINT_DATA

Signed-off-by: Fabio Aiuto <fabioaiuto83@gmail.com>
---
 drivers/staging/rtl8723bs/include/rtw_debug.h | 19 -------------------
 1 file changed, 19 deletions(-)

diff --git a/drivers/staging/rtl8723bs/include/rtw_debug.h b/drivers/staging/rtl8723bs/include/rtw_debug.h
index d1c557818305..4c0857241922 100644
--- a/drivers/staging/rtl8723bs/include/rtw_debug.h
+++ b/drivers/staging/rtl8723bs/include/rtw_debug.h
@@ -231,25 +231,6 @@
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

