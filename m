Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4CA843F0506
	for <lists+linux-kernel@lfdr.de>; Wed, 18 Aug 2021 15:40:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238689AbhHRNlT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 18 Aug 2021 09:41:19 -0400
Received: from mail.kernel.org ([198.145.29.99]:40812 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S237685AbhHRNkS (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Aug 2021 09:40:18 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 29F9A610C9
        for <linux-kernel@vger.kernel.org>; Wed, 18 Aug 2021 13:39:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1629293982;
        bh=emCVGi8RUaxRXQSy47g4RuVgdLf1+5hiHeDFC9rQ1zw=;
        h=From:To:Subject:Date:In-Reply-To:References:From;
        b=nAVIBys/De/s/XBSTo+wxeYCXWXQhI/l3mDm2QCjf6qcNj33vWVOlcCVbpBFUHZT7
         s9H+YjeF7VmO92ro1HvUIJ6MIBYGAfk1EZ2jSPQZSpFmhmIcdfwqIVjUIBJV+LWT6f
         nVjwDEL2U3ew6pvo6fx2WIUGcMsEk1tpn0vERnc2x+7KVHPAODGK+HfT+RGTsacSPX
         UoYicdWxY9aU7h0XRaYcoaKHawy99JSi6ZIgooXGFPaarZOmSlm+8c4BA4g0iJpGmu
         dH3/OpJKMsVgSvjznGFrZ6BZvFUCxiHoedFrHXVfctWo48HcmOpFXfLKf5vzYHBFNu
         aOC/XVwk3+0Xw==
From:   Oded Gabbay <ogabbay@kernel.org>
To:     linux-kernel@vger.kernel.org
Subject: [PATCH 14/16] habanalabs/gaudi: define DC POWER for secured PMC
Date:   Wed, 18 Aug 2021 16:39:20 +0300
Message-Id: <20210818133922.63637-14-ogabbay@kernel.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20210818133922.63637-1-ogabbay@kernel.org>
References: <20210818133922.63637-1-ogabbay@kernel.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In secured mode, the CGM is disabled. Therefore, the DC power is
higher. Without taking it into consideration, the utilization is
12-15% at idle.

Signed-off-by: Oded Gabbay <ogabbay@kernel.org>
---
 drivers/misc/habanalabs/gaudi/gaudi.c  | 6 +++++-
 drivers/misc/habanalabs/gaudi/gaudiP.h | 2 ++
 2 files changed, 7 insertions(+), 1 deletion(-)

diff --git a/drivers/misc/habanalabs/gaudi/gaudi.c b/drivers/misc/habanalabs/gaudi/gaudi.c
index c8bd76e30679..ba1fcdc16f50 100644
--- a/drivers/misc/habanalabs/gaudi/gaudi.c
+++ b/drivers/misc/habanalabs/gaudi/gaudi.c
@@ -506,7 +506,11 @@ static inline void set_default_power_values(struct hl_device *hdev)
 
 	if (hdev->card_type == cpucp_card_type_pmc) {
 		prop->max_power_default = MAX_POWER_DEFAULT_PMC;
-		prop->dc_power_default = DC_POWER_DEFAULT_PMC;
+
+		if (prop->fw_security_enabled)
+			prop->dc_power_default = DC_POWER_DEFAULT_PMC_SEC;
+		else
+			prop->dc_power_default = DC_POWER_DEFAULT_PMC;
 	} else {
 		prop->max_power_default = MAX_POWER_DEFAULT_PCI;
 		prop->dc_power_default = DC_POWER_DEFAULT_PCI;
diff --git a/drivers/misc/habanalabs/gaudi/gaudiP.h b/drivers/misc/habanalabs/gaudi/gaudiP.h
index 2f0928c0fa8f..7addb31e3eee 100644
--- a/drivers/misc/habanalabs/gaudi/gaudiP.h
+++ b/drivers/misc/habanalabs/gaudi/gaudiP.h
@@ -52,6 +52,8 @@
 #define DC_POWER_DEFAULT_PCI		60000		/* 60W */
 #define DC_POWER_DEFAULT_PMC		60000		/* 60W */
 
+#define DC_POWER_DEFAULT_PMC_SEC	97000		/* 97W */
+
 #define GAUDI_CPU_TIMEOUT_USEC		30000000	/* 30s */
 
 #define TPC_ENABLED_MASK		0xFF
-- 
2.17.1

