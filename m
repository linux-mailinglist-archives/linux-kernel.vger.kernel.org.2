Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6326D36A061
	for <lists+linux-kernel@lfdr.de>; Sat, 24 Apr 2021 11:05:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237079AbhDXJF6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 24 Apr 2021 05:05:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58358 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237419AbhDXJEK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 24 Apr 2021 05:04:10 -0400
Received: from mail-wm1-x32c.google.com (mail-wm1-x32c.google.com [IPv6:2a00:1450:4864:20::32c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 58046C061574
        for <linux-kernel@vger.kernel.org>; Sat, 24 Apr 2021 02:03:32 -0700 (PDT)
Received: by mail-wm1-x32c.google.com with SMTP id n4-20020a05600c4f84b029013151278decso2407212wmq.4
        for <linux-kernel@vger.kernel.org>; Sat, 24 Apr 2021 02:03:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=RLOdNZ/idN2fC5170Bm5seBXbd2GYVgAZ5BDCqnR19c=;
        b=Brxc2zhbr5SLSYkNjRsmPqwmdBWvb5SfwfKjg0wDmEUfvHP5sxTCAroeTYMgxbwEeh
         vjjRqTQCpHi32a9mYtZ1f7CK1zMem7fUVe4k3NPtp/1Dme3IbbLahcMJWTAFmRQ5l+yx
         Wb77eAniAf1wwMBHvPoa99wYaHQyR4to0AXOtHQD2ayusj5WAMAyR4HVyfQQnfQ60nBi
         AqiZ8b5ljJgNwwsN+OyorlR/g4tRbbbodxlIjIlZh99RBeHkP1cGLNvI5UI4hBTfsLJk
         efFVCTtBhpFZ8MAFw0Qx4VhEkO/n3M/Q5I8woVSBrv9oiYXBfK/h2GEfOAT8a3e+SM7K
         qxlQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=RLOdNZ/idN2fC5170Bm5seBXbd2GYVgAZ5BDCqnR19c=;
        b=WYNM8DKvUaaeF7ltaSw8T8nILPBcswmHStUXA/HVvR6ifjG2X0jAOXquhhlymuxJQg
         JeWHSU3kdhyRbRr/s9pgKQO+MwmLhzFw2bc+LURrEViru37Y7ZFEXh5QX6cI7u3X15xZ
         C00ek2JfLL6PjjBpGY2wiMkl7xrioGppPuTxqs30oHIXuDxO5Gc1VrVY8fHDkLXSR+ez
         rQE+H6dJHT1HCmcfGQAlGhNil1MsZJnJ5BaY3bRl1sEJU6vDLTfNKQNmCOIICDB5kqc3
         L1OAZkT1AMSArWP6L6+jYolnNjhXX9Ztw/cOFX1xvcWdD7UBncxSWtW7WjF0yrROWMYY
         pW+g==
X-Gm-Message-State: AOAM530MkQya/D3xm/BQ1kTWLUzdXjYELaQwgcHwFsR8APdtePmdoc6V
        +CMFdXh0cXzOsuImHBExkya1NP71cDvS4w==
X-Google-Smtp-Source: ABdhPJwrLyO6cdvvqY8+IeqmgjqM3g2VhyMC+tdYkZ5wqfP2vSxz8bs61/wdY256itHJHyWVJcjhRw==
X-Received: by 2002:a1c:a54a:: with SMTP id o71mr8697594wme.172.1619255010874;
        Sat, 24 Apr 2021 02:03:30 -0700 (PDT)
Received: from agape ([5.171.80.252])
        by smtp.gmail.com with ESMTPSA id o62sm38514561wmo.3.2021.04.24.02.03.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 24 Apr 2021 02:03:30 -0700 (PDT)
From:   Fabio Aiuto <fabioaiuto83@gmail.com>
To:     gregkh@linuxfoundation.org
Cc:     joe@perches.com, linux-staging@lists.linux.dev,
        linux-kernel@vger.kernel.org
Subject: [PATCH v2 33/50] staging: rtl8723bs: remove unused debug macros tied to _RTL871X_IOCTL_SET_C_ definition
Date:   Sat, 24 Apr 2021 11:02:16 +0200
Message-Id: <f21423d909f1c2b95cac10a715ea49af76b776b1.1619254603.git.fabioaiuto83@gmail.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <cover.1619254603.git.fabioaiuto83@gmail.com>
References: <cover.1619254603.git.fabioaiuto83@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

remove unused debug macros tied to
 _RTL871X_IOCTL_SET_C_ definition.

Signed-off-by: Fabio Aiuto <fabioaiuto83@gmail.com>
---
 drivers/staging/rtl8723bs/include/rtw_debug.h | 5 +----
 1 file changed, 1 insertion(+), 4 deletions(-)

diff --git a/drivers/staging/rtl8723bs/include/rtw_debug.h b/drivers/staging/rtl8723bs/include/rtw_debug.h
index 501155c8c9cf..7f84bc03e9c7 100644
--- a/drivers/staging/rtl8723bs/include/rtw_debug.h
+++ b/drivers/staging/rtl8723bs/include/rtw_debug.h
@@ -7,7 +7,6 @@
 #ifndef __RTW_DEBUG_H__
 #define __RTW_DEBUG_H__
 
-#define _module_rtl871x_ioctl_set_c_		BIT(17)
 #define _module_rtl871x_ioctl_query_c_	BIT(18)
 #define _module_rtl871x_pwrctrl_c_			BIT(19)
 #define _module_hci_intfs_c_			BIT(20)
@@ -26,9 +25,7 @@
 
 #undef _MODULE_DEFINE_
 
-#if defined _RTL871X_IOCTL_SET_C_
-	#define	_MODULE_DEFINE_	_module_rtl871x_ioctl_set_c_
-#elif defined _RTL871X_IOCTL_QUERY_C_
+#if defined _RTL871X_IOCTL_QUERY_C_
 	#define	_MODULE_DEFINE_	_module_rtl871x_ioctl_query_c_
 #elif defined _RTL871X_PWRCTRL_C_
 	#define	_MODULE_DEFINE_	_module_rtl871x_pwrctrl_c_
-- 
2.20.1

