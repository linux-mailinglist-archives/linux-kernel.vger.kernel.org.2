Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D48C0415B61
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Sep 2021 11:48:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240293AbhIWJuV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 23 Sep 2021 05:50:21 -0400
Received: from mailgate.ics.forth.gr ([139.91.1.2]:30141 "EHLO
        mailgate.ics.forth.gr" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240268AbhIWJuU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Sep 2021 05:50:20 -0400
Received: from av3.ics.forth.gr (av3in.ics.forth.gr [139.91.1.77])
        by mailgate.ics.forth.gr (8.15.2/ICS-FORTH/V10-1.8-GATE) with ESMTP id 18N9OK91037542
        for <linux-kernel@vger.kernel.org>; Thu, 23 Sep 2021 12:24:20 +0300 (EEST)
DKIM-Signature: v=1; a=rsa-sha256; d=ics.forth.gr; s=av; c=relaxed/simple;
        q=dns/txt; i=@ics.forth.gr; t=1632389055; x=1634981055;
        h=From:Sender:Reply-To:Subject:Date:Message-ID:To:Cc:MIME-Version:Content-Type:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:Resent-From:
        Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=KrneRFThc8H11gDbK0Ff3mrpfTanbaFNP85B4qwwTG8=;
        b=PMdP0E71zM1o3g53Ov9R7IOQiYamSUcee9x87eAYjLbItru3CPNSOm/eSBIFVMXu
        FBzOjpTS0mp+TdqL3vqL9+bRekk/tJbghP9w4aClgjbqNz//zOPo30ToxLunEPmf
        8QUa30V6dglUsIeNtiihoZ+5jusIjwvgERRfgMxrMHlHZBLdxHgwYrybeUrlWyR1
        mvRzW7dYYIs8YH0yCFrgKdWmM6ShoBJS6efIM+9+mvSoFlU33QmEdw1PehGGeJRT
        bPN6ceJDVZ9fdz05vlHRW1icw/95i9MusNizfQu7cO/aDGkicq9AqykVRZmgcoTM
        btHp2k9f9NAiItIr5aje3A==;
X-AuditID: 8b5b014d-ba8f670000005d46-a9-614c47bfd475
Received: from enigma.ics.forth.gr (enigma.ics.forth.gr [139.91.151.35])
        by av3.ics.forth.gr (Symantec Messaging Gateway) with SMTP id 66.DB.23878.FB74C416; Thu, 23 Sep 2021 12:24:15 +0300 (EEST)
X-ICS-AUTH-INFO: Authenticated user:  at ics.forth.gr
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8;
 format=flowed
Content-Transfer-Encoding: 8bit
Date:   Thu, 23 Sep 2021 12:24:13 +0300
From:   Nick Kossifidis <mick@ics.forth.gr>
To:     guoren@kernel.org
Cc:     anup.patel@wdc.com, atish.patra@wdc.com, palmerdabbelt@google.com,
        christoph.muellner@vrull.eu, philipp.tomsich@vrull.eu, hch@lst.de,
        liush@allwinnertech.com, wefu@redhat.com, lazyparser@gmail.com,
        drew@beagleboard.org, linux-riscv@lists.infradead.org,
        linux-kernel@vger.kernel.org, taiten.peng@canonical.com,
        aniket.ponkshe@canonical.com, heinrich.schuchardt@canonical.com,
        gordan.markus@canonical.com, Guo Ren <guoren@linux.alibaba.com>,
        Arnd Bergmann <arnd@arndb.de>, Chen-Yu Tsai <wens@csie.org>,
        Maxime Ripard <maxime@cerno.tech>,
        Daniel Lustig <dlustig@nvidia.com>,
        Greg Favor <gfavor@ventanamicro.com>,
        Andrea Mondelli <andrea.mondelli@huawei.com>,
        Jonathan Behrens <behrensj@mit.edu>,
        Xinhaoqu <xinhaoqu@huawei.com>,
        Bill Huffman <huffman@cadence.com>,
        Nick Kossifidis <mick@ics.forth.gr>,
        Allen Baum <allen.baum@esperantotech.com>,
        Josh Scheid <jscheid@ventanamicro.com>,
        Richard Trauben <rtrauben@gmail.com>
Subject: Re: [PATCH] riscv: Add RISC-V svpbmt extension
Organization: FORTH
In-Reply-To: <20210923072716.913826-1-guoren@kernel.org>
References: <20210923072716.913826-1-guoren@kernel.org>
Message-ID: <6d7b1668c1f562a5ef426bb2519f9784@mailhost.ics.forth.gr>
X-Sender: mick@mailhost.ics.forth.gr
User-Agent: Roundcube Webmail/1.3.16
X-Brightmail-Tracker: H4sIAAAAAAAAA02SfUwTZxzHfe6udwdZ41EkPmgmWZ2JwiwYXHxYSIe6ZU+mLjMhKmhkFzyB
        jCBrK27DjFbwpaARGhDtC4WJBKxBbQELSJCLoOiwDuaiwTpwjDFYGS/1jeIYLVnCf5/k+/vm
        +/njx5IyrWQFm5GlEVRZfKacDqaK9pavXt/+2XY+xvCaQUPiSRqduyUy6HhxK4WGJkpo9NbQ
        xaAfa19RqLp5Jbo5epNBD/NPA/SstoZBrWfNFLrhekWjkTYdhe48b6FQna2TQA91TxjUZ7MS
        6M97XTTq9f5Kob4WM42apgtoVFffRaLzr/8FKH/8AYMar9cDVFSXi7qv3QLoyqUygAraSyn0
        RnQRqGqsgkmIwKMnhgnsmzEAPO6rAfiKfozARu0ZGj994KLxtec2CZ4T6yjcbHQzuNJ+GBfc
        9kjwoL2XwPbLeho3D8ZhR3Uebn2ipb9cnhwcf0DIzMgRVNHKr4LTy152k9mudd92X/xdogXe
        iEIQxEJuI7w4rqMLQTAr4zoBfGNyShaCD6GpTQ/8LOVCYPeFIcrPJIdg2S/tYIEjYH6jifQz
        xa2BUxWtgS7NrYPW3o7A/TIuDF41WQMDJOdgofPEKcIfhHKboOeFlvHzUi4UTrl/DpSD5gcG
        7z4KDMjmb3wNBmZB4hPobnjKLMi9Dyd8A/PMsmHz7LDIi0GIcZGqcZGqcZFqJSAvA47PiVVk
        pKoVBw+pNOmKNJUdBJ4E7HCCfodHIQKCBSKALClfJp1+/Dkvkx7gv/teUB1KUR3OFNQiWMlS
        8uVSqaI4Rcal8Rrha0HIFlT/pwQbtEJL2MLjLFUJurzjMw09yT2bZ+LMu8wTOHQgZsxhKN/n
        LCz9eHKr5VSpbemwWCzaau8WdAzvcFfuyd7kSB7/AXalPHb23cj9w+3R9URVdSh3b9k5MFeU
        EF2d1LI28vZJNXE0O2mtk9zW33/UMvfTznLW4vsr97eeyY9KfNSx6P4jms2dTGxi7YZ3DjY1
        96XKP6W8G/ma02F208g06fpi367zyvT93szZqknnbHuFd6Qky5oYfv+fI/rZ3mqlJirVGh/i
        EF8YbFFa/XvKeHy1Xrv37/BGtjBk/+5nKSWjZXk58JtLOerI0rRHdFDMknebHNHbYZs5aSqP
        +2DVmti4xAyPnFKn8xsiSZWa/w8uNVDTkwMAAA==
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello Guo,

Στις 2021-09-23 10:27, guoren@kernel.org έγραψε:
diff --git a/Documentation/devicetree/bindings/riscv/cpus.yaml 
b/Documentation/devicetree/bindings/riscv/cpus.yaml
index e534f6a7cfa1..1825cd8db0de 100644
--- a/Documentation/devicetree/bindings/riscv/cpus.yaml
+++ b/Documentation/devicetree/bindings/riscv/cpus.yaml
@@ -56,7 +56,9 @@ properties:
      enum:
        - riscv,sv32
        - riscv,sv39
+      - riscv,sv39,svpbmt
        - riscv,sv48
+      - riscv,sv48,svpbmt
        - riscv,none

Isn't svpbmt orthogonal to the mmu type ? It's a functionality that can 
be present on either sv39/48/57 so why not have another "svpbmt" 
property directly on the cpu node ?

> + * rv64 PTE format:
> + * | 63 | 62 61 | 60 54 | 53  10 | 9             8 | 7 | 6 | 5 | 4 |
> 3 | 2 | 1 | 0
> + *   N      MT     RSV    PFN      reserved for SW   D   A   G   U
> X   W   R   V
> + * [62:61] Memory Type definitions:
> + *  00 - PMA    Normal Cacheable, No change to implied PMA memory type
> + *  01 - NC     Non-cacheable, idempotent, weakly-ordered Main Memory
> + *  10 - IO     Non-cacheable, non-idempotent, strongly-ordered I/O 
> memory
> + *  11 - Rsvd   Reserved for future standard use
> + */
> +#define _PAGE_MT_MASK		((u64)0x3 << 61)
> +#define _PAGE_MT_PMA		((u64)0x0 << 61)
> +#define _PAGE_MT_NC		((u64)0x1 << 61)
> +#define _PAGE_MT_IO		((u64)0x2 << 61)
> +

It'd be cleaner IMHO if you defined _PAGE_MT_MASK as (_PAGE_MT_PMA | 
_PAGE_MT_NC | _PAGE_MT_IO), like other masks are defined (e.g. 
_PAGE_CHG_MASK on the same file). I also suggest you use unsigned long 
instead of u64 for consistency.

> +enum {
> +	MT_PMA,
> +	MT_NC,
> +	MT_IO,
> +	MT_MAX
> +};
> +
> +extern struct __riscv_svpbmt_struct {
> +	unsigned long mask;
> +	unsigned long mt[MT_MAX];
> +} __riscv_svpbmt;
> +
> +#define _PAGE_DMA_MASK		__riscv_svpbmt.mask
> +#define _PAGE_DMA_PMA		__riscv_svpbmt.mt[MT_PMA]
> +#define _PAGE_DMA_NC		__riscv_svpbmt.mt[MT_NC]
> +#define _PAGE_DMA_IO		__riscv_svpbmt.mt[MT_IO]
> +#else
> +#define _PAGE_DMA_MASK		0
> +#define _PAGE_DMA_PMA		0
> +#define _PAGE_DMA_NC		0
> +#define _PAGE_DMA_IO		0
> +#endif /* CONFIG_64BIT */
> +#endif /* __ASSEMBLY__ */
> +
>  #define _PAGE_SPECIAL   _PAGE_SOFT
>  #define _PAGE_TABLE     _PAGE_PRESENT
> 

This struct is not useful as part of enabling the standard Svpbmt 
extension on Linux, we can set _PAGE_DMA_* macros directly on this patch 
and introduce the struct approach later on, when we also define 
alternative values for _PAGE_DMA_* flags. Also to someone reading the 
code the struct doesn't make sense without some documentation on why 
it's needed. Finally why the enum / array ? Why not just have different 
fields on the struct ?

> diff --git a/arch/riscv/include/asm/pgtable.h 
> b/arch/riscv/include/asm/pgtable.h
> index 39b550310ec6..d07ba586c866 100644
> --- a/arch/riscv/include/asm/pgtable.h
> +++ b/arch/riscv/include/asm/pgtable.h
> @@ -136,7 +136,8 @@
>  				| _PAGE_PRESENT \
>  				| _PAGE_ACCESSED \
>  				| _PAGE_DIRTY \
> -				| _PAGE_GLOBAL)
> +				| _PAGE_GLOBAL \
> +				| _PAGE_DMA_PMA)
> 

That's a bit misleading, it's like marking the kernel pages as DMAable.

-/*
- * The RISC-V ISA doesn't yet specify how to query or modify PMAs, so 
we can't
- * change the properties of memory regions.
- */
-#define _PAGE_IOREMAP _PAGE_KERNEL
+#define _PAGE_IOREMAP    ((_PAGE_KERNEL & ~_PAGE_DMA_MASK) | 
_PAGE_DMA_IO)
+
+#define PAGE_IOREMAP        __pgprot(_PAGE_IOREMAP)

This isn't used anywhere.

@@ -490,6 +489,28 @@ static inline int ptep_clear_flush_young(struct 
vm_area_struct *vma,
      return ptep_test_and_clear_young(vma, address, ptep);
  }

+#define pgprot_noncached pgprot_noncached
+static inline pgprot_t pgprot_noncached(pgprot_t _prot)
+{
+    unsigned long prot = pgprot_val(_prot);
+
+    prot &= ~_PAGE_DMA_MASK;
+    prot |= _PAGE_DMA_IO;
+
+    return __pgprot(prot);
+}
+
+#define pgprot_writecombine pgprot_writecombine
+static inline pgprot_t pgprot_writecombine(pgprot_t _prot)
+{
+    unsigned long prot = pgprot_val(_prot);
+
+    prot &= ~_PAGE_DMA_MASK;
+    prot |= _PAGE_DMA_NC;
+
+    return __pgprot(prot);
+}
+

We also have the IO type, we should also define pgprot_device to also 
ensure ordering, or else it'll fallback to pgprot_noncached, which in 
our case won't work well due to RVWMO:
https://elixir.bootlin.com/linux/latest/source/include/linux/pgtable.h#L930

+void __init riscv_svpbmt(void)
+{
+#ifdef CONFIG_64BIT
+    struct device_node *node;
+    const char *str;
+
+    for_each_of_cpu_node(node) {
+        if (of_property_read_string(node, "mmu-type", &str)) {
+            continue;
+        }
+
+        if (!strncmp(str + 11, "svpbmt", 6)) {
+            __riscv_svpbmt.mask      = _PAGE_MT_MASK;
+            __riscv_svpbmt.mt[MT_PMA] = _PAGE_MT_PMA;
+            __riscv_svpbmt.mt[MT_NC]  = _PAGE_MT_NC;
+            __riscv_svpbmt.mt[MT_IO]  = _PAGE_MT_IO;
+            break;
+        }
+    }
+#endif
+}

You break; here the first time you find a cpu node with svpbmt enabled, 
shouldn't we make sure that all used cpu nodes support svpbmt before 
using the extension ?

Regards,
Nick
