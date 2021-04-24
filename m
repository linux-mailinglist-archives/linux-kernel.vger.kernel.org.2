Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1118236A058
	for <lists+linux-kernel@lfdr.de>; Sat, 24 Apr 2021 11:04:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237788AbhDXJFP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 24 Apr 2021 05:05:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58376 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237348AbhDXJDz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 24 Apr 2021 05:03:55 -0400
Received: from mail-wr1-x432.google.com (mail-wr1-x432.google.com [IPv6:2a00:1450:4864:20::432])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 060CDC06138C
        for <linux-kernel@vger.kernel.org>; Sat, 24 Apr 2021 02:03:17 -0700 (PDT)
Received: by mail-wr1-x432.google.com with SMTP id m9so37937464wrx.3
        for <linux-kernel@vger.kernel.org>; Sat, 24 Apr 2021 02:03:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=xT7xLGR/u98oUeFxtP8FIkbPXzcjRalBgVrGk8h35HY=;
        b=d9MevJG2/aebTxNaGiOyJJK7rFBaJLuONbjKrAYL1Skc5WEHZsjoZITH7VHA7UIhfJ
         XwQkAbeARR9v7Ckbszujxb8VMoKaNfvr9Jir8IA6Dvu5MAHvFSdYsXNCkgfdprphfe6H
         WhloNFzR60L0Fc0NmnUmRkBRwlGGkr20g6rC00tLzbWoc6TP1uRLI3I4NyUrK36jApQA
         Jl8Dva5hPxlC/aahgdgDfDHhy+63w90zqTby/QGoeXejf8+nXF2nZpW/rD0Du1u9LEJC
         0rqpRoUviE5DK2TAuC/NANFY33ulxY/aEMLrE7OisvX7syetPq5aCrsLEhw+DIBTcj9V
         J2hw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=xT7xLGR/u98oUeFxtP8FIkbPXzcjRalBgVrGk8h35HY=;
        b=uH2Ylfd+XCL7/6UGkO+OkdyeHwRwi1zhIR+tleqzweLVBhvZ45079R4N1c49wWo/cU
         eN5zgomGgJBMY2kk2LeMQBc3k13VL6Mnxmqo/Av5Q5f79BaboOyBP3zoW2fr/e1gfQDH
         cKx/UQfFmYibHMWR2useKQohiLD/PItWRZI4Ne+iMlLyaVx6M6QY/KVJJZA8GPUtnyCG
         A/l9sKIk6LBc4pSed9gz7JHcOTwkLPY+OhHhUt0hq0+WSD39s7wRZPT//VxlZhqIUSq6
         8Yll8tml4v2AvuxEIPgD6jLCNsDEincQjtcXZj7kctItS9LaiDEA5atwfDYBZ/Io+/X6
         5RJQ==
X-Gm-Message-State: AOAM533+ml3Q3pciZTQD3fEFdQY6d7d+7W6rBePnY1CvA4RLXGox9eAO
        QCcPJeT2d7x5c7c/QwdqoyeUPGHEvY6cRw==
X-Google-Smtp-Source: ABdhPJxR/z5NN7Kl8/Afei+r6SQXt+heg1jRd4xQ1a0QKGbNJk9bpZsifcdTPWcrphTeV0w0Nv53hw==
X-Received: by 2002:a5d:67c8:: with SMTP id n8mr10096516wrw.200.1619254995642;
        Sat, 24 Apr 2021 02:03:15 -0700 (PDT)
Received: from agape ([5.171.80.252])
        by smtp.gmail.com with ESMTPSA id f6sm10002406wmf.28.2021.04.24.02.03.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 24 Apr 2021 02:03:15 -0700 (PDT)
From:   Fabio Aiuto <fabioaiuto83@gmail.com>
To:     gregkh@linuxfoundation.org
Cc:     joe@perches.com, linux-staging@lists.linux.dev,
        linux-kernel@vger.kernel.org
Subject: [PATCH v2 24/50] staging: rtl8723bs: remove obsolete debug macro definitions
Date:   Sat, 24 Apr 2021 11:02:07 +0200
Message-Id: <5bc9e69d8ba03d2bd8031bcff73b22aeed5c0912.1619254603.git.fabioaiuto83@gmail.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <cover.1619254603.git.fabioaiuto83@gmail.com>
References: <cover.1619254603.git.fabioaiuto83@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

remove debug macro definition untied to any tracing component.

Signed-off-by: Fabio Aiuto <fabioaiuto83@gmail.com>
---
 drivers/staging/rtl8723bs/include/rtw_debug.h | 5 +----
 1 file changed, 1 insertion(+), 4 deletions(-)

diff --git a/drivers/staging/rtl8723bs/include/rtw_debug.h b/drivers/staging/rtl8723bs/include/rtw_debug.h
index bb56d38e6b7a..6e6dea4779d9 100644
--- a/drivers/staging/rtl8723bs/include/rtw_debug.h
+++ b/drivers/staging/rtl8723bs/include/rtw_debug.h
@@ -7,7 +7,6 @@
 #ifndef __RTW_DEBUG_H__
 #define __RTW_DEBUG_H__
 
-#define _module_cmd_osdep_c_		BIT(8)
 #define _module_rtl871x_io_c_				BIT(9)
 #define _module_io_osdep_c_		BIT(10)
 #define _module_os_intfs_c_			BIT(11)
@@ -35,9 +34,7 @@
 
 #undef _MODULE_DEFINE_
 
-#if defined _CMD_OSDEP_C_
-	#define _MODULE_DEFINE_	_module_cmd_osdep_c_
-#elif defined _RTW_IO_C_
+#if defined _RTW_IO_C_
 	#define _MODULE_DEFINE_	_module_rtl871x_io_c_
 #elif defined _IO_OSDEP_C_
 	#define _MODULE_DEFINE_	_module_io_osdep_c_
-- 
2.20.1

