Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 49802367C8E
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Apr 2021 10:32:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235445AbhDVIb0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 22 Apr 2021 04:31:26 -0400
Received: from smtp2.axis.com ([195.60.68.18]:24503 "EHLO smtp2.axis.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S235306AbhDVIbW (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Apr 2021 04:31:22 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=axis.com; q=dns/txt; s=axis-central1; t=1619080249;
  x=1650616249;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=0R2bXFjgWP4qbx7o/WKjoTD4bzUTv0W+6xUNU4/fvgk=;
  b=A5WZ+FuRrswzi3d+iO1no8UdSWmcLOs1gZd6HtQXuUecyEk4TpETFByK
   ytu+x7seZYRRYevQTpsyPhlv7KMlBjPnHiSJMz6qoMNfwYejrs0KKv3hh
   ivkE8/8JsLgwRQqkKiLiRW8rouxS2WxRSOXls+gaZ09UWn0i5HEoyObW6
   4eQ/TbCnQHdEXn87aLqeDR2wxmr8Ysvv1JQQvyGU/cPoHyZAdBF1PAJrV
   +DpTq7FUsgx+R08SUqBLIA3THOCwZCsRqJ3uwrIRLHr5HIv+RbaGffVjQ
   7ttQ6I21tjOd7XnEQBRNaA7GhzFPRUDLfAg0yMfdGHPBNyKqRT2/1k9IL
   Q==;
From:   Vincent Whitchurch <vincent.whitchurch@axis.com>
To:     Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>
CC:     <kernel@axis.com>,
        Vincent Whitchurch <vincent.whitchurch@axis.com>,
        <linux-kernel@vger.kernel.org>
Subject: [PATCH] regulator: core: Respect off_on_delay at startup
Date:   Thu, 22 Apr 2021 10:30:44 +0200
Message-ID: <20210422083044.11479-1-vincent.whitchurch@axis.com>
X-Mailer: git-send-email 2.28.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

We currently do not respect off_on_delay the first time we turn on a
regulator.  This is problematic since the regulator could have been
turned off by the bootloader, or it could it have been turned off during
the probe of the regulator driver (such as when regulator-fixed requests
the enable GPIO), either of which could potentially have happened less
than off_on_delay microseconds ago before the first time a client
requests for the regulator to be turned on.

We can't know exactly when the regulator was turned off, but initialise
off_on_delay to the current time when registering the regulator, so that
we guarantee that we respect the off_on_delay in all cases.

Signed-off-by: Vincent Whitchurch <vincent.whitchurch@axis.com>
---
 drivers/regulator/core.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/regulator/core.c b/drivers/regulator/core.c
index 16114aea099a..d6219cb8bd29 100644
--- a/drivers/regulator/core.c
+++ b/drivers/regulator/core.c
@@ -1439,6 +1439,8 @@ static int set_machine_constraints(struct regulator_dev *rdev)
 
 		if (rdev->constraints->always_on)
 			rdev->use_count++;
+	} else if (rdev->desc->off_on_delay) {
+		rdev->last_off_jiffy = jiffies;
 	}
 
 	print_constraints(rdev);
-- 
2.28.0

