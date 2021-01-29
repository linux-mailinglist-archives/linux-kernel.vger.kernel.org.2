Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B81F7308D08
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Jan 2021 20:06:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232937AbhA2TFV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 29 Jan 2021 14:05:21 -0500
Received: from esa3.hgst.iphmx.com ([216.71.153.141]:50457 "EHLO
        esa3.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231195AbhA2TEF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 29 Jan 2021 14:04:05 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1611947045; x=1643483045;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=vZldTM6FtX8zAz/82bg/iHZZ5vBv6DuboGd6Gv8CJL8=;
  b=FsNTSsYYpNZKqP3xsWgFo7TTq3zZbmY5+Y7+AR0FL5av6MD2yNhQ2Vuo
   iNc8RIAujsSWoS7vE6AZbbd+kxohuj1N6jsab1St9Qm5CfsYIXhg8u//H
   Kj96zn5KPtDZyyDqNGaEfE3iXO1PbIe0x7ZiOa+4tCJSNDzkJoL3IWX0e
   GGOLfcGxN4v2cFXove6RrBOpZR4bK4j9iknyjIFDKsnGUfdeclUXrFzXI
   fDrkMyhig/18blYoqbZT88J9yMPyEIIXAOUgVxV86Ipr4B0L3tlbHQNi7
   C1hvecTKaU6RIy+NhmDQD1DftgERQEkpAszNrcZdyegyGKlagflT1NxXp
   A==;
IronPort-SDR: uPDJlnvMrAqSMvh83OK+BGNHVfCvo+JsEI/eYj5/2LyF1+UWFFxQKRvOQbI9wiH00wsC3mGSVq
 8QU636LkLd9zD7CsuHlrKxZe/ljLqAenxVRRdc+Psay60xiyxlQrSkCYnfWDjJARDR+GT3FzCs
 OYdCxULiMwWAkiZS5Mea4KePO+kkFetfpcPfWATzT7WyMLazOIiM7EiL459I0++fj2qDG/y49l
 1QHXIt2bSip/zWagVA4Q1fdZiSSZMYpBH1igsQXqqLDzSAuOS/T0kjGJr3io//RYQzkOayhkqm
 DFw=
X-IronPort-AV: E=Sophos;i="5.79,386,1602518400"; 
   d="scan'208";a="163107513"
Received: from uls-op-cesaip02.wdc.com (HELO uls-op-cesaep02.wdc.com) ([199.255.45.15])
  by ob1.hgst.iphmx.com with ESMTP; 30 Jan 2021 03:00:55 +0800
IronPort-SDR: 5BrTnTssXL0JttNxuRyEqCnCEIjr6bmqCDsXFSt5K4S36ULtjX50Yp10j6X7wvewbnVmYsGIoC
 435zuztxbkAcL3eUUs8iheDB72WRAUucWFAvRCm2bDRKaUisDey8SwLP4iOCzGWuCzWDibBRUC
 shTtmVdWylr+pjbmzdcSC/D3izs+ANmbaA2RikiOPA5IxAnaJ1DCY40c7ZOz550DZGTg374B2k
 xtzzsxa6B0MZiIGRB3isX6vrM49x5pGVzDuChtIXbMmKk+Qh9TgwjNFwkrfi+SEKHMRw/fHBaS
 z1DvraJTNLjl2Tk11+fBhqyQ
Received: from uls-op-cesaip01.wdc.com ([10.248.3.36])
  by uls-op-cesaep02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Jan 2021 10:43:08 -0800
IronPort-SDR: X7WyXnjKJibRyNc4+vNza209iP55cN/v9duebfXYs8amH7iT/Ra1DehB6uI469L8Xnmul0jaIB
 I+wmhNaWhnz5h/LyjxqsGCGlxlWZEIkF7cRbaVhVU0OVaDi+4vRdhlRSjj9mjO59I/mY6PjKhu
 MSsLivXPJVksfaL60cymcOULpjF0lTkstBfW8Witwm5LSPD8uhlWbmaujTFcwcHn7/Cj/vvW98
 3Q3580JqBdbloVRkLIYZ5kLXDeGtaDRbph9cjFokOhUu5ro691OSA22QYK82h2nBXSyZ+YZMKm
 j80=
WDCIronportException: Internal
Received: from usa003967.ad.shared (HELO jedi-01.hgst.com) ([10.86.63.124])
  by uls-op-cesaip01.wdc.com with ESMTP; 29 Jan 2021 11:00:55 -0800
From:   Atish Patra <atish.patra@wdc.com>
To:     linux-kernel@vger.kernel.org
Cc:     Sebastien Van Cauwenberghe <svancau@gmail.com>,
        Atish Patra <atish.patra@wdc.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Anup Patel <anup.patel@wdc.com>,
        Ard Biesheuvel <ardb@kernel.org>,
        "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
        linux-riscv@lists.infradead.org,
        Nick Desaulniers <ndesaulniers@gooogle.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Zong Li <zong.li@sifive.com>
Subject: [PATCH 2/3] riscv: Align on L1_CACHE_BYTES when STRICT_KERNEL_RWX
Date:   Fri, 29 Jan 2021 11:00:37 -0800
Message-Id: <20210129190038.1001626-2-atish.patra@wdc.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210129190038.1001626-1-atish.patra@wdc.com>
References: <20210129190038.1001626-1-atish.patra@wdc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Sebastien Van Cauwenberghe <svancau@gmail.com>

Allows the sections to be aligned on smaller boundaries and
therefore results in a smaller kernel image size.

Signed-off-by: Sebastien Van Cauwenberghe <svancau@gmail.com>
Reviewed-by: Atish Patra <atish.patra@wdc.com>
---
 arch/riscv/include/asm/set_memory.h | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/arch/riscv/include/asm/set_memory.h b/arch/riscv/include/asm/set_memory.h
index 211eb8244a45..8b80c80c7f1a 100644
--- a/arch/riscv/include/asm/set_memory.h
+++ b/arch/riscv/include/asm/set_memory.h
@@ -32,14 +32,14 @@ bool kernel_page_present(struct page *page);
 
 #endif /* __ASSEMBLY__ */
 
-#ifdef CONFIG_ARCH_HAS_STRICT_KERNEL_RWX
+#ifdef CONFIG_STRICT_KERNEL_RWX
 #ifdef CONFIG_64BIT
 #define SECTION_ALIGN (1 << 21)
 #else
 #define SECTION_ALIGN (1 << 22)
 #endif
-#else /* !CONFIG_ARCH_HAS_STRICT_KERNEL_RWX */
+#else /* !CONFIG_STRICT_KERNEL_RWX */
 #define SECTION_ALIGN L1_CACHE_BYTES
-#endif /* CONFIG_ARCH_HAS_STRICT_KERNEL_RWX */
+#endif /* CONFIG_STRICT_KERNEL_RWX */
 
 #endif /* _ASM_RISCV_SET_MEMORY_H */
-- 
2.25.1

