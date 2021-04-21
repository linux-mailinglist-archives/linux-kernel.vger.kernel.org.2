Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1EACC366BB0
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Apr 2021 15:05:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239346AbhDUNFZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 21 Apr 2021 09:05:25 -0400
Received: from mail.kernel.org ([198.145.29.99]:43838 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S239499AbhDUNE2 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Apr 2021 09:04:28 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 75B7D6143B;
        Wed, 21 Apr 2021 13:03:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1619010235;
        bh=ddu+4co7Kt9tLyVFX3hnwu31l+5r/KYvdlwr2dFv+rA=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Cx7foaBSEhT9rwU9xnePVfbjeEqzXGhD+q3Sfny/gNH75tNN4Jk11TBr3SqOMPK3v
         vVZekQSydZRoW6h5Bk00yO6LlbEenIe1m1xyu7MgH/8CnjQshKoBNZLbtr/b0BgDPz
         lhX7gsJAQwXhomd0989eBVVrvWOGJFFcznscjwts=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Aditya Pakki <pakki001@umn.edu>
Subject: [PATCH 060/190] Revert "staging: kpc2000: remove unnecessary assertions in kpc_dma_transfer"
Date:   Wed, 21 Apr 2021 14:58:55 +0200
Message-Id: <20210421130105.1226686-61-gregkh@linuxfoundation.org>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20210421130105.1226686-1-gregkh@linuxfoundation.org>
References: <20210421130105.1226686-1-gregkh@linuxfoundation.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This reverts commit d7a336d67ab5443a0ef14b8335d139e855e8a682.

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
Cc: https
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/staging/kpc2000/kpc_dma/fileops.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/staging/kpc2000/kpc_dma/fileops.c b/drivers/staging/kpc2000/kpc_dma/fileops.c
index 10dcd6646b01..7fdad86044ca 100644
--- a/drivers/staging/kpc2000/kpc_dma/fileops.c
+++ b/drivers/staging/kpc2000/kpc_dma/fileops.c
@@ -49,7 +49,9 @@ static int kpc_dma_transfer(struct dev_private_data *priv,
 	u64 dma_addr;
 	u64 user_ctl;
 
+	BUG_ON(priv == NULL);
 	ldev = priv->ldev;
+	BUG_ON(ldev == NULL);
 
 	acd = kzalloc(sizeof(*acd), GFP_KERNEL);
 	if (!acd) {
-- 
2.31.1

