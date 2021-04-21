Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3E417366C78
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Apr 2021 15:18:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241652AbhDUNRw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 21 Apr 2021 09:17:52 -0400
Received: from mail.kernel.org ([198.145.29.99]:47824 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S241383AbhDUNIR (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Apr 2021 09:08:17 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id D09E56143B;
        Wed, 21 Apr 2021 13:07:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1619010457;
        bh=6ZaWGuJG+QrHosbsC7owRywWvxO+N87Jjcjj+DYnNu4=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=tztBDrqorb7/0aoDqXGerZDHO+tZqepv2LtsYcrb+/ItWfCgD8X9sMuQcaVgGTAJr
         zmPkdmNWFk6k4AZ0WkdRE9IjBvLBHAGQEx3tUTKn/Rtc5FIXihYRZX0BriSB2NVjSX
         KGmE1PvjF5xD/Wd1gVEYETNexxFAgnhU2kyJBCv8=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Kangjie Lu <kjlu@umn.edu>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>
Subject: [PATCH 142/190] Revert "rtc: hym8563: fix a missing check of block data read"
Date:   Wed, 21 Apr 2021 15:00:17 +0200
Message-Id: <20210421130105.1226686-143-gregkh@linuxfoundation.org>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20210421130105.1226686-1-gregkh@linuxfoundation.org>
References: <20210421130105.1226686-1-gregkh@linuxfoundation.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This reverts commit 9a20b5e35a536d6bb4b2d4a3b14a0457e205356c.

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
Cc: Alexandre Belloni <alexandre.belloni@bootlin.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/rtc/rtc-hym8563.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/drivers/rtc/rtc-hym8563.c b/drivers/rtc/rtc-hym8563.c
index 0751cae27285..a9d033eff61e 100644
--- a/drivers/rtc/rtc-hym8563.c
+++ b/drivers/rtc/rtc-hym8563.c
@@ -94,8 +94,6 @@ static int hym8563_rtc_read_time(struct device *dev, struct rtc_time *tm)
 	int ret;
 
 	ret = i2c_smbus_read_i2c_block_data(client, HYM8563_SEC, 7, buf);
-	if (ret < 0)
-		return ret;
 
 	if (buf[0] & HYM8563_SEC_VL) {
 		dev_warn(&client->dev,
-- 
2.31.1

