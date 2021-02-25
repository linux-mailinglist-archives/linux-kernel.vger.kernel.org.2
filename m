Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 52D4C325364
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Feb 2021 17:21:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232081AbhBYQVJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 25 Feb 2021 11:21:09 -0500
Received: from mail.kernel.org ([198.145.29.99]:56512 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229880AbhBYQU1 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Feb 2021 11:20:27 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id 0B3B264F19;
        Thu, 25 Feb 2021 16:19:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1614269986;
        bh=bba/TSBKqVhB2+xq/9QyQJalX8j94NHhn2njJvrqKNs=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=GJqaTampMfLnldcT/mmnagY3Wr7ftBajFkzteJFjXpBLHS1HHXqy+1GmnG/crRFMm
         6az10yiqKG7Ig+GDwCUYFoZco4UHJpn4HmMpCUG10KAgW3qk9AAX5pz6QS78DKsy7K
         JhJMd5aTgxWRjM5xEqKjsGUfkKrJtIX3Xg89BHGqCnHcJqPqSbtoFLzUb9KivMcYwo
         BgFL5NFfFIL8OO/A5ez3Te4fRdll6QX9O2YC0MJXAPrx/qIBWhUhKD5Opi0k7Aiu5H
         LOWDW2OBaKJHIHjuHhx4k9gsnJA1KLvvwf0DJ3kV6xHbHYM3XBdUgDuEqAgrVWhlTs
         oSEHpzE/cD1RA==
From:   Oded Gabbay <ogabbay@kernel.org>
To:     linux-kernel@vger.kernel.org
Cc:     Ofir Bitton <obitton@habana.ai>
Subject: [PATCH 3/4] habanalabs/gaudi: update extended async event header
Date:   Thu, 25 Feb 2021 18:19:38 +0200
Message-Id: <20210225161939.20842-3-ogabbay@kernel.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210225161939.20842-1-ogabbay@kernel.org>
References: <20210225161939.20842-1-ogabbay@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Ofir Bitton <obitton@habana.ai>

Update to the latest definition of the firmware

Signed-off-by: Ofir Bitton <obitton@habana.ai>
Reviewed-by: Oded Gabbay <ogabbay@kernel.org>
Signed-off-by: Oded Gabbay <ogabbay@kernel.org>
---
 .../include/gaudi/gaudi_async_ids_map_extended.h       | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/drivers/misc/habanalabs/include/gaudi/gaudi_async_ids_map_extended.h b/drivers/misc/habanalabs/include/gaudi/gaudi_async_ids_map_extended.h
index 737176ba06fb..9106395eb920 100644
--- a/drivers/misc/habanalabs/include/gaudi/gaudi_async_ids_map_extended.h
+++ b/drivers/misc/habanalabs/include/gaudi/gaudi_async_ids_map_extended.h
@@ -301,10 +301,10 @@ static struct gaudi_async_events_ids_map gaudi_irq_map_table[] = {
 	{ .fc_id = 274, .cpu_id = 128, .valid = 0, .name = "" },
 	{ .fc_id = 275, .cpu_id = 128, .valid = 0, .name = "" },
 	{ .fc_id = 276, .cpu_id = 128, .valid = 0, .name = "" },
-	{ .fc_id = 277, .cpu_id = 129, .valid = 0, .name = "" },
-	{ .fc_id = 278, .cpu_id = 129, .valid = 0, .name = "" },
-	{ .fc_id = 279, .cpu_id = 129, .valid = 0, .name = "" },
-	{ .fc_id = 280, .cpu_id = 129, .valid = 0, .name = "" },
+	{ .fc_id = 277, .cpu_id = 129, .valid = 1, .name = "DMA_IF_SEI_0" },
+	{ .fc_id = 278, .cpu_id = 129, .valid = 1, .name = "DMA_IF_SEI_1" },
+	{ .fc_id = 279, .cpu_id = 129, .valid = 1, .name = "DMA_IF_SEI_2" },
+	{ .fc_id = 280, .cpu_id = 129, .valid = 1, .name = "DMA_IF_SEI_3" },
 	{ .fc_id = 281, .cpu_id = 130, .valid = 0, .name = "" },
 	{ .fc_id = 282, .cpu_id = 131, .valid = 0, .name = "" },
 	{ .fc_id = 283, .cpu_id = 132, .valid = 0, .name = "" },
@@ -681,7 +681,7 @@ static struct gaudi_async_events_ids_map gaudi_irq_map_table[] = {
 	{ .fc_id = 654, .cpu_id = 503, .valid = 0, .name = "" },
 	{ .fc_id = 655, .cpu_id = 504, .valid = 0, .name = "" },
 	{ .fc_id = 656, .cpu_id = 505, .valid = 0, .name = "" },
-	{ .fc_id = 657, .cpu_id = 506, .valid = 0, .name = "" },
+	{ .fc_id = 657, .cpu_id = 506, .valid = 1, .name = "PKT_QUEUE_ASYNC" },
 	{ .fc_id = 658, .cpu_id = 507, .valid = 1, .name = "FIX_POWER_ENV_S" },
 	{ .fc_id = 659, .cpu_id = 508, .valid = 1, .name = "FIX_POWER_ENV_E" },
 	{ .fc_id = 660, .cpu_id = 509, .valid = 1,
-- 
2.25.1

