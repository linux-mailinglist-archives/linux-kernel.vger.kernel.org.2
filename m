Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0971B3E8760
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Aug 2021 02:45:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236231AbhHKAoC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 10 Aug 2021 20:44:02 -0400
Received: from mail.kernel.org ([198.145.29.99]:38936 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S235830AbhHKAnn (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Aug 2021 20:43:43 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id E229B60EDF;
        Wed, 11 Aug 2021 00:43:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1628642601;
        bh=rQG6R4IYtK009L51KoLDJPAjJafHG5PoJg6sbJHan6E=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=DJg+8ueSH0w/uLEJilaVjKfT7/1op5f9m25OKoODB2hgOotmDiKaiWNsqlSSJFjWa
         I184RC/qwaFr3Qxsf9BJ26Wjz+PnlteUyda2kOpu1K6VbC/nasY6d5hW8DYjn/WWDL
         hDzArlo4G20vmIyrDFCP94XrRzXCnTmzUfnY9X2IYALSRgT66zRyKRXAJliAEtpt6E
         Y8r94qPZjjfFn2porTkDsupsx0dUBiMIqZzn6ww0B0d1Sv1nWhSn7L5BYLwxWXm3kq
         L2IG9lDzZVjkulLxDzXvYk2Tx4sRr1sIbfds+xs2KQPooGRGNYWAXU42SlIi64Pbf5
         N7KCYFHYLALnA==
From:   Vineet Gupta <vgupta@kernel.org>
To:     linux-snps-arc@lists.infradead.org
Cc:     linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        Anshuman Khandual <anshuman.khandual@arm.com>,
        Mike Rapoport <rppt@kernel.org>,
        Vineet Gupta <vgupta@kernel.org>
Subject: [PATCH 11/18] ARC: mm: move MMU specific bits out of entry code
Date:   Tue, 10 Aug 2021 17:42:51 -0700
Message-Id: <20210811004258.138075-12-vgupta@kernel.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210811004258.138075-1-vgupta@kernel.org>
References: <20210811004258.138075-1-vgupta@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Signed-off-by: Vineet Gupta <vgupta@kernel.org>
---
 arch/arc/kernel/entry.S | 6 ------
 arch/arc/mm/tlb.c       | 3 +++
 2 files changed, 3 insertions(+), 6 deletions(-)

diff --git a/arch/arc/kernel/entry.S b/arch/arc/kernel/entry.S
index 2cb8dfe866b6..684efd094520 100644
--- a/arch/arc/kernel/entry.S
+++ b/arch/arc/kernel/entry.S
@@ -101,12 +101,6 @@ ENTRY(EV_MachineCheck)
 	lr  r0, [efa]
 	mov r1, sp
 
-	; hardware auto-disables MMU, re-enable it to allow kernel vaddr
-	; access for say stack unwinding of modules for crash dumps
-	lr	r3, [ARC_REG_PID]
-	or	r3, r3, MMU_ENABLE
-	sr	r3, [ARC_REG_PID]
-
 	lsr  	r3, r2, 8
 	bmsk 	r3, r3, 7
 	brne    r3, ECR_C_MCHK_DUP_TLB, 1f
diff --git a/arch/arc/mm/tlb.c b/arch/arc/mm/tlb.c
index b68d5798327b..34f16e0b41e6 100644
--- a/arch/arc/mm/tlb.c
+++ b/arch/arc/mm/tlb.c
@@ -813,5 +813,8 @@ void do_tlb_overlap_fault(unsigned long cause, unsigned long address,
 		}
 	}
 
+	/* Re-enable MMU as hardware may have auto-disabled it upon exception */
+	write_aux_reg(ARC_REG_PID, read_aux_reg(ARC_REG_PID) | MMU_ENABLE);
+
 	local_irq_restore(flags);
 }
-- 
2.25.1

