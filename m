Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A6D16366BAA
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Apr 2021 15:04:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240779AbhDUNFE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 21 Apr 2021 09:05:04 -0400
Received: from mail.kernel.org ([198.145.29.99]:44536 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S240708AbhDUNEP (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Apr 2021 09:04:15 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 5119D61454;
        Wed, 21 Apr 2021 13:03:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1619010221;
        bh=pr7X+h9GjbcV/ufT0Hd0kw5jlUoROPdbO1QZWJeUVmw=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=lrAhZDg1idVobR+dc7J7a1z4WlnSkK2bKq9pvAhr9oYogezC3qOtBzRUk6YXXdKI1
         1G6QBuI6hcvzOiRdHNCW1rglXNq2VErvc3a3TZS5n3A/Rli9J8MMkfb7IxkwUGVexb
         IiV8g9gTEHk/nwJRIk+wI5hyM4jpYDYLPNyy5MpQ=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Aditya Pakki <pakki001@umn.edu>,
        Hans Verkuil <hverkuil-cisco@xs4all.nl>,
        Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
Subject: [PATCH 056/190] Revert "media: davinci/vpfe_capture.c: Avoid BUG_ON for register failure"
Date:   Wed, 21 Apr 2021 14:58:51 +0200
Message-Id: <20210421130105.1226686-57-gregkh@linuxfoundation.org>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20210421130105.1226686-1-gregkh@linuxfoundation.org>
References: <20210421130105.1226686-1-gregkh@linuxfoundation.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This reverts commit b0e4cfae483fe1e3db71ab2d8509490df60e52c6.

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
 drivers/media/platform/davinci/vpfe_capture.c | 31 +++++++++----------
 1 file changed, 15 insertions(+), 16 deletions(-)

diff --git a/drivers/media/platform/davinci/vpfe_capture.c b/drivers/media/platform/davinci/vpfe_capture.c
index f9f7dd17c57c..bcedaf4523e0 100644
--- a/drivers/media/platform/davinci/vpfe_capture.c
+++ b/drivers/media/platform/davinci/vpfe_capture.c
@@ -168,22 +168,21 @@ int vpfe_register_ccdc_device(const struct ccdc_hw_device *dev)
 	int ret = 0;
 	printk(KERN_NOTICE "vpfe_register_ccdc_device: %s\n", dev->name);
 
-	if (!dev->hw_ops.open ||
-	    !dev->hw_ops.enable ||
-	    !dev->hw_ops.set_hw_if_params ||
-	    !dev->hw_ops.configure ||
-	    !dev->hw_ops.set_buftype ||
-	    !dev->hw_ops.get_buftype ||
-	    !dev->hw_ops.enum_pix ||
-	    !dev->hw_ops.set_frame_format ||
-	    !dev->hw_ops.get_frame_format ||
-	    !dev->hw_ops.get_pixel_format ||
-	    !dev->hw_ops.set_pixel_format ||
-	    !dev->hw_ops.set_image_window ||
-	    !dev->hw_ops.get_image_window ||
-	    !dev->hw_ops.get_line_length ||
-	    !dev->hw_ops.getfid)
-		return -EINVAL;
+	BUG_ON(!dev->hw_ops.open);
+	BUG_ON(!dev->hw_ops.enable);
+	BUG_ON(!dev->hw_ops.set_hw_if_params);
+	BUG_ON(!dev->hw_ops.configure);
+	BUG_ON(!dev->hw_ops.set_buftype);
+	BUG_ON(!dev->hw_ops.get_buftype);
+	BUG_ON(!dev->hw_ops.enum_pix);
+	BUG_ON(!dev->hw_ops.set_frame_format);
+	BUG_ON(!dev->hw_ops.get_frame_format);
+	BUG_ON(!dev->hw_ops.get_pixel_format);
+	BUG_ON(!dev->hw_ops.set_pixel_format);
+	BUG_ON(!dev->hw_ops.set_image_window);
+	BUG_ON(!dev->hw_ops.get_image_window);
+	BUG_ON(!dev->hw_ops.get_line_length);
+	BUG_ON(!dev->hw_ops.getfid);
 
 	mutex_lock(&ccdc_lock);
 	if (!ccdc_cfg) {
-- 
2.31.1

