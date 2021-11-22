Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4CB54459835
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Nov 2021 00:07:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231709AbhKVXKT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 22 Nov 2021 18:10:19 -0500
Received: from foss.arm.com ([217.140.110.172]:46118 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231441AbhKVXKO (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 Nov 2021 18:10:14 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 44ED713A1;
        Mon, 22 Nov 2021 15:07:07 -0800 (PST)
Received: from e120937-lin.home (unknown [172.31.20.19])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id B944E3F5A1;
        Mon, 22 Nov 2021 15:07:05 -0800 (PST)
From:   Cristian Marussi <cristian.marussi@arm.com>
To:     linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Cc:     sudeep.holla@arm.com, james.quinlan@broadcom.com,
        Jonathan.Cameron@Huawei.com, f.fainelli@gmail.com,
        vincent.guittot@linaro.org, souvik.chakravarty@arm.com,
        cristian.marussi@arm.com
Subject: [PATCH v6 02/16] firmware: arm_scmi: Set polling timeout to max_rx_timeout_ms
Date:   Mon, 22 Nov 2021 23:06:26 +0000
Message-Id: <20211122230640.1345-3-cristian.marussi@arm.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20211122230640.1345-1-cristian.marussi@arm.com>
References: <20211122230640.1345-1-cristian.marussi@arm.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Use transport specific transmission timeout (max_rx_timeout_ms) also for
polling transactions.

Signed-off-by: Cristian Marussi <cristian.marussi@arm.com>
---
 drivers/firmware/arm_scmi/driver.c | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/drivers/firmware/arm_scmi/driver.c b/drivers/firmware/arm_scmi/driver.c
index 3cf161f3bcc7..568562121f64 100644
--- a/drivers/firmware/arm_scmi/driver.c
+++ b/drivers/firmware/arm_scmi/driver.c
@@ -724,8 +724,6 @@ static void xfer_put(const struct scmi_protocol_handle *ph,
 	__scmi_xfer_put(&info->tx_minfo, xfer);
 }
 
-#define SCMI_MAX_POLL_TO_NS	(100 * NSEC_PER_USEC)
-
 static bool scmi_xfer_done_no_timeout(struct scmi_chan_info *cinfo,
 				      struct scmi_xfer *xfer, ktime_t stop)
 {
@@ -799,7 +797,8 @@ static int do_xfer(const struct scmi_protocol_handle *ph,
 	}
 
 	if (xfer->hdr.poll_completion) {
-		ktime_t stop = ktime_add_ns(ktime_get(), SCMI_MAX_POLL_TO_NS);
+		ktime_t stop = ktime_add_ms(ktime_get(),
+					    info->desc->max_rx_timeout_ms);
 
 		spin_until_cond(scmi_xfer_done_no_timeout(cinfo, xfer, stop));
 		if (ktime_before(ktime_get(), stop)) {
-- 
2.17.1

