Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A0900366C14
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Apr 2021 15:10:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241874AbhDUNJ2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 21 Apr 2021 09:09:28 -0400
Received: from mail.kernel.org ([198.145.29.99]:46346 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S235456AbhDUNG6 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Apr 2021 09:06:58 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id E533261474;
        Wed, 21 Apr 2021 13:06:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1619010380;
        bh=A5H84BYQVsP5HzrkIMZJRxI8oGI0GZQ58oRok65LThc=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=eZRBz5m6IBuf8DUnsFC2Av7ZjMBpK0hB2ka4Q2L3acP3hPmkaJFp4ZPWkShJGVFqH
         iWmqW9PHaKiXm0jF7AeZHoAI5AQkOWhflsJENYbxNWrS+XhW8em3B3NlX1UQbt5Z3z
         H4FmF7lDVJX0l6QDhKCTO4PvQPfIeEWRVS0+EfHs=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Kangjie Lu <kjlu@umn.edu>,
        Mika Westerberg <mika.westerberg@linux.intel.com>
Subject: [PATCH 116/190] Revert "thunderbolt: property: Fix a NULL pointer dereference"
Date:   Wed, 21 Apr 2021 14:59:51 +0200
Message-Id: <20210421130105.1226686-117-gregkh@linuxfoundation.org>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20210421130105.1226686-1-gregkh@linuxfoundation.org>
References: <20210421130105.1226686-1-gregkh@linuxfoundation.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This reverts commit 106204b56f60abf1bead7dceb88f2be3e34433da.

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
 drivers/thunderbolt/property.c | 5 -----
 1 file changed, 5 deletions(-)

diff --git a/drivers/thunderbolt/property.c b/drivers/thunderbolt/property.c
index ee76449524a3..b2f0d6386cee 100644
--- a/drivers/thunderbolt/property.c
+++ b/drivers/thunderbolt/property.c
@@ -548,11 +548,6 @@ int tb_property_add_data(struct tb_property_dir *parent, const char *key,
 
 	property->length = size / 4;
 	property->value.data = kzalloc(size, GFP_KERNEL);
-	if (!property->value.data) {
-		kfree(property);
-		return -ENOMEM;
-	}
-
 	memcpy(property->value.data, buf, buflen);
 
 	list_add_tail(&property->list, &parent->properties);
-- 
2.31.1

