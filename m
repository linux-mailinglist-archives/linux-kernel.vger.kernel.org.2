Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3671A39351F
	for <lists+linux-kernel@lfdr.de>; Thu, 27 May 2021 19:49:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235399AbhE0Rux (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 27 May 2021 13:50:53 -0400
Received: from mail.kernel.org ([198.145.29.99]:44336 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229791AbhE0Ruu (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 May 2021 13:50:50 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 4F3036135C;
        Thu, 27 May 2021 17:49:16 +0000 (UTC)
Date:   Thu, 27 May 2021 18:49:13 +0100
From:   Catalin Marinas <catalin.marinas@arm.com>
To:     Anshuman Khandual <anshuman.khandual@arm.com>
Cc:     linux-arm-kernel@lists.infradead.org,
        Will Deacon <will@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        David Hildenbrand <david@redhat.com>,
        Mike Rapoport <rppt@kernel.org>, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org
Subject: Re: [PATCH] arm64/mm: Drop HAVE_ARCH_PFN_VALID
Message-ID: <20210527174913.GJ8661@arm.com>
References: <1621947349-25421-1-git-send-email-anshuman.khandual@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1621947349-25421-1-git-send-email-anshuman.khandual@arm.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, May 25, 2021 at 06:25:49PM +0530, Anshuman Khandual wrote:
> CONFIG_SPARSEMEM_VMEMMAP is now the only available memory model on arm64
> platforms and free_unused_memmap() would just return without creating any
> holes in the memmap mapping. There is no need for any special handling in
> pfn_valid() and HAVE_ARCH_PFN_VALID can just be dropped. This also moves
> the pfn upper bits sanity check into generic pfn_valid().
> 
> Cc: Catalin Marinas <catalin.marinas@arm.com>
> Cc: Will Deacon <will@kernel.org>
> Cc: Andrew Morton <akpm@linux-foundation.org>
> Cc: David Hildenbrand <david@redhat.com>
> Cc: Mike Rapoport <rppt@kernel.org>
> Cc: linux-arm-kernel@lists.infradead.org
> Cc: linux-kernel@vger.kernel.org
> Cc: linux-mm@kvack.org
> Acked-by: Mike Rapoport <rppt@linux.ibm.com>
> Acked-by: David Hildenbrand <david@redhat.com>
> Signed-off-by: Anshuman Khandual <anshuman.khandual@arm.com>

Acked-by: Catalin Marinas <catalin.marinas@arm.com>
