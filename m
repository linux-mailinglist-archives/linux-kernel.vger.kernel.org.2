Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 93EA13BA30C
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Jul 2021 18:06:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229807AbhGBQJK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 2 Jul 2021 12:09:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35114 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229455AbhGBQJJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Jul 2021 12:09:09 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6661DC061762
        for <linux-kernel@vger.kernel.org>; Fri,  2 Jul 2021 09:06:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Type:MIME-Version:Message-ID:
        Subject:Cc:To:From:Date:Sender:Reply-To:Content-Transfer-Encoding:Content-ID:
        Content-Description:In-Reply-To:References;
        bh=iC1QZXy9Cno3bICQJjkmHqM8p3uVRAtns8+PaSPO5+8=; b=wQz/0NOVk+4ejBAefuHHoMDhFo
        Cju+ikF+UTkF83UxB0g7Q0yOycGv8B/02IsEly3HlBSQRqmwzD1N1LNICcl7V6HSTi7X3zWSSfCg/
        66uWKjK3z4dBoWmtSvymJUuNvgYApDm7j5QNULwKpEhVmWVUovceE+puYsr9msn66TRZkrCdRdBBS
        h2Gq/uwWaajij7DgJpxJz9TO4If1LTwbpH20J79WuAzrPMoPnDXmekyXq7eAghJSjy6PZAGs864qO
        0pintKwMm7sUJJpN/jnRowqmyIi6sJ8G/R/QidmFEq9WENDD17Mm1Y9m0uIoRBziafiFrGsQ1fRu3
        rp+Pa9+g==;
Received: from [2001:4bb8:180:285:6928:4a94:34bd:6961] (helo=localhost)
        by casper.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1lzLgJ-007qUJ-3Q; Fri, 02 Jul 2021 16:06:24 +0000
Date:   Fri, 2 Jul 2021 18:06:17 +0200
From:   Christoph Hellwig <hch@infradead.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     linux-kernel@vger.kernel.org, iommu@lists.linux-foundation.org
Subject: [GIT PULL] dma-mapping updates for Linux 5.14
Message-ID: <YN85ebItWEBp98jL@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by casper.infradead.org. See http://www.infradead.org/rpr.html
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following changes since commit a7f3d3d3600c8ed119eb0d2483de0062ce2e3707:

  dma-mapping: add unlikely hint to error path in dma_mapping_error (2021-04-02 16:41:08 +0200)

are available in the Git repository at:

  git://git.infradead.org/users/hch/dma-mapping.git tags/dma-mapping-5.14

for you to fetch changes up to 2b4bbc6231d789f58676d2ccc42177df163e1c4a:

  dma-debug: report -EEXIST errors in add_dma_entry (2021-06-22 08:15:47 +0200)

----------------------------------------------------------------
dma-mapping updates for Linux 5.14

 - a trivivial whitespace fix (Zhen Lei)
 - report -EEXIST errors in add_dma_entry (Hamza Mahfooz)

----------------------------------------------------------------
Hamza Mahfooz (1):
      dma-debug: report -EEXIST errors in add_dma_entry

Zhen Lei (1):
      dma-mapping: remove a trailing space

 kernel/dma/coherent.c | 2 +-
 kernel/dma/debug.c    | 6 ++----
 2 files changed, 3 insertions(+), 5 deletions(-)
