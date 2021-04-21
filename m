Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4A3C9366BEF
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Apr 2021 15:10:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241236AbhDUNIo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 21 Apr 2021 09:08:44 -0400
Received: from mail.kernel.org ([198.145.29.99]:47824 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S240984AbhDUNGY (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Apr 2021 09:06:24 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 70D0F6144B;
        Wed, 21 Apr 2021 13:05:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1619010351;
        bh=dDGRrWasOUeHp1NBLPSltfVXK9G2zmKpgkwxpwZnhZs=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=kSbIYST7rkjyTixM3jv9g0ehgsS6uMh+piemxl9Nu2rA/rehxNQ4xq4qh+3ruuFTK
         nBRKEF5/ieY7Z4AvUF0hX59Rq5MY6z+8LQ5DeCEk+xN4om+WL32tb4ahbZQAiWat5z
         eoBZxAiXL89c9MXdhC7305E0QHb/lJnjpgSI3GV0=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Kangjie Lu <kjlu@umn.edu>, Mukesh Ojha <mojha@codeaurora.org>,
        Mika Westerberg <mika.westerberg@linux.intel.com>
Subject: [PATCH 103/190] Revert "thunderbolt: property: Fix a missing check of kzalloc"
Date:   Wed, 21 Apr 2021 14:59:38 +0200
Message-Id: <20210421130105.1226686-104-gregkh@linuxfoundation.org>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20210421130105.1226686-1-gregkh@linuxfoundation.org>
References: <20210421130105.1226686-1-gregkh@linuxfoundation.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This reverts commit 6183d5a51866f3acdeeb66b75e87d44025b01a55.

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
Cc: Mukesh Ojha <mojha@codeaurora.org>
Cc: Mika Westerberg <mika.westerberg@linux.intel.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/thunderbolt/property.c | 7 +------
 1 file changed, 1 insertion(+), 6 deletions(-)

diff --git a/drivers/thunderbolt/property.c b/drivers/thunderbolt/property.c
index d5b0cdb8f0b1..841314deb446 100644
--- a/drivers/thunderbolt/property.c
+++ b/drivers/thunderbolt/property.c
@@ -587,12 +587,7 @@ int tb_property_add_text(struct tb_property_dir *parent, const char *key,
 		return -ENOMEM;
 
 	property->length = size / 4;
-	property->value.text = kzalloc(size, GFP_KERNEL);
-	if (!property->value.text) {
-		kfree(property);
-		return -ENOMEM;
-	}
-
+	property->value.data = kzalloc(size, GFP_KERNEL);
 	strcpy(property->value.text, text);
 
 	list_add_tail(&property->list, &parent->properties);
-- 
2.31.1

