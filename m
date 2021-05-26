Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2973B39197C
	for <lists+linux-kernel@lfdr.de>; Wed, 26 May 2021 16:05:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234145AbhEZOGk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 26 May 2021 10:06:40 -0400
Received: from youngberry.canonical.com ([91.189.89.112]:59108 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233890AbhEZOGh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 May 2021 10:06:37 -0400
Received: from 1.general.cking.uk.vpn ([10.172.193.212] helo=localhost)
        by youngberry.canonical.com with esmtpsa  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256
        (Exim 4.93)
        (envelope-from <colin.king@canonical.com>)
        id 1llu9b-0006g0-Hg; Wed, 26 May 2021 14:04:59 +0000
From:   Colin King <colin.king@canonical.com>
To:     Ben Skeggs <bskeggs@redhat.com>, David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        Alistair Popple <apopple@nvidia.com>,
        Stephen Rothwell <sfr@canb.auug.org.au>,
        Andrew Morton <akpm@linux-foundation.org>,
        dri-devel@lists.freedesktop.org, nouveau@lists.freedesktop.org
Cc:     kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH][next] nouveau/svm: Fix missing failure check on call to make_device_exclusive_range
Date:   Wed, 26 May 2021 15:04:59 +0100
Message-Id: <20210526140459.3749959-1-colin.king@canonical.com>
X-Mailer: git-send-email 2.31.1
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Colin Ian King <colin.king@canonical.com>

The call to make_device_exclusive_range can potentially fail leaving
pointer page not initialized that leads to an uninitialized pointer
read issue. Fix this by adding a check to see if the call failed and
returning the error code.

Addresses-Coverity: ("Uninitialized pointer read")
Fixes: c620bba9828c ("nouveau/svm: implement atomic SVM access")
Signed-off-by: Colin Ian King <colin.king@canonical.com>
---
 drivers/gpu/drm/nouveau/nouveau_svm.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/nouveau/nouveau_svm.c b/drivers/gpu/drm/nouveau/nouveau_svm.c
index 84726a89e665..b913b4907088 100644
--- a/drivers/gpu/drm/nouveau/nouveau_svm.c
+++ b/drivers/gpu/drm/nouveau/nouveau_svm.c
@@ -609,8 +609,10 @@ static int nouveau_atomic_range_fault(struct nouveau_svmm *svmm,
 
 		notifier_seq = mmu_interval_read_begin(&notifier->notifier);
 		mmap_read_lock(mm);
-		make_device_exclusive_range(mm, start, start + PAGE_SIZE,
-					    &page, drm->dev);
+		ret = make_device_exclusive_range(mm, start, start + PAGE_SIZE,
+						  &page, drm->dev);
+		if (ret < 0)
+			goto out;
 		mmap_read_unlock(mm);
 		if (!page) {
 			ret = -EINVAL;
-- 
2.31.1

