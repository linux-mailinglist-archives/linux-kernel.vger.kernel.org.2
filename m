Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E520D3F89F7
	for <lists+linux-kernel@lfdr.de>; Thu, 26 Aug 2021 16:17:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242878AbhHZOSH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 26 Aug 2021 10:18:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57500 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242870AbhHZOSG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 Aug 2021 10:18:06 -0400
Received: from ustc.edu.cn (email6.ustc.edu.cn [IPv6:2001:da8:d800::8])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id F1412C061757
        for <linux-kernel@vger.kernel.org>; Thu, 26 Aug 2021 07:17:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=mail.ustc.edu.cn; s=dkim; h=Received:Date:From:To:Cc:Subject:
        Message-ID:In-Reply-To:References:MIME-Version:Content-Type:
        Content-Transfer-Encoding; bh=8LeG+ayM3U5NRwK0VVcdLpHKizOeH76kOi
        ceUiVWas0=; b=HPVDEYvgzIeQaQBcLQe/qg9/rtz9zMAoAl7mr+2F72vkjHIoSe
        iQsGBdzrIRKCD7Su281jC1YWmH/lC+WM1EPvpP/xK19hZ/qucYtv6FcDUxE2bMe9
        vEwRaq5nCyzZ3pw4xrMqoNia9+6NMtGeJuh+pPKowLW0Mc5yC/G+RN0YE=
Received: from xhacker (unknown [101.86.20.15])
        by newmailweb.ustc.edu.cn (Coremail) with SMTP id LkAmygBH+PxMoidhNqTGAA--.59142S2;
        Thu, 26 Aug 2021 22:16:44 +0800 (CST)
Date:   Thu, 26 Aug 2021 22:10:29 +0800
From:   Jisheng Zhang <jszhang3@mail.ustc.edu.cn>
To:     Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>
Cc:     linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH v2 1/2] riscv: Enable BUILDTIME_TABLE_SORT
Message-ID: <20210826221029.39a77a02@xhacker>
In-Reply-To: <20210826220952.77a68a9e@xhacker>
References: <20210826220952.77a68a9e@xhacker>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-CM-TRANSID: LkAmygBH+PxMoidhNqTGAA--.59142S2
X-Coremail-Antispam: 1UD129KBjvdXoW7GFy3Cr1fJw1DKr1UGFWfKrg_yoWDtwc_K3
        s7K3s7XFy3X3WSva4xWrs5Zr1YkayvgFyfArWSvry2934Uu3yfJasxtF15Wr18Wa1DXr4x
        u392qr1DGr1xXjkaLaAFLSUrUUUUUb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
        9fnUUIcSsGvfJTRUUUbrxYjsxI4VW3JwAYFVCjjxCrM7AC8VAFwI0_Jr0_Gr1l1xkIjI8I
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
        cSsGvfC2KfnxnUUI43ZEXa7IU8mhF7UUUUU==
X-CM-SenderInfo: xmv2xttqjtqzxdloh3xvwfhvlgxou0/
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Jisheng Zhang <jszhang@kernel.org>

Enable BUILDTIME_TABLE_SORT to sort the exception table at build time
rather than during boot.

Signed-off-by: Jisheng Zhang <jszhang@kernel.org>
---
 arch/riscv/Kconfig  | 1 +
 scripts/sorttable.c | 1 +
 2 files changed, 2 insertions(+)

diff --git a/arch/riscv/Kconfig b/arch/riscv/Kconfig
index 80a7aa9f74de..570689d3889b 100644
--- a/arch/riscv/Kconfig
+++ b/arch/riscv/Kconfig
@@ -40,6 +40,7 @@ config RISCV
 	select ARCH_WANT_FRAME_POINTERS
 	select ARCH_WANT_HUGE_PMD_SHARE if 64BIT
 	select BINFMT_FLAT_NO_DATA_START_OFFSET if !MMU
+	select BUILDTIME_TABLE_SORT if MMU
 	select CLONE_BACKWARDS
 	select CLINT_TIMER if !MMU
 	select COMMON_CLK
diff --git a/scripts/sorttable.c b/scripts/sorttable.c
index 0ef3abfc4a51..f355869c65cd 100644
--- a/scripts/sorttable.c
+++ b/scripts/sorttable.c
@@ -349,6 +349,7 @@ static int do_file(char const *const fname, void *addr)
 	case EM_ARM:
 	case EM_MICROBLAZE:
 	case EM_MIPS:
+	case EM_RISCV:
 	case EM_XTENSA:
 		break;
 	default:
-- 
2.32.0


