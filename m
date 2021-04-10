Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E6E4F35AE1D
	for <lists+linux-kernel@lfdr.de>; Sat, 10 Apr 2021 16:21:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234854AbhDJOVI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 10 Apr 2021 10:21:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54640 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234806AbhDJOVC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 10 Apr 2021 10:21:02 -0400
Received: from mail-ed1-x52b.google.com (mail-ed1-x52b.google.com [IPv6:2a00:1450:4864:20::52b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 28E45C06138D
        for <linux-kernel@vger.kernel.org>; Sat, 10 Apr 2021 07:20:47 -0700 (PDT)
Received: by mail-ed1-x52b.google.com with SMTP id ba6so9796632edb.1
        for <linux-kernel@vger.kernel.org>; Sat, 10 Apr 2021 07:20:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=7Ihlf6EeNR0Ofy/7hSQfm/MbRWgreKGnDKnK62NK7Uo=;
        b=De7eaLb73QaNAFXdzKrrurzhdbblg1ANXUUNY6GK5QDY2uitlAKmxthg1gbRnvkA+r
         E+phag5oZhzde7J6Fr+r0oRaPAr0y0XtJdKkajUPJUpYm9dXbBa4IesXxxhga0ezn1Cu
         Eq7syHLMXa2ShtjsqailmdJwDNnNZ+iiVscTi4sXDryPqLnZ2x+thz34RCCXU2Iej2uk
         E7lYTJ83Fo3T0v7MDd9+m8FWek4sQalv7/YbKt/KOfshwRGktVJnn1H3j2jaCPwxVMBj
         TppB8A++uvewUDF4r96qyIccwH7aOGjiPNVRJJgr0m/Ym5HFPmzeq6Ps/d8xkT0ZGqDn
         S5Yg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=7Ihlf6EeNR0Ofy/7hSQfm/MbRWgreKGnDKnK62NK7Uo=;
        b=F/KnV5+8AUMeCJt1V2+xHZ3iTZAZrm1imZwya34yLvNMcnK5c/2woitcjRVaDcgdfV
         zZTFYNtN+cNNsn/PdmltIh82wOk1jqX/tm6RWAeaDRaxEg8gSqmQhDtDopR+9C9Bzrkc
         X7rUuIbmZZUhbF9iMnn5Qmsykbx3kNEfG1xxF3/gC2tm9mOCBP31xEpnr6G45dmhuIA5
         Hho+tl/S7AD4Kgna9yelmqjiggiVjBrdyBQTMINag4fYvxGnJhqYz6+Or8cglTxE6zfn
         915Cu2qVGHhYcXSrJptr3vfJSbt8fw2PvKkrP5LkRxLp1jASfpfGjilcyXNIkHW42C8F
         DTkw==
X-Gm-Message-State: AOAM5319UIGw0/dG08NKVmRDMe3e3peVh7c4qwc/IFkZiatJ3KdRwGp5
        ICIjytQ/SvV20mdyFqTwGLty5gGnEGAKOA==
X-Google-Smtp-Source: ABdhPJz3qI31piMzN/172lSxyB86SDdbkXGNuWnJML4z0NDfxvNYM5y6iT5JN+r2j9WAWJD4mg7vJA==
X-Received: by 2002:a05:6402:104c:: with SMTP id e12mr21390495edu.108.1618064445712;
        Sat, 10 Apr 2021 07:20:45 -0700 (PDT)
Received: from agape ([5.171.81.28])
        by smtp.gmail.com with ESMTPSA id p4sm2560398edr.43.2021.04.10.07.20.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 10 Apr 2021 07:20:45 -0700 (PDT)
From:   Fabio Aiuto <fabioaiuto83@gmail.com>
To:     gregkh@linuxfoundation.org
Cc:     linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: [PATCH 03/25] staging: rtl8723bs: remove DBG_8192C macro definitions
Date:   Sat, 10 Apr 2021 16:20:16 +0200
Message-Id: <e7259eeb5927d48a2920548b92dc507befa5e6af.1618064274.git.fabioaiuto83@gmail.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <cover.1618064274.git.fabioaiuto83@gmail.com>
References: <cover.1618064274.git.fabioaiuto83@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

remove all DBG_8192C macro definitions.

Macro DBG_8192C belongs to a family of verbose
private tracing macros.

The default behaviour is _do nothing_, to activate
it one should define DEBUG symbol by hand.

So just remove it

Signed-off-by: Fabio Aiuto <fabioaiuto83@gmail.com>
---
 drivers/staging/rtl8723bs/include/rtw_debug.h | 10 ----------
 1 file changed, 10 deletions(-)

diff --git a/drivers/staging/rtl8723bs/include/rtw_debug.h b/drivers/staging/rtl8723bs/include/rtw_debug.h
index 65e1d9bd7099..7747e90bd1cc 100644
--- a/drivers/staging/rtl8723bs/include/rtw_debug.h
+++ b/drivers/staging/rtl8723bs/include/rtw_debug.h
@@ -131,7 +131,6 @@
 	#define	_MODULE_DEFINE_	_module_efuse_
 #endif
 
-#define DBG_8192C(x, ...) do {} while (0)
 #define DBG_871X_LEVEL(x, ...) do {} while (0)
 
 #undef _dbgdump
@@ -193,15 +192,6 @@
 
 #endif /* defined(_dbgdump) */
 
-#ifdef DEBUG
-#if	defined(_dbgdump)
-	#undef DBG_8192C
-	#define DBG_8192C(...)     do {\
-		_dbgdump(DRIVER_PREFIX __VA_ARGS__);\
-	} while (0)
-#endif /* defined(_dbgdump) */
-#endif /* DEBUG */
-
 void dump_drv_version(void *sel);
 void dump_log_level(void *sel);
 
-- 
2.20.1

