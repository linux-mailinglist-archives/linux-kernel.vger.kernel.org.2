Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0532632CA06
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Mar 2021 02:39:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231732AbhCDB2P (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 3 Mar 2021 20:28:15 -0500
Received: from lucky1.263xmail.com ([211.157.147.131]:45528 "EHLO
        lucky1.263xmail.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230445AbhCDB14 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 Mar 2021 20:27:56 -0500
Received: from localhost (unknown [192.168.167.69])
        by lucky1.263xmail.com (Postfix) with ESMTP id 3C267B945E;
        Thu,  4 Mar 2021 09:25:39 +0800 (CST)
X-MAIL-GRAY: 0
X-MAIL-DELIVERY: 1
X-ADDR-CHECKED: 0
X-ANTISPAM-LEVEL: 2
X-ABS-CHECKED: 0
Received: from localhost.localdomain (unknown [124.126.19.250])
        by smtp.263.net (postfix) whith ESMTP id P17142T139833580455680S1614821138633857_;
        Thu, 04 Mar 2021 09:25:38 +0800 (CST)
X-IP-DOMAINF: 1
X-UNIQUE-TAG: <622fa203a92ef646e76853adc9a0004c>
X-RL-SENDER: wangjingyu@uniontech.com
X-SENDER: wangjingyu@uniontech.com
X-LOGIN-NAME: wangjingyu@uniontech.com
X-FST-TO: alexander.deucher@amd.com
X-SENDER-IP: 124.126.19.250
X-ATTACHMENT-NUM: 0
X-System-Flag: 0
From:   wangjingyu <wangjingyu@uniontech.com>
To:     alexander.deucher@amd.com
Cc:     christian.koenig@amd.com, airlied@linux.ie, daniel@ffwll.ch,
        amd-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
        linux-kernel@vger.kernel.org,
        wangjingyu <wangjingyu@uniontech.com>,
        zhuyong <zhuyong@uniontech.com>
Subject: [PATCH] MIPS: drm/radeon: A gray screen appears when going into  hibernation(S4)
Date:   Thu,  4 Mar 2021 09:25:35 +0800
Message-Id: <20210304012535.25475-1-wangjingyu@uniontech.com>
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
 drivers/gpu/drm/radeon/radeon_display.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/gpu/drm/radeon/radeon_display.c b/drivers/gpu/drm/radeon/radeon_display.c
index 652af7a134bd..1be50f949bb4 100644
--- a/drivers/gpu/drm/radeon/radeon_display.c
+++ b/drivers/gpu/drm/radeon/radeon_display.c
@@ -226,6 +226,8 @@ void radeon_crtc_load_lut(struct drm_crtc *crtc)
 	if (!crtc->enabled)
 		return;
 
+	sleep(50);
+
 	if (ASIC_IS_DCE5(rdev))
 		dce5_crtc_load_lut(crtc);
 	else if (ASIC_IS_DCE4(rdev))
-- 
2.11.0



