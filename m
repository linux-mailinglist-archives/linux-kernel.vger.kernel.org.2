Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E25D4318794
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Feb 2021 10:59:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230144AbhBKJ7Q (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 11 Feb 2021 04:59:16 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37820 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230124AbhBKJzb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 11 Feb 2021 04:55:31 -0500
Received: from mail-pl1-x62a.google.com (mail-pl1-x62a.google.com [IPv6:2607:f8b0:4864:20::62a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C5E24C061574
        for <linux-kernel@vger.kernel.org>; Thu, 11 Feb 2021 01:54:50 -0800 (PST)
Received: by mail-pl1-x62a.google.com with SMTP id e12so3049474pls.4
        for <linux-kernel@vger.kernel.org>; Thu, 11 Feb 2021 01:54:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=wcz3AQJyepgs6E3Mhy+qpeJeGUBWMUKWfxuRMoRrU+I=;
        b=W40w3jlQ178sIb6XnOXVB0x9dFaVjJYV0dcsC45zN/UsV9asePx7aMgfCt1F/zD3PK
         B/cuDHa1KHlCpt7gT3FoeJgvvF9mCydP7kBcp5p2BBjuewhpPkjp/5C2W3URNmn0Ou9g
         bgTb3bHPlj2q8Hhpb0biWq+/tZjCnOfw/Q3B1qE+q4WovUho+yVx8E34VvlqeaRytiyl
         jzGMGzhRNSNmQ5tFt4dhpYCYVJPM6EAwKUU64Q8Ddc1VEaY6qbrKpy0vAZJmb/k7xcwL
         xsNKy1MueZrBbTm+Wuwo8sHc/fCM2fB4tnRwLd7nSEyi7iRaSIJtzNSgGJhOOyUdlqRJ
         xaZw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=wcz3AQJyepgs6E3Mhy+qpeJeGUBWMUKWfxuRMoRrU+I=;
        b=bx34mZpueT+fUjM6mp13NEedqA2ydHfqlbFGzcOuboY82vfnDdgQrovWYb6IWQJXTb
         d+WnldYQnkb9Zi1QOPltnTKfb5NkMPaz1PZUlXQf2vD58o3oIBAMo93ftC7Xo7lowR0j
         h9Z9lTNnB7n1Lo65yW+78Uxw0SVwAKJW0fdR2Wt0ivsvQ2jhXZGC2eFyMjim6cvuGbU9
         G0yRuGVu45ZO6C1Ig1jmbf9E1qUv/C3ycuqXycrFS0HrXmR01xW4IMhI+nCHtkFVcnlz
         sSsw95jiBMNcDonJ72pDAe9j3lRk4vOqhlsz9VnRgGaNpadTaN5XPG/JPHcRCusqEXNS
         4+hQ==
X-Gm-Message-State: AOAM533SWQVK2qW9JMMlDyuRO1/Q1a7DPalK7Q2cv+bMi5G/6kUO8isT
        5vJeBBETKGRoQ+gwY8Gr914=
X-Google-Smtp-Source: ABdhPJwV1rcv6wGkjVZ8flLv4pmrLtBs1E2FL3ApE5mLK8efWmbyclpYoAXRUjxrJdjzDcqHGzwx8A==
X-Received: by 2002:a17:902:8c8f:b029:e0:1663:fd34 with SMTP id t15-20020a1709028c8fb02900e01663fd34mr6901568plo.84.1613037290390;
        Thu, 11 Feb 2021 01:54:50 -0800 (PST)
Received: from localhost.localdomain ([27.5.41.215])
        by smtp.gmail.com with ESMTPSA id y24sm4959382pfr.152.2021.02.11.01.54.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 11 Feb 2021 01:54:50 -0800 (PST)
From:   Hemansh Agnihotri <hemanshagnihotri27@gmail.com>
To:     johan@kernel.org, elder@kernel.org, gregkh@linuxfoundation.org
Cc:     greybus-dev@lists.linaro.org, devel@driverdev.osuosl.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH 1/1] staging: greybus: Added do - while in multi statement macro
Date:   Thu, 11 Feb 2021 15:24:44 +0530
Message-Id: <20210211095444.54447-1-hemanshagnihotri27@gmail.com>
X-Mailer: git-send-email 2.30.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch add fixes an checkpatch error for "Macros with multiple statements
should be enclosed in a do - while loop"

Signed-off-by: Hemansh Agnihotri <hemanshagnihotri27@gmail.com>
---
 drivers/staging/greybus/loopback.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/drivers/staging/greybus/loopback.c b/drivers/staging/greybus/loopback.c
index 2471448ba42a..6dd95d648999 100644
--- a/drivers/staging/greybus/loopback.c
+++ b/drivers/staging/greybus/loopback.c
@@ -162,10 +162,11 @@ static ssize_t name##_avg_show(struct device *dev,		\
 }									\
 static DEVICE_ATTR_RO(name##_avg)
 
-#define gb_loopback_stats_attrs(field)				\
+#define gb_loopback_stats_attrs(field) do { \
 	gb_loopback_ro_stats_attr(field, min, u);		\
 	gb_loopback_ro_stats_attr(field, max, u);		\
-	gb_loopback_ro_avg_attr(field)
+	gb_loopback_ro_avg_attr(field);				\
+	} while (0)
 
 #define gb_loopback_attr(field, type)					\
 static ssize_t field##_show(struct device *dev,				\
-- 
2.30.0

