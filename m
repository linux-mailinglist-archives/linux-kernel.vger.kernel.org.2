Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 572E53CFAE9
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Jul 2021 15:42:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238683AbhGTNBm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 20 Jul 2021 09:01:42 -0400
Received: from mail.kernel.org ([198.145.29.99]:57178 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S238352AbhGTM56 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Jul 2021 08:57:58 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 1A983610C7;
        Tue, 20 Jul 2021 13:38:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1626788314;
        bh=X1OfJw0RM1DPXO0z6hDn73lwdA7qoOG1pYnQLWh5Ur8=;
        h=From:To:Cc:Subject:Date:From;
        b=KKnaiyeZfIQrjBKwWAn3ylTLFVOvyEjYO9lhgTX0JLI+8ScqxgsjTeNmRS/Bemr9Z
         ++NJ3g81fbxoVXXajwOBbWJ6AcdPtm5elBg5MQOEYm1k8Wtj/pxgR03fiiFF8BN48+
         8naEoeaWMqZFjTqyUyr6Nyizk1CHAaCm5TLSyO0HONHjCbgCnAvczL3EB3+612jg42
         5+VGKEnOMPXilon0hNHIXFYgGowJvKLeLRh19n1vb+ZKZJYZOKbu6Shi/VFOyerqkS
         K0z9IDubo1zjoFfLrLboxTtluJ2klsja8K/Cj2mFHySACWSWfm5+bjoqzrlLdHjIik
         AqV5u/LyZRWMg==
From:   Will Deacon <will@kernel.org>
To:     iommu@lists.linux-foundation.org
Cc:     linux-kernel@vger.kernel.org, Will Deacon <will@kernel.org>,
        Guenter Roeck <linux@roeck-us.net>,
        Claire Chang <tientzu@chromium.org>,
        Christoph Hellwig <hch@lst.de>,
        Robin Murphy <robin.murphy@arm.com>,
        Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>,
        Nathan Chancellor <nathan@kernel.org>
Subject: [PATCH v2 0/4] Fix restricted DMA vs swiotlb_exit()
Date:   Tue, 20 Jul 2021 14:38:22 +0100
Message-Id: <20210720133826.9075-1-will@kernel.org>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi again, folks,

This is version two of the patch series I posted yesterday:

  https://lore.kernel.org/r/20210719123054.6844-1-will@kernel.org

The only changes since v1 are:

  * Squash patches 2 and 3, amending the commit message accordingly
  * Add Reviewed-by and Tested-by tags from Christoph and Claire (thanks!)

I'd usually leave it a bit longer between postings, but since this fixes
issues with patches in -next I thought I'd spin a new version immediately.

Cheers,

Will

Cc: Guenter Roeck <linux@roeck-us.net>
Cc: Claire Chang <tientzu@chromium.org>
Cc: Christoph Hellwig <hch@lst.de>
Cc: Robin Murphy <robin.murphy@arm.com>
Cc: Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>
Cc: Nathan Chancellor <nathan@kernel.org>

--->8

Will Deacon (4):
  of: Return success from of_dma_set_restricted_buffer() when
    !OF_ADDRESS
  swiotlb: Convert io_default_tlb_mem to static allocation
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

