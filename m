Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 55C7E3D4C42
	for <lists+linux-kernel@lfdr.de>; Sun, 25 Jul 2021 08:04:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230127AbhGYFXK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 25 Jul 2021 01:23:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50008 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229460AbhGYFXE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 25 Jul 2021 01:23:04 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 17AB5C061757
        for <linux-kernel@vger.kernel.org>; Sat, 24 Jul 2021 23:03:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Type:MIME-Version:Message-ID:
        Subject:Cc:To:From:Date:Sender:Reply-To:Content-Transfer-Encoding:Content-ID:
        Content-Description:In-Reply-To:References;
        bh=u8Y6L+Rco34iM+E3rhGHsG8KSlyhUxu63ehVuhEIgzQ=; b=ThGLr0xDamavUqwJ6uf55u8NYC
        O2khtWaERytaQu3aLCF0t1DtrEZymrZlybqfocct8yMV4uT4pcpUv7DlwJxTR5AfiKZA0axrkUSWe
        LKwXIxdKkeEvh2wG6sWW4/Utwic9DhFwKwMKgi/RFJ0u6oGodCDQzJ2J7BBi2EulTjPVsKwCMwrno
        7N9CdpVcZfd+V9Htq+jG1RbpXz7smdhcduHe9MPJhEk6MPeYh6WYw8iYxD13t5ztN+Idgw/rzOffj
        A2YnlZZm0YAJKiNCPYgGO7CD+rM1lvtSS1hey5Fe+q9gPlGzsJaxaYYYmdi4dcpXxtiTJnBZAJ99P
        QUTTw4ug==;
Received: from [2001:4bb8:184:87c5:a8b3:bdfd:fc9b:6250] (helo=localhost)
        by casper.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1m7XEQ-00Cq3Y-KS; Sun, 25 Jul 2021 06:03:26 +0000
Date:   Sun, 25 Jul 2021 08:03:21 +0200
From:   Christoph Hellwig <hch@infradead.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     linux-kernel@vger.kernel.org, iommu@lists.linux-foundation.org
Subject: [GIT PULL] dma-mapping fix for Linux 5.14
Message-ID: <YPz+qQ6dbZVDbMwu@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by casper.infradead.org. See http://www.infradead.org/rpr.html
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following changes since commit d936eb23874433caa3e3d841cfa16f5434b85dcf:

  Revert "Makefile: Enable -Wimplicit-fallthrough for Clang" (2021-07-15 18:05:31 -0700)

are available in the Git repository at:

  git://git.infradead.org/users/hch/dma-mapping.git tags/dma-mapping-5.14-1

for you to fetch changes up to 40ac971eab89330d6153e7721e88acd2d98833f9:

  dma-mapping: handle vmalloc addresses in dma_common_{mmap,get_sgtable} (2021-07-16 11:30:26 +0200)

----------------------------------------------------------------
dma-mapping fix for Lonux 5.14

  - handle vmalloc addresses in dma_common_{mmap,get_sgtable}
    (Roman Skakun)

----------------------------------------------------------------
Roman Skakun (1):
      dma-mapping: handle vmalloc addresses in dma_common_{mmap,get_sgtable}

 kernel/dma/ops_helpers.c | 12 ++++++++++--
 1 file changed, 10 insertions(+), 2 deletions(-)
