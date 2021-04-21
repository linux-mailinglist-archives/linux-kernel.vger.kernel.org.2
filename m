Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 41D27366C83
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Apr 2021 15:20:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242285AbhDUNTV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 21 Apr 2021 09:19:21 -0400
Received: from mail.kernel.org ([198.145.29.99]:52246 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S242182AbhDUNJw (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Apr 2021 09:09:52 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id F0E1361455;
        Wed, 21 Apr 2021 13:09:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1619010558;
        bh=QkfzxDfaZfGtpmoa/d+laslR7/OyV5I25yoNwC+3S/o=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=LtdO7aLiNC/anZpvFaLn6KweK8L34oUPNv0ihAu7Ni3h7J8w/OTRGPY5dcAKyYEmA
         LK4rgBudE7xUrJ2RKIsAY619OJqzPlknMyU2RISWDVReM/PNm6SGJxcDNzfO1luymJ
         TNeaPtO1v+XgtRb0lbDwPs0Idptpc4ASMQiMWDMU=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Kangjie Lu <kjlu@umn.edu>,
        "David S . Miller" <davem@davemloft.net>
Subject: [PATCH 178/190] Revert "net: netxen: fix a missing check and an uninitialized use"
Date:   Wed, 21 Apr 2021 15:00:53 +0200
Message-Id: <20210421130105.1226686-179-gregkh@linuxfoundation.org>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20210421130105.1226686-1-gregkh@linuxfoundation.org>
References: <20210421130105.1226686-1-gregkh@linuxfoundation.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This reverts commit d134e486e831defd26130770181f01dfc6195f7d.

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
 drivers/net/ethernet/qlogic/netxen/netxen_nic_init.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/net/ethernet/qlogic/netxen/netxen_nic_init.c b/drivers/net/ethernet/qlogic/netxen/netxen_nic_init.c
index 08f9477d2ee8..32b9e28dda16 100644
--- a/drivers/net/ethernet/qlogic/netxen/netxen_nic_init.c
+++ b/drivers/net/ethernet/qlogic/netxen/netxen_nic_init.c
@@ -1107,8 +1107,7 @@ netxen_validate_firmware(struct netxen_adapter *adapter)
 		return -EINVAL;
 	}
 	val = nx_get_bios_version(adapter);
-	if (netxen_rom_fast_read(adapter, NX_BIOS_VERSION_OFFSET, (int *)&bios))
-		return -EIO;
+	netxen_rom_fast_read(adapter, NX_BIOS_VERSION_OFFSET, (int *)&bios);
 	if ((__force u32)val != bios) {
 		dev_err(&pdev->dev, "%s: firmware bios is incompatible\n",
 				fw_name[fw_type]);
-- 
2.31.1

