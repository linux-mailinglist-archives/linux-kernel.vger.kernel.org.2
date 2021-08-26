Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9F05E3F89FB
	for <lists+linux-kernel@lfdr.de>; Thu, 26 Aug 2021 16:18:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242870AbhHZOS5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 26 Aug 2021 10:18:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57702 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229832AbhHZOS4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 Aug 2021 10:18:56 -0400
Received: from ustc.edu.cn (email6.ustc.edu.cn [IPv6:2001:da8:d800::8])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 7BC28C061757
        for <linux-kernel@vger.kernel.org>; Thu, 26 Aug 2021 07:18:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=mail.ustc.edu.cn; s=dkim; h=Received:Date:From:To:Cc:Subject:
        Message-ID:In-Reply-To:References:MIME-Version:Content-Type:
        Content-Transfer-Encoding; bh=dyqgEwHabF8Up4ihFeWT3SFMT5DdXXc05B
        iXW6J2O7A=; b=P3vzN6Vv5HSuDDDXOMb7zW50OP3Rw807Oi9NJoZv/dkbr2rFqM
        U9AlEUuqtclQd+8jPu/Z5eo5p0i9CbfHwlbD/1WIg4zSRbblCdvv7o2s+pqbxp9X
        GCKyoYF0tdM6MQvB/b7OiF3fZqHBchXvtqt9gnQSS4dUI1ZhL6j2GyQGw=
Received: from xhacker (unknown [101.86.20.15])
        by newmailweb.ustc.edu.cn (Coremail) with SMTP id LkAmygBnbw99oidhLaXGAA--.14379S2;
        Thu, 26 Aug 2021 22:17:33 +0800 (CST)
Date:   Thu, 26 Aug 2021 22:11:18 +0800
From:   Jisheng Zhang <jszhang3@mail.ustc.edu.cn>
To:     Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>
Cc:     linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH v2 2/2] riscv: Move EXCEPTION_TABLE to RO_DATA segment
Message-ID: <20210826221118.24be1142@xhacker>
In-Reply-To: <20210826220952.77a68a9e@xhacker>
References: <20210826220952.77a68a9e@xhacker>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-CM-TRANSID: LkAmygBnbw99oidhLaXGAA--.14379S2
X-Coremail-Antispam: 1UD129KBjvdXoW7GFyDAr4kJF15tr1xKFykKrg_yoWkKrg_G3
        Z7Ww43WryfCw4Sva4UGw4fWr90yayrKFykZw1jvrWxWFy3Xrs0q3s5JF43A3s8CryxCrs3
        AF12kr97Cr12qjkaLaAFLSUrUUUUUb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
        9fnUUIcSsGvfJTRUUUbrxYjsxI4VWDJwAYFVCjjxCrM7AC8VAFwI0_Jr0_Gr1l1xkIjI8I
        6I8E6xAIw20EY4v20xvaj40_Wr0E3s1l1IIY67AEw4v_Jr0_Jr4l8cAvFVAK0II2c7xJM2
        8CjxkF64kEwVA0rcxSw2x7M28EF7xvwVC0I7IYx2IY67AKxVW5JVW7JwA2z4x0Y4vE2Ix0
        cI8IcVCY1x0267AKxVW8JVWxJwA2z4x0Y4vEx4A2jsIE14v26rxl6s0DM28EF7xvwVC2z2
        80aVCY1x0267AKxVW0oVCq3wAS0I0E0xvYzxvE52x082IY62kv0487Mc02F40EFcxC0VAK
        zVAqx4xG6I80ewAv7VC0I7IYx2IY67AKxVWUXVWUAwAv7VC2z280aVAFwI0_Jr0_Gr1lOx
        8S6xCaFVCjc4AY6r1j6r4UM4x0Y48IcVAKI48JMxAIw28IcxkI7VAKI48JMxC20s026xCa
        FVCjc4AY6r1j6r4UMI8I3I0E5I8CrVAFwI0_Jr0_Jr4lx2IqxVCjr7xvwVAFwI0_JrI_Jr
        Wlx4CE17CEb7AF67AKxVWUAVWUtwCIc40Y0x0EwIxGrwCI42IY6xIIjxv20xvE14v26r1j
        6r1xMIIF0xvE2Ix0cI8IcVCY1x0267AKxVW8JVWxJwCI42IY6xAIw20EY4v20xvaj40_Gr
        0_Zr1lIxAIcVC2z280aVAFwI0_Jr0_Gr1lIxAIcVC2z280aVCY1x0267AKxVW8JVW8JrUv
        cSsGvfC2KfnxnUUI43ZEXa7IU8DxhJUUUUU==
X-CM-SenderInfo: xmv2xttqjtqzxdloh3xvwfhvlgxou0/
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Jisheng Zhang <jszhang@kernel.org>

_ex_table section is read-only, so move it to RO_DATA.

Signed-off-by: Jisheng Zhang <jszhang@kernel.org>
---
 arch/riscv/kernel/vmlinux-xip.lds.S | 1 -
 arch/riscv/kernel/vmlinux.lds.S     | 4 ++--
 2 files changed, 2 insertions(+), 3 deletions(-)

diff --git a/arch/riscv/kernel/vmlinux-xip.lds.S b/arch/riscv/kernel/vmlinux-xip.lds.S
index af776555ded9..9c9f35091ef0 100644
--- a/arch/riscv/kernel/vmlinux-xip.lds.S
+++ b/arch/riscv/kernel/vmlinux-xip.lds.S
@@ -121,7 +121,6 @@ SECTIONS
 	}
 
 	BSS_SECTION(PAGE_SIZE, PAGE_SIZE, 0)
-	EXCEPTION_TABLE(0x10)
 
 	.rel.dyn : AT(ADDR(.rel.dyn) - LOAD_OFFSET) {
 		*(.rel.dyn*)
diff --git a/arch/riscv/kernel/vmlinux.lds.S b/arch/riscv/kernel/vmlinux.lds.S
index 502d0826ecb1..5104f3a871e3 100644
--- a/arch/riscv/kernel/vmlinux.lds.S
+++ b/arch/riscv/kernel/vmlinux.lds.S
@@ -4,6 +4,8 @@
  * Copyright (C) 2017 SiFive
  */
 
+#define RO_EXCEPTION_TABLE_ALIGN	16
+
 #ifdef CONFIG_XIP_KERNEL
 #include "vmlinux-xip.lds.S"
 #else
@@ -112,8 +114,6 @@ SECTIONS
 		*(.srodata*)
 	}
 
-	EXCEPTION_TABLE(0x10)
-
 	. = ALIGN(SECTION_ALIGN);
 	_data = .;
 
-- 
2.32.0


