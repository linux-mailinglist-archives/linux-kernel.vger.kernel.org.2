Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 40BB94599EB
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Nov 2021 02:57:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232579AbhKWCAx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 22 Nov 2021 21:00:53 -0500
Received: from mail.kernel.org ([198.145.29.99]:59676 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232696AbhKWCAu (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 Nov 2021 21:00:50 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id 0034560F45;
        Tue, 23 Nov 2021 01:57:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1637632662;
        bh=BdXerXyBKn++TZTW4qxVgfzjOM5davINOBe2TBLOin0=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=fQYZWTvJk3uy/Za1q4jH5+qviOz8pTbZ9dps+9tOZZzxry2+uB0mCaYNr6R55+Mus
         pgMIMRGpXfQcM7IMnKQkXsOuWRkeuHLSGZ0U7mVZz8g9TFWX6f9WRF7e1FAkMumlDV
         BJTrQoORbLTsUwpdx/JF66nx8AHj2974HDUcZTfc/vBap6bjeY3Wa2OxDcNKuouv1S
         RIcCg9ZW+Yug/8jcFYyjx1vbpIcM32r4G8C+xl6Y/Vvi8SC3ivr/JqiUxaW+SgLJmi
         R2sARQP94ln1HNHEPqI76/8iJlYEYk9A6rDgycS0MLdQsu0Z0DMSOHnAtdtFciZv+U
         Dz3CHDy8KhImQ==
From:   guoren@kernel.org
To:     guoren@kernel.org, anup@brainfault.org, palmer@dabbelt.com,
        atishp@rivosinc.com
Cc:     linux-kernel@vger.kernel.org, linux-riscv@lists.infradead.org,
        linux-doc@vger.kernel.org, Guo Ren <guoren@linux.alibaba.com>,
        Anup Patel <anup.patel@wdc.com>
Subject: [RFC PATCH 3/3] riscv: Add riscv.fwsz kernel parameter
Date:   Tue, 23 Nov 2021 09:57:17 +0800
Message-Id: <20211123015717.542631-4-guoren@kernel.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20211123015717.542631-1-guoren@kernel.org>
References: <20211123015717.542631-1-guoren@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Guo Ren <guoren@linux.alibaba.com>

The firmware of riscv (such as opensbi) occupy 2MB(64bit) /
4MB(32bit) in Linux. It's very wasteful to small memory footprint
soc chip such as Allwinner D1s/F133. The kernel parameter gives a
chance to users to set the proper size of the firmware and get
more than 1.5MB of memory.

Signed-off-by: Guo Ren <guoren@linux.alibaba.com>
Cc: Palmer Dabbelt <palmer@dabbelt.com>
Cc: Anup Patel <anup.patel@wdc.com>
Cc: Atish Patra <atishp@rivosinc.com>
---
 Documentation/admin-guide/kernel-parameters.txt | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/Documentation/admin-guide/kernel-parameters.txt b/Documentation/admin-guide/kernel-parameters.txt
index 9725c546a0d4..ee505743c8f4 100644
--- a/Documentation/admin-guide/kernel-parameters.txt
+++ b/Documentation/admin-guide/kernel-parameters.txt
@@ -4964,6 +4964,9 @@
 			[KNL] Disable ring 3 MONITOR/MWAIT feature on supported
 			CPUs.
 
+	riscv.fwsz=nn[KMG]
+			[RISC-V] Determine firmware size to save memory
+
 	ro		[KNL] Mount root device read-only on boot
 
 	rodata=		[KNL]
-- 
2.25.1

