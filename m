Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7E86344382F
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Nov 2021 23:02:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231308AbhKBWFL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 2 Nov 2021 18:05:11 -0400
Received: from ms.lwn.net ([45.79.88.28]:53372 "EHLO ms.lwn.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229525AbhKBWE4 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 Nov 2021 18:04:56 -0400
Received: from meer.lwn.net (unknown [IPv6:2601:281:8300:104d::5f6])
        by ms.lwn.net (Postfix) with ESMTPA id 7045B5ECC;
        Tue,  2 Nov 2021 22:02:20 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 ms.lwn.net 7045B5ECC
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=lwn.net; s=20201203;
        t=1635890540; bh=dL7VBWHP87JECG3fkyi97Jd2x8qCMW8FkxQ5TKCxpJE=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=n/ca9iHxQBKEmPXTp6t0MnmyS4BkLQ2iW62WdL1QTn6UAd9LnS09rfJrny9b4wj7C
         kgQVo84H7yA93M3txhLBMhV1vF2GAr4Pr1fk4GsfwIw8qg3d8dwBY+iANboG3wQEDQ
         gVXQwRRu7ItoNHEOkJWwml1L1OGIEatc1h88miVW8OF/wig7kbEyH6Sg9vCSMW0Nlo
         2xmM8WZtKgxA0p/Za3qsW+k/3np2IcJ3aGNk6r6towGNNia7SLzlBpht76YCp+Jyw0
         5Ez9ilXzviZkfnevLofh+4bFYoHv3waWVfiyvFKwVwN/9EGMjXOCnHQXS1ZSihCy4d
         d3XeUWUcehIbQ==
From:   Jonathan Corbet <corbet@lwn.net>
To:     linux-kernel@vger.kernel.org
Cc:     Jonathan Corbet <corbet@lwn.net>,
        Linus Walleij <linus.walleij@linaro.org>,
        Arnd Bergmann <arnd@arndb.de>
Subject: [PATCH 7/9] ARM: ixp4xx: remove unused header file pata_ixp4xx_cf.h
Date:   Tue,  2 Nov 2021 16:02:01 -0600
Message-Id: <20211102220203.940290-8-corbet@lwn.net>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20211102220203.940290-1-corbet@lwn.net>
References: <20211102220203.940290-1-corbet@lwn.net>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Commit b00ced38e317 ("ARM: ixp4xx: Delete Avila boardfiles") removed the
last use of <linux/platform_data/pata_ixp4xx_cf.h> but left the header file
in place.  Nothing uses this file, delete it now.

Cc: Linus Walleij <linus.walleij@linaro.org>
Cc: Arnd Bergmann <arnd@arndb.de>
Signed-off-by: Jonathan Corbet <corbet@lwn.net>
---
 include/linux/platform_data/pata_ixp4xx_cf.h | 21 --------------------
 1 file changed, 21 deletions(-)
 delete mode 100644 include/linux/platform_data/pata_ixp4xx_cf.h

diff --git a/include/linux/platform_data/pata_ixp4xx_cf.h b/include/linux/platform_data/pata_ixp4xx_cf.h
deleted file mode 100644
index e60fa41da4a5..000000000000
--- a/include/linux/platform_data/pata_ixp4xx_cf.h
+++ /dev/null
@@ -1,21 +0,0 @@
-/* SPDX-License-Identifier: GPL-2.0 */
-#ifndef __PLATFORM_DATA_PATA_IXP4XX_H
-#define __PLATFORM_DATA_PATA_IXP4XX_H
-
-#include <linux/types.h>
-
-/*
- * This structure provide a means for the board setup code
- * to give information to th pata_ixp4xx driver. It is
- * passed as platform_data.
- */
-struct ixp4xx_pata_data {
-	volatile u32	*cs0_cfg;
-	volatile u32	*cs1_cfg;
-	unsigned long	cs0_bits;
-	unsigned long	cs1_bits;
-	void __iomem	*cmd;
-	void __iomem	*ctl;
-};
-
-#endif
-- 
2.31.1

