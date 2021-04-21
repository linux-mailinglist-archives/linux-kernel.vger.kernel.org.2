Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 14F4B366B77
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Apr 2021 15:02:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240075AbhDUNCP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 21 Apr 2021 09:02:15 -0400
Received: from mail.kernel.org ([198.145.29.99]:41188 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S239191AbhDUNCO (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Apr 2021 09:02:14 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id E71C56144C;
        Wed, 21 Apr 2021 13:01:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1619010097;
        bh=50pMkKJqasAq0okfm7f3txXDv9t77z83Ua+pGhFTRgo=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=d1HmBJ2bcGLPCId//cficMOFtLR127ivZ4qi/niUuWyXNmbNs3l8Xup6nWLnBU0mP
         ShpW2q+kv+YwmWaTSaWwLUppMhbb1B/G5bz34DGKHt+uJaTqyhU4YGmN1U5HW18cEx
         Ib35QYskNGtSdqxgAwgRs450mD8i72jm+ZmcFrFM=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Qiushi Wu <wu000273@umn.edu>, Heiko Stuebner <heiko@sntech.de>,
        Hans Verkuil <hverkuil-cisco@xs4all.nl>,
        Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
Subject: [PATCH 012/190] Revert "media: rockchip/rga: Fix a reference count leak."
Date:   Wed, 21 Apr 2021 14:58:07 +0200
Message-Id: <20210421130105.1226686-13-gregkh@linuxfoundation.org>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20210421130105.1226686-1-gregkh@linuxfoundation.org>
References: <20210421130105.1226686-1-gregkh@linuxfoundation.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This reverts commit 884d638e0853c4b5f01eb6d048fc3b6239012404.

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
Cc: Heiko Stuebner <heiko@sntech.de>
Cc: Hans Verkuil <hverkuil-cisco@xs4all.nl>
Cc: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/media/platform/rockchip/rga/rga-buf.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/media/platform/rockchip/rga/rga-buf.c b/drivers/media/platform/rockchip/rga/rga-buf.c
index bf9a75b75083..36b821ccc1db 100644
--- a/drivers/media/platform/rockchip/rga/rga-buf.c
+++ b/drivers/media/platform/rockchip/rga/rga-buf.c
@@ -81,7 +81,6 @@ static int rga_buf_start_streaming(struct vb2_queue *q, unsigned int count)
 
 	ret = pm_runtime_get_sync(rga->dev);
 	if (ret < 0) {
-		pm_runtime_put_noidle(rga->dev);
 		rga_buf_return_buffers(q, VB2_BUF_STATE_QUEUED);
 		return ret;
 	}
-- 
2.31.1

