Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A77F436A053
	for <lists+linux-kernel@lfdr.de>; Sat, 24 Apr 2021 11:04:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237550AbhDXJEu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 24 Apr 2021 05:04:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58306 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237325AbhDXJDs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 24 Apr 2021 05:03:48 -0400
Received: from mail-wm1-x32e.google.com (mail-wm1-x32e.google.com [IPv6:2a00:1450:4864:20::32e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9FB89C061346
        for <linux-kernel@vger.kernel.org>; Sat, 24 Apr 2021 02:03:08 -0700 (PDT)
Received: by mail-wm1-x32e.google.com with SMTP id i21-20020a05600c3555b029012eae2af5d4so2420285wmq.4
        for <linux-kernel@vger.kernel.org>; Sat, 24 Apr 2021 02:03:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=YcuffsLTjuFNEp9yR3yPCxH/1v2srf0L4WVCdD7zdno=;
        b=CJ9mKAMpzy7MUH9uhgfTxXTlSCr+jWPT+/RS8UYrVxaFrtoGWas3/57aCvthmduj8Z
         F3fs2Y80I5qnx8Uenkou0srjSlZsgG6eED9UmBr4YYJF+sF8AMM924H9/mdyAM+S8Zpy
         yxBC/TPEHhoS20Lq8/KIurftk02qmSau5vnYU/nzYrWdM0vW8t2va399HW0Ezz4kF954
         ZcWp1nzOUD/FwlaqzlHF5+86b4VWJ/6/Eagj7NlzgfrWy8Dnszmbcj+tldaRdGx4APC7
         rE7/t5r/Y43sABwwu57ZbEsrgda1wB6+ln5hIccurU5g5Yva88MSW+kEo9Heho7e7I9g
         gKsA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=YcuffsLTjuFNEp9yR3yPCxH/1v2srf0L4WVCdD7zdno=;
        b=XCERi0wsZcbIx2y1zKXnytf2U5PyTA3CnrLTFEmafkXl7IgN4pUT5jqw5l8id1wgY+
         vl7wqw5ihXkmJAOioJ40xaCXA1akceVH13rscsOWPwJeoMba29m7cdp2IknDyjkKdvqQ
         f4ab7wIrwClItyCa0KLx+Xo1941yD6Fj58UGwqTlbw95MT/btA0B0jw7b0ngdLwhhk35
         Cjc3yYdpVgxz7CqiREkZvPI+Tqfp8B3k4uZx5Hib4UkBl28BLUDNOeZH1YmnqX4mSPSU
         5Hn8g0iYVoR4r1H6IktdQFDMN5QA8Gu46ZP7EHcUaNntBwwTvxNF8RCdtz9GbFP3QqeK
         ji2w==
X-Gm-Message-State: AOAM5328lCzcBd/PMslaeU6UYUsp/VAEB7BCZ6/3lwvu0bKrw3e8XT42
        nHmuh71P2wLPLSjuadXMs8LdMCd6pvRVSA==
X-Google-Smtp-Source: ABdhPJwGFooaZC7dZCtqbqYT9pIBFRzOUYNj9wwrtCHVtcshN+4CaLYhIJQPUg+hflxdlrwt//C4+w==
X-Received: by 2002:a7b:ce09:: with SMTP id m9mr8492947wmc.150.1619254987199;
        Sat, 24 Apr 2021 02:03:07 -0700 (PDT)
Received: from agape ([5.171.80.252])
        by smtp.gmail.com with ESMTPSA id i12sm12301839wrm.77.2021.04.24.02.03.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 24 Apr 2021 02:03:06 -0700 (PDT)
From:   Fabio Aiuto <fabioaiuto83@gmail.com>
To:     gregkh@linuxfoundation.org
Cc:     joe@perches.com, linux-staging@lists.linux.dev,
        linux-kernel@vger.kernel.org
Subject: [PATCH v2 19/50] staging: rtl8723bs: remove debug macros related to os_dep/mlme_linux.c tracing
Date:   Sat, 24 Apr 2021 11:02:02 +0200
Message-Id: <2528845d21764e95ab03d9245999b79acb2febd8.1619254603.git.fabioaiuto83@gmail.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <cover.1619254603.git.fabioaiuto83@gmail.com>
References: <cover.1619254603.git.fabioaiuto83@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

remove debug macro definitions related to os_dep/mlme_linux.c
obsolete tracing.

Signed-off-by: Fabio Aiuto <fabioaiuto83@gmail.com>
---
 drivers/staging/rtl8723bs/include/rtw_debug.h | 5 +----
 drivers/staging/rtl8723bs/os_dep/mlme_linux.c | 4 ----
 2 files changed, 1 insertion(+), 8 deletions(-)

diff --git a/drivers/staging/rtl8723bs/include/rtw_debug.h b/drivers/staging/rtl8723bs/include/rtw_debug.h
index 01d723268254..7f5b98578d60 100644
--- a/drivers/staging/rtl8723bs/include/rtw_debug.h
+++ b/drivers/staging/rtl8723bs/include/rtw_debug.h
@@ -7,7 +7,6 @@
 #ifndef __RTW_DEBUG_H__
 #define __RTW_DEBUG_H__
 
-#define _module_mlme_osdep_c_		BIT(5)
 #define _module_rtl871x_sta_mgt_c_		BIT(6)
 #define _module_rtl871x_cmd_c_			BIT(7)
 #define _module_cmd_osdep_c_		BIT(8)
@@ -38,9 +37,7 @@
 
 #undef _MODULE_DEFINE_
 
-#if defined _MLME_OSDEP_C_
-	#define _MODULE_DEFINE_	_module_mlme_osdep_c_
-#elif defined _RTW_MLME_EXT_C_
+#if defined _RTW_MLME_EXT_C_
 	#define _MODULE_DEFINE_ 1
 #elif defined _RTW_STA_MGT_C_
 	#define _MODULE_DEFINE_	_module_rtl871x_sta_mgt_c_
diff --git a/drivers/staging/rtl8723bs/os_dep/mlme_linux.c b/drivers/staging/rtl8723bs/os_dep/mlme_linux.c
index 0a16752f805b..a4560ba22db1 100644
--- a/drivers/staging/rtl8723bs/os_dep/mlme_linux.c
+++ b/drivers/staging/rtl8723bs/os_dep/mlme_linux.c
@@ -4,10 +4,6 @@
  * Copyright(c) 2007 - 2011 Realtek Corporation. All rights reserved.
  *
  ******************************************************************************/
-
-
-#define _MLME_OSDEP_C_
-
 #include <drv_types.h>
 #include <rtw_debug.h>
 
-- 
2.20.1

