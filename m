Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 16ADF366BEA
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Apr 2021 15:08:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240286AbhDUNIe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 21 Apr 2021 09:08:34 -0400
Received: from mail.kernel.org ([198.145.29.99]:46576 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S239604AbhDUNGV (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Apr 2021 09:06:21 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id C2DFC6146D;
        Wed, 21 Apr 2021 13:05:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1619010348;
        bh=91wwQTLszap9hlXYtl2ct8GpI7EFi+4sg4UwdtlKRDE=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=E5bnp02GnUSFDs64DlVp9wlIYIR2YmGeRBMgtnVoDRNi/ZIEcSTgsirWdGHOOFTHD
         eQsROKJYoV4bcDIn6uzsJhq3I2V9uG0uBaR6jf6wjHn0t6srE9H9xv9KlFpNPq/PR9
         t04ynQb2W4vUr94IvAExUamzHNv5TACuT6wZGwI4=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Kangjie Lu <kjlu@umn.edu>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        Hans Verkuil <hverkuil-cisco@xs4all.nl>,
        Mauro Carvalho Chehab <mchehab+samsung@kernel.org>
Subject: [PATCH 102/190] Revert "media: video-mux: fix null pointer dereferences"
Date:   Wed, 21 Apr 2021 14:59:37 +0200
Message-Id: <20210421130105.1226686-103-gregkh@linuxfoundation.org>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20210421130105.1226686-1-gregkh@linuxfoundation.org>
References: <20210421130105.1226686-1-gregkh@linuxfoundation.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This reverts commit aeb0d0f581e2079868e64a2e5ee346d340376eae.

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
Cc: Philipp Zabel <p.zabel@pengutronix.de>
Cc: Hans Verkuil <hverkuil-cisco@xs4all.nl>
Cc: Mauro Carvalho Chehab <mchehab+samsung@kernel.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/media/platform/video-mux.c | 5 -----
 1 file changed, 5 deletions(-)

diff --git a/drivers/media/platform/video-mux.c b/drivers/media/platform/video-mux.c
index 133122e38515..a754e20850c2 100644
--- a/drivers/media/platform/video-mux.c
+++ b/drivers/media/platform/video-mux.c
@@ -442,14 +442,9 @@ static int video_mux_probe(struct platform_device *pdev)
 	vmux->active = -1;
 	vmux->pads = devm_kcalloc(dev, num_pads, sizeof(*vmux->pads),
 				  GFP_KERNEL);
-	if (!vmux->pads)
-		return -ENOMEM;
-
 	vmux->format_mbus = devm_kcalloc(dev, num_pads,
 					 sizeof(*vmux->format_mbus),
 					 GFP_KERNEL);
-	if (!vmux->format_mbus)
-		return -ENOMEM;
 
 	for (i = 0; i < num_pads; i++) {
 		vmux->pads[i].flags = (i < num_pads - 1) ? MEDIA_PAD_FL_SINK
-- 
2.31.1

