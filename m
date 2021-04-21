Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1CA9B366C44
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Apr 2021 15:13:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241813AbhDUNN2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 21 Apr 2021 09:13:28 -0400
Received: from mail.kernel.org ([198.145.29.99]:49250 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S241690AbhDUNJR (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Apr 2021 09:09:17 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id DC0C26143B;
        Wed, 21 Apr 2021 13:08:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1619010523;
        bh=wauSPb1UHT6b3etSZmWbUPFddj2bur9oZW4bivtm00o=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=ys/4S1a1rjGSa4pqemzBjsQIAJrUjiinccptkzPq/B2RsV2MiqNm2kKudObaRm09L
         5EzMTiNl4ZbI5sjQNXkwqxWtk5eYNdEiCAVPvWasOPhXkbgob6jCUMzw4XEAXs2aYi
         O3LhPiZw1mYFNuRFg2dSs/ixZbd4njlcktx7ouMc=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Wenwen Wang <wang6495@umn.edu>, Jens Axboe <axboe@kernel.dk>
Subject: [PATCH 167/190] Revert "gdrom: fix a memory leak bug"
Date:   Wed, 21 Apr 2021 15:00:42 +0200
Message-Id: <20210421130105.1226686-168-gregkh@linuxfoundation.org>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20210421130105.1226686-1-gregkh@linuxfoundation.org>
References: <20210421130105.1226686-1-gregkh@linuxfoundation.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This reverts commit 093c48213ee37c3c3ff1cf5ac1aa2a9d8bc66017.

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

Cc: Wenwen Wang <wang6495@umn.edu>
Cc: Jens Axboe <axboe@kernel.dk>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/cdrom/gdrom.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/cdrom/gdrom.c b/drivers/cdrom/gdrom.c
index 9874fc1c815b..466fc3eee8bb 100644
--- a/drivers/cdrom/gdrom.c
+++ b/drivers/cdrom/gdrom.c
@@ -863,7 +863,6 @@ static void __exit exit_gdrom(void)
 	platform_device_unregister(pd);
 	platform_driver_unregister(&gdrom_driver);
 	kfree(gd.toc);
-	kfree(gd.cd_info);
 }
 
 module_init(init_gdrom);
-- 
2.31.1

