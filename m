Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 046253B2EC2
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Jun 2021 14:17:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231397AbhFXMT6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 24 Jun 2021 08:19:58 -0400
Received: from relay12.mail.gandi.net ([217.70.178.232]:33775 "EHLO
        relay12.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229448AbhFXMT6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Jun 2021 08:19:58 -0400
Received: (Authenticated sender: alex@ghiti.fr)
        by relay12.mail.gandi.net (Postfix) with ESMTPSA id 4CBBB200005;
        Thu, 24 Jun 2021 12:17:36 +0000 (UTC)
From:   Alexandre Ghiti <alex@ghiti.fr>
To:     Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Jisheng Zhang <jszhang@kernel.org>,
        linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org
Cc:     Alexandre Ghiti <alex@ghiti.fr>
Subject: [PATCH -fixes] riscv: Fix PTDUMP output now BPF region moved back to module region
Date:   Thu, 24 Jun 2021 14:17:21 +0200
Message-Id: <20210624121721.2828421-1-alex@ghiti.fr>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

BPF region was moved back to the region below the kernel at the end of the
module region in commit 3a02764c372c ("riscv: Ensure BPF_JIT_REGION_START
aligned with PMD size"), so reflect this change in kernel page table
output.

Signed-off-by: Alexandre Ghiti <alex@ghiti.fr>
---
 arch/riscv/mm/ptdump.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/riscv/mm/ptdump.c b/arch/riscv/mm/ptdump.c
index 0536ac84b730..22d6555d89dc 100644
--- a/arch/riscv/mm/ptdump.c
+++ b/arch/riscv/mm/ptdump.c
@@ -98,8 +98,8 @@ static struct addr_marker address_markers[] = {
 	{0, "vmalloc() end"},
 	{0, "Linear mapping"},
 #ifdef CONFIG_64BIT
-	{0, "Modules mapping"},
-	{0, "Kernel mapping (kernel, BPF)"},
+	{0, "Modules/BPF mapping"},
+	{0, "Kernel mapping"},
 #endif
 	{-1, NULL},
 };
-- 
2.30.2

