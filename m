Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id ED368366B82
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Apr 2021 15:02:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239184AbhDUNCy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 21 Apr 2021 09:02:54 -0400
Received: from mail.kernel.org ([198.145.29.99]:41976 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S240153AbhDUNCk (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Apr 2021 09:02:40 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 31B5C613DC;
        Wed, 21 Apr 2021 13:02:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1619010126;
        bh=ersMlf4mb5vpgfp70k5CUd4bD/MbCELRqIIwpyX3d7Y=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=NiBxhQJ84lZ1N7isfs83WWpprAlGB8nM0O7LxYCQ4EE+QnwRORDCog5m/F5JDCqi2
         nZtdXhairD58EuOPQSIT4xGtmYiUMHz+WyDThrHHYCvyYBc+e4Xuf/i06Si9nGzzH4
         v1Cmj2xXbKySKKETbVJbiaIrPq/xfuYWc2dcOYj0=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Qiushi Wu <wu000273@umn.edu>,
        Hans Verkuil <hverkuil-cisco@xs4all.nl>,
        Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
Subject: [PATCH 004/190] Revert "media: exynos4-is: Fix several reference count leaks due to pm_runtime_get_sync"
Date:   Wed, 21 Apr 2021 14:57:59 +0200
Message-Id: <20210421130105.1226686-5-gregkh@linuxfoundation.org>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20210421130105.1226686-1-gregkh@linuxfoundation.org>
References: <20210421130105.1226686-1-gregkh@linuxfoundation.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This reverts commit 7ef64ceea0008c17e94a8a2c60c5d6d46f481996.

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

Cc: Qiushi Wu <wu000273@umn.edu>
Cc: Hans Verkuil <hverkuil-cisco@xs4all.nl>
Cc: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/media/platform/exynos4-is/fimc-isp.c  | 4 +---
 drivers/media/platform/exynos4-is/fimc-lite.c | 2 +-
 2 files changed, 2 insertions(+), 4 deletions(-)

diff --git a/drivers/media/platform/exynos4-is/fimc-isp.c b/drivers/media/platform/exynos4-is/fimc-isp.c
index a77c49b18511..cde0d254ec1c 100644
--- a/drivers/media/platform/exynos4-is/fimc-isp.c
+++ b/drivers/media/platform/exynos4-is/fimc-isp.c
@@ -305,10 +305,8 @@ static int fimc_isp_subdev_s_power(struct v4l2_subdev *sd, int on)
 
 	if (on) {
 		ret = pm_runtime_get_sync(&is->pdev->dev);
-		if (ret < 0) {
-			pm_runtime_put(&is->pdev->dev);
+		if (ret < 0)
 			return ret;
-		}
 		set_bit(IS_ST_PWR_ON, &is->state);
 
 		ret = fimc_is_start_firmware(is);
diff --git a/drivers/media/platform/exynos4-is/fimc-lite.c b/drivers/media/platform/exynos4-is/fimc-lite.c
index fe20af3a7178..1576f273761b 100644
--- a/drivers/media/platform/exynos4-is/fimc-lite.c
+++ b/drivers/media/platform/exynos4-is/fimc-lite.c
@@ -471,7 +471,7 @@ static int fimc_lite_open(struct file *file)
 	set_bit(ST_FLITE_IN_USE, &fimc->state);
 	ret = pm_runtime_get_sync(&fimc->pdev->dev);
 	if (ret < 0)
-		goto err_pm;
+		goto unlock;
 
 	ret = v4l2_fh_open(file);
 	if (ret < 0)
-- 
2.31.1

