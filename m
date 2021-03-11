Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 126A6336EDB
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Mar 2021 10:29:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232010AbhCKJ2u (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 11 Mar 2021 04:28:50 -0500
Received: from youngberry.canonical.com ([91.189.89.112]:51748 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231683AbhCKJ2e (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 11 Mar 2021 04:28:34 -0500
Received: from 1.general.cking.uk.vpn ([10.172.193.212] helo=localhost)
        by youngberry.canonical.com with esmtpsa (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.86_2)
        (envelope-from <colin.king@canonical.com>)
        id 1lKHcN-0002PC-3z; Thu, 11 Mar 2021 09:28:31 +0000
From:   Colin King <colin.king@canonical.com>
To:     Alex Deucher <alexander.deucher@amd.com>,
        =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>, amd-gfx@lists.freedesktop.org,
        dri-devel@lists.freedesktop.org
Cc:     kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH][next] drm/amdgpu: Fix spelling mistake "disabed" -> "disabled"
Date:   Thu, 11 Mar 2021 09:28:30 +0000
Message-Id: <20210311092830.5106-1-colin.king@canonical.com>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Colin Ian King <colin.king@canonical.com>

There is a spelling mistake in a drm debug message. Fix it.

Signed-off-by: Colin Ian King <colin.king@canonical.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_device.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
index 617e62e1eff9..dcbae9237cfa 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
@@ -3464,7 +3464,7 @@ int amdgpu_device_init(struct amdgpu_device *adev,
 				      adev->ip_blocks[i].version->type == AMD_IP_BLOCK_TYPE_COMMON ||
 				      adev->ip_blocks[i].version->type == AMD_IP_BLOCK_TYPE_IH ||
 				      adev->ip_blocks[i].version->type == AMD_IP_BLOCK_TYPE_SMC)) {
-					DRM_DEBUG("IP %s disabed for hw_init.\n",
+					DRM_DEBUG("IP %s disabled for hw_init.\n",
 						adev->ip_blocks[i].version->funcs->name);
 					adev->ip_blocks[i].status.hw = true;
 				}
-- 
2.30.2

