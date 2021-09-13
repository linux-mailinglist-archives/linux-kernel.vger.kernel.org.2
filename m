Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D7373409D4D
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Sep 2021 21:40:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347523AbhIMTky (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 13 Sep 2021 15:40:54 -0400
Received: from mail.kernel.org ([198.145.29.99]:45106 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S242762AbhIMTku (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Sep 2021 15:40:50 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 84EAF61107;
        Mon, 13 Sep 2021 19:39:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1631561974;
        bh=246bgQXePjlCj4BNsgS6sTwyOsAmxz7KHrPFBcNXBEw=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=o/UmutqP+674v7p41QZFouTP5qvkoE5B0rwE4B2VJEF4v2Qb6xMuBJR1DaufFuHy2
         OxlPHq1eDlZeQ04gqttn085wjyULCVW1H3iq0Pcicligm6KmEYYtiOBTRhDePdxdc0
         c7cdXQWetLWF+iEA+yFKWlfl4eRyZR//sZxfnrwZxqQXbR0sVSuwCHtcsiJ7ZF7RsR
         vACxIOKjKLPIQJC5oQp0jJJgM8/ZZnAxyv9QVfB9r8yvLiD+sXuCnLonaSYWEcj42P
         E8TgMOv9d1sc/TFpsKPNo5gM+7ZlUk4/yPbZeObmyxlQbieBcTe7dTEavoEsbOVOCJ
         pxCEg2xWda/mQ==
From:   Oded Gabbay <ogabbay@kernel.org>
To:     linux-kernel@vger.kernel.org
Cc:     Ofir Bitton <obitton@habana.ai>
Subject: [PATCH 3/3] habanalabs: remove redundant cs validity checks
Date:   Mon, 13 Sep 2021 22:39:26 +0300
Message-Id: <20210913193926.17329-3-ogabbay@kernel.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20210913193926.17329-1-ogabbay@kernel.org>
References: <20210913193926.17329-1-ogabbay@kernel.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Ofir Bitton <obitton@habana.ai>

During TDR handling, we check multiple times if CS is valid.
No need to perform this check as CS must be valid at all time
during the TDR handling.

Signed-off-by: Ofir Bitton <obitton@habana.ai>
Reviewed-by: Oded Gabbay <ogabbay@kernel.org>
Signed-off-by: Oded Gabbay <ogabbay@kernel.org>
---
 drivers/misc/habanalabs/common/command_submission.c | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/drivers/misc/habanalabs/common/command_submission.c b/drivers/misc/habanalabs/common/command_submission.c
index a4ed91ed991d..70bc00ff27f0 100644
--- a/drivers/misc/habanalabs/common/command_submission.c
+++ b/drivers/misc/habanalabs/common/command_submission.c
@@ -431,11 +431,10 @@ static void cs_handle_tdr(struct hl_device *hdev, struct hl_cs *cs)
 	/* Don't cancel TDR in case this CS was timedout because we might be
 	 * running from the TDR context
 	 */
-	if (cs && (cs->timedout ||
-			hdev->timeout_jiffies == MAX_SCHEDULE_TIMEOUT))
+	if (cs->timedout || hdev->timeout_jiffies == MAX_SCHEDULE_TIMEOUT)
 		return;
 
-	if (cs && cs->tdr_active)
+	if (cs->tdr_active)
 		cancel_delayed_work_sync(&cs->work_tdr);
 
 	spin_lock(&hdev->cs_mirror_lock);
-- 
2.17.1

