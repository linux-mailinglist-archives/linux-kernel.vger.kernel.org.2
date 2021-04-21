Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7BED5366B97
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Apr 2021 15:03:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240481AbhDUNDh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 21 Apr 2021 09:03:37 -0400
Received: from mail.kernel.org ([198.145.29.99]:42374 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S240392AbhDUNDZ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Apr 2021 09:03:25 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id C5FB46144B;
        Wed, 21 Apr 2021 13:02:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1619010172;
        bh=4FALHvgAMTrACEpfV9mbSRxIf7DEV2x/BSx/ROwSxVY=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=2NOndzHogBGRpfWmmJpksqUl2lKBZ7QiKZq1J6iaRquUnlKQfyhvUavQbwUne/Olw
         1CdDjyu5rtmM8u/ApC54IwF4jFm4hpaTzq4OIXZHTn5xShBVwMZnTejdfrYhSaDTXs
         Anrrs6tZQWRLiBn0u3lgOWvgMKeJoZtH7A7LkMe4=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Qiushi Wu <wu000273@umn.edu>, Joerg Roedel <jroedel@suse.de>
Subject: [PATCH 039/190] Revert "iommu: Fix reference count leak in iommu_group_alloc."
Date:   Wed, 21 Apr 2021 14:58:34 +0200
Message-Id: <20210421130105.1226686-40-gregkh@linuxfoundation.org>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20210421130105.1226686-1-gregkh@linuxfoundation.org>
References: <20210421130105.1226686-1-gregkh@linuxfoundation.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This reverts commit 7cc31613734c4870ae32f5265d576ef296621343.

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
Cc: https
Cc: Joerg Roedel <jroedel@suse.de>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/iommu/iommu.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/iommu/iommu.c b/drivers/iommu/iommu.c
index d0b0a15dba84..cd22cd0e6517 100644
--- a/drivers/iommu/iommu.c
+++ b/drivers/iommu/iommu.c
@@ -596,7 +596,7 @@ struct iommu_group *iommu_group_alloc(void)
 				   NULL, "%d", group->id);
 	if (ret) {
 		ida_simple_remove(&iommu_group_ida, group->id);
-		kobject_put(&group->kobj);
+		kfree(group);
 		return ERR_PTR(ret);
 	}
 
-- 
2.31.1

