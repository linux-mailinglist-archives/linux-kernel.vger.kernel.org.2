Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4FB96357AB9
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Apr 2021 05:22:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230168AbhDHDWT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 7 Apr 2021 23:22:19 -0400
Received: from foss.arm.com ([217.140.110.172]:38316 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229510AbhDHDWR (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Apr 2021 23:22:17 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id ABD6A1063;
        Wed,  7 Apr 2021 20:22:05 -0700 (PDT)
Received: from u200856.usa.arm.com (unknown [172.31.20.19])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 634A03F792;
        Wed,  7 Apr 2021 20:22:05 -0700 (PDT)
From:   jlinton <jeremy.linton@arm.com>
To:     linux-usb@vger.kernel.org
Cc:     gregkh@linuxfoundation.org, hminas@synopsys.com,
        linux-kernel@vger.kernel.org, Jeremy Linton <jeremy.linton@arm.com>
Subject: [PATCH] usb: dwc2: Enable RPi in ACPI mode
Date:   Wed,  7 Apr 2021 22:21:56 -0500
Message-Id: <20210408032156.5732-1-jeremy.linton@arm.com>
X-Mailer: git-send-email 2.26.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Jeremy Linton <jeremy.linton@arm.com>

The dwc2 driver has everything we need to run
in ACPI mode except for the ACPI module device table
boilerplate. With that added and identified as "BCM2848",
an id in use by other OSs for this device, the dw2
controller on the BCM2711 will work.

Signed-off-by: Jeremy Linton <jeremy.linton@arm.com>
---
 drivers/usb/dwc2/core.h     |  2 ++
 drivers/usb/dwc2/params.c   | 14 ++++++++++++++
 drivers/usb/dwc2/platform.c |  1 +
 3 files changed, 17 insertions(+)

diff --git a/drivers/usb/dwc2/core.h b/drivers/usb/dwc2/core.h
index 7161344c6522..defc6034af49 100644
--- a/drivers/usb/dwc2/core.h
+++ b/drivers/usb/dwc2/core.h
@@ -38,6 +38,7 @@
 #ifndef __DWC2_CORE_H__
 #define __DWC2_CORE_H__
 
+#include <linux/acpi.h>
 #include <linux/phy/phy.h>
 #include <linux/regulator/consumer.h>
 #include <linux/usb/gadget.h>
@@ -1339,6 +1340,7 @@ irqreturn_t dwc2_handle_common_intr(int irq, void *dev);
 
 /* The device ID match table */
 extern const struct of_device_id dwc2_of_match_table[];
+extern const struct acpi_device_id dwc2_acpi_match[];
 
 int dwc2_lowlevel_hw_enable(struct dwc2_hsotg *hsotg);
 int dwc2_lowlevel_hw_disable(struct dwc2_hsotg *hsotg);
diff --git a/drivers/usb/dwc2/params.c b/drivers/usb/dwc2/params.c
index 92df3d620f7d..127878a0a397 100644
--- a/drivers/usb/dwc2/params.c
+++ b/drivers/usb/dwc2/params.c
@@ -232,6 +232,12 @@ const struct of_device_id dwc2_of_match_table[] = {
 };
 MODULE_DEVICE_TABLE(of, dwc2_of_match_table);
 
+const struct acpi_device_id dwc2_acpi_match[] = {
+	{ "BCM2848", dwc2_set_bcm_params },
+	{ },
+};
+MODULE_DEVICE_TABLE(acpi, dwc2_acpi_match);
+
 static void dwc2_set_param_otg_cap(struct dwc2_hsotg *hsotg)
 {
 	u8 val;
@@ -878,6 +884,14 @@ int dwc2_init_params(struct dwc2_hsotg *hsotg)
 	if (match && match->data) {
 		set_params = match->data;
 		set_params(hsotg);
+	} else {
+		struct acpi_device_id *amatch;
+
+		amatch = acpi_match_device(dwc2_acpi_match, hsotg->dev);
+		if (amatch && amatch->driver_data) {
+			set_params = amatch->driver_data;
+			set_params(hsotg);
+		}
 	}
 
 	dwc2_check_params(hsotg);
diff --git a/drivers/usb/dwc2/platform.c b/drivers/usb/dwc2/platform.c
index 5f18acac7406..53fc6bc3ed1a 100644
--- a/drivers/usb/dwc2/platform.c
+++ b/drivers/usb/dwc2/platform.c
@@ -734,6 +734,7 @@ static struct platform_driver dwc2_platform_driver = {
 	.driver = {
 		.name = dwc2_driver_name,
 		.of_match_table = dwc2_of_match_table,
+		.acpi_match_table = ACPI_PTR(dwc2_acpi_match),
 		.pm = &dwc2_dev_pm_ops,
 	},
 	.probe = dwc2_driver_probe,
-- 
2.26.2

