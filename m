Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5B104312602
	for <lists+linux-kernel@lfdr.de>; Sun,  7 Feb 2021 17:27:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229636AbhBGQ0y (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 7 Feb 2021 11:26:54 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42382 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229506AbhBGQ0w (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 7 Feb 2021 11:26:52 -0500
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5BAC2C06174A
        for <linux-kernel@vger.kernel.org>; Sun,  7 Feb 2021 08:26:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Type:MIME-Version:Message-ID:
        Subject:Cc:To:From:Date:Sender:Reply-To:Content-Transfer-Encoding:Content-ID:
        Content-Description:In-Reply-To:References;
        bh=oyOjEuJbaUrZDVi6UGKFq49upkI+s55d99FAd7+Mq7w=; b=qbvGukdAbhx4ukLix1XzXe3ubg
        VZs6q8VrGPboR1IsRvsJhE07wh0WeYDjgMv17EquwBMJp6IVN0FNUNB11NuEB4ls9mLcxu9eVAjnm
        Pw3W2PXghA3x1puBVaK0iLdR+8UFZ3RUev9OqWmi1TXkXhad9SiK3LVw4U5voPL1ez4hdYAN0GyV6
        JzvrsojyPybHB5ygNgFzez3pu0fadojegg6K/jzoHQSc38uOQpBCQAHJx5YuvwaGg/dzjWFDerHHu
        wblBBeZ/vE3IFq7S7ASLokdKRaBJfwGqaP8p6sMo/q3mAqaN+kB73qdXQ+FfX/OryvCcTg6BDvrqG
        ljrxeMdQ==;
Received: from [2001:4bb8:184:7d04:4590:5583:6cb7:77c7] (helo=localhost)
        by casper.infradead.org with esmtpsa (Exim 4.94 #2 (Red Hat Linux))
        id 1l8msw-004uha-Gz; Sun, 07 Feb 2021 16:26:08 +0000
Date:   Sun, 7 Feb 2021 17:26:05 +0100
From:   Christoph Hellwig <hch@infradead.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     linux-kernel@vger.kernel.org, iommu@lists.linux-foundation.org
Subject: [GIT PULL] dma-mapping fix for 5.11
Message-ID: <YCAUnVvH3rA24ZCa@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by casper.infradead.org. See http://www.infradead.org/rpr.html
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following changes since commit dd86e7fa07a3ec33c92c957ea7b642c4702516a0:

  Merge tag 'pci-v5.11-fixes-2' of git://git.kernel.org/pub/scm/linux/kernel/git/helgaas/pci (2021-02-04 16:05:40 -0800)

are available in the Git repository at:

  git://git.infradead.org/users/hch/dma-mapping.git tags/dma-mapping-5.11-2

for you to fetch changes up to 9f5f8ec50165630cfc49897410b30997d4d677b5:

  dma-mapping: benchmark: use u8 for reserved field in uAPI structure (2021-02-05 12:48:46 +0100)

----------------------------------------------------------------
dma-mapping fixes for 5.11:

 - fix a 32 vs 64-bit padding issue in the new benchmark code
   (Barry Song)

----------------------------------------------------------------
Barry Song (1):
      dma-mapping: benchmark: use u8 for reserved field in uAPI structure

 kernel/dma/map_benchmark.c                      | 2 +-
 tools/testing/selftests/dma/dma_map_benchmark.c | 4 +++-
 2 files changed, 4 insertions(+), 2 deletions(-)
