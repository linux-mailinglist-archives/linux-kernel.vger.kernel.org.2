Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CEE3F366C77
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Apr 2021 15:18:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236364AbhDUNRl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 21 Apr 2021 09:17:41 -0400
Received: from mail.kernel.org ([198.145.29.99]:48956 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S241356AbhDUNIN (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Apr 2021 09:08:13 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id E71BB61452;
        Wed, 21 Apr 2021 13:07:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1619010451;
        bh=z9z/OMQPrFnKnfkxl8Jezf87j9Fh3GM9kTn22fZiR3k=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=CGw7mkEpmtdjT/kcBI8gcDxLjLblWTE1BL7be0TszAGmMs5ceDJoZCLTXOk/CJ7MD
         04IAaRqgT4Zo0lTkRLPVRJgM2nX3VRGynjyY/PG007ncc4TZr9vl1L3HlkPf6Bpjdn
         UZWkkfLp9nfXgPR3yf1fLiV4upoTj8zJY9ksWUXI=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Aditya Pakki <pakki001@umn.edu>,
        "David S . Miller" <davem@davemloft.net>
Subject: [PATCH 140/190] Revert "isdn: mISDN: Fix potential NULL pointer dereference of kzalloc"
Date:   Wed, 21 Apr 2021 15:00:15 +0200
Message-Id: <20210421130105.1226686-141-gregkh@linuxfoundation.org>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20210421130105.1226686-1-gregkh@linuxfoundation.org>
References: <20210421130105.1226686-1-gregkh@linuxfoundation.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This reverts commit 38d22659803a033b1b66cd2624c33570c0dde77d.

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
Cc: David S. Miller <davem@davemloft.net>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/isdn/hardware/mISDN/hfcsusb.c | 3 ---
 1 file changed, 3 deletions(-)

diff --git a/drivers/isdn/hardware/mISDN/hfcsusb.c b/drivers/isdn/hardware/mISDN/hfcsusb.c
index 70061991915a..4bb470d3963d 100644
--- a/drivers/isdn/hardware/mISDN/hfcsusb.c
+++ b/drivers/isdn/hardware/mISDN/hfcsusb.c
@@ -249,9 +249,6 @@ hfcsusb_ph_info(struct hfcsusb *hw)
 	int i;
 
 	phi = kzalloc(struct_size(phi, bch, dch->dev.nrbchan), GFP_ATOMIC);
-	if (!phi)
-		return;
-
 	phi->dch.ch.protocol = hw->protocol;
 	phi->dch.ch.Flags = dch->Flags;
 	phi->dch.state = dch->state;
-- 
2.31.1

