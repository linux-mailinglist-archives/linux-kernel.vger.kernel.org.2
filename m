Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B6EE136EB24
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Apr 2021 15:08:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239563AbhD2NJg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 29 Apr 2021 09:09:36 -0400
Received: from mail.kernel.org ([198.145.29.99]:34386 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S238251AbhD2NJK (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Apr 2021 09:09:10 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 22A0D61405;
        Thu, 29 Apr 2021 13:08:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1619701703;
        bh=vsQ6dJQCstgVPtjphghgpJ14AOV3rhg3l1QZNi7Zm2M=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=x9B5N4AVQ9PiKImgvXOZ8n/f7GErNl0Ool4TZj7mbZL4fC56P6pNRBPuhxXHblEXW
         rVI6ljQlChUzI7ONa5q+GEwKtEXw8/iryQ1LnMIkf+iDJsTRF7+2I+hcpiHTFEjS1X
         IhHKFhn6/+MVUf2OJcVNXeKaRbzr0CB+v+ITZoqc=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Qiushi Wu <wu000273@umn.edu>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>
Subject: [PATCH 2/7] Revert "rtc: mc13xxx: fix a double-unlock issue"
Date:   Thu, 29 Apr 2021 15:08:06 +0200
Message-Id: <20210429130811.3353369-3-gregkh@linuxfoundation.org>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20210429130811.3353369-1-gregkh@linuxfoundation.org>
References: <20210429130811.3353369-1-gregkh@linuxfoundation.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This reverts commit 8816cd726a4fee197af2d851cbe25991ae19ea14.

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

Cc: Qiushi Wu <wu000273@umn.edu>
Cc: Alexandre Belloni <alexandre.belloni@bootlin.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/rtc/rtc-mc13xxx.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/drivers/rtc/rtc-mc13xxx.c b/drivers/rtc/rtc-mc13xxx.c
index d4234e78497e..0921ca792847 100644
--- a/drivers/rtc/rtc-mc13xxx.c
+++ b/drivers/rtc/rtc-mc13xxx.c
@@ -308,10 +308,8 @@ static int __init mc13xxx_rtc_probe(struct platform_device *pdev)
 	mc13xxx_unlock(mc13xxx);
 
 	ret = devm_rtc_register_device(priv->rtc);
-	if (ret) {
-		mc13xxx_lock(mc13xxx);
+	if (ret)
 		goto err_irq_request;
-	}
 
 	return 0;
 
-- 
2.31.1

