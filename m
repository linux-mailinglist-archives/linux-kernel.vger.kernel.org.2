Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 33D5440BA66
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Sep 2021 23:37:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235035AbhINViP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 14 Sep 2021 17:38:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54770 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233927AbhINViO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Sep 2021 17:38:14 -0400
Received: from mail-qv1-xf2a.google.com (mail-qv1-xf2a.google.com [IPv6:2607:f8b0:4864:20::f2a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BE6F0C061574
        for <linux-kernel@vger.kernel.org>; Tue, 14 Sep 2021 14:36:56 -0700 (PDT)
Received: by mail-qv1-xf2a.google.com with SMTP id w9so602052qvs.12
        for <linux-kernel@vger.kernel.org>; Tue, 14 Sep 2021 14:36:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=udAMjuzQQXCmw/M6tlpuan4V6V3k6IzB88Y+68k1I+A=;
        b=NcDjiaFrICMq2t8AiYC0QR1foMx2X9OFceglBCdJBSFSmbw8Qa764mZRGKs/hE07+N
         qZ8gxdnLAXMJqqymPBeQ/wU1VIiQT4OYq6nW/rC9G7yNG0MxmJl1n15JwfufsxJAHYWD
         ppvCyXSETWO8I9Ijqc90AgfIp5AKCuvsPAOPUEsWkbP67Qs3ECtC5/j9QnOeovvJKWLe
         tKCmyYTJHFVCGZZkt+eJhKIu+zqOwEtYfi9HC895+ZuNUKoMMJhm3oxAyrqeAhJhAMW+
         TqvGv3ipHzryrZrGrqGfYG6DD0yXcATFLaoiFQIQ1JYT6vDqIv6XbtN482mQdKu31LBK
         QhJA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=udAMjuzQQXCmw/M6tlpuan4V6V3k6IzB88Y+68k1I+A=;
        b=kbvJtPVWFrsB3Z5ROmXL/5HhmB9HI7zF/hXT1bioAXCwB3nyUGW1K1ZxOwslvYDkw4
         vR0K/8nFIUrO4+3oHUESN3HRScdlZ4BZg8Hbf0EAAGjY+omwJI6BaeY3V9yhmTjhyvEP
         U6AlPU/XLWPjQYriUpzBriyH9XqzmLKxSiKjD1tDWu01WXXcpGLSmQVIHFHnmYCRmvwV
         NBBchnyL67UijYyoT+THkZnziO73xY51//x2FgMAK9XyB/CKj2iBbmahP41AEteq0bo7
         dKoiHAauqgYgnt3qPSlvJA0DCBB6Ceuhd+ahoRhK8ctSpDcZ8OpjA9TNBebje3HZbUp2
         qmEQ==
X-Gm-Message-State: AOAM531rHGf/bpaR9nThgNSKG/uz/4mcU3TOpuxAJGMjVO+b0xN0PUk6
        XhAsguCTT1gwOqOO2r2u7bg=
X-Google-Smtp-Source: ABdhPJxxXWO0eizgQx1CYU83tgTd5fvuSvlhbjAtTXF9Zcp944W2+8AW/NjkFcB1YPUHP0awC269Og==
X-Received: by 2002:a0c:8e05:: with SMTP id v5mr7695690qvb.25.1631655415960;
        Tue, 14 Sep 2021 14:36:55 -0700 (PDT)
Received: from localhost.localdomain ([191.84.239.65])
        by smtp.gmail.com with ESMTPSA id o7sm6716611qtw.87.2021.09.14.14.36.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 14 Sep 2021 14:36:55 -0700 (PDT)
From:   Gaston Gonzalez <gascoar@gmail.com>
To:     linux-staging@lists.linux.dev
Cc:     gregkh@linuxfoundation.org, nsaenz@kernel.org,
        stefan.wahren@i2se.com, arnd@arndb.de, dan.carpenter@oracle.com,
        ojaswin98@gmail.com, amarjargal16@gmail.com,
        linux-rpi-kernel@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org,
        bcm-kernel-feedback-list@broadcom.com,
        linux-kernel@vger.kernel.org, gascoar@gmail.com
Subject: [PATCH 4/8] staging: vchiq_arm: clarify multiplication expressions
Date:   Tue, 14 Sep 2021 18:35:32 -0300
Message-Id: <20210914213532.396654-4-gascoar@gmail.com>
X-Mailer: git-send-email 2.33.0
In-Reply-To: <20210914213532.396654-1-gascoar@gmail.com>
References: <20210914213532.396654-1-gascoar@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add spaces around '*' in multiplication expressions to enhance
readability.

Reported by checkpatch.pl
---
 drivers/staging/vc04_services/interface/vchiq_arm/vchiq_arm.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/staging/vc04_services/interface/vchiq_arm/vchiq_arm.c b/drivers/staging/vc04_services/interface/vchiq_arm/vchiq_arm.c
index f8b3997125e4..bb4035f2de65 100644
--- a/drivers/staging/vc04_services/interface/vchiq_arm/vchiq_arm.c
+++ b/drivers/staging/vc04_services/interface/vchiq_arm/vchiq_arm.c
@@ -466,8 +466,8 @@ int vchiq_platform_init(struct platform_device *pdev, struct vchiq_state *state)
 
 	g_free_fragments = g_fragments_base;
 	for (i = 0; i < (MAX_FRAGMENTS - 1); i++) {
-		*(char **)&g_fragments_base[i*g_fragments_size] =
-			&g_fragments_base[(i + 1)*g_fragments_size];
+		*(char **)&g_fragments_base[i * g_fragments_size] =
+			&g_fragments_base[(i + 1) * g_fragments_size];
 	}
 	*(char **)&g_fragments_base[i * g_fragments_size] = NULL;
 	sema_init(&g_free_fragments_sema, MAX_FRAGMENTS);
-- 
2.33.0

