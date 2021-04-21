Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 96756366C49
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Apr 2021 15:13:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242079AbhDUNNw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 21 Apr 2021 09:13:52 -0400
Received: from mail.kernel.org ([198.145.29.99]:52158 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S241816AbhDUNJZ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Apr 2021 09:09:25 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 93F1B61454;
        Wed, 21 Apr 2021 13:08:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1619010532;
        bh=b+WCiNdD5b7C4sxQkL4CjoBuwghl8oownnzhJX+7Jsk=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=bcvUBZLU9J3i+TDTNmfDhCgX7y23cvUOXSedFpIHtMDycgJEnnqhsYv/ISNVfI0BJ
         hNA/PPAxQJjpCEAQV7kwX+txCH8S+RPvnfLWgrR/NdDSN6HA4w2KCVK/YBn4DK5/bi
         lTp/0InPz1h69KteiakQHwdq6QwUggr/pSNw8d+A=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Kangjie Lu <kjlu@umn.edu>,
        "David S . Miller" <davem@davemloft.net>
Subject: [PATCH 170/190] Revert "net: dsa: bcm_sf2: Propagate error value from mdio_write"
Date:   Wed, 21 Apr 2021 15:00:45 +0200
Message-Id: <20210421130105.1226686-171-gregkh@linuxfoundation.org>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20210421130105.1226686-1-gregkh@linuxfoundation.org>
References: <20210421130105.1226686-1-gregkh@linuxfoundation.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This reverts commit e49505f7255be8ced695919c08a29bf2c3d79616.

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
 drivers/net/dsa/bcm_sf2.c | 7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

diff --git a/drivers/net/dsa/bcm_sf2.c b/drivers/net/dsa/bcm_sf2.c
index ba5d546d06aa..b4f3d458143a 100644
--- a/drivers/net/dsa/bcm_sf2.c
+++ b/drivers/net/dsa/bcm_sf2.c
@@ -361,10 +361,11 @@ static int bcm_sf2_sw_mdio_write(struct mii_bus *bus, int addr, int regnum,
 	 * send them to our master MDIO bus controller
 	 */
 	if (addr == BRCM_PSEUDO_PHY_ADDR && priv->indir_phy_mask & BIT(addr))
-		return bcm_sf2_sw_indir_rw(priv, 0, addr, regnum, val);
+		bcm_sf2_sw_indir_rw(priv, 0, addr, regnum, val);
 	else
-		return mdiobus_write_nested(priv->master_mii_bus, addr,
-				regnum, val);
+		mdiobus_write_nested(priv->master_mii_bus, addr, regnum, val);
+
+	return 0;
 }
 
 static irqreturn_t bcm_sf2_switch_0_isr(int irq, void *dev_id)
-- 
2.31.1

