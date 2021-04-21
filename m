Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F332B366BAB
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Apr 2021 15:04:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240783AbhDUNFL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 21 Apr 2021 09:05:11 -0400
Received: from mail.kernel.org ([198.145.29.99]:43838 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S240724AbhDUNER (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Apr 2021 09:04:17 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 3288A61456;
        Wed, 21 Apr 2021 13:03:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1619010224;
        bh=WiaT5Zae82YRFi67K4EqsuhyZXKsltlFHRzd5GC+MBw=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=SUN6rHM/rKBdm89pQ2hlnDgKh90oiaHlNW/1DrSHKnN/apGihvrpjUP8awvv2jR/T
         EX2aXAcfVOoMYHY6aA+d0opwRBMxwZiAJA9vk45SZTxPTOJtxQU2drZNo7ldHuDcJ9
         0MxemuoJkpAGTcj+7Ng2AbUTfeOm+qGjASv1RfWo=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Aditya Pakki <pakki001@umn.edu>,
        Hans Verkuil <hverkuil-cisco@xs4all.nl>,
        Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
Subject: [PATCH 057/190] Revert "media: saa7146: Avoid using BUG_ON as an assertion"
Date:   Wed, 21 Apr 2021 14:58:52 +0200
Message-Id: <20210421130105.1226686-58-gregkh@linuxfoundation.org>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20210421130105.1226686-1-gregkh@linuxfoundation.org>
References: <20210421130105.1226686-1-gregkh@linuxfoundation.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This reverts commit 1ec4c6efe23154b4ab44c1a34dbc0eb121eb614a.

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
 drivers/media/common/saa7146/saa7146_video.c | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/drivers/media/common/saa7146/saa7146_video.c b/drivers/media/common/saa7146/saa7146_video.c
index 7b8795eca589..d9d7d82ca451 100644
--- a/drivers/media/common/saa7146/saa7146_video.c
+++ b/drivers/media/common/saa7146/saa7146_video.c
@@ -345,8 +345,7 @@ static int video_begin(struct saa7146_fh *fh)
 
 	fmt = saa7146_format_by_fourcc(dev, vv->video_fmt.pixelformat);
 	/* we need to have a valid format set here */
-	if (!fmt)
-		return -EINVAL;
+	BUG_ON(NULL == fmt);
 
 	if (0 != (fmt->flags & FORMAT_IS_PLANAR)) {
 		resource = RESOURCE_DMA1_HPS|RESOURCE_DMA2_CLP|RESOURCE_DMA3_BRS;
@@ -399,8 +398,7 @@ static int video_end(struct saa7146_fh *fh, struct file *file)
 
 	fmt = saa7146_format_by_fourcc(dev, vv->video_fmt.pixelformat);
 	/* we need to have a valid format set here */
-	if (!fmt)
-		return -EINVAL;
+	BUG_ON(NULL == fmt);
 
 	if (0 != (fmt->flags & FORMAT_IS_PLANAR)) {
 		resource = RESOURCE_DMA1_HPS|RESOURCE_DMA2_CLP|RESOURCE_DMA3_BRS;
-- 
2.31.1

