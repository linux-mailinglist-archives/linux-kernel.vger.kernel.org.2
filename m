Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id ABCAD308CFE
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Jan 2021 20:06:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232931AbhA2TDu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 29 Jan 2021 14:03:50 -0500
Received: from esa3.hgst.iphmx.com ([216.71.153.141]:50457 "EHLO
        esa3.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232898AbhA2TCh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 29 Jan 2021 14:02:37 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1611946956; x=1643482956;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=n54GfTxo7ki//EqLnS1Ir9viRWCH31o1XwXpCjE5Z+Q=;
  b=BayVPdeDfp9ktzOkTz52J8fInpz57DhKyKuAjvuNJatuNAzLhEnddMaX
   jmFnub05TSuO/mtndwgjawhsDPHyd3QOQrvvAOtYKBszmmG6TNxi2dkc6
   4hfWnLopB26/TXcZXJuehGGGenXXN7bwNTQeb9IcV84al7nnTHn6YX7au
   kwpsDlgdicYtoXYLHKu83uX8Xcwh13pj83Gq+s3Y9b7dvpzvJcgQv4S5/
   s3v8xzVs9NjxUMqFRF2qFWOJVKhXtpoSp15M9WfxQ3M0okwmGnduiTqIl
   xGtGiArlN0RlzfcjxcRx1cvpGW538KEoeI4j6adQyOjuK/wROwRCCxTiW
   Q==;
IronPort-SDR: ylgRtMM9OIRVLHw0E2aXt7R0UnbaG7T1h+VQgjuIqK+a+jzlOghnMIsTfmBCZyWVnpSw2Zx431
 sjiYcguCpOGg0yjFqoNCuQuCwhGGwuwJmYUP+ysvb0R32XjK1Uy1tDRJ/kWey815pLdKneWOGk
 MdD0cdH5V7PTZzqkoc720qxT3BLXrIGbYeRco8/DiMfkXdp0HNebYFxpx4dy7K67IbCGDREC3z
 GixhyadHlAP49eX9OgOluOIxCmVs6CfIVpKgy6F/E+BBxfvuG4GRISB9N67DYwq+ld1dWAHy51
 xKM=
X-IronPort-AV: E=Sophos;i="5.79,386,1602518400"; 
   d="scan'208";a="163107512"
Received: from uls-op-cesaip02.wdc.com (HELO uls-op-cesaep02.wdc.com) ([199.255.45.15])
  by ob1.hgst.iphmx.com with ESMTP; 30 Jan 2021 03:00:54 +0800
IronPort-SDR: QkLCcYHavA0LwZUkttebcXtgssNdaLemESRBNOgXKNGRMwy9bjWhOsxpcrsn8Qh/eEjwsqbXwO
 i8zdeCLKSlwwEFlkfKFtLxR41pKWuApe86w2mc5icu1NRaLuQY+hZtwp3aPaAaiOkKSdRg5jKr
 2ZW8mlY2UbOYpLO69TxjehNdv7EpaxuuUj12kwdgvm6MNfX+76K+e0Yt/8eWk3yaxWg6h6ou0B
 ja8NWygEQypJ4lIVZ3nAeB925Hjlsc9QXmwGSJy9gg9t0k+Fn+lZj+R8B60hSLNlL5McTZ8X+R
 nszhQFubbPBddpAD3GGwq+LE
Received: from uls-op-cesaip01.wdc.com ([10.248.3.36])
  by uls-op-cesaep02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Jan 2021 10:43:07 -0800
IronPort-SDR: ePbdRRjjbFrzTBLS92BttP6hleZsjSEvHAUUnd1DU6vHKn1v37kuOKJ3QNt37TuS960hslrCOi
 j/ihp4eNzLKnWfW5uRKyrfFXCDWzvMdPBCltWL8bQV58nwGBvogIaMXV8M9kNKAB5Dvgkm6Nj5
 WDqkjFFyfSVlCHH+DhY3TNpVHwleqAR2SkxKeivXQyyWEqVJ/sCtr0BjPbNTFBfn6+sxmUlHK8
 uBWjwmPmyGvbr/k1XYiDBNldK1Rlq9q+aYnHMe/ft0UW7QrJKaH72cfWUuBqoHxZ3YNWgl/Iaf
 plg=
WDCIronportException: Internal
Received: from usa003967.ad.shared (HELO jedi-01.hgst.com) ([10.86.63.124])
  by uls-op-cesaip01.wdc.com with ESMTP; 29 Jan 2021 11:00:54 -0800
From:   Atish Patra <atish.patra@wdc.com>
To:     linux-kernel@vger.kernel.org
Cc:     Atish Patra <atish.patra@wdc.com>,
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
Subject: [PATCH 1/3] RISC-V: Fix .init section permission update
Date:   Fri, 29 Jan 2021 11:00:36 -0800
Message-Id: <20210129190038.1001626-1-atish.patra@wdc.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

.init section permission should only updated to non-execute if
STRICT_KERNEL_RWX is enabled. Otherwise, this will lead to a kernel hang.

Fixes: 19a00869028f ("RISC-V: Protect all kernel sections including init early")

Suggested-by: Geert Uytterhoeven <geert@linux-m68k.org>
Reported-by: Geert Uytterhoeven <geert@linux-m68k.org>
Signed-off-by: Atish Patra <atish.patra@wdc.com>
---
 arch/riscv/kernel/setup.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/arch/riscv/kernel/setup.c b/arch/riscv/kernel/setup.c
index 3fa3f26dde85..c7c0655dd45b 100644
--- a/arch/riscv/kernel/setup.c
+++ b/arch/riscv/kernel/setup.c
@@ -293,6 +293,8 @@ void free_initmem(void)
 	unsigned long init_begin = (unsigned long)__init_begin;
 	unsigned long init_end = (unsigned long)__init_end;
 
-	set_memory_rw_nx(init_begin, (init_end - init_begin) >> PAGE_SHIFT);
+	if (IS_ENABLED(CONFIG_STRICT_KERNEL_RWX))
+		set_memory_rw_nx(init_begin, (init_end - init_begin) >> PAGE_SHIFT);
+
 	free_initmem_default(POISON_FREE_INITMEM);
 }
-- 
2.25.1

