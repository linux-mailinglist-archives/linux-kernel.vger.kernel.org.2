Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BBB6A3AD83C
	for <lists+linux-kernel@lfdr.de>; Sat, 19 Jun 2021 08:44:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234061AbhFSGqZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 19 Jun 2021 02:46:25 -0400
Received: from mail-m17639.qiye.163.com ([59.111.176.39]:14338 "EHLO
        mail-m17639.qiye.163.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232371AbhFSGqV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 19 Jun 2021 02:46:21 -0400
DKIM-Signature: a=rsa-sha256;
        b=fMr2eHk5ouOqXvZl2LY/op5mJu49kCWugMf1bCoFu/cV/OXTjxvRPhjhwckgaaDCHkwUDoQaXEQBB1jDH+Lg1t2n2xshvUXM4c6QhzQx/YqqOmEU1I2sFP5JzlDSE0NOFgVQxFRSyE2ghczG+d7sTMz7Ip6SgJDF0m+bobtYpBw=;
        s=default; c=relaxed/relaxed; d=vivo.com; v=1;
        bh=bdZKbD4ntL+uOvkUFJz0eat8qRy6SiL1gcyD6sQKVDY=;
        h=date:mime-version:subject:message-id:from;
Received: from ubuntu.localdomain (unknown [36.152.145.181])
        by mail-m17639.qiye.163.com (Hmail) with ESMTPA id 638C93800E5;
        Sat, 19 Jun 2021 14:44:08 +0800 (CST)
From:   Bernard Zhao <bernard@vivo.com>
To:     Alex Deucher <alexander.deucher@amd.com>,
        =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>, amd-gfx@lists.freedesktop.org,
        dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
Cc:     Bernard Zhao <bernard@vivo.com>
Subject: [PATCH 1/4] drm/radeon: remove meaningless if(r) check code
Date:   Fri, 18 Jun 2021 23:43:45 -0700
Message-Id: <20210619064349.26676-2-bernard@vivo.com>
X-Mailer: git-send-email 2.31.0
In-Reply-To: <20210619064349.26676-1-bernard@vivo.com>
References: <20210619064349.26676-1-bernard@vivo.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-HM-Spam-Status: e1kfGhgUHx5ZQUtXWQgYFAkeWUFZS1VLWVdZKFlBSE83V1ktWUFJV1kPCR
        oVCBIfWUFZGUMYGFZKH0wZTx9NHRlMT0pVEwETFhoSFyQUDg9ZV1kWGg8SFR0UWUFZT0tIVUpKS0
        hKTFVLWQY+
X-HM-Sender-Digest: e1kMHhlZQR0aFwgeV1kSHx4VD1lBWUc6Nxw6TQw*Qj8RK0I0QhY5TSMT
        GEgKCVZVSlVKTUlPS0NOS09DQ0lPVTMWGhIXVRkeCRUaCR87DRINFFUYFBZFWVdZEgtZQVlITVVK
        TklVSk9OVUpDSllXWQgBWUFITEpNNwY+
X-HM-Tid: 0a7a23032ccdd994kuws638c93800e5
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Function radeon_fence_driver_init always returns success,
remove meaningless if(r) check code.

Signed-off-by: Bernard Zhao <bernard@vivo.com>
---
 drivers/gpu/drm/radeon/cik.c       | 4 +---
 drivers/gpu/drm/radeon/evergreen.c | 4 +---
 drivers/gpu/drm/radeon/ni.c        | 4 +---
 drivers/gpu/drm/radeon/si.c        | 4 +---
 4 files changed, 4 insertions(+), 12 deletions(-)

diff --git a/drivers/gpu/drm/radeon/cik.c b/drivers/gpu/drm/radeon/cik.c
index 42a8afa839cb..f6cf0b8fdd83 100644
--- a/drivers/gpu/drm/radeon/cik.c
+++ b/drivers/gpu/drm/radeon/cik.c
@@ -8584,9 +8584,7 @@ int cik_init(struct radeon_device *rdev)
 	radeon_get_clock_info(rdev->ddev);
 
 	/* Fence driver */
-	r = radeon_fence_driver_init(rdev);
-	if (r)
-		return r;
+	radeon_fence_driver_init(rdev);
 
 	/* initialize memory controller */
 	r = cik_mc_init(rdev);
diff --git a/drivers/gpu/drm/radeon/evergreen.c b/drivers/gpu/drm/radeon/evergreen.c
index 8e9e88bf1f43..36a888e1b179 100644
--- a/drivers/gpu/drm/radeon/evergreen.c
+++ b/drivers/gpu/drm/radeon/evergreen.c
@@ -5208,9 +5208,7 @@ int evergreen_init(struct radeon_device *rdev)
 	/* Initialize clocks */
 	radeon_get_clock_info(rdev->ddev);
 	/* Fence driver */
-	r = radeon_fence_driver_init(rdev);
-	if (r)
-		return r;
+	radeon_fence_driver_init(rdev);
 	/* initialize AGP */
 	if (rdev->flags & RADEON_IS_AGP) {
 		r = radeon_agp_init(rdev);
diff --git a/drivers/gpu/drm/radeon/ni.c b/drivers/gpu/drm/radeon/ni.c
index ab7bd3080217..4a364ca7a1be 100644
--- a/drivers/gpu/drm/radeon/ni.c
+++ b/drivers/gpu/drm/radeon/ni.c
@@ -2375,9 +2375,7 @@ int cayman_init(struct radeon_device *rdev)
 	/* Initialize clocks */
 	radeon_get_clock_info(rdev->ddev);
 	/* Fence driver */
-	r = radeon_fence_driver_init(rdev);
-	if (r)
-		return r;
+	radeon_fence_driver_init(rdev);
 	/* initialize memory controller */
 	r = evergreen_mc_init(rdev);
 	if (r)
diff --git a/drivers/gpu/drm/radeon/si.c b/drivers/gpu/drm/radeon/si.c
index d0e94b10e4c0..013e44ed0f39 100644
--- a/drivers/gpu/drm/radeon/si.c
+++ b/drivers/gpu/drm/radeon/si.c
@@ -6857,9 +6857,7 @@ int si_init(struct radeon_device *rdev)
 	radeon_get_clock_info(rdev->ddev);
 
 	/* Fence driver */
-	r = radeon_fence_driver_init(rdev);
-	if (r)
-		return r;
+	radeon_fence_driver_init(rdev);
 
 	/* initialize memory controller */
 	r = si_mc_init(rdev);
-- 
2.31.0

