Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E56E3366C2C
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Apr 2021 15:12:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242051AbhDUNLg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 21 Apr 2021 09:11:36 -0400
Received: from mail.kernel.org ([198.145.29.99]:49770 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S241049AbhDUNIk (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Apr 2021 09:08:40 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id A90E161456;
        Wed, 21 Apr 2021 13:08:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1619010482;
        bh=YN+N+lOhZFGX8Eqnl4lW/SkY2DO/lgawVdtFLhv+E/A=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=dBV0o6rWS6W3l6lM0iRafIsS8s2wf/bqx2n5VY1r9uT49jkoFmNYTzQJt04+UJDBU
         DXXzJ2pscHwBvbc6+mJa/OgBT4WpTO+LJ1ys96nEk4m0w84HpRZIYwfEnxpuQX76GT
         1If8EctqsgIVWdIkjQRt6FEf3JrwdQUZMGHwe48o=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Kangjie Lu <kjlu@umn.edu>,
        Mauro Carvalho Chehab <mchehab+samsung@kernel.org>
Subject: [PATCH 153/190] Revert "media: usb: gspca: add a missed return-value check for do_command"
Date:   Wed, 21 Apr 2021 15:00:28 +0200
Message-Id: <20210421130105.1226686-154-gregkh@linuxfoundation.org>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20210421130105.1226686-1-gregkh@linuxfoundation.org>
References: <20210421130105.1226686-1-gregkh@linuxfoundation.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This reverts commit 5ceaf5452c1b2a452dadaf377f9f07af7bda9cc3.

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
 drivers/media/usb/gspca/cpia1.c | 8 ++------
 1 file changed, 2 insertions(+), 6 deletions(-)

diff --git a/drivers/media/usb/gspca/cpia1.c b/drivers/media/usb/gspca/cpia1.c
index d93d384286c1..99e594559a0c 100644
--- a/drivers/media/usb/gspca/cpia1.c
+++ b/drivers/media/usb/gspca/cpia1.c
@@ -537,14 +537,10 @@ static int do_command(struct gspca_dev *gspca_dev, u16 command,
 		}
 		if (sd->params.qx3.button) {
 			/* button pressed - unlock the latch */
-			ret = do_command(gspca_dev, CPIA_COMMAND_WriteMCPort,
+			do_command(gspca_dev, CPIA_COMMAND_WriteMCPort,
 				   3, 0xdf, 0xdf, 0);
-			if (ret)
-				return ret;
-			ret = do_command(gspca_dev, CPIA_COMMAND_WriteMCPort,
+			do_command(gspca_dev, CPIA_COMMAND_WriteMCPort,
 				   3, 0xff, 0xff, 0);
-			if (ret)
-				return ret;
 		}
 
 		/* test whether microscope is cradled */
-- 
2.31.1

