Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A2E94355042
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Apr 2021 11:42:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233732AbhDFJmR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 6 Apr 2021 05:42:17 -0400
Received: from szxga05-in.huawei.com ([45.249.212.191]:15493 "EHLO
        szxga05-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232997AbhDFJmQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Apr 2021 05:42:16 -0400
Received: from DGGEMS410-HUB.china.huawei.com (unknown [172.30.72.60])
        by szxga05-in.huawei.com (SkyGuard) with ESMTP id 4FF2Ym0mN0zrd5Y;
        Tue,  6 Apr 2021 17:39:56 +0800 (CST)
Received: from huawei.com (10.67.174.47) by DGGEMS410-HUB.china.huawei.com
 (10.3.19.210) with Microsoft SMTP Server id 14.3.498.0; Tue, 6 Apr 2021
 17:41:58 +0800
From:   He Ying <heying24@huawei.com>
To:     <gregkh@linuxfoundation.org>, <nsaenzjulienne@suse.de>,
        <sudeep.holla@arm.com>, <linus.walleij@linaro.org>,
        <robh@kernel.org>, <john.stultz@linaro.org>,
        <colin.king@canonical.com>
CC:     <heying24@huawei.com>, <linux-kernel@vger.kernel.org>
Subject: [PATCH V2] firmware: qcom-scm: Fix QCOM_SCM configuration
Date:   Tue, 6 Apr 2021 05:42:00 -0400
Message-ID: <20210406094200.60952-1-heying24@huawei.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.67.174.47]
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When CONFIG_QCOM_SCM is y and CONFIG_HAVE_ARM_SMCCC
is not set, compiling errors are encountered as follows:

drivers/firmware/qcom_scm-smc.o: In function `__scm_smc_do_quirk':
qcom_scm-smc.c:(.text+0x36): undefined reference to `__arm_smccc_smc'
drivers/firmware/qcom_scm-legacy.o: In function `scm_legacy_call':
qcom_scm-legacy.c:(.text+0xe2): undefined reference to `__arm_smccc_smc'
drivers/firmware/qcom_scm-legacy.o: In function `scm_legacy_call_atomic':
qcom_scm-legacy.c:(.text+0x1f0): undefined reference to `__arm_smccc_smc'

Note that __arm_smccc_smc is defined when HAVE_ARM_SMCCC is y.
So add dependency on HAVE_ARM_SMCCC in QCOM_SCM configuration.

Fixes: 916f743da354 ("firmware: qcom: scm: Move the scm driver to drivers/firmware")
Reported-by: Hulk Robot <hulkci@huawei.com>
Signed-off-by: He Ying <heying24@huawei.com>
---
V2:
- Add Fixes tag

 drivers/firmware/Kconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/firmware/Kconfig b/drivers/firmware/Kconfig
index 3f14dffb9669..5dd19dbd67a3 100644
--- a/drivers/firmware/Kconfig
+++ b/drivers/firmware/Kconfig
@@ -237,6 +237,7 @@ config INTEL_STRATIX10_RSU
 config QCOM_SCM
 	bool
 	depends on ARM || ARM64
+	depends on HAVE_ARM_SMCCC
 	select RESET_CONTROLLER
 
 config QCOM_SCM_DOWNLOAD_MODE_DEFAULT
-- 
2.17.1

