Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id ABC52366D44
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Apr 2021 15:54:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239436AbhDUNzO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 21 Apr 2021 09:55:14 -0400
Received: from mail.kernel.org ([198.145.29.99]:60512 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S235434AbhDUNzN (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Apr 2021 09:55:13 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id C7F9661445;
        Wed, 21 Apr 2021 13:54:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1619013280;
        bh=xsSRZkZgikKP0lAUU0pZmINr59Nb0l2owCZotO2GYEk=;
        h=From:To:Cc:Subject:Date:From;
        b=i1qgcFVMKCUH+ijRpqfAWmAOO2HHEms+iY2/YL0CquBOaBahdegI+oBA56jkMEuVC
         P7YxORNasFIkSQenTzRYzFQIOnzF9yXrbM6uJNl9bx/i0mrHrwFLvYlBuQ6/4fnJcx
         jqUaNzMs8BqGExG7/slTfE/sf60mJiTX91ySpInsbr2mk8e9peMM322Ol498qWqfA+
         cChOadTTF227LA/L2wpwdY6ZQ0FEbTODLKIcOoD5YrQXcutJLLkUkzglMK6Yw2Qk1P
         8GW+KtaxZLUkx+4vI+3sGe35495ehA196qlcdQkt5Bc9iXeVxiO0aFfypAUmynLbtb
         0YF1QYaiaDByA==
From:   Arnd Bergmann <arnd@kernel.org>
To:     Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Lee Jones <lee.jones@linaro.org>,
        Matti Vaittinen <matti.vaittinen@fi.rohmeurope.com>
Cc:     Arnd Bergmann <arnd@arndb.de>,
        ChiYuan Huang <cy_huang@richtek.com>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Christoph Fritz <chf.fritz@googlemail.com>,
        Axel Lin <axel.lin@ingics.com>,
        Vincent Whitchurch <vincent.whitchurch@axis.com>,
        Adam Ward <Adam.Ward.opensource@diasemi.com>,
        Krzysztof Kozlowski <krzk@kernel.org>,
        linux-kernel@vger.kernel.org
Subject: [PATCH] regulator: bd71815: select CONFIG_ROHM_REGULATOR
Date:   Wed, 21 Apr 2021 15:54:27 +0200
Message-Id: <20210421135433.3505561-1-arnd@kernel.org>
X-Mailer: git-send-email 2.29.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Arnd Bergmann <arnd@arndb.de>

The newly added driver is missing a dependency as shown by this
randconfig build failure:

arm-linux-gnueabi-ld: drivers/regulator/bd71815-regulator.o: in function `buck12_set_hw_dvs_levels':
bd71815-regulator.c:(.text+0x4b6): undefined reference to `rohm_regulator_set_dvs_levels'

Fixes: 1aad39001e85 ("regulator: Support ROHM BD71815 regulators")
Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
 drivers/regulator/Kconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/regulator/Kconfig b/drivers/regulator/Kconfig
index 9d84d9245490..9aeb32c320aa 100644
--- a/drivers/regulator/Kconfig
+++ b/drivers/regulator/Kconfig
@@ -207,6 +207,7 @@ config REGULATOR_BD70528
 config REGULATOR_BD71815
 	tristate "ROHM BD71815 Power Regulator"
 	depends on MFD_ROHM_BD71828
+	select REGULATOR_ROHM
 	help
 	  This driver supports voltage regulators on ROHM BD71815 PMIC.
 	  This will enable support for the software controllable buck
-- 
2.29.2

