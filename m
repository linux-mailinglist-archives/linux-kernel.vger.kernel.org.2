Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6C4E733875B
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Mar 2021 09:30:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232262AbhCLI3p (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 12 Mar 2021 03:29:45 -0500
Received: from inva021.nxp.com ([92.121.34.21]:56198 "EHLO inva021.nxp.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232274AbhCLI3l (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 12 Mar 2021 03:29:41 -0500
Received: from inva021.nxp.com (localhost [127.0.0.1])
        by inva021.eu-rdc02.nxp.com (Postfix) with ESMTP id 39BFD20064D;
        Fri, 12 Mar 2021 09:29:38 +0100 (CET)
Received: from invc005.ap-rdc01.nxp.com (invc005.ap-rdc01.nxp.com [165.114.16.14])
        by inva021.eu-rdc02.nxp.com (Postfix) with ESMTP id A830C2008F3;
        Fri, 12 Mar 2021 09:29:35 +0100 (CET)
Received: from localhost.localdomain (mega.ap.freescale.net [10.192.208.232])
        by invc005.ap-rdc01.nxp.com (Postfix) with ESMTP id 48CD84029B;
        Fri, 12 Mar 2021 09:29:29 +0100 (CET)
From:   Ran Wang <ran.wang_1@nxp.com>
To:     Jens Wiklander <jens.wiklander@linaro.org>
Cc:     op-tee@lists.trustedfirmware.org, linux-kernel@vger.kernel.org,
        Ran Wang <ran.wang_1@nxp.com>
Subject: [PATCH] optee: enable apci support
Date:   Fri, 12 Mar 2021 16:36:53 +0800
Message-Id: <20210312083653.38780-1-ran.wang_1@nxp.com>
X-Mailer: git-send-email 2.17.1
X-Virus-Scanned: ClamAV using ClamSMTP
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch add ACPI support for optee driver.

Signed-off-by: Ran Wang <ran.wang_1@nxp.com>
---
 drivers/tee/optee/core.c | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/drivers/tee/optee/core.c b/drivers/tee/optee/core.c
index cf4718c6d35d..8fb261f4b9db 100644
--- a/drivers/tee/optee/core.c
+++ b/drivers/tee/optee/core.c
@@ -5,6 +5,7 @@
 
 #define pr_fmt(fmt) KBUILD_MODNAME ": " fmt
 
+#include <linux/acpi.h>
 #include <linux/arm-smccc.h>
 #include <linux/errno.h>
 #include <linux/io.h>
@@ -735,12 +736,21 @@ static const struct of_device_id optee_dt_match[] = {
 };
 MODULE_DEVICE_TABLE(of, optee_dt_match);
 
+#ifdef CONFIG_ACPI
+static const struct acpi_device_id optee_acpi_match[] = {
+	{ "OPTEE01",},
+	{ },
+};
+MODULE_DEVICE_TABLE(acpi, dwc3_acpi_match);
+#endif
+
 static struct platform_driver optee_driver = {
 	.probe  = optee_probe,
 	.remove = optee_remove,
 	.driver = {
 		.name = "optee",
 		.of_match_table = optee_dt_match,
+		.acpi_match_table = ACPI_PTR(optee_acpi_match),
 	},
 };
 module_platform_driver(optee_driver);
-- 
2.25.1

