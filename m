Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 14946389FA6
	for <lists+linux-kernel@lfdr.de>; Thu, 20 May 2021 10:16:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231177AbhETISN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 20 May 2021 04:18:13 -0400
Received: from youngberry.canonical.com ([91.189.89.112]:57959 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229536AbhETISL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 May 2021 04:18:11 -0400
Received: from 1.general.cking.uk.vpn ([10.172.193.212] helo=localhost)
        by youngberry.canonical.com with esmtpsa  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256
        (Exim 4.93)
        (envelope-from <colin.king@canonical.com>)
        id 1ljdrK-0000s2-AR; Thu, 20 May 2021 08:16:46 +0000
From:   Colin King <colin.king@canonical.com>
To:     Alex Deucher <alexander.deucher@amd.com>,
        =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>,
        Xinhui.Pan@amd.com, David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>, amd-gfx@lists.freedesktop.org,
        dri-devel@lists.freedesktop.org
Cc:     kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH][next] drm/amdgpu/acpi: Fix null check on memory allocation
Date:   Thu, 20 May 2021 09:16:46 +0100
Message-Id: <20210520081646.6296-1-colin.king@canonical.com>
X-Mailer: git-send-email 2.31.1
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Colin Ian King <colin.king@canonical.com>

The current null check is checking the wrong pointer atif. Fix this
to check the correct pointer atcs.

Addresses-Coverity: ("Uninitialized pointer read")
Fixes: c1c4d8efddde ("drm/amdgpu/acpi: unify ATCS handling (v2)")
Signed-off-by: Colin Ian King <colin.king@canonical.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_acpi.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_acpi.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_acpi.c
index c39f447df21d..b3ee7fb72b81 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_acpi.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_acpi.c
@@ -901,7 +901,7 @@ int amdgpu_acpi_init(struct amdgpu_device *adev)
 		goto out;
 
 	atcs = kzalloc(sizeof(*atcs), GFP_KERNEL);
-	if (!atif) {
+	if (!atcs) {
 		DRM_WARN("Not enough memory to initialize ATCS\n");
 		goto out;
 	}
-- 
2.31.1

