Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DE55538D7FA
	for <lists+linux-kernel@lfdr.de>; Sun, 23 May 2021 02:14:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231480AbhEWAQC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 22 May 2021 20:16:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36238 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231451AbhEWAP5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 22 May 2021 20:15:57 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:e::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 49E76C061574
        for <linux-kernel@vger.kernel.org>; Sat, 22 May 2021 17:14:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
        MIME-Version:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:
        Content-ID:Content-Description:In-Reply-To:References;
        bh=V741LUjrxIOzNlc1/QB9NN5ze4klKIAsKSm42CLSt1w=; b=QV34yF9LW3G4q7J9C7j5KvUNsq
        unKDtg6B0H5huimaFdLd7+C80Ufl6cCC0ULOcc4wklJZGyZZJ2MfhYKeMuWED6412fe3fdbUOPRcp
        bSctkRCvcu08duzYeKyGPMezOGevb5pxKjtyURh8WFs7JH8fTGgM3sAkWWFb+9aGI7jjTvtMtFoHD
        XEVd95HGDeFlW5Qjfx/6CJYjCg1PyasNsK+CASpbaqHUy04zxNGA1gbMlJg4bVpamLLVeYypPnqge
        AS4FnAkaDXheZVdJa+3NdJEpFNopYLf+odMBx4HGNoTdjXQsM8egmLeAe48Pod0OraDXBywrFpfJb
        aEoio8KA==;
Received: from [2601:1c0:6280:3f0::7376] (helo=bombadil.infradead.org)
        by bombadil.infradead.org with esmtpsa (Exim 4.94 #2 (Red Hat Linux))
        id 1lkblE-000FpR-JV; Sun, 23 May 2021 00:14:28 +0000
From:   Randy Dunlap <rdunlap@infradead.org>
To:     linux-kernel@vger.kernel.org
Cc:     Randy Dunlap <rdunlap@infradead.org>,
        Matti Vaittinen <matti.vaittinen@fi.rohmeurope.com>,
        Lee Jones <lee.jones@linaro.org>,
        Mark Brown <broonie@kernel.org>,
        Liam Girdwood <lgirdwood@gmail.com>
Subject: [PATCH] regulator: bd71815: add select to fix build
Date:   Sat, 22 May 2021 17:14:27 -0700
Message-Id: <20210523001427.13500-1-rdunlap@infradead.org>
X-Mailer: git-send-email 2.26.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Mend the Kconfig for REGULATOR_BD71815 to prevent build errors:

riscv32-linux-ld: drivers/regulator/bd71815-regulator.o: in function `.L0 ':
regulator.c:289: undefined reference to `rohm_regulator_set_dvs_levels'
riscv32-linux-ld: drivers/regulator/bd71815-regulator.c:370: undefined reference to `rohm_regulator_set_dvs_levels'

Fixes: 1aad39001e85 ("regulator: Support ROHM BD71815 regulators")
Signed-off-by: Randy Dunlap <rdunlap@infradead.org>
Cc: Matti Vaittinen <matti.vaittinen@fi.rohmeurope.com>
Cc: Lee Jones <lee.jones@linaro.org>
Cc: Mark Brown <broonie@kernel.org>
Cc: Liam Girdwood <lgirdwood@gmail.com>
---
 drivers/regulator/Kconfig |    1 +
 1 file changed, 1 insertion(+)

--- linux-next-20210521.orig/drivers/regulator/Kconfig
+++ linux-next-20210521/drivers/regulator/Kconfig
@@ -207,6 +207,7 @@ config REGULATOR_BD70528
 config REGULATOR_BD71815
 	tristate "ROHM BD71815 Power Regulator"
 	depends on MFD_ROHM_BD71828
+	select REGULATOR_ROHM
 	help
 	  This driver supports voltage regulators on ROHM BD71815 PMIC.
 	  This will enable support for the software controllable buck
