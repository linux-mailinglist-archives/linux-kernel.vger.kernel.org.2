Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 870264448B8
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Nov 2021 20:05:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231230AbhKCTHd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 3 Nov 2021 15:07:33 -0400
Received: from linux.microsoft.com ([13.77.154.182]:58990 "EHLO
        linux.microsoft.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229697AbhKCTHb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 Nov 2021 15:07:31 -0400
Received: from sequoia.work.tihix.com (162-237-133-238.lightspeed.rcsntx.sbcglobal.net [162.237.133.238])
        by linux.microsoft.com (Postfix) with ESMTPSA id BDA5020519AA;
        Wed,  3 Nov 2021 12:04:54 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com BDA5020519AA
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
        s=default; t=1635966295;
        bh=Ul80Vu5Otv/Oegs5gBk421bsnOEAue0lkyMmdBXmyNY=;
        h=From:To:Cc:Subject:Date:From;
        b=KX/Jk4oRJ2aamGJrdsiUFwzyiOsudtC5eZZZ+wjqm5W/YQOz1aPWLzGMC1yI/5eyl
         fZZlq2bjFC+axiCSMFLWMipVQevrVF190rZmntQlrYv7hWmVoEddU8tg+xJIhq3Koe
         UpUN5UtAUWwy85iiOk3J/5k6jN7bBveqUiqot2KQ=
From:   Tyler Hicks <tyhicks@linux.microsoft.com>
To:     Lee Jones <lee.jones@linaro.org>
Cc:     Alistair Francis <alistair@alistair23.me>,
        linux-kernel@vger.kernel.org
Subject: [PATCH] mfd: simple-mfd-i2c: Fix linker error due to new mfd-core dependency
Date:   Wed,  3 Nov 2021 14:04:26 -0500
Message-Id: <20211103190426.1511507-1-tyhicks@linux.microsoft.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Select CONFIG_MFD_CORE from CONFIG_MFD_SIMPLE_MFD_I2C, now that
simple-mfd-i2c.c calls devm_mfd_add_devices(), to fix the following
linker error:

 ld: drivers/mfd/simple-mfd-i2c.o: in function `simple_mfd_i2c_probe':
 simple-mfd-i2c.c:(.text+0x62): undefined reference to `devm_mfd_add_devices'
 make: *** [Makefile:1187: vmlinux] Error 1

Fixes: c753ea31781a ("mfd: simple-mfd-i2c: Add support for registering devices via MFD cells")
Cc: stable@vger.kernel.org # 5.15.x
Signed-off-by: Tyler Hicks <tyhicks@linux.microsoft.com>
---
 drivers/mfd/Kconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/mfd/Kconfig b/drivers/mfd/Kconfig
index ca0edab91aeb..d2f345245538 100644
--- a/drivers/mfd/Kconfig
+++ b/drivers/mfd/Kconfig
@@ -1194,6 +1194,7 @@ config MFD_SI476X_CORE
 config MFD_SIMPLE_MFD_I2C
 	tristate
 	depends on I2C
+	select MFD_CORE
 	select REGMAP_I2C
 	help
 	  This driver creates a single register map with the intention for it
-- 
2.25.1

