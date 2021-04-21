Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 28EBB366BB2
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Apr 2021 15:05:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239980AbhDUNFa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 21 Apr 2021 09:05:30 -0400
Received: from mail.kernel.org ([198.145.29.99]:44998 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S240679AbhDUNEe (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Apr 2021 09:04:34 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id DBB006143C;
        Wed, 21 Apr 2021 13:03:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1619010240;
        bh=XKKFUUm9Gw1dvPYXKJPlv9/EVtIYk9xsGQjFzqXhkN0=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=SWW9Tp1+YeFbu2inzRdD5aSWuYox49OfTIzcyVqfsiKjbubRXiJ8Z3zoao3+/EeSK
         d1aYWpGsGg5JwFvdxu3mGuOQGDyYs06H4GDtEdJsqXzj9PME+j3xzBtzYydiRp7KkT
         AmxL/9A0CIB9glQjSi+1zkP9h2jytG8P7z5tcpSw=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Hannes Reinecke <hare@suse.de>,
        Aditya Pakki <pakki001@umn.edu>,
        "Martin K . Petersen" <martin.petersen@oracle.com>
Subject: [PATCH 062/190] Revert "scsi: libfc: remove unnecessary assertion on ep variable"
Date:   Wed, 21 Apr 2021 14:58:57 +0200
Message-Id: <20210421130105.1226686-63-gregkh@linuxfoundation.org>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20210421130105.1226686-1-gregkh@linuxfoundation.org>
References: <20210421130105.1226686-1-gregkh@linuxfoundation.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This reverts commit 52b894393cecdc303990e834778d39b85d0553fc.

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

Cc: https
Cc: Hannes Reinecke <hare@suse.de>
Cc: Aditya Pakki <pakki001@umn.edu>
Cc: Martin K. Petersen <martin.petersen@oracle.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/target/tcm_fc/tfc_io.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/target/tcm_fc/tfc_io.c b/drivers/target/tcm_fc/tfc_io.c
index bbe2e29612fa..15d557a11f63 100644
--- a/drivers/target/tcm_fc/tfc_io.c
+++ b/drivers/target/tcm_fc/tfc_io.c
@@ -220,6 +220,7 @@ void ft_recv_write_data(struct ft_cmd *cmd, struct fc_frame *fp)
 	ep = fc_seq_exch(seq);
 	lport = ep->lp;
 	if (cmd->was_ddp_setup) {
+		BUG_ON(!ep);
 		BUG_ON(!lport);
 		/*
 		 * Since DDP (Large Rx offload) was setup for this request,
-- 
2.31.1

