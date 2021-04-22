Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8D311368084
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Apr 2021 14:32:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236204AbhDVMcj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 22 Apr 2021 08:32:39 -0400
Received: from youngberry.canonical.com ([91.189.89.112]:34593 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235791AbhDVMcg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Apr 2021 08:32:36 -0400
Received: from 1.general.cking.uk.vpn ([10.172.193.212] helo=localhost)
        by youngberry.canonical.com with esmtpsa (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.86_2)
        (envelope-from <colin.king@canonical.com>)
        id 1lZYUx-0006X3-4m; Thu, 22 Apr 2021 12:31:59 +0000
From:   Colin King <colin.king@canonical.com>
To:     Felix Kuehling <Felix.Kuehling@amd.com>,
        Alex Deucher <alexander.deucher@amd.com>,
        =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        Alex Sierra <alex.sierra@amd.com>,
        Philip Yang <Philip.Yang@amd.com>,
        amd-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org
Cc:     kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH][next] drm/amdkfd: fix uint32 variable compared to less than zero
Date:   Thu, 22 Apr 2021 13:31:58 +0100
Message-Id: <20210422123158.247332-1-colin.king@canonical.com>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Colin Ian King <colin.king@canonical.com>

Currently the call to kfd_process_gpuidx_from_gpuid is returning an
int value and this is being assigned to a uint32_t variable gpuidx
and this is being checked for a negative error return which is always
going to be false. Fix this by making gpuidx an int32_t. This makes
gpuidx also type consistent with the use of gpuidx from the callers.

Addresses-Coverity: ("Unsigned compared against 0")
Fixes: cda0f85bfa5e ("drm/amdkfd: refine migration policy with xnack on")
Signed-off-by: Colin Ian King <colin.king@canonical.com>
---
 drivers/gpu/drm/amd/amdkfd/kfd_svm.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_svm.c b/drivers/gpu/drm/amd/amdkfd/kfd_svm.c
index 0e0b4ffd20ab..bf3c8de85b4a 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_svm.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_svm.c
@@ -1330,7 +1330,7 @@ static void svm_range_unreserve_bos(struct svm_validate_context *ctx)
  */
 static int svm_range_validate_and_map(struct mm_struct *mm,
 				      struct svm_range *prange,
-				      uint32_t gpuidx, bool intr, bool wait)
+				      int32_t gpuidx, bool intr, bool wait)
 {
 	struct svm_validate_context ctx;
 	struct hmm_range *hmm_range;
-- 
2.30.2

