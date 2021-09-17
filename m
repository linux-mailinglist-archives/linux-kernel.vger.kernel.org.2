Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3DB7E40FE07
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Sep 2021 18:40:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237058AbhIQQlf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 17 Sep 2021 12:41:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39016 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236237AbhIQQle (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Sep 2021 12:41:34 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1370BC061574
        for <linux-kernel@vger.kernel.org>; Fri, 17 Sep 2021 09:40:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Type:MIME-Version:Message-ID:
        Subject:Cc:To:From:Date:Sender:Reply-To:Content-Transfer-Encoding:Content-ID:
        Content-Description:In-Reply-To:References;
        bh=mUkQRbyk6HgsN6EI+V8Ut5t9uOqEFk/bK805sRdA1qk=; b=MvLF58negozTqmwCoqkawYXf1S
        SLnnkfA1T544Wp5uh7pRxcHIR30qolf3LDrfUnIBmOtoVBJtqIqT8XH/ofyI99Zj09IWw2pv7wqep
        3ICz1YXBHpDfV/lQkIF5A+bZySDG8FWikyTUlQG+ocf6kZ1jvnIyDvzk/zvb/tOmXew+S47vBdBOf
        2CTUx/8R8tTJw+dOouquzMYaUIsPWm3yC1p4c7249vJvPJl6SYrfd+ZqHTBqWCBYMBDz5jUZxjT65
        CMaBDllvdjw2nxudUr20YIXuIDTKW4hYXM6xk/4+hfOqwRMHvuRdKe99Y37VdTcj1oezV27fbqN36
        ixsAjI1w==;
Received: from [2001:4bb8:184:72db:ef3e:3e1e:83c8:e434] (helo=localhost)
        by casper.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1mRGt3-000RfV-7s; Fri, 17 Sep 2021 16:39:16 +0000
Date:   Fri, 17 Sep 2021 18:38:52 +0200
From:   Christoph Hellwig <hch@infradead.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     iommu@lists.linux-foundation.org, linux-kernel@vger.kernel.org
Subject: [GIT PULL] dma-mapping fixes for Linux 5.15 (2nd attempt)
Message-ID: <YUTEnFAls4dyIyJ1@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by casper.infradead.org. See http://www.infradead.org/rpr.html
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following changes since commit c1dec343d7abdf8e71aab2a289ab45ce8b1afb7e:

  hexagon: use the generic global coherent pool (2021-08-19 09:02:40 +0200)

are available in the Git repository at:

  git://git.infradead.org/users/hch/dma-mapping.git tags/dma-mapping-5.15-1

for you to fetch changes up to 59583f747664046aaae5588d56d5954fab66cce8:

  sparc32: page align size in arch_dma_alloc (2021-09-14 14:35:17 +0200)

----------------------------------------------------------------
dma-mapping fixes for Linux 5.15

 - page align size in sparc32 arch_dma_alloc (Andreas Larsson)
 - tone down a new dma-debug message (Hamza Mahfooz)
 - fix the kerneldoc for dma_map_sg_attrs (me)

----------------------------------------------------------------
Andreas Larsson (1):
      sparc32: page align size in arch_dma_alloc

Christoph Hellwig (1):
      dma-mapping: fix the kerneldoc for dma_map_sg_attrs

Hamza Mahfooz (1):
      dma-debug: prevent an error message from causing runtime problems

 arch/sparc/kernel/ioport.c | 4 +++-
 kernel/dma/debug.c         | 3 ++-
 kernel/dma/mapping.c       | 3 ++-
 3 files changed, 7 insertions(+), 3 deletions(-)
