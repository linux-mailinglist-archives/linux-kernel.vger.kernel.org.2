Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9D256366B81
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Apr 2021 15:02:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240167AbhDUNCv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 21 Apr 2021 09:02:51 -0400
Received: from mail.kernel.org ([198.145.29.99]:42048 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S240223AbhDUNCm (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Apr 2021 09:02:42 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id C804161454;
        Wed, 21 Apr 2021 13:02:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1619010129;
        bh=rGCAxYqn74DQeaaL7lVQJ6ywr1XrHm1+ENyR03tjiGE=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=zvGzYzLEfdJdz/JGxxXUgPZ3UkKDnHSAQ6Dr02tlLS1uFgFu/80ply9PcLWs6hyAs
         ekqI5Gq8abqQzimmaz2QS6Zr4FCrFEtBnemuD/e+JSCwxwE6uW1Dc+Ehd9l+TJrM4r
         LVUHP1JR5no0ppFfK1YeMHd/IlQ/EUUd0u+4gutg=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Evan Quan <evan.quan@amd.com>, Aditya Pakki <pakki001@umn.edu>,
        Alex Deucher <alexander.deucher@amd.com>
Subject: [PATCH 022/190] Revert "drm/radeon: Fix reference count leaks caused by pm_runtime_get_sync"
Date:   Wed, 21 Apr 2021 14:58:17 +0200
Message-Id: <20210421130105.1226686-23-gregkh@linuxfoundation.org>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20210421130105.1226686-1-gregkh@linuxfoundation.org>
References: <20210421130105.1226686-1-gregkh@linuxfoundation.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This reverts commit 9fb10671011143d15b6b40d6d5fa9c52c57e9d63.

Commits from @umn.edu addresses have been found to be submitted in "bad
faith" to try to test the kernel community's ability to review "known
malicious" changes.  The result of these submissions can be found in a
paper published at the 42nd IEEE Symposium on Security and Privacy
entitled, "Open Source Insecurity: Stealthily Introducing
Vulnerabilities via Hypocrite Commits" written by Qiushi Wu (University
of Minnesota) and Kangjie Lu (University of Minnesota).

Because of this, all submissions from this group must be reverted from
the kernel tree and will need to be re-reviewed again to determine if
they actually are a valid fix.  Until that work is complete, remove this
change to ensure that no problems are being introduced into the
codebase.

Cc: Evan Quan <evan.quan@amd.com>
Cc: Aditya Pakki <pakki001@umn.edu>
Cc: Alex Deucher <alexander.deucher@amd.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/gpu/drm/radeon/radeon_display.c | 4 +---
 drivers/gpu/drm/radeon/radeon_drv.c     | 4 +---
 drivers/gpu/drm/radeon/radeon_kms.c     | 4 +---
 3 files changed, 3 insertions(+), 9 deletions(-)

diff --git a/drivers/gpu/drm/radeon/radeon_display.c b/drivers/gpu/drm/radeon/radeon_display.c
index 652af7a134bd..9f29ba6c2bed 100644
--- a/drivers/gpu/drm/radeon/radeon_display.c
+++ b/drivers/gpu/drm/radeon/radeon_display.c
@@ -627,10 +627,8 @@ radeon_crtc_set_config(struct drm_mode_set *set,
 	dev = set->crtc->dev;
 
 	ret = pm_runtime_get_sync(dev->dev);
-	if (ret < 0) {
-		pm_runtime_put_autosuspend(dev->dev);
+	if (ret < 0)
 		return ret;
-	}
 
 	ret = drm_crtc_helper_set_config(set, ctx);
 
diff --git a/drivers/gpu/drm/radeon/radeon_drv.c b/drivers/gpu/drm/radeon/radeon_drv.c
index efeb115ae70e..468b364c2dab 100644
--- a/drivers/gpu/drm/radeon/radeon_drv.c
+++ b/drivers/gpu/drm/radeon/radeon_drv.c
@@ -513,10 +513,8 @@ long radeon_drm_ioctl(struct file *filp,
 	long ret;
 	dev = file_priv->minor->dev;
 	ret = pm_runtime_get_sync(dev->dev);
-	if (ret < 0) {
-		pm_runtime_put_autosuspend(dev->dev);
+	if (ret < 0)
 		return ret;
-	}
 
 	ret = drm_ioctl(filp, cmd, arg);
 
diff --git a/drivers/gpu/drm/radeon/radeon_kms.c b/drivers/gpu/drm/radeon/radeon_kms.c
index 2479d6ab7a36..df644bb68c0f 100644
--- a/drivers/gpu/drm/radeon/radeon_kms.c
+++ b/drivers/gpu/drm/radeon/radeon_kms.c
@@ -644,10 +644,8 @@ int radeon_driver_open_kms(struct drm_device *dev, struct drm_file *file_priv)
 	file_priv->driver_priv = NULL;
 
 	r = pm_runtime_get_sync(dev->dev);
-	if (r < 0) {
-		pm_runtime_put_autosuspend(dev->dev);
+	if (r < 0)
 		return r;
-	}
 
 	/* new gpu have virtual address space support */
 	if (rdev->family >= CHIP_CAYMAN) {
-- 
2.31.1

