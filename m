Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D46C938F621
	for <lists+linux-kernel@lfdr.de>; Tue, 25 May 2021 01:15:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229863AbhEXXRL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 24 May 2021 19:17:11 -0400
Received: from foss.arm.com ([217.140.110.172]:49016 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229547AbhEXXRJ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 May 2021 19:17:09 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id DBCA41042;
        Mon, 24 May 2021 16:15:40 -0700 (PDT)
Received: from e120937-lin.home (unknown [172.31.20.19])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 1FA033F73D;
        Mon, 24 May 2021 16:15:39 -0700 (PDT)
From:   Cristian Marussi <cristian.marussi@arm.com>
To:     linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Cc:     sudeep.holla@arm.com, james.quinlan@broadcom.com,
        Jonathan.Cameron@Huawei.com, f.fainelli@gmail.com,
        etienne.carriere@linaro.org, vincent.guittot@linaro.org,
        souvik.chakravarty@arm.com, cristian.marussi@arm.com
Subject: [PATCH 1/4] firmware: arm_scmi: reset_rx_to_maxsz during async commands
Date:   Tue, 25 May 2021 00:15:00 +0100
Message-Id: <20210524231503.34924-2-cristian.marussi@arm.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20210524231503.34924-1-cristian.marussi@arm.com>
References: <20210524231503.34924-1-cristian.marussi@arm.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

During an async commands execution the rx buffer len is at first set to
max_msg_sz when the synchronous part of the command is first sent; once
the synchronous part completes the transport layer waits for the delayed
response which will be processed using the same xfer descriptor initially
allocated, but synchronous response received at the end of the xfer will
have shrunk the rx buffer len to the effective payload response length.

Raise the rx buffer length again to max_msg_sz while waiting for the
delayed response, while adding an informational error message.

Fixes: 58ecdf03dbb9 ("firmware: arm_scmi: Add support for asynchronous commands and delayed response")
Signed-off-by: Cristian Marussi <cristian.marussi@arm.com>
---
 drivers/firmware/arm_scmi/driver.c | 12 ++++++++++--
 1 file changed, 10 insertions(+), 2 deletions(-)

diff --git a/drivers/firmware/arm_scmi/driver.c b/drivers/firmware/arm_scmi/driver.c
index 66eb3f0e5daf..75141b90ae53 100644
--- a/drivers/firmware/arm_scmi/driver.c
+++ b/drivers/firmware/arm_scmi/driver.c
@@ -513,8 +513,16 @@ static int do_xfer_with_response(const struct scmi_protocol_handle *ph,
 	xfer->async_done = &async_response;
 
 	ret = do_xfer(ph, xfer);
-	if (!ret && !wait_for_completion_timeout(xfer->async_done, timeout))
-		ret = -ETIMEDOUT;
+	if (!ret) {
+		/* rx.len would have been shrunk in the sync do_xfer above */
+		reset_rx_to_maxsz(ph, xfer);
+		if (!wait_for_completion_timeout(xfer->async_done, timeout)) {
+			dev_err(ph->dev,
+				"timed out in delayed resp(caller: %pS)\n",
+				(void *)_RET_IP_);
+			ret = -ETIMEDOUT;
+		}
+	}
 
 	xfer->async_done = NULL;
 	return ret;
-- 
2.17.1

