Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1D96A324B3D
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Feb 2021 08:30:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233701AbhBYH1h (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 25 Feb 2021 02:27:37 -0500
Received: from szxga04-in.huawei.com ([45.249.212.190]:12206 "EHLO
        szxga04-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233498AbhBYH1S (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Feb 2021 02:27:18 -0500
Received: from DGGEMS408-HUB.china.huawei.com (unknown [172.30.72.59])
        by szxga04-in.huawei.com (SkyGuard) with ESMTP id 4DmPRl0XdtzlPlk;
        Thu, 25 Feb 2021 15:24:19 +0800 (CST)
Received: from huawei.com (10.69.192.56) by DGGEMS408-HUB.china.huawei.com
 (10.3.19.208) with Microsoft SMTP Server id 14.3.498.0; Thu, 25 Feb 2021
 15:26:12 +0800
From:   Luo Jiaxing <luojiaxing@huawei.com>
To:     <nouveau@lists.freedesktop.org>, <dri-devel@lists.freedesktop.org>,
        <bskeggs@redhat.com>
CC:     <linux-kernel@vger.kernel.org>, <linuxarm@openeuler.org>,
        <luojiaxing@huawei.com>
Subject: [PATCH v1 1/2] drm/nouveau/kms/nv50-: Remove several set but not used variables "ret" in disp.c
Date:   Thu, 25 Feb 2021 15:27:06 +0800
Message-ID: <1614238026-43279-1-git-send-email-luojiaxing@huawei.com>
X-Mailer: git-send-email 2.7.4
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.69.192.56]
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fixes the following warning when using W=1 to build kernel:

drivers/gpu/drm/nouveau/dispnv50/disp.c: In function ‘nv50_mstm_cleanup’:
drivers/gpu/drm/nouveau/dispnv50/disp.c:1389:6: warning: variable ‘ret’ set but not used [-Wunused-but-set-variable]
 1389 |  int ret;
      |      ^~~
drivers/gpu/drm/nouveau/dispnv50/disp.c: In function ‘nv50_mstm_prepare’:
drivers/gpu/drm/nouveau/dispnv50/disp.c:1413:6: warning: variable ‘ret’ set but not used [-Wunused-but-set-variable]
 1413 |  int ret;
      |      ^~~

Signed-off-by: Luo Jiaxing <luojiaxing@huawei.com>
---
 drivers/gpu/drm/nouveau/dispnv50/disp.c | 8 +++-----
 1 file changed, 3 insertions(+), 5 deletions(-)

diff --git a/drivers/gpu/drm/nouveau/dispnv50/disp.c b/drivers/gpu/drm/nouveau/dispnv50/disp.c
index 196612a..828f48d 100644
--- a/drivers/gpu/drm/nouveau/dispnv50/disp.c
+++ b/drivers/gpu/drm/nouveau/dispnv50/disp.c
@@ -1386,12 +1386,11 @@ nv50_mstm_cleanup(struct nv50_mstm *mstm)
 {
 	struct nouveau_drm *drm = nouveau_drm(mstm->outp->base.base.dev);
 	struct drm_encoder *encoder;
-	int ret;
 
 	NV_ATOMIC(drm, "%s: mstm cleanup\n", mstm->outp->base.base.name);
-	ret = drm_dp_check_act_status(&mstm->mgr);
+	drm_dp_check_act_status(&mstm->mgr);
 
-	ret = drm_dp_update_payload_part2(&mstm->mgr);
+	drm_dp_update_payload_part2(&mstm->mgr);
 
 	drm_for_each_encoder(encoder, mstm->outp->base.base.dev) {
 		if (encoder->encoder_type == DRM_MODE_ENCODER_DPMST) {
@@ -1410,10 +1409,9 @@ nv50_mstm_prepare(struct nv50_mstm *mstm)
 {
 	struct nouveau_drm *drm = nouveau_drm(mstm->outp->base.base.dev);
 	struct drm_encoder *encoder;
-	int ret;
 
 	NV_ATOMIC(drm, "%s: mstm prepare\n", mstm->outp->base.base.name);
-	ret = drm_dp_update_payload_part1(&mstm->mgr);
+	drm_dp_update_payload_part1(&mstm->mgr);
 
 	drm_for_each_encoder(encoder, mstm->outp->base.base.dev) {
 		if (encoder->encoder_type == DRM_MODE_ENCODER_DPMST) {
-- 
2.7.4

