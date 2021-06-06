Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E69D839D1C9
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Jun 2021 00:13:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230443AbhFFWPB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 6 Jun 2021 18:15:01 -0400
Received: from foss.arm.com ([217.140.110.172]:46296 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230428AbhFFWO7 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 6 Jun 2021 18:14:59 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 98A3F11D4;
        Sun,  6 Jun 2021 15:13:09 -0700 (PDT)
Received: from e120937-lin.home (unknown [172.31.20.19])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 3CF613F719;
        Sun,  6 Jun 2021 15:13:07 -0700 (PDT)
From:   Cristian Marussi <cristian.marussi@arm.com>
To:     linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Cc:     sudeep.holla@arm.com, james.quinlan@broadcom.com,
        Jonathan.Cameron@Huawei.com, f.fainelli@gmail.com,
        etienne.carriere@linaro.org, vincent.guittot@linaro.org,
        souvik.chakravarty@arm.com, cristian.marussi@arm.com
Subject: [RFC PATCH 01/10] firmware: arm_scmi: Reset properly xfer SCMI status
Date:   Sun,  6 Jun 2021 23:12:23 +0100
Message-Id: <20210606221232.33768-2-cristian.marussi@arm.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20210606221232.33768-1-cristian.marussi@arm.com>
References: <20210606221232.33768-1-cristian.marussi@arm.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When an SCMI command transfer fails due to some protocol issue an SCMI
error code is reported inside the SCMI message payload itself and it is
then retrieved and transcribed by the specific transport layer into the
xfer.hdr.status field by transport specific .fetch_response().

The core SCMI transport layer never explicitly reset xfer.hdr.status,
so when an xfer is reused, if a transport misbehaved in handling such
status field, we risk to see an invalid ghost error code.

Reset xfer.hdr.status to SCMI_SUCCESS right before each transfer is
started.

Signed-off-by: Cristian Marussi <cristian.marussi@arm.com>
---
 drivers/firmware/arm_scmi/driver.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/firmware/arm_scmi/driver.c b/drivers/firmware/arm_scmi/driver.c
index ca71568c5c41..bee33f9c2032 100644
--- a/drivers/firmware/arm_scmi/driver.c
+++ b/drivers/firmware/arm_scmi/driver.c
@@ -447,6 +447,7 @@ static int do_xfer(const struct scmi_protocol_handle *ph,
 			      xfer->hdr.protocol_id, xfer->hdr.seq,
 			      xfer->hdr.poll_completion);
 
+	xfer->hdr.status = SCMI_SUCCESS;
 	ret = info->desc->ops->send_message(cinfo, xfer);
 	if (ret < 0) {
 		dev_dbg(dev, "Failed to send message %d\n", ret);
-- 
2.17.1

