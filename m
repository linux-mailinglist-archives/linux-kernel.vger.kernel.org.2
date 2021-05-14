Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 42D08380C42
	for <lists+linux-kernel@lfdr.de>; Fri, 14 May 2021 16:49:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234570AbhENOur (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 14 May 2021 10:50:47 -0400
Received: from youngberry.canonical.com ([91.189.89.112]:45038 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233044AbhENOup (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 May 2021 10:50:45 -0400
Received: from 1.general.cking.uk.vpn ([10.172.193.212] helo=localhost)
        by youngberry.canonical.com with esmtpsa  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256
        (Exim 4.93)
        (envelope-from <colin.king@canonical.com>)
        id 1lhZ87-0006J9-0E; Fri, 14 May 2021 14:49:31 +0000
From:   Colin King <colin.king@canonical.com>
To:     VMware Graphics <linux-graphics-maintainer@vmware.com>,
        Roland Scheidegger <sroland@vmware.com>,
        Zack Rusin <zackr@vmware.com>, David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        dri-devel@lists.freedesktop.org
Cc:     kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH][V2][next] drm/vmwgfx: Fix memory allocation check and a leak of object fifo
Date:   Fri, 14 May 2021 15:49:30 +0100
Message-Id: <20210514144930.89813-1-colin.king@canonical.com>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Colin Ian King <colin.king@canonical.com>

The allocation of fifo is lacking an allocation failure check, so
fix this by adding one.

In the case where fifo->static_buffer fails to be allocated the
error return path neglects to kfree the fifo object. Fix this by
adding in the missing kfree.

Kudos to Dan Carpenter for spotting the missing kzalloc failure
check.

Addresses-Coverity: ("Resource leak")
Fixes: 2cd80dbd3551 ("drm/vmwgfx: Add basic support for SVGA3")
Signed-off-by: Colin Ian King <colin.king@canonical.com>
---

V2: Add missing allocation failure check
    Update $SUBJECT to reflect this extra change

---
 drivers/gpu/drm/vmwgfx/vmwgfx_cmd.c | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/vmwgfx/vmwgfx_cmd.c b/drivers/gpu/drm/vmwgfx/vmwgfx_cmd.c
index 027d7d504e78..d9acd2f3f673 100644
--- a/drivers/gpu/drm/vmwgfx/vmwgfx_cmd.c
+++ b/drivers/gpu/drm/vmwgfx/vmwgfx_cmd.c
@@ -105,10 +105,14 @@ struct vmw_fifo_state *vmw_fifo_create(struct vmw_private *dev_priv)
 		return NULL;
 
 	fifo = kzalloc(sizeof(*fifo), GFP_KERNEL);
+	if (!fifo)
+		return ERR_PTR(-ENOMEM);
 	fifo->static_buffer_size = VMWGFX_FIFO_STATIC_SIZE;
 	fifo->static_buffer = vmalloc(fifo->static_buffer_size);
-	if (unlikely(fifo->static_buffer == NULL))
+	if (unlikely(fifo->static_buffer == NULL)) {
+		kfree(fifo);
 		return ERR_PTR(-ENOMEM);
+	}
 
 	fifo->dynamic_buffer = NULL;
 	fifo->reserved_size = 0;
-- 
2.30.2

