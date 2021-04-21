Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9452F366BF7
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Apr 2021 15:10:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241771AbhDUNJV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 21 Apr 2021 09:09:21 -0400
Received: from mail.kernel.org ([198.145.29.99]:47148 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S238665AbhDUNG4 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Apr 2021 09:06:56 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 469CE61464;
        Wed, 21 Apr 2021 13:06:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1619010377;
        bh=peDSARWDVtWje0Dw80ELTGeK8xQD2WIjrlaeaHWSfBo=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Jr18uafpYgx4gsCsYCZ0qjKVcRfXze6FjM4nflZNN5uNcHN7Ciylp6Hkh5eFzNOeg
         6yfE0gwlAK90+ygvUK+4hvJ67ekInCmo4GgPfvzkMtrWRMGoSmlwamNOYDdZCg/nNI
         Jr6J3z34BsaNUYNR0AZcpbAyYZf39IxzjPWCVx0M=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Kangjie Lu <kjlu@umn.edu>,
        Mika Westerberg <mika.westerberg@linux.intel.com>
Subject: [PATCH 115/190] Revert "thunderbolt: Fix a missing check of kmemdup"
Date:   Wed, 21 Apr 2021 14:59:50 +0200
Message-Id: <20210421130105.1226686-116-gregkh@linuxfoundation.org>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20210421130105.1226686-1-gregkh@linuxfoundation.org>
References: <20210421130105.1226686-1-gregkh@linuxfoundation.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This reverts commit e4dfdd5804cce1255f99c5dd033526a18135a616.

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
Cc: Mika Westerberg <mika.westerberg@linux.intel.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/thunderbolt/property.c | 4 ----
 1 file changed, 4 deletions(-)

diff --git a/drivers/thunderbolt/property.c b/drivers/thunderbolt/property.c
index 841314deb446..ee76449524a3 100644
--- a/drivers/thunderbolt/property.c
+++ b/drivers/thunderbolt/property.c
@@ -176,10 +176,6 @@ static struct tb_property_dir *__tb_property_parse_dir(const u32 *block,
 	} else {
 		dir->uuid = kmemdup(&block[dir_offset], sizeof(*dir->uuid),
 				    GFP_KERNEL);
-		if (!dir->uuid) {
-			tb_property_free_dir(dir);
-			return NULL;
-		}
 		content_offset = dir_offset + 4;
 		content_len = dir_len - 4; /* Length includes UUID */
 	}
-- 
2.31.1

