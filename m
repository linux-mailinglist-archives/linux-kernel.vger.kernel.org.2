Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 43B1244382E
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Nov 2021 23:02:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231873AbhKBWFF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 2 Nov 2021 18:05:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33838 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231218AbhKBWEz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 Nov 2021 18:04:55 -0400
Received: from ms.lwn.net (ms.lwn.net [IPv6:2600:3c01:e000:3a1::42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6FCF1C061714
        for <linux-kernel@vger.kernel.org>; Tue,  2 Nov 2021 15:02:20 -0700 (PDT)
Received: from meer.lwn.net (unknown [IPv6:2601:281:8300:104d::5f6])
        by ms.lwn.net (Postfix) with ESMTPA id F043C5ECA;
        Tue,  2 Nov 2021 22:02:19 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 ms.lwn.net F043C5ECA
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=lwn.net; s=20201203;
        t=1635890540; bh=8pBr2TGHVgYTbZKGOPAv1jDSquEjlbn/oydrgdQgtK4=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=nr0bdIskuK2HW2Q8Cb+ryhQcfnecfgS2qIFFG8t0Lhb4/CSC/nJlM8fnEwozR90P2
         5nOaoPg9FVzojETa+vWez9nZbujYQxyPkAhzSFlvjuKcbKoPjiG8wzHU1EmCEc1Sfc
         9JczoYVn2KvbWysLKCLNBNxD91n4NoaLQKww/wYonip59A5O1GxKrPkfDXNK+QnXr4
         aKLnlu83RGYIJMsMt68uSr8uJPGnskpBfqA6i60F+hu/N5x8BSFRLrnoOwqU43ndNi
         zExnf+GC+77gu8NOVRM4x+uSr13jEwDyGYORVoURdtmZIQBWs5Pci8EtOX5o4C+4Gr
         uD7NThWjP8imQ==
From:   Jonathan Corbet <corbet@lwn.net>
To:     linux-kernel@vger.kernel.org
Cc:     Jonathan Corbet <corbet@lwn.net>,
        Boris Brezillon <bbrezillon@kernel.org>,
        Miquel Raynal <miquel.raynal@bootlin.com>,
        Richard Weinberger <richard@nod.at>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        linux-mtd@lists.infradead.org
Subject: [PATCH 6/9] mtd: remove unused header file <linux/mtd/latch-addr-flash.h>
Date:   Tue,  2 Nov 2021 16:02:00 -0600
Message-Id: <20211102220203.940290-7-corbet@lwn.net>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20211102220203.940290-1-corbet@lwn.net>
References: <20211102220203.940290-1-corbet@lwn.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Commit d24dbd7541ff ("mtd: maps: Get rid of the latch-addr-flash driver")
removed the last user of <linux/mtd/latch-addr-flash.h> but left the header
file behind.  Nothing uses this file, delete it now.

Cc: Boris Brezillon <bbrezillon@kernel.org>
Cc: Miquel Raynal <miquel.raynal@bootlin.com>
Cc: Richard Weinberger <richard@nod.at>
Cc: Vignesh Raghavendra <vigneshr@ti.com>
Cc: linux-mtd@lists.infradead.org
Signed-off-by: Jonathan Corbet <corbet@lwn.net>
---
 include/linux/mtd/latch-addr-flash.h | 29 ----------------------------
 1 file changed, 29 deletions(-)
 delete mode 100644 include/linux/mtd/latch-addr-flash.h

diff --git a/include/linux/mtd/latch-addr-flash.h b/include/linux/mtd/latch-addr-flash.h
deleted file mode 100644
index e94b8e128074..000000000000
--- a/include/linux/mtd/latch-addr-flash.h
+++ /dev/null
@@ -1,29 +0,0 @@
-/*
- * Interface for NOR flash driver whose high address lines are latched
- *
- * Copyright © 2008 MontaVista Software, Inc. <source@mvista.com>
- *
- * This file is licensed under the terms of the GNU General Public License
- * version 2. This program is licensed "as is" without any warranty of any
- * kind, whether express or implied.
- */
-#ifndef __LATCH_ADDR_FLASH__
-#define __LATCH_ADDR_FLASH__
-
-struct map_info;
-struct mtd_partition;
-
-struct latch_addr_flash_data {
-	unsigned int		width;
-	unsigned int		size;
-
-	int			(*init)(void *data, int cs);
-	void			(*done)(void *data);
-	void			(*set_window)(unsigned long offset, void *data);
-	void			*data;
-
-	unsigned int		nr_parts;
-	struct mtd_partition	*parts;
-};
-
-#endif
-- 
2.31.1

