Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B0D813F24A4
	for <lists+linux-kernel@lfdr.de>; Fri, 20 Aug 2021 04:11:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237388AbhHTCLf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 19 Aug 2021 22:11:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35654 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234768AbhHTCLe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Aug 2021 22:11:34 -0400
Received: from mail-qv1-xf2e.google.com (mail-qv1-xf2e.google.com [IPv6:2607:f8b0:4864:20::f2e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B642CC061575
        for <linux-kernel@vger.kernel.org>; Thu, 19 Aug 2021 19:10:57 -0700 (PDT)
Received: by mail-qv1-xf2e.google.com with SMTP id c14so4745390qvs.9
        for <linux-kernel@vger.kernel.org>; Thu, 19 Aug 2021 19:10:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=6GBnlD7JIyrI3ypjxWJiH4K8EVYyZag/d4qLh3mFEpQ=;
        b=VZ11PEonbAYy7cyzGyN9eE/qqJI9vWpZp48IKfN3n7cZQ1XbNEjNyOABuFangAlTak
         3AMprImiO3aGZJQCgYikAvx5v0y+xbb5nTMyk5p4YEXjXg85Ph3rS4m9+FvMSn6BX471
         L7ldCkk/8vZG++GqG+PW+bh/+t+LaiRUobzBMES8V1v4yU3BGiTAlos8xPMqcIHeXqMM
         gjjWwMNdjQB+ZnrpdD4gEXa/X1sF+AgfuQXUM2+fbrFC/bjvtFaR1uqvPOKKVITnodXS
         d4Ms9bX0wFZBgSfMZA4w1K9LAdjGQeL4qbsKndTlShjAXafICXYXdvMMWSAI6Zhx8Lr8
         P58Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=6GBnlD7JIyrI3ypjxWJiH4K8EVYyZag/d4qLh3mFEpQ=;
        b=Yd82DxdzMeNk0qd35Gvcy7wEh12M/Erk6DimRv4GTIQcqPJAJIq/JbbRQtp3sb5J2o
         aTvfLkSzt7UcdDVnyoc8j8lcsAAh/gb4NwTjGak/6C/4u4ptnjr5JiPSOcGc6HYRZvun
         J1Rnk/wyQ9zZBdctycHL4cFbsMyRnwSa799vHarFqdr+X8YZhAVz1YIos2KpD0Vk/19q
         BRcLXaLYrMBoX867W5+ef7F5Ab5HB/VJO/kVj47Nhy3Ss2e8qpkhIzMd9R6zqS1yJ1/H
         C3uVfInLayT0pH2fmz2UdyG04HvwJeQeR+AXjFJGlqrdePZkaBJhuMqeaT8QQIEUK5iK
         HigQ==
X-Gm-Message-State: AOAM532IEghDtCjdJ91RazPwm+FWImQY/+Uq4n3XsV4OvpL38E9nEsQq
        snDj9jWZp2YlO1TBEqTPhPQ=
X-Google-Smtp-Source: ABdhPJyuxnKhj81Zor3HZ/w5G7/iqhNkCh/TAMNPAMf/ziEHAWuUD/V8OpjZnPsGrpXo5Qfc9s7P7w==
X-Received: by 2002:a05:6214:29ee:: with SMTP id jv14mr17653090qvb.5.1629425456962;
        Thu, 19 Aug 2021 19:10:56 -0700 (PDT)
Received: from localhost.localdomain ([193.203.214.57])
        by smtp.gmail.com with ESMTPSA id h4sm2398873qkp.86.2021.08.19.19.10.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 19 Aug 2021 19:10:56 -0700 (PDT)
From:   jing yangyang <cgel.zte@gmail.com>
X-Google-Original-From: jing yangyang <jing.yangyang@zte.com.cn>
To:     Anitha Chrisanthus <anitha.chrisanthus@intel.com>
Cc:     Edmund Dea <edmund.j.dea@intel.com>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
        jing yangyang <jing.yangyang@zte.com.cn>,
        Zeal Robot <zealci@zte.com.cn>
Subject: [PATCH linux-next] : add put_device() after of_find_device_by_node()
Date:   Thu, 19 Aug 2021 19:10:29 -0700
Message-Id: <20210820021029.10770-1-jing.yangyang@zte.com.cn>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This was found by coccicheck:
./drivers/gpu/drm/kmb/kmb_drv.c:503:2-8:
ERROR  missing put_device; call of_find_device_by_node on line 490,
but without a corresponding object release within this function.

Reported-by: Zeal Robot <zealci@zte.com.cn>
Signed-off-by: jing yangyang <jing.yangyang@zte.com.cn>
---
 drivers/gpu/drm/kmb/kmb_drv.c | 7 +++++--
 1 file changed, 5 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/kmb/kmb_drv.c b/drivers/gpu/drm/kmb/kmb_drv.c
index f54392e..58495a9 100644
--- a/drivers/gpu/drm/kmb/kmb_drv.c
+++ b/drivers/gpu/drm/kmb/kmb_drv.c
@@ -500,8 +500,10 @@ static int kmb_probe(struct platform_device *pdev)
 	ret = kmb_dsi_host_bridge_init(get_device(&dsi_pdev->dev));
 
 	if (ret == -EPROBE_DEFER) {
+		put_device(&dsi_pdev->dev);
 		return -EPROBE_DEFER;
 	} else if (ret) {
+		put_device(&dsi_pdev->dev);
 		DRM_ERROR("probe failed to initialize DSI host bridge\n");
 		return ret;
 	}
@@ -509,9 +511,10 @@ static int kmb_probe(struct platform_device *pdev)
 	/* Create DRM device */
 	kmb = devm_drm_dev_alloc(dev, &kmb_driver,
 				 struct kmb_drm_private, drm);
-	if (IS_ERR(kmb))
+	if (IS_ERR(kmb)) {
+		put_device(&dsi_pdev->dev);
 		return PTR_ERR(kmb);
-
+	}
 	dev_set_drvdata(dev, &kmb->drm);
 
 	/* Initialize MIPI DSI */
-- 
1.8.3.1


