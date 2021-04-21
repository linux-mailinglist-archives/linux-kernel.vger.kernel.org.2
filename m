Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 00AB7366C66
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Apr 2021 15:18:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242913AbhDUNQZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 21 Apr 2021 09:16:25 -0400
Received: from mail.kernel.org ([198.145.29.99]:52962 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S242525AbhDUNKO (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Apr 2021 09:10:14 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 550166143B;
        Wed, 21 Apr 2021 13:09:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1619010580;
        bh=rJXyx2n989rVeF0RwSfMzLjGMOzQiDJzKpDgh60DZWg=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=d7V8KynlSlqYTFnSnhDEOEkglR/xdL/A0bKOjc4ZMe6PJY7s7zkfJjpZMap17mIEt
         AQM7hFj6zrf9Ozx/LqhqMtpV15zdebucbpgd+igGB1Z3ienvEfoEwIxIS86+LWpR21
         NTIICQ1YEC6s9ATnLS1GTnI6LKbR2GnkMdS+7uuY=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Kangjie Lu <kjlu@umn.edu>,
        Mauro Carvalho Chehab <mchehab+samsung@kernel.org>
Subject: [PATCH 152/190] Revert "media: usb: gspca: add a missed check for goto_low_power"
Date:   Wed, 21 Apr 2021 15:00:27 +0200
Message-Id: <20210421130105.1226686-153-gregkh@linuxfoundation.org>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20210421130105.1226686-1-gregkh@linuxfoundation.org>
References: <20210421130105.1226686-1-gregkh@linuxfoundation.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This reverts commit 5b711870bec4dc9a6d705d41e127e73944fa3650.

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
Cc: Mauro Carvalho Chehab <mchehab+samsung@kernel.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/media/usb/gspca/cpia1.c | 6 +-----
 1 file changed, 1 insertion(+), 5 deletions(-)

diff --git a/drivers/media/usb/gspca/cpia1.c b/drivers/media/usb/gspca/cpia1.c
index a4f7431486f3..d93d384286c1 100644
--- a/drivers/media/usb/gspca/cpia1.c
+++ b/drivers/media/usb/gspca/cpia1.c
@@ -1424,7 +1424,6 @@ static int sd_config(struct gspca_dev *gspca_dev,
 {
 	struct sd *sd = (struct sd *) gspca_dev;
 	struct cam *cam;
-	int ret;
 
 	sd->mainsFreq = FREQ_DEF == V4L2_CID_POWER_LINE_FREQUENCY_60HZ;
 	reset_camera_params(gspca_dev);
@@ -1436,10 +1435,7 @@ static int sd_config(struct gspca_dev *gspca_dev,
 	cam->cam_mode = mode;
 	cam->nmodes = ARRAY_SIZE(mode);
 
-	ret = goto_low_power(gspca_dev);
-	if (ret)
-		gspca_err(gspca_dev, "Cannot go to low power mode: %d\n",
-			  ret);
+	goto_low_power(gspca_dev);
 	/* Check the firmware version. */
 	sd->params.version.firmwareVersion = 0;
 	get_version_information(gspca_dev);
-- 
2.31.1

