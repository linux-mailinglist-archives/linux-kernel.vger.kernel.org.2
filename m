Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1B712366C56
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Apr 2021 15:18:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242294AbhDUNOa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 21 Apr 2021 09:14:30 -0400
Received: from mail.kernel.org ([198.145.29.99]:52246 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S241915AbhDUNJb (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Apr 2021 09:09:31 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id CED0B61458;
        Wed, 21 Apr 2021 13:08:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1619010538;
        bh=FHFS3KLl9FS4rtJDQct8uw++rnrMB+K7eCyNwmiwq4U=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=UnVzDtvZkilqmqjux3U5v5jxJf1ycLsebU4QKoGwmeldgjET4nycSNoZkdKSjhQuZ
         EymeyVpeuDVUkBkaglW5uQAiso0ldIeI0RzzEZuqvPHEbygftcx4plev+MfU8PkkPv
         mJyqlG0PNvFTChbAMipxBo66lTUfv4zZtAW6Hg/c=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Kangjie Lu <kjlu@umn.edu>,
        "David S . Miller" <davem@davemloft.net>
Subject: [PATCH 172/190] Revert "net: (cpts) fix a missing check of clk_prepare"
Date:   Wed, 21 Apr 2021 15:00:47 +0200
Message-Id: <20210421130105.1226686-173-gregkh@linuxfoundation.org>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20210421130105.1226686-1-gregkh@linuxfoundation.org>
References: <20210421130105.1226686-1-gregkh@linuxfoundation.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This reverts commit 2d822f2dbab7f4c820f72eb8570aacf3f35855bd.

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
 drivers/net/ethernet/ti/cpts.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/drivers/net/ethernet/ti/cpts.c b/drivers/net/ethernet/ti/cpts.c
index 43222a34cba0..60fde1bb9665 100644
--- a/drivers/net/ethernet/ti/cpts.c
+++ b/drivers/net/ethernet/ti/cpts.c
@@ -778,9 +778,7 @@ struct cpts *cpts_create(struct device *dev, void __iomem *regs,
 		return ERR_CAST(cpts->refclk);
 	}
 
-	ret = clk_prepare(cpts->refclk);
-	if (ret)
-		return ERR_PTR(ret);
+	clk_prepare(cpts->refclk);
 
 	cpts->cc.read = cpts_systim_read;
 	cpts->cc.mask = CLOCKSOURCE_MASK(32);
-- 
2.31.1

