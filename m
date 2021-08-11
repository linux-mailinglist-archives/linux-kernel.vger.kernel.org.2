Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 254113E8763
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Aug 2021 02:45:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236033AbhHKAoJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 10 Aug 2021 20:44:09 -0400
Received: from mail.kernel.org ([198.145.29.99]:39116 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S236063AbhHKAnp (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Aug 2021 20:43:45 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 3FF6260E97;
        Wed, 11 Aug 2021 00:43:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1628642602;
        bh=xDJ908ZzfO6+yH0suS+Wf2y1mcWCsd5q/TbB74bMqLk=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Dx/7wL9VqmoKx8zT58MEHcTkH3sRnAUzpeBYJPrDooFmOZWP2OEPHhDvVRq1SWBpn
         rI3jxw5FPKPfAnrRZqqV22NN4vrCt+0MgWAaAcv6iAmMfGOL5CcUf9ZZMWGZFRhFBC
         TrZM6Pf4/X6/FFbDo4TxsniUc0aO+lVH0C/Rsf4XoTQNd2ZiUOzLDYkEVuRC2Xf0eg
         t6jq2Trd3/FOcPVYECbXSpQcAFgGAuulYPKg7lyK3GA5xXZmxN8T91uBiKk+Ruhzfh
         cWneKU1nY8fqyoUdpdf5AW5KWz84GyO70HYRgl7oiNE0miDCnjFtg2lYuVFvIvyT7o
         mHiBMOwpkp2rA==
From:   Vineet Gupta <vgupta@kernel.org>
To:     linux-snps-arc@lists.infradead.org
Cc:     linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        Anshuman Khandual <anshuman.khandual@arm.com>,
        Mike Rapoport <rppt@kernel.org>,
        Vineet Gupta <vgupta@kernel.org>
Subject: [PATCH 14/18] ARC: mm: hack to allow 2 level build with 4 level code
Date:   Tue, 10 Aug 2021 17:42:54 -0700
Message-Id: <20210811004258.138075-15-vgupta@kernel.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210811004258.138075-1-vgupta@kernel.org>
References: <20210811004258.138075-1-vgupta@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

PMD_SHIFT is mapped to PUD_SHIFT or PGD_SHIFT by asm-generic/pgtable-*
but only for !__ASSEMBLY__

tlbex.S asm code has PTRS_PER_PTE which uses PMD_SHIFT hence barfs
for CONFIG_PGTABLE_LEVEL={2,3} and works for 4.

So add a workaround local to tlbex.S - the proper fix is to change
asm-generic/pgtable-* headers to expose the defines for __ASSEMBLY__ too

Signed-off-by: Vineet Gupta <vgupta@kernel.org>
---
 arch/arc/mm/tlbex.S | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/arch/arc/mm/tlbex.S b/arch/arc/mm/tlbex.S
index 6b5872197005..d08bd09a0afc 100644
--- a/arch/arc/mm/tlbex.S
+++ b/arch/arc/mm/tlbex.S
@@ -145,6 +145,14 @@ ex_saved_reg1:
 ;TLB Miss handling Code
 ;============================================================================
 
+#ifndef PMD_SHIFT
+#define PMD_SHIFT PUD_SHIFT
+#endif
+
+#ifndef PUD_SHIFT
+#define PUD_SHIFT PGDIR_SHIFT
+#endif
+
 ;-----------------------------------------------------------------------------
 ; This macro does the page-table lookup for the faulting address.
 ; OUT: r0 = PTE faulted on, r1 = ptr to PTE, r2 = Faulting V-address
-- 
2.25.1

