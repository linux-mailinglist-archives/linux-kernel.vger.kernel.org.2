Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 89EC4366C2E
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Apr 2021 15:12:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242121AbhDUNLn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 21 Apr 2021 09:11:43 -0400
Received: from mail.kernel.org ([198.145.29.99]:46346 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S241494AbhDUNJB (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Apr 2021 09:09:01 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 667A461458;
        Wed, 21 Apr 2021 13:08:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1619010493;
        bh=LjRPFfaiBM794yDXhw61zjcLIyxr26zjVv2XqpLbM9w=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=it86d/5UulW32oERWFxno7pOm38n8gW8KEiDuh4ZhRtEgMtaAjK6xVWPkQ5i/bJZk
         7SkMtK/PtbUIQCjOrSlFhKOOGfLF45QrwoP+FaaZP2VvHLNGB5d+ZFUk9ng+VAQiNX
         0MPvT/wczfb8j+togiF2/Pq+GZ/YvgKrPML0/PNY=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Aditya Pakki <pakki001@umn.edu>,
        Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: [PATCH 157/190] Revert "Input: ad7879 - add check for read errors in interrupt"
Date:   Wed, 21 Apr 2021 15:00:32 +0200
Message-Id: <20210421130105.1226686-158-gregkh@linuxfoundation.org>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20210421130105.1226686-1-gregkh@linuxfoundation.org>
References: <20210421130105.1226686-1-gregkh@linuxfoundation.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This reverts commit e85bb0beb6498c0dffe18a2f1f16d575bc175c32.

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
Cc: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/input/touchscreen/ad7879.c | 11 ++++-------
 1 file changed, 4 insertions(+), 7 deletions(-)

diff --git a/drivers/input/touchscreen/ad7879.c b/drivers/input/touchscreen/ad7879.c
index e850853328f1..8c4f3c193550 100644
--- a/drivers/input/touchscreen/ad7879.c
+++ b/drivers/input/touchscreen/ad7879.c
@@ -245,14 +245,11 @@ static void ad7879_timer(struct timer_list *t)
 static irqreturn_t ad7879_irq(int irq, void *handle)
 {
 	struct ad7879 *ts = handle;
-	int error;
 
-	error = regmap_bulk_read(ts->regmap, AD7879_REG_XPLUS,
-				 ts->conversion_data, AD7879_NR_SENSE);
-	if (error)
-		dev_err_ratelimited(ts->dev, "failed to read %#02x: %d\n",
-				    AD7879_REG_XPLUS, error);
-	else if (!ad7879_report(ts))
+	regmap_bulk_read(ts->regmap, AD7879_REG_XPLUS,
+			 ts->conversion_data, AD7879_NR_SENSE);
+
+	if (!ad7879_report(ts))
 		mod_timer(&ts->timer, jiffies + TS_PEN_UP_TIMEOUT);
 
 	return IRQ_HANDLED;
-- 
2.31.1

