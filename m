Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CEDBE338B16
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Mar 2021 12:08:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234015AbhCLLI2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 12 Mar 2021 06:08:28 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43754 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233871AbhCLLIL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 12 Mar 2021 06:08:11 -0500
Received: from mail-wm1-x32f.google.com (mail-wm1-x32f.google.com [IPv6:2a00:1450:4864:20::32f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 40FCFC061761
        for <linux-kernel@vger.kernel.org>; Fri, 12 Mar 2021 03:08:11 -0800 (PST)
Received: by mail-wm1-x32f.google.com with SMTP id j4-20020a05600c4104b029010c62bc1e20so14941994wmi.3
        for <linux-kernel@vger.kernel.org>; Fri, 12 Mar 2021 03:08:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=0qmJtn2ROcq97cCAA/GgmHQVBHx/QLh0PdVV8I8LApw=;
        b=G5ue6+jRiPOzq/lTADL9GS6ZiSQV1lqYa6OFSDlKj5E005qW0tpjcCwKDRUtDZbKd+
         2csTU8r1cM6ZAGC423BbrQXTqqsexOPlNp2MtoU4tiHUW339WrkZm9+xPjd88bySsvh4
         urQZ2szjy6rw7/lwmKq7VsTYDclnBGrB5jkAo989HorY2VpunPe3w6On523sRmlX/eJy
         1P47iupyOtjC38861DiFU+8ET7Bkam+LPUV0/uYES5xjMmhLm0pT+9z+ILWIoUgn5VtX
         r6TZ/YOB57py9JU7d9g+TbxJOOT+XF++6EWy89GdsjTEIEU0pN2STtyCUpK+7Oo21rZN
         +N/A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=0qmJtn2ROcq97cCAA/GgmHQVBHx/QLh0PdVV8I8LApw=;
        b=YTsVZTBDJZvOcx9Zkc1e4l32q4S3Jc6OylBtVk66zTpv6bFQVoX/Gxyh3YZx5ssLjA
         mN03qs6435Wc1lZui3DuB7SBDA+6qmj+Jsu2EFNUyPNOA7YBZQO2BQPcrocxYh9KA3pz
         B45rMMdF4hkl6Lral8bM3vsejI7iz4L/nikFf1mKN6yt8mb3LO5p01078U8fz/WGpgtw
         4Fi6D9Ql7ZDa8LN/3f6zh64mMlA+IzAKuPSSG2CS7RMj4GATC43E5xkCwZpAGrNTVMAE
         MJZdBGQ2yRugyCgRZNA8LC0nqvhhGNe52q9UQPUINGKfaLof5MvM6iub3is7D0LQbX10
         HDhA==
X-Gm-Message-State: AOAM533ceAAYG+F8KPtpg4CGIu1V7fseje6++5TqOXpa1skpieyHs5y4
        vay66kToaBtnOEsTM07Ly30OpA==
X-Google-Smtp-Source: ABdhPJx36y25qS2AGf2j01Ur/wYoFleHO4MNf+ufa+gV2DrYYq7R4ceLSKtf7sZqa0Nh8hNWnuTGTQ==
X-Received: by 2002:a1c:1dd5:: with SMTP id d204mr12259143wmd.127.1615547289996;
        Fri, 12 Mar 2021 03:08:09 -0800 (PST)
Received: from dell.default ([91.110.221.204])
        by smtp.gmail.com with ESMTPSA id f126sm1813003wmf.17.2021.03.12.03.08.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 12 Mar 2021 03:08:09 -0800 (PST)
From:   Lee Jones <lee.jones@linaro.org>
To:     lee.jones@linaro.org
Cc:     linux-kernel@vger.kernel.org,
        Pantelis Antoniou <pantelis.antoniou@konsulko.com>,
        Frank Rowand <frowand.list@gmail.com>,
        Rob Herring <robh+dt@kernel.org>, devicetree@vger.kernel.org
Subject: [PATCH 09/10] of: overlay: Fix function name disparity
Date:   Fri, 12 Mar 2021 11:07:57 +0000
Message-Id: <20210312110758.2220959-10-lee.jones@linaro.org>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20210312110758.2220959-1-lee.jones@linaro.org>
References: <20210312110758.2220959-1-lee.jones@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fixes the following W=1 kernel build warning(s):

 drivers/of/overlay.c:147: warning: expecting prototype for of_overlay_notifier_register(). Prototype was for of_overlay_notifier_unregister() instead

Cc: Pantelis Antoniou <pantelis.antoniou@konsulko.com>
Cc: Frank Rowand <frowand.list@gmail.com>
Cc: Rob Herring <robh+dt@kernel.org>
Cc: devicetree@vger.kernel.org
Signed-off-by: Lee Jones <lee.jones@linaro.org>
---
 drivers/of/overlay.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/of/overlay.c b/drivers/of/overlay.c
index 50bbe0edf5380..1c867a5e4c7c2 100644
--- a/drivers/of/overlay.c
+++ b/drivers/of/overlay.c
@@ -140,7 +140,7 @@ int of_overlay_notifier_register(struct notifier_block *nb)
 EXPORT_SYMBOL_GPL(of_overlay_notifier_register);
 
 /**
- * of_overlay_notifier_register() - Unregister notifier for overlay operations
+ * of_overlay_notifier_unregister() - Unregister notifier for overlay operations
  * @nb:		Notifier block to unregister
  */
 int of_overlay_notifier_unregister(struct notifier_block *nb)
-- 
2.27.0

