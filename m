Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 815243570F8
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Apr 2021 17:50:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1353900AbhDGPuq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 7 Apr 2021 11:50:46 -0400
Received: from esa1.hgst.iphmx.com ([68.232.141.245]:39414 "EHLO
        esa1.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1353955AbhDGPtn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Apr 2021 11:49:43 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1617810574; x=1649346574;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=91UF3XDHR+5BK9OsUH3n8K3X1hOKJSJ2ZUtlIirwwrM=;
  b=F2XnK/8q+SM+xmHGC5iOEfVFV1j1ARGrCqJQctdf3QlZ0Lo3p6Jdn3RE
   Q7yof4SbCPTio6ciAYw88Ifu/6k6HOdnsFg3stzIsqGnW5ntfEHg/Yrfs
   UA285lRS5iZL1qhRjvGf8ouubWl0lIAEbDyOUHpUKzG3vn0RiMieTR3tS
   zJgUZVRjIvJqdhqsGPcRUsHaBdqVNYeHq6U4uAKtYUgeKn1Z/FJmqS1mM
   o8M/39lXKpHp55KNJdny3peGan4hJaigraIvhoMvO4oacab9CQBzcJ7+S
   Q3Zz+i8MioHh5gxK9cMLGB2c+A2RfCnarW6zbUdKSIF9KkQsgb4YJZVyy
   Q==;
IronPort-SDR: RzVj9WcQIfE3WnXf37+13c3AJfDQLE31KKFLzwnwjOipQRFg/lYv+89HmyWrKCgSGa61+KPlya
 zJPAlByHQCkm7p/7JmjSL3SASZFYI9FsUqOcBPDb8trJ9JbmfTAYEGkrk1wZRJUNTz43jcrbUQ
 AZFMUCUl9LCk7asIPL/0zCNQ6nt/8x42Dwni3b6r8+2kDRKNzbJMBtl0sSek57ywzfO1Zcgh+v
 fNts2aPO2Vwrd1QNCqX5AtUep5QUdew/V6yrYdjmb1IHw3qHZaD8RXPePgJDn1g1JVpZ9SO0zC
 XQ4=
X-IronPort-AV: E=Sophos;i="5.82,203,1613404800"; 
   d="scan'208";a="274931697"
Received: from h199-255-45-14.hgst.com (HELO uls-op-cesaep01.wdc.com) ([199.255.45.14])
  by ob1.hgst.iphmx.com with ESMTP; 07 Apr 2021 23:49:33 +0800
IronPort-SDR: EbStP34IYgiCdPbgbgOcCyBBz7yhk/GPp8fOF6/wPH5ejRLLlB6XXN1FbNMDugqCnIKPRiNKkn
 RYqrRGcTIPHhL7x1bbfFD3vUSlqC/fPJQrpeNzZO+Url6vwM9OP8CBQ1pQCpLuEg9ZyHd+ioP0
 QMWA13u9L/trV9uM5Q0eeFrubDfgVh5aC2gYzZFhzgRsD6CmoGSKGzS5fOx3mNTE2dtKDRsBCn
 t3M+6UkM9ydK755Lnpzmb7M9HwZlXnGmsW/AESZfcUqWuttE9+4MZC1mfcrwkk+dcdh3zs1FRA
 kR2Mkr4doTSDu+uLV7r0Ou9V
Received: from uls-op-cesaip01.wdc.com ([10.248.3.36])
  by uls-op-cesaep01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Apr 2021 08:30:53 -0700
IronPort-SDR: S/zRMmFYPV/GfPI1LS+wpGzLIjw7o2v/mGiuL8CAguAfgkFeylt/UnGYKywFpaTukM6ayibUy8
 U8s6c8bznjYQF/fFN25skPrIhbKmj2+f4YegA1lx8mRySeparspDzx4toCMPUWOEK4phZjpe8T
 1T6E8/kKepyQacW34LF5dGeONW75ZVW80qbMzgxKyO+I3QnqEukPhCkDP2SZMlhn+WTyYTra/j
 7mUbbYKqIMyhmpoftI+CByFNFaxFhOB56JO2jdoGin5eh4rAnp+vCFkZ/ZOsFVxFOzfCpnh4fZ
 P3I=
WDCIronportException: Internal
Received: from unknown (HELO twashi.fujisawa.hgst.com) ([10.225.163.90])
  by uls-op-cesaip01.wdc.com with ESMTP; 07 Apr 2021 08:49:33 -0700
From:   Damien Le Moal <damien.lemoal@wdc.com>
To:     Palmer Dabbelt <palmer@dabbelt.com>,
        linux-riscv@lists.infradead.org,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        linux-kernel@vger.kernel.org
Cc:     Max Filippov <jcmvbkbc@gmail.com>,
        Greg Ungerer <gerg@linux-m68k.org>,
        Anup Patel <anup.patel@wdc.com>, Christoph Hellwig <hch@lst.de>
Subject: [PATCH v2 2/2] riscv: Disable text-data gap in flat binaries
Date:   Thu,  8 Apr 2021 00:49:24 +0900
Message-Id: <20210407154924.1557489-3-damien.lemoal@wdc.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20210407154924.1557489-1-damien.lemoal@wdc.com>
References: <20210407154924.1557489-1-damien.lemoal@wdc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

uclibc/gcc combined with elf2flt riscv linker file fully resolve the
PC relative __global_pointer$ value at compile time and do not generate
a relocation entry to set a runtime gp value. As a result, if the
flatbin loader introduces a gap between the text and data sections, the
gp value becomes incorrect and prevent correct execution of a flatbin
executable.

Avoid this problem by enabling CONFIG_BINFMT_FLAT_NO_TEXT_DATA_GAP
automatically when CONFIG_RISCV is enabled and CONFIG_MMU disabled.

Signed-off-by: Damien Le Moal <damien.lemoal@wdc.com>
---
 arch/riscv/Kconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/riscv/Kconfig b/arch/riscv/Kconfig
index 0d0cf67359cb..6a85fbbd056e 100644
--- a/arch/riscv/Kconfig
+++ b/arch/riscv/Kconfig
@@ -33,6 +33,7 @@ config RISCV
 	select ARCH_WANT_DEFAULT_TOPDOWN_MMAP_LAYOUT if MMU
 	select ARCH_WANT_FRAME_POINTERS
 	select ARCH_WANT_HUGE_PMD_SHARE if 64BIT
+	select BINFMT_FLAT_NO_TEXT_DATA_GAP if !MMU
 	select CLONE_BACKWARDS
 	select CLINT_TIMER if !MMU
 	select COMMON_CLK
-- 
2.30.2

