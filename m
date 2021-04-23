Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BACB4369553
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Apr 2021 16:59:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243192AbhDWPAS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 23 Apr 2021 11:00:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48696 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242999AbhDWO7s (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 23 Apr 2021 10:59:48 -0400
Received: from mail-wm1-x331.google.com (mail-wm1-x331.google.com [IPv6:2a00:1450:4864:20::331])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 52056C06138B
        for <linux-kernel@vger.kernel.org>; Fri, 23 Apr 2021 07:59:11 -0700 (PDT)
Received: by mail-wm1-x331.google.com with SMTP id d200-20020a1c1dd10000b02901384767d4a5so1397337wmd.3
        for <linux-kernel@vger.kernel.org>; Fri, 23 Apr 2021 07:59:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=3ASz4YhECpEaBfGtt4tRNIDu5bRVVnAa9AjlX4YDm8o=;
        b=j8ixrypmhFUbl3uQWnYCR/9g08NrSdnaS9mMtRmwJStnJ13S6tWfZZtTih/HCY/qns
         3RraMknghvBTfesK+aXVebpkG1MmSyFpUNlWNnE4byqK6icef0z/hNoLNOZmiRkz+Arw
         Vmz2O07Nfgg8S47OjhjUGoDYi3lMFDcmun6Z1Hmro7f/fOQZWWxrXgPShwMH9c2JWVHG
         3mmCqTQ/8OU5gq4r9s46ZpUPuoN9ZgBsybt8ANFfhzODRsUVJwmWZ+8k+0Py1cJ8E8vh
         10R3Sv50++/y30PEVp5FmAQHbQtO98OVfMl+AnHBgh6QVJOxa4bl5QfQ8kRjnES53p6I
         RzrQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=3ASz4YhECpEaBfGtt4tRNIDu5bRVVnAa9AjlX4YDm8o=;
        b=kfmB5Cv30+d49hN5CxGmeYwOumX8plaR/3gqpb6nDA7/XkKuOC1u1u3j8bb44DrWM6
         UdbEapE3Adk9nk+0rRl/iatHK5dMuKmygKiYj30QPPS/KSOTBGs3dTjP5hxRh0Q2Esdb
         scsFmVlXjGt6bT8BIMB5pRCqKOs3MEm9vFYf3O4SGcunkSJhXhXy+9ubm6sAK8tph9Ge
         FyXMXtpyYUtgZfI8aMBICgQxtfevTQcrLY73uoj2nN9iQvM/P1cziW5VLKNjkl/5kM+d
         YckfVGKv2LHRcnEjuLHJ1nn0m04n89sqamFJIxhct4TkGoaOng0voEjbq79h3OFXVq/A
         e5LQ==
X-Gm-Message-State: AOAM532/Z/tjoECDsHeyRcUSp6aiZMJclYySAUwJnxjEMx7gj0jRoP53
        MCefb704BtYl9jmvZ6DaXcESSRq4ZIA=
X-Google-Smtp-Source: ABdhPJyd7QIqAGfJX0cCaDqlP6IdYLJjfiP/T9LLNsQzPfV8S9k+EK4I7a84K7AcxyoNeZ/UHt6jhQ==
X-Received: by 2002:a05:600c:3544:: with SMTP id i4mr4601542wmq.38.1619189949941;
        Fri, 23 Apr 2021 07:59:09 -0700 (PDT)
Received: from agape ([5.171.72.99])
        by smtp.gmail.com with ESMTPSA id b12sm37942782wmj.1.2021.04.23.07.59.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 23 Apr 2021 07:59:09 -0700 (PDT)
From:   Fabio Aiuto <fabioaiuto83@gmail.com>
To:     gregkh@linuxfoundation.org
Cc:     linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: [PATCH 17/49] staging: rtl8723bs: remove debug macros related to core/rtw_mlme.c tracing
Date:   Fri, 23 Apr 2021 16:58:08 +0200
Message-Id: <dcb7fe18b687fe809cf77265046ab85789c3e019.1619189489.git.fabioaiuto83@gmail.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <cover.1619189489.git.fabioaiuto83@gmail.com>
References: <cover.1619189489.git.fabioaiuto83@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

remove debug macro definitions related to core/rtw_mlme.c
obsolete tracing.

Signed-off-by: Fabio Aiuto <fabioaiuto83@gmail.com>
---
 drivers/staging/rtl8723bs/core/rtw_mlme.c     | 2 --
 drivers/staging/rtl8723bs/include/rtw_debug.h | 5 +----
 2 files changed, 1 insertion(+), 6 deletions(-)

diff --git a/drivers/staging/rtl8723bs/core/rtw_mlme.c b/drivers/staging/rtl8723bs/core/rtw_mlme.c
index 4707dba90397..569943a09848 100644
--- a/drivers/staging/rtl8723bs/core/rtw_mlme.c
+++ b/drivers/staging/rtl8723bs/core/rtw_mlme.c
@@ -4,8 +4,6 @@
  * Copyright(c) 2007 - 2011 Realtek Corporation. All rights reserved.
  *
  ******************************************************************************/
-#define _RTW_MLME_C_
-
 #include <linux/etherdevice.h>
 #include <drv_types.h>
 #include <rtw_debug.h>
diff --git a/drivers/staging/rtl8723bs/include/rtw_debug.h b/drivers/staging/rtl8723bs/include/rtw_debug.h
index d04f116bc9a4..01d723268254 100644
--- a/drivers/staging/rtl8723bs/include/rtw_debug.h
+++ b/drivers/staging/rtl8723bs/include/rtw_debug.h
@@ -7,7 +7,6 @@
 #ifndef __RTW_DEBUG_H__
 #define __RTW_DEBUG_H__
 
-#define _module_rtl871x_mlme_c_		BIT(4)
 #define _module_mlme_osdep_c_		BIT(5)
 #define _module_rtl871x_sta_mgt_c_		BIT(6)
 #define _module_rtl871x_cmd_c_			BIT(7)
@@ -39,9 +38,7 @@
 
 #undef _MODULE_DEFINE_
 
-#if defined _RTW_MLME_C_
-	#define _MODULE_DEFINE_	_module_rtl871x_mlme_c_
-#elif defined _MLME_OSDEP_C_
+#if defined _MLME_OSDEP_C_
 	#define _MODULE_DEFINE_	_module_mlme_osdep_c_
 #elif defined _RTW_MLME_EXT_C_
 	#define _MODULE_DEFINE_ 1
-- 
2.20.1

