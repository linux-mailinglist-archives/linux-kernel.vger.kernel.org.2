Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E73EA36A072
	for <lists+linux-kernel@lfdr.de>; Sat, 24 Apr 2021 11:06:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238072AbhDXJHU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 24 Apr 2021 05:07:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58476 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237579AbhDXJEj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 24 Apr 2021 05:04:39 -0400
Received: from mail-wr1-x42e.google.com (mail-wr1-x42e.google.com [IPv6:2a00:1450:4864:20::42e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 21F25C06138C
        for <linux-kernel@vger.kernel.org>; Sat, 24 Apr 2021 02:03:59 -0700 (PDT)
Received: by mail-wr1-x42e.google.com with SMTP id e7so41704132wrs.11
        for <linux-kernel@vger.kernel.org>; Sat, 24 Apr 2021 02:03:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=Rd5Skrnm1vG8IFRdylWE6XpRaE/YvS+Wl0BTfIy1QHc=;
        b=ozK0lX2wtNAycHUDWCVuYqTbJMngH9apRulBK6FOUaO12gAjEFbqGJr+IGl4EcgHD+
         qciEHWfTp76ht0eKNhhuJ5MEhcisA31s2YryVVecQVkCkwcJqpTZTj8//18ScUjuVlPB
         dqMGRUu6Bu8BHNWNCP7ldxl9b4l/Ub3qlNfConfewJ1mCd1qFdtK7xXCpC2bVQkYoglq
         pTvdijloSxuIVYis4jS5QXqi5vJD7YPIY9vgWGlNo2rIhOnBBj+Ddzd2k3UiNJdoJxwt
         SgEGmQn5+FGzJ/FdLv9Qhz6cDS4/cF44WQT1iER90R2dMQx0EAXqAVVupFfROAYUby7x
         wBhA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=Rd5Skrnm1vG8IFRdylWE6XpRaE/YvS+Wl0BTfIy1QHc=;
        b=iTjmY6LFxesmzANV/zJJXMFtmPoCH7a2FKJj1v1ptdt5q1vrmshCPZgBeJkAJwKjwv
         3WCSTfW98ZkqBOIdu7a2Y+jRjpGMVllRS/znwFDa52waG9P9q8F0R2p6XcFeFNtJp00P
         KuNyk5ZqTcaSoUJaLmS1S5mYB+EoyTLH/IRHhemWBMpE2MpP/rROvnu/NYYBbp7QJ4q9
         OR6Gt5uDIDKZ/5vDeK/nSSlJLMWF2fgA/OIoUyxeekwBr8m1my/hueOhH8Q/132OjNL9
         pjuK3Id9V5Vcyb3YT4Q8Bj11pbkayyObtRArWlrAyom6SX2upJ5+GkRf3PJAPMBJ03Oy
         mSBw==
X-Gm-Message-State: AOAM531TZ+3FRZNf6/S3AFnT1IuJakN2yMWyBzuJi7ppTYLAJFZtZmpN
        SxPXOSULHkOUIEZhC5Zq5xOHx4//5FBnRg==
X-Google-Smtp-Source: ABdhPJzpikNzw5yythw0nY19FXLqeEtffu9LBFqGLpq0n9SSadbJz8XrwkSNOWsggxRjM4MV4Tu64w==
X-Received: by 2002:adf:8b02:: with SMTP id n2mr9522850wra.259.1619255037747;
        Sat, 24 Apr 2021 02:03:57 -0700 (PDT)
Received: from agape ([5.171.80.252])
        by smtp.gmail.com with ESMTPSA id p18sm11490944wrs.68.2021.04.24.02.03.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 24 Apr 2021 02:03:57 -0700 (PDT)
From:   Fabio Aiuto <fabioaiuto83@gmail.com>
To:     gregkh@linuxfoundation.org
Cc:     joe@perches.com, linux-staging@lists.linux.dev,
        linux-kernel@vger.kernel.org
Subject: [PATCH v2 49/50] staging: rtl8723bs: remove last unused debug macros
Date:   Sat, 24 Apr 2021 11:02:32 +0200
Message-Id: <3baf120a9e99d087968e8db55e2b1c33ae5c5e8a.1619254603.git.fabioaiuto83@gmail.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <cover.1619254603.git.fabioaiuto83@gmail.com>
References: <cover.1619254603.git.fabioaiuto83@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

remove last unused debug macros.

Signed-off-by: Fabio Aiuto <fabioaiuto83@gmail.com>
---
 drivers/staging/rtl8723bs/include/rtw_debug.h | 12 ------------
 1 file changed, 12 deletions(-)

diff --git a/drivers/staging/rtl8723bs/include/rtw_debug.h b/drivers/staging/rtl8723bs/include/rtw_debug.h
index c9f53c08efbb..189f02a8300a 100644
--- a/drivers/staging/rtl8723bs/include/rtw_debug.h
+++ b/drivers/staging/rtl8723bs/include/rtw_debug.h
@@ -7,18 +7,6 @@
 #ifndef __RTW_DEBUG_H__
 #define __RTW_DEBUG_H__
 
-#define _module_rtl8712_recv_c_		BIT(30)
-
-#undef _MODULE_DEFINE_
-
-#if defined _RTL8712_RECV_C_
-	#define	_MODULE_DEFINE_	_module_rtl8712_recv_c_
-#elif defined _RTL8192CU_RECV_C_
-	#define	_MODULE_DEFINE_	_module_rtl8712_recv_c_
-#elif defined _RTL871X_MLME_EXT_C_
-	#define _MODULE_DEFINE_	_module_mlme_osdep_c_
-#endif
-
 #define DRIVER_PREFIX "RTL8723BS: "
 
 void mac_reg_dump(struct adapter *adapter);
-- 
2.20.1

