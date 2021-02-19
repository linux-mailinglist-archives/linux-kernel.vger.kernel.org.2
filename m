Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 91A4A31FFCA
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Feb 2021 21:27:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229891AbhBSU0j (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 19 Feb 2021 15:26:39 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35028 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229649AbhBSU0g (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 19 Feb 2021 15:26:36 -0500
Received: from mail-pg1-x531.google.com (mail-pg1-x531.google.com [IPv6:2607:f8b0:4864:20::531])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BFD6AC061786
        for <linux-kernel@vger.kernel.org>; Fri, 19 Feb 2021 12:25:53 -0800 (PST)
Received: by mail-pg1-x531.google.com with SMTP id m2so5635119pgq.5
        for <linux-kernel@vger.kernel.org>; Fri, 19 Feb 2021 12:25:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=6dVHk96AcArKaN/SteHJiGOj0BkhTaJ4SHAFKAMGMno=;
        b=US8UsJfdfwgQ5VJMv+ws5DQdc7kWG+09VFpbjL8+QlLWWI4BEGXOdeRn59ENUfPza3
         LARhRjYeoO5MoA4+Gxyl2KuUUNjmtsOXlNa9i91ENpAp0DvCTELgAtTIamw8ELLtUhKw
         2EKkb8GqyPZmrS24NOI97ZF1zsIQzzGUvFXPjk4c7F5ChrdWlvpiagQDunNuTEo18SoL
         Lz8GB7amTN9R8sXnXqh2hwL0BQy8fLnlKChlzTEaoA+eZw3wY/J67aTmxWyKvQDKXfGO
         gItrkElzsyLHdvYUxWmehMfUnjjPfUxIoTGHVlaalIycqBeCAHCOVY8pVCZE6V9IvJBb
         4ISg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=6dVHk96AcArKaN/SteHJiGOj0BkhTaJ4SHAFKAMGMno=;
        b=Vu17yicGFs542tkd1HCKRYJNfHRWpJeFZtV2Y7OxP6jITMFP+bPzMZhk+0D7kVUS5d
         VOugrKZFFM93awJC46MKUlxkXFybpYIP8oyYBxHDBr20fBtK+S07ngOS8cIrr0ADi9gw
         U35hXKlFuiZZ1fMSjXKH/Mrj5jmELQjZA8MI1suz6sViKYaqR4LMN4n1igiJ/XK7PLE0
         XQ/EflXwhM6JSA4UX1HSI+vKL/qj0nyzBYC6cRd+IhPA3FvaVSxdKb5sRn8Pjbpq7/+m
         LPgwqDywAipXcw5TlodIQBCOZEWGJfGEYKOSJo14bzXRTG3fKLaqOKkAmkDO1TIX/kDm
         gQiw==
X-Gm-Message-State: AOAM533EVnurenXe+tXVQsAk01+64HXPrWYcKs19oIlAXb3XRP1V9Yq+
        B0Ep7FqLvHEjmlwF3DmvwbU=
X-Google-Smtp-Source: ABdhPJxlFJJmRCqw1LJ4pqMIv8LiowF3wCbrm7Xzuz9QimAsiezEFTTBfr9clmbpjYdjjIIcXIwD6A==
X-Received: by 2002:aa7:82cf:0:b029:1cc:5393:ad8e with SMTP id f15-20020aa782cf0000b02901cc5393ad8emr11258170pfn.3.1613766353128;
        Fri, 19 Feb 2021 12:25:53 -0800 (PST)
Received: from localhost.localdomain ([49.36.144.93])
        by smtp.gmail.com with ESMTPSA id g62sm10504199pgc.32.2021.02.19.12.25.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 19 Feb 2021 12:25:52 -0800 (PST)
From:   Amrit Khera <amritkhera98@gmail.com>
To:     gregkh@linuxfoundation.org, lee.jones@linaro.org, arnd@arndb.de,
        kuba@kernel.org, mail@anirudhrb.com, ayush@disroot.org
Cc:     devel@driverdev.osuosl.org, linux-kernel@vger.kernel.org,
        Amrit Khera <amritkhera98@gmail.com>
Subject: [PATCH] staging: wimax: Fix block comment style issue in stack.c
Date:   Sat, 20 Feb 2021 01:55:25 +0530
Message-Id: <20210219202524.14642-1-amritkhera98@gmail.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This change fixes a checkpatch warning for "Block comments
use * on subsequent lines".

Signed-off-by: Amrit Khera <amritkhera98@gmail.com>
---
 drivers/staging/wimax/stack.c | 11 ++++++-----
 1 file changed, 6 insertions(+), 5 deletions(-)

diff --git a/drivers/staging/wimax/stack.c b/drivers/staging/wimax/stack.c
index ace24a6dfd2d..781426000015 100644
--- a/drivers/staging/wimax/stack.c
+++ b/drivers/staging/wimax/stack.c
@@ -62,11 +62,12 @@ MODULE_PARM_DESC(debug,
  * close to where the data is generated.
  */
 /*
-static const struct nla_policy wimax_gnl_re_status_change[WIMAX_GNL_ATTR_MAX + 1] = {
-	[WIMAX_GNL_STCH_STATE_OLD] = { .type = NLA_U8 },
-	[WIMAX_GNL_STCH_STATE_NEW] = { .type = NLA_U8 },
-};
-*/
+ * static const struct nla_policy
+ * wimax_gnl_re_status_change[WIMAX_GNL_ATTR_MAX + 1] = {
+ *	[WIMAX_GNL_STCH_STATE_OLD] = { .type = NLA_U8 },
+ *	[WIMAX_GNL_STCH_STATE_NEW] = { .type = NLA_U8 },
+ * };
+ */
 
 
 /*
-- 
2.20.1

