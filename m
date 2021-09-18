Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 26F9E41058E
	for <lists+linux-kernel@lfdr.de>; Sat, 18 Sep 2021 11:42:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239330AbhIRJnh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 18 Sep 2021 05:43:37 -0400
Received: from smtpbgsg2.qq.com ([54.254.200.128]:60931 "EHLO smtpbgsg2.qq.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S238420AbhIRJnc (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 18 Sep 2021 05:43:32 -0400
X-Greylist: delayed 959 seconds by postgrey-1.27 at vger.kernel.org; Sat, 18 Sep 2021 05:43:31 EDT
X-QQ-mid: bizesmtp39t1631958120t47jr2rw
Received: from localhost.localdomain (unknown [124.126.19.250])
        by esmtp6.qq.com (ESMTP) with 
        id ; Sat, 18 Sep 2021 17:41:59 +0800 (CST)
X-QQ-SSF: 0140000000200070B000B00B0000000
X-QQ-FEAT: /rrU+puPB7Tk5bnqdyL8tUxn9Y8rEAEEEI4wjYzKXbUhAmg5fth3vv7XnXEfL
        wlFd7G4YZzmF7uGuI+yAhU/XKJ4GOAQFiTyYwASs3tQngyH62gP83ym/Mfy6yPISSJPhRjy
        9oTTArd5BAzubAY+xjfYFTDanuBSF2FmJK+32vDAmt9u25XG0Aq+mtUPTThiu1IpRxkQ4Qh
        d97mmSNb7ZhH4XcGFYbQRI3DwWcIs2jM/r16ylriQ/3nB7vPbnLhUhjDFwf1bVCZjmbDEPQ
        3X4vgnmTCT5+vwU2Ec7tVjfkcrrpKBalaB5Hlj3fOYVcfc4FTzFHtqzvkmA9AcebZiZSUC3
        nf2JmkHq9DTcMEEJXd5DMh8kYprmYDeHo64bevX
X-QQ-GoodBg: 2
From:   Zhiwei Yang <yangzhiwei@uniontech.com>
To:     David Airlie <airlied@linux.ie>, Daniel Vetter <daniel@ffwll.ch>,
        Alex Deucher <alexander.deucher@amd.com>
Cc:     =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>,
        amd-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
        linux-kernel@vger.kernel.org,
        Zhiwei Yang <yangzhiwei@uniontech.com>
Subject: [PATCH] drm/radeon: fix uninitialized bool variable
Date:   Sat, 18 Sep 2021 17:41:57 +0800
Message-Id: <20210918094157.4770-1-yangzhiwei@uniontech.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-QQ-SENDSIZE: 520
Feedback-ID: bizesmtp:uniontech.com:qybgforeign:qybgforeign1
X-QQ-Bgrelay: 1
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The bool variable detected_hpd_without_ddc in struct radeon_connector
is uninitialized when first used, that may cause unnecessary ddc ops.
Make it as false when a new connector is alloced.

Signed-off-by: Zhiwei Yang <yangzhiwei@uniontech.com>
---
 drivers/gpu/drm/radeon/radeon_connectors.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/drivers/gpu/drm/radeon/radeon_connectors.c b/drivers/gpu/drm/radeon/radeon_connectors.c
index fe12d9d91d7a..c1987a66373f 100644
--- a/drivers/gpu/drm/radeon/radeon_connectors.c
+++ b/drivers/gpu/drm/radeon/radeon_connectors.c
@@ -1866,6 +1866,7 @@ radeon_add_atom_connector(struct drm_device *dev,
 	bool shared_ddc = false;
 	bool is_dp_bridge = false;
 	bool has_aux = false;
+	bool detected_hpd_without_ddc = false;
 
 	if (connector_type == DRM_MODE_CONNECTOR_Unknown)
 		return;
@@ -1923,6 +1924,7 @@ radeon_add_atom_connector(struct drm_device *dev,
 	radeon_connector->shared_ddc = shared_ddc;
 	radeon_connector->connector_object_id = connector_object_id;
 	radeon_connector->hpd = *hpd;
+	radeon_connector->detected_hpd_without_ddc = detected_hpd_without_ddc;
 
 	radeon_connector->router = *router;
 	if (router->ddc_valid || router->cd_valid) {
@@ -2384,6 +2386,7 @@ radeon_add_legacy_connector(struct drm_device *dev,
 	struct radeon_connector *radeon_connector;
 	struct i2c_adapter *ddc = NULL;
 	uint32_t subpixel_order = SubPixelNone;
+	bool detected_hpd_without_ddc = false;
 
 	if (connector_type == DRM_MODE_CONNECTOR_Unknown)
 		return;
@@ -2414,6 +2417,7 @@ radeon_add_legacy_connector(struct drm_device *dev,
 	radeon_connector->devices = supported_device;
 	radeon_connector->connector_object_id = connector_object_id;
 	radeon_connector->hpd = *hpd;
+	radeon_connector->detected_hpd_without_ddc = detected_hpd_without_ddc;
 
 	switch (connector_type) {
 	case DRM_MODE_CONNECTOR_VGA:
-- 
2.20.1



