Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 332893F5FAA
	for <lists+linux-kernel@lfdr.de>; Tue, 24 Aug 2021 16:00:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237637AbhHXOA7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 24 Aug 2021 10:00:59 -0400
Received: from foss.arm.com ([217.140.110.172]:36156 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S237607AbhHXOA5 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Aug 2021 10:00:57 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 58F2713A1;
        Tue, 24 Aug 2021 07:00:13 -0700 (PDT)
Received: from e120937-lin.home (unknown [172.31.20.19])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 9E7BE3F766;
        Tue, 24 Aug 2021 07:00:11 -0700 (PDT)
From:   Cristian Marussi <cristian.marussi@arm.com>
To:     linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Cc:     sudeep.holla@arm.com, james.quinlan@broadcom.com,
        Jonathan.Cameron@Huawei.com, f.fainelli@gmail.com,
        etienne.carriere@linaro.org, vincent.guittot@linaro.org,
        souvik.chakravarty@arm.com, cristian.marussi@arm.com
Subject: [PATCH v4 01/12] firmware: arm_scmi: Perform earlier cinfo lookup call in do_xfer
Date:   Tue, 24 Aug 2021 14:59:30 +0100
Message-Id: <20210824135941.38656-2-cristian.marussi@arm.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20210824135941.38656-1-cristian.marussi@arm.com>
References: <20210824135941.38656-1-cristian.marussi@arm.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Lookup cinfo data early in do_xfer so as to avoid any further init work
on xfer structure in case of error.

No functional change.

Signed-off-by: Cristian Marussi <cristian.marussi@arm.com>
---
 drivers/firmware/arm_scmi/driver.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/firmware/arm_scmi/driver.c b/drivers/firmware/arm_scmi/driver.c
index b406b3f78f46..01c79a8fa77f 100644
--- a/drivers/firmware/arm_scmi/driver.c
+++ b/drivers/firmware/arm_scmi/driver.c
@@ -766,6 +766,10 @@ static int do_xfer(const struct scmi_protocol_handle *ph,
 		return -EINVAL;
 	}
 
+	cinfo = idr_find(&info->tx_idr, pi->proto->id);
+	if (unlikely(!cinfo))
+		return -EINVAL;
+
 	/*
 	 * Initialise protocol id now from protocol handle to avoid it being
 	 * overridden by mistake (or malice) by the protocol code mangling with
@@ -774,10 +778,6 @@ static int do_xfer(const struct scmi_protocol_handle *ph,
 	xfer->hdr.protocol_id = pi->proto->id;
 	reinit_completion(&xfer->done);
 
-	cinfo = idr_find(&info->tx_idr, xfer->hdr.protocol_id);
-	if (unlikely(!cinfo))
-		return -EINVAL;
-
 	trace_scmi_xfer_begin(xfer->transfer_id, xfer->hdr.id,
 			      xfer->hdr.protocol_id, xfer->hdr.seq,
 			      xfer->hdr.poll_completion);
-- 
2.17.1

