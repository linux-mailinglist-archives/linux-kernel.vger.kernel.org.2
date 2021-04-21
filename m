Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3F7CF366B92
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Apr 2021 15:03:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240357AbhDUNDd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 21 Apr 2021 09:03:33 -0400
Received: from mail.kernel.org ([198.145.29.99]:43068 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S240359AbhDUNDU (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Apr 2021 09:03:20 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 6D00C6142F;
        Wed, 21 Apr 2021 13:02:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1619010167;
        bh=xG5knZPm185ejwvtN+fdLP+TxqkuOy5JUHYARZjxZR4=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=U4CN2ulN4GN7SKvghKORS83DFcdAem0o97vdjRyyNwVOyoK99t0+TvfYfmTvZaySV
         8+i1GT7jqxgW70enhDwi0BYDmr3vSErrssiv3qTliyk+tKYNMZ2VNRMDcBplDL72WP
         BZ8EAlg3UDC2tUdIsfGV0i19ecGzHF8K3VwAaPcg=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Aditya Pakki <pakki001@umn.edu>,
        Hans Verkuil <hverkuil-cisco@xs4all.nl>,
        Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
Subject: [PATCH 002/190] Revert "media: st-delta: Fix reference count leak in delta_run_work"
Date:   Wed, 21 Apr 2021 14:57:57 +0200
Message-Id: <20210421130105.1226686-3-gregkh@linuxfoundation.org>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20210421130105.1226686-1-gregkh@linuxfoundation.org>
References: <20210421130105.1226686-1-gregkh@linuxfoundation.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This reverts commit 57cc666d36adc7b45e37ba4cd7bc4e44ec4c43d7.

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
Cc: Hans Verkuil <hverkuil-cisco@xs4all.nl>
Cc: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/media/platform/sti/delta/delta-v4l2.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/drivers/media/platform/sti/delta/delta-v4l2.c b/drivers/media/platform/sti/delta/delta-v4l2.c
index c691b3d81549..2503224eeee5 100644
--- a/drivers/media/platform/sti/delta/delta-v4l2.c
+++ b/drivers/media/platform/sti/delta/delta-v4l2.c
@@ -954,10 +954,8 @@ static void delta_run_work(struct work_struct *work)
 	/* enable the hardware */
 	if (!dec->pm) {
 		ret = delta_get_sync(ctx);
-		if (ret) {
-			delta_put_autosuspend(ctx);
+		if (ret)
 			goto err;
-		}
 	}
 
 	/* decode this access unit */
-- 
2.31.1

