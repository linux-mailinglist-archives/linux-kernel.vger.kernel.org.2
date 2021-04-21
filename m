Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AB41A366B79
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Apr 2021 15:02:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240112AbhDUNCT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 21 Apr 2021 09:02:19 -0400
Received: from mail.kernel.org ([198.145.29.99]:41408 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S240094AbhDUNCQ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Apr 2021 09:02:16 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 41415613DC;
        Wed, 21 Apr 2021 13:01:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1619010103;
        bh=jxckjqkTvkkwJtxmk4r4p7AWwqlkAtuCmy1fi8KOdEQ=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=yGlLFN7KWrckZPyBILOg5eJcO0dVSYrdhUzfLeItTeQRqpqegaHfhLJ/gWDGXhES0
         O/6FOyDXZdqhgWYV4NpWy/N8JXldLJtJ1jt61jSX+HSlO8AgMMSo+Lxa3gnrV5b0Cl
         3oKABvFsqnmCSXX8xHJkPjBIi5RxEpGypBKMF2+k=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Qiushi Wu <wu000273@umn.edu>,
        Hans Verkuil <hverkuil-cisco@xs4all.nl>,
        Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
Subject: [PATCH 014/190] Revert "media: rcar-vin: Fix a reference count leak."
Date:   Wed, 21 Apr 2021 14:58:09 +0200
Message-Id: <20210421130105.1226686-15-gregkh@linuxfoundation.org>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20210421130105.1226686-1-gregkh@linuxfoundation.org>
References: <20210421130105.1226686-1-gregkh@linuxfoundation.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This reverts commit aaffa0126a111d65f4028c503c76192d4cc93277.

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
Cc: Hans Verkuil <hverkuil-cisco@xs4all.nl>
Cc: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/media/platform/rcar-vin/rcar-dma.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/drivers/media/platform/rcar-vin/rcar-dma.c b/drivers/media/platform/rcar-vin/rcar-dma.c
index f30dafbdf61c..e109b3d0f4d1 100644
--- a/drivers/media/platform/rcar-vin/rcar-dma.c
+++ b/drivers/media/platform/rcar-vin/rcar-dma.c
@@ -1459,10 +1459,8 @@ int rvin_set_channel_routing(struct rvin_dev *vin, u8 chsel)
 	int ret;
 
 	ret = pm_runtime_get_sync(vin->dev);
-	if (ret < 0) {
-		pm_runtime_put_noidle(vin->dev);
+	if (ret < 0)
 		return ret;
-	}
 
 	/* Make register writes take effect immediately. */
 	vnmc = rvin_read(vin, VNMC_REG);
-- 
2.31.1

