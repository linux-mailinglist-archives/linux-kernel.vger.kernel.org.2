Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E636D3BBE69
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Jul 2021 16:50:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231582AbhGEOwv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 5 Jul 2021 10:52:51 -0400
Received: from foss.arm.com ([217.140.110.172]:47930 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230504AbhGEOwu (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Jul 2021 10:52:50 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id CE8E26D;
        Mon,  5 Jul 2021 07:50:13 -0700 (PDT)
Received: from e120937-lin.home (unknown [172.31.20.19])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 6F6063F7D7;
        Mon,  5 Jul 2021 07:50:09 -0700 (PDT)
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
Subject: [PATCH v5 01/15] firmware: arm_scmi: Avoid padding in sensor message structure
Date:   Mon,  5 Jul 2021 15:49:00 +0100
Message-Id: <20210705144914.35094-2-cristian.marussi@arm.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20210705144914.35094-1-cristian.marussi@arm.com>
References: <20210705144914.35094-1-cristian.marussi@arm.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Structure scmi_resp_sensor_reading_complete is meant to represent an SCMI
asynchronous reading complete message: representing the readings field with
a 64bit type forces padding and breaks reads in scmi_sensor_reading_get.

Split it in two adjacent 32bit readings_low/high subfields to avoid padding
or the need to make it packed.

Fixes: e2083d3673916 ("firmware: arm_scmi: Add SCMI v3.0 sensors timestamped reads")
Signed-off-by: Cristian Marussi <cristian.marussi@arm.com>
---
 drivers/firmware/arm_scmi/sensors.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/drivers/firmware/arm_scmi/sensors.c b/drivers/firmware/arm_scmi/sensors.c
index 2c88aa221559..308471586381 100644
--- a/drivers/firmware/arm_scmi/sensors.c
+++ b/drivers/firmware/arm_scmi/sensors.c
@@ -166,7 +166,8 @@ struct scmi_msg_sensor_reading_get {
 
 struct scmi_resp_sensor_reading_complete {
 	__le32 id;
-	__le64 readings;
+	__le32 readings_low;
+	__le32 readings_high;
 };
 
 struct scmi_sensor_reading_resp {
@@ -717,7 +718,8 @@ static int scmi_sensor_reading_get(const struct scmi_protocol_handle *ph,
 
 			resp = t->rx.buf;
 			if (le32_to_cpu(resp->id) == sensor_id)
-				*value = get_unaligned_le64(&resp->readings);
+				*value =
+					get_unaligned_le64(&resp->readings_low);
 			else
 				ret = -EPROTO;
 		}
-- 
2.17.1

