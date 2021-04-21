Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EBCDE366BD3
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Apr 2021 15:06:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239839AbhDUNH0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 21 Apr 2021 09:07:26 -0400
Received: from mail.kernel.org ([198.145.29.99]:46720 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S236928AbhDUNFk (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Apr 2021 09:05:40 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 63B3061454;
        Wed, 21 Apr 2021 13:05:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1619010308;
        bh=iSKulrRmBlFONhrKe+nLABavZ756490dIAbF6AGDErU=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=dHxo48oJQ1ok/+2GnofoO7pO93jqPA+Qlcg7e0uGKvxXEWa6KJ9LBh6b98treUzL9
         VkyMJtk8tWtUMabjO3xBvV5Ci18z5t8yiZZitcZvDQB8v241UVM82L79aB7d1u/D8S
         t5WF35A+fg/4nKMptv2cCz/i32hGGsJU0eTrc+Tk=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Kangjie Lu <kjlu@umn.edu>,
        Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        Ulf Hansson <ulf.hansson@linaro.org>
Subject: [PATCH 088/190] Revert "mmc_spi: add a status check for spi_sync_locked"
Date:   Wed, 21 Apr 2021 14:59:23 +0200
Message-Id: <20210421130105.1226686-89-gregkh@linuxfoundation.org>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20210421130105.1226686-1-gregkh@linuxfoundation.org>
References: <20210421130105.1226686-1-gregkh@linuxfoundation.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This reverts commit 611025983b7976df0183390a63a2166411d177f1.

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
Cc: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Cc: Ulf Hansson <ulf.hansson@linaro.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/mmc/host/mmc_spi.c | 4 ----
 1 file changed, 4 deletions(-)

diff --git a/drivers/mmc/host/mmc_spi.c b/drivers/mmc/host/mmc_spi.c
index 02f4fd26e76a..cc40b050e302 100644
--- a/drivers/mmc/host/mmc_spi.c
+++ b/drivers/mmc/host/mmc_spi.c
@@ -800,10 +800,6 @@ mmc_spi_readblock(struct mmc_spi_host *host, struct spi_transfer *t,
 	}
 
 	status = spi_sync_locked(spi, &host->m);
-	if (status < 0) {
-		dev_dbg(&spi->dev, "read error %d\n", status);
-		return status;
-	}
 
 	if (host->dma_dev) {
 		dma_sync_single_for_cpu(host->dma_dev,
-- 
2.31.1

