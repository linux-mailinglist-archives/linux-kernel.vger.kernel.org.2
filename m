Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D9E0A366C7A
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Apr 2021 15:18:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241828AbhDUNSU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 21 Apr 2021 09:18:20 -0400
Received: from mail.kernel.org ([198.145.29.99]:49410 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S241394AbhDUNIX (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Apr 2021 09:08:23 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id AD44461467;
        Wed, 21 Apr 2021 13:07:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1619010468;
        bh=aUJWd+OylxRtW9cpzhgsQHFCpPm4R0a4bxN9pT391Vk=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=03vnQbmB7OtCW90DgYhDoFU5+FgvaIv0DU5R5NE6TnQeTWc86GrmKLBW46rXbDLi2
         vPFYyyhNkInikZKJoxRsNsawyvGo/2LtqbOKc6zn2NBtfL1KB6tqA5cdzeOIHty2T/
         fYo3dfqrbvfuR5wHhDJUkiix0eSMWmrdksMt9oFs=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Kangjie Lu <kjlu@umn.edu>,
        Dan Williams <dan.j.williams@intel.com>
Subject: [PATCH 112/190] Revert "libnvdimm/namespace: Fix a potential NULL pointer dereference"
Date:   Wed, 21 Apr 2021 14:59:47 +0200
Message-Id: <20210421130105.1226686-113-gregkh@linuxfoundation.org>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20210421130105.1226686-1-gregkh@linuxfoundation.org>
References: <20210421130105.1226686-1-gregkh@linuxfoundation.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This reverts commit 55c1fc0af29a6c1b92f217b7eb7581a882e0c07c.

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
Cc: Dan Williams <dan.j.williams@intel.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/nvdimm/namespace_devs.c | 5 +----
 1 file changed, 1 insertion(+), 4 deletions(-)

diff --git a/drivers/nvdimm/namespace_devs.c b/drivers/nvdimm/namespace_devs.c
index 2403b71b601e..04f7cb7a23b7 100644
--- a/drivers/nvdimm/namespace_devs.c
+++ b/drivers/nvdimm/namespace_devs.c
@@ -2297,12 +2297,9 @@ static struct device *create_namespace_blk(struct nd_region *nd_region,
 	if (!nsblk->uuid)
 		goto blk_err;
 	memcpy(name, nd_label->name, NSLABEL_NAME_LEN);
-	if (name[0]) {
+	if (name[0])
 		nsblk->alt_name = kmemdup(name, NSLABEL_NAME_LEN,
 				GFP_KERNEL);
-		if (!nsblk->alt_name)
-			goto blk_err;
-	}
 	res = nsblk_add_resource(nd_region, ndd, nsblk,
 			__le64_to_cpu(nd_label->dpa));
 	if (!res)
-- 
2.31.1

