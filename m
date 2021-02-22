Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 37CEB321106
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Feb 2021 07:50:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229952AbhBVGt2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 22 Feb 2021 01:49:28 -0500
Received: from lucky1.263xmail.com ([211.157.147.132]:51380 "EHLO
        lucky1.263xmail.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229518AbhBVGtZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 Feb 2021 01:49:25 -0500
Received: from localhost (unknown [192.168.167.32])
        by lucky1.263xmail.com (Postfix) with ESMTP id 29657F0FFC;
        Mon, 22 Feb 2021 14:47:04 +0800 (CST)
X-MAIL-GRAY: 0
X-MAIL-DELIVERY: 1
X-ADDR-CHECKED: 0
X-ANTISPAM-LEVEL: 2
X-ABS-CHECKED: 0
Received: from localhost.localdomain (unknown [124.126.19.250])
        by smtp.263.net (postfix) whith ESMTP id P27943T140459827513088S1613976423851514_;
        Mon, 22 Feb 2021 14:47:03 +0800 (CST)
X-IP-DOMAINF: 1
X-UNIQUE-TAG: <17e9c158043e3d51b4697a8f6a79f68d>
X-RL-SENDER: wangjingyu@uniontech.com
X-SENDER: wangjingyu@uniontech.com
X-LOGIN-NAME: wangjingyu@uniontech.com
X-FST-TO: alexander.deucher@amd.com
X-SENDER-IP: 124.126.19.250
X-ATTACHMENT-NUM: 0
X-System-Flag: 0
From:   wangjingyu <wangjingyu@uniontech.com>
To:     alexander.deucher@amd.com, christian.koenig@amd.com,
        airlied@linux.ie
Cc:     amd-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
        linux-kernel@vger.kernel.org,
        wangjingyu <wangjingyu@uniontech.com>,
        zhuyong <zhuyong@uniontech.com>
Subject: [PATCH] drm/radeon: A gray screen appears when going into hibernation(S4)
Date:   Mon, 22 Feb 2021 14:46:53 +0800
Message-Id: <20210222064653.22084-1-wangjingyu@uniontech.com>
X-Mailer: git-send-email 2.11.0
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Radeon Card:
    Caicos[Radeon HD 6450/7450/8450 /R5 230 OEM]

there is no gray screen when echo 4>/sys/module/drm/parameters/debug,
so the WREG32 function after DRM_DEBUG_KMS may have wrong when going
into hibernation.the delay of msleep(50) just can fix gray screen.

Signed-off-by: wangjingyu <wangjingyu@uniontech.com>
Signed-off-by: zhuyong <zhuyong@uniontech.com>
---
 drivers/gpu/drm/radeon/radeon_display.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/gpu/drm/radeon/radeon_display.c b/drivers/gpu/drm/radeon/radeon_display.c
index ddfe91efa61e..1f7f0904e4a5 100644
--- a/drivers/gpu/drm/radeon/radeon_display.c
+++ b/drivers/gpu/drm/radeon/radeon_display.c
@@ -215,6 +215,7 @@ void radeon_crtc_load_lut(struct drm_crtc *crtc)
 	if (!crtc->enabled)
 		return;
 
+	msleep(50);
 	if (ASIC_IS_DCE5(rdev))
 		dce5_crtc_load_lut(crtc);
 	else if (ASIC_IS_DCE4(rdev))
-- 
2.11.0



