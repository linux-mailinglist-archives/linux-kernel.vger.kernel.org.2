Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 041B8460769
	for <lists+linux-kernel@lfdr.de>; Sun, 28 Nov 2021 17:17:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1358360AbhK1QU0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 28 Nov 2021 11:20:26 -0500
Received: from ams.source.kernel.org ([145.40.68.75]:35730 "EHLO
        ams.source.kernel.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233180AbhK1QST (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 28 Nov 2021 11:18:19 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id AAAA0B80D26
        for <linux-kernel@vger.kernel.org>; Sun, 28 Nov 2021 16:15:01 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BB508C004E1;
        Sun, 28 Nov 2021 16:14:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1638116100;
        bh=TkeGvT+T+N/UbFTgouihV6/Po7pgj+jD5L9aMgcATg0=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=iSR9fRcuC9YGICfR8TRlzvzfboaEGTVg8vMXWO8rBsG9zf5qf03Qw0gxl/9oAqDCJ
         pxC1OZCGmW7Mt69MxcTY+javIYrnP7uuKv5aTQYV0qD+0SNQLSyBUwHFo77zl5GRtC
         sBDyN2piMZsoo/QyARnRcIkC8Znu0aXi9hV8WjUcUAMaeTb2lwWlryjnXNEl/9GVKo
         yENOdwbsIlyWdYzBG+vPXPyXxoWqCK2Aufso2kWCgXP+jJAwxulwLpPBobDKqRyJmP
         VRl5gaBdAjGorQFV5A2AHgYBbTV58MQ4jONtNM7kauRfiveRb0FQ4ftuqwsQDkxATV
         /BzPDtPKHMw0w==
From:   Jisheng Zhang <jszhang@kernel.org>
To:     Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Anup Patel <anup.patel@wdc.com>,
        Atish Patra <atishp@atishpatra.org>
Cc:     linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org,
        kvm-riscv@lists.infradead.org
Subject: [PATCH 2/5] riscv: head: make secondary_start_common() static
Date:   Mon, 29 Nov 2021 00:07:38 +0800
Message-Id: <20211128160741.2122-3-jszhang@kernel.org>
X-Mailer: git-send-email 2.34.0
In-Reply-To: <20211128160741.2122-1-jszhang@kernel.org>
References: <20211128160741.2122-1-jszhang@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

There are no users outside head.S so make secondary_start_common()
static.

Signed-off-by: Jisheng Zhang <jszhang@kernel.org>
---
 arch/riscv/kernel/head.S | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/arch/riscv/kernel/head.S b/arch/riscv/kernel/head.S
index f52f01ecbeea..3ce95f8783bd 100644
--- a/arch/riscv/kernel/head.S
+++ b/arch/riscv/kernel/head.S
@@ -177,8 +177,7 @@ secondary_start_sbi:
 	REG_L sp, (a4)
 	REG_L tp, (a5)
 
-	.global secondary_start_common
-secondary_start_common:
+.Lsecondary_start_common:
 
 #ifdef CONFIG_MMU
 	/* Enable virtual memory and relocate to virtual address */
@@ -365,7 +364,7 @@ clear_bss_done:
 	beqz tp, .Lwait_for_cpu_up
 	fence
 
-	tail secondary_start_common
+	tail .Lsecondary_start_common
 #endif
 
 END(_start_kernel)
-- 
2.34.0

