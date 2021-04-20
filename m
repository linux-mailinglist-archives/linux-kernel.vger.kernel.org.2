Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 69CA1365BC9
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Apr 2021 17:03:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232974AbhDTPDw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 20 Apr 2021 11:03:52 -0400
Received: from mail.kernel.org ([198.145.29.99]:59228 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232902AbhDTPDv (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Apr 2021 11:03:51 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id DB1B9610A1;
        Tue, 20 Apr 2021 15:03:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1618930999;
        bh=j2AhiOXhAEFdSXlVtOmuTch74/ss0CH34AqlDj2lObw=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=rghGQ4Jms/10w+c2YUoA0xR7pEvFY+pxR5xN1nGHNOtIWuVhOZjS4OjDGWh0wTPzI
         RUuP17zgJlqsGRhFIpV2eRuid/0uqrYF74K5VpG4lVFZWkqrPIcbIkHikAMeITJKVU
         WhjGYkyswCKkggInHbmvW57ScJAZxQ3UUloLx6rEPnUsWD6H6pql50reuV5IONOLNM
         seMsNftgoixkTpCGEgvGDiOb+PlXgfV+0OMBu9tnscaCRp61/9BC0qt1zQ9w1w4Rdr
         1n0zGLpmgjzZrjQpdUQCNSL1blMLFdzLl/ObWLC+ohd+RDp4p1ZkAn5AS3/acz9zlU
         /SNxFd6Pbb/Jg==
Date:   Tue, 20 Apr 2021 18:03:11 +0300
From:   Mike Rapoport <rppt@kernel.org>
To:     David Hildenbrand <david@redhat.com>
Cc:     linux-arm-kernel@lists.infradead.org,
        Anshuman Khandual <anshuman.khandual@arm.com>,
        Ard Biesheuvel <ardb@kernel.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Marc Zyngier <maz@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Mike Rapoport <rppt@linux.ibm.com>,
        Will Deacon <will@kernel.org>, kvmarm@lists.cs.columbia.edu,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org
Subject: Re: [PATCH v1 2/4] memblock: update initialization of reserved pages
Message-ID: <YH7tL77Z9UzTAFca@kernel.org>
References: <20210420090925.7457-1-rppt@kernel.org>
 <20210420090925.7457-3-rppt@kernel.org>
 <ed8f10a0-9b68-1d12-0305-90fd378af6b9@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ed8f10a0-9b68-1d12-0305-90fd378af6b9@redhat.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Apr 20, 2021 at 03:56:28PM +0200, David Hildenbrand wrote:
> On 20.04.21 11:09, Mike Rapoport wrote:
> > From: Mike Rapoport <rppt@linux.ibm.com>
> > 
> > The struct pages representing a reserved memory region are initialized
> > using reserve_bootmem_range() function. This function is called for each
> > reserved region just before the memory is freed from memblock to the buddy
> > page allocator.
> > 
> > The struct pages for MEMBLOCK_NOMAP regions are kept with the default
> > values set by the memory map initialization which makes it necessary to
> > have a special treatment for such pages in pfn_valid() and
> > pfn_valid_within().
> 
> Just a general question while thinking about it:
> 
> Would we right now initialize the memmap of these pages already via
> memmap_init_zone()->memmap_init_range()? (IOW, not marking the
> PageReserved?)

Yep. These pages are part of memblock.memory so they are initialized in
memmap_init_zone()->memmap_init_range() to the default values.

-- 
Sincerely yours,
Mike.
