Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D3A2D36A062
	for <lists+linux-kernel@lfdr.de>; Sat, 24 Apr 2021 11:05:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236232AbhDXJGB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 24 Apr 2021 05:06:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58324 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237445AbhDXJEM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 24 Apr 2021 05:04:12 -0400
Received: from mail-wm1-x330.google.com (mail-wm1-x330.google.com [IPv6:2a00:1450:4864:20::330])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 00C5FC06174A
        for <linux-kernel@vger.kernel.org>; Sat, 24 Apr 2021 02:03:34 -0700 (PDT)
Received: by mail-wm1-x330.google.com with SMTP id n4-20020a05600c4f84b029013151278decso2407234wmq.4
        for <linux-kernel@vger.kernel.org>; Sat, 24 Apr 2021 02:03:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=JmVSxO1mcykbvIqMdlxGXo0H35C2W5D9ZAmsoCB0GTI=;
        b=eGsRIazwxE9PPw733zFs1WSsnYKobx9lOk/iubnZnP/fnjpOpewj2btyT6Rs78NSl0
         jig8ul2kZD7E3Z/aq3LGFIQb3Lenzq2xZ5JoxNV78eRV+VEPxCUoCSOuloM5ifeteRlF
         pTCXTymDm82Ck5XnaTRj8wcFp5W4R3KcXMXIypQmNIh+v/G/KDhXYt5mHazo/7Fm5NqJ
         BlbZubns2ONDIXc2OKRGfrlLdzx4LBYhIcwIK23iXK0ZeSIds4pQuhuTKf5ZHMDdVYQF
         2oV79ZuA2eyR8KVoFX/0V9k9kAerxbTNmvZNATN1JDOAw4251bV4DzXKGdJIEH1ZZkb4
         mSkg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=JmVSxO1mcykbvIqMdlxGXo0H35C2W5D9ZAmsoCB0GTI=;
        b=oyax1AvPLL26XjLv45FY1yJyUDcV7fRp6TPZJxtr4/mxGZ2oOvy37VNE3W1i4lNdLF
         y64Y5eKqocQmVZZqRsVEUBaPqQuC4LjBOKfFfD5TDwff0wwZz3mx05J2dm2MTn0ZOmdh
         o7qkE1UwLwmf8MIZoW3nOKrvNrKURIfZzDR30MNPE19jC8zgob3VX3qGxaL8PC53xcbH
         FCnHmlDhbjjS4/j13F5kRgk8fg9+v6+1mFRGuOmK/cnMd5bbM9nwafwtDOJGTl0oL6hN
         UmPbO8aB3Ecf9S8BCMtS3vW9qVyptVWQQ1MCcK29674+pOLLVW9xNvxO2BrFvQ7yu9DV
         aFFQ==
X-Gm-Message-State: AOAM5332PVu023cp7aKTgLaVoxd6KKzaDUHkJs7TrYPVRt/sAXXHLlsO
        BmX3VmY3LxG+U8U8ibqkxDHcr5S2gfAbUw==
X-Google-Smtp-Source: ABdhPJySmWJlYPB+tgfzn92lmHsWeHMHIN0TgQBNsRgMYcLb0Doroi3hhXRWSFOIQr31xTYWy2h1xA==
X-Received: by 2002:a05:600c:3790:: with SMTP id o16mr6024325wmr.155.1619255012626;
        Sat, 24 Apr 2021 02:03:32 -0700 (PDT)
Received: from agape ([5.171.80.252])
        by smtp.gmail.com with ESMTPSA id h17sm12007428wru.67.2021.04.24.02.03.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 24 Apr 2021 02:03:32 -0700 (PDT)
From:   Fabio Aiuto <fabioaiuto83@gmail.com>
To:     gregkh@linuxfoundation.org
Cc:     joe@perches.com, linux-staging@lists.linux.dev,
        linux-kernel@vger.kernel.org
Subject: [PATCH v2 34/50] staging: rtl8723bs: remove unused debug macros tied to _RTL871X_IOCTL_QUERY_C_ definition
Date:   Sat, 24 Apr 2021 11:02:17 +0200
Message-Id: <9157d4b219072ef48e5e91814718d2b19d0e3b77.1619254603.git.fabioaiuto83@gmail.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <cover.1619254603.git.fabioaiuto83@gmail.com>
References: <cover.1619254603.git.fabioaiuto83@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

remove unused debug macros tied to
_RTL871X_IOCTL_QUERY_C_ definition.

Signed-off-by: Fabio Aiuto <fabioaiuto83@gmail.com>
---
 drivers/staging/rtl8723bs/include/rtw_debug.h | 5 +----
 1 file changed, 1 insertion(+), 4 deletions(-)

diff --git a/drivers/staging/rtl8723bs/include/rtw_debug.h b/drivers/staging/rtl8723bs/include/rtw_debug.h
index 7f84bc03e9c7..be44d72599d3 100644
--- a/drivers/staging/rtl8723bs/include/rtw_debug.h
+++ b/drivers/staging/rtl8723bs/include/rtw_debug.h
@@ -7,7 +7,6 @@
 #ifndef __RTW_DEBUG_H__
 #define __RTW_DEBUG_H__
 
-#define _module_rtl871x_ioctl_query_c_	BIT(18)
 #define _module_rtl871x_pwrctrl_c_			BIT(19)
 #define _module_hci_intfs_c_			BIT(20)
 #define _module_hci_ops_c_			BIT(21)
@@ -25,9 +24,7 @@
 
 #undef _MODULE_DEFINE_
 
-#if defined _RTL871X_IOCTL_QUERY_C_
-	#define	_MODULE_DEFINE_	_module_rtl871x_ioctl_query_c_
-#elif defined _RTL871X_PWRCTRL_C_
+#if defined _RTL871X_PWRCTRL_C_
 	#define	_MODULE_DEFINE_	_module_rtl871x_pwrctrl_c_
 #elif defined _RTW_PWRCTRL_C_
 	#define	_MODULE_DEFINE_	1
-- 
2.20.1

