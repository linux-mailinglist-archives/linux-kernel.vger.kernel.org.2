Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 82B9B36A06A
	for <lists+linux-kernel@lfdr.de>; Sat, 24 Apr 2021 11:06:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237283AbhDXJGe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 24 Apr 2021 05:06:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58358 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237508AbhDXJE0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 24 Apr 2021 05:04:26 -0400
Received: from mail-wr1-x42b.google.com (mail-wr1-x42b.google.com [IPv6:2a00:1450:4864:20::42b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 514ADC06134D
        for <linux-kernel@vger.kernel.org>; Sat, 24 Apr 2021 02:03:47 -0700 (PDT)
Received: by mail-wr1-x42b.google.com with SMTP id m9so37938404wrx.3
        for <linux-kernel@vger.kernel.org>; Sat, 24 Apr 2021 02:03:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=ko6Q/RilYLQvwkCUUa2QBQ+wUnQsOzFNJX5UmfxpZZQ=;
        b=ELX5E/FzI9JWSLjfEbbup8R8tjr6NC5HmCHn914GFPfJclTW6m43HcoVjU92Axu7yq
         jffFsGwXeQlQ6rZDkfP2E5rnzt7JbTV2b+DcZBrdSEaBW6j0N79Ympc5zRj5vZQAqQht
         Z1JqNCJeZH1Uyy06h+UebehBi9tQDD5CD3+PkWKdztI4ybtdh2Ep56gVOZiBBx5D6Ctv
         YEtM9TgnVOw0eZldqtCegd5Q838peAeHjRRvsLc39AOXPumtPz1vXtbd/rsXzzSGNEvI
         sgdEqvmszZ5CQRjVGXOPt15UnnvkRe7m5jXvwS5YbMzG1jD+lxbMKTJ35i4OjE2fBCMb
         dBPA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=ko6Q/RilYLQvwkCUUa2QBQ+wUnQsOzFNJX5UmfxpZZQ=;
        b=mP5ZT/omSPBmv/xkvd07Y4DQU2k8/BRPBQsWQS/moAdd46QIOXnMHrynAIicW+dJj8
         Sx/l5LwTCSyrieXOzdZ6tuYoH80JZPSLJ6EcrR0dcWgl6IiVztgzO1w1IMmqLo2+YV/Z
         1uBetHi8hhqsYhUlm1Ab3r/dGlFA113QabIBpqxI257v1k49tfbSFmqv9lmj1DUodhFD
         eSTmKK5x7tBjekEOb9TmMjhb5NwO9qTu0Hk4mvVzfRxZxmOblXI3hjy9tcRcfIdwg8GI
         i4oOnxLYGmkSVt8TOikOCXPVvOKNicPAiACbPFKUybRcU+bY6hCzISPTxh7P9S3OUcsw
         c7ew==
X-Gm-Message-State: AOAM532PSnlS12haHksNA44ftYQf6yBPRJNgo4HRAdHZH/Xv/a2mKYEt
        +QCFhF1eZ2g2tr2qXDFqeMEkZRC0+gXbWg==
X-Google-Smtp-Source: ABdhPJz0AmwXVnHDjhBPl9tsO/8sGagnCXBDc3uDumDMvb/saPFlYjgUtq3lB9E2zpJme1xzd+FCWA==
X-Received: by 2002:adf:9011:: with SMTP id h17mr9784605wrh.384.1619255025914;
        Sat, 24 Apr 2021 02:03:45 -0700 (PDT)
Received: from agape ([5.171.80.252])
        by smtp.gmail.com with ESMTPSA id h14sm14247409wrq.45.2021.04.24.02.03.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 24 Apr 2021 02:03:45 -0700 (PDT)
From:   Fabio Aiuto <fabioaiuto83@gmail.com>
To:     gregkh@linuxfoundation.org
Cc:     joe@perches.com, linux-staging@lists.linux.dev,
        linux-kernel@vger.kernel.org
Subject: [PATCH v2 42/50] staging: rtl8723bs: remove unused macros tied to _HCI_OPS_OS_C_ definition
Date:   Sat, 24 Apr 2021 11:02:25 +0200
Message-Id: <8cddae8116da58df3f5a9be48e618418a4c686ef.1619254603.git.fabioaiuto83@gmail.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <cover.1619254603.git.fabioaiuto83@gmail.com>
References: <cover.1619254603.git.fabioaiuto83@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

remove unused macros tied to
_HCI_OPS_OS_C_ definition.

Signed-off-by: Fabio Aiuto <fabioaiuto83@gmail.com>
---
 drivers/staging/rtl8723bs/include/rtw_debug.h | 5 +----
 1 file changed, 1 insertion(+), 4 deletions(-)

diff --git a/drivers/staging/rtl8723bs/include/rtw_debug.h b/drivers/staging/rtl8723bs/include/rtw_debug.h
index 261317b07635..a6c2956133ed 100644
--- a/drivers/staging/rtl8723bs/include/rtw_debug.h
+++ b/drivers/staging/rtl8723bs/include/rtw_debug.h
@@ -7,7 +7,6 @@
 #ifndef __RTW_DEBUG_H__
 #define __RTW_DEBUG_H__
 
-#define _module_hci_ops_os_c_			BIT(24)
 #define _module_rtl871x_ioctl_os_c		BIT(25)
 #define _module_rtl8712_cmd_c_		BIT(26)
 /* define _module_efuse_			BIT(27) */
@@ -19,9 +18,7 @@
 
 #undef _MODULE_DEFINE_
 
-#if defined _HCI_OPS_OS_C_
-	#define	_MODULE_DEFINE_	_module_hci_ops_os_c_
-#elif defined _RTL871X_IOCTL_LINUX_C_
+#if defined _RTL871X_IOCTL_LINUX_C_
 	#define	_MODULE_DEFINE_	_module_rtl871x_ioctl_os_c
 #elif defined _RTL8712_CMD_C_
 	#define	_MODULE_DEFINE_	_module_rtl8712_cmd_c_
-- 
2.20.1

