Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 07D683EADB8
	for <lists+linux-kernel@lfdr.de>; Fri, 13 Aug 2021 01:40:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238639AbhHLXjJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 12 Aug 2021 19:39:09 -0400
Received: from mail.kernel.org ([198.145.29.99]:48968 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S238475AbhHLXia (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Aug 2021 19:38:30 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 00929610FF;
        Thu, 12 Aug 2021 23:38:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1628811484;
        bh=OznPj0H31NuyGJ0zu5NrPr8zmibKxgGabmxj0tfu3OI=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=qSLCgRfDUgYypTq6vAUv99MIOcg2OnKf0tnDXJqcySf3ubU/7uoPK7McrjorJIkxX
         VfcDxT+ITm2tR4CPvh0KFoYz7ntI9yAluS95kThBPQzj4peUcTgFXvXnixaRcjf4oz
         mvs8MWR0B4l9tfx3cNDVtWbyU9kofkJhuFdo243+DMU9Jh8DGEgSEz+EkTdio3gE+g
         J/H9DmrTQ4RbJIOPOW9rTn8IDNhacihpSUGjLyQzwhEITlQo9bQeNjdriIb90bWMvn
         ETyBJ0iKYzooOHqC2RVmF1lRDL8zf7EGYlVavXPmsVbI08yOdOsazanNOQZVC2nb8z
         xgdu49URX80Dg==
From:   Vineet Gupta <vgupta@kernel.org>
To:     linux-snps-arc@lists.infradead.org
Cc:     linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        Anshuman Khandual <anshuman.khandual@arm.com>,
        Mike Rapoport <rppt@kernel.org>,
        Vineet Gupta <vgupta@kernel.org>
Subject: [PATCH v2 15/19] ARC: mm: hack to allow 2 level build with 4 level code
Date:   Thu, 12 Aug 2021 16:37:49 -0700
Message-Id: <20210812233753.104217-16-vgupta@kernel.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210812233753.104217-1-vgupta@kernel.org>
References: <20210812233753.104217-1-vgupta@kernel.org>
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
index 0b4bb62fa0ab..c4a5f16444ce 100644
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

