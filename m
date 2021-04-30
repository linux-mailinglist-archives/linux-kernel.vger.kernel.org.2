Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 215CB36FCB1
	for <lists+linux-kernel@lfdr.de>; Fri, 30 Apr 2021 16:50:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233422AbhD3Op1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 30 Apr 2021 10:45:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50604 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233134AbhD3OpP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 30 Apr 2021 10:45:15 -0400
Received: from mail-ed1-x52b.google.com (mail-ed1-x52b.google.com [IPv6:2a00:1450:4864:20::52b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DC778C06138B
        for <linux-kernel@vger.kernel.org>; Fri, 30 Apr 2021 07:44:26 -0700 (PDT)
Received: by mail-ed1-x52b.google.com with SMTP id c22so19287440edn.7
        for <linux-kernel@vger.kernel.org>; Fri, 30 Apr 2021 07:44:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=To5Vs4KwxhQBIQUiXfT+kEa1NbW/RrIHm/UCYNTGQs4=;
        b=d3GVzqh3cIJ2kTDbiFmWkIxu0xae8TF50ikxxDLwKh20iUeyObjynelbULg/cNaGg/
         iFjbvcDpaN0jkSXYte0or8ZMVdZCYuftG0Hw7FMcADdyZ7KwuXhwmqBXP98on09Qxgrl
         HOsHIp71figOvAnRwRRCc6jVzV9AwyxVW10PH1WF4LaokpwzaSH4z0GrMkTNsEBnSxm0
         tIyt98mhsocFiqaY6A/TAie5CDM0TcLnFqvo3CjkjkRdbvGKT3DOb/gF18nNtSbTxW2R
         EJcHaDf/KzxB5axT2FjHmXXMzgdH6xMsZIkB3dXDnn8gSFkEqi63cAc2wEpqstxaV79U
         q3ig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=To5Vs4KwxhQBIQUiXfT+kEa1NbW/RrIHm/UCYNTGQs4=;
        b=Yb1/nhzuT480gRCeCjohMQRsYVeW8QEtMsgh2WaR/BLsNijgVVLO+CZdrwRdqm2Poj
         tIkGCsh+le3sNKf+Z4jvvZdVVlq7T4JlyVOObNsf5Pzsac8mfGvtSfEO8r29aKscHSm1
         TPQd68vfPv07lJNVnO+/sjAdJlFXe8cAVMu26VPUENMVp/kZhGSJJOw9RFjgdjk0jvXN
         kIa2Zslxhb7eTwd2K9Oqt1ooZfE4udIgfMprnjh586uGORzo0HV97GGccjBOND1TJbv2
         vfiUgsmWsvOsRNsGvVlpRxSAUEWAZ3cX6XLmALu6lUEjvs3YCeMMbIJUA1/zVhneXA8/
         R6Ew==
X-Gm-Message-State: AOAM531XJDSUoYd37ImcPhr+UtuVMfWwy1NBo6xjzMqzSNzSmXOILK/d
        cDlAWgR6JIMhKQnlz08X0U7e6epBlUc=
X-Google-Smtp-Source: ABdhPJz1Rfs7uU1+aRUA3Nj7Mijwp2I2I6Hx3L+G+bdFHtuu1Wj85wJZBKoETBhbF3J6GKPYanUQQw==
X-Received: by 2002:aa7:d513:: with SMTP id y19mr6287666edq.9.1619793865431;
        Fri, 30 Apr 2021 07:44:25 -0700 (PDT)
Received: from agape ([109.52.244.36])
        by smtp.gmail.com with ESMTPSA id w1sm1487670edt.89.2021.04.30.07.44.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 30 Apr 2021 07:44:25 -0700 (PDT)
From:   Fabio Aiuto <fabioaiuto83@gmail.com>
To:     gregkh@linuxfoundation.org
Cc:     linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: [PATCH v2 07/43] staging: rtl8723bs: remove ODM_RT_TRACE* unused macro defs
Date:   Fri, 30 Apr 2021 16:43:37 +0200
Message-Id: <c3e116d07fadbba86e61eafe77dd5f3faae66c26.1619793405.git.fabioaiuto83@gmail.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <cover.1619793405.git.fabioaiuto83@gmail.com>
References: <cover.1619793405.git.fabioaiuto83@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

remove unused ODM_RT_TRACE* macro defs.

Signed-off-by: Fabio Aiuto <fabioaiuto83@gmail.com>
---
 drivers/staging/rtl8723bs/hal/odm_debug.h | 23 -----------------------
 1 file changed, 23 deletions(-)

diff --git a/drivers/staging/rtl8723bs/hal/odm_debug.h b/drivers/staging/rtl8723bs/hal/odm_debug.h
index be0d4c49a747..09e8bfec7664 100644
--- a/drivers/staging/rtl8723bs/hal/odm_debug.h
+++ b/drivers/staging/rtl8723bs/hal/odm_debug.h
@@ -96,27 +96,6 @@
 #endif
 
 #if DBG
-#define ODM_RT_TRACE(pDM_Odm, comp, level, fmt)\
-	do {\
-		if (\
-			(comp & pDM_Odm->DebugComponents) &&\
-			(level <= pDM_Odm->DebugLevel ||\
-			 level == ODM_DBG_SERIOUS)\
-		) {\
-			RT_PRINTK fmt;\
-		} \
-	} while (0)
-
-#define ODM_RT_TRACE_F(pDM_Odm, comp, level, fmt)\
-	do {\
-		if (\
-			(comp & pDM_Odm->DebugComponents) &&\
-			(level <= pDM_Odm->DebugLevel)\
-		) {\
-			RT_PRINTK fmt;\
-		} \
-	} while (0)
-
 #define ODM_RT_ASSERT(pDM_Odm, expr, fmt)\
 	do {\
 		if (!expr) {\
@@ -150,8 +129,6 @@
 		} \
 	} while (0)
 #else
-#define ODM_RT_TRACE(pDM_Odm, comp, level, fmt)		no_printk fmt
-#define ODM_RT_TRACE_F(pDM_Odm, comp, level, fmt)	no_printk fmt
 #define ODM_RT_ASSERT(pDM_Odm, expr, fmt)		no_printk fmt
 #define ODM_dbg_enter()					do {} while (0)
 #define ODM_dbg_exit()					do {} while (0)
-- 
2.20.1

