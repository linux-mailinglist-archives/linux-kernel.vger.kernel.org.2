Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 32406366C6F
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Apr 2021 15:18:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237669AbhDUNRV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 21 Apr 2021 09:17:21 -0400
Received: from mail.kernel.org ([198.145.29.99]:47284 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S241267AbhDUNIB (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Apr 2021 09:08:01 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 2849761480;
        Wed, 21 Apr 2021 13:07:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1619010440;
        bh=wtP7V2PQvqfWwW+gmsxYqZZb/ZPb4vsX9z/jnT7oZ74=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=ucL3rWllorL1i/OKGkshDSpjybAQUAyN8DFAqxXyhow4uvEONC3Vy1wigP//m7GmB
         Jz+hA5/vIPYZjhPT2P5Kn8s50heLtpDdK0Qwm5VtcWmV7URreEC3INwNmisZQtvdAA
         ecf3/KWGsf9qDLuazWLVjasESr+XyAi/D0ujpBLE=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Kangjie Lu <kjlu@umn.edu>,
        "David S . Miller" <davem@davemloft.net>
Subject: [PATCH 136/190] Revert "net: thunder: fix a potential NULL pointer dereference"
Date:   Wed, 21 Apr 2021 15:00:11 +0200
Message-Id: <20210421130105.1226686-137-gregkh@linuxfoundation.org>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20210421130105.1226686-1-gregkh@linuxfoundation.org>
References: <20210421130105.1226686-1-gregkh@linuxfoundation.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This reverts commit 0b31d98d90f09868dce71319615e19cd1f146fb6.

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
 drivers/net/ethernet/cavium/thunder/nicvf_main.c | 6 ------
 1 file changed, 6 deletions(-)

diff --git a/drivers/net/ethernet/cavium/thunder/nicvf_main.c b/drivers/net/ethernet/cavium/thunder/nicvf_main.c
index c33b4e837515..b10608c55db0 100644
--- a/drivers/net/ethernet/cavium/thunder/nicvf_main.c
+++ b/drivers/net/ethernet/cavium/thunder/nicvf_main.c
@@ -2246,12 +2246,6 @@ static int nicvf_probe(struct pci_dev *pdev, const struct pci_device_id *ent)
 	nic->nicvf_rx_mode_wq = alloc_ordered_workqueue("nicvf_rx_mode_wq_VF%d",
 							WQ_MEM_RECLAIM,
 							nic->vf_id);
-	if (!nic->nicvf_rx_mode_wq) {
-		err = -ENOMEM;
-		dev_err(dev, "Failed to allocate work queue\n");
-		goto err_unregister_interrupts;
-	}
-
 	INIT_WORK(&nic->rx_mode_work.work, nicvf_set_rx_mode_task);
 	spin_lock_init(&nic->rx_mode_wq_lock);
 
-- 
2.31.1

