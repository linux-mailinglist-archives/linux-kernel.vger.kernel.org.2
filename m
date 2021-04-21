Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BC641366C27
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Apr 2021 15:12:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241751AbhDUNLO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 21 Apr 2021 09:11:14 -0400
Received: from mail.kernel.org ([198.145.29.99]:49658 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S241423AbhDUNIc (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Apr 2021 09:08:32 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id A9B8661461;
        Wed, 21 Apr 2021 13:07:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1619010476;
        bh=W+fqRjEprRdWVAZVQw54H830NNvbN8Hve8nTQDZmp6I=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=EZgjNSLqJn5cU++RhHH2jQYmZKCRB6VQ7iDYhW5JPCDPpOTJNdH/TljPkfRx+p3mP
         990eOjIRSghaM8amzSRUEwoLjbShaj/QMqzQbiBR4jjNxfkKR1tet3MqAZlHqfrQAd
         tViKjgQdzduMqXRbNfiqfpxiST+Ou0MTWlqYpoB0=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Aditya Pakki <pakki001@umn.edu>,
        Dan Williams <dan.j.williams@intel.com>
Subject: [PATCH 105/190] Revert "libnvdimm/btt: Fix a kmemdup failure check"
Date:   Wed, 21 Apr 2021 14:59:40 +0200
Message-Id: <20210421130105.1226686-106-gregkh@linuxfoundation.org>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20210421130105.1226686-1-gregkh@linuxfoundation.org>
References: <20210421130105.1226686-1-gregkh@linuxfoundation.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This reverts commit 486fa92df4707b5df58d6508728bdb9321a59766.

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

Cc: Aditya Pakki <pakki001@umn.edu>
Cc: Dan Williams <dan.j.williams@intel.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/nvdimm/btt_devs.c | 18 +++++-------------
 1 file changed, 5 insertions(+), 13 deletions(-)

diff --git a/drivers/nvdimm/btt_devs.c b/drivers/nvdimm/btt_devs.c
index 05feb97e11ce..995573905dfb 100644
--- a/drivers/nvdimm/btt_devs.c
+++ b/drivers/nvdimm/btt_devs.c
@@ -191,15 +191,14 @@ static struct device *__nd_btt_create(struct nd_region *nd_region,
 		return NULL;
 
 	nd_btt->id = ida_simple_get(&nd_region->btt_ida, 0, 0, GFP_KERNEL);
-	if (nd_btt->id < 0)
-		goto out_nd_btt;
+	if (nd_btt->id < 0) {
+		kfree(nd_btt);
+		return NULL;
+	}
 
 	nd_btt->lbasize = lbasize;
-	if (uuid) {
+	if (uuid)
 		uuid = kmemdup(uuid, 16, GFP_KERNEL);
-		if (!uuid)
-			goto out_put_id;
-	}
 	nd_btt->uuid = uuid;
 	dev = &nd_btt->dev;
 	dev_set_name(dev, "btt%d.%d", nd_region->id, nd_btt->id);
@@ -213,13 +212,6 @@ static struct device *__nd_btt_create(struct nd_region *nd_region,
 		return NULL;
 	}
 	return dev;
-
-out_put_id:
-	ida_simple_remove(&nd_region->btt_ida, nd_btt->id);
-
-out_nd_btt:
-	kfree(nd_btt);
-	return NULL;
 }
 
 struct device *nd_btt_create(struct nd_region *nd_region)
-- 
2.31.1

