Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 11E613DB7F4
	for <lists+linux-kernel@lfdr.de>; Fri, 30 Jul 2021 13:42:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238630AbhG3Lmn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 30 Jul 2021 07:42:43 -0400
Received: from mail.kernel.org ([198.145.29.99]:40378 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S238605AbhG3Lmm (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 30 Jul 2021 07:42:42 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id DA0B56103B;
        Fri, 30 Jul 2021 11:42:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1627645357;
        bh=nRa9TJJxTAW4vDwwhA6VyorL4FVC9dzFn9iKflCLVG4=;
        h=From:To:Cc:Subject:Date:From;
        b=AX4PmDXFu2OLhlDawWaxLNHParYoTGmSJs27Idg5FL5pTfeInPD7rwiKgXxtrPeI+
         YnwXvpvboeOTSnmX/9f+mJ3pK9gkCHjGs1oOX1FEqc/IlpAEENMFlPxjozGkEsqeRe
         +SJcWyl4yBDUBIX9BWRzNcVNNGHxZAwrWROd3Slwwzk9h7ai3tQmQ+Rw3tJslJOoEA
         JDxgIz+qYcifZf5UFEZ2HUVKcEEErOFWHEP3BSmqPcUWWS0MWvPMPstHVDuFBYfJrV
         n3N3cwwEGzSKSNAO4b1VbXellnqtPpwftg22Q3+Z80kzZ2DcYa8RZJu3CXAzO/vKm4
         W5of3aDkiQuZQ==
From:   Will Deacon <will@kernel.org>
To:     linux-kernel@vger.kernel.org
Cc:     iommu@lists.linux-foundation.org, linuxppc-dev@lists.ozlabs.org,
        Will Deacon <will@kernel.org>,
        Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>,
        Claire Chang <tientzu@chromium.org>,
        Christoph Hellwig <hch@lst.de>,
        Robin Murphy <robin.murphy@arm.com>,
        Nicholas Piggin <npiggin@gmail.com>,
        Sachin Sant <sachinp@linux.vnet.ibm.com>,
        Nathan Chancellor <nathan@kernel.org>
Subject: [PATCH] powerpc/svm: Don't issue ultracalls if !mem_encrypt_active()
Date:   Fri, 30 Jul 2021 12:42:31 +0100
Message-Id: <20210730114231.23445-1-will@kernel.org>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Commit ad6c00283163 ("swiotlb: Free tbl memory in swiotlb_exit()")
introduced a set_memory_encrypted() call to swiotlb_exit() so that the
buffer pages are returned to an encrypted state prior to being freed.

Sachin reports that this leads to the following crash on a Power server:

[    0.010799] software IO TLB: tearing down default memory pool
[    0.010805] ------------[ cut here ]------------
[    0.010808] kernel BUG at arch/powerpc/kernel/interrupt.c:98!

Nick spotted that this is because set_memory_encrypted() is issuing an
ultracall which doesn't exist for the processor, and should therefore
be gated by mem_encrypt_active() to mirror the x86 implementation.

Cc: Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>
Cc: Claire Chang <tientzu@chromium.org>
Cc: Christoph Hellwig <hch@lst.de>
Cc: Robin Murphy <robin.murphy@arm.com>
Fixes: ad6c00283163 ("swiotlb: Free tbl memory in swiotlb_exit()")
Suggested-by: Nicholas Piggin <npiggin@gmail.com>
Reported-by: Sachin Sant <sachinp@linux.vnet.ibm.com>
Tested-by: Sachin Sant <sachinp@linux.vnet.ibm.com>
Tested-by: Nathan Chancellor <nathan@kernel.org>
Link: https://lore.kernel.org/r/1905CD70-7656-42AE-99E2-A31FC3812EAC@linux.vnet.ibm.com/
Signed-off-by: Will Deacon <will@kernel.org>
---
 arch/powerpc/platforms/pseries/svm.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/arch/powerpc/platforms/pseries/svm.c b/arch/powerpc/platforms/pseries/svm.c
index 1d829e257996..87f001b4c4e4 100644
--- a/arch/powerpc/platforms/pseries/svm.c
+++ b/arch/powerpc/platforms/pseries/svm.c
@@ -63,6 +63,9 @@ void __init svm_swiotlb_init(void)
 
 int set_memory_encrypted(unsigned long addr, int numpages)
 {
+	if (!mem_encrypt_active())
+		return 0;
+
 	if (!PAGE_ALIGNED(addr))
 		return -EINVAL;
 
@@ -73,6 +76,9 @@ int set_memory_encrypted(unsigned long addr, int numpages)
 
 int set_memory_decrypted(unsigned long addr, int numpages)
 {
+	if (!mem_encrypt_active())
+		return 0;
+
 	if (!PAGE_ALIGNED(addr))
 		return -EINVAL;
 
-- 
2.32.0.554.ge1b32706d8-goog

