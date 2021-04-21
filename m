Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5E129366BF9
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Apr 2021 15:10:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241957AbhDUNJf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 21 Apr 2021 09:09:35 -0400
Received: from mail.kernel.org ([198.145.29.99]:47370 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S239689AbhDUNG7 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Apr 2021 09:06:59 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 83B4561452;
        Wed, 21 Apr 2021 13:06:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1619010386;
        bh=uzIaOMNGCQ6Uf/UGxcGNeEuzWnR9hEHddcDqfgT9RdE=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=TmvGFEBrvwU1GzDYUOA2urJBrwHYJk167nE8bF3RrCh2iJiDwLFMCXvCZschkEK48
         qL+g+Kz3PlygDwcnQ1Hroe4JRwat3KI+qbB73QHCyzNq6sAUIWQuT79IXcnCIMvsNv
         HLrty9P3eBOffKFrJPBlgJ1JgIHpJX/ScbxXc3Tk=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Kangjie Lu <kjlu@umn.edu>, Avri Altman <avri.altman@wdc.com>,
        "Martin K . Petersen" <martin.petersen@oracle.com>
Subject: [PATCH 118/190] Revert "scsi: ufs: fix a missing check of devm_reset_control_get"
Date:   Wed, 21 Apr 2021 14:59:53 +0200
Message-Id: <20210421130105.1226686-119-gregkh@linuxfoundation.org>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20210421130105.1226686-1-gregkh@linuxfoundation.org>
References: <20210421130105.1226686-1-gregkh@linuxfoundation.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This reverts commit 63a06181d7ce169d09843645c50fea1901bc9f0a.

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

Cc: Kangjie Lu <kjlu@umn.edu>
Cc: Avri Altman <avri.altman@wdc.com>
Cc: Martin K. Petersen <martin.petersen@oracle.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/scsi/ufs/ufs-hisi.c | 4 ----
 1 file changed, 4 deletions(-)

diff --git a/drivers/scsi/ufs/ufs-hisi.c b/drivers/scsi/ufs/ufs-hisi.c
index 0aa58131e791..7d1e07a9d9dd 100644
--- a/drivers/scsi/ufs/ufs-hisi.c
+++ b/drivers/scsi/ufs/ufs-hisi.c
@@ -468,10 +468,6 @@ static int ufs_hisi_init_common(struct ufs_hba *hba)
 	ufshcd_set_variant(hba, host);
 
 	host->rst  = devm_reset_control_get(dev, "rst");
-	if (IS_ERR(host->rst)) {
-		dev_err(dev, "%s: failed to get reset control\n", __func__);
-		return PTR_ERR(host->rst);
-	}
 
 	ufs_hisi_set_pm_lvl(hba);
 
-- 
2.31.1

