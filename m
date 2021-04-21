Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 310C2366C06
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Apr 2021 15:10:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240573AbhDUNKX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 21 Apr 2021 09:10:23 -0400
Received: from mail.kernel.org ([198.145.29.99]:46176 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S240190AbhDUNHq (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Apr 2021 09:07:46 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 64ABD61458;
        Wed, 21 Apr 2021 13:07:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1619010430;
        bh=Z5M1vDqlkja65SXgBTo/1DSiMwq/dNqYmwrQmMmlacw=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=s5VVF/ArdHO6lc9TVbfxOf88db2y2fUqISvp630gX+fWnZejvxqKReZqXrnF378+y
         MmbBvhGxmStIwlQWPX/6BQ65brDH0/KrLrlP52ONs2+mZ35GNwi9P9L72kZvfxVBWd
         rPtoU5UsD9HstSL6j8JzmZf9/Tj778gX3tJztDfM=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Kangjie Lu <kjlu@umn.edu>,
        "David S . Miller" <davem@davemloft.net>
Subject: [PATCH 133/190] Revert "net: qlogic: fix a potential NULL pointer dereference"
Date:   Wed, 21 Apr 2021 15:00:08 +0200
Message-Id: <20210421130105.1226686-134-gregkh@linuxfoundation.org>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20210421130105.1226686-1-gregkh@linuxfoundation.org>
References: <20210421130105.1226686-1-gregkh@linuxfoundation.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This reverts commit eb32cfcdef2305dc0e44a65d42801315669bb27e.

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
Cc: David S. Miller <davem@davemloft.net>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/net/ethernet/qlogic/qla3xxx.c | 6 ------
 1 file changed, 6 deletions(-)

diff --git a/drivers/net/ethernet/qlogic/qla3xxx.c b/drivers/net/ethernet/qlogic/qla3xxx.c
index 214e347097a7..50dbb8205e6c 100644
--- a/drivers/net/ethernet/qlogic/qla3xxx.c
+++ b/drivers/net/ethernet/qlogic/qla3xxx.c
@@ -3863,12 +3863,6 @@ static int ql3xxx_probe(struct pci_dev *pdev,
 	netif_stop_queue(ndev);
 
 	qdev->workqueue = create_singlethread_workqueue(ndev->name);
-	if (!qdev->workqueue) {
-		unregister_netdev(ndev);
-		err = -ENOMEM;
-		goto err_out_iounmap;
-	}
-
 	INIT_DELAYED_WORK(&qdev->reset_work, ql_reset_work);
 	INIT_DELAYED_WORK(&qdev->tx_timeout_work, ql_tx_timeout_work);
 	INIT_DELAYED_WORK(&qdev->link_state_work, ql_link_state_machine_work);
-- 
2.31.1

