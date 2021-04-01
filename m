Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 35330351226
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Apr 2021 11:30:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234580AbhDAJYD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 1 Apr 2021 05:24:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36538 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234122AbhDAJWo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Apr 2021 05:22:44 -0400
Received: from mail-ed1-x535.google.com (mail-ed1-x535.google.com [IPv6:2a00:1450:4864:20::535])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 26338C0613E6
        for <linux-kernel@vger.kernel.org>; Thu,  1 Apr 2021 02:22:44 -0700 (PDT)
Received: by mail-ed1-x535.google.com with SMTP id x21so1163354eds.4
        for <linux-kernel@vger.kernel.org>; Thu, 01 Apr 2021 02:22:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=IKhEXT66iJIONAmAc2SJC/Db6Cavnl//qgP4+fnjAt0=;
        b=JAfsSg/xP6H1BaRfgCQtGN9xzxHBtoKk1XXrNlLAdSiom41M861yNgL9UxpS1MRmMR
         Dt+qkazwMg1dDc1w/lw79Y58FTeTMLCcG8E8PqhZMF6dnOtogUYeQHqWVrsOdaG8i7OU
         6qDEtxtCmF90kDPuQzJDkq4dAbeSupVFgQuBSIYYOMFZFzq5FhSOpxD2RwZmioCB0QTP
         CRBbg9d5Rr+gEPEhGuzt1jPrc08IBGc5pYdlMAJ9BTOrwD7hVVWMFZ1zQujX8yR3WJNs
         ZHuClfLUVEbY3rvvUDD2XNY4MvJ0RHDPFiHiXvEImZnVO/R+G4AaCnbby0ETn3+r5EYE
         kolw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=IKhEXT66iJIONAmAc2SJC/Db6Cavnl//qgP4+fnjAt0=;
        b=fcxcaojvgC7twY47jAhfSYeynKkwL2ntGWBEdL7nbevvkiwr47fZFVNtXXXzOR/tW9
         ExFKOThIJacqdj4Tv1xkv/wtMWSnACMpVP0NrI4TB2InzQQ/HIbL+XL1BOJd61G9QR4A
         TnoFJtGFpZXTnZ99YcIwdewVozVcX5yDmMTiOwD1axB+mcKGMBOmgnHK29Y+rAUzIMvB
         tCkrUOnUfYjKxy4tMsu5/0/siJnpyD0Yyvn8E/hDIrksaHy/gXZBNUPenFqI7p+T0GSf
         Ws61XJSLaifHQbVg9UL/hmpemVFg9ZUktSyTs1GHnzZkJdFsp4Ad/+YSYXVLUBwwrBIt
         d/yA==
X-Gm-Message-State: AOAM5321nTI4KXIOaFAy1SqOwKKP2YULBdvUosWNMpQuSipZMx6i4x7o
        GK/8kIKFI0BPAkamnwWbUt8=
X-Google-Smtp-Source: ABdhPJxjoF82gW4KMVWKm60oOl8v9ay5vfX9TqHcN5ipYsV9JJRquqKlivA+5y0gzNc/9JVkxyDv2Q==
X-Received: by 2002:a05:6402:1350:: with SMTP id y16mr8650792edw.309.1617268962913;
        Thu, 01 Apr 2021 02:22:42 -0700 (PDT)
Received: from agape ([5.171.80.247])
        by smtp.gmail.com with ESMTPSA id p19sm3273654edr.57.2021.04.01.02.22.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 01 Apr 2021 02:22:42 -0700 (PDT)
From:   Fabio Aiuto <fabioaiuto83@gmail.com>
To:     gregkh@linuxfoundation.org
Cc:     joe@perches.com, dan.carpenter@oracle.com,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org,
        Fabio Aiuto <fabioaiuto83@gmail.com>
Subject: [PATCH 49/49] staging: rtl8723bs: remove obsolete macro
Date:   Thu,  1 Apr 2021 11:21:19 +0200
Message-Id: <1c7cdfcf488e5dc5bc5c3c29733b0d53caee71fb.1617268327.git.fabioaiuto83@gmail.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <cover.1617268327.git.fabioaiuto83@gmail.com>
References: <cover.1617268327.git.fabioaiuto83@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

remove obsolete macro RT_TRACE

Signed-off-by: Fabio Aiuto <fabioaiuto83@gmail.com>
---
 drivers/staging/rtl8723bs/include/rtw_debug.h | 18 ------------------
 1 file changed, 18 deletions(-)

diff --git a/drivers/staging/rtl8723bs/include/rtw_debug.h b/drivers/staging/rtl8723bs/include/rtw_debug.h
index d3c77798a5eb..6639d79cd7ec 100644
--- a/drivers/staging/rtl8723bs/include/rtw_debug.h
+++ b/drivers/staging/rtl8723bs/include/rtw_debug.h
@@ -131,8 +131,6 @@
 	#define	_MODULE_DEFINE_	_module_efuse_
 #endif
 
-#define RT_TRACE(_Comp, _Level, Fmt) do {} while (0)
-
 #define DBG_871X(x, ...) do {} while (0)
 #define MSG_8192C(x, ...) do {} while (0)
 #define DBG_8192C(x, ...) do {} while (0)
@@ -216,22 +214,6 @@
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

