Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9F13641D0F3
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Sep 2021 03:30:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347230AbhI3Bc2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 29 Sep 2021 21:32:28 -0400
Received: from mail.kernel.org ([198.145.29.99]:58248 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229477AbhI3Bc1 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Sep 2021 21:32:27 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 20A6261555;
        Thu, 30 Sep 2021 01:30:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1632965445;
        bh=W4G6Gi3WfUEF+ocW3iGHbdJrEsYEKtCwelydWmNSTXY=;
        h=From:To:Cc:Subject:Date:From;
        b=FeOEGvYRt9YBnwi5kb3qw8llRdbAqgOX6GOAwmn4C6e28NCDqfS8q5TUg2/bAbIFc
         OvNHwA/EpqIBHDiAdYuUqhshspz+SGchmTQodNjn+9BI89Een4JTe6+CdWq+uqjd/O
         ELQcKqDQ73VGn9LFULcWdRiwt1PWG2nakPImJSXJYsOz/L+b4+hIrubDMVuWwbi+Xc
         TB3T9h0huptHiBzUo1Q+MKwh+vm2H+UcPWWNQCxdr9aZf2jRpaAhrHY4bcdq6MNF97
         rs0kxTFZvJAdBbiXn8EoQ/8LL2+y2OzRLQtZSrharXYebFR3x1yiN+9kMR+KY+m59L
         caIl6hfQKQ89A==
From:   Mike Rapoport <rppt@kernel.org>
To:     linux-arm-kernel@lists.infradead.org
Cc:     Alex Bee <knaerzche@gmail.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Anshuman Khandual <anshuman.khandual@arm.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Christoph Hellwig <hch@lst.de>,
        David Hildenbrand <david@redhat.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Marek Szyprowski <m.szyprowski@samsung.com>,
        Mike Rapoport <rppt@kernel.org>,
        Mike Rapoport <rppt@linux.ibm.com>,
        Robin Murphy <robin.murphy@arm.com>,
        Will Deacon <will@kernel.org>, iommu@lists.linux-foundation.org
Subject: [PATCH 0/2] arm64: retry dropping HAVE_ARCH_PFN_VALID
Date:   Thu, 30 Sep 2021 04:30:37 +0300
Message-Id: <20210930013039.11260-1-rppt@kernel.org>
X-Mailer: git-send-email 2.28.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Mike Rapoport <rppt@linux.ibm.com>

Hi,

This is a new attempt to drop HAVE_ARCH_PFN_VALID on arm64 and start using
the generic implementation of pfn_valid().

The first patch removes the check for pfn_valid() in dma_map_resource()
which is required to avoid false positives when there is memory map for
MMIO.

Anshuman Khandual (1):
  arm64/mm: drop HAVE_ARCH_PFN_VALID

Mike Rapoport (1):
  dma-mapping: remove bogus test for pfn_valid from dma_map_resource

 arch/arm64/Kconfig            |  1 -
 arch/arm64/include/asm/page.h |  1 -
 arch/arm64/mm/init.c          | 37 -----------------------------------
 kernel/dma/mapping.c          |  4 ----
 4 files changed, 43 deletions(-)


base-commit: 5816b3e6577eaa676ceb00a848f0fd65fe2adc29
-- 
2.28.0

