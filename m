Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3A035327375
	for <lists+linux-kernel@lfdr.de>; Sun, 28 Feb 2021 18:02:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231234AbhB1RBd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 28 Feb 2021 12:01:33 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46724 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230449AbhB1RB2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 28 Feb 2021 12:01:28 -0500
Received: from mail-ed1-x531.google.com (mail-ed1-x531.google.com [IPv6:2a00:1450:4864:20::531])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0E803C06174A
        for <linux-kernel@vger.kernel.org>; Sun, 28 Feb 2021 09:00:46 -0800 (PST)
Received: by mail-ed1-x531.google.com with SMTP id d13so12489808edp.4
        for <linux-kernel@vger.kernel.org>; Sun, 28 Feb 2021 09:00:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=1nO8DN9qj06zKLWl1W6gXx6dVH7T5boOgxNKKypwyvM=;
        b=Zx1bmPRjsXaxhCckxSVpxaw046VLxfNJbu9tFJhVEoFXTL7l8PQl2ut9rqI2/UAuBu
         AQqo9UmD7+hNWT2cqU5lZbr1qwtlAh5Zl4G1oblQ4dImD1lo1Ih+m2SlmIAy4Mg4g38L
         +PiOvutyztqJN7s+k1Lp52IWS8XvPBqG0Io4f5WCz4uAHVKA4H66/CjCJUZPbKFupJZ8
         29wCRmkdozX7+0OhiezLfZBJ4rNxb9SxvV5udMYbUrGX/WG2QH1FKadsEj4Onjj1jtDX
         79z5WDgfBmR4H7uSOfaNQ7dn3AQ+mg0vpPy3SdXm8xXUfLfV1NeKmvayqNm83yxwAOI+
         K7HQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=1nO8DN9qj06zKLWl1W6gXx6dVH7T5boOgxNKKypwyvM=;
        b=JxTu4f2E8rm57cUvd7JflQQI+qm1IrOZOgbcaov7CraNdaT0rLHvo094cZcT4pm0Cs
         Mr/v4/VddJ+YQWLU7pGpCCDOsVKgl/1iLFsIznS/Fh/sFEJXc6N/LznEsMyNGf2m38bD
         l8cguw4vizLt9PCUSUusysKOdhsYIB6wCDOYWB3u/WkukcP4GqpnOcU4WuxPZxC4ceSx
         djg+ZXztTw8tkCHTv8D72hM9W4ldYOauOMxsVHBjbjhRAf2TXjBwpRowrepApbIQO7jp
         iUzOsqgmD6dRyklMV7arS35GDR8YBaGdP89mDnt9mZ4p3YeblYfJaqN1lMGPI8UU9yJX
         nUcA==
X-Gm-Message-State: AOAM530QJWtNftrv32kmwN3wSbAjNVQC25NPVMbkGJIJ5WML3G46/Spa
        Wr7BEVVCk9S5WXGZPeeTZE571+t8QQ==
X-Google-Smtp-Source: ABdhPJwO5gY8Ahd1DqN7RLUySkKiPuJch2s0mgEyXWPmaVwsZgu4sa3+cHAAZ/YauwosnLnJQUMYXA==
X-Received: by 2002:a05:6402:1649:: with SMTP id s9mr12793763edx.177.1614531644817;
        Sun, 28 Feb 2021 09:00:44 -0800 (PST)
Received: from localhost.localdomain ([46.53.249.223])
        by smtp.gmail.com with ESMTPSA id oy8sm10406866ejb.58.2021.02.28.09.00.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 28 Feb 2021 09:00:44 -0800 (PST)
Date:   Sun, 28 Feb 2021 20:00:42 +0300
From:   Alexey Dobriyan <adobriyan@gmail.com>
To:     torvalds@linux-foundation.org
Cc:     linux-kernel@vger.kernel.org, akpm@linux-foundation.org,
        linus.walleij@linaro.org
Subject: [PATCH 04/11] pragma once: convert
 drivers/gpu/drm/pl111/pl111_nomadik.h
Message-ID: <YDvMOp41h6UlCKMP@localhost.localdomain>
References: <YDvLYzsGu+l1pQ2y@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <YDvLYzsGu+l1pQ2y@localhost.localdomain>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From fe8504a1a0b5352cbc676b933c3dbb79ae9f59c9 Mon Sep 17 00:00:00 2001
From: Alexey Dobriyan <adobriyan@gmail.com>
Date: Tue, 9 Feb 2021 16:50:24 +0300
Subject: [PATCH 04/11] pragma once: convert drivers/gpu/drm/pl111/pl111_nomadik.h

This file has broken include guard, convert it manually.

Signed-off-by: Alexey Dobriyan <adobriyan@gmail.com>
---
 drivers/gpu/drm/pl111/pl111_nomadik.h | 6 +-----
 1 file changed, 1 insertion(+), 5 deletions(-)

diff --git a/drivers/gpu/drm/pl111/pl111_nomadik.h b/drivers/gpu/drm/pl111/pl111_nomadik.h
index 47ccf5c839fc..00592a38c7d8 100644
--- a/drivers/gpu/drm/pl111/pl111_nomadik.h
+++ b/drivers/gpu/drm/pl111/pl111_nomadik.h
@@ -1,9 +1,5 @@
 // SPDX-License-Identifier: GPL-2.0+
-
-#ifndef PL111_NOMADIK_H
-#define PL111_NOMADIK_H
-#endif
-
+#pragma once
 struct device;
 
 #ifdef CONFIG_ARCH_NOMADIK
-- 
2.29.2

