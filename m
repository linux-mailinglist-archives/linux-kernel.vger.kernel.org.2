Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1DFE039F397
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Jun 2021 12:31:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230382AbhFHKdc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 8 Jun 2021 06:33:32 -0400
Received: from foss.arm.com ([217.140.110.172]:55096 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230321AbhFHKdb (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Jun 2021 06:33:31 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 4AB4F1396;
        Tue,  8 Jun 2021 03:31:38 -0700 (PDT)
Received: from e120937-lin.home (unknown [172.31.20.19])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 85D6E3F719;
        Tue,  8 Jun 2021 03:31:37 -0700 (PDT)
From:   Cristian Marussi <cristian.marussi@arm.com>
To:     linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Cc:     sudeep.holla@arm.com, cristian.marussi@arm.com
Subject: [PATCH] firmware: arm_scmi: Add delayed response status check
Date:   Tue,  8 Jun 2021 11:30:56 +0100
Message-Id: <20210608103056.3388-1-cristian.marussi@arm.com>
X-Mailer: git-send-email 2.17.1
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

A successfully received delayed response could anyway report a failure at
the protocol layer in the message status field.

Add a check also for this error condition.

Fixes: 58ecdf03dbb9 ("firmware: arm_scmi: Add support for asynchronous commands and delayed response")
Signed-off-by: Cristian Marussi <cristian.marussi@arm.com>
---
 drivers/firmware/arm_scmi/driver.c | 8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)

diff --git a/drivers/firmware/arm_scmi/driver.c b/drivers/firmware/arm_scmi/driver.c
index 759ae4a23e74..6826d516e4eb 100644
--- a/drivers/firmware/arm_scmi/driver.c
+++ b/drivers/firmware/arm_scmi/driver.c
@@ -519,8 +519,12 @@ static int do_xfer_with_response(const struct scmi_protocol_handle *ph,
 	xfer->async_done = &async_response;
 
 	ret = do_xfer(ph, xfer);
-	if (!ret && !wait_for_completion_timeout(xfer->async_done, timeout))
-		ret = -ETIMEDOUT;
+	if (!ret) {
+		if (!wait_for_completion_timeout(xfer->async_done, timeout))
+			ret = -ETIMEDOUT;
+		else if (xfer->hdr.status)
+			ret = scmi_to_linux_errno(xfer->hdr.status);
+	}
 
 	xfer->async_done = NULL;
 	return ret;
-- 
2.17.1

