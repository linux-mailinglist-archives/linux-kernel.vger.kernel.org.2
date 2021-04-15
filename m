Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A140A360234
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Apr 2021 08:15:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231159AbhDOGPm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 15 Apr 2021 02:15:42 -0400
Received: from esa5.hgst.iphmx.com ([216.71.153.144]:31338 "EHLO
        esa5.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230465AbhDOGPg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Apr 2021 02:15:36 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1618467314; x=1650003314;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=+vC1bp9TOZdk9mu2+skV17UchlT5/1kRNmCw0/3ydKo=;
  b=AKsVD/QgdKQeARUyRjRIilwDDnscdUVXD3UiqpAB6wTDUNtRPYkXlx6o
   qnInRy7+/2Kc7NqbpO5Ru7S9RiYAXHzctbbyFuKCZAwcBLU5SqELR9+C3
   b7eGdJ/JK6O2th7kSD3klURdPJ7+64aBw5GsNZUCrDNUJZcd7tfy7yN4k
   /Y2kwcUf6IwoEzfSIGH5/KWejlq2Ft0FOxjMSLsjszaH0lfP7VHO/uGcB
   IT96stkGfOQ/koBrr1FssL68Jk/Lo5zqOzprvPBXJXzJN7R5PUCJZcocJ
   slsFKGAtMGrweL2yrv7xZBX0A/UTudHEou7tE3siWg2qSq8l4E3ZF+I/6
   g==;
IronPort-SDR: K+qc2rlnLyB0WOvJcXRHCm3Z3UPUHVIBHvMRAjxJOHkCeIkrwpZCYCe+dkm+HzGDT4r4lvyM7w
 35BtivRlQt4WnDLa+ybWsmqhbMnYB2cRX5rq26Y6WrbzZT7G+DE77Wp7g6o+p08jnTYsOgdjCZ
 C90QpBReWBoXgfOB/OFKncUGZOXG9xmN5y6Ky9WpeE9dP2NO9LNHu5OlncS6sZgQpGeqsaexDw
 ftvQeIpr29DOWqSNIDESn4Z/ZnDgaz1Fm3+M1ldsY8s/W0T6dn0S0HbzPGAiXiaGCVM5TL+Klp
 HIQ=
X-IronPort-AV: E=Sophos;i="5.82,223,1613404800"; 
   d="scan'208";a="164846905"
Received: from h199-255-45-14.hgst.com (HELO uls-op-cesaep01.wdc.com) ([199.255.45.14])
  by ob1.hgst.iphmx.com with ESMTP; 15 Apr 2021 14:15:14 +0800
IronPort-SDR: PWiM6znyDc9JwBfPOQwEctofHyccovMpFa9Q63qoRsMhUJsYigTOTEEc6Z0+askezKs6Yn/ls1
 7N+DFpdnE4Cotev26DVt589erZTQNytN3hjRN7aDgeoKEz5gnt/dsmkDDGwaAJ9iCkE0vv/gxN
 arAR8U8pSr7/jIsfNzyWS6nkzqUlW04xD4mC+gtIFZTIRrjHXQUDbTyxzMtUh+fdxverwtHEdW
 giE5eB/4rEgIPrUjy+kWl1qVEkI1DEg9f7+LIxS3rB0v+s5Q+CCuQ55GbJNqdjC4X7F+EEG1Zd
 jT9beVKG25heSZnpPsrLxyQ5
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
  by uls-op-cesaep01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Apr 2021 22:56:11 -0700
IronPort-SDR: CORGKa2wMbDvLePNZsaaczVddMUkq4eTnPAarxeeOWCn9jhVx3X035/H6mVM8VRLZUUUSwjZ1z
 Y6np024svUqxcbyeXHOXsZlBrEQ6VmuLT9qP7b846qMDs2vXYPYGkcq1DrZSnoyTn9pXC4pyyu
 Ltc7ChaWYVrcL5U5n9d8jVlTH/BhdbXIrYeQ9Rhyx7EMA2WUHkhvSpPFh2GN6vsAdYFLN05OMa
 /usJ77OXNCf8umuZvXDJjgfE+W/Hn7loX9EXXSX5iwJ8KpGjPFZ/isGxELOMgrBEm86b9A8COE
 5pI=
WDCIronportException: Internal
Received: from unknown (HELO twashi.fujisawa.hgst.com) ([10.225.163.118])
  by uls-op-cesaip02.wdc.com with ESMTP; 14 Apr 2021 23:15:13 -0700
From:   Damien Le Moal <damien.lemoal@wdc.com>
To:     uclinux-dev@uclinux.org, ugerg@linux-m68k.org,
        Palmer Dabbelt <palmer@dabbelt.com>,
        linux-riscv@lists.infradead.org,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        linux-kernel@vger.kernel.org
Cc:     Max Filippov <jcmvbkbc@gmail.com>,
        Greg Ungerer <gerg@linux-m68k.org>,
        Anup Patel <anup.patel@wdc.com>, Christoph Hellwig <hch@lst.de>
Subject: [PATCH v3 2/2] riscv: Disable text-data gap in flat binaries
Date:   Thu, 15 Apr 2021 15:15:02 +0900
Message-Id: <20210415061502.7248-3-damien.lemoal@wdc.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20210415061502.7248-1-damien.lemoal@wdc.com>
References: <20210415061502.7248-1-damien.lemoal@wdc.com>
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
Acked-by: Palmer Dabbelt <palmerdabbelt@google.com>
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

