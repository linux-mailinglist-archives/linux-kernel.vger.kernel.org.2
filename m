Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3753436A052
	for <lists+linux-kernel@lfdr.de>; Sat, 24 Apr 2021 11:04:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237607AbhDXJEr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 24 Apr 2021 05:04:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58322 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237279AbhDXJDp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 24 Apr 2021 05:03:45 -0400
Received: from mail-wm1-x329.google.com (mail-wm1-x329.google.com [IPv6:2a00:1450:4864:20::329])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E1B15C06138D
        for <linux-kernel@vger.kernel.org>; Sat, 24 Apr 2021 02:03:06 -0700 (PDT)
Received: by mail-wm1-x329.google.com with SMTP id i21-20020a05600c3555b029012eae2af5d4so2420259wmq.4
        for <linux-kernel@vger.kernel.org>; Sat, 24 Apr 2021 02:03:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=3ASz4YhECpEaBfGtt4tRNIDu5bRVVnAa9AjlX4YDm8o=;
        b=LPxgu7bhDiELB4WsWO/ieNEky3pMc+7pEi1t59pL2mwdt3Wint5nAdKffsE3CL8+yV
         K/aBDc0zyazDxo3uzRej1O5tKMDIGbd8d7gpBbUqg6DsxGYz1oY8VRN6/167IKX/qAxS
         UZ3hpgLdzGwgCTdvsfahj3t+j1BJwwFm6wPSRdzKu3/HORZ3ZrPBZP65pykhcqowf35C
         pMwHyYEGg2eFas2/Qc8g1U7NKdcaiKmDzvlyftvR02j6oyS3VS3EZ8OM8MBmnJqUPiXF
         xgDo/QPzUa/aXra1Ug3raT6+8gN6PMYR5I96u6LaKAXwqlxKeIwKQJvYRMsTCDOzMmMO
         R7AA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=3ASz4YhECpEaBfGtt4tRNIDu5bRVVnAa9AjlX4YDm8o=;
        b=uet6Mb6AM7EgrBpURRZPdjOfGTb9hueGSQfRmA132w7QnydpQBYMgNHTFyuZURPdB8
         BEt+p1Gn3tY7NXzzisxt3UU2RJQxG82u80y2GV3xoseZW97bMliwry7d6T/QMydQQeuc
         tOIQPEASyLpS6FxOIApbDN0uYrhWzZtl2ug9VT1EwEKrxBfMOFsuLtwpI8nceRyyb18M
         bOwZAKaMsPpmxRHjOUvGJEiKOXjOUxJumW8qX+KnFuqSlNMdTTdDnVbx0neswyEh6ApP
         8DFoQx+Qp0dFI6fdF4KENYcT/yoKI9JDkEO0kn/hiee9sn6wvvguFeRXEcn5a4Ur20go
         +QFg==
X-Gm-Message-State: AOAM530Gma2VZ4PU3QsbYkn0hO3EAELq9kPLVJ9djKVTthLwUAZ3qUlU
        CV85mGAbZ25fcr8+ahwhkRvpb3ERMcJoDw==
X-Google-Smtp-Source: ABdhPJyRrs7euprLh77navZiBeZ9Ipywb7F74qS0CpaXnR2tay2CZ3hm0E1qd3/RxwdYm/ri+UfVAg==
X-Received: by 2002:a05:600c:350b:: with SMTP id h11mr9749226wmq.103.1619254985358;
        Sat, 24 Apr 2021 02:03:05 -0700 (PDT)
Received: from agape ([5.171.80.252])
        by smtp.gmail.com with ESMTPSA id v185sm10526923wmb.25.2021.04.24.02.03.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 24 Apr 2021 02:03:05 -0700 (PDT)
From:   Fabio Aiuto <fabioaiuto83@gmail.com>
To:     gregkh@linuxfoundation.org
Cc:     joe@perches.com, linux-staging@lists.linux.dev,
        linux-kernel@vger.kernel.org
Subject: [PATCH v2 18/50] staging: rtl8723bs: remove debug macros related to core/rtw_mlme.c tracing
Date:   Sat, 24 Apr 2021 11:02:01 +0200
Message-Id: <5ab63de74186fb9e8f90ffed9d7557b3e2d4caed.1619254603.git.fabioaiuto83@gmail.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <cover.1619254603.git.fabioaiuto83@gmail.com>
References: <cover.1619254603.git.fabioaiuto83@gmail.com>
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

