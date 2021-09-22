Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4B5CD415109
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Sep 2021 22:06:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237651AbhIVUH6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 22 Sep 2021 16:07:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50504 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237632AbhIVUHd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Sep 2021 16:07:33 -0400
Received: from mail-wr1-x435.google.com (mail-wr1-x435.google.com [IPv6:2a00:1450:4864:20::435])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 545AFC0613D3
        for <linux-kernel@vger.kernel.org>; Wed, 22 Sep 2021 13:05:50 -0700 (PDT)
Received: by mail-wr1-x435.google.com with SMTP id d21so10283654wra.12
        for <linux-kernel@vger.kernel.org>; Wed, 22 Sep 2021 13:05:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=h02ebF9jZHXus7OiG53g7IHFMhzwY9WpWKsUgRjOpGc=;
        b=Br+1p8l3gtJLYoNGQpSYGdovnlINhFz5cwseq1GTVAr9GhkHUmzJNJ/aCOBiqub+8o
         OtvfoFsalp+/fXRxfK0jRfzXc9+xYPs6HjmcR5CP4IatUjgrGx2+3lBw4k3rjVs6VIE7
         qxLPY3hdzcw7vrnpD5Nar6c1116zBg8ehe47A1CBhNR5AFmQ6PJYUqTFEttPnW0muN77
         qIJLRsF5mGw2thLluUaqMP1vrLyiB+sRcNfSQGabTWAYygfzI8l8AirH+o9Q/j2Yt46/
         xMvcIRkHCJ4t9509NbD/uc2/4w+JpcfZMWBT0WKAXv3NKE6w3HRg2zXi6A9tQTY5CVAe
         o9/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=h02ebF9jZHXus7OiG53g7IHFMhzwY9WpWKsUgRjOpGc=;
        b=OvSnrgj/8ukVFHPVX39cDaXpL0RoMNCE2JrJH8LQ/tsoOFwP7fa3paxbCENwgYdZf3
         4okI7mc5vUtzty4owXQLdXVCdZivKKJaU1n54X2vRdH520PqpnZf65kDk+1zgAR6tYOn
         oOGRIOIvN1JthsWT8K9eeOZTjivLhYQr7QvRXnD9Kb4o4UmFqd/9HeZfLGYvSD130RWe
         WbWqaRVHaC6Mj6r0krpcXUTBaArU/7HH42RICdUnL4WXTCPTV4E6ZDO+dTiV4K7HJrfQ
         vIonmHCOtWdkjsSGTi/d2fGUVfFo2S17ZqvjLRvNcbDbdBzr4s9/fdJBidnH/S1ZEedy
         LH+Q==
X-Gm-Message-State: AOAM533bTEdPbsvTcD0GXf6sqRYdjQ2A6hmdZUidNsBxdUTn//OLM3v0
        HDLms4Z93BwBI4QnX2WcTdk=
X-Google-Smtp-Source: ABdhPJzb/9yJP0bPTfIVD5ASzrBHmRQpZrZZq/vw+ijxmw+O6O1rujP/n8LyZbmmT46efSPNJZhupw==
X-Received: by 2002:a7b:c7c6:: with SMTP id z6mr12443599wmk.34.1632341148965;
        Wed, 22 Sep 2021 13:05:48 -0700 (PDT)
Received: from localhost.localdomain ([2a02:8108:96c0:3b88::cde])
        by smtp.gmail.com with ESMTPSA id e2sm3219761wra.40.2021.09.22.13.05.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 22 Sep 2021 13:05:48 -0700 (PDT)
From:   Michael Straube <straube.linux@gmail.com>
To:     gregkh@linuxfoundation.org
Cc:     Larry.Finger@lwfinger.net, phil@philpotter.co.uk,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org,
        Michael Straube <straube.linux@gmail.com>
Subject: [PATCH 25/47] staging: r8188eu: remove rtw_atoi()
Date:   Wed, 22 Sep 2021 22:03:58 +0200
Message-Id: <20210922200420.9693-26-straube.linux@gmail.com>
X-Mailer: git-send-email 2.33.0
In-Reply-To: <20210922200420.9693-1-straube.linux@gmail.com>
References: <20210922200420.9693-1-straube.linux@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Function rtw_atoi() is not used, remove it.

Signed-off-by: Michael Straube <straube.linux@gmail.com>
---
 drivers/staging/r8188eu/include/osdep_service.h |  2 --
 drivers/staging/r8188eu/os_dep/osdep_service.c  | 17 -----------------
 2 files changed, 19 deletions(-)

diff --git a/drivers/staging/r8188eu/include/osdep_service.h b/drivers/staging/r8188eu/include/osdep_service.h
index 86140ca3a115..b9b87f2317a1 100644
--- a/drivers/staging/r8188eu/include/osdep_service.h
+++ b/drivers/staging/r8188eu/include/osdep_service.h
@@ -155,8 +155,6 @@ s32  rtw_get_passing_time_ms(u32 start);
 
 void rtw_usleep_os(int us);
 
-u32  rtw_atoi(u8 *s);
-
 static inline unsigned char _cancel_timer_ex(struct timer_list *ptimer)
 {
 	return del_timer_sync(ptimer);
diff --git a/drivers/staging/r8188eu/os_dep/osdep_service.c b/drivers/staging/r8188eu/os_dep/osdep_service.c
index bee6d42b8738..489a7d33b212 100644
--- a/drivers/staging/r8188eu/os_dep/osdep_service.c
+++ b/drivers/staging/r8188eu/os_dep/osdep_service.c
@@ -19,23 +19,6 @@ inline int RTW_STATUS_CODE(int error_code)
 	return _FAIL;
 }
 
-u32 rtw_atoi(u8 *s)
-{
-	int num = 0, flag = 0;
-	int i;
-	for (i = 0; i <= strlen(s); i++) {
-		if (s[i] >= '0' && s[i] <= '9')
-			num = num * 10 + s[i] - '0';
-		else if (s[0] == '-' && i == 0)
-			flag = 1;
-		else
-			break;
-	}
-	if (flag == 1)
-		num = num * -1;
-	return num;
-}
-
 void *rtw_malloc2d(int h, int w, int size)
 {
 	int j;
-- 
2.33.0

