Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A2130356B9A
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Apr 2021 13:56:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244708AbhDGL5A (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 7 Apr 2021 07:57:00 -0400
Received: from esa3.hgst.iphmx.com ([216.71.153.141]:61766 "EHLO
        esa3.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235246AbhDGL45 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Apr 2021 07:56:57 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1617796608; x=1649332608;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=H5pI3ie5XSFSAQDc8gf+PA4Da275zUOynoSsfmXEaiQ=;
  b=Oqw5GNxU693Nu1y7iUGRJGpIX2r3FO7rfuruAPYyI+bzxVgHUxABYqPf
   q0i7jfaOjCYXKLOHC0k56bCxOytrlw3mo1bhi2hbWpnLKFwz2nYyzRvNl
   bvSsUTKbdbm3/Z1Svgi1ZYVu91OU2Ml1RoC2GEckZWKd0fNFfNvYVevOC
   UFtYiCXlRxb/9ddFLFhqYi1vsXm/kkA95WoyY1JuWffBwO7PHS1i+v2IA
   PxBI4nOOnZ40YIYgLFmeAz96zFFd3nEkjsPafLTvysELxDadRygrcynpR
   3hcwPHfoSUK3NM7DLzs2CX53D1ddO5XsdcWewVH24F6q9Q8eh8wvUCxpg
   Q==;
IronPort-SDR: ML4HQYeikW8IyapqoYEXE/isVonJhfSecWIj/suBbH4qvvF2clUkvp9zZbOwTm46uFLtfHitE9
 f+LE+HIFCZbFw0igUYNZtVvpxI9MUhCMMOhCfaZWQ1XlgAakPG8B7tOrODwJsFJ0Lky4PIygtG
 FA+ObMmGbA7UyjY37j+r7aO1d7OhN7flP0lc74HxhCfHRhMGMEnyhX7eZnv71Riq0/py9Uh6rV
 pMydg3wrAkU5VpIlH13u2nuBtC/zXNlfUI/CtxPlmjZ7ndfuGFwcmYbdmGTE2dYCoQOfilK6ut
 WXs=
X-IronPort-AV: E=Sophos;i="5.82,203,1613404800"; 
   d="scan'208";a="168551281"
Received: from h199-255-45-15.hgst.com (HELO uls-op-cesaep02.wdc.com) ([199.255.45.15])
  by ob1.hgst.iphmx.com with ESMTP; 07 Apr 2021 19:56:47 +0800
IronPort-SDR: 3M3L+t/bnSn0udrdCD23bEnInZLrRTR2P+wovQhuK7p/YVOaKMzwCOT3Ef5oJp3KpfUwYUzbZJ
 kz7ic3tSKFCMR59d1qK///thABhReTSmn4jZkXPzEZ/hwqQu9V0bBozTzZni7xae9dVT5rXgFd
 gpGYo4CgfyJ4bSENcbOJezEgb76XVnHvo8Agg1KA/o37I6tTFc0ZwQ2kLRYecBgXf913Xgizf6
 HBPvWlcypYaHoXJAKfk8EQAHuCFVlGus0AOQrVLwUcOOQeT9mbpDWHpxAUh4JYj/4EI1P6La51
 rxVSq6O8uc+85v5it4G2rzCs
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
  by uls-op-cesaep02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Apr 2021 04:36:32 -0700
IronPort-SDR: 9e2jbEm8D1doKxEIYX3CmwvGDbWmBBGVjWx1JrOmMxjBeG/PY90cnZBcFhnunFZpyiXM6MnEQz
 KqCqa9m0k7FMtMK1KvCw60ICbcn3VdT/i0zly4dDsaf9LzZCWS7VgBaxoPSs9prS+ids7c73dX
 plYX4luXIOMQ0GC/jOhv3hvfqIkcaRIB9cpSi+WRaQauTFlfPE6e2oIOUVY5PKdVLl32TpPoiu
 i7Sp+CSG4Vnrp6OfXPrF7DC2pVZ+McGLU6uEC1dWRoBdrp3mgKuwvWzFmiPh6fxV6L2ZaASefK
 s0Y=
WDCIronportException: Internal
Received: from unknown (HELO twashi.fujisawa.hgst.com) ([10.225.163.90])
  by uls-op-cesaip02.wdc.com with ESMTP; 07 Apr 2021 04:56:47 -0700
From:   Damien Le Moal <damien.lemoal@wdc.com>
To:     Palmer Dabbelt <palmer@dabbelt.com>,
        linux-riscv@lists.infradead.org,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        linux-kernel@vger.kernel.org
Cc:     Max Filippov <jcmvbkbc@gmail.com>,
        Greg Ungerer <gerg@linux-m68k.org>,
        Anup Patel <anup.patel@wdc.com>, Christoph Hellwig <hch@lst.de>
Subject: [PATCH 2/2] riscv: introduce asm/flat.h
Date:   Wed,  7 Apr 2021 20:56:38 +0900
Message-Id: <20210407115638.1055824-3-damien.lemoal@wdc.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20210407115638.1055824-1-damien.lemoal@wdc.com>
References: <20210407115638.1055824-1-damien.lemoal@wdc.com>
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
executable. Avoid this problem by introducing the file asm/flat.h
and defining the macro FLAT_TEXT_DATA_NO_GAP to indicate that the text
and data sections must be loaded at contiguous addresses.

Signed-off-by: Damien Le Moal <damien.lemoal@wdc.com>
---
 arch/riscv/include/asm/Kbuild |  1 -
 arch/riscv/include/asm/flat.h | 29 +++++++++++++++++++++++++++++
 2 files changed, 29 insertions(+), 1 deletion(-)
 create mode 100644 arch/riscv/include/asm/flat.h

diff --git a/arch/riscv/include/asm/Kbuild b/arch/riscv/include/asm/Kbuild
index 445ccc97305a..a8b54a3f4c2b 100644
--- a/arch/riscv/include/asm/Kbuild
+++ b/arch/riscv/include/asm/Kbuild
@@ -1,7 +1,6 @@
 # SPDX-License-Identifier: GPL-2.0
 generic-y += early_ioremap.h
 generic-y += extable.h
-generic-y += flat.h
 generic-y += kvm_para.h
 generic-y += user.h
 generic-y += vmlinux.lds.h
diff --git a/arch/riscv/include/asm/flat.h b/arch/riscv/include/asm/flat.h
new file mode 100644
index 000000000000..43bccf090fd1
--- /dev/null
+++ b/arch/riscv/include/asm/flat.h
@@ -0,0 +1,29 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+#ifndef _ASM_RISCV_FLAT_H
+#define _ASM_RISCV_FLAT_H
+
+#include <asm/unaligned.h>
+
+static inline int flat_get_addr_from_rp(u32 __user *rp, u32 relval, u32 flags,
+					u32 *addr)
+{
+	*addr = get_unaligned((__force u32 *)rp);
+	return 0;
+}
+
+static inline int flat_put_addr_at_rp(u32 __user *rp, u32 addr, u32 rel)
+{
+	put_unaligned(addr, (__force u32 *)rp);
+	return 0;
+}
+
+/*
+ * uclibc/gcc fully resolve the PC relative __global_pointer value
+ * at compile time and do not generate a relocation entry to set a
+ * runtime gp value. As a result, the flatbin loader must not introduce
+ * a gap between the text and data sections and keep them contiguous to
+ * avoid invalid address accesses.
+ */
+#define FLAT_TEXT_DATA_NO_GAP	(1)
+
+#endif /* _ASM_RISCV_FLAT_H */
-- 
2.30.2

