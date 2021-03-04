Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1269732D007
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Mar 2021 10:50:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237940AbhCDJuX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 4 Mar 2021 04:50:23 -0500
Received: from youngberry.canonical.com ([91.189.89.112]:39235 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237868AbhCDJuN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 Mar 2021 04:50:13 -0500
Received: from 1.general.cking.uk.vpn ([10.172.193.212] helo=localhost)
        by youngberry.canonical.com with esmtpsa (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.86_2)
        (envelope-from <colin.king@canonical.com>)
        id 1lHkbo-0004S9-BN; Thu, 04 Mar 2021 09:49:28 +0000
From:   Colin King <colin.king@canonical.com>
To:     Dave Airlie <airlied@redhat.com>,
        Gerd Hoffmann <kraxel@redhat.com>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        virtualization@lists.linux-foundation.org,
        spice-devel@lists.freedesktop.org, dri-devel@lists.freedesktop.org
Cc:     kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] qxl: Fix uninitialised struct field head.surface_id
Date:   Thu,  4 Mar 2021 09:49:28 +0000
Message-Id: <20210304094928.2280722-1-colin.king@canonical.com>
X-Mailer: git-send-email 2.30.0
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Colin Ian King <colin.king@canonical.com>

The surface_id struct field in head is not being initialized and
static analysis warns that this is being passed through to
dev->monitors_config->heads[i] on an assignment. Clear up this
warning by initializing it to zero.

Addresses-Coverity: ("Uninitialized scalar variable")
Fixes: a6d3c4d79822 ("qxl: hook monitors_config updates into crtc, not encoder.")
Signed-off-by: Colin Ian King <colin.king@canonical.com>
---
 drivers/gpu/drm/qxl/qxl_display.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/gpu/drm/qxl/qxl_display.c b/drivers/gpu/drm/qxl/qxl_display.c
index 012bce0cdb65..10738e04c09b 100644
--- a/drivers/gpu/drm/qxl/qxl_display.c
+++ b/drivers/gpu/drm/qxl/qxl_display.c
@@ -328,6 +328,7 @@ static void qxl_crtc_update_monitors_config(struct drm_crtc *crtc,
 
 	head.id = i;
 	head.flags = 0;
+	head.surface_id = 0;
 	oldcount = qdev->monitors_config->count;
 	if (crtc->state->active) {
 		struct drm_display_mode *mode = &crtc->mode;
-- 
2.30.0

