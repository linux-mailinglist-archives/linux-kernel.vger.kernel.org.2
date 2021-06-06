Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2D5B539D1CE
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Jun 2021 00:13:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231151AbhFFWPP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 6 Jun 2021 18:15:15 -0400
Received: from foss.arm.com ([217.140.110.172]:46374 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230487AbhFFWPL (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 6 Jun 2021 18:15:11 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id A4D1412FC;
        Sun,  6 Jun 2021 15:13:21 -0700 (PDT)
Received: from e120937-lin.home (unknown [172.31.20.19])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 8F9863F719;
        Sun,  6 Jun 2021 15:13:19 -0700 (PDT)
From:   Cristian Marussi <cristian.marussi@arm.com>
To:     linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Cc:     sudeep.holla@arm.com, james.quinlan@broadcom.com,
        Jonathan.Cameron@Huawei.com, f.fainelli@gmail.com,
        etienne.carriere@linaro.org, vincent.guittot@linaro.org,
        souvik.chakravarty@arm.com, cristian.marussi@arm.com
Subject: [RFC PATCH 06/10] firmware: arm_scmi: Use new trace event scmi_xfer_response_wait
Date:   Sun,  6 Jun 2021 23:12:28 +0100
Message-Id: <20210606221232.33768-7-cristian.marussi@arm.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20210606221232.33768-1-cristian.marussi@arm.com>
References: <20210606221232.33768-1-cristian.marussi@arm.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Use new trace event to mark start of waiting for response section.

Signed-off-by: Cristian Marussi <cristian.marussi@arm.com>
---
 drivers/firmware/arm_scmi/driver.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/drivers/firmware/arm_scmi/driver.c b/drivers/firmware/arm_scmi/driver.c
index 276b729f2f43..11bea548947f 100644
--- a/drivers/firmware/arm_scmi/driver.c
+++ b/drivers/firmware/arm_scmi/driver.c
@@ -458,6 +458,11 @@ static int scmi_wait_for_message_response(struct scmi_chan_info *cinfo,
 	struct device *dev = info->dev;
 	int ret = 0, timeout_ms = info->desc->max_rx_timeout_ms;
 
+	trace_scmi_xfer_response_wait(xfer->transfer_id, xfer->hdr.id,
+				      xfer->hdr.protocol_id, xfer->hdr.seq,
+				      xfer->hdr.poll_completion,
+				      info->desc->atomic_capable);
+
 	if (!xfer->hdr.poll_completion) {
 		if (!info->desc->atomic_capable) {
 			if (!wait_for_completion_timeout(&xfer->done,
-- 
2.17.1

