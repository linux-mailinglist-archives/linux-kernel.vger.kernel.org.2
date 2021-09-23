Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7FB1341618C
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Sep 2021 16:58:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241886AbhIWPAR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 23 Sep 2021 11:00:17 -0400
Received: from foss.arm.com ([217.140.110.172]:35874 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S241840AbhIWPAL (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Sep 2021 11:00:11 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id C1CFB113E;
        Thu, 23 Sep 2021 07:58:39 -0700 (PDT)
Received: from e120937-lin.home (unknown [172.31.20.19])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id D365A3F718;
        Thu, 23 Sep 2021 07:58:37 -0700 (PDT)
From:   Cristian Marussi <cristian.marussi@arm.com>
To:     linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Cc:     sudeep.holla@arm.com, james.quinlan@broadcom.com,
        Jonathan.Cameron@Huawei.com, f.fainelli@gmail.com,
        etienne.carriere@linaro.org, vincent.guittot@linaro.org,
        souvik.chakravarty@arm.com, peter.hilber@opensynergy.com,
        igor.skalkin@opensynergy.com, cristian.marussi@arm.com
Subject: [PATCH v5 06/13] firmware: arm_scmi: Use new trace event scmi_xfer_response_wait
Date:   Thu, 23 Sep 2021 15:57:55 +0100
Message-Id: <20210923145802.50938-7-cristian.marussi@arm.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20210923145802.50938-1-cristian.marussi@arm.com>
References: <20210923145802.50938-1-cristian.marussi@arm.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Use new trace event to mark start of waiting for response section.

Reviewed-by: Florian Fainelli <f.fainelli@gmail.com>
Signed-off-by: Cristian Marussi <cristian.marussi@arm.com>
---
v4 --> v5
- consider atomic_enable flag too
---
 drivers/firmware/arm_scmi/driver.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/drivers/firmware/arm_scmi/driver.c b/drivers/firmware/arm_scmi/driver.c
index 4a53ca749334..76bfd883ffb3 100644
--- a/drivers/firmware/arm_scmi/driver.c
+++ b/drivers/firmware/arm_scmi/driver.c
@@ -788,6 +788,12 @@ static int scmi_wait_for_message_response(struct scmi_chan_info *cinfo,
 	struct device *dev = info->dev;
 	int ret = 0, timeout_ms = info->desc->max_rx_timeout_ms;
 
+	trace_scmi_xfer_response_wait(xfer->transfer_id, xfer->hdr.id,
+				      xfer->hdr.protocol_id, xfer->hdr.seq,
+				      xfer->hdr.poll_completion,
+				      info->desc->atomic_capable &&
+				      info->desc->atomic_enabled);
+
 	if (!xfer->hdr.poll_completion) {
 		if (!info->desc->atomic_capable ||
 		    !info->desc->atomic_enabled) {
-- 
2.17.1

