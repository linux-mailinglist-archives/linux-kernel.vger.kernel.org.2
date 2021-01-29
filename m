Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B01C3308D0B
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Jan 2021 20:06:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232924AbhA2TFq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 29 Jan 2021 14:05:46 -0500
Received: from esa3.hgst.iphmx.com ([216.71.153.141]:50666 "EHLO
        esa3.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232851AbhA2TEa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 29 Jan 2021 14:04:30 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1611947070; x=1643483070;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=mHKpdCHAaIc6wWDciCP+VXwGBcRZytaYsIXTPrszhlk=;
  b=lgOpaRI1VBnMEFZfqrgWgzv3ew+MKg6KmXkk4W3wNk42TZl9k4LqSM6R
   e3ntXoSOOm7JR7jFEPtIgfVlY27Y6Iq/EUHUCOklrcndtX0NyuyO8J5C1
   PNkaC3pBS3h1f/ta1rXcUy7SqnMoN5QUXYtIVv9kdGYmOc8PcnP9RNTwu
   dm3P9vvXcnN795eGFasGYkerlySebVJXgKJLBAMSLJBoNDUAFtyfaCGds
   0eQbCWvoY3W9CTfB+JSTm7OMrOrBJ70NvwIX4YRYNCjoeBBiMtXHoOxYJ
   oEq6HUQJUozfBnt/QMmMpmgjecQ+ShWUG8gFpGLaO/ODPKzrWyGZFdWpO
   Q==;
IronPort-SDR: bfsTrz+f7qPgP/VgCgGGO8ZQnXakVg6RO3K44JDrAGzwhsdwlKv8hS+6Hi1cSFRgp5X7LqycqS
 5z4IJExmgVQmrYJlkdymn1ZdNO6Pp2tEKFYoA8WCykwk92Y089/wEvGkp1QCqyyRJANyUxbIkp
 cJPvbw5U3bOq0OkRBTlzB/PucP+CoIDf7hSL4v1Jv0/r2D5KQbawiPCqvnH81epkjmwNw4EyII
 ejSdPJiMmYgQi+x1nxVZcfHZ15GKyw6c3MuCMu6jXa8Cg+UOLndzw+iT+w17nHsKBXCngQ7jX6
 9h0=
X-IronPort-AV: E=Sophos;i="5.79,386,1602518400"; 
   d="scan'208";a="163107515"
Received: from uls-op-cesaip02.wdc.com (HELO uls-op-cesaep02.wdc.com) ([199.255.45.15])
  by ob1.hgst.iphmx.com with ESMTP; 30 Jan 2021 03:00:55 +0800
IronPort-SDR: n9s6vAWqVZeiLvttQERdl9ftIj4HTadwOMgr0awJcOoa/mI382yt5GJQZnYzNiQGtNaevHcR+n
 2yExA9lBSfcXjoBbhXgLPzo4DL00bfp7cz9Fo8WjyB85O9ph8+aTgrFGl+loqp+ZTRHjuO4omS
 2Tg1B/LHX8p5W+A/t5XWu5Lbuof5kvO4S7wl4G/NQUkZUnTQ3D09/z5Eyhq9yYbg2e7jyrq2Nu
 ddd4gSVYdMlWwW6Twio2DwWRdUMTBLtRL7OVrCrlZArlEJ5o6PKB0wNW4lRvpqhe5zAI/lo5gc
 IGPTtv0s0H3dmA2BCSG0C9vn
Received: from uls-op-cesaip01.wdc.com ([10.248.3.36])
  by uls-op-cesaep02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Jan 2021 10:43:08 -0800
IronPort-SDR: qWiMg5teuON++9ffe8hyV4AViVWlg0EpHL3QmskW2g2LA8On0O7RC+XJFaR1v53Ntb/+cNVqHe
 tBA9ufRGq/9busQADKuFl4pdq7rvKyt7AQ7tPybQIZkkRhTBIiFROSk4J6eQQyL+k1nSPkwl2o
 8Uf+2KvEsbTOSntjA6I7ZhDDUy4QF7qtQO6f7bjm/A/d/HA/y+gULjZxkB/OoxzQd79rOj9QS8
 TOzGKqLNbNGbPhbnhw7IJOYv6dT6cupTygSUa6+cBf3/QpOTUWIdVdAV5UtQcHi+IIRf6RbvuV
 Qbk=
WDCIronportException: Internal
Received: from usa003967.ad.shared (HELO jedi-01.hgst.com) ([10.86.63.124])
  by uls-op-cesaip01.wdc.com with ESMTP; 29 Jan 2021 11:00:55 -0800
From:   Atish Patra <atish.patra@wdc.com>
To:     linux-kernel@vger.kernel.org
Cc:     Atish Patra <atish.patra@wdc.com>,
        Randy Dunlap <rdunlap@infradead.org>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Anup Patel <anup.patel@wdc.com>,
        Ard Biesheuvel <ardb@kernel.org>,
        "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
        linux-riscv@lists.infradead.org,
        Nick Desaulniers <ndesaulniers@gooogle.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Sebastien Van Cauwenberghe <svancau@gmail.com>,
        Zong Li <zong.li@sifive.com>
Subject: [PATCH 3/3] RISC-V: Define MAXPHYSMEM_1GB only for RV32
Date:   Fri, 29 Jan 2021 11:00:38 -0800
Message-Id: <20210129190038.1001626-3-atish.patra@wdc.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210129190038.1001626-1-atish.patra@wdc.com>
References: <20210129190038.1001626-1-atish.patra@wdc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

MAXPHYSMEM_1GB option was added for RV32 because RV32 only supports 1GB
of maximum physical memory. This lead to few compilation errors reported
by kernel test robot which created the following configuration combination
which are not useful but can be configured.

1. MAXPHYSMEM_1GB & RV64
2, MAXPHYSMEM_2GB & RV32

Fixes: e557793799c5 ("RISC-V: Fix maximum allowed phsyical memory for RV32")

Fix this by restricting MAXPHYSMEM_1GB for RV32 and MAXPHYSMEM_2GB only for
RV64.

Reported-by: Randy Dunlap <rdunlap@infradead.org>
Acked-by: Randy Dunlap <rdunlap@infradead.org>
Tested-by: Geert Uytterhoeven <geert@linux-m68k.org>
Signed-off-by: Atish Patra <atish.patra@wdc.com>
---
 arch/riscv/Kconfig | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/arch/riscv/Kconfig b/arch/riscv/Kconfig
index e9e2c1f0a690..e0a34eb5ed3b 100644
--- a/arch/riscv/Kconfig
+++ b/arch/riscv/Kconfig
@@ -252,8 +252,10 @@ choice
 	default MAXPHYSMEM_128GB if 64BIT && CMODEL_MEDANY
 
 	config MAXPHYSMEM_1GB
+		depends on 32BIT
 		bool "1GiB"
 	config MAXPHYSMEM_2GB
+		depends on 64BIT && CMODEL_MEDLOW
 		bool "2GiB"
 	config MAXPHYSMEM_128GB
 		depends on 64BIT && CMODEL_MEDANY
-- 
2.25.1

