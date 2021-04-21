Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 39A2D366C41
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Apr 2021 15:12:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241511AbhDUNNS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 21 Apr 2021 09:13:18 -0400
Received: from mail.kernel.org ([198.145.29.99]:49410 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S241644AbhDUNJO (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Apr 2021 09:09:14 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 08BE36145E;
        Wed, 21 Apr 2021 13:08:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1619010520;
        bh=2KVYXg4Amks15meF9byRNYhsGm/+/NeCSiwRyynZ3PE=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=BVNWY/nNtx7nPmK4BOL4vAsbNuufI0J2/fJCVd7yNP4XmiiWNXGY5/zHla+M2RDeD
         wqxUtEhQmDtmRueM6XJ55cgM9kxVO49J7bQYkHZFZ7LjNAtY+UMJbJwvd+B/xvY5Bf
         di83HlYWbWsIa5U/7FwYLG87Z4TlxaybDoPOzc3s=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Aditya Pakki <pakki001@umn.edu>,
        Devesh Sharma <devesh.sharma@broadcom.com>,
        Jason Gunthorpe <jgg@mellanox.com>
Subject: [PATCH 166/190] Revert "infiniband: bnxt_re: qplib: Check the return value of send_message"
Date:   Wed, 21 Apr 2021 15:00:41 +0200
Message-Id: <20210421130105.1226686-167-gregkh@linuxfoundation.org>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20210421130105.1226686-1-gregkh@linuxfoundation.org>
References: <20210421130105.1226686-1-gregkh@linuxfoundation.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This reverts commit 94edd87a1c59f3efa6fdf4e98d6d492e6cec6173.

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
Cc: Devesh Sharma <devesh.sharma@broadcom.com>
Cc: Jason Gunthorpe <jgg@mellanox.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/infiniband/hw/bnxt_re/qplib_sp.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/drivers/infiniband/hw/bnxt_re/qplib_sp.c b/drivers/infiniband/hw/bnxt_re/qplib_sp.c
index 049b3576302b..c9cc03e2130c 100644
--- a/drivers/infiniband/hw/bnxt_re/qplib_sp.c
+++ b/drivers/infiniband/hw/bnxt_re/qplib_sp.c
@@ -775,8 +775,9 @@ int bnxt_qplib_map_tc2cos(struct bnxt_qplib_res *res, u16 *cids)
 	req.cos0 = cpu_to_le16(cids[0]);
 	req.cos1 = cpu_to_le16(cids[1]);
 
-	return bnxt_qplib_rcfw_send_message(rcfw, (void *)&req, (void *)&resp,
-						NULL, 0);
+	bnxt_qplib_rcfw_send_message(rcfw, (void *)&req, (void *)&resp, NULL,
+				     0);
+	return 0;
 }
 
 int bnxt_qplib_get_roce_stats(struct bnxt_qplib_rcfw *rcfw,
-- 
2.31.1

