Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A370241EF0B
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Oct 2021 16:01:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1353653AbhJAOD3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 1 Oct 2021 10:03:29 -0400
Received: from mail.kernel.org ([198.145.29.99]:48874 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1353675AbhJAOD1 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Oct 2021 10:03:27 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id D0EBD61A03;
        Fri,  1 Oct 2021 14:01:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1633096903;
        bh=BsLzucRJ7iKQ3GfXIzsq7Cvk+aim72OP90PDiMEECj0=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=j5GdhvssI4RdbYJP3J1S9LJ0NqL4nQUK7KN50vCwzskamQeWQMudtzvO7P0BFxuuV
         K0Xyofnxi0Ih3eOzHDGWHcAwgmUYYqqqZyqwWwKmXY1imuBSvdqCwVUXML4PcJW9Ys
         Tw1z0OgxoaEGRT2gWxPmnipsLa+vNwyBjonCXsCr4a3qbyrH6dKLB/ZHHSNzBAcYTX
         tkcsVj6kqfbNSXaiDKQ18nz9QUqKZDLArkXPbpJcacFejUZE5cZ2mM4NGDhGDNcHB3
         QyLBlk/1XEqB4Coh2Cvl6FooRW0+upYa4OFgj+VeLVgsiEZ0S42SIMIjMWkTNZsuMK
         igtmUN0yh/6Uw==
From:   Will Deacon <will@kernel.org>
To:     Mike Rapoport <rppt@kernel.org>,
        linux-arm-kernel@lists.infradead.org
Cc:     catalin.marinas@arm.com, kernel-team@android.com,
        Will Deacon <will@kernel.org>,
        David Hildenbrand <david@redhat.com>,
        Robin Murphy <robin.murphy@arm.com>,
        Christoph Hellwig <hch@lst.de>,
        Andrew Morton <akpm@linux-foundation.org>,
        Mike Rapoport <rppt@linux.ibm.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Marek Szyprowski <m.szyprowski@samsung.com>,
        Alex Bee <knaerzche@gmail.com>,
        Anshuman Khandual <anshuman.khandual@arm.com>,
        iommu@lists.linux-foundation.org
Subject: Re: [PATCH 0/2] arm64: retry dropping HAVE_ARCH_PFN_VALID
Date:   Fri,  1 Oct 2021 15:01:32 +0100
Message-Id: <163309648548.1106750.5985957686338166630.b4-ty@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20210930013039.11260-1-rppt@kernel.org>
References: <20210930013039.11260-1-rppt@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 30 Sep 2021 04:30:37 +0300, Mike Rapoport wrote:
> From: Mike Rapoport <rppt@linux.ibm.com>
> 
> Hi,
> 
> This is a new attempt to drop HAVE_ARCH_PFN_VALID on arm64 and start using
> the generic implementation of pfn_valid().
> 
> [...]

Applied to arm64 (for-next/pfn-valid), thanks!

[1/2] dma-mapping: remove bogus test for pfn_valid from dma_map_resource
      https://git.kernel.org/arm64/c/a9c38c5d267c
[2/2] arm64/mm: drop HAVE_ARCH_PFN_VALID
      https://git.kernel.org/arm64/c/3de360c3fdb3

Cheers,
-- 
Will

https://fixes.arm64.dev
https://next.arm64.dev
https://will.arm64.dev
