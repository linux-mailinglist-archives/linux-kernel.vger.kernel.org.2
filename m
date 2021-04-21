Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9E79F366BC9
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Apr 2021 15:06:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240915AbhDUNG7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 21 Apr 2021 09:06:59 -0400
Received: from mail.kernel.org ([198.145.29.99]:46346 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S240740AbhDUNF2 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Apr 2021 09:05:28 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id CAD4A6145C;
        Wed, 21 Apr 2021 13:04:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1619010294;
        bh=tE+D+vYphl1bcUm/plWHwtNMf6M3/jFBB6k7VRySKu8=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=WrStUColLrjrtCTV+zcoFsp2ozcy7jAnVd6SouPFFkS1ufJKVXn3dTU0C5fOBwFVf
         b2hMocrL1tmXtp4AZb8khXOlCV0xDsFFtZMLw/fgaeYR8FSZLWcBUm8n7e8744LsxF
         lhHFkHHZRghK7bpJZFMpNgZlBeSc0NfB8FGHHEd4=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Kangjie Lu <kjlu@umn.edu>, Mukesh Ojha <mojha@codeaurora.org>,
        Stefan Schmidt <stefan@datenfreihafen.org>
Subject: [PATCH 084/190] Revert "net: ieee802154: fix missing checks for regmap_update_bits"
Date:   Wed, 21 Apr 2021 14:59:19 +0200
Message-Id: <20210421130105.1226686-85-gregkh@linuxfoundation.org>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20210421130105.1226686-1-gregkh@linuxfoundation.org>
References: <20210421130105.1226686-1-gregkh@linuxfoundation.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This reverts commit 22e8860cf8f777fbf6a83f2fb7127f682a8e9de4.

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
Cc: Mukesh Ojha <mojha@codeaurora.org>
Cc: Stefan Schmidt <stefan@datenfreihafen.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/net/ieee802154/mcr20a.c | 6 ------
 1 file changed, 6 deletions(-)

diff --git a/drivers/net/ieee802154/mcr20a.c b/drivers/net/ieee802154/mcr20a.c
index 8dc04e2590b1..2ce5b41983f8 100644
--- a/drivers/net/ieee802154/mcr20a.c
+++ b/drivers/net/ieee802154/mcr20a.c
@@ -524,8 +524,6 @@ mcr20a_start(struct ieee802154_hw *hw)
 	dev_dbg(printdev(lp), "no slotted operation\n");
 	ret = regmap_update_bits(lp->regmap_dar, DAR_PHY_CTRL1,
 				 DAR_PHY_CTRL1_SLOTTED, 0x0);
-	if (ret < 0)
-		return ret;
 
 	/* enable irq */
 	enable_irq(lp->spi->irq);
@@ -533,15 +531,11 @@ mcr20a_start(struct ieee802154_hw *hw)
 	/* Unmask SEQ interrupt */
 	ret = regmap_update_bits(lp->regmap_dar, DAR_PHY_CTRL2,
 				 DAR_PHY_CTRL2_SEQMSK, 0x0);
-	if (ret < 0)
-		return ret;
 
 	/* Start the RX sequence */
 	dev_dbg(printdev(lp), "start the RX sequence\n");
 	ret = regmap_update_bits(lp->regmap_dar, DAR_PHY_CTRL1,
 				 DAR_PHY_CTRL1_XCVSEQ_MASK, MCR20A_XCVSEQ_RX);
-	if (ret < 0)
-		return ret;
 
 	return 0;
 }
-- 
2.31.1

