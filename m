Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8C481366C12
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Apr 2021 15:10:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241681AbhDUNJQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 21 Apr 2021 09:09:16 -0400
Received: from mail.kernel.org ([198.145.29.99]:46884 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S241033AbhDUNGq (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Apr 2021 09:06:46 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 49E4261477;
        Wed, 21 Apr 2021 13:06:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1619010369;
        bh=23ldNKy3hV6pudqhZXpZA4qAPN/pyit8dk3C+COTKh8=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=L7N6nrApSR4NHikwq1AAJ8RXJPbiV29NSRW99yFX35Cmc1CG7txTyE1E4RJHmJQ+v
         uLBSSaLyHM9sP6pLLhpS5/0TXnhxHh9IbBse57U4JsYxNOb+IdpHCPdbhNx56EN8ep
         N0LL93aZjPETsOx2V9/fyb4+0udwHIS4uGtUMw8A=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Kangjie Lu <kjlu@umn.edu>,
        Andrew Bowers <andrewx.bowers@intel.com>,
        Mukesh Ojha <mojha@codeaurora.org>,
        Jeff Kirsher <jeffrey.t.kirsher@intel.com>
Subject: [PATCH 076/190] Revert "net: ixgbevf: fix a missing check of ixgbevf_write_msg_read_ack"
Date:   Wed, 21 Apr 2021 14:59:11 +0200
Message-Id: <20210421130105.1226686-77-gregkh@linuxfoundation.org>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20210421130105.1226686-1-gregkh@linuxfoundation.org>
References: <20210421130105.1226686-1-gregkh@linuxfoundation.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This reverts commit 20d437ee8f4899573e6ea76c06ef0206e98bccb6.

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
Cc: Andrew Bowers <andrewx.bowers@intel.com>
Cc: Mukesh Ojha <mojha@codeaurora.org>
Cc: Jeff Kirsher <jeffrey.t.kirsher@intel.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/net/ethernet/intel/ixgbevf/vf.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/drivers/net/ethernet/intel/ixgbevf/vf.c b/drivers/net/ethernet/intel/ixgbevf/vf.c
index bfe6dfcec4ab..501823f2d1c0 100644
--- a/drivers/net/ethernet/intel/ixgbevf/vf.c
+++ b/drivers/net/ethernet/intel/ixgbevf/vf.c
@@ -508,8 +508,9 @@ static s32 ixgbevf_update_mc_addr_list_vf(struct ixgbe_hw *hw,
 		vector_list[i++] = ixgbevf_mta_vector(hw, ha->addr);
 	}
 
-	return ixgbevf_write_msg_read_ack(hw, msgbuf, msgbuf,
-			IXGBE_VFMAILBOX_SIZE);
+	ixgbevf_write_msg_read_ack(hw, msgbuf, msgbuf, IXGBE_VFMAILBOX_SIZE);
+
+	return 0;
 }
 
 /**
-- 
2.31.1

