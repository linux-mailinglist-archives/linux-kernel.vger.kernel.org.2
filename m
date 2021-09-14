Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 18D4340B28E
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Sep 2021 17:08:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234180AbhINPJc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 14 Sep 2021 11:09:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47408 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233617AbhINPJb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Sep 2021 11:09:31 -0400
Received: from mail-wr1-x42d.google.com (mail-wr1-x42d.google.com [IPv6:2a00:1450:4864:20::42d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8DFC6C061574
        for <linux-kernel@vger.kernel.org>; Tue, 14 Sep 2021 08:08:13 -0700 (PDT)
Received: by mail-wr1-x42d.google.com with SMTP id x6so20754995wrv.13
        for <linux-kernel@vger.kernel.org>; Tue, 14 Sep 2021 08:08:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=CRIlQg+upo5hP8weBxz0PNmeSI1bR0RemM+MM+p+Is0=;
        b=WIPErERmvzG8kE+ee3gXEEaoYRJv5QdAd6mEUXBL1KiRLiBqfHT99QafcJEsV5HQRE
         EyxBpxCwwlSJTmhJLueVm9BDnrqkSpOWCvzem0bbVGlCwj6Uk6gNuaiJG5UGDNpuS5mL
         oZbVBZH/yTYcYVqsLKoffx7F5Wg3XXotg/OwQRSsRZ+739oVRz2CE+sMMnWOwgWvsTPS
         G5JUUr5Rs22DDBvIyc/XSk9Q2u1E3IZKdoY+s9nbedyu6asgEULeAijPb918sjmFwaVn
         6OFA+zvQRmxBZSYZkhkmjVp5xtk87vDER4PZ9tOpQ132GQLmgBlAXm59c8vx3ohTPvWW
         ZNZw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=CRIlQg+upo5hP8weBxz0PNmeSI1bR0RemM+MM+p+Is0=;
        b=JBy+cIvXjbW2yZuCPjBa2p5LFpT1ODZPcffRCixvHLdBvlXvCigndZtnPstInzWoN4
         jPlgM97XVPADzqnuvzuoYZjMWJ187XTWMu/n5SdIEr0KOxbin6AMl0QaLna+8OgNDgx+
         P+dScMWEYTdROP7BW7JH5DMW05hJoHauc+4gETZPpF+SQVn37wszvFPwFuI4pVcbPZgF
         oiF/GjsnNalGXo3jAyDoMafwIgG71Icbb/HYHqYAlbhM8bdUzYEznRs43toY8DnQpD3J
         12BrujpQaURwdC/3UFVZWJkukVL0UzQG7PCVOiNnuwDwvK8ZdAAEPvYYbWVsilxibJ82
         0AoQ==
X-Gm-Message-State: AOAM531dzOHlUbZRvlELsBvlmbdvVROEaE1/3VCkAjUeEHteEf3FY1df
        EwEYp0kLaBTbYIINNCNf1g==
X-Google-Smtp-Source: ABdhPJxFKWizTvgkbxISpyz7IpsBM8Sxby+VDRXDNDfqeOTD9NprIar1qRNoqr847/8XwV7/VlJmrA==
X-Received: by 2002:a5d:6ca2:: with SMTP id a2mr19329229wra.291.1631632092081;
        Tue, 14 Sep 2021 08:08:12 -0700 (PDT)
Received: from alex-ThinkPad-E480.. ([2a02:810b:f40:4200:b79e:d9e1:c821:37f2])
        by smtp.googlemail.com with ESMTPSA id k1sm10589441wrz.61.2021.09.14.08.08.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 14 Sep 2021 08:08:11 -0700 (PDT)
From:   Alex Bee <knaerzche@gmail.com>
To:     Sandy Huang <hjc@rock-chips.com>,
        =?UTF-8?q?Heiko=20St=C3=BCbner?= <heiko@sntech.de>,
        Andy Yan <andy.yan@rock-chips.com>
Cc:     Jonathan McDowell <noodles@earth.li>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        dri-devel@lists.freedesktop.org,
        linux-arm-kernel@lists.infradead.org,
        linux-rockchip@lists.infradead.org, linux-kernel@vger.kernel.org,
        Alex Bee <knaerzche@gmail.com>
Subject: [PATCH] drm/rockchip: handle non-platform devices in rockchip_drm_endpoint_is_subdriver
Date:   Tue, 14 Sep 2021 17:07:56 +0200
Message-Id: <20210914150756.85190-1-knaerzche@gmail.com>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

As discussed at [1] rockchip_drm_endpoint_is_subdriver will currently always
return -ENODEV for non-platform-devices (e.g. external i2c bridges), what
makes them never being considered in rockchip_rgb_init.

As suggested at [1] this additionally adds a of_device_is_available for
the node found, which will work for both platform and non-platform devices.
Also we can return early for non-platform-devices if they are enabled,
as rockchip_sub_drivers contains exclusively platform-devices.

[1] https://lore.kernel.org/all/20210316182753.GA25685@earth.li/

Suggested-by: Heiko Stuebner <heiko@sntech.de>
Signed-off-by: Alex Bee <knaerzche@gmail.com>
---
 drivers/gpu/drm/rockchip/rockchip_drm_drv.c | 9 ++++++++-
 1 file changed, 8 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/rockchip/rockchip_drm_drv.c b/drivers/gpu/drm/rockchip/rockchip_drm_drv.c
index bfba9793d238..81a5ec30ef4f 100644
--- a/drivers/gpu/drm/rockchip/rockchip_drm_drv.c
+++ b/drivers/gpu/drm/rockchip/rockchip_drm_drv.c
@@ -275,10 +275,17 @@ int rockchip_drm_endpoint_is_subdriver(struct device_node *ep)
 		return -ENODEV;
 
 	/* status disabled will prevent creation of platform-devices */
+	if (!of_device_is_available(node)) {
+		of_node_put(node);
+		return -ENODEV;
+	}
+
 	pdev = of_find_device_by_node(node);
 	of_node_put(node);
+
+	/* enabled non-platform-devices can immediately return here */
 	if (!pdev)
-		return -ENODEV;
+		return false;
 
 	/*
 	 * All rockchip subdrivers have probed at this point, so

base-commit: 6880fa6c56601bb8ed59df6c30fd390cc5f6dd8f
-- 
2.30.2

