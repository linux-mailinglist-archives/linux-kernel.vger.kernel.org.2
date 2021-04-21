Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BDCFF366B9B
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Apr 2021 15:03:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240519AbhDUNDw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 21 Apr 2021 09:03:52 -0400
Received: from mail.kernel.org ([198.145.29.99]:43568 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S240477AbhDUNDh (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Apr 2021 09:03:37 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 854946144C;
        Wed, 21 Apr 2021 13:03:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1619010184;
        bh=KbPl6jZnMtDxWQx4Uj/vKXABm2eho66AbnVO7BC3r4E=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=o5jSI9c6TSvyezPBfjIb2w03v9FZt2EczMO9S/tb8zFDs5qRaYGqJkLYpapoTvhWA
         oF306WBHRXDeAHMk7aYKeyy49L/pHfoZ0+A7637QqDKvFvYq6BOgt1ozgkf05KF/mL
         YK3d/qLQIWqscImpcwuNcRs4mMR1pZkY1hJKrYMk=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Qiushi Wu <wu000273@umn.edu>,
        "David S . Miller" <davem@davemloft.net>
Subject: [PATCH 043/190] Revert "qlcnic: fix missing release in qlcnic_83xx_interrupt_test."
Date:   Wed, 21 Apr 2021 14:58:38 +0200
Message-Id: <20210421130105.1226686-44-gregkh@linuxfoundation.org>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20210421130105.1226686-1-gregkh@linuxfoundation.org>
References: <20210421130105.1226686-1-gregkh@linuxfoundation.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This reverts commit 15c973858903009e995b2037683de29dfe968621.

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
 drivers/net/ethernet/qlogic/qlcnic/qlcnic_83xx_hw.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/drivers/net/ethernet/qlogic/qlcnic/qlcnic_83xx_hw.c b/drivers/net/ethernet/qlogic/qlcnic/qlcnic_83xx_hw.c
index d8882d0b6b49..edefeeff60f4 100644
--- a/drivers/net/ethernet/qlogic/qlcnic/qlcnic_83xx_hw.c
+++ b/drivers/net/ethernet/qlogic/qlcnic/qlcnic_83xx_hw.c
@@ -3649,7 +3649,7 @@ int qlcnic_83xx_interrupt_test(struct net_device *netdev)
 	ahw->diag_cnt = 0;
 	ret = qlcnic_alloc_mbx_args(&cmd, adapter, QLCNIC_CMD_INTRPT_TEST);
 	if (ret)
-		goto fail_mbx_args;
+		goto fail_diag_irq;
 
 	if (adapter->flags & QLCNIC_MSIX_ENABLED)
 		intrpt_id = ahw->intr_tbl[0].id;
@@ -3679,8 +3679,6 @@ int qlcnic_83xx_interrupt_test(struct net_device *netdev)
 
 done:
 	qlcnic_free_mbx_args(&cmd);
-
-fail_mbx_args:
 	qlcnic_83xx_diag_free_res(netdev, drv_sds_rings);
 
 fail_diag_irq:
-- 
2.31.1

