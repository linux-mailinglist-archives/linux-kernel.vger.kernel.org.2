Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 402C43A74D8
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Jun 2021 05:16:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231181AbhFODSP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 14 Jun 2021 23:18:15 -0400
Received: from szxga02-in.huawei.com ([45.249.212.188]:4906 "EHLO
        szxga02-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230240AbhFODSO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Jun 2021 23:18:14 -0400
Received: from dggemv704-chm.china.huawei.com (unknown [172.30.72.55])
        by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4G3tg04CqHz6yQb;
        Tue, 15 Jun 2021 11:13:00 +0800 (CST)
Received: from dggpemm500016.china.huawei.com (7.185.36.25) by
 dggemv704-chm.china.huawei.com (10.3.19.47) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2176.2; Tue, 15 Jun 2021 11:16:09 +0800
Received: from huawei.com (10.67.174.205) by dggpemm500016.china.huawei.com
 (7.185.36.25) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2176.2; Tue, 15 Jun
 2021 11:16:08 +0800
From:   Chen Jiahao <chenjiahao16@huawei.com>
To:     <bskeggs@redhat.com>, <airlied@linux.ie>, <daniel@ffwll.ch>,
        <lyude@redhat.com>, <airlied@redhat.com>, <nikola.cornij@amd.com>,
        <ville.syrjala@linux.intel.com>, <dri-devel@lists.freedesktop.org>,
        <nouveau@lists.freedesktop.org>, <linux-kernel@vger.kernel.org>
CC:     <chenjiahao16@huawei.com>, <heying24@huawei.com>
Subject: [PATCH] drm: nouveau: fix nouveau_backlight compiling error
Date:   Tue, 15 Jun 2021 11:16:58 +0800
Message-ID: <20210615031658.176218-1-chenjiahao16@huawei.com>
X-Mailer: git-send-email 2.31.1
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.67.174.205]
X-ClientProxiedBy: dggems705-chm.china.huawei.com (10.3.19.182) To
 dggpemm500016.china.huawei.com (7.185.36.25)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

There is a compiling error in disp.c while not selecting
CONFIG_DRM_NOUVEAU_BACKLIGHT:

drivers/gpu/drm/nouveau/dispnv50/disp.c: In function ‘nv50_sor_atomic_disable’:
drivers/gpu/drm/nouveau/dispnv50/disp.c:1665:52: error:
‘struct nouveau_connector’ has no member named ‘backlight’
 1665 |  struct nouveau_backlight *backlight = nv_connector->backlight;
      |                                                    ^~
drivers/gpu/drm/nouveau/dispnv50/disp.c:1670:28: error: dereferencing pointer
to incomplete type ‘struct nouveau_backlight’
 1670 |  if (backlight && backlight->uses_dpcd) {
      |                            ^~

The problem is solved by adding the CONFIG_DRM_NOUVEAU_BACKLIGHT dependency
where struct nouveau_backlight is used.

Signed-off-by: Chen Jiahao <chenjiahao16@huawei.com>
---
 drivers/gpu/drm/nouveau/dispnv50/disp.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/drivers/gpu/drm/nouveau/dispnv50/disp.c b/drivers/gpu/drm/nouveau/dispnv50/disp.c
index 093e1f7163b3..d266b7721e29 100644
--- a/drivers/gpu/drm/nouveau/dispnv50/disp.c
+++ b/drivers/gpu/drm/nouveau/dispnv50/disp.c
@@ -1662,17 +1662,21 @@ nv50_sor_atomic_disable(struct drm_encoder *encoder, struct drm_atomic_state *st
 	struct nouveau_drm *drm = nouveau_drm(nv_encoder->base.base.dev);
 	struct nouveau_crtc *nv_crtc = nouveau_crtc(nv_encoder->crtc);
 	struct nouveau_connector *nv_connector = nv50_outp_get_old_connector(state, nv_encoder);
+#ifdef CONFIG_DRM_NOUVEAU_BACKLIGHT
 	struct nouveau_backlight *backlight = nv_connector->backlight;
+#endif
 	struct drm_dp_aux *aux = &nv_connector->aux;
 	int ret;
 	u8 pwr;
 
+#ifdef CONFIG_DRM_NOUVEAU_BACKLIGHT
 	if (backlight && backlight->uses_dpcd) {
 		ret = drm_edp_backlight_disable(aux, &backlight->edp_info);
 		if (ret < 0)
 			NV_ERROR(drm, "Failed to disable backlight on [CONNECTOR:%d:%s]: %d\n",
 				 nv_connector->base.base.id, nv_connector->base.name, ret);
 	}
+#endif
 
 	if (nv_encoder->dcb->type == DCB_OUTPUT_DP) {
 		int ret = drm_dp_dpcd_readb(aux, DP_SET_POWER, &pwr);
-- 
2.31.1

