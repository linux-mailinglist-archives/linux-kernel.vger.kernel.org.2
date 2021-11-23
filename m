Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 609674599E9
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Nov 2021 02:57:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232662AbhKWCAs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 22 Nov 2021 21:00:48 -0500
Received: from mail.kernel.org ([198.145.29.99]:59616 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232536AbhKWCAq (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 Nov 2021 21:00:46 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id 1CCBD6109E;
        Tue, 23 Nov 2021 01:57:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1637632659;
        bh=ZoaCHZIddZMnMBytdCkniWndd2x5DKoT53jTEzEace0=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=d2DWSzhFTZ/nRNq1/+ZNXmqr0Adm3HfxWsPsndo6EMq+kaS32yxy1SH/bIHVNy3fO
         aOdNG4Av9Z1hevUg5sx1zfWfSxYSQm0r+NPyL/jr7aadcoJ0DxeD++YhuwR7keegdf
         CE5BjmFz+i3q63wObnTfVSy1WqRH6ZfHxTq9HYRkw7sNFnY0QKPPw9cVKbSA/Odf9l
         O2F/dh2j6u2g1BHcwBajzqQ7cMpB4Qy3lSJ4+69EiY/qJ87skU8OUTHulVhP9ZxvhU
         d8PyoznPtKyMPTjU2gSbVTJgqUO2nq2jqRf64Vlb4kVkeMmkwIsLyYqoWtJLJF5BGs
         iYCAxkvNH0zoQ==
From:   guoren@kernel.org
To:     guoren@kernel.org, anup@brainfault.org, palmer@dabbelt.com,
        atishp@rivosinc.com
Cc:     linux-kernel@vger.kernel.org, linux-riscv@lists.infradead.org,
        linux-doc@vger.kernel.org, Guo Ren <guoren@linux.alibaba.com>,
        Anup Patel <anup.patel@wdc.com>
Subject: [RFC PATCH 2/3] riscv: Add early_param to decrease firmware region
Date:   Tue, 23 Nov 2021 09:57:16 +0800
Message-Id: <20211123015717.542631-3-guoren@kernel.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20211123015717.542631-1-guoren@kernel.org>
References: <20211123015717.542631-1-guoren@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Guo Ren <guoren@linux.alibaba.com>

Using riscv.fw_size in cmdline to tell the kernel what the
firmware (opensbi) size is. Then reserve the proper size of
firmware to save memory instead of the whole 2MB. It's helpful
to satisfy a small memory system (D1s/F133 from Allwinner).

Signed-off-by: Guo Ren <guoren@linux.alibaba.com>
Cc: Palmer Dabbelt <palmer@dabbelt.com>
Cc: Anup Patel <anup.patel@wdc.com>
Cc: Atish Patra <atishp@rivosinc.com>
---
 arch/riscv/mm/init.c | 14 +++++++++++++-
 1 file changed, 13 insertions(+), 1 deletion(-)

diff --git a/arch/riscv/mm/init.c b/arch/riscv/mm/init.c
index 920e78f8c3e4..f7db6d40213d 100644
--- a/arch/riscv/mm/init.c
+++ b/arch/riscv/mm/init.c
@@ -159,6 +159,15 @@ static int __init early_mem(char *p)
 }
 early_param("mem", early_mem);
 
+static phys_addr_t firmware_size __initdata;
+static int __init early_get_firmware_size(char *arg)
+{
+	firmware_size = memparse(arg, &arg);
+
+	return 0;
+}
+early_param("riscv.fwsz", early_get_firmware_size);
+
 static void __init setup_bootmem(void)
 {
 	phys_addr_t vmlinux_end = __pa_symbol(&_end);
@@ -224,7 +233,10 @@ static void __init setup_bootmem(void)
 	/*
 	 * Reserve OpenSBI region and depends on PMP to deny accesses.
 	 */
-	memblock_reserve(__pa(PAGE_OFFSET), LOAD_OFFSET);
+	if (firmware_size > PAGE_SIZE)
+		memblock_reserve(__pa(PAGE_OFFSET), firmware_size);
+	else
+		memblock_reserve(__pa(PAGE_OFFSET), LOAD_OFFSET);
 
 	early_init_fdt_scan_reserved_mem();
 	dma_contiguous_reserve(dma32_phys_limit);
-- 
2.25.1

