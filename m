Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B44AD3622F4
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Apr 2021 16:52:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245363AbhDPOlE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 16 Apr 2021 10:41:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45234 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244767AbhDPOim (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 16 Apr 2021 10:38:42 -0400
Received: from mail-ed1-x52f.google.com (mail-ed1-x52f.google.com [IPv6:2a00:1450:4864:20::52f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 86C5CC06134F
        for <linux-kernel@vger.kernel.org>; Fri, 16 Apr 2021 07:38:10 -0700 (PDT)
Received: by mail-ed1-x52f.google.com with SMTP id o20so6274324edc.7
        for <linux-kernel@vger.kernel.org>; Fri, 16 Apr 2021 07:38:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=4gQV8mJJSsa7/geg3uIIMju4DuwjY0BUG1OfqH4cLSs=;
        b=u6xbTe3xnS1gxy5a6K6GfhsnvR+yi1tODlvBP0VAE7+3t8Yro6VDBbKwS753lIQs8W
         p8WxAHkE8yRXaFTsQ38fO6gNDCMye+0iXJ/bugUjU/Ukti+9nG2YiCz6A+JztQ2Ikvj5
         eMvhwvqeXTPrDQRWGMaC3DUQtFfLgU2G9nWqHX9QFDcRjFNRv/K/LgJOJLy+KZ6XETul
         PJHcTwK+yLHk4N6r3Vq/316CC6LRR67mt+GiT8UKl3AieE0d2tNYrCmuYtEKNFiRIE+6
         iwlq0JUnw59qA52zPXYh86eRrO/5DQMhpYcgBvdCYWqrgvhyuNJ2iJlb5LDEOnIdIn9W
         HsoQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=4gQV8mJJSsa7/geg3uIIMju4DuwjY0BUG1OfqH4cLSs=;
        b=gkaYPw7oOo8IpmraZjfMtiSEEbq+KKglSzrw1CrzYj/9kF6bPvxGWeQhWs9GFUc16I
         bBc6CGLUGDvlyzQK8uQC1u/d02PFzHdTp6xqjFFSV48a/O+pby38ozZGbrhhwTnyCA1f
         g3EJskJsFLpRuDoGgmRnYjnoIkDqjR6j3Y/ChCZqqQ0NdjqXvfHg1Vx3b4lhxZJJycyo
         4Eg/54Im/trqZSlrS90bd5M2HDfufiYaLrhsO5qvaDXR/e8hhy0aM4U57pU8xBp9WZ/r
         iKT5T3XTvvCRKCAguTHDUkm9/uFqMJp3k/Az7PBmHzh+SqQneKRntWp6FOt9Q7yzvf3p
         g8BA==
X-Gm-Message-State: AOAM530ntnmvTXSmEaoM7yUmkh1by729WhsGvKxLTk3v5DQ7uGradq7F
        9ex7RU/a+MhVtDEIQQ3fbFFdng==
X-Google-Smtp-Source: ABdhPJx6hl0NeE9v7r2wwoPvU738KX9/i1DbfaWlqv4VwG0bItjiP/oOEsDadsPe3idoRSOBEDjryg==
X-Received: by 2002:a05:6402:b07:: with SMTP id bm7mr10115095edb.82.1618583889302;
        Fri, 16 Apr 2021 07:38:09 -0700 (PDT)
Received: from dell.default ([91.110.221.215])
        by smtp.gmail.com with ESMTPSA id j10sm1326523ejk.93.2021.04.16.07.38.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 16 Apr 2021 07:38:08 -0700 (PDT)
From:   Lee Jones <lee.jones@linaro.org>
To:     lee.jones@linaro.org
Cc:     linux-kernel@vger.kernel.org,
        Jagan Teki <jagan@amarulasolutions.com>,
        Thierry Reding <thierry.reding@gmail.com>,
        Sam Ravnborg <sam@ravnborg.org>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        dri-devel@lists.freedesktop.org
Subject: [PATCH 37/40] drm/panel/panel-sitronix-st7701: Demote kernel-doc format abuse
Date:   Fri, 16 Apr 2021 15:37:22 +0100
Message-Id: <20210416143725.2769053-38-lee.jones@linaro.org>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20210416143725.2769053-1-lee.jones@linaro.org>
References: <20210416143725.2769053-1-lee.jones@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fixes the following W=1 kernel build warning(s):

 drivers/gpu/drm/panel/panel-sitronix-st7701.c:42: warning: This comment starts with '/**', but isn't a kernel-doc comment. Refer Documentation/doc-guide/kernel-doc.rst

Cc: Jagan Teki <jagan@amarulasolutions.com>
Cc: Thierry Reding <thierry.reding@gmail.com>
Cc: Sam Ravnborg <sam@ravnborg.org>
Cc: David Airlie <airlied@linux.ie>
Cc: Daniel Vetter <daniel@ffwll.ch>
Cc: dri-devel@lists.freedesktop.org
Signed-off-by: Lee Jones <lee.jones@linaro.org>
---
 drivers/gpu/drm/panel/panel-sitronix-st7701.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/panel/panel-sitronix-st7701.c b/drivers/gpu/drm/panel/panel-sitronix-st7701.c
index 4d2a149b202cb..320a2a8fd4592 100644
--- a/drivers/gpu/drm/panel/panel-sitronix-st7701.c
+++ b/drivers/gpu/drm/panel/panel-sitronix-st7701.c
@@ -38,7 +38,7 @@
 #define DSI_CMD2_BK1_SPD2		0xC2 /* Source EQ2 Setting */
 #define DSI_CMD2_BK1_MIPISET1		0xD0 /* MIPI Setting 1 */
 
-/**
+/*
  * Command2 with BK function selection.
  *
  * BIT[4, 0]: [CN2, BKXSEL]
-- 
2.27.0

