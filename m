Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AFD3B308DCF
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Jan 2021 20:59:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233065AbhA2Twv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 29 Jan 2021 14:52:51 -0500
Received: from mail.kernel.org ([198.145.29.99]:58242 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232863AbhA2Twq (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 29 Jan 2021 14:52:46 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id 55EA364E12;
        Fri, 29 Jan 2021 19:52:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1611949925;
        bh=9mLiGpXk6bvkY+x4LV/OFvu74lal4nzyr2VPTxZeGVk=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=CJPoslY/cGvuk/BxzdZnfpsdeDjI0BUUu6krvgOwflx1Lc/6RA911p/YSzzazDpQT
         /XsIl5slMgtcH4qDB1tcJ7kcBp9j5WNDmoginQO42f+XuWkXvjUUYsQjqe++KTv2mN
         Kbh3XTV+e0iIw0tNBODPOnCxGhy+utn6xjuRHAHwRx4PDdTNcstbbyY8shrkJ0fx01
         dUnKcxeE0pq9zEu9uz42wIqv/cUgnrv4uw8B6/JUI/crpddIUDd5xZNImObjhu8evm
         0CkrM8jYFBsXo1H/qDor/gNSyp2FfDIvz3lzS+Vr6JvfcOfRCXOakdJFY6S37bcW8k
         O4jFxxfokpOZw==
Received: by mail.kernel.org with local (Exim 4.94)
        (envelope-from <mchehab@kernel.org>)
        id 1l5ZoJ-007Wju-6V; Fri, 29 Jan 2021 20:52:03 +0100
From:   Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Mark Brown <broonie@kernel.org>,
        Lee Jones <lee.jones@linaro.org>
Cc:     Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
        Mayulong <mayulong1@huawei.com>, devel@driverdev.osuosl.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v8 09/14] staging: hikey9xx: hi6421-spmi-pmic: update copyright notes
Date:   Fri, 29 Jan 2021 20:51:55 +0100
Message-Id: <5a86478c8ccb93d3105485b5f16e20e9c12e2196.1611949675.git.mchehab+huawei@kernel.org>
X-Mailer: git-send-email 2.29.2
In-Reply-To: <cover.1611949675.git.mchehab+huawei@kernel.org>
References: <cover.1611949675.git.mchehab+huawei@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: Mauro Carvalho Chehab <mchehab@kernel.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

At PMIC subsystem, C89 comments are preferred over C99.
While here, also update the copyrights of the header file.

Signed-off-by: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
---
 drivers/staging/hikey9xx/hi6421-spmi-pmic.c | 14 +++++++-------
 include/linux/mfd/hi6421-spmi-pmic.h        |  1 +
 2 files changed, 8 insertions(+), 7 deletions(-)

diff --git a/drivers/staging/hikey9xx/hi6421-spmi-pmic.c b/drivers/staging/hikey9xx/hi6421-spmi-pmic.c
index 9c10f7c4e7c9..2301f4fcd48d 100644
--- a/drivers/staging/hikey9xx/hi6421-spmi-pmic.c
+++ b/drivers/staging/hikey9xx/hi6421-spmi-pmic.c
@@ -1,11 +1,11 @@
 // SPDX-License-Identifier: GPL-2.0
-//
-// Device driver for regulators in HISI PMIC IC
-//
-// Copyright (c) 2013 Linaro Ltd.
-// Copyright (c) 2011 Hisilicon.
-//
-// Copyright (c) 2020-2021 Huawei Technologies Co., Ltd
+/*
+ * Device driver for regulators in HISI PMIC IC
+ *
+ * Copyright (c) 2013 Linaro Ltd.
+ * Copyright (c) 2011 Hisilicon.
+ * Copyright (c) 2020-2021 Huawei Technologies Co., Ltd
+ */
 
 #include <linux/bitops.h>
 #include <linux/interrupt.h>
diff --git a/include/linux/mfd/hi6421-spmi-pmic.h b/include/linux/mfd/hi6421-spmi-pmic.h
index 4d61cb266a18..2660226138b8 100644
--- a/include/linux/mfd/hi6421-spmi-pmic.h
+++ b/include/linux/mfd/hi6421-spmi-pmic.h
@@ -4,6 +4,7 @@
  *
  * Copyright (c) 2013 Linaro Ltd.
  * Copyright (C) 2011 Hisilicon.
+ * Copyright (c) 2020-2021 Huawei Technologies Co., Ltd
  *
  * Guodong Xu <guodong.xu@linaro.org>
  */
-- 
2.29.2

