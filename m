Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E79BD41301B
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Sep 2021 10:20:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231204AbhIUIVj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 21 Sep 2021 04:21:39 -0400
Received: from verein.lst.de ([213.95.11.211]:55477 "EHLO verein.lst.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230421AbhIUIVi (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Sep 2021 04:21:38 -0400
Received: by verein.lst.de (Postfix, from userid 2407)
        id 9386F67373; Tue, 21 Sep 2021 10:20:07 +0200 (CEST)
Date:   Tue, 21 Sep 2021 10:20:07 +0200
From:   Christoph Hellwig <hch@lst.de>
To:     Catalin Marinas <catalin.marinas@arm.com>
Cc:     Mike Rapoport <rppt@kernel.org>, Christoph Hellwig <hch@lst.de>,
        David Hildenbrand <david@redhat.com>,
        Robin Murphy <robin.murphy@arm.com>,
        Alex Bee <knaerzche@gmail.com>, Will Deacon <will@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Anshuman Khandual <anshuman.khandual@arm.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-mm@kvack.org,
        Linux ARM <linux-arm-kernel@lists.infradead.org>
Subject: Re: [BUG 5.14] arm64/mm: dma memory mapping fails (in some cases)
Message-ID: <20210921082007.GA29121@lst.de>
References: <20210824173741.GC623@arm.com> <YSU6NVZ3j0XCurWC@kernel.org> <0908ce39-7e30-91fa-68ef-11620f9596ae@arm.com> <60a11eba-2910-3b5f-ef96-97d4556c1596@redhat.com> <20210825102044.GA3420@arm.com> <YUUHJ5EI+6Mop4Wu@kernel.org> <20210918051843.GA16104@lst.de> <YUWlO2tZC5IwCAHV@kernel.org> <YUXQBV6KKi+/Q6gX@kernel.org> <YUhpNgwwttW1ewez@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YUhpNgwwttW1ewez@arm.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Sep 20, 2021 at 11:57:58AM +0100, Catalin Marinas wrote:
> > As this WARN_ON(pfn_valid()) is only present in dma_map_resource() it's
> > probably safe to drop it entirely. 
> 
> I agree, we should drop it. IIUC dma_map_resource() does not create any
> kernel mapping to cause problems with attribute aliasing. You'd need a
> prior devm_ioremap_resource() if you want access to that range from the
> CPU side. For arm64 at least, the latter ends up with a
> pfn_is_map_memory() check.

It doesn't create any new mappings.  The only real issue is that it
does the wrong thing for RAM in a way that might not be noticed on
simple (x86/PC) platforms.
