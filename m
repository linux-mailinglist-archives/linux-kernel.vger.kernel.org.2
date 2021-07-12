Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6C9EC3C5E2B
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Jul 2021 16:19:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234966AbhGLOVx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 12 Jul 2021 10:21:53 -0400
Received: from foss.arm.com ([217.140.110.172]:55860 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233172AbhGLOVw (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Jul 2021 10:21:52 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id E6849D6E;
        Mon, 12 Jul 2021 07:19:03 -0700 (PDT)
Received: from e120937-lin.home (unknown [172.31.20.19])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id BDF4B3F774;
        Mon, 12 Jul 2021 07:19:00 -0700 (PDT)
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
Subject: [PATCH v6 02/17] firmware: arm_scmi: Fix max pending messages boundary check
Date:   Mon, 12 Jul 2021 15:18:18 +0100
Message-Id: <20210712141833.6628-3-cristian.marussi@arm.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20210712141833.6628-1-cristian.marussi@arm.com>
References: <20210712141833.6628-1-cristian.marussi@arm.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

SCMI message headers carry a sequence number and such field is sized to
allow for MSG_TOKEN_MAX distinct numbers; moreover zero is not really an
acceptable maximum number of pending in-flight messages.

Fix accordignly the checks performed on the value exported by transports
in scmi_desc.max_msg.

Reported-by: Vincent Guittot <vincent.guittot@linaro.org>
Signed-off-by: Cristian Marussi <cristian.marussi@arm.com>
---
 drivers/firmware/arm_scmi/driver.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/drivers/firmware/arm_scmi/driver.c b/drivers/firmware/arm_scmi/driver.c
index 66e5e694be7d..d2c98642cb14 100644
--- a/drivers/firmware/arm_scmi/driver.c
+++ b/drivers/firmware/arm_scmi/driver.c
@@ -1025,8 +1025,9 @@ static int __scmi_xfer_info_init(struct scmi_info *sinfo,
 	const struct scmi_desc *desc = sinfo->desc;
 
 	/* Pre-allocated messages, no more than what hdr.seq can support */
-	if (WARN_ON(desc->max_msg >= MSG_TOKEN_MAX)) {
-		dev_err(dev, "Maximum message of %d exceeds supported %ld\n",
+	if (WARN_ON(!desc->max_msg || desc->max_msg > MSG_TOKEN_MAX)) {
+		dev_err(dev,
+			"Invalid max_msg %d. Maximum messages supported %lu.\n",
 			desc->max_msg, MSG_TOKEN_MAX);
 		return -EINVAL;
 	}
-- 
2.17.1

