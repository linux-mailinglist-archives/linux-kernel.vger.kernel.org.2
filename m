Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 92DC436B923
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Apr 2021 20:40:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235927AbhDZSkw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 26 Apr 2021 14:40:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46550 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238102AbhDZSjD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Apr 2021 14:39:03 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 648CAC061574
        for <linux-kernel@vger.kernel.org>; Mon, 26 Apr 2021 11:38:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
        Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
        Content-Description:In-Reply-To:References;
        bh=67Creo4gLYBxQ5qf1EsBIy56GvQMCAKhgqOjplxQ+n0=; b=tNMMxKClPJhYnpSnH/C/7EV1OS
        Jq+zn7FW3Z2pImBVHwcPA1WtVjIgmxU1+Wh/j5ra78tTMpOJYoOgELlO9W1O3lPi18GUrrt36sDdU
        gkuUtz6+sMxzL9ZOhaBstRpvMJB+3SHEAt/6nI6kxNFpjqCLJa2GlI3YV9qUCyZR6KbE06xvkSTPL
        4bI1PKKmJr18/NHLP+4sBidxe2yGvv3BBtDCZHAGdXuILkG9MBFAf+sacC+kZ5iIKn279cW2yeoFb
        Tt74WyT7+KkkHoTCT14HZ+HGncWqnRP3zV1gDARCzmfdBw8oKCF2u8YrmJ/gTwDHAovcd+xPmeTQm
        Js9mEdtQ==;
Received: from [2601:1c0:6280:3f0::df68] (helo=casper.infradead.org)
        by casper.infradead.org with esmtpsa (Exim 4.94 #2 (Red Hat Linux))
        id 1lb67I-005xzJ-7h; Mon, 26 Apr 2021 18:37:58 +0000
From:   Randy Dunlap <rdunlap@infradead.org>
To:     linux-kernel@vger.kernel.org
Cc:     Randy Dunlap <rdunlap@infradead.org>,
        Matti Vaittinen <matti.vaittinen@fi.rohmeurope.com>,
        Lee Jones <lee.jones@linaro.org>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>
Subject: [PATCH -next RESEND] regulator: BD71815: select REGULATOR_ROHM to fix link errors
Date:   Mon, 26 Apr 2021 11:37:52 -0700
Message-Id: <20210426183752.19089-1-rdunlap@infradead.org>
X-Mailer: git-send-email 2.26.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

With REGULATOR_ROHM there are linker errors:

ld: drivers/regulator/bd71815-regulator.o: in function `set_hw_dvs_levels':
bd71815-regulator.c:(.text+0xbb): undefined reference to `rohm_regulator_set_dvs_levels'
ld: drivers/regulator/bd71815-regulator.o: in function `buck12_set_hw_dvs_levels':
bd71815-regulator.c:(.text+0x33e): undefined reference to `rohm_regulator_set_dvs_levels'

Fixes: 1aad39001e851 ("regulator: Support ROHM BD71815 regulators")
Signed-off-by: Randy Dunlap <rdunlap@infradead.org>
Cc: Matti Vaittinen <matti.vaittinen@fi.rohmeurope.com>
Cc: Lee Jones <lee.jones@linaro.org>
Cc: Liam Girdwood <lgirdwood@gmail.com>
Cc: Mark Brown <broonie@kernel.org>
---
Sorry about the Resend. I'm having some email problems.

 drivers/regulator/Kconfig |    1 +
 1 file changed, 1 insertion(+)

--- linux-next-20210426.orig/drivers/regulator/Kconfig
+++ linux-next-20210426/drivers/regulator/Kconfig
@@ -207,6 +207,7 @@ config REGULATOR_BD70528
 config REGULATOR_BD71815
 	tristate "ROHM BD71815 Power Regulator"
 	depends on MFD_ROHM_BD71828
+	select REGULATOR_ROHM
 	help
 	  This driver supports voltage regulators on ROHM BD71815 PMIC.
 	  This will enable support for the software controllable buck
