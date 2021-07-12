Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A145D3C5E33
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Jul 2021 16:19:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235105AbhGLOWW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 12 Jul 2021 10:22:22 -0400
Received: from foss.arm.com ([217.140.110.172]:56034 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S235006AbhGLOWV (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Jul 2021 10:22:21 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 637FED6E;
        Mon, 12 Jul 2021 07:19:33 -0700 (PDT)
Received: from e120937-lin.home (unknown [172.31.20.19])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 695603F774;
        Mon, 12 Jul 2021 07:19:30 -0700 (PDT)
From:   Cristian Marussi <cristian.marussi@arm.com>
To:     linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        virtualization@lists.linux-foundation.org,
        virtio-dev@lists.oasis-open.org
Cc:     sudeep.holla@arm.com, james.quinlan@broadcom.com,
        Jonathan.Cameron@Huawei.com, f.fainelli@gmail.com,
        etienne.carriere@linaro.org, vincent.guittot@linaro.org,
        souvik.chakravarty@arm.com, cristian.marussi@arm.com,
        igor.skalkin@opensynergy.com, peter.hilber@opensynergy.com,
        alex.bennee@linaro.org, jean-philippe@linaro.org,
        mikhail.golubev@opensynergy.com, anton.yakovlev@opensynergy.com,
        Vasyl.Vavrychuk@opensynergy.com,
        Andriy.Tryshnivskyy@opensynergy.com
Subject: [PATCH v6 10/17] firmware: arm_scmi: Make polling mode optional
Date:   Mon, 12 Jul 2021 15:18:26 +0100
Message-Id: <20210712141833.6628-11-cristian.marussi@arm.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20210712141833.6628-1-cristian.marussi@arm.com>
References: <20210712141833.6628-1-cristian.marussi@arm.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add a check for the presence of .poll_done transport operation so that
transports that do not need to support polling mode have no need to provide
a dummy .poll_done callback either and polling mode can be disabled in the
SCMI core for that tranport.

Signed-off-by: Cristian Marussi <cristian.marussi@arm.com>
---
 drivers/firmware/arm_scmi/driver.c | 43 ++++++++++++++++++------------
 1 file changed, 26 insertions(+), 17 deletions(-)

diff --git a/drivers/firmware/arm_scmi/driver.c b/drivers/firmware/arm_scmi/driver.c
index a952b6527b8a..4183d25c9289 100644
--- a/drivers/firmware/arm_scmi/driver.c
+++ b/drivers/firmware/arm_scmi/driver.c
@@ -777,25 +777,34 @@ static int do_xfer(const struct scmi_protocol_handle *ph,
 	}
 
 	if (xfer->hdr.poll_completion) {
-		ktime_t stop = ktime_add_ns(ktime_get(), SCMI_MAX_POLL_TO_NS);
-
-		spin_until_cond(scmi_xfer_done_no_timeout(cinfo, xfer, stop));
-
-		if (ktime_before(ktime_get(), stop)) {
-			unsigned long flags;
-
-			/*
-			 * Do not fetch_response if an out-of-order delayed
-			 * response is being processed.
-			 */
-			spin_lock_irqsave(&xfer->lock, flags);
-			if (xfer->state == SCMI_XFER_SENT_OK) {
-				info->desc->ops->fetch_response(cinfo, xfer);
-				xfer->state = SCMI_XFER_RESP_OK;
+		if (info->desc->ops->poll_done) {
+			ktime_t stop = ktime_add_ns(ktime_get(),
+						    SCMI_MAX_POLL_TO_NS);
+
+			spin_until_cond(scmi_xfer_done_no_timeout(cinfo, xfer,
+								  stop));
+
+			if (ktime_before(ktime_get(), stop)) {
+				unsigned long flags;
+
+				/*
+				 * Do not fetch_response if an out-of-order delayed
+				 * response is being processed.
+				 */
+				spin_lock_irqsave(&xfer->lock, flags);
+				if (xfer->state == SCMI_XFER_SENT_OK) {
+					info->desc->ops->fetch_response(cinfo,
+									xfer);
+					xfer->state = SCMI_XFER_RESP_OK;
+				}
+				spin_unlock_irqrestore(&xfer->lock, flags);
+			} else {
+				ret = -ETIMEDOUT;
 			}
-			spin_unlock_irqrestore(&xfer->lock, flags);
 		} else {
-			ret = -ETIMEDOUT;
+			dev_warn_once(dev,
+				      "Polling mode is not supported by transport.\n");
+			ret = EINVAL;
 		}
 	} else {
 		/* And we wait for the response. */
-- 
2.17.1

