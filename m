Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 41AF141C658
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Sep 2021 16:08:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245748AbhI2OJx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 29 Sep 2021 10:09:53 -0400
Received: from mail.kernel.org ([198.145.29.99]:46216 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S245632AbhI2OJv (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Sep 2021 10:09:51 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 3938661209;
        Wed, 29 Sep 2021 14:08:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1632924490;
        bh=c7WJcVAF4GajWRueVfHuSae4ly0LTAi3qTXyQvL0Eso=;
        h=From:To:Cc:Subject:Date:From;
        b=q8nLZasG0M+1bm9hCksm98ZEpdLEsaPUkSFH553s7toxUQtS9pPvdXSRHKKl0ky8a
         Q8R8O38IGtMu2ZmUY5TsfDVRBEmtDbLptbGEc6wVZQIKkdWpr1bGHmKfe7aTH7LRfL
         Gg0Wsu17Z5rgcfALqFVENPlaWJvLABo6j+FBK98G4FWyOspPwrGw3qG2TAYYnksSRF
         ntCIdkTQ7Kwy9B8WKYYZqLalej3kHN2zb2KL4MsgBR0hgnftRYVtTp6eR8LFELqI+b
         fx9LoDEFV4CiF4VGtQrSoD31C+pyEXFHHoCA777i7t7b3SiVOilpkoNS7OTlr46VIP
         mt221tHa+hAxw==
From:   Mark Brown <broonie@kernel.org>
To:     Liam Girdwood <lgirdwood@gmail.com>
Cc:     linux-kernel@vger.kernel.org, Mark Brown <broonie@kernel.org>
Subject: [PATCH] regulator: Lower priority of logging when setting supply
Date:   Wed, 29 Sep 2021 15:07:17 +0100
Message-Id: <20210929140717.3769-1-broonie@kernel.org>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=767; h=from:subject; bh=c7WJcVAF4GajWRueVfHuSae4ly0LTAi3qTXyQvL0Eso=; b=owEBbQGS/pANAwAKASTWi3JdVIfQAcsmYgBhVHL6+Yin7xnImqD7SmQnpXjpRksCIGwfUgkAUSfM hTytYYCJATMEAAEKAB0WIQSt5miqZ1cYtZ/in+ok1otyXVSH0AUCYVRy+gAKCRAk1otyXVSH0F5FB/ 0Se/ED6KCS2h0nm3vkBlBKbTHwBi6vQghWGqX3xjra6Xvg29cGGVdCqPJT+XDhGRgONZePtivnq+hI PJkagdmUIbOO1ODj3qCKzV/ZSMwvGGprW8B4hJBwnQAbx9C/luBSBq1jp24O9Ki9+ypA+rm3qMFDbU hmKbhzJKq//An2nww40P400+TFTYwMFIb5hWKAsxt6MmcVS6TNtKz421xXpA4y2uoK5I/vWCGVaf/B F7mQ+VxQ84aeEm/UoocT5f4UuoC/Y5wbYc6eMNuznoFkim58IoFdnD5SEV6G+RLSn4lf/p5dAIyJPq RVxA5cUWH4ZuM7mHxhBcRVQVYDx62O
X-Developer-Key: i=broonie@kernel.org; a=openpgp; fpr=3F2568AAC26998F9E813A1C5C3F436CA30F5D8EB
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

We lowered all the other constraint related log messages to debug level so
lower the logging of what supplies we're configuring to debug level too.

Signed-off-by: Mark Brown <broonie@kernel.org>
---
 drivers/regulator/core.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/regulator/core.c b/drivers/regulator/core.c
index 4b22c3276d58..26bee444fc70 100644
--- a/drivers/regulator/core.c
+++ b/drivers/regulator/core.c
@@ -1571,7 +1571,7 @@ static int set_supply(struct regulator_dev *rdev,
 {
 	int err;
 
-	rdev_info(rdev, "supplied by %s\n", rdev_get_name(supply_rdev));
+	rdev_dbg(rdev, "supplied by %s\n", rdev_get_name(supply_rdev));
 
 	if (!try_module_get(supply_rdev->owner))
 		return -ENODEV;
-- 
2.20.1

