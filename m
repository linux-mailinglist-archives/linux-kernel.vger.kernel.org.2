Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A1243366BB1
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Apr 2021 15:05:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240739AbhDUNF0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 21 Apr 2021 09:05:26 -0400
Received: from mail.kernel.org ([198.145.29.99]:44950 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S240649AbhDUNEb (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Apr 2021 09:04:31 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 2AE7A6144B;
        Wed, 21 Apr 2021 13:03:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1619010237;
        bh=1yrkR4sWkO2FEI+pnnmh5i5hNQTaf+2bJ03+FNBUzKo=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=cOiuOBqtlbPKyzHOxspNxOyHnOn5/iJI9I9UM2u9gQY6zw9kYEhxHLlG3zMwykDa1
         6qBF6BRxu2eSuBU8JuDAuo4Sq6ikLbfPQsB8mSICLXPcGb8gKFD4mynxCLqK0qgf+V
         ajHWNqQdC82bzDjxPwAJwN+2aMVF6O14JNGEMkmw=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Aditya Pakki <pakki001@umn.edu>,
        Juergen Gross <jgross@suse.com>
Subject: [PATCH 061/190] Revert "xen/grant-table: remove multiple BUG_ON on gnttab_interface"
Date:   Wed, 21 Apr 2021 14:58:56 +0200
Message-Id: <20210421130105.1226686-62-gregkh@linuxfoundation.org>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20210421130105.1226686-1-gregkh@linuxfoundation.org>
References: <20210421130105.1226686-1-gregkh@linuxfoundation.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This reverts commit d6bd6cf9feb81737f9f64d2c1acf98fdaacebad1.

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
Cc: Juergen Gross <jgross@suse.com>
Cc: Juergen Gross <jgross@suse.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/xen/grant-table.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/drivers/xen/grant-table.c b/drivers/xen/grant-table.c
index 3729bea0c989..5065d36c602e 100644
--- a/drivers/xen/grant-table.c
+++ b/drivers/xen/grant-table.c
@@ -663,6 +663,7 @@ static int grow_gnttab_list(unsigned int more_frames)
 	unsigned int nr_glist_frames, new_nr_glist_frames;
 	unsigned int grefs_per_frame;
 
+	BUG_ON(gnttab_interface == NULL);
 	grefs_per_frame = gnttab_interface->grefs_per_grant_frame;
 
 	new_nr_grant_frames = nr_grant_frames + more_frames;
@@ -1281,6 +1282,7 @@ EXPORT_SYMBOL_GPL(gnttab_unmap_refs_sync);
 
 static unsigned int nr_status_frames(unsigned int nr_grant_frames)
 {
+	BUG_ON(gnttab_interface == NULL);
 	return gnttab_frames(nr_grant_frames, SPP);
 }
 
@@ -1508,6 +1510,7 @@ static int gnttab_expand(unsigned int req_entries)
 	int rc;
 	unsigned int cur, extra;
 
+	BUG_ON(gnttab_interface == NULL);
 	cur = nr_grant_frames;
 	extra = ((req_entries + gnttab_interface->grefs_per_grant_frame - 1) /
 		 gnttab_interface->grefs_per_grant_frame);
@@ -1542,6 +1545,7 @@ int gnttab_init(void)
 	/* Determine the maximum number of frames required for the
 	 * grant reference free list on the current hypervisor.
 	 */
+	BUG_ON(gnttab_interface == NULL);
 	max_nr_glist_frames = (max_nr_grant_frames *
 			       gnttab_interface->grefs_per_grant_frame / RPP);
 
-- 
2.31.1

