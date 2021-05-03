Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2F574371506
	for <lists+linux-kernel@lfdr.de>; Mon,  3 May 2021 14:09:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233808AbhECME0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 3 May 2021 08:04:26 -0400
Received: from mail.kernel.org ([198.145.29.99]:37450 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S234132AbhECMCV (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 May 2021 08:02:21 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 26FD0611CB;
        Mon,  3 May 2021 12:01:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1620043287;
        bh=3G9nkghIRA/Abt3t1oEzpOOgsg9FrWllJJyHAYVX/rI=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=zG5c8dY+Z+mM8qseU3A8xG82eleVXqRBizWYHaZ1EQ0HffOFRzmRkfMLQJJuCmGUt
         NAfe7j4a5ejIzfa6z7MS4kqpAkRC5l9jXEgB2Vr3tf/yTqVwo5s3tgB+MRAlODz647
         YwYTSwuXoEC7wEMPre8zjZi5TdJQnLOxhF7A/qJk=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Kangjie Lu <kjlu@umn.edu>,
        "David S . Miller" <davem@davemloft.net>
Subject: [PATCH 40/69] Revert "isdn: mISDNinfineon: fix potential NULL pointer dereference"
Date:   Mon,  3 May 2021 13:57:07 +0200
Message-Id: <20210503115736.2104747-41-gregkh@linuxfoundation.org>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20210503115736.2104747-1-gregkh@linuxfoundation.org>
References: <20210503115736.2104747-1-gregkh@linuxfoundation.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This reverts commit d721fe99f6ada070ae8fc0ec3e01ce5a42def0d9.

Because of recent interactions with developers from @umn.edu, all
commits from them have been recently re-reviewed to ensure if they were
correct or not.

Upon review, this commit was found to be incorrect for the reasons
below, so it must be reverted.  It will be fixed up "correctly" in a
later kernel change.

The original commit was incorrect, it should have never have used
"unlikely()" and if it ever does trigger, resources are left grabbed.

Given there are no users for this code around, I'll just revert this and
leave it "as is" as the odds that ioremap() will ever fail here is
horrendiously low.

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

