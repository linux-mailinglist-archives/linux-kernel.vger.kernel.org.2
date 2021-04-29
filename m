Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B054836EB28
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Apr 2021 15:09:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238815AbhD2NJu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 29 Apr 2021 09:09:50 -0400
Received: from mail.kernel.org ([198.145.29.99]:34492 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S239049AbhD2NJU (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Apr 2021 09:09:20 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id E66B861405;
        Thu, 29 Apr 2021 13:08:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1619701713;
        bh=Kq1pbPFw4lvQZncgqGKNk5Fm20UQ8Gt55ufHzgJ2Kxk=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=imuRzkYemenFabKleXf9sTxyLbHqbqWd+hlv7B4gR00kiU6kBrp54jTjlWKfxOpzX
         g/hP14Hb0u4o8mncl5lznO4+Ks4Yvsdw6tXP4WdnHFO4J1uJd3ROSnmCE+JTReZvf5
         OhhOxDZsd+bx2xhP+2oIJmI4BBWnsCyGw3dCtEJc=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Kangjie Lu <kjlu@umn.edu>,
        Jacek Anaszewski <jacek.anaszewski@gmail.com>
Subject: [PATCH 6/7] Revert "leds: lp5523: fix a missing check of return value of lp55xx_read"
Date:   Thu, 29 Apr 2021 15:08:10 +0200
Message-Id: <20210429130811.3353369-7-gregkh@linuxfoundation.org>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20210429130811.3353369-1-gregkh@linuxfoundation.org>
References: <20210429130811.3353369-1-gregkh@linuxfoundation.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This reverts commit 248b57015f35c94d4eae2fdd8c6febf5cd703900.

Commits from @umn.edu addresses have been found to be submitted in "bad
faith" to try to test the kernel community's ability to review "known
malicious" changes.  The result of these submissions can be found in a
paper submitted to the 42nd IEEE Symposium on Security and Privacy
entitled, "Open Source Insecurity: Stealthily Introducing
Vulnerabilities via Hypocrite Commits" written by Qiushi Wu (University
of Minnesota) and Kangjie Lu (University of Minnesota) but later
withdrawn.

Because of this, all submissions from this group must be reverted from
the kernel tree and will need to be re-reviewed again to determine if
they actually are a valid fix.  Until that work is complete, remove this
change to ensure that no problems are being introduced into the
codebase.

Cc: Kangjie Lu <kjlu@umn.edu>
Cc: Jacek Anaszewski <jacek.anaszewski@gmail.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/leds/leds-lp5523.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/drivers/leds/leds-lp5523.c b/drivers/leds/leds-lp5523.c
index fc433e63b1dc..5036d7d5f3d4 100644
--- a/drivers/leds/leds-lp5523.c
+++ b/drivers/leds/leds-lp5523.c
@@ -305,9 +305,7 @@ static int lp5523_init_program_engine(struct lp55xx_chip *chip)
 
 	/* Let the programs run for couple of ms and check the engine status */
 	usleep_range(3000, 6000);
-	ret = lp55xx_read(chip, LP5523_REG_STATUS, &status);
-	if (ret)
-		return ret;
+	lp55xx_read(chip, LP5523_REG_STATUS, &status);
 	status &= LP5523_ENG_STATUS_MASK;
 
 	if (status != LP5523_ENG_STATUS_MASK) {
-- 
2.31.1

