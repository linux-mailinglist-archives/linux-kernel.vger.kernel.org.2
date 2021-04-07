Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 711C1356218
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Apr 2021 05:46:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348433AbhDGDrB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 6 Apr 2021 23:47:01 -0400
Received: from m15113.mail.126.com ([220.181.15.113]:36907 "EHLO
        m15113.mail.126.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344405AbhDGDq7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Apr 2021 23:46:59 -0400
X-Greylist: delayed 1997 seconds by postgrey-1.27 at vger.kernel.org; Tue, 06 Apr 2021 23:46:58 EDT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=126.com;
        s=s110527; h=From:Subject:Date:Message-Id; bh=EYLDIVy5Lq+tCCcmxS
        9wSWSpPH1DV1dAdlXfneGhR7w=; b=SPFZZtkE7t/KQmLEIBEGSzC7QSWAYnUt+q
        dJXipiD05wCV/Jdog3/D7te4YJs/PTjZ2b/vSlR1jfNvYM/ZA4+TimnfMyt7r+vk
        WDXFuIsVLbs7t0W9EpZ1q+ARzkteO2adkMHyoKBG0rEtkFP2Qw23TgxBlWJukXoi
        UfJY08/2U=
Received: from localhost.localdomain (unknown [106.16.165.72])
        by smtp3 (Coremail) with SMTP id DcmowAAHDeGnIm1gdK2IQA--.41702S2;
        Wed, 07 Apr 2021 11:10:44 +0800 (CST)
From:   wangyingjie55@126.com
To:     alexander.deucher@amd.com, christian.koenig@amd.com,
        airlied@linux.ie, daniel@ffwll.ch, airlied@redhat.com
Cc:     wangyingjie55@126.com, amd-gfx@lists.freedesktop.org,
        dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
Subject: [PATCH v1] drm/radeon: Fix a missing check bug in radeon_dp_mst_detect()
Date:   Tue,  6 Apr 2021 20:10:04 -0700
Message-Id: <1617765004-5308-1-git-send-email-wangyingjie55@126.com>
X-Mailer: git-send-email 2.7.4
X-CM-TRANSID: DcmowAAHDeGnIm1gdK2IQA--.41702S2
X-Coremail-Antispam: 1Uf129KBjvdXoWrurW8KF4kZrWftr1xKrW3ZFb_yoWkGwbE9r
        n7Wa4rJayDKryIq3W7Z3WxX3sFgw4j9F1UWr1ftryIqry8Jr1fuF15t3WFyan8Xay7Jrn8
        K3WrKFy3Ars3KjkaLaAFLSUrUUUUjb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
        9fnUUvcSsGvfC2KfnxnUUI43ZEXa7IUU9XoDUUUUU==
X-Originating-IP: [106.16.165.72]
X-CM-SenderInfo: 5zdqw5xlqjyxrhvvqiyswou0bp/1tbiVxRtp1pEDOzDMAAAsE
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Yingjie Wang <wangyingjie55@126.com>

In radeon_dp_mst_detect(), We should check whether or not @connector
has been unregistered from userspace. If the connector is unregistered,
we should return disconnected status.

Fixes: 9843ead08f18 ("drm/radeon: add DisplayPort MST support (v2)")
Signed-off-by: Yingjie Wang <wangyingjie55@126.com>
---
 drivers/gpu/drm/radeon/radeon_dp_mst.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/gpu/drm/radeon/radeon_dp_mst.c b/drivers/gpu/drm/radeon/radeon_dp_mst.c
index 2c32186c4acd..4e4c937c36c6 100644
--- a/drivers/gpu/drm/radeon/radeon_dp_mst.c
+++ b/drivers/gpu/drm/radeon/radeon_dp_mst.c
@@ -242,6 +242,9 @@ radeon_dp_mst_detect(struct drm_connector *connector,
 		to_radeon_connector(connector);
 	struct radeon_connector *master = radeon_connector->mst_port;
 
+	if (drm_connector_is_unregistered(connector))
+		return connector_status_disconnected;
+
 	return drm_dp_mst_detect_port(connector, ctx, &master->mst_mgr,
 				      radeon_connector->port);
 }
-- 
2.7.4

