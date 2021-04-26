Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 65D6A36B2C7
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Apr 2021 14:13:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233245AbhDZMNt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 26 Apr 2021 08:13:49 -0400
Received: from youngberry.canonical.com ([91.189.89.112]:48411 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231550AbhDZMNs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Apr 2021 08:13:48 -0400
Received: from 1.general.cking.uk.vpn ([10.172.193.212] helo=localhost)
        by youngberry.canonical.com with esmtpsa (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.86_2)
        (envelope-from <colin.king@canonical.com>)
        id 1lb06q-0001ta-9F; Mon, 26 Apr 2021 12:13:04 +0000
From:   Colin King <colin.king@canonical.com>
To:     Felix Kuehling <Felix.Kuehling@amd.com>,
        Alex Deucher <alexander.deucher@amd.com>,
        =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>, amd-gfx@lists.freedesktop.org,
        dri-devel@lists.freedesktop.org
Cc:     kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH][next] drm/amdkfd: Fix spelling mistake "unregisterd" -> "unregistered"
Date:   Mon, 26 Apr 2021 13:13:04 +0100
Message-Id: <20210426121304.83256-1-colin.king@canonical.com>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Colin Ian King <colin.king@canonical.com>

There is a spelling mistake in a pr_debug message. Fix it.

Signed-off-by: Colin Ian King <colin.king@canonical.com>
---
 drivers/gpu/drm/amd/amdkfd/kfd_svm.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_svm.c b/drivers/gpu/drm/amd/amdkfd/kfd_svm.c
index 4cc2539bed5b..e4ce97ab6e26 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_svm.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_svm.c
@@ -2286,7 +2286,7 @@ svm_range_restore_pages(struct amdgpu_device *adev, unsigned int pasid,
 		}
 		prange = svm_range_create_unregistered_range(adev, p, mm, addr);
 		if (!prange) {
-			pr_debug("failed to create unregisterd range svms 0x%p address [0x%llx]\n",
+			pr_debug("failed to create unregistered range svms 0x%p address [0x%llx]\n",
 				 svms, addr);
 			mmap_write_downgrade(mm);
 			r = -EFAULT;
-- 
2.30.2

