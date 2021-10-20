Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 384F143510F
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Oct 2021 19:14:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230369AbhJTRRL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 20 Oct 2021 13:17:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33736 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230049AbhJTRRK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Oct 2021 13:17:10 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:e::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E315FC06161C
        for <linux-kernel@vger.kernel.org>; Wed, 20 Oct 2021 10:14:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Content-Type:MIME-Version:Message-ID:
        Subject:Cc:To:From:Date:Sender:Reply-To:Content-Transfer-Encoding:Content-ID:
        Content-Description:In-Reply-To:References;
        bh=dlA2zg6fiC2H+IJzS881hgO1rZ9WRlHQjA0SQx8l/68=; b=n7cUPV57gIINXpdjNb7An9Eso+
        SdAG4G8HgYNzVQhGwaQDR8g3FFNs1y9VYZv6t1zrrmi7dC/pVtETiabJJmbNod4l5KOUuHCgXncaa
        Qn37iQxzKV8KdgXhlNQH8xDaXirhN5rXxZR+1mVQjot6e6LwFCUdsXqXMyvSPHWr70R356rzig1S1
        eQX12I+TEbLbPQfR/vF4hTxscTosIocHd6HLpXykRl2jNQdumGAmllZzYIigyqvAqf9eXfXuyU72F
        HmFwFU/uG2Br1meu2TRpXRIe2N1FSWT0O/i9ul3eekOt+LqLIjDPzGpgPkcYjIDQnUenZu+/GWPw/
        haKXc7+Q==;
Received: from [2001:4bb8:180:8777:a130:d02a:a9b5:7d80] (helo=localhost)
        by bombadil.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1mdFB0-005IqL-6f; Wed, 20 Oct 2021 17:14:54 +0000
Date:   Wed, 20 Oct 2021 19:14:51 +0200
From:   Christoph Hellwig <hch@infradead.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     iommu@lists.linux-foundation.org, linux-kernel@vger.kernel.org
Subject: [GIT PULL] dma-mapping fixes for Linux 5.15
Message-ID: <YXBOiy+yS4pwwHeQ@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following changes since commit 59583f747664046aaae5588d56d5954fab66cce8:

  sparc32: page align size in arch_dma_alloc (2021-09-14 14:35:17 +0200)

are available in the Git repository at:

  git://git.infradead.org/users/hch/dma-mapping.git tags/dma-mapping-5.15-2

for you to fetch changes up to c2bbf9d1e9ac7d4fdd503b190bc1ba8a6302bc49:

  dma-debug: teach add_dma_entry() about DMA_ATTR_SKIP_CPU_SYNC (2021-10-18 12:46:45 +0200)

----------------------------------------------------------------
dma-mapping fixes for Linux 5.15

 - fix more dma-debug fallout (Gerald Schaefer, Hamza Mahfooz)
 - fix a kerneldoc warning (Logan Gunthorpe)

----------------------------------------------------------------
Gerald Schaefer (1):
      dma-debug: fix sg checks in debug_dma_map_sg()

Hamza Mahfooz (1):
      dma-debug: teach add_dma_entry() about DMA_ATTR_SKIP_CPU_SYNC

Logan Gunthorpe (1):
      dma-mapping: fix the kerneldoc for dma_map_sgtable()

 kernel/dma/debug.c   | 36 ++++++++++++++++++++----------------
 kernel/dma/debug.h   | 24 ++++++++++++++++--------
 kernel/dma/mapping.c | 24 ++++++++++++------------
 3 files changed, 48 insertions(+), 36 deletions(-)
