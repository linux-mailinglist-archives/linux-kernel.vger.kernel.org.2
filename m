Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3985136817B
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Apr 2021 15:33:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236402AbhDVNeW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 22 Apr 2021 09:34:22 -0400
Received: from mail.kernel.org ([198.145.29.99]:59404 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230005AbhDVNeV (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Apr 2021 09:34:21 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id B04246145D;
        Thu, 22 Apr 2021 13:33:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1619098426;
        bh=t0BYMH9xcCAjPvr3dKnR2jagiZDPjThmRe480mlqi6c=;
        h=From:To:Cc:Subject:Date:From;
        b=nQMbtwnCnIgGYk3xZ3/grusI8phMVT8ff4ZhZrjvBCsu3v7MLr8bduOyneaaNtEwE
         /aM+gZjej9VOsTadtjsUlGaKxRXvTaE8XJkRNQhGcIwlzgkKDR9K4ufhugHHNKVJh2
         2fepBVLnfILj+01bvKmi1QyjvuC2mFZx3BOz/IA1MGuPqMAyw51dUhpfJE5TvZAwjb
         +t5zNdOxHVBCv8WECf/i4+SvduVfxt9eSlLt2tmzyvBL6j2+dr5j3y3D3l9KNSrRnN
         5eucFOiQV9vat9UXUMEIkSHkCJNgulctxOuSQWrPkkP9M0HdTqQa/qMdPnt/DUpeeY
         ySa4B57PJjevA==
From:   Arnd Bergmann <arnd@kernel.org>
To:     Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Matti Vaittinen <matti.vaittinen@fi.rohmeurope.com>,
        Lee Jones <lee.jones@linaro.org>
Cc:     Arnd Bergmann <arnd@arndb.de>, linux-power@fi.rohmeurope.com,
        linux-kernel@vger.kernel.org
Subject: [PATCH] regulator: bd71815: include <linux/of.h> and <linux/gpio/consumer.h>
Date:   Thu, 22 Apr 2021 15:33:25 +0200
Message-Id: <20210422133338.1734640-1-arnd@kernel.org>
X-Mailer: git-send-email 2.29.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Arnd Bergmann <arnd@arndb.de>

The new driver causes a build failure because of a missing includes:

drivers/regulator/bd71815-regulator.c: In function 'buck12_set_hw_dvs_levels':
drivers/regulator/bd71815-regulator.c:210:13: error: implicit declaration of function 'of_find_property' [-Werror=implicit-function-declaration]
  210 |         if (of_find_property(np, "rohm,dvs-run-voltage", NULL) ||
      |             ^~~~~~~~~~~~~~~~
drivers/regulator/bd71815-regulator.c: At top level:
drivers/regulator/bd71815-regulator.c:461:37: error: implicit declaration of function 'of_match_ptr' [-Werror=implicit-function-declaration]
  461 |                         .of_match = of_match_ptr(#_name),               \
      |                                     ^~~~~~~~~~~~
drivers/regulator/bd71815-regulator.c: In function 'bd7181x_probe':
drivers/regulator/bd71815-regulator.c:590:19: error: implicit declaration of function 'devm_gpiod_get_from_of_node' [-Werror=implicit-function-declaration]
  590 |         ldo4_en = devm_gpiod_get_from_of_node(&pdev->dev,
      |                   ^~~~~~~~~~~~~~~~~~~~~~~~~~~
drivers/regulator/bd71815-regulator.c:593:50: error: 'GPIOD_ASIS' undeclared (first use in this function); did you mean 'GPIOF_IN'?
  593 |                                                  GPIOD_ASIS, "ldo4-en");
      |                                                  ^~~~~~~~~~
      |                                                  GPIOF_IN

Fixes: 1aad39001e85 ("regulator: Support ROHM BD71815 regulators")
Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
As found yesterday with another patch I sent for this driver,
it is apparently not part of the regulator tree but only merged
through Lee's mfd tree.
---
 drivers/regulator/bd71815-regulator.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/regulator/bd71815-regulator.c b/drivers/regulator/bd71815-regulator.c
index a4e8d5e36b40..5be2b01632a0 100644
--- a/drivers/regulator/bd71815-regulator.c
+++ b/drivers/regulator/bd71815-regulator.c
@@ -16,9 +16,10 @@
 #include <linux/regulator/driver.h>
 #include <linux/delay.h>
 #include <linux/slab.h>
-#include <linux/gpio.h>
+#include <linux/gpio/consumer.h>
 #include <linux/mfd/rohm-generic.h>
 #include <linux/mfd/rohm-bd71815.h>
+#include <linux/of.h>
 #include <linux/regulator/of_regulator.h>
 
 struct bd71815_regulator {
-- 
2.29.2

