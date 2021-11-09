Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 579D844AF0B
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Nov 2021 14:53:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234582AbhKIN4I (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 9 Nov 2021 08:56:08 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48848 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231137AbhKIN4G (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 Nov 2021 08:56:06 -0500
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EA6DAC061764
        for <linux-kernel@vger.kernel.org>; Tue,  9 Nov 2021 05:53:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Type:MIME-Version:Message-ID:
        Subject:Cc:To:From:Date:Sender:Reply-To:Content-Transfer-Encoding:Content-ID:
        Content-Description:In-Reply-To:References;
        bh=oIgGMHpAi8JRcxWTzCOubpqVxrGPO33+sqQ/r9/ZSe8=; b=vCCTlysMrpqzREWqr9l/8iS5z0
        3kcyk2eEQu9gz/0H+hXP44mhE6q9fECwsTorbB7hVYEXzHjlSt0X4ApmSj4vGgNtbFcbg3RQgmVSc
        A00nChZp2FuqdN6raezzrT1fi2XYX64BPYZkgNL3BN2/BMNemdShGLZN1dCEwOG97dsY2lMABFHJx
        DnBeKBC0bCF51EP5FbmjHbFAeNbYJh3H8eDdQima6di6+jnoeLO6m1yxVifpqrU4Ww2UL2bcfVXlH
        Nn+gpBp0x0zWY6gOrdNelsuoELp61EHW8AQMP+LLEiGz4iwr9gU1AeJvWeX6X9j0XJqw0MV2zBGyp
        We9htWkw==;
Received: from [2001:4bb8:19a:7ee7:fb46:2fe1:8652:d9d4] (helo=localhost)
        by casper.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1mkRYr-0014Wx-0z; Tue, 09 Nov 2021 13:53:18 +0000
Date:   Tue, 9 Nov 2021 14:53:16 +0100
From:   Christoph Hellwig <hch@infradead.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     linux-kernel@vger.kernel.org, iommu@lists.linux-foundation.org
Subject: [GIT PULL] dma-mapping updates for Linux 5.16
Message-ID: <YYp9TAVLFsxqfVx7@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by casper.infradead.org. See http://www.infradead.org/rpr.html
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Just a small set of changes this time.  The request dma_direct_alloc
cleanups are still under review and haven't made the cut.

The following changes since commit 519d81956ee277b4419c723adfb154603c2565ba:

  Linux 5.15-rc6 (2021-10-17 20:00:13 -1000)

are available in the Git repository at:

  git://git.infradead.org/users/hch/dma-mapping.git tags/dma-mapping-5.16

for you to fetch changes up to 9fbd8dc19aa57ec8fe92606043199919527cd9be:

  dma-mapping: use 'bitmap_zalloc()' when applicable (2021-10-27 08:20:09 +0200)

----------------------------------------------------------------
dma-mapping updates for Linux 5.16

 - convert sparc32 to the generic dma-direct code
 - use bitmap_zalloc (Christophe JAILLET)

----------------------------------------------------------------
Christoph Hellwig (3):
      sparc32: remove the call to dma_make_coherent in arch_dma_free
      sparc32: remove dma_make_coherent
      sparc32: use DMA_DIRECT_REMAP

Christophe JAILLET (1):
      dma-mapping: use 'bitmap_zalloc()' when applicable

 arch/sparc/Kconfig         |  3 +-
 arch/sparc/kernel/ioport.c | 76 +++++-----------------------------------------
 kernel/dma/coherent.c      |  5 ++-
 3 files changed, 12 insertions(+), 72 deletions(-)
