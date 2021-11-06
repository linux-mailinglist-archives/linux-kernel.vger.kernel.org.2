Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 523F64470F1
	for <lists+linux-kernel@lfdr.de>; Sun,  7 Nov 2021 00:18:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234635AbhKFXTZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 6 Nov 2021 19:19:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34528 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231176AbhKFXTW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 6 Nov 2021 19:19:22 -0400
Received: from mail-wr1-x432.google.com (mail-wr1-x432.google.com [IPv6:2a00:1450:4864:20::432])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1907CC061570
        for <linux-kernel@vger.kernel.org>; Sat,  6 Nov 2021 16:16:41 -0700 (PDT)
Received: by mail-wr1-x432.google.com with SMTP id r8so19776010wra.7
        for <linux-kernel@vger.kernel.org>; Sat, 06 Nov 2021 16:16:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=philpotter-co-uk.20210112.gappssmtp.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=IZ/mVLnVEjcxSgetrmyGMYqsYZyZaCCXV6KwPJ0Xu2s=;
        b=RkqL8VMOgBhResrdZPpHrKB3aNjdst8n+rhc7Dv6QdsNNiwglICXJzRqfuxY0yp9EN
         duORt1qV5ebIpDxwS9gpdlaI7YG2RMXX8o+BKKXJu4hfc+rZoOc3GBvX64LNTHRyWC67
         Iym1sqE/95FRJGbmkknoqTCh9Qv4E9bmfOUCP/9GpkVaFDTWeDnlOadd3g1+Fyq2KNJa
         PC9TCpfrZ5pgPSIgW0gACFvrYhbC6ZLd8F5fcpNKaGmAsy5h5NflnhovcxSbLW65qSNA
         RPWAXbCDupTRix68ASj+7LI5RDe317s/kvjN5Ef5RKP1J0xJYZ/fC5v46IJJOpy6XA/w
         LlOw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=IZ/mVLnVEjcxSgetrmyGMYqsYZyZaCCXV6KwPJ0Xu2s=;
        b=jlbk5Vz6QAaYiz0TZw9eCmMSsVfdYJ6DI1dJCpGx54oU69gj0Ci71qJi8xi5vYzI69
         smDjTALkTrAMkMhSfSHSUg2MeUP5s++gpSwn3wf4tDRHQ7XGjrb6hdu5fBQGPx1nif9G
         1nsOqfqF1SfTMzjT36emncFoUnGCuw/UGCiIOsct3/iL0+r4RJk7zcOO//s1wzO0HWME
         9YpbrTE6le6RZ9Jm+STExvYzTMxOwj8oJnht4yiLc1mPRS+jfRfeoyr4zld34S1wf5dv
         rsms/QHxm1L3I1kFL2khqRet1jnZCYxrCAZro6B6RhHklvG51cyg5/GUbemBKgrODsur
         DhvQ==
X-Gm-Message-State: AOAM531WWRwhQWFM/oYOh/b72cBQtc3I4V8UM6Q/1EXlH1nHk8Q1FrGy
        32RWFfmb25j9xxeEaL+6GHMrnw==
X-Google-Smtp-Source: ABdhPJzzTMAz+XqQ3CuJCZFA0d5RS+rno4KgaxH2kXOJ+4jFW3qdhJjNFP+Sj/m7CQk+yBWtI97heQ==
X-Received: by 2002:a5d:61ca:: with SMTP id q10mr69651962wrv.102.1636240599736;
        Sat, 06 Nov 2021 16:16:39 -0700 (PDT)
Received: from localhost.localdomain (3.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.6.1.f.d.0.b.8.0.1.0.0.2.ip6.arpa. [2001:8b0:df16::3])
        by smtp.gmail.com with ESMTPSA id 4sm16320389wrz.90.2021.11.06.16.16.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 06 Nov 2021 16:16:39 -0700 (PDT)
From:   Phillip Potter <phil@philpotter.co.uk>
To:     gregkh@linuxfoundation.org
Cc:     Larry.Finger@lwfinger.net, straube.linux@gmail.com,
        martin@kaiser.cx, fmdefrancesco@gmail.com,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org,
        dan.carpenter@oracle.com
Subject: [PATCH 2/2] staging: r8188eu: remove MSG_88E macro
Date:   Sat,  6 Nov 2021 23:16:36 +0000
Message-Id: <20211106231636.894-3-phil@philpotter.co.uk>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20211106231636.894-1-phil@philpotter.co.uk>
References: <20211106231636.894-1-phil@philpotter.co.uk>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Remove MSG_88E macro from include/rtw_debug.h, as it no longer has any
callers within the driver.

Signed-off-by: Phillip Potter <phil@philpotter.co.uk>
---
 drivers/staging/r8188eu/include/rtw_debug.h | 6 ------
 1 file changed, 6 deletions(-)

diff --git a/drivers/staging/r8188eu/include/rtw_debug.h b/drivers/staging/r8188eu/include/rtw_debug.h
index 0a77e3e73a45..39b69b9ad0a3 100644
--- a/drivers/staging/r8188eu/include/rtw_debug.h
+++ b/drivers/staging/r8188eu/include/rtw_debug.h
@@ -66,10 +66,4 @@ extern u32 GlobalDebugLevel;
 			pr_info(DRIVER_PREFIX __VA_ARGS__);		\
 	} while (0)
 
-#define MSG_88E(...)							\
-	do {								\
-		if (_drv_err_ <= GlobalDebugLevel)			\
-			pr_info(DRIVER_PREFIX __VA_ARGS__);			\
-	} while (0)
-
 #endif	/* __RTW_DEBUG_H__ */
-- 
2.31.1

