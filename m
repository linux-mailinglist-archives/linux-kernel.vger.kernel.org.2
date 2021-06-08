Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 33CB439FC2B
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Jun 2021 18:13:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232570AbhFHQPM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 8 Jun 2021 12:15:12 -0400
Received: from youngberry.canonical.com ([91.189.89.112]:40083 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229724AbhFHQPK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Jun 2021 12:15:10 -0400
Received: from 1.general.cking.uk.vpn ([10.172.193.212] helo=localhost)
        by youngberry.canonical.com with esmtpsa  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256
        (Exim 4.93)
        (envelope-from <colin.king@canonical.com>)
        id 1lqeLp-0000zO-PA; Tue, 08 Jun 2021 16:13:13 +0000
From:   Colin King <colin.king@canonical.com>
To:     Dave Airlie <airlied@redhat.com>,
        Gerd Hoffmann <kraxel@redhat.com>,
        Daniel Vetter <daniel@ffwll.ch>, Alon Levy <alevy@redhat.com>,
        virtualization@lists.linux-foundation.org,
        spice-devel@lists.freedesktop.org, dri-devel@lists.freedesktop.org
Cc:     kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] drm: qxl: ensure surf.data is ininitialized
Date:   Tue,  8 Jun 2021 17:13:13 +0100
Message-Id: <20210608161313.161922-1-colin.king@canonical.com>
X-Mailer: git-send-email 2.31.1
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Colin Ian King <colin.king@canonical.com>

The object surf is not fully initialized and the uninitialized
field surf.data is being copied by the call to qxl_bo_create
via the call to qxl_gem_object_create. Set surf.data to zero
to ensure garbage data from the stack is not being copied.

Addresses-Coverity: ("Uninitialized scalar variable")
Fixes: f64122c1f6ad ("drm: add new QXL driver. (v1.4)")
Signed-off-by: Colin Ian King <colin.king@canonical.com>
---
 drivers/gpu/drm/qxl/qxl_dumb.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/gpu/drm/qxl/qxl_dumb.c b/drivers/gpu/drm/qxl/qxl_dumb.c
index a635d9fdf8ac..d636ba685451 100644
--- a/drivers/gpu/drm/qxl/qxl_dumb.c
+++ b/drivers/gpu/drm/qxl/qxl_dumb.c
@@ -58,6 +58,8 @@ int qxl_mode_dumb_create(struct drm_file *file_priv,
 	surf.height = args->height;
 	surf.stride = pitch;
 	surf.format = format;
+	surf.data = 0;
+
 	r = qxl_gem_object_create_with_handle(qdev, file_priv,
 					      QXL_GEM_DOMAIN_CPU,
 					      args->size, &surf, &qobj,
-- 
2.31.1

