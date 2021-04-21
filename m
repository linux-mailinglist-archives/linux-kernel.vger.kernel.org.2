Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D8524366B91
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Apr 2021 15:03:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240425AbhDUNDc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 21 Apr 2021 09:03:32 -0400
Received: from mail.kernel.org ([198.145.29.99]:42374 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S240311AbhDUNDS (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Apr 2021 09:03:18 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id DCAF36147F;
        Wed, 21 Apr 2021 13:02:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1619010164;
        bh=+9hvM3ul7eEnj/XVVfgkrv31WyqYmoFMyz3wesNBefw=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=iZaR8GdU/9t//Pw6xbtJb8LL7Os9FY8Td5zr9oGwOtlMHiOLsGhNpvfIC1O1Z3jdC
         8oRjlA102tnGiNC+0R4Qai6dI8iKCqc2qMv8Wj0lTpJm26BW5hBQlbuihSFAeHkVrz
         HjiYZjlooZ4gmsQC7M7nVfacDH/vJ8qwLJkvEtv8=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Qiushi Wu <wu000273@umn.edu>,
        Hans Verkuil <hverkuil-cisco@xs4all.nl>,
        Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
Subject: [PATCH 011/190] Revert "media: platform: fcp: Fix a reference count leak."
Date:   Wed, 21 Apr 2021 14:58:06 +0200
Message-Id: <20210421130105.1226686-12-gregkh@linuxfoundation.org>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20210421130105.1226686-1-gregkh@linuxfoundation.org>
References: <20210421130105.1226686-1-gregkh@linuxfoundation.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This reverts commit 63e36a381d92a9cded97e90d481ee22566557dd1.

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
 drivers/media/platform/rcar-fcp.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/drivers/media/platform/rcar-fcp.c b/drivers/media/platform/rcar-fcp.c
index 5c03318ae07b..13a84c7e3586 100644
--- a/drivers/media/platform/rcar-fcp.c
+++ b/drivers/media/platform/rcar-fcp.c
@@ -102,10 +102,8 @@ int rcar_fcp_enable(struct rcar_fcp_device *fcp)
 		return 0;
 
 	ret = pm_runtime_get_sync(fcp->dev);
-	if (ret < 0) {
-		pm_runtime_put_noidle(fcp->dev);
+	if (ret < 0)
 		return ret;
-	}
 
 	return 0;
 }
-- 
2.31.1

