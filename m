Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C6B3C443830
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Nov 2021 23:02:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231971AbhKBWFM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 2 Nov 2021 18:05:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33844 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231272AbhKBWE4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 Nov 2021 18:04:56 -0400
Received: from ms.lwn.net (ms.lwn.net [IPv6:2600:3c01:e000:3a1::42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 474A5C061714
        for <linux-kernel@vger.kernel.org>; Tue,  2 Nov 2021 15:02:21 -0700 (PDT)
Received: from meer.lwn.net (unknown [IPv6:2601:281:8300:104d::5f6])
        by ms.lwn.net (Postfix) with ESMTPA id CF1A05ECB;
        Tue,  2 Nov 2021 22:02:20 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 ms.lwn.net CF1A05ECB
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=lwn.net; s=20201203;
        t=1635890541; bh=2wGyJfIQVSZrWD9oS01T9AMKg1Ln7sYga/NfPQ5b2q4=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=V0v2SUwE1xSYVsir6Gf9BgziqmX5AtLuppGiOZnNkprEI+AqSro0tDvA/NdYC3m7+
         7J76N/++ONgO19Rd+qqAqFlbyWeZIAD42ljq+IDr1YUR3pYmDDyMlNhINlFBz+dnWe
         qACaPXf76VU4Wz0b1JkO+aSjzG0WeV6/FKy/1U1Vop0e1f9VKgWtTEVBzjBDtHBT51
         EllFuw4zdHuPSIl8HTOU5N6hWuD6dEGERGaRAaNnSCoOcOpPOINf0DVxmA5IwswGkn
         tvoKeOxm6QCxrC78FhvuNvdK+P8Wdu4CydOr/GMzEWRJOJxAWqoEt9c+qHoWyLuUAZ
         YMl2AAwqwwu6Q==
From:   Jonathan Corbet <corbet@lwn.net>
To:     linux-kernel@vger.kernel.org
Cc:     Jonathan Corbet <corbet@lwn.net>,
        "Signed-off-by : Arnd Bergmann" <arnd@arndb.de>,
        "Signed-off-by : Mark Brown" <broonie@kernel.org>,
        linux-arm-kernel@lists.infradead.org
Subject: [PATCH 8/9] spi: remove unused header file <linux/platform_data/spi-clps711x.h>
Date:   Tue,  2 Nov 2021 16:02:02 -0600
Message-Id: <20211102220203.940290-9-corbet@lwn.net>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20211102220203.940290-1-corbet@lwn.net>
References: <20211102220203.940290-1-corbet@lwn.net>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Commit 6acaadc852f1 ("spi: clps711x: Driver refactor") removed the only use
of <linux/platform_data/spi-clps711x.h>, but left the header file behind.
This file is unused, delete it.

Cc: Signed-off-by: Arnd Bergmann <arnd@arndb.de>
Cc: Signed-off-by: Mark Brown <broonie@kernel.org>
Cc: linux-arm-kernel@lists.infradead.org
Signed-off-by: Jonathan Corbet <corbet@lwn.net>
---
 include/linux/platform_data/spi-clps711x.h | 17 -----------------
 1 file changed, 17 deletions(-)
 delete mode 100644 include/linux/platform_data/spi-clps711x.h

diff --git a/include/linux/platform_data/spi-clps711x.h b/include/linux/platform_data/spi-clps711x.h
deleted file mode 100644
index efaa596848c9..000000000000
--- a/include/linux/platform_data/spi-clps711x.h
+++ /dev/null
@@ -1,17 +0,0 @@
-/* SPDX-License-Identifier: GPL-2.0-or-later */
-/*
- *  CLPS711X SPI bus driver definitions
- *
- *  Copyright (C) 2012 Alexander Shiyan <shc_work@mail.ru>
- */
-
-#ifndef ____LINUX_PLATFORM_DATA_SPI_CLPS711X_H
-#define ____LINUX_PLATFORM_DATA_SPI_CLPS711X_H
-
-/* Board specific platform_data */
-struct spi_clps711x_pdata {
-	int *chipselect;	/* Array of GPIO-numbers */
-	int num_chipselect;	/* Total count of GPIOs */
-};
-
-#endif
-- 
2.31.1

