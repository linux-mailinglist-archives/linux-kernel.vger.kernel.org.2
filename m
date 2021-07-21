Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E5A193D0A43
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Jul 2021 10:08:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235788AbhGUHZf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 21 Jul 2021 03:25:35 -0400
Received: from relay7-d.mail.gandi.net ([217.70.183.200]:42941 "EHLO
        relay7-d.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234378AbhGUHWY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Jul 2021 03:22:24 -0400
Received: (Authenticated sender: alex@ghiti.fr)
        by relay7-d.mail.gandi.net (Postfix) with ESMTPSA id 2B0532000D;
        Wed, 21 Jul 2021 08:02:51 +0000 (UTC)
From:   Alexandre Ghiti <alex@ghiti.fr>
To:     Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org
Cc:     Alexandre Ghiti <alex@ghiti.fr>
Subject: [PATCH -fixes 3/3] riscv: Optimize kernel virtual address conversion macro
Date:   Wed, 21 Jul 2021 09:59:37 +0200
Message-Id: <20210721075937.696811-4-alex@ghiti.fr>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20210721075937.696811-1-alex@ghiti.fr>
References: <20210721075937.696811-1-alex@ghiti.fr>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The current test in kernel_mapping_va_to_pa only applies when
CONFIG_XIP_KERNEL is set, so use IS_ENABLED to optimize this macro at
compile-time in standard kernels that do not require this test.

Signed-off-by: Alexandre Ghiti <alex@ghiti.fr>
---
 arch/riscv/include/asm/page.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/riscv/include/asm/page.h b/arch/riscv/include/asm/page.h
index b0ca5058e7ae..10dc063868f6 100644
--- a/arch/riscv/include/asm/page.h
+++ b/arch/riscv/include/asm/page.h
@@ -123,7 +123,7 @@ extern phys_addr_t phys_ram_base;
 #define linear_mapping_va_to_pa(x)	((unsigned long)(x) - kernel_map.va_pa_offset)
 #define kernel_mapping_va_to_pa(y) ({						\
 	unsigned long _y = y;							\
-	(_y < kernel_map.virt_addr + XIP_OFFSET) ?					\
+	(IS_ENABLED(CONFIG_XIP_KERNEL) && _y < kernel_map.virt_addr + XIP_OFFSET) ?	\
 		((unsigned long)(_y) - kernel_map.va_kernel_xip_pa_offset) :		\
 		((unsigned long)(_y) - kernel_map.va_kernel_pa_offset - XIP_OFFSET);	\
 	})
-- 
2.30.2

