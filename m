Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8CB5430CEB8
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Feb 2021 23:25:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235312AbhBBWWS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 2 Feb 2021 17:22:18 -0500
Received: from foss.arm.com ([217.140.110.172]:58470 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S234943AbhBBWSi (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 Feb 2021 17:18:38 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 7BBB4142F;
        Tue,  2 Feb 2021 14:17:25 -0800 (PST)
Received: from e120937-lin.home (unknown [172.31.20.19])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 73B723F694;
        Tue,  2 Feb 2021 14:17:23 -0800 (PST)
From:   Cristian Marussi <cristian.marussi@arm.com>
To:     linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Cc:     sudeep.holla@arm.com, lukasz.luba@arm.com,
        james.quinlan@broadcom.com, Jonathan.Cameron@Huawei.com,
        f.fainelli@gmail.com, etienne.carriere@linaro.org,
        thara.gopinath@linaro.org, vincent.guittot@linaro.org,
        souvik.chakravarty@arm.com, cristian.marussi@arm.com
Subject: [PATCH v6 23/37] firmware: arm_scmi: remove legacy scmi_reset_ops protocol interface
Date:   Tue,  2 Feb 2021 22:15:41 +0000
Message-Id: <20210202221555.41167-24-cristian.marussi@arm.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20210202221555.41167-1-cristian.marussi@arm.com>
References: <20210202221555.41167-1-cristian.marussi@arm.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Now that all the SCMI driver users have been migrated to the new interface
remove the legacy interface and all the transient code.

Signed-off-by: Cristian Marussi <cristian.marussi@arm.com>
---
 drivers/firmware/arm_scmi/reset.c | 68 -------------------------------
 include/linux/scmi_protocol.h     | 11 -----
 2 files changed, 79 deletions(-)

diff --git a/drivers/firmware/arm_scmi/reset.c b/drivers/firmware/arm_scmi/reset.c
index 9c808f5add7e..3856ceed2bd7 100644
--- a/drivers/firmware/arm_scmi/reset.c
+++ b/drivers/firmware/arm_scmi/reset.c
@@ -125,14 +125,6 @@ static int scmi_reset_num_domains_get(const struct scmi_protocol_handle *ph)
 	return pi->num_domains;
 }
 
-static int __scmi_reset_num_domains_get(const struct scmi_handle *handle)
-{
-	const struct scmi_protocol_handle *ph =
-		scmi_map_protocol_handle(handle, SCMI_PROTOCOL_RESET);
-
-	return scmi_reset_num_domains_get(ph);
-}
-
 static char *scmi_reset_name_get(const struct scmi_protocol_handle *ph,
 				 u32 domain)
 {
@@ -143,15 +135,6 @@ static char *scmi_reset_name_get(const struct scmi_protocol_handle *ph,
 	return dom->name;
 }
 
-static char *__scmi_reset_name_get(const struct scmi_handle *handle,
-				   u32 domain)
-{
-	const struct scmi_protocol_handle *ph =
-		scmi_map_protocol_handle(handle, SCMI_PROTOCOL_RESET);
-
-	return scmi_reset_name_get(ph, domain);
-}
-
 static int scmi_reset_latency_get(const struct scmi_protocol_handle *ph,
 				  u32 domain)
 {
@@ -161,15 +144,6 @@ static int scmi_reset_latency_get(const struct scmi_protocol_handle *ph,
 	return dom->latency_us;
 }
 
-static int __scmi_reset_latency_get(const struct scmi_handle *handle,
-				    u32 domain)
-{
-	const struct scmi_protocol_handle *ph =
-		scmi_map_protocol_handle(handle, SCMI_PROTOCOL_RESET);
-
-	return scmi_reset_latency_get(ph, domain);
-}
-
 static int scmi_domain_reset(const struct scmi_protocol_handle *ph, u32 domain,
 			     u32 flags, u32 state)
 {
@@ -207,15 +181,6 @@ static int scmi_reset_domain_reset(const struct scmi_protocol_handle *ph,
 				 ARCH_COLD_RESET);
 }
 
-static int __scmi_reset_domain_reset(const struct scmi_handle *handle,
-				     u32 domain)
-{
-	const struct scmi_protocol_handle *ph =
-		scmi_map_protocol_handle(handle, SCMI_PROTOCOL_RESET);
-
-	return scmi_reset_domain_reset(ph, domain);
-}
-
 static int
 scmi_reset_domain_assert(const struct scmi_protocol_handle *ph, u32 domain)
 {
@@ -223,39 +188,12 @@ scmi_reset_domain_assert(const struct scmi_protocol_handle *ph, u32 domain)
 				 ARCH_COLD_RESET);
 }
 
-static int
-__scmi_reset_domain_assert(const struct scmi_handle *handle, u32 domain)
-{
-	const struct scmi_protocol_handle *ph =
-		scmi_map_protocol_handle(handle, SCMI_PROTOCOL_RESET);
-
-	return scmi_reset_domain_assert(ph, domain);
-}
-
 static int
 scmi_reset_domain_deassert(const struct scmi_protocol_handle *ph, u32 domain)
 {
 	return scmi_domain_reset(ph, domain, 0, ARCH_COLD_RESET);
 }
 
-static int
-__scmi_reset_domain_deassert(const struct scmi_handle *handle, u32 domain)
-{
-	const struct scmi_protocol_handle *ph =
-		scmi_map_protocol_handle(handle, SCMI_PROTOCOL_RESET);
-
-	return scmi_reset_domain_deassert(ph, domain);
-}
-
-static const struct scmi_reset_ops reset_ops = {
-	.num_domains_get = __scmi_reset_num_domains_get,
-	.name_get = __scmi_reset_name_get,
-	.latency_get = __scmi_reset_latency_get,
-	.reset = __scmi_reset_domain_reset,
-	.assert = __scmi_reset_domain_assert,
-	.deassert = __scmi_reset_domain_deassert,
-};
-
 static const struct scmi_reset_proto_ops reset_proto_ops = {
 	.num_domains_get = scmi_reset_num_domains_get,
 	.name_get = scmi_reset_name_get,
@@ -357,7 +295,6 @@ static int scmi_reset_protocol_init(const struct scmi_protocol_handle *ph)
 	int domain;
 	u32 version;
 	struct scmi_reset_info *pinfo;
-	struct scmi_handle *handle;
 
 	ph->xops->version_get(ph, &version);
 
@@ -382,11 +319,6 @@ static int scmi_reset_protocol_init(const struct scmi_protocol_handle *ph)
 	}
 
 	pinfo->version = version;
-
-	/* Transient code for legacy ops interface */
-	handle = scmi_map_scmi_handle(ph);
-	handle->reset_ops = &reset_ops;
-
 	return ph->set_priv(ph, pinfo);
 }
 
diff --git a/include/linux/scmi_protocol.h b/include/linux/scmi_protocol.h
index 07a41237e74f..9bbfc970e803 100644
--- a/include/linux/scmi_protocol.h
+++ b/include/linux/scmi_protocol.h
@@ -483,15 +483,6 @@ struct scmi_reset_proto_ops {
 	int (*deassert)(const struct scmi_protocol_handle *ph, u32 domain);
 };
 
-struct scmi_reset_ops {
-	int (*num_domains_get)(const struct scmi_handle *handle);
-	char *(*name_get)(const struct scmi_handle *handle, u32 domain);
-	int (*latency_get)(const struct scmi_handle *handle, u32 domain);
-	int (*reset)(const struct scmi_handle *handle, u32 domain);
-	int (*assert)(const struct scmi_handle *handle, u32 domain);
-	int (*deassert)(const struct scmi_handle *handle, u32 domain);
-};
-
 /**
  * struct scmi_voltage_info - describe one available SCMI Voltage Domain
  *
@@ -612,7 +603,6 @@ struct scmi_notify_ops {
  * @dev: pointer to the SCMI device
  * @version: pointer to the structure containing SCMI version information
  * @sensor_ops: pointer to set of sensor protocol operations
- * @reset_ops: pointer to set of reset protocol operations
  * @voltage_ops: pointer to set of voltage protocol operations
  * @devm_acquire_protocol: devres managed method to get hold of a protocol,
  *			   causing its initialization and related resource
@@ -635,7 +625,6 @@ struct scmi_handle {
 	struct device *dev;
 	struct scmi_revision_info *version;
 	const struct scmi_sensor_ops *sensor_ops;
-	const struct scmi_reset_ops *reset_ops;
 	const struct scmi_voltage_ops *voltage_ops;
 
 	int __must_check (*devm_acquire_protocol)(struct scmi_device *sdev,
-- 
2.17.1

