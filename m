Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 54CE83DC837
	for <lists+linux-kernel@lfdr.de>; Sat, 31 Jul 2021 22:50:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231590AbhGaUtn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 31 Jul 2021 16:49:43 -0400
Received: from foss.arm.com ([217.140.110.172]:52372 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229958AbhGaUtl (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 31 Jul 2021 16:49:41 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 4A859106F;
        Sat, 31 Jul 2021 13:49:34 -0700 (PDT)
Received: from localhost.localdomain (unknown [172.31.20.19])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 06B103F70D;
        Sat, 31 Jul 2021 13:49:31 -0700 (PDT)
From:   Andre Przywara <andre.przywara@arm.com>
To:     Matt Mackall <mpm@selenic.com>,
        Herbert Xu <herbert@gondor.apana.org.au>,
        Mark Rutland <mark.rutland@arm.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Sudeep Holla <sudeep.holla@arm.com>
Cc:     linux-crypto@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Ard Biesheuvel <ardb@kernel.org>,
        Mark Brown <broonie@kernel.org>, Will Deacon <will@kernel.org>,
        Ali Saidi <alisaidi@amazon.com>,
        Jon Nettleton <jon@solid-run.com>
Subject: [PATCH v4 1/2] firmware: smccc: Register smccc_trng platform device
Date:   Sat, 31 Jul 2021 21:48:44 +0100
Message-Id: <20210731204845.21196-2-andre.przywara@arm.com>
X-Mailer: git-send-email 2.14.1
In-Reply-To: <20210731204845.21196-1-andre.przywara@arm.com>
References: <20210731204845.21196-1-andre.przywara@arm.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

At the moment we probe for the Random Number Generator SMCCC service,
and use that in the core code (arch_get_random). However the hardware
entropy can also be useful to access from userland, and be it to assess
its quality.

Register a platform device when the SMCCC TRNG service is detected, to
allow a hw_random driver to hook onto this.

The function registering the device is deliberately made in a way which
allows expansion, so other services that could be exposed via a platform
device (or some other interface), can be added here easily.

Signed-off-by: Andre Przywara <andre.przywara@arm.com>
---
 drivers/firmware/smccc/smccc.c | 17 +++++++++++++++++
 1 file changed, 17 insertions(+)

diff --git a/drivers/firmware/smccc/smccc.c b/drivers/firmware/smccc/smccc.c
index 9f937b125ab0..60ccf3e90d7d 100644
--- a/drivers/firmware/smccc/smccc.c
+++ b/drivers/firmware/smccc/smccc.c
@@ -9,6 +9,7 @@
 #include <linux/init.h>
 #include <linux/arm-smccc.h>
 #include <linux/kernel.h>
+#include <linux/platform_device.h>
 #include <asm/archrandom.h>
 
 static u32 smccc_version = ARM_SMCCC_VERSION_1_0;
@@ -42,3 +43,19 @@ u32 arm_smccc_get_version(void)
 	return smccc_version;
 }
 EXPORT_SYMBOL_GPL(arm_smccc_get_version);
+
+static int __init smccc_devices_init(void)
+{
+	struct platform_device *pdev;
+
+	if (smccc_trng_available) {
+		pdev = platform_device_register_simple("smccc_trng", -1,
+						       NULL, 0);
+		if (IS_ERR(pdev))
+			pr_err("smccc_trng: could not register device: %ld\n",
+			       PTR_ERR(pdev));
+	}
+
+	return 0;
+}
+device_initcall(smccc_devices_init);
-- 
2.17.6

