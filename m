Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3B1CD369562
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Apr 2021 17:01:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243371AbhDWPBD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 23 Apr 2021 11:01:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48824 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243117AbhDWPAD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 23 Apr 2021 11:00:03 -0400
Received: from mail-wm1-x336.google.com (mail-wm1-x336.google.com [IPv6:2a00:1450:4864:20::336])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 56B80C06175F
        for <linux-kernel@vger.kernel.org>; Fri, 23 Apr 2021 07:59:26 -0700 (PDT)
Received: by mail-wm1-x336.google.com with SMTP id k4-20020a7bc4040000b02901331d89fb83so1390340wmi.5
        for <linux-kernel@vger.kernel.org>; Fri, 23 Apr 2021 07:59:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=Gr+K/KD3N327fp7eZydf22I4/DF15PNcSVC+sZKAZL8=;
        b=MYIN01Fcckf9oiF9Ft54iEBpF5iMRS+cAxyz9J+ZnnAKMzI3dMBuK+A/Ozda8l5M9G
         agkkOFsZB+ogpJQpo3CxuryXqiRwvfBq0+iyeciTZ8Iw/S+gsGhPl8mYMUjbe/esZKyS
         l4nRwk/ln2J2rVYEbJQz2RfbVXY6ThbYRIwvJcyIcetcLMEppuKO3VwTuAMOMR4OKvUY
         G/e2Rj7BcfjfkIx8dnrvIcWjtDaxtO/11KuUHI5pzklgqzeWYhiF4dLtzne1YYBfeMQt
         YlEAB2NDw6ZdZQbL1TGbmIAY8FezmFRXeYeiYYoEoTY6I+2PdbLXSD94ygT+gxmZGLiG
         HAyg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=Gr+K/KD3N327fp7eZydf22I4/DF15PNcSVC+sZKAZL8=;
        b=JcpmzqGonT5sVjwwJZPBrsjhCfk46EVY6HAPkEaBe8irculFHaMA2tIDNP9Bo57BYc
         LfH/PvBTQC9mRr0fOAr2ZSWKimRThBGR1AHGBtVyBt1SVLBgFEphiY1lTCecVojEB5E4
         uVN2achFosSt0lJtmI/O4o/ohtVw1Xfq5MoPKV7l8bd+H4N0RhzdKugzuc7iUMhveolG
         H+TiPQ5VnghupB4UzdUnWpoEB6SsZzlH1SAw17EZOu+VBX8djXtta6TgbTrQQel5peRN
         oLKCVCG+4gygnooEX48JO5ObUw69UjnZJPjEI23MU5453WtKjm0HQSzU3t9UF1MEKMeP
         f6Qw==
X-Gm-Message-State: AOAM531Ygx2pSrXs9buXbJ6avgzD8CrVgJHxNogvpJtZWV44uhkgIp8s
        SCElCBih68+qDvGYYxksD41nINq/rLE=
X-Google-Smtp-Source: ABdhPJy5D9byjEySTWVOXCIdZCEXhqP09xzrXXOMT8x26xVfi7NaVFZo57k4osTgplr5V1bwBBEB/g==
X-Received: by 2002:a7b:c10a:: with SMTP id w10mr2236126wmi.176.1619189964567;
        Fri, 23 Apr 2021 07:59:24 -0700 (PDT)
Received: from agape ([5.171.72.99])
        by smtp.gmail.com with ESMTPSA id i20sm10236192wmq.29.2021.04.23.07.59.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 23 Apr 2021 07:59:24 -0700 (PDT)
From:   Fabio Aiuto <fabioaiuto83@gmail.com>
To:     gregkh@linuxfoundation.org
Cc:     linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: [PATCH 26/49] staging: rtl8723bs: remove debug macros related to os_dep/os_intfs.c tracing
Date:   Fri, 23 Apr 2021 16:58:17 +0200
Message-Id: <ab291890a43722fb8c718bce3b6c4e74ae368b35.1619189489.git.fabioaiuto83@gmail.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <cover.1619189489.git.fabioaiuto83@gmail.com>
References: <cover.1619189489.git.fabioaiuto83@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

remove debug macro definitions related to os_dep/os_intfs.c
obsolete tracing.

Signed-off-by: Fabio Aiuto <fabioaiuto83@gmail.com>
---
 drivers/staging/rtl8723bs/include/rtw_debug.h | 5 +----
 drivers/staging/rtl8723bs/os_dep/os_intfs.c   | 2 --
 2 files changed, 1 insertion(+), 6 deletions(-)

diff --git a/drivers/staging/rtl8723bs/include/rtw_debug.h b/drivers/staging/rtl8723bs/include/rtw_debug.h
index 470edb0b655b..f7c2d9ac3a61 100644
--- a/drivers/staging/rtl8723bs/include/rtw_debug.h
+++ b/drivers/staging/rtl8723bs/include/rtw_debug.h
@@ -7,7 +7,6 @@
 #ifndef __RTW_DEBUG_H__
 #define __RTW_DEBUG_H__
 
-#define _module_os_intfs_c_			BIT(11)
 #define _module_rtl871x_security_c_		BIT(12)
 #define _module_rtl871x_eeprom_c_			BIT(13)
 #define _module_hal_init_c_		BIT(14)
@@ -32,9 +31,7 @@
 
 #undef _MODULE_DEFINE_
 
-#if defined _OS_INTFS_C_
-	#define	_MODULE_DEFINE_	_module_os_intfs_c_
-#elif defined _RTW_SECURITY_C_
+#if defined _RTW_SECURITY_C_
 	#define	_MODULE_DEFINE_	_module_rtl871x_security_c_
 #elif defined _RTW_EEPROM_C_
 	#define	_MODULE_DEFINE_	_module_rtl871x_eeprom_c_
diff --git a/drivers/staging/rtl8723bs/os_dep/os_intfs.c b/drivers/staging/rtl8723bs/os_dep/os_intfs.c
index 160f624612c7..6ac78a9ae615 100644
--- a/drivers/staging/rtl8723bs/os_dep/os_intfs.c
+++ b/drivers/staging/rtl8723bs/os_dep/os_intfs.c
@@ -4,8 +4,6 @@
  * Copyright(c) 2007 - 2011 Realtek Corporation. All rights reserved.
  *
  ******************************************************************************/
-#define _OS_INTFS_C_
-
 #include <drv_types.h>
 #include <rtw_debug.h>
 #include <hal_data.h>
-- 
2.20.1

