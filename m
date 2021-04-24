Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0B08536A06B
	for <lists+linux-kernel@lfdr.de>; Sat, 24 Apr 2021 11:06:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238133AbhDXJGi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 24 Apr 2021 05:06:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58324 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237510AbhDXJE2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 24 Apr 2021 05:04:28 -0400
Received: from mail-wr1-x42c.google.com (mail-wr1-x42c.google.com [IPv6:2a00:1450:4864:20::42c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 14DFDC061574
        for <linux-kernel@vger.kernel.org>; Sat, 24 Apr 2021 02:03:49 -0700 (PDT)
Received: by mail-wr1-x42c.google.com with SMTP id e5so22024605wrg.7
        for <linux-kernel@vger.kernel.org>; Sat, 24 Apr 2021 02:03:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=qN9q3YqqahsKFdZjoFQK7gigKnmNtZ3S2NITUyAA5T8=;
        b=jnXc3V8ksm7/O5oBKF2h2B7shbI+qGuf9E+P6RjMGwuOz7MHuRZ602hbyfU6ZAN3is
         I1g1cBRYSXj2/UhDcou7JRxH8r74vPibqgK5VRo+hQdfqRcqmPfdRNT1z5sTZGHVp3XX
         8p1KUEy5x0VvR9LBFb5yTMEThQHNuv6v3i5z2fLeJjxBqzv5HqAivbFFh9Ynb6YHg9Xv
         33Mbiv5vkoGIwp6oRMSpFvoTGkp1yWaWraobWyWzJCgRtqCZ3kbOcjBKv/z4BrWGC6CE
         qRZvcZgGWLi1/GopWkbo/1QbwMUFFXCJCtlOgkf+I1oZ0AGYwLyIsvd7P3O9cU/N7nmX
         +VJQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=qN9q3YqqahsKFdZjoFQK7gigKnmNtZ3S2NITUyAA5T8=;
        b=hUvMnNdtqHhBYTy+w/Du7j8h23RL43nI3vfc6XGIf04StmCLMHhziO1sN2/wapBdxz
         KBx2HLR8eFk7eiu8LgXbEKh/iTNoHWWdYX35aZtHb1iU5G8FoTXkCIh1nTQF0hih3FfE
         oTR1WCKQsveZS8Zt4nCqucfI98/m58Z3c3moVSX1DBIvd2ZoNJ0EcLIFpu6xA6MUVPTI
         l56pZcfT+XFppci33l2bt6Jm6R4zuuaRUfupMB26QIxWAWKxtAYwY/IjhDCzPYYM84SR
         GiEPZ54JNjTXv9woT+lgF8LcSY0Ks51TG9bqUjj75WpXadvhxX15x2Cj1R4l9ko/4cw0
         8qTw==
X-Gm-Message-State: AOAM533PwC0fItkdaLBk9QFOGYg3OkQOEjsba/R1on3RBJHb9UgZj1mR
        iX4KLA40b329xrsEQbL4Oby66Ur2EnkSXQ==
X-Google-Smtp-Source: ABdhPJzgwv+3XIdVwZ96TjfU94t6uQNZFgkXvJN4jJbhmw3Hd/SYQyoej+X57WbOhmYvbuUoc01dOg==
X-Received: by 2002:a5d:5151:: with SMTP id u17mr10159432wrt.413.1619255027702;
        Sat, 24 Apr 2021 02:03:47 -0700 (PDT)
Received: from agape ([5.171.80.252])
        by smtp.gmail.com with ESMTPSA id f25sm12292243wrd.43.2021.04.24.02.03.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 24 Apr 2021 02:03:47 -0700 (PDT)
From:   Fabio Aiuto <fabioaiuto83@gmail.com>
To:     gregkh@linuxfoundation.org
Cc:     joe@perches.com, linux-staging@lists.linux.dev,
        linux-kernel@vger.kernel.org
Subject: [PATCH v2 43/50] staging: rtl8723bs: remove unused macros tied to _RTL871X_IOCTL_LINUX_C definition
Date:   Sat, 24 Apr 2021 11:02:26 +0200
Message-Id: <6c836355bb4a51a3f9925e0cc75cbce3c0b63df8.1619254603.git.fabioaiuto83@gmail.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <cover.1619254603.git.fabioaiuto83@gmail.com>
References: <cover.1619254603.git.fabioaiuto83@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

remove unused macros tied to
_RTL871X_IOCTL_LINUX_C_ definition.

Signed-off-by: Fabio Aiuto <fabioaiuto83@gmail.com>
---
 drivers/staging/rtl8723bs/include/rtw_debug.h | 5 +----
 1 file changed, 1 insertion(+), 4 deletions(-)

diff --git a/drivers/staging/rtl8723bs/include/rtw_debug.h b/drivers/staging/rtl8723bs/include/rtw_debug.h
index a6c2956133ed..550cff9b1147 100644
--- a/drivers/staging/rtl8723bs/include/rtw_debug.h
+++ b/drivers/staging/rtl8723bs/include/rtw_debug.h
@@ -7,7 +7,6 @@
 #ifndef __RTW_DEBUG_H__
 #define __RTW_DEBUG_H__
 
-#define _module_rtl871x_ioctl_os_c		BIT(25)
 #define _module_rtl8712_cmd_c_		BIT(26)
 /* define _module_efuse_			BIT(27) */
 #define	_module_rtl8192c_xmit_c_ BIT(28)
@@ -18,9 +17,7 @@
 
 #undef _MODULE_DEFINE_
 
-#if defined _RTL871X_IOCTL_LINUX_C_
-	#define	_MODULE_DEFINE_	_module_rtl871x_ioctl_os_c
-#elif defined _RTL8712_CMD_C_
+#if defined _RTL8712_CMD_C_
 	#define	_MODULE_DEFINE_	_module_rtl8712_cmd_c_
 #elif defined _RTL8192C_XMIT_C_
 	#define	_MODULE_DEFINE_	1
-- 
2.20.1

