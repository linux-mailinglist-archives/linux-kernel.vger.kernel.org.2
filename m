Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 58CE6308DEA
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Jan 2021 20:59:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233179AbhA2T6C (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 29 Jan 2021 14:58:02 -0500
Received: from mail.kernel.org ([198.145.29.99]:58672 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233113AbhA2Tx1 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 29 Jan 2021 14:53:27 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id 5EBD564E15;
        Fri, 29 Jan 2021 19:52:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1611949925;
        bh=feBXUgjOCqV4KmfRmBNmIA+y1g/8EvSYsIHoefjUsvI=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=FiuQvuHwr15TI6v+1UaLclqtccNvElKWHl9kVCpKWCe2mebevxZq2I1+MGWauBSKF
         iTfCa+qdcAkfsHiuHs3+eDNqfkkTmEijNipZEwsczyrxbN8gTGDM1okLeRfDeuiKa1
         m6FFBFuPqJTNc9OM0CZPAcSbl+JgWLoilAZ360Gh+pXq3AnHSxCm6UTDUQQJknd5+I
         R/gAKMtf5Vv1DCA6T6PyZmy5C7vkOewI5gnMwCgeTYpVfEHKeNvjtdAE38svKjH4F0
         i7oRFLKkX0oF8Czm2zIVrApNXHd5KdHbpvP6d//PAb7lxsZje3Zwupz70QtI4z6TjS
         O8kXJyVh0rcpw==
Received: by mail.kernel.org with local (Exim 4.94)
        (envelope-from <mchehab@kernel.org>)
        id 1l5ZoJ-007Wjk-2t; Fri, 29 Jan 2021 20:52:03 +0100
From:   Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Mark Brown <broonie@kernel.org>,
        Lee Jones <lee.jones@linaro.org>
Cc:     Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
        Mayulong <mayulong1@huawei.com>, devel@driverdev.osuosl.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v8 05/14] staging: hikey9xx: hi6421-spmi-pmic: cleanup header file
Date:   Fri, 29 Jan 2021 20:51:51 +0100
Message-Id: <138c3a11e4de0ebabdf27932957852136c2f7510.1611949675.git.mchehab+huawei@kernel.org>
X-Mailer: git-send-email 2.29.2
In-Reply-To: <cover.1611949675.git.mchehab+huawei@kernel.org>
References: <cover.1611949675.git.mchehab+huawei@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: Mauro Carvalho Chehab <mchehab@kernel.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Remove the IRQ list from the header, as this is used only
inside the driver itself. Also, get rid of two unused
defines.

The net result is that only struct hi6421_spmi_pmic remains
on it, as this is used by the regulator driver.

Signed-off-by: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
---
 drivers/staging/hikey9xx/hi6421-spmi-pmic.c | 17 +++++++++++++++++
 include/linux/mfd/hi6421-spmi-pmic.h        | 20 --------------------
 2 files changed, 17 insertions(+), 20 deletions(-)

diff --git a/drivers/staging/hikey9xx/hi6421-spmi-pmic.c b/drivers/staging/hikey9xx/hi6421-spmi-pmic.c
index c8e55b7b08e2..909f7b106af4 100644
--- a/drivers/staging/hikey9xx/hi6421-spmi-pmic.c
+++ b/drivers/staging/hikey9xx/hi6421-spmi-pmic.c
@@ -17,6 +17,23 @@
 #include <linux/slab.h>
 #include <linux/spmi.h>
 
+enum hi6421_spmi_pmic_irq_list {
+	OTMP = 0,
+	VBUS_CONNECT,
+	VBUS_DISCONNECT,
+	ALARMON_R,
+	HOLD_6S,
+	HOLD_1S,
+	POWERKEY_UP,
+	POWERKEY_DOWN,
+	OCP_SCP_R,
+	COUL_R,
+	SIM0_HPD_R,
+	SIM0_HPD_F,
+	SIM1_HPD_R,
+	SIM1_HPD_F,
+	PMIC_IRQ_LIST_MAX,
+};
 /* 8-bit register offset in PMIC */
 #define HISI_MASK_STATE			0xff
 
diff --git a/include/linux/mfd/hi6421-spmi-pmic.h b/include/linux/mfd/hi6421-spmi-pmic.h
index aa8d5382f559..4d61cb266a18 100644
--- a/include/linux/mfd/hi6421-spmi-pmic.h
+++ b/include/linux/mfd/hi6421-spmi-pmic.h
@@ -14,9 +14,6 @@
 #include <linux/irqdomain.h>
 #include <linux/regmap.h>
 
-#define HISI_ECO_MODE_ENABLE		(1)
-#define HISI_ECO_MODE_DISABLE		(0)
-
 struct hi6421_spmi_pmic {
 	struct resource				*res;
 	struct device				*dev;
@@ -29,21 +26,4 @@ struct hi6421_spmi_pmic {
 	struct regmap				*regmap;
 };
 
-enum hi6421_spmi_pmic_irq_list {
-	OTMP = 0,
-	VBUS_CONNECT,
-	VBUS_DISCONNECT,
-	ALARMON_R,
-	HOLD_6S,
-	HOLD_1S,
-	POWERKEY_UP,
-	POWERKEY_DOWN,
-	OCP_SCP_R,
-	COUL_R,
-	SIM0_HPD_R,
-	SIM0_HPD_F,
-	SIM1_HPD_R,
-	SIM1_HPD_F,
-	PMIC_IRQ_LIST_MAX,
-};
 #endif		/* __HISI_PMIC_H */
-- 
2.29.2

