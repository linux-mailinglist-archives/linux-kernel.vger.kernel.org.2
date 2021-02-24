Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 16173323814
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Feb 2021 08:50:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234387AbhBXHuA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 24 Feb 2021 02:50:00 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54274 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233340AbhBXHtH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Feb 2021 02:49:07 -0500
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4D5A8C06174A
        for <linux-kernel@vger.kernel.org>; Tue, 23 Feb 2021 23:48:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Type:MIME-Version:Message-ID:
        Subject:Cc:To:From:Date:Sender:Reply-To:Content-Transfer-Encoding:Content-ID:
        Content-Description:In-Reply-To:References;
        bh=vml+hkIwuOnmZog02I4fUIFk3ENnUomHJWuHDEIs+N8=; b=A8I3Z3HaOAG6Lae6lrwpudICvK
        B3Kn9NTFTuFDqbcdW4n5r0RijFjXTKcVk5E3iZAek+q3ib4YBiiNqRlF1IYxxnljfA3qW8Hy68gO9
        wg44Ve6EfK8tlzQrzYIZwixZ28VYuELzLE4AzDA9zO/cr/k+5pQTqm0evHRbhkb+IdEZvEhbxTfNz
        LHTrX/m8b22+var4MgDfdKKXCUahOw5TR++T/Gscgp1nrBWSqNqhb6szmMKL1lbmaCtikCpSc2uge
        009ykv6heSsDeoU3sUKLdFhkdUNejbYWgdTpxAPVYx0182+gPQvfpFvTzHJvxYsCBNT6n74InyYWT
        OHBebxvw==;
Received: from 213-225-9-156.nat.highway.a1.net ([213.225.9.156] helo=localhost)
        by casper.infradead.org with esmtpsa (Exim 4.94 #2 (Red Hat Linux))
        id 1lEou3-0097qn-I7; Wed, 24 Feb 2021 07:48:18 +0000
Date:   Wed, 24 Feb 2021 08:46:01 +0100
From:   Christoph Hellwig <hch@infradead.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     linux-kernel@vger.kernel.org, iommu@lists.linux-foundation.org
Subject: [GIT PULL] dma-mapping updates for 5.12
Message-ID: <YDYEOTIu02GKL8T2@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by casper.infradead.org. See http://www.infradead.org/rpr.html
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following changes since commit 9f5f8ec50165630cfc49897410b30997d4d677b5:

  dma-mapping: benchmark: use u8 for reserved field in uAPI structure (2021-02-05 12:48:46 +0100)

are available in the Git repository at:

  git://git.infradead.org/users/hch/dma-mapping.git tags/dma-mapping-5.12

for you to fetch changes up to 81d88ce55092edf1a1f928efb373f289c6b90efd:

  dma-mapping: remove the {alloc,free}_noncoherent methods (2021-02-09 18:01:38 +0100)

----------------------------------------------------------------
dma-mapping updates for 5.12:

 - add support to emulate processing delays in the DMA API benchmark
   selftest (Barry Song)
 - remove support for non-contiguous noncoherent allocations,
   which aren't used and will be replaced by a different API

----------------------------------------------------------------
Barry Song (1):
      dma-mapping: benchmark: pretend DMA is transmitting

Christoph Hellwig (1):
      dma-mapping: remove the {alloc,free}_noncoherent methods

 Documentation/core-api/dma-api.rst              | 64 +++++++++----------------
 drivers/iommu/dma-iommu.c                       | 30 ------------
 include/linux/dma-map-ops.h                     |  5 --
 include/linux/dma-mapping.h                     | 17 +++++--
 kernel/dma/map_benchmark.c                      | 12 ++++-
 kernel/dma/mapping.c                            | 40 ----------------
 tools/testing/selftests/dma/dma_map_benchmark.c | 21 ++++++--
 7 files changed, 64 insertions(+), 125 deletions(-)
