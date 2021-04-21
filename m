Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1C9CA366BA6
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Apr 2021 15:04:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240669AbhDUNEL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 21 Apr 2021 09:04:11 -0400
Received: from mail.kernel.org ([198.145.29.99]:43926 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S240547AbhDUNDu (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Apr 2021 09:03:50 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 124C161454;
        Wed, 21 Apr 2021 13:03:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1619010197;
        bh=ubg36tC0Z4bEqtOvHgsn6JKgOQttKO+sZAu1gCBRhW4=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=wM1aTNTVJ46lTIxn+7PnYKNJAGOkfTP4J2AzOg51NpiqSYxomQhmA9Z0VyRQIxULM
         UK73cJmxZdBN34H03pGEEMkHwD5Iq4Pnl6nAA+NhxNE11HgDij5iqiT3NueEssc/8T
         bdb8JnmIBYmFvyHxpAmJRL8kB3txm1u9FsPh8gaI=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Qiushi Wu <wu000273@umn.edu>,
        "David S . Miller" <davem@davemloft.net>
Subject: [PATCH 048/190] Revert "net: sun: fix missing release regions in cas_init_one()."
Date:   Wed, 21 Apr 2021 14:58:43 +0200
Message-Id: <20210421130105.1226686-49-gregkh@linuxfoundation.org>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20210421130105.1226686-1-gregkh@linuxfoundation.org>
References: <20210421130105.1226686-1-gregkh@linuxfoundation.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This reverts commit 5a730153984dd13f82ffae93d7170d76eba204e9.

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

Cc: Qiushi Wu <wu000273@umn.edu>
Cc: David S. Miller <davem@davemloft.net>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/net/ethernet/sun/cassini.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/sun/cassini.c b/drivers/net/ethernet/sun/cassini.c
index 9ff894ba8d3e..d9cdf51c5a33 100644
--- a/drivers/net/ethernet/sun/cassini.c
+++ b/drivers/net/ethernet/sun/cassini.c
@@ -4956,7 +4956,7 @@ static int cas_init_one(struct pci_dev *pdev, const struct pci_device_id *ent)
 					  cas_cacheline_size)) {
 			dev_err(&pdev->dev, "Could not set PCI cache "
 			       "line size\n");
-			goto err_out_free_res;
+			goto err_write_cacheline;
 		}
 	}
 #endif
@@ -5128,6 +5128,7 @@ static int cas_init_one(struct pci_dev *pdev, const struct pci_device_id *ent)
 err_out_free_res:
 	pci_release_regions(pdev);
 
+err_write_cacheline:
 	/* Try to restore it in case the error occurred after we
 	 * set it.
 	 */
-- 
2.31.1

