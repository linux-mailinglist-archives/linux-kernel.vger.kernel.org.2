Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7A65036FD00
	for <lists+linux-kernel@lfdr.de>; Fri, 30 Apr 2021 17:05:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230128AbhD3O6W (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 30 Apr 2021 10:58:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53504 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230167AbhD3O6I (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 30 Apr 2021 10:58:08 -0400
Received: from mail-ed1-x529.google.com (mail-ed1-x529.google.com [IPv6:2a00:1450:4864:20::529])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 01A92C06174A
        for <linux-kernel@vger.kernel.org>; Fri, 30 Apr 2021 07:57:20 -0700 (PDT)
Received: by mail-ed1-x529.google.com with SMTP id y26so3353505eds.4
        for <linux-kernel@vger.kernel.org>; Fri, 30 Apr 2021 07:57:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=To5Vs4KwxhQBIQUiXfT+kEa1NbW/RrIHm/UCYNTGQs4=;
        b=FkW2n5uhRVS/tbvwwiD8+p/OMOIVy0D0hwSVIFuuzueBZfBLWbIDJvrVq/SUOztFIj
         bVRwXAap3Li/3uq9pPcSuwUXQevRCvJvs8NxeHC4+LWEZioFOZ29Qy0B9W9kfy5HoDiC
         3Uk8HzVIhCKtKSFAZ6Uk1RjEG5DPsejS6zVtZ1VWafrOXuSPTDWnVfJ9CFqXn+LQBDT1
         CVet7VlAy32dKOyRGkuFKawpII1TM/BbhO4LYakcI2mhgNcUeCDHEzDiqgkVpLvj9vzz
         +R/poNaF1z+D0lAFzcLdj8R7oxLpIsTXWRuVgDKBS0kfWKB9dQMB5JhW9r1bJPtyhjfk
         NPeg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=To5Vs4KwxhQBIQUiXfT+kEa1NbW/RrIHm/UCYNTGQs4=;
        b=DBlJ4nlbSWLHDzaqUqYiHKyufKfPvrcK57ZgzjsuyigS0xdXhzqNpUDqfzrv1qyyAh
         rurYXOHNUdkhAvXXZff5HY1orxxR7dgwsrTQD8enJvbZrdFAfBQ5k4SI3Js4K83vKd7C
         82rvPkQeQ5jJZp257iHKqMSaSBFMd5b9uH76BpApX3rkdhMsGQO7nymawD6Q6XaFi75+
         QdQHh+bue75BsmXXKPescvXRCbhUtqKQWI1mJ6Xpvqm5LkDaMUa9XOJhesKPC5wohcvO
         nzhqwjASuPgfdd6F7vL8KojX/S8LjuTpR500nrAAA/yeu8tdT7A4uzUO/rDbAxFm6HQA
         NyOw==
X-Gm-Message-State: AOAM530HBDg4WVGrnjpOX/Mzag/iZUM/YM8uJhhOpTBiF8KyVbkTXqIx
        FHsqAR4j7pDw2XcLb1xCkCpMBzR2KxE=
X-Google-Smtp-Source: ABdhPJxczERZnNHtsul7hOhkaQLuitz+UTPnft/C3X1DL0/21XZlcjrynzOgzmLId6+KXKdP05mKsw==
X-Received: by 2002:aa7:c412:: with SMTP id j18mr6505470edq.163.1619794638510;
        Fri, 30 Apr 2021 07:57:18 -0700 (PDT)
Received: from agape ([109.52.244.36])
        by smtp.gmail.com with ESMTPSA id m2sm1529162edc.10.2021.04.30.07.57.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 30 Apr 2021 07:57:18 -0700 (PDT)
From:   Fabio Aiuto <fabioaiuto83@gmail.com>
To:     gregkh@linuxfoundation.org
Cc:     linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: [PATCH v3 07/43] staging: rtl8723bs: remove ODM_RT_TRACE* unused macro defs
Date:   Fri, 30 Apr 2021 16:56:29 +0200
Message-Id: <f0feec848702a12594bb67acceb42f4be647088e.1619794331.git.fabioaiuto83@gmail.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <cover.1619794331.git.fabioaiuto83@gmail.com>
References: <cover.1619794331.git.fabioaiuto83@gmail.com>
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

