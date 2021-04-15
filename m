Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3FAAA360699
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Apr 2021 12:08:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232473AbhDOKIH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 15 Apr 2021 06:08:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37216 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232348AbhDOKIG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Apr 2021 06:08:06 -0400
Received: from mail-wm1-x32f.google.com (mail-wm1-x32f.google.com [IPv6:2a00:1450:4864:20::32f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 50E1DC061574
        for <linux-kernel@vger.kernel.org>; Thu, 15 Apr 2021 03:07:43 -0700 (PDT)
Received: by mail-wm1-x32f.google.com with SMTP id y204so10759865wmg.2
        for <linux-kernel@vger.kernel.org>; Thu, 15 Apr 2021 03:07:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=873gk6pELNZLFerjSZqmlNlTvV/hjDYlASHgozHzVZ0=;
        b=n0oaecMjObdX0MGX9l3Q7lO0EHAoDhTwFPyj9xJhVjpEh5hulNm8WvA06vxCS68nzP
         xIThcU369Y17gZNQOX/7ZpQ+JI3zjR1MLdqT5NwFZKimsHgwFK7Tovj6WPQQi55UrWoB
         PU8KJUPuRkRvbIh1GhGJJDzQi+SJE0EXjKGayOt7M8XSH9Iv5y4YjUq3q9AgmJneFrUg
         nS1VE1k80xmSmTJHwEBCkeDr9rmpW71jqQ8qqH9vSrjj/np/LncAFEw8+lD9L8xJ0jn+
         EyCVmSgZv3g4Y3tx6Kyeb2K8plaKFyrC/4QuOTFS8IXRGfSslw3Prz8pwUDdGZrTY1hi
         1StQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=873gk6pELNZLFerjSZqmlNlTvV/hjDYlASHgozHzVZ0=;
        b=fTdMSpiwplmEdlqWvufGOXE6sOqVTU5M0bjg/K5JlYzHT8r3cMLLZHPF9wcmrcnO8i
         CW3vnrpSR+boPeVR46iSlVCvSzmLH6/yNaH8nKDWgzRKhqXQFOrTpaJxQBWSq/ER2QmF
         C+vhTHsMqhLihAI4/kbvveMC1kqBEmF3vAjjLs3dXLtpbxa1UrFgOMJQuPpuVkfgd5Hy
         T/rVIHbxxvCqNGmEtyKf9ARvPeqX618ez5oxG1Kkq68iQ9dhW/4ygr/lEr6PKtOoJFaB
         67B931b9nfNjMCwrqOThQbyfmUV28jBWIi3Vq22UNOcDzc3SqgBBvj9E/NpAW9FeNPOn
         8zuQ==
X-Gm-Message-State: AOAM533AdxbCeQOkPO/aRilJDXOblTsgjfKLD4Rh+hQ1uhs6/JbaeLZx
        1LEGsqIgzmkGK38ULBGZGM0VCRYpG7A=
X-Google-Smtp-Source: ABdhPJwjwjgBnAt8qFrrT1F9oBmScy3DlpE4Yjnafd/HxxgUyHhJicBN5T638mFNMLI9gHQM2GSXRQ==
X-Received: by 2002:a7b:c769:: with SMTP id x9mr2368517wmk.124.1618481261936;
        Thu, 15 Apr 2021 03:07:41 -0700 (PDT)
Received: from agape ([5.171.72.223])
        by smtp.gmail.com with ESMTPSA id n2sm2181383wmb.32.2021.04.15.03.07.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 15 Apr 2021 03:07:41 -0700 (PDT)
From:   Fabio Aiuto <fabioaiuto83@gmail.com>
To:     gregkh@linuxfoundation.org
Cc:     linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: [PATCH 5/6] staging: rtl8723bs: remove unused DBG_871X_LEVEL macro declarations
Date:   Thu, 15 Apr 2021 12:07:23 +0200
Message-Id: <ec371fd8a4e53b4730b45f0a1c9210106b2914f2.1618480688.git.fabioaiuto83@gmail.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <cover.1618480688.git.fabioaiuto83@gmail.com>
References: <cover.1618480688.git.fabioaiuto83@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

remove unused DBG_871X_LEVEL macro declarations.

DBG_871X_LEVEL macro wraps a raw printk call which is not
recommended in a device driver context, prefer using
netdev_*() log functions.

Signed-off-by: Fabio Aiuto <fabioaiuto83@gmail.com>
---
 drivers/staging/rtl8723bs/include/rtw_debug.h | 14 --------------
 1 file changed, 14 deletions(-)

diff --git a/drivers/staging/rtl8723bs/include/rtw_debug.h b/drivers/staging/rtl8723bs/include/rtw_debug.h
index 12873c3d801d..23f4cb4711d4 100644
--- a/drivers/staging/rtl8723bs/include/rtw_debug.h
+++ b/drivers/staging/rtl8723bs/include/rtw_debug.h
@@ -131,8 +131,6 @@
 	#define	_MODULE_DEFINE_	_module_efuse_
 #endif
 
-#define DBG_871X_LEVEL(x, ...) do {} while (0)
-
 #undef _dbgdump
 
 #ifndef _RTL871X_DEBUG_C_
@@ -146,18 +144,6 @@
 
 #if defined(_dbgdump)
 
-/* with driver-defined prefix */
-#undef DBG_871X_LEVEL
-#define DBG_871X_LEVEL(level, fmt, arg...)     \
-	do {\
-		if (level <= GlobalDebugLevel) {\
-			if (level <= _drv_err_ && level > _drv_always_) \
-				_dbgdump(DRIVER_PREFIX"ERROR " fmt, ##arg);\
-			else \
-				_dbgdump(DRIVER_PREFIX fmt, ##arg);\
-		} \
-	} while (0)
-
 /* without driver-defined prefix */
 #undef _DBG_871X_LEVEL
 #define _DBG_871X_LEVEL(level, fmt, arg...)	   \
-- 
2.20.1

