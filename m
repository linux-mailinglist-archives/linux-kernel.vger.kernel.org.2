Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CEC9634FD59
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Mar 2021 11:43:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235212AbhCaJnA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 31 Mar 2021 05:43:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39986 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234996AbhCaJl1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 31 Mar 2021 05:41:27 -0400
Received: from mail-ed1-x52a.google.com (mail-ed1-x52a.google.com [IPv6:2a00:1450:4864:20::52a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5980EC061574
        for <linux-kernel@vger.kernel.org>; Wed, 31 Mar 2021 02:41:27 -0700 (PDT)
Received: by mail-ed1-x52a.google.com with SMTP id b16so21520917eds.7
        for <linux-kernel@vger.kernel.org>; Wed, 31 Mar 2021 02:41:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=R92z1YtOtroE0DR69RZMhwatu8EFWjP4tLoowms2g08=;
        b=gBZNY4YKRRuvskSqEayIahyoYNLYK8aoMeKElt6WCjc5rTANKUF9847pdb4nKv7Soo
         YzphHEDWJfJ9XQgaQwZqAa94pJSJ11xJmB9EsJLItH7V4NarLMWH9aaY+CBqeu0WnZEN
         kfzlVxjV2p3QNjxR8FYXFKr0BmuxK2JkBIssEgnrVT5nYs/hlhKub4b2eiXIP6i9Q50N
         MekMtYG8YkCc0wmnH+yyQvux6lVxpWzEyyV57QbTo4ZRrn54XLFNaKeoa/M9H3GrTnXO
         LnKFyTKNH4QZRYnjiXtIu9WQtPaMexxj+g9yRLej9YDYF8wcrCD0wueFgJoletXgbqew
         OjMA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=R92z1YtOtroE0DR69RZMhwatu8EFWjP4tLoowms2g08=;
        b=FrY92fWk6TCjtu/81yUu04c0in5PHOTDlQQsFlt1esKq1V93NpDd8Mg3VgErwR396H
         3VbH/G6xnYZqM8q8gtDG7vt+yBPO/JsZFfl8xEJQEOAiHmoMKRg7XibR9Xi+vpV6LPTA
         d9yKoBrJp5Gl7oYO8TTx5NY9IvWK6FfB+qhVQnZ8FIKQGydQXh6fqdu9JPfBDHGC6oBO
         tHVJZmDAXHClouSLdEQOwI9B2LlIRvm2iYWsA06ZkmRBc+r9M7zvHATAxmIrxuO1xAzO
         zfawrgCYvJEDDi7VQOyT8ZeHmcoL3gj2K6/7tta/DZBo68MY3zsK7C2d3MpT9zadVkaz
         5S0w==
X-Gm-Message-State: AOAM532ppt/fZR8FcGeJrMwYmjsJ1sciNsGc6OUZWbWcPvlWZsRiNwKS
        hrxVsNJI/iM2ehC00rBX8yU=
X-Google-Smtp-Source: ABdhPJw/jeP3mYmws/qzK6LoY4wmoibgF3/xIMSivGZCyAWnXo1cyfmlnKW1L7iFllZxVqYTq5WMzQ==
X-Received: by 2002:a05:6402:14cc:: with SMTP id f12mr2692072edx.19.1617183686047;
        Wed, 31 Mar 2021 02:41:26 -0700 (PDT)
Received: from agape ([5.171.73.44])
        by smtp.gmail.com with ESMTPSA id f9sm1145767edq.43.2021.03.31.02.41.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 31 Mar 2021 02:41:25 -0700 (PDT)
From:   Fabio Aiuto <fabioaiuto83@gmail.com>
To:     gregkh@linuxfoundation.org
Cc:     joe@perches.com, linux-staging@lists.linux.dev,
        linux-kernel@vger.kernel.org, Fabio Aiuto <fabioaiuto83@gmail.com>
Subject: [PATCH 40/40] staging: rtl8723bs: remove obsolete debug macro
Date:   Wed, 31 Mar 2021 11:40:08 +0200
Message-Id: <bbfc64dfd0da03d38c7b0121e7e04e31bb9ba9eb.1617183374.git.fabioaiuto83@gmail.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <cover.1617183374.git.fabioaiuto83@gmail.com>
References: <cover.1617183374.git.fabioaiuto83@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

remove obsolete debug macro RT_TRACE

Signed-off-by: Fabio Aiuto <fabioaiuto83@gmail.com>
---
 drivers/staging/rtl8723bs/include/rtw_debug.h | 17 -----------------
 1 file changed, 17 deletions(-)

diff --git a/drivers/staging/rtl8723bs/include/rtw_debug.h b/drivers/staging/rtl8723bs/include/rtw_debug.h
index 4c0857241922..f539d8e7f89f 100644
--- a/drivers/staging/rtl8723bs/include/rtw_debug.h
+++ b/drivers/staging/rtl8723bs/include/rtw_debug.h
@@ -131,7 +131,6 @@
 	#define	_MODULE_DEFINE_	_module_efuse_
 #endif
 
-#define RT_TRACE(_Comp, _Level, Fmt) do {} while (0)
 #define RT_PRINT_DATA(_Comp, _Level, _TitleString, _HexData, _HexDataLen) do {} while (0)
 
 #define DBG_871X(x, ...) do {} while (0)
@@ -217,22 +216,6 @@
 #endif /* defined(_dbgdump) */
 #endif /* DEBUG */
 
-#ifdef DEBUG_RTL871X
-
-#if	defined(_dbgdump) && defined(_MODULE_DEFINE_)
-
-	#undef RT_TRACE
-	#define RT_TRACE(_Comp, _Level, Fmt)\
-	do {\
-		if ((_Comp & GlobalDebugComponents) && (_Level <= GlobalDebugLevel)) {\
-			_dbgdump("%s [0x%08x,%d]", DRIVER_PREFIX, (unsigned int)_Comp, _Level);\
-			_dbgdump Fmt;\
-		} \
-	} while (0)
-
-#endif /* defined(_dbgdump) && defined(_MODULE_DEFINE_) */
-#endif /* DEBUG_RTL871X */
-
 void dump_drv_version(void *sel);
 void dump_log_level(void *sel);
 
-- 
2.20.1

