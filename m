Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 51311325D6B
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Feb 2021 07:08:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229863AbhBZGIE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 26 Feb 2021 01:08:04 -0500
Received: from lucky1.263xmail.com ([211.157.147.130]:43072 "EHLO
        lucky1.263xmail.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229541AbhBZGIC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 Feb 2021 01:08:02 -0500
Received: from localhost (unknown [192.168.167.16])
        by lucky1.263xmail.com (Postfix) with ESMTP id 8C2E6D0590;
        Fri, 26 Feb 2021 14:05:32 +0800 (CST)
X-MAIL-GRAY: 0
X-MAIL-DELIVERY: 1
X-ADDR-CHECKED: 0
X-ANTISPAM-LEVEL: 2
X-ABS-CHECKED: 0
Received: from localhost.localdomain (unknown [124.126.19.250])
        by smtp.263.net (postfix) whith ESMTP id P32473T140679506294528S1614319533098420_;
        Fri, 26 Feb 2021 14:05:33 +0800 (CST)
X-IP-DOMAINF: 1
X-UNIQUE-TAG: <a77edb68d092f3f6d269c21c0bccd56a>
X-RL-SENDER: wangjingyu@uniontech.com
X-SENDER: wangjingyu@uniontech.com
X-LOGIN-NAME: wangjingyu@uniontech.com
X-FST-TO: airlied@linux.ie
X-SENDER-IP: 124.126.19.250
X-ATTACHMENT-NUM: 0
X-System-Flag: 0
From:   wangjingyu <wangjingyu@uniontech.com>
To:     airlied@linux.ie, daniel@ffwll.ch
Cc:     alexander.deucher@amd.com, christian.koenig@amd.com,
        amd-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
        linux-kernel@vger.kernel.org, wangjingyu <wangjingyu@uniontech.com>
Subject: [PATCH] radeon: ERROR: space prohibited before that ','
Date:   Fri, 26 Feb 2021 14:05:28 +0800
Message-Id: <20210226060528.12964-1-wangjingyu@uniontech.com>
X-Mailer: git-send-email 2.11.0
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

drm_property_create_range(rdev->ddev, 0 , "coherent", 0, 1);

Signed-off-by: wangjingyu <wangjingyu@uniontech.com>
---
 drivers/gpu/drm/radeon/radeon_display.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/radeon/radeon_display.c b/drivers/gpu/drm/radeon/radeon_display.c
index 3a6fedad002d..439d1b3e87d8 100644
--- a/drivers/gpu/drm/radeon/radeon_display.c
+++ b/drivers/gpu/drm/radeon/radeon_display.c
@@ -1396,7 +1396,7 @@ static int radeon_modeset_create_props(struct radeon_device *rdev)
 
 	if (rdev->is_atom_bios) {
 		rdev->mode_info.coherent_mode_property =
-			drm_property_create_range(rdev->ddev, 0 , "coherent", 0, 1);
+			drm_property_create_range(rdev->ddev, 0, "coherent", 0, 1);
 		if (!rdev->mode_info.coherent_mode_property)
 			return -ENOMEM;
 	}
-- 
2.11.0



