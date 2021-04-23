Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3515A36954C
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Apr 2021 16:59:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242907AbhDWO7z (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 23 Apr 2021 10:59:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48694 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242783AbhDWO7i (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 23 Apr 2021 10:59:38 -0400
Received: from mail-wr1-x42e.google.com (mail-wr1-x42e.google.com [IPv6:2a00:1450:4864:20::42e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 88AE9C06138B
        for <linux-kernel@vger.kernel.org>; Fri, 23 Apr 2021 07:58:59 -0700 (PDT)
Received: by mail-wr1-x42e.google.com with SMTP id c15so39764518wro.13
        for <linux-kernel@vger.kernel.org>; Fri, 23 Apr 2021 07:58:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=Tik2seEPmYbG3/nfRHJhbJrnEhAl8Pv2iXQyiuLU5zQ=;
        b=hYWTE/wPgWF17hJsfe4W3w26PGMabUTFsk/YnWWG+3g/xFX512v3Aow/d8LKa61cAC
         Aci2FNhSpAIDeLggtq17b/vO42ypl2SEswOJbkuY6BnYXTSYK3+cWWuJiDmo3OvWwJGC
         dDN7BgkDQrE0XyXvhHE8yyI3lKVCHztIAVV5XBY7AQe/O7xDqurpU3RgRQnr1m2wBVVM
         NJo9VNfiDWIvlFFXMKS0rQbiYbgc9oF/82fraB6BxBQOxSdY7xHZ/crGPFdK0f6pUy5s
         uSbJzUFQDTYc0v3XmoHs9YBGPr6fcZ1B0paN0il0d+5pI/7/nMOT79Vo5Fs8ZvXSmXLY
         jh2Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=Tik2seEPmYbG3/nfRHJhbJrnEhAl8Pv2iXQyiuLU5zQ=;
        b=I7mjheVGOiFOAP8zHfIma66/aZJqxOYcmOTXoYZaaQT0iqfkvNsCA5Z7XbzuCVcuQZ
         K1/9CrdsCnm8cpQZWcjZIoe3j46qc3O+ltjz8IfgaQofdGDSM7mlnF1hPryi2S42PK+0
         Te6C5CneuGI1oq9sALVw7M2sjS8G9UDb9oA0mv9Vt7m9UPLbJ7vL3AdMdkEVDhzy4iTR
         7nSptTuq5Ag5d16hU70fmROxNS+Voywgwh7WoMwgaGxpCkAULBe02PrtFMcU9fA88Mxq
         DQm6ty58Xh8331+2x2XojJKgd2t2MgbLd39n4Pyc/ag0K9in7smzdEktb6ppvNGSWRc+
         c2SA==
X-Gm-Message-State: AOAM532qQhI0ttIfqDPCfg6PIRhvCVkuqF9PKN8Qg096CDFiOo4d+5eP
        akivsVhSNupm1YC7Y3g0pGV6wUnxTZs=
X-Google-Smtp-Source: ABdhPJwMH2VfpOfV+fBjlbHf9rZ3hqIkkR7sFjRsDzyPasG1/94zP9a2+a+rBN0LjE168Gskoh23NQ==
X-Received: by 2002:adf:fe09:: with SMTP id n9mr5345877wrr.284.1619189938096;
        Fri, 23 Apr 2021 07:58:58 -0700 (PDT)
Received: from agape ([5.171.72.99])
        by smtp.gmail.com with ESMTPSA id u2sm10473213wmm.5.2021.04.23.07.58.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 23 Apr 2021 07:58:57 -0700 (PDT)
From:   Fabio Aiuto <fabioaiuto83@gmail.com>
To:     gregkh@linuxfoundation.org
Cc:     linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: [PATCH 10/49] staging: rtl8723bs: remove unused debug variables declarations and initialization
Date:   Fri, 23 Apr 2021 16:58:01 +0200
Message-Id: <b0877682d86c83f65be4d91386c4e682f5b7aee8.1619189489.git.fabioaiuto83@gmail.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <cover.1619189489.git.fabioaiuto83@gmail.com>
References: <cover.1619189489.git.fabioaiuto83@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

remove unused debug variables extern declarations
and containing #ifndef block.

remove initialization as well.

Signed-off-by: Fabio Aiuto <fabioaiuto83@gmail.com>
---
 drivers/staging/rtl8723bs/core/rtw_debug.c    | 2 --
 drivers/staging/rtl8723bs/include/rtw_debug.h | 5 -----
 2 files changed, 7 deletions(-)

diff --git a/drivers/staging/rtl8723bs/core/rtw_debug.c b/drivers/staging/rtl8723bs/core/rtw_debug.c
index e6e583446626..78130e63078c 100644
--- a/drivers/staging/rtl8723bs/core/rtw_debug.c
+++ b/drivers/staging/rtl8723bs/core/rtw_debug.c
@@ -10,8 +10,6 @@
 #include <rtw_debug.h>
 #include <hal_btcoex.h>
 
-u32 GlobalDebugLevel = _drv_err_;
-
 #include <rtw_version.h>
 
 void mac_reg_dump(struct adapter *adapter)
diff --git a/drivers/staging/rtl8723bs/include/rtw_debug.h b/drivers/staging/rtl8723bs/include/rtw_debug.h
index 2232a1014528..579724e8fc2f 100644
--- a/drivers/staging/rtl8723bs/include/rtw_debug.h
+++ b/drivers/staging/rtl8723bs/include/rtw_debug.h
@@ -131,11 +131,6 @@
 	#define	_MODULE_DEFINE_	_module_efuse_
 #endif
 
-#ifndef _RTL871X_DEBUG_C_
-	extern u32 GlobalDebugLevel;
-	extern u64 GlobalDebugComponents;
-#endif
-
 #define DRIVER_PREFIX "RTL8723BS: "
 
 void mac_reg_dump(struct adapter *adapter);
-- 
2.20.1

