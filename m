Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 829A8366C75
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Apr 2021 15:18:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241433AbhDUNRe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 21 Apr 2021 09:17:34 -0400
Received: from mail.kernel.org ([198.145.29.99]:48880 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S241331AbhDUNIH (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Apr 2021 09:08:07 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 702A461464;
        Wed, 21 Apr 2021 13:07:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1619010448;
        bh=0RnA7THINng5r4rLzEiNzx6YKN80iBzw2EN+VyF9vEc=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=XVEiQ1+t3CXpdtsjHeTiKwScHOHh+1h4Rt7MbOmTH0loeZmeebNv2SdvwgGD8e/e5
         /5KDqJvU8cyyeuAjzPtvSgo+Rof9SoFtf+tiMM8XZQeIO25e4rFBf+w93XqkONMmIM
         Cea87+Pd45g1Y4o+jTG+Y6yJUAw9CN+fzBsg6vy8=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Kangjie Lu <kjlu@umn.edu>,
        "David S . Miller" <davem@davemloft.net>
Subject: [PATCH 139/190] Revert "isdn: mISDNinfineon: fix potential NULL pointer dereference"
Date:   Wed, 21 Apr 2021 15:00:14 +0200
Message-Id: <20210421130105.1226686-140-gregkh@linuxfoundation.org>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20210421130105.1226686-1-gregkh@linuxfoundation.org>
References: <20210421130105.1226686-1-gregkh@linuxfoundation.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This reverts commit d721fe99f6ada070ae8fc0ec3e01ce5a42def0d9.

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
 drivers/isdn/hardware/mISDN/mISDNinfineon.c | 5 +----
 1 file changed, 1 insertion(+), 4 deletions(-)

diff --git a/drivers/isdn/hardware/mISDN/mISDNinfineon.c b/drivers/isdn/hardware/mISDN/mISDNinfineon.c
index a16c7a2a7f3d..fa9c491f9c38 100644
--- a/drivers/isdn/hardware/mISDN/mISDNinfineon.c
+++ b/drivers/isdn/hardware/mISDN/mISDNinfineon.c
@@ -697,11 +697,8 @@ setup_io(struct inf_hw *hw)
 				(ulong)hw->addr.start, (ulong)hw->addr.size);
 			return err;
 		}
-		if (hw->ci->addr_mode == AM_MEMIO) {
+		if (hw->ci->addr_mode == AM_MEMIO)
 			hw->addr.p = ioremap(hw->addr.start, hw->addr.size);
-			if (unlikely(!hw->addr.p))
-				return -ENOMEM;
-		}
 		hw->addr.mode = hw->ci->addr_mode;
 		if (debug & DEBUG_HW)
 			pr_notice("%s: IO addr %lx (%lu bytes) mode%d\n",
-- 
2.31.1

