Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6A9F4369560
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Apr 2021 17:01:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243343AbhDWPA7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 23 Apr 2021 11:00:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48808 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243091AbhDWPAA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 23 Apr 2021 11:00:00 -0400
Received: from mail-wr1-x434.google.com (mail-wr1-x434.google.com [IPv6:2a00:1450:4864:20::434])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6C773C061756
        for <linux-kernel@vger.kernel.org>; Fri, 23 Apr 2021 07:59:22 -0700 (PDT)
Received: by mail-wr1-x434.google.com with SMTP id h4so39664472wrt.12
        for <linux-kernel@vger.kernel.org>; Fri, 23 Apr 2021 07:59:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=Juwe0Gjnc+rMihuOPa254C+qnQsP361xtVqHu6bwkD0=;
        b=cilC5YmEgJWBEcFSrGf/9kWUjXxhw49oiDoI3EjCtAmU2yChXbtjNmoQ6uMhNnR8Rq
         n3aLrpj/1oVi33nYg60ypuXLCgszNOofkfDhiu+t2a/9n1F7/Uy55lyp21fQcaCtnnS1
         OtG6vsJI/3v9ZJUHO+N0kHcXXZnSNTc7SbznsFVDW/Lrb92Zb9yVqgMLw13+XSL9DMhF
         mYopVWSdBftqRn4VMVFwA5Y5XzcFMXR7Ce/9wzl4kgG+obWINEFCJCCqv3uZ2cjqsF4N
         ORFQfa5hiJFI1rqTA+++4cma0u3Vv74e2r92lTTFy/F8fHuAZKoNKBYRepEItbcjJDbt
         LtWg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=Juwe0Gjnc+rMihuOPa254C+qnQsP361xtVqHu6bwkD0=;
        b=RBveUDEyt6LaBG2ZccfLNO0KfzpLXr6qsvXoirrSCLWrkhToUFSeYh43fDQEAhhvFZ
         ORbKVlSCGIJDrNPSQUSEFNiRnRPJliP+WVfZ/ogSn51NjuKw0Kt0rZVyO5XwESmKxHcH
         3BxU8r7gIevnC5BNqXt7Z35yhXwhJZSwh27hDRPKWqAM3JcWU0tQx+iFbhFDi/v6vwi6
         RwGMqkkekclOTNMZoYFBXPXbu2q2FWdAHmV5I02pr9s437czoqHwd/y/7lYls87szHqs
         8jbcgg2LmB58k0fVcJ8bD3vVBSZVchSuG9MINVChVKxyQPlGx8E7Xp76oGJGUPNHj0k5
         VCvQ==
X-Gm-Message-State: AOAM532UqYGsEMTMTIMNukZickC3wan/5Y7wpBrB87WzVqbsLuPcCIky
        oLSJ0lemXEGHkjDAHwB/1dvwahG6S2s=
X-Google-Smtp-Source: ABdhPJz9kh80zY5LPlC37x/Vv1IbCQwUqZ99lMGUtY3OmTk+nlgp25cntfeAJZzL5zlLbQmfTUZdNg==
X-Received: by 2002:a5d:47ad:: with SMTP id 13mr5342048wrb.56.1619189961030;
        Fri, 23 Apr 2021 07:59:21 -0700 (PDT)
Received: from agape ([5.171.72.99])
        by smtp.gmail.com with ESMTPSA id g1sm9301081wrd.69.2021.04.23.07.59.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 23 Apr 2021 07:59:20 -0700 (PDT)
From:   Fabio Aiuto <fabioaiuto83@gmail.com>
To:     gregkh@linuxfoundation.org
Cc:     linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: [PATCH 24/49] staging: rtl8723bs: remove debug macros related to core/rtw_io.c tracing
Date:   Fri, 23 Apr 2021 16:58:15 +0200
Message-Id: <fd1b76fc795bb0752ff0de0486f996148a3d0a72.1619189489.git.fabioaiuto83@gmail.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <cover.1619189489.git.fabioaiuto83@gmail.com>
References: <cover.1619189489.git.fabioaiuto83@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

remove debug macro definitions related to core/rtw_io.c
obsolete tracing.

Signed-off-by: Fabio Aiuto <fabioaiuto83@gmail.com>
---
 drivers/staging/rtl8723bs/core/rtw_io.c       | 2 --
 drivers/staging/rtl8723bs/include/rtw_debug.h | 5 +----
 2 files changed, 1 insertion(+), 6 deletions(-)

diff --git a/drivers/staging/rtl8723bs/core/rtw_io.c b/drivers/staging/rtl8723bs/core/rtw_io.c
index c860ab7d618c..ecbb679fbc16 100644
--- a/drivers/staging/rtl8723bs/core/rtw_io.c
+++ b/drivers/staging/rtl8723bs/core/rtw_io.c
@@ -25,8 +25,6 @@ jackson@realtek.com.tw
 
 */
 
-#define _RTW_IO_C_
-
 #include <drv_types.h>
 #include <rtw_debug.h>
 
diff --git a/drivers/staging/rtl8723bs/include/rtw_debug.h b/drivers/staging/rtl8723bs/include/rtw_debug.h
index 6e6dea4779d9..7206fdfbe12d 100644
--- a/drivers/staging/rtl8723bs/include/rtw_debug.h
+++ b/drivers/staging/rtl8723bs/include/rtw_debug.h
@@ -7,7 +7,6 @@
 #ifndef __RTW_DEBUG_H__
 #define __RTW_DEBUG_H__
 
-#define _module_rtl871x_io_c_				BIT(9)
 #define _module_io_osdep_c_		BIT(10)
 #define _module_os_intfs_c_			BIT(11)
 #define _module_rtl871x_security_c_		BIT(12)
@@ -34,9 +33,7 @@
 
 #undef _MODULE_DEFINE_
 
-#if defined _RTW_IO_C_
-	#define _MODULE_DEFINE_	_module_rtl871x_io_c_
-#elif defined _IO_OSDEP_C_
+#if defined _IO_OSDEP_C_
 	#define _MODULE_DEFINE_	_module_io_osdep_c_
 #elif defined _OS_INTFS_C_
 	#define	_MODULE_DEFINE_	_module_os_intfs_c_
-- 
2.20.1

