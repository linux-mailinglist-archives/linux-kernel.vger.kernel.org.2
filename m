Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E9E4F3E3BFD
	for <lists+linux-kernel@lfdr.de>; Sun,  8 Aug 2021 19:33:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232240AbhHHRdl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 8 Aug 2021 13:33:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47926 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230049AbhHHRdk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 8 Aug 2021 13:33:40 -0400
Received: from ustc.edu.cn (email6.ustc.edu.cn [IPv6:2001:da8:d800::8])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id BF096C061760
        for <linux-kernel@vger.kernel.org>; Sun,  8 Aug 2021 10:33:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=mail.ustc.edu.cn; s=dkim; h=Received:Date:From:To:Cc:Subject:
        Message-ID:In-Reply-To:References:MIME-Version:Content-Type:
        Content-Transfer-Encoding; bh=mEBPb7uJhspwGBVzHQeQ07LejInNjVQaJw
        9WxmbgQEs=; b=TPKkmskwOMPg67nmXGR1Vnz6baRH3PIwnNm23XA4ZJxi8mZj3u
        RhQtXazh2X+w/3v+Ctic81Z/YmiA8/BQa7i64hLAc6YSBfL1LpKF1c9phJVEmxR7
        iZ/0SyyWdzc7XGInAnpJ9DjjYvofbMG/l74DEOmPJK+ukrS6D499bjsO8=
Received: from xhacker (unknown [101.86.20.15])
        by newmailweb.ustc.edu.cn (Coremail) with SMTP id LkAmygBH+Pw+FRBhcvgMAA--.3365S2;
        Mon, 09 Aug 2021 01:32:46 +0800 (CST)
Date:   Mon, 9 Aug 2021 01:26:41 +0800
From:   Jisheng Zhang <jszhang3@mail.ustc.edu.cn>
To:     Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>
Cc:     linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH 2/2] riscv: Move EXCEPTION_TABLE to RO_DATA segment
Message-ID: <20210809012641.1b7916a9@xhacker>
In-Reply-To: <20210809012509.4983c1d6@xhacker>
References: <20210809012509.4983c1d6@xhacker>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-CM-TRANSID: LkAmygBH+Pw+FRBhcvgMAA--.3365S2
X-Coremail-Antispam: 1UD129KBjvdXoW7GFyxtrWfKw15Xr1kArWDurg_yoWkKFc_G3
        Z7Ww4fWryfCw4Sva4UGw4fWr90yayrKFyvvw1jvrWxWFy3Xrs0q3s5JF43Z3s8CryxCrs3
        AF12kr97Cr12qjkaLaAFLSUrUUUUUb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
        9fnUUIcSsGvfJTRUUUbFkYjsxI4VWDJwAYFVCjjxCrM7AC8VAFwI0_Jr0_Gr1l1xkIjI8I
        6I8E6xAIw20EY4v20xvaj40_Wr0E3s1l1IIY67AEw4v_Jr0_Jr4l8cAvFVAK0II2c7xJM2
        8CjxkF64kEwVA0rcxSw2x7M28EF7xvwVC0I7IYx2IY67AKxVW7JVWDJwA2z4x0Y4vE2Ix0
        cI8IcVCY1x0267AKxVWxJVW8Jr1l84ACjcxK6I8E87Iv67AKxVW8Jr0_Cr1UM28EF7xvwV
        C2z280aVCY1x0267AKxVW8Jr0_Cr1UM2AIxVAIcxkEcVAq07x20xvEncxIr21l5I8CrVAC
        Y4xI64kE6c02F40Ex7xfMcIj6xIIjxv20xvE14v26r1Y6r17McIj6I8E87Iv67AKxVWUJV
        W8JwAm72CE4IkC6x0Yz7v_Jr0_Gr1lF7xvr2IY64vIr41l42xK82IYc2Ij64vIr41l4I8I
        3I0E4IkC6x0Yz7v_Jr0_Gr1lx2IqxVAqx4xG67AKxVWUJVWUGwC20s026x8GjcxK67AKxV
        WUGVWUWwC2zVAF1VAY17CE14v26r126r1DMIIYrxkI7VAKI48JMIIF0xvE2Ix0cI8IcVAF
        wI0_Jr0_JF4lIxAIcVC0I7IYx2IY6xkF7I0E14v26r4j6F4UMIIF0xvE42xK8VAvwI8IcI
        k0rVW8JVW3JwCI42IY6I8E87Iv67AKxVWUJVW8JwCI42IY6I8E87Iv6xkF7I0E14v26r4j
        6r4UJbIYCTnIWIevJa73UjIFyTuYvjxUcj2MUUUUU
X-CM-SenderInfo: xmv2xttqjtqzxdloh3xvwfhvlgxou0/
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Jisheng Zhang <jszhang@kernel.org>

The _ex_table section is read-only, so move it to RO_DATA.

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


