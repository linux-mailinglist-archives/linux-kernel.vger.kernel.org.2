Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CCED23CD4C7
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Jul 2021 14:32:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236826AbhGSLvM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 19 Jul 2021 07:51:12 -0400
Received: from mail.kernel.org ([198.145.29.99]:59978 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231290AbhGSLvG (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Jul 2021 07:51:06 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 6CEBE6113E;
        Mon, 19 Jul 2021 12:31:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1626697906;
        bh=fheK/HYwVWc3ZOM2xABTkv7fnCAc75GRLPfud8UIPVQ=;
        h=From:To:Cc:Subject:Date:From;
        b=o5PHI94XBhXiBZwXAEpM5tiBAZxG0yn/0lyJ+lHBaOrGQMzFVaWYfMsv8a0MCeX5K
         TJC+mgoilx+nJIag8FKZ/jHflf0pf4jwyBUEvFzSOOaxdclleY5E5Pts40JZ1wUPtC
         SVEXWDE7N03DMIPHkPf6pk6k1cw/Xt099Iyq5YQMXStCQyYHK35GxiCWso3HVRsFfi
         usVXi51WmNGr+We1pmezkF3EUOV9zDrvmbSv4n0JRsqvRtTmCNKH+H3CLAfspb/3+M
         VhxQCLjb5Jqvi6AdzeGLKKLVct+483CuPq40Vi5qHOwURX2wvV96YmcXLysKVzBHTz
         yAVXrfiyJwtBg==
From:   Will Deacon <will@kernel.org>
To:     iommu@lists.linux-foundation.org
Cc:     linux-kernel@vger.kernel.org, Will Deacon <will@kernel.org>,
        Guenter Roeck <linux@roeck-us.net>,
        Claire Chang <tientzu@chromium.org>,
        Christoph Hellwig <hch@lst.de>,
        Robin Murphy <robin.murphy@arm.com>,
        Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>,
        Nathan Chancellor <nathan@kernel.org>
Subject: [PATCH 0/5] Fix restricted DMA vs swiotlb_exit()
Date:   Mon, 19 Jul 2021 13:30:49 +0100
Message-Id: <20210719123054.6844-1-will@kernel.org>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi all,

This series fixes the issues which have been reported against the
Restricted DMA series in -next:

  * Fix the build for Sparc as reported by Guenter [1].

  * Rework the lifetime of 'io_tlb_default_mem' so that devices
    can retain valid references to it even after swiotlb_exit(). This,
    in turn, fixes the x86/AMD IOMMU regressions reported by Nathan [2].

I also then added a diagnostic to swiotlb_exit(), as suggested by Konrad
[3] and the final patch frees the underlying buffer memory during the
tear down, but I must confess that I don't know why this wasn't being
done already.

A massive thank you to Nathan for helping to debug this and also for
testing these patches to confirm that they address the issue on his
machine.

Patches are based against swiotlb devel/for-linus-5.15.

Cheers,

Will

[1] https://lore.kernel.org/r/20210702030807.GA2685166@roeck-us.net
[2] https://lore.kernel.org/r/YNvMDFWKXSm4LRfZ@Ryzen-9-3900X.localdomain
[3] https://lore.kernel.org/r/YORsr0h7u5l9DZwh@char.us.oracle.com

Cc: Guenter Roeck <linux@roeck-us.net>
Cc: Claire Chang <tientzu@chromium.org>
Cc: Christoph Hellwig <hch@lst.de>
Cc: Robin Murphy <robin.murphy@arm.com>
Cc: Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>
Cc: Nathan Chancellor <nathan@kernel.org>

--->8

Will Deacon (5):
  of: Return success from of_dma_set_restricted_buffer() when
    !OF_ADDRESS
  swiotlb: Point io_default_tlb_mem at static allocation
  swiotlb: Remove io_tlb_default_mem indirection
  swiotlb: Emit diagnostic in swiotlb_exit()
  swiotlb: Free tbl memory in swiotlb_exit()

 drivers/base/core.c       |  2 +-
 drivers/of/of_private.h   |  3 +-
 drivers/xen/swiotlb-xen.c |  4 +-
 include/linux/swiotlb.h   |  4 +-
 kernel/dma/swiotlb.c      | 82 +++++++++++++++++++++++----------------
 5 files changed, 56 insertions(+), 39 deletions(-)

-- 
2.32.0.402.g57bb445576-goog

