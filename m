Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1B6993C607E
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Jul 2021 18:27:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233991AbhGLQ3r (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 12 Jul 2021 12:29:47 -0400
Received: from foss.arm.com ([217.140.110.172]:57986 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233455AbhGLQ3m (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Jul 2021 12:29:42 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 4D34E31B;
        Mon, 12 Jul 2021 09:26:54 -0700 (PDT)
Received: from e120937-lin.home (unknown [172.31.20.19])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 9F1033F774;
        Mon, 12 Jul 2021 09:26:52 -0700 (PDT)
From:   Cristian Marussi <cristian.marussi@arm.com>
To:     linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Cc:     sudeep.holla@arm.com, james.quinlan@broadcom.com,
        Jonathan.Cameron@Huawei.com, f.fainelli@gmail.com,
        etienne.carriere@linaro.org, vincent.guittot@linaro.org,
        souvik.chakravarty@arm.com, cristian.marussi@arm.com
Subject: [PATCH v3 4/8] firmware: arm_scmi: Use new trace event scmi_xfer_response_wait
Date:   Mon, 12 Jul 2021 17:26:21 +0100
Message-Id: <20210712162626.34705-5-cristian.marussi@arm.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20210712162626.34705-1-cristian.marussi@arm.com>
References: <20210712162626.34705-1-cristian.marussi@arm.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Use new trace event to mark start of waiting for response section.

Signed-off-by: Cristian Marussi <cristian.marussi@arm.com>
---
 drivers/firmware/arm_scmi/driver.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/drivers/firmware/arm_scmi/driver.c b/drivers/firmware/arm_scmi/driver.c
index a2a62910e805..fa9fea9cb3e6 100644
--- a/drivers/firmware/arm_scmi/driver.c
+++ b/drivers/firmware/arm_scmi/driver.c
@@ -781,6 +781,11 @@ static int scmi_wait_for_message_response(struct scmi_chan_info *cinfo,
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

