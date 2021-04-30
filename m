Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 309A536F686
	for <lists+linux-kernel@lfdr.de>; Fri, 30 Apr 2021 09:45:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231326AbhD3HpW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 30 Apr 2021 03:45:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41982 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231145AbhD3HpG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 30 Apr 2021 03:45:06 -0400
Received: from mail-ed1-x52b.google.com (mail-ed1-x52b.google.com [IPv6:2a00:1450:4864:20::52b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 02F1DC06138E
        for <linux-kernel@vger.kernel.org>; Fri, 30 Apr 2021 00:44:18 -0700 (PDT)
Received: by mail-ed1-x52b.google.com with SMTP id c22so17864937edn.7
        for <linux-kernel@vger.kernel.org>; Fri, 30 Apr 2021 00:44:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=To5Vs4KwxhQBIQUiXfT+kEa1NbW/RrIHm/UCYNTGQs4=;
        b=MdREbTr7OPdVCn+5up/v1N3oaL9ScsRrcwtAtxHbFKhYl92qDmuJQQSMIpz6gwdiFD
         /fpWJz1RJANSijMaVC4CRuq3QT2Y7ZXSgw5HKCQ3mJll+L4iM3CCeo6KLev5EmnWWh5i
         ER4yW7WxHWc0RX7v2MbAKAdXaQ81JmEL/0cknsNBosEIh0iIfV6baFm3oBSsXkxBEIDV
         JFU+yj8NCVArmsm1s9pnLkGPaCUUKESFUsTzCzBuraT5F/wzD8gwrfOlFzey4mpb+eL2
         BmtEiezRrUlfbwYKWxjcw4mtb4OOJ2iY9pr5LU9ervCxQJWg86t2pfo6oBOfuP1EpT5T
         1NyA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=To5Vs4KwxhQBIQUiXfT+kEa1NbW/RrIHm/UCYNTGQs4=;
        b=kB7ZP295c5rTBj2S9OR6mn3OU3JFh/Ss7yXjG7BOUBHn2Z+YysEUM8S9bKggukoJJW
         O8QB0HFrIHdfMYKBdCAmDXz4Hc9bjQ0Vr4PzyOokp1PH4qU1a3V3WJIsGy5ThJIcgOk1
         aykseSgsB2ug0Vbor15K2uhX8KAlp2WDIxGMeNDEtO2v1p3PmpbiCpxPlGNJ/UM9DeOs
         G7iSZxR68W6mqZKCp06oLRN1rKYpI2HDkecnnDSZDYbRddxyTRNU3p8aWDeNTgaey3NZ
         5Rm4afjFWC77n+8H2Ve0MXjrg5KkZC5xQabGFq79kr6LaAudbgoH0kPRAvFi8fmtfg12
         VhZA==
X-Gm-Message-State: AOAM533BvVwYGJq6u8GoarD3j1yTVktQ6eMnOqrZkRlNujbYkrnMEUhN
        COZudKAYQKpTkEvSGiSPlulaKj6iqsEINg==
X-Google-Smtp-Source: ABdhPJwyLcQf+LrVh/AemCcpVgp30CEQiz13hujARAJfo6ChhFBKu6RGnveri53YL9GIpiivOU9l0w==
X-Received: by 2002:a05:6402:26d3:: with SMTP id x19mr4114763edd.349.1619768656479;
        Fri, 30 Apr 2021 00:44:16 -0700 (PDT)
Received: from agape ([5.171.81.86])
        by smtp.gmail.com with ESMTPSA id p18sm1412702ejb.19.2021.04.30.00.44.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 30 Apr 2021 00:44:16 -0700 (PDT)
From:   Fabio Aiuto <fabioaiuto83@gmail.com>
To:     gregkh@linuxfoundation.org
Cc:     linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: [PATCH 07/43] staging: rtl8723bs: remove ODM_RT_TRACE* unused macro defs
Date:   Fri, 30 Apr 2021 09:43:25 +0200
Message-Id: <a899c4c389c2355b8867503739e970ac107a98cb.1619768150.git.fabioaiuto83@gmail.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <cover.1619768150.git.fabioaiuto83@gmail.com>
References: <cover.1619768150.git.fabioaiuto83@gmail.com>
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

