Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A773D3714F8
	for <lists+linux-kernel@lfdr.de>; Mon,  3 May 2021 14:02:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233439AbhECMDI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 3 May 2021 08:03:08 -0400
Received: from mail.kernel.org ([198.145.29.99]:36968 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S234037AbhECMCC (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 May 2021 08:02:02 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 0A8CD613BB;
        Mon,  3 May 2021 12:01:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1620043268;
        bh=53O9R+bYuc3MmxJC1hlOKSRnlPyc6u9c1NfiZc3Jv1Y=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=P1SmPxud86OqNyjqNHE99jWTmNs/PCQIJ9zWkzzpJtz3wX3j1zTrD7PBfiQc9T66O
         HIjYDMd8Mf3uqEKESen5o8Q/pLkeF+wkhjLR6x6dFi3PwWeGRlW8YTrFMx/+MIYSZf
         tjZwjpjYlb2cO8r9l4D5TSL7DZBeR5ncYlYgBtVY=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Kangjie Lu <kjlu@umn.edu>,
        "David S . Miller" <davem@davemloft.net>
Subject: [PATCH 64/69] Revert "net: liquidio: fix a NULL pointer dereference"
Date:   Mon,  3 May 2021 13:57:31 +0200
Message-Id: <20210503115736.2104747-65-gregkh@linuxfoundation.org>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20210503115736.2104747-1-gregkh@linuxfoundation.org>
References: <20210503115736.2104747-1-gregkh@linuxfoundation.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This reverts commit fe543b2f174f34a7a751aa08b334fe6b105c4569.

Because of recent interactions with developers from @umn.edu, all
commits from them have been recently re-reviewed to ensure if they were
correct or not.

Upon review, this commit was found to be incorrect for the reasons
below, so it must be reverted.  It will be fixed up "correctly" in a
later kernel change.

While the original commit does keep the immediate "NULL dereference"
from happening, it does not properly propagate the error back to the
callers, AND it does not fix this same identical issue in the
drivers/net/ethernet/cavium/liquidio/lio_vf_main.c for some reason.

Cc: Kangjie Lu <kjlu@umn.edu>
Cc: David S. Miller <davem@davemloft.net>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/net/ethernet/cavium/liquidio/lio_main.c | 5 -----
 1 file changed, 5 deletions(-)

diff --git a/drivers/net/ethernet/cavium/liquidio/lio_main.c b/drivers/net/ethernet/cavium/liquidio/lio_main.c
index 7c5af4beedc6..6fa570068648 100644
--- a/drivers/net/ethernet/cavium/liquidio/lio_main.c
+++ b/drivers/net/ethernet/cavium/liquidio/lio_main.c
@@ -1166,11 +1166,6 @@ static void send_rx_ctrl_cmd(struct lio *lio, int start_stop)
 	sc = (struct octeon_soft_command *)
 		octeon_alloc_soft_command(oct, OCTNET_CMD_SIZE,
 					  16, 0);
-	if (!sc) {
-		netif_info(lio, rx_err, lio->netdev,
-			   "Failed to allocate octeon_soft_command\n");
-		return;
-	}
 
 	ncmd = (union octnet_cmd *)sc->virtdptr;
 
-- 
2.31.1

