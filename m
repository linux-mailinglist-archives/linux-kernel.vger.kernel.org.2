Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DA18C366C13
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Apr 2021 15:10:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241819AbhDUNJZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 21 Apr 2021 09:09:25 -0400
Received: from mail.kernel.org ([198.145.29.99]:47076 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S240868AbhDUNG4 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Apr 2021 09:06:56 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id B8E196144C;
        Wed, 21 Apr 2021 13:06:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1619010375;
        bh=aY1sRReZ51ihhxXjyplDI+E7R9+vk6u6U628NCAlhKM=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=2bW4jFTBDhdlZBSq7lYdOo/+JjF5dVhHejc4O5mT2pRdbUUpYD7BGOoTuyO8xG+wN
         ElLwLbkia2JKWTjiNrOYWQuZJHf8+L8Eth2cR+ga9VcuUrPjyHYzv9b5xEzD8ZfvK4
         NCSN4//ZqtmSIAQdbDNDXl1UOFJhsqF6Zi9kGoys=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Kangjie Lu <kjlu@umn.edu>, David Sterba <dsterba@suse.com>
Subject: [PATCH 106/190] Revert "tty: ipwireless: fix missing checks for ioremap"
Date:   Wed, 21 Apr 2021 14:59:41 +0200
Message-Id: <20210421130105.1226686-107-gregkh@linuxfoundation.org>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20210421130105.1226686-1-gregkh@linuxfoundation.org>
References: <20210421130105.1226686-1-gregkh@linuxfoundation.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This reverts commit 1bbb1c318cd8a3a39e8c3e2e83d5e90542d6c3e3.

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
Cc: David Sterba <dsterba@suse.com>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/tty/ipwireless/main.c | 8 --------
 1 file changed, 8 deletions(-)

diff --git a/drivers/tty/ipwireless/main.c b/drivers/tty/ipwireless/main.c
index 4c18bbfe1a92..3475e841ef5c 100644
--- a/drivers/tty/ipwireless/main.c
+++ b/drivers/tty/ipwireless/main.c
@@ -114,10 +114,6 @@ static int ipwireless_probe(struct pcmcia_device *p_dev, void *priv_data)
 
 	ipw->common_memory = ioremap(p_dev->resource[2]->start,
 				resource_size(p_dev->resource[2]));
-	if (!ipw->common_memory) {
-		ret = -ENOMEM;
-		goto exit1;
-	}
 	if (!request_mem_region(p_dev->resource[2]->start,
 				resource_size(p_dev->resource[2]),
 				IPWIRELESS_PCCARD_NAME)) {
@@ -138,10 +134,6 @@ static int ipwireless_probe(struct pcmcia_device *p_dev, void *priv_data)
 
 	ipw->attr_memory = ioremap(p_dev->resource[3]->start,
 				resource_size(p_dev->resource[3]));
-	if (!ipw->attr_memory) {
-		ret = -ENOMEM;
-		goto exit3;
-	}
 	if (!request_mem_region(p_dev->resource[3]->start,
 				resource_size(p_dev->resource[3]),
 				IPWIRELESS_PCCARD_NAME)) {
-- 
2.31.1

