Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8723A4130C8
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Sep 2021 11:34:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231424AbhIUJfq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 21 Sep 2021 05:35:46 -0400
Received: from mail.kernel.org ([198.145.29.99]:34394 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229894AbhIUJfp (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Sep 2021 05:35:45 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 9D68961131;
        Tue, 21 Sep 2021 09:34:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1632216857;
        bh=26947zVG9riVqwftMN1dSoamNLEgoqIkp483H/vlQOo=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Zo2HL5/V1BbcKSIpxSOBX/zdavkL4LAEANyknHxlliKWMePeJzZr4IeEC/oSTlAYq
         xMj+dgHL42dCKy96+2Wu4J+KlASIJoo7owJ5j3nG4mnqynPiESYhiWjdd49vSqqN++
         0ZCeYqjlhtTw3fLkQfHAh6iewWUS14jUeFvJupdrrV4Bo+FXTapZvJVk9VC5zxQRNv
         7PaU2iomEyzPiSTKr8eQOOuM0OE9XwNEoX+ySL0No88y23eoUwj9XVk3/eIgpo48Gw
         X5e4Uks97yzbFv3Sdsz5bbAAFMJMKAv14aLh7zxHLMdaa1UylaD0EPl4w0+RE6gUvr
         oylJ1v4fD8l5w==
Date:   Tue, 21 Sep 2021 12:34:10 +0300
From:   Mike Rapoport <rppt@kernel.org>
To:     Christoph Hellwig <hch@lst.de>
Cc:     Catalin Marinas <catalin.marinas@arm.com>,
        David Hildenbrand <david@redhat.com>,
        Robin Murphy <robin.murphy@arm.com>,
        Alex Bee <knaerzche@gmail.com>, Will Deacon <will@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Anshuman Khandual <anshuman.khandual@arm.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-mm@kvack.org,
        Linux ARM <linux-arm-kernel@lists.infradead.org>
Subject: Re: [BUG 5.14] arm64/mm: dma memory mapping fails (in some cases)
Message-ID: <YUmnEoifUsnvAiuV@kernel.org>
References: <YSU6NVZ3j0XCurWC@kernel.org>
 <0908ce39-7e30-91fa-68ef-11620f9596ae@arm.com>
 <60a11eba-2910-3b5f-ef96-97d4556c1596@redhat.com>
 <20210825102044.GA3420@arm.com>
 <YUUHJ5EI+6Mop4Wu@kernel.org>
 <20210918051843.GA16104@lst.de>
 <YUWlO2tZC5IwCAHV@kernel.org>
 <YUXQBV6KKi+/Q6gX@kernel.org>
 <YUhpNgwwttW1ewez@arm.com>
 <20210921082007.GA29121@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210921082007.GA29121@lst.de>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Sep 21, 2021 at 10:20:07AM +0200, Christoph Hellwig wrote:
> On Mon, Sep 20, 2021 at 11:57:58AM +0100, Catalin Marinas wrote:
> > > As this WARN_ON(pfn_valid()) is only present in dma_map_resource() it's
> > > probably safe to drop it entirely. 
> > 
> > I agree, we should drop it. IIUC dma_map_resource() does not create any
> > kernel mapping to cause problems with attribute aliasing. You'd need a
> > prior devm_ioremap_resource() if you want access to that range from the
> > CPU side. For arm64 at least, the latter ends up with a
> > pfn_is_map_memory() check.
> 
> It doesn't create any new mappings.  The only real issue is that it
> does the wrong thing for RAM in a way that might not be noticed on
> simple (x86/PC) platforms.

But if the mapping request was rejected by devm_ioremap_resource() because
of an attempt to map RAM, why we would get to dma_map_resource() at all? 


-- 
Sincerely yours,
Mike.
