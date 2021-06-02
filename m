Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9F5F8398507
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Jun 2021 11:13:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231521AbhFBJPa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 2 Jun 2021 05:15:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51780 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229603AbhFBJP2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Jun 2021 05:15:28 -0400
Received: from mail-pg1-x534.google.com (mail-pg1-x534.google.com [IPv6:2607:f8b0:4864:20::534])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 75A5DC061574
        for <linux-kernel@vger.kernel.org>; Wed,  2 Jun 2021 02:13:44 -0700 (PDT)
Received: by mail-pg1-x534.google.com with SMTP id 6so1720044pgk.5
        for <linux-kernel@vger.kernel.org>; Wed, 02 Jun 2021 02:13:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=sRa/SCLvjxclceznxdFj3+fej72AkhZROM61oD4qmtY=;
        b=PadHvrgXfsF8NWcRseL9ndsK0SRDFHvq0J/1AMXGNoo+jdHj8ecNl05GYTtB9gcCsf
         iNzuowUlrzCHtWiOLSoDBfqYgiVe4uU0h5IDeB5+B0WMSCrVMie24Z9Izk7qe1T1f2th
         DRRlzyJyZziM9RYXYOLSeGitJSIcP0r/5Mgz3htnRHKalG5Q1wR0Vl43G2N1pEK+sJRy
         Kr37L33/rdJyF2nJ6xGS7rngukMiR+ozULYXoxFewWgVUgwqkV2uYDHv5uyrHyuMwxzw
         yFw3vYnJLzO1hq1yeLXmdUhbYW6m63O5HUVUQzUOsKZ10LwMPgLpCtixZyUDLq6fQOYz
         oV5w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=sRa/SCLvjxclceznxdFj3+fej72AkhZROM61oD4qmtY=;
        b=PGhbzFj868/sazsti+uKn9sFaJoMOrJ2MTvATEEVIrrLgSxtiF8l7qiIddJB8/5Y0q
         FEogJS1UyRR0wsV0fC7zKsJoZM0ezxoX4N5KwAVH7eD/fH5Iqqj/KPPJQcBiHAbDBMqD
         xVG8KlAbSmBmxjNcUL5tNCgJ0ANpR3IqDtK3sQkdaJIEB3Va7M/gkSfpx3k2yPR5VaNL
         HGsMdeF0d9QAdAoJFAWUPpcGHPe+Yzeakz2b4p/tv/mRy80AwPMPx//H4UekphpVZ/N/
         lNdfYr6dWfuQNCdH+8yGBQlP9xKdZ/ecaUw+D6zZ8eulIdNd4mpRnjopOpN3m2d8tq3H
         TjEQ==
X-Gm-Message-State: AOAM532cRYdAuAY7B9rtJCjtjdow6QFRqARrjSdYVVhQlPpvZqrCy+6R
        JzNsriORkpx2n6nd+TutUKo=
X-Google-Smtp-Source: ABdhPJwTV3FKHHyx7tOoeqkV1rWY56OKsASLEP4SLRoWUowqvbbpSHctG+YB0L+ldtG6q+z9mDmYrg==
X-Received: by 2002:aa7:9581:0:b029:2ea:39e:2224 with SMTP id z1-20020aa795810000b02902ea039e2224mr6870691pfj.32.1622625223899;
        Wed, 02 Jun 2021 02:13:43 -0700 (PDT)
Received: from localhost.localdomain ([2405:201:9005:8001:1fcc:40d0:d6f2:3e07])
        by smtp.gmail.com with ESMTPSA id o20sm2433387pjq.4.2021.06.02.02.13.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 02 Jun 2021 02:13:43 -0700 (PDT)
From:   Souptick Joarder <jrdr.linux@gmail.com>
To:     hjc@rock-chips.com, heiko@sntech.de, airlied@linux.ie,
        daniel@ffwll.ch
Cc:     dri-devel@lists.freedesktop.org,
        linux-arm-kernel@lists.infradead.org,
        linux-rockchip@lists.infradead.org, linux-kernel@vger.kernel.org,
        Souptick Joarder <jrdr.linux@gmail.com>,
        kernel test robot <lkp@intel.com>
Subject: [PATCH] drm/rockchip: defined struct vop_driver_dt_match[] under CONFIG_OF
Date:   Wed,  2 Jun 2021 14:43:24 +0530
Message-Id: <20210602091324.9440-1-jrdr.linux@gmail.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

kernel test robot throws warning when CONFIG_OF not set.

>> drivers/gpu/drm/rockchip/rockchip_vop_reg.c:1038:34:
warning: unused variable 'vop_driver_dt_match' [-Wunused-const-variable]
   static const struct of_device_id vop_driver_dt_match[] = {

Fixed it by defining vop_driver_dt_match[] under CONFIG_OF.

Reported-by: kernel test robot <lkp@intel.com>
Signed-off-by: Souptick Joarder <jrdr.linux@gmail.com>
---
 drivers/gpu/drm/rockchip/rockchip_vop_reg.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/gpu/drm/rockchip/rockchip_vop_reg.c b/drivers/gpu/drm/rockchip/rockchip_vop_reg.c
index ca7cc82125cb..2cdf889ca361 100644
--- a/drivers/gpu/drm/rockchip/rockchip_vop_reg.c
+++ b/drivers/gpu/drm/rockchip/rockchip_vop_reg.c
@@ -1069,6 +1069,7 @@ static const struct vop_data rk3328_vop = {
 	.win_size = ARRAY_SIZE(rk3328_vop_win_data),
 };
 
+#ifdef CONFIG_OF
 static const struct of_device_id vop_driver_dt_match[] = {
 	{ .compatible = "rockchip,rk3036-vop",
 	  .data = &rk3036_vop },
@@ -1099,6 +1100,7 @@ static const struct of_device_id vop_driver_dt_match[] = {
 	{},
 };
 MODULE_DEVICE_TABLE(of, vop_driver_dt_match);
+#endif
 
 static int vop_probe(struct platform_device *pdev)
 {
-- 
2.25.1

