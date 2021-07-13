Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D220A3C6BBE
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Jul 2021 09:52:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234431AbhGMHzZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 13 Jul 2021 03:55:25 -0400
Received: from mail.kernel.org ([198.145.29.99]:40608 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S234248AbhGMHzV (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Jul 2021 03:55:21 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 5F91261279;
        Tue, 13 Jul 2021 07:52:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1626162751;
        bh=FPM7OGyTcWHRXLONUUeZiYskFZIXxiry5tjZOeHxppc=;
        h=From:To:Cc:Subject:Date:From;
        b=mSkZw1NvJGHAyeJRpdbxrlRf9HR3+piPWNHov8KbujXopQMTgQd1yRD8RBv7iCTDI
         3Y2uQE+bWIfEDwXQCLsm4EyRWutA9Sk/IqC56cOwNC5EvYe6cwf0jaTePsMHzfuJku
         fTmWcvNQFzfpuuCd3zGVVBuvZc1Lm7I8Czaf9BNTQkttKVI1QBIQYI+DshFfLQvVCP
         RE0o61UVf7duwtY4aeNDe29Fs/d0nu7OQgYRgRvfMpVXOSBP9frtgX2u0LpkRbNXjv
         aY873dtqv4tJUtpO0xdZXW4825fupPTCz2uJ2x2DaUZEeqYDBHI3iPpWvBNl+Xsx12
         UxWvWKHwum7Uw==
From:   Oded Gabbay <ogabbay@kernel.org>
To:     linux-kernel@vger.kernel.org
Cc:     Ofir Bitton <obitton@habana.ai>
Subject: [PATCH 01/11] habanalabs/gaudi: trigger state dump in case of SM errors
Date:   Tue, 13 Jul 2021 10:52:16 +0300
Message-Id: <20210713075226.11094-1-ogabbay@kernel.org>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Ofir Bitton <obitton@habana.ai>

State dump is relevant to the user in case of Sync Manager error, so
we need to trigger it in that case as well.

Signed-off-by: Ofir Bitton <obitton@habana.ai>
Reviewed-by: Oded Gabbay <ogabbay@kernel.org>
Signed-off-by: Oded Gabbay <ogabbay@kernel.org>
---
 drivers/misc/habanalabs/gaudi/gaudi.c | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/drivers/misc/habanalabs/gaudi/gaudi.c b/drivers/misc/habanalabs/gaudi/gaudi.c
index fdbe8155ef3c..6cbedeee15d1 100644
--- a/drivers/misc/habanalabs/gaudi/gaudi.c
+++ b/drivers/misc/habanalabs/gaudi/gaudi.c
@@ -7894,8 +7894,9 @@ static void gaudi_handle_eqe(struct hl_device *hdev,
 	u32 ctl = le32_to_cpu(eq_entry->hdr.ctl);
 	u16 event_type = ((ctl & EQ_CTL_EVENT_TYPE_MASK)
 			>> EQ_CTL_EVENT_TYPE_SHIFT);
-	u8 cause;
 	bool reset_required;
+	u8 cause;
+	int rc;
 
 	gaudi->events_stat[event_type]++;
 	gaudi->events_stat_aggregate[event_type]++;
@@ -8081,6 +8082,10 @@ static void gaudi_handle_eqe(struct hl_device *hdev,
 		gaudi_print_irq_info(hdev, event_type, false);
 		gaudi_print_sm_sei_info(hdev, event_type,
 					&eq_entry->sm_sei_data);
+		rc = hl_state_dump(hdev);
+		if (rc)
+			dev_err(hdev->dev,
+				"Error during system state dump %d\n", rc);
 		hl_fw_unmask_irq(hdev, event_type);
 		break;
 
-- 
2.25.1

