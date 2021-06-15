Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 174513A72F2
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Jun 2021 02:18:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232004AbhFOAUj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 14 Jun 2021 20:20:39 -0400
Received: from mail-qk1-f180.google.com ([209.85.222.180]:33551 "EHLO
        mail-qk1-f180.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230233AbhFOAUh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Jun 2021 20:20:37 -0400
Received: by mail-qk1-f180.google.com with SMTP id c9so13986242qkm.0
        for <linux-kernel@vger.kernel.org>; Mon, 14 Jun 2021 17:18:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=philpotter-co-uk.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=GHijSFisswyE68RaJCvcX+69ZFWMyHRiaE4D9hGGu9w=;
        b=r5SiADkncDP/kK0m4mDI+9wRgNC0f0L4Oyq8O1+8B/oO9ZVqN9P0HbH4nAfEauXbrs
         5aVaB7DgwexYaw8Wd0ljkCayhCiuuuHATmRP7zK/9xtBITcY2VxGj3RWqZVXymC4CBsp
         q0g4Usym3tCl4M4UcpHRxJJlB2ktKCbnSWy9guk2scYNCoGS0hwKSjIvcHUhoOot1wGX
         SGiq9f4psjDA6DOH0d7+yLN8nPVpMwCZbcphWBsxuP+SQXjVqPd4AJZejljeM1m2d7U2
         UZrOvR1iZsNmDR/zRrV28hzFFkPUt5P207Uxn3f/ty6/lzFFUOx/iPKiv7gDNg8j4WMk
         4GNQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=GHijSFisswyE68RaJCvcX+69ZFWMyHRiaE4D9hGGu9w=;
        b=DgazOPokve1yMk0fu33469329+PVZuKokH5RmqDEMMw3ZDfku+Q4zkWKQS/h9Lm0u+
         g0iHVdHQEXPoOmv4Dr+Q9Rplki4BfaP0f49NSjAFRC3JBJ/mLpEhMacqqU+jdI8N09nA
         BkRw/VQY2qPicM9tUXA5zV3Ptp345yHeFRXohjIphtMJOa6SNXsiudmOQ9R6p12hMYP/
         rc7mgJibEO4bo4I8w/GJwga/esEJtx//lI0IDBGIwkakxHfyMiv4qGN6wSPuJ2L6SfYu
         bAcYSGspQ++C1B4QXkUMu3al0c00/lVEBO2tT7PIDKas2mQ+Yo0L3ByvBfEheIJBHX5+
         EyiA==
X-Gm-Message-State: AOAM532iVwHa4F7Z0/0BnqOeSjxvWwcTBgN5RmXmxD3K5RKDjMvR+N3k
        puf4AJ9AE8887fDIuRyn8KUgyw==
X-Google-Smtp-Source: ABdhPJxbV1I4j3CQeEIE0YZIe8tGn5g06qV/OYfEXQzM2jm52fkZYCjgpZOqEqgS5msJF+SUx+cGpQ==
X-Received: by 2002:a05:620a:29d3:: with SMTP id s19mr4440667qkp.434.1623716239127;
        Mon, 14 Jun 2021 17:17:19 -0700 (PDT)
Received: from localhost.localdomain (5.d.e.a.c.b.a.1.5.0.9.4.d.7.7.d.0.a.1.e.e.d.f.d.0.b.8.0.1.0.0.2.ip6.arpa. [2001:8b0:dfde:e1a0:d77d:4905:1abc:aed5])
        by smtp.gmail.com with ESMTPSA id m199sm11244248qke.71.2021.06.14.17.17.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 14 Jun 2021 17:17:18 -0700 (PDT)
From:   Phillip Potter <phil@philpotter.co.uk>
To:     gregkh@linuxfoundation.org
Cc:     Larry.Finger@lwfinger.net, dan.carpenter@oracle.com,
        linux-kernel@vger.kernel.org, linux-staging@lists.linux.dev
Subject: [PATCH 28/28] staging: rtl8188eu: remove DBG_88E macro definition
Date:   Tue, 15 Jun 2021 01:15:07 +0100
Message-Id: <20210615001507.1171-29-phil@philpotter.co.uk>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20210615001507.1171-1-phil@philpotter.co.uk>
References: <20210615001507.1171-1-phil@philpotter.co.uk>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

As all callers have now been removed, remove the definition of the
DBG_88E macro itself. It is no longer required and is dead code.

Signed-off-by: Phillip Potter <phil@philpotter.co.uk>
---
 drivers/staging/rtl8188eu/include/rtw_debug.h | 6 ------
 1 file changed, 6 deletions(-)

diff --git a/drivers/staging/rtl8188eu/include/rtw_debug.h b/drivers/staging/rtl8188eu/include/rtw_debug.h
index 2fd6151bf698..a1b25ca16d28 100644
--- a/drivers/staging/rtl8188eu/include/rtw_debug.h
+++ b/drivers/staging/rtl8188eu/include/rtw_debug.h
@@ -64,12 +64,6 @@ extern u32 GlobalDebugLevel;
 			pr_info(DRIVER_PREFIX fmt, ##arg);	\
 	} while (0)
 
-#define DBG_88E(...)							\
-	do {								\
-		if (_drv_err_ <= GlobalDebugLevel)			\
-			pr_info(DRIVER_PREFIX __VA_ARGS__);		\
-	} while (0)
-
 #define MSG_88E(...)							\
 	do {								\
 		if (_drv_err_ <= GlobalDebugLevel)			\
-- 
2.30.2

