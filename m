Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0CE9C33D444
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Mar 2021 13:52:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233907AbhCPMvm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 16 Mar 2021 08:51:42 -0400
Received: from foss.arm.com ([217.140.110.172]:37816 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232978AbhCPMtw (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Mar 2021 08:49:52 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 61E4C1478;
        Tue, 16 Mar 2021 05:49:52 -0700 (PDT)
Received: from e120937-lin.home (unknown [172.31.20.19])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 7C5893F792;
        Tue, 16 Mar 2021 05:49:50 -0700 (PDT)
From:   Cristian Marussi <cristian.marussi@arm.com>
To:     linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Cc:     sudeep.holla@arm.com, lukasz.luba@arm.com,
        james.quinlan@broadcom.com, Jonathan.Cameron@Huawei.com,
        f.fainelli@gmail.com, etienne.carriere@linaro.org,
        thara.gopinath@linaro.org, vincent.guittot@linaro.org,
        souvik.chakravarty@arm.com, cristian.marussi@arm.com
Subject: [PATCH v7 16/38] firmware: arm_scmi: remove legacy scmi_power_ops protocol interface
Date:   Tue, 16 Mar 2021 12:48:41 +0000
Message-Id: <20210316124903.35011-17-cristian.marussi@arm.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20210316124903.35011-1-cristian.marussi@arm.com>
References: <20210316124903.35011-1-cristian.marussi@arm.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Now that all the SCMI driver users have been migrated to the new interface
remove the legacy interface and all the transient code.

Signed-off-by: Cristian Marussi <cristian.marussi@arm.com>
---
 drivers/firmware/arm_scmi/power.c | 47 -------------------------------
 include/linux/scmi_protocol.h     | 11 --------
 2 files changed, 58 deletions(-)

diff --git a/drivers/firmware/arm_scmi/power.c b/drivers/firmware/arm_scmi/power.c
index c950c1fc0fbe..ecdf49abd981 100644
--- a/drivers/firmware/arm_scmi/power.c
+++ b/drivers/firmware/arm_scmi/power.c
@@ -146,15 +146,6 @@ static int scmi_power_state_set(const struct scmi_protocol_handle *ph,
 	return ret;
 }
 
-static int __scmi_power_state_set(const struct scmi_handle *handle,
-				  u32 domain, u32 state)
-{
-	const struct scmi_protocol_handle *ph =
-		scmi_map_protocol_handle(handle, SCMI_PROTOCOL_POWER);
-
-	return scmi_power_state_set(ph, domain, state);
-}
-
 static int scmi_power_state_get(const struct scmi_protocol_handle *ph,
 				u32 domain, u32 *state)
 {
@@ -175,15 +166,6 @@ static int scmi_power_state_get(const struct scmi_protocol_handle *ph,
 	return ret;
 }
 
-static int __scmi_power_state_get(const struct scmi_handle *handle,
-				  u32 domain, u32 *state)
-{
-	const struct scmi_protocol_handle *ph =
-		scmi_map_protocol_handle(handle, SCMI_PROTOCOL_POWER);
-
-	return scmi_power_state_get(ph, domain, state);
-}
-
 static int scmi_power_num_domains_get(const struct scmi_protocol_handle *ph)
 {
 	struct scmi_power_info *pi = ph->get_priv(ph);
@@ -191,14 +173,6 @@ static int scmi_power_num_domains_get(const struct scmi_protocol_handle *ph)
 	return pi->num_domains;
 }
 
-static int __scmi_power_num_domains_get(const struct scmi_handle *handle)
-{
-	const struct scmi_protocol_handle *ph =
-		scmi_map_protocol_handle(handle, SCMI_PROTOCOL_POWER);
-
-	return scmi_power_num_domains_get(ph);
-}
-
 static char *scmi_power_name_get(const struct scmi_protocol_handle *ph,
 				 u32 domain)
 {
@@ -208,22 +182,6 @@ static char *scmi_power_name_get(const struct scmi_protocol_handle *ph,
 	return dom->name;
 }
 
-static char *__scmi_power_name_get(const struct scmi_handle *handle,
-				   u32 domain)
-{
-	const struct scmi_protocol_handle *ph =
-		scmi_map_protocol_handle(handle, SCMI_PROTOCOL_POWER);
-
-	return scmi_power_name_get(ph, domain);
-}
-
-static const struct scmi_power_ops power_ops = {
-	.num_domains_get = __scmi_power_num_domains_get,
-	.name_get = __scmi_power_name_get,
-	.state_set = __scmi_power_state_set,
-	.state_get = __scmi_power_state_get,
-};
-
 static const struct scmi_power_proto_ops power_proto_ops = {
 	.num_domains_get = scmi_power_num_domains_get,
 	.name_get = scmi_power_name_get,
@@ -324,7 +282,6 @@ static int scmi_power_protocol_init(const struct scmi_protocol_handle *ph)
 	int domain;
 	u32 version;
 	struct scmi_power_info *pinfo;
-	struct scmi_handle *handle;
 
 	ph->xops->version_get(ph, &version);
 
@@ -350,10 +307,6 @@ static int scmi_power_protocol_init(const struct scmi_protocol_handle *ph)
 
 	pinfo->version = version;
 
-	/* Transient code for legacy ops interface */
-	handle = scmi_map_scmi_handle(ph);
-	handle->power_ops = &power_ops;
-
 	return ph->set_priv(ph, pinfo);
 }
 
diff --git a/include/linux/scmi_protocol.h b/include/linux/scmi_protocol.h
index dfb3d2f5e0d3..2328d36b7597 100644
--- a/include/linux/scmi_protocol.h
+++ b/include/linux/scmi_protocol.h
@@ -152,15 +152,6 @@ struct scmi_power_proto_ops {
 			 u32 *state);
 };
 
-struct scmi_power_ops {
-	int (*num_domains_get)(const struct scmi_handle *handle);
-	char *(*name_get)(const struct scmi_handle *handle, u32 domain);
-	int (*state_set)(const struct scmi_handle *handle, u32 domain,
-			 u32 state);
-	int (*state_get)(const struct scmi_handle *handle, u32 domain,
-			 u32 *state);
-};
-
 /**
  * scmi_sensor_reading  - represent a timestamped read
  *
@@ -614,7 +605,6 @@ struct scmi_notify_ops {
  *
  * @dev: pointer to the SCMI device
  * @version: pointer to the structure containing SCMI version information
- * @power_ops: pointer to set of power protocol operations
  * @clk_ops: pointer to set of clock protocol operations
  * @sensor_ops: pointer to set of sensor protocol operations
  * @reset_ops: pointer to set of reset protocol operations
@@ -638,7 +628,6 @@ struct scmi_handle {
 	struct device *dev;
 	struct scmi_revision_info *version;
 	const struct scmi_clk_ops *clk_ops;
-	const struct scmi_power_ops *power_ops;
 	const struct scmi_sensor_ops *sensor_ops;
 	const struct scmi_reset_ops *reset_ops;
 	const struct scmi_voltage_ops *voltage_ops;
-- 
2.17.1

