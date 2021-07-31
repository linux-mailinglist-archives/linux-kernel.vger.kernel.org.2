Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 40CFB3DC208
	for <lists+linux-kernel@lfdr.de>; Sat, 31 Jul 2021 02:39:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234958AbhGaAjx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 30 Jul 2021 20:39:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53650 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234535AbhGaAjs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 30 Jul 2021 20:39:48 -0400
Received: from mail-wr1-x42b.google.com (mail-wr1-x42b.google.com [IPv6:2a00:1450:4864:20::42b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F3A39C0613C1
        for <linux-kernel@vger.kernel.org>; Fri, 30 Jul 2021 17:39:42 -0700 (PDT)
Received: by mail-wr1-x42b.google.com with SMTP id m12so8583016wru.12
        for <linux-kernel@vger.kernel.org>; Fri, 30 Jul 2021 17:39:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=philpotter-co-uk.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=1x7J72bz0//FnktNoXDcuPvaVh8FGIGtRtGljqXJxPI=;
        b=DV94T71R1HBU0cBgOCnceg7Kj/t/kTFeTTO8xBP6j8VySr3HTsEMZ3dNyikgLVxBmZ
         A76nYMWGJNqLhdEsln56jB/p19u5Du3IMEA1anqp/OQ5byLQPGm0pgYf6S3o/mEkwcKu
         6uV7lIvQsqqqZi+lg//hWSzharaqjpAidXTpiQEBVSa9psxnAnLTbi2WuizQ3TxHy+Bn
         szyBJnInI9TCXNLWiZ3Q02UCQSecHOR6lZCTusNMPTm2Y1WiVMBFHtv3YLX7D/SZcmsA
         WS8FB8Gd8gUzT19izzt60IXP0qdFK4Ozd3HbijzzMqu0nJ4gmTZFhN+ZETUhmS5kH+Wd
         St8g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=1x7J72bz0//FnktNoXDcuPvaVh8FGIGtRtGljqXJxPI=;
        b=ulPJj+WxNWHCAmTzI9VXgA/OAh1IxHdBmi3thlMtP1XxBvS2aF0YEbK9mXabVmo5CA
         UUMATfou665RveFUsmmZO5aPcPTkmjSgm5ICjy20c1PzcwIapzIfxxiNmOVkrjhVKUAV
         Z66KJYA/J1R62cIkhgbRUD76hxQIdnWswLMWnfb8uynW+nmOg3ZDOODC/t62hX2ydiq+
         dv999SYkWdcixE/YVUlWk9AeWhB7Q2QlEQD+jp5INyC+ErSLaJu+ycU1/FaG06FzTqw+
         UFfGBTyPZ6maXPADyT6Rbj40Wc9CGW+827ZzaDra1jDVRtkt55RsRZZdVwS3kTzKugDr
         TTqg==
X-Gm-Message-State: AOAM5338HZ1HyCLfEQkK1EIdJM99WQg5VeVUb4PdgfT+LX3JJHmS89GV
        gQU7fK8tFmArEHG3m7W1+VI2EQ==
X-Google-Smtp-Source: ABdhPJxg7c6sIqyUBMxj5AilCZYolQMpN91HTKL11x+vT/KGDeJTKwDl86NHVCMhS2r3+qaYi64uSg==
X-Received: by 2002:adf:f24f:: with SMTP id b15mr5733702wrp.22.1627691981633;
        Fri, 30 Jul 2021 17:39:41 -0700 (PDT)
Received: from localhost.localdomain (3.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.6.1.f.d.0.b.8.0.1.0.0.2.ip6.arpa. [2001:8b0:df16::3])
        by smtp.gmail.com with ESMTPSA id g138sm3829614wmg.32.2021.07.30.17.39.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 30 Jul 2021 17:39:41 -0700 (PDT)
From:   Phillip Potter <phil@philpotter.co.uk>
To:     gregkh@linuxfoundation.org
Cc:     Larry.Finger@lwfinger.net, linux-staging@lists.linux.dev,
        linux-kernel@vger.kernel.org
Subject: [PATCH 03/14 resent] staging: r8188eu: remove ODM_RT_ASSERT macro definition and caller
Date:   Sat, 31 Jul 2021 01:39:26 +0100
Message-Id: <20210731003937.68615-4-phil@philpotter.co.uk>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20210731003937.68615-1-phil@philpotter.co.uk>
References: <20210731003937.68615-1-phil@philpotter.co.uk>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Remove ODM_RT_ASSERT macro definition from include/odm_debug.h and
its one caller in hal/odm.c, as this debug code is against best
practice.

Signed-off-by: Phillip Potter <phil@philpotter.co.uk>
---
 drivers/staging/r8188eu/hal/odm.c           | 1 -
 drivers/staging/r8188eu/include/odm_debug.h | 9 ---------
 2 files changed, 10 deletions(-)

diff --git a/drivers/staging/r8188eu/hal/odm.c b/drivers/staging/r8188eu/hal/odm.c
index c6c184d95fee..fa3973393eda 100644
--- a/drivers/staging/r8188eu/hal/odm.c
+++ b/drivers/staging/r8188eu/hal/odm.c
@@ -1373,7 +1373,6 @@ bool ODM_RAStateCheck(struct odm_dm_struct *pDM_Odm, s32 RSSI, bool bForceUpdate
 		LowRSSIThreshForRA += GoUpGap;
 		break;
 	default:
-		ODM_RT_ASSERT(pDM_Odm, false, ("wrong rssi level setting %d !", *pRATRState));
 		break;
 	}
 
diff --git a/drivers/staging/r8188eu/include/odm_debug.h b/drivers/staging/r8188eu/include/odm_debug.h
index 73fdea598707..c11d8925952c 100644
--- a/drivers/staging/r8188eu/include/odm_debug.h
+++ b/drivers/staging/r8188eu/include/odm_debug.h
@@ -96,15 +96,6 @@
 		RT_PRINTK fmt;						\
 	}
 
-#define ODM_RT_ASSERT(pDM_Odm, expr, fmt)				\
-	if (!(expr)) {							\
-		DbgPrint( "Assertion failed! %s at ......\n", #expr);	\
-		DbgPrint( "      ......%s,%s,line=%d\n", __FILE__,	\
-			__func__, __LINE__);				\
-		RT_PRINTK fmt;						\
-		ASSERT(false);						\
-	}
-
 void ODM_InitDebugSetting(struct odm_dm_struct *pDM_Odm);
 
 #endif	/*  __ODM_DBG_H__ */
-- 
2.31.1

