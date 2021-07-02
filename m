Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3D8163BA039
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Jul 2021 14:15:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232065AbhGBMRg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 2 Jul 2021 08:17:36 -0400
Received: from youngberry.canonical.com ([91.189.89.112]:59357 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231975AbhGBMI3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Jul 2021 08:08:29 -0400
Received: from 1.general.cking.uk.vpn ([10.172.193.212] helo=localhost)
        by youngberry.canonical.com with esmtpsa  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256
        (Exim 4.93)
        (envelope-from <colin.king@canonical.com>)
        id 1lzHv5-0006TO-1f; Fri, 02 Jul 2021 12:05:19 +0000
From:   Colin King <colin.king@canonical.com>
To:     Ben Skeggs <bskeggs@redhat.com>, David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>, lyude@redhat.com,
        Dave Airlie <airlied@redhat.com>,
        dri-devel@lists.freedesktop.org, nouveau@lists.freedesktop.org
Cc:     kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] drm/nouveau: Remove redundant error check on variable ret
Date:   Fri,  2 Jul 2021 13:05:18 +0100
Message-Id: <20210702120518.17740-1-colin.king@canonical.com>
X-Mailer: git-send-email 2.31.1
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Colin Ian King <colin.king@canonical.com>

The call to drm_dp_aux_init never returns an error code and there
is no error return being assigned to variable ret. The check for
an error in ret is always false since ret is still zero from the
start of the function so the init error check and error message
is redundant and can be removed.

Addresses-Coverity: ("Logically dead code")
Fixes: fd43ad9d47e7 ("drm/nouveau/kms/nv50-: Move AUX adapter reg to connector late register/early unregister")
Signed-off-by: Colin Ian King <colin.king@canonical.com>
---
 drivers/gpu/drm/nouveau/nouveau_connector.c | 6 ------
 1 file changed, 6 deletions(-)

diff --git a/drivers/gpu/drm/nouveau/nouveau_connector.c b/drivers/gpu/drm/nouveau/nouveau_connector.c
index 22b83a6577eb..f37e5f28a93f 100644
--- a/drivers/gpu/drm/nouveau/nouveau_connector.c
+++ b/drivers/gpu/drm/nouveau/nouveau_connector.c
@@ -1362,12 +1362,6 @@ nouveau_connector_create(struct drm_device *dev,
 			 dcbe->hasht, dcbe->hashm);
 		nv_connector->aux.name = kstrdup(aux_name, GFP_KERNEL);
 		drm_dp_aux_init(&nv_connector->aux);
-		if (ret) {
-			NV_ERROR(drm, "Failed to init AUX adapter for sor-%04x-%04x: %d\n",
-				 dcbe->hasht, dcbe->hashm, ret);
-			kfree(nv_connector);
-			return ERR_PTR(ret);
-		}
 		fallthrough;
 	default:
 		funcs = &nouveau_connector_funcs;
-- 
2.31.1

