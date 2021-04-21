Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BD9F5366C0E
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Apr 2021 15:10:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240924AbhDUNKp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 21 Apr 2021 09:10:45 -0400
Received: from mail.kernel.org ([198.145.29.99]:47370 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S238938AbhDUNIB (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Apr 2021 09:08:01 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id D72206147E;
        Wed, 21 Apr 2021 13:07:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1619010443;
        bh=7yGAf5A1jRppKIiobnQX1pnoToWg6+sjh6ZdDHaV4HI=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=l92zuvqgPPdnKh1+klceKXm+uIZOm4NFS1AtpX9Pl8i8dDAuABktZR4iG/bm+Mhr9
         CAFZqc90mdxukjAr+o2tc9O4QXn98HeoOKaVcqaznMHxfkhdRJgyEd/IpDOExAsk1F
         vVcfoyGxLb0Jdk5vZpngYJ/ZBuboB8PQET7Hqb8c=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Kangjie Lu <kjlu@umn.edu>,
        "David S . Miller" <davem@davemloft.net>
Subject: [PATCH 137/190] Revert "net: lio_core: fix two NULL pointer dereferences"
Date:   Wed, 21 Apr 2021 15:00:12 +0200
Message-Id: <20210421130105.1226686-138-gregkh@linuxfoundation.org>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20210421130105.1226686-1-gregkh@linuxfoundation.org>
References: <20210421130105.1226686-1-gregkh@linuxfoundation.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This reverts commit 41af8b3a097c6fd17a4867efa25966927094f57c.

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
 drivers/net/ethernet/cavium/liquidio/lio_core.c | 10 ----------
 1 file changed, 10 deletions(-)

diff --git a/drivers/net/ethernet/cavium/liquidio/lio_core.c b/drivers/net/ethernet/cavium/liquidio/lio_core.c
index 2a0d64e5797c..3532730eb936 100644
--- a/drivers/net/ethernet/cavium/liquidio/lio_core.c
+++ b/drivers/net/ethernet/cavium/liquidio/lio_core.c
@@ -1211,11 +1211,6 @@ int liquidio_change_mtu(struct net_device *netdev, int new_mtu)
 
 	sc = (struct octeon_soft_command *)
 		octeon_alloc_soft_command(oct, OCTNET_CMD_SIZE, 16, 0);
-	if (!sc) {
-		netif_info(lio, rx_err, lio->netdev,
-			   "Failed to allocate soft command\n");
-		return -ENOMEM;
-	}
 
 	ncmd = (union octnet_cmd *)sc->virtdptr;
 
@@ -1689,11 +1684,6 @@ int liquidio_set_fec(struct lio *lio, int on_off)
 
 	sc = octeon_alloc_soft_command(oct, OCTNET_CMD_SIZE,
 				       sizeof(struct oct_nic_seapi_resp), 0);
-	if (!sc) {
-		dev_err(&oct->pci_dev->dev,
-			"Failed to allocate soft command\n");
-		return -ENOMEM;
-	}
 
 	ncmd = sc->virtdptr;
 	resp = sc->virtrptr;
-- 
2.31.1

