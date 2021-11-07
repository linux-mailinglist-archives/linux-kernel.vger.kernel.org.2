Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id ABCA84475F2
	for <lists+linux-kernel@lfdr.de>; Sun,  7 Nov 2021 21:52:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236555AbhKGUyn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 7 Nov 2021 15:54:43 -0500
Received: from mail.kernel.org ([198.145.29.99]:56466 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S236250AbhKGUyf (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 7 Nov 2021 15:54:35 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id 161A5619E1;
        Sun,  7 Nov 2021 20:51:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1636318312;
        bh=gEf2HFwC5Kmt5rOLBoxZw02fZBtE2V6JSjPrTROGr48=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=NRzMZA2vkH2kTLWdpA9C7EXas5A8bETS4kGEJI04ducqa+U4sIIOdJGG0SQAQPkBp
         qNTxISLofHXeELujOvcGtWMHk37hlLCg3GUUjg2RQDOdmOuv0kp9NsgGQP1eBu9zjp
         8RtUgTUo4qqBGKjK4O+Z3J4lJ5DKAbONpUypChmiva90kuQOIeQ7j2Ip/zCW+0xaA+
         1zywQLlojqgJoAsljkrucI5YlqAHYIGJeecZZF76TL+0IW5NiVRCVpAU36eZU9JdiY
         bhPjHMlSV0l7rIknvfo8KqhqoKo5H8loJdwP6GSxLLML3mZE17nuvWxsx+WK6dcY45
         3G0S3wrMsjH2Q==
From:   Oded Gabbay <ogabbay@kernel.org>
To:     linux-kernel@vger.kernel.org
Cc:     farah kassabri <fkassabri@habana.ai>
Subject: [PATCH 07/10] habanalabs/gaudi: Fix collective wait bug
Date:   Sun,  7 Nov 2021 22:51:33 +0200
Message-Id: <20211107205136.2329007-7-ogabbay@kernel.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20211107205136.2329007-1-ogabbay@kernel.org>
References: <20211107205136.2329007-1-ogabbay@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: farah kassabri <fkassabri@habana.ai>

In Signaling-From-Graph case, the driver didn't set the hw_sob pointer
at the right place, which is needed for the cs completion
check prior to start sending all the master/slaves jobs to device.

Signed-off-by: farah kassabri <fkassabri@habana.ai>
Reviewed-by: Oded Gabbay <ogabbay@kernel.org>
Signed-off-by: Oded Gabbay <ogabbay@kernel.org>
---
 drivers/misc/habanalabs/gaudi/gaudi.c | 15 +++++++++++----
 1 file changed, 11 insertions(+), 4 deletions(-)

diff --git a/drivers/misc/habanalabs/gaudi/gaudi.c b/drivers/misc/habanalabs/gaudi/gaudi.c
index b4814369062e..a9e279bfebae 100644
--- a/drivers/misc/habanalabs/gaudi/gaudi.c
+++ b/drivers/misc/habanalabs/gaudi/gaudi.c
@@ -1276,6 +1276,7 @@ static int gaudi_collective_wait_init_cs(struct hl_cs *cs)
 		container_of(cs->signal_fence, struct hl_cs_compl, base_fence);
 	struct hl_cs_compl *cs_cmpl =
 		container_of(cs->fence, struct hl_cs_compl, base_fence);
+	struct hl_cs_encaps_sig_handle *handle = cs->encaps_sig_hdl;
 	struct gaudi_collective_properties *cprop;
 	u32 stream, queue_id, sob_group_offset;
 	struct gaudi_device *gaudi;
@@ -1288,10 +1289,16 @@ static int gaudi_collective_wait_init_cs(struct hl_cs *cs)
 	gaudi = hdev->asic_specific;
 	cprop = &gaudi->collective_props;
 
-	/* In encaps signals case the SOB info will be retrieved from
-	 * the handle in gaudi_collective_slave_init_job.
-	 */
-	if (!cs->encaps_signals) {
+	if (cs->encaps_signals) {
+		cs_cmpl->hw_sob = handle->hw_sob;
+		/* at this checkpoint we only need the hw_sob pointer
+		 * for the completion check before start going over the jobs
+		 * of the master/slaves, the sob_value will be taken later on
+		 * in gaudi_collective_slave_init_job depends on each
+		 * job wait offset value.
+		 */
+		cs_cmpl->sob_val = 0;
+	} else {
 		/* copy the SOB id and value of the signal CS */
 		cs_cmpl->hw_sob = signal_cs_cmpl->hw_sob;
 		cs_cmpl->sob_val = signal_cs_cmpl->sob_val;
-- 
2.25.1

