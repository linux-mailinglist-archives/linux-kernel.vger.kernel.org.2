Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F10FB413652
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Sep 2021 17:38:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234143AbhIUPjm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 21 Sep 2021 11:39:42 -0400
Received: from verein.lst.de ([213.95.11.211]:56744 "EHLO verein.lst.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S234078AbhIUPji (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Sep 2021 11:39:38 -0400
Received: by verein.lst.de (Postfix, from userid 2407)
        id 620AF67373; Tue, 21 Sep 2021 17:38:05 +0200 (CEST)
Date:   Tue, 21 Sep 2021 17:38:05 +0200
From:   Christoph Hellwig <hch@lst.de>
To:     Mike Rapoport <rppt@kernel.org>
Cc:     Christoph Hellwig <hch@lst.de>,
        Catalin Marinas <catalin.marinas@arm.com>,
        David Hildenbrand <david@redhat.com>,
        Robin Murphy <robin.murphy@arm.com>,
        Alex Bee <knaerzche@gmail.com>, Will Deacon <will@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Anshuman Khandual <anshuman.khandual@arm.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-mm@kvack.org,
        Linux ARM <linux-arm-kernel@lists.infradead.org>
Subject: Re: [BUG 5.14] arm64/mm: dma memory mapping fails (in some cases)
Message-ID: <20210921153805.GA29952@lst.de>
References: <0908ce39-7e30-91fa-68ef-11620f9596ae@arm.com> <60a11eba-2910-3b5f-ef96-97d4556c1596@redhat.com> <20210825102044.GA3420@arm.com> <YUUHJ5EI+6Mop4Wu@kernel.org> <20210918051843.GA16104@lst.de> <YUWlO2tZC5IwCAHV@kernel.org> <YUXQBV6KKi+/Q6gX@kernel.org> <YUhpNgwwttW1ewez@arm.com> <20210921082007.GA29121@lst.de> <YUmnEoifUsnvAiuV@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YUmnEoifUsnvAiuV@kernel.org>
User-Agent: Mutt/1.5.17 (2007-11-01)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Sep 21, 2021 at 12:34:10PM +0300, Mike Rapoport wrote:
> > It doesn't create any new mappings.  The only real issue is that it
> > does the wrong thing for RAM in a way that might not be noticed on
> > simple (x86/PC) platforms.
> 
> But if the mapping request was rejected by devm_ioremap_resource() because
> of an attempt to map RAM, why we would get to dma_map_resource() at all? 

dma_map_resource takes a phys_addr_t that could come from anywhere.
