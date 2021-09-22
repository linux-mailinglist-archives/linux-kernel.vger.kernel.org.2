Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 053F041428E
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Sep 2021 09:22:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233173AbhIVHYI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 22 Sep 2021 03:24:08 -0400
Received: from mail.kernel.org ([198.145.29.99]:41094 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229697AbhIVHYI (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Sep 2021 03:24:08 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id E45AB610A0;
        Wed, 22 Sep 2021 07:22:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1632295358;
        bh=WNKcqaMlMsH9avHQqL/8bXo1+ieMx7dN8g+lDPzOPuQ=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=bnfR0sFXxVmWgESwlgn7ej6589e2jVsdDqcK4MCGIvf4tVB0oabLNs+pB3y4vGg8z
         NQqSASyDEXdPWaQ6masJpciVRvgZhJ43JfAp6MxidubFH6ZJRuahZRJlLZbyV8MtHv
         38YcFV5AvfvO4KA+fkWhOmM65BJZAe7Q6gacfi9akt5GHYDtztJukRSqu4nv2FPMP3
         KKW5Uv1aK/R5JsL5P3GZ5Ipse8zpnFZLirq6kJFmb5RsiGV1BovZVCOTntvCCfYOeZ
         a/lQ3cTpkPGaQ0vGhHtnYe+SkzMNaTxo0yS47yYYYqXs3rIrF0FVBtXmdwp/lEGjoo
         MHDJr4OXgJqiw==
Date:   Wed, 22 Sep 2021 10:22:32 +0300
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
Message-ID: <YUrZuKSaDnJ+rO0k@kernel.org>
References: <60a11eba-2910-3b5f-ef96-97d4556c1596@redhat.com>
 <20210825102044.GA3420@arm.com>
 <YUUHJ5EI+6Mop4Wu@kernel.org>
 <20210918051843.GA16104@lst.de>
 <YUWlO2tZC5IwCAHV@kernel.org>
 <YUXQBV6KKi+/Q6gX@kernel.org>
 <YUhpNgwwttW1ewez@arm.com>
 <20210921082007.GA29121@lst.de>
 <YUmnEoifUsnvAiuV@kernel.org>
 <20210921153805.GA29952@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210921153805.GA29952@lst.de>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Sep 21, 2021 at 05:38:05PM +0200, Christoph Hellwig wrote:
> On Tue, Sep 21, 2021 at 12:34:10PM +0300, Mike Rapoport wrote:
> > > It doesn't create any new mappings.  The only real issue is that it
> > > does the wrong thing for RAM in a way that might not be noticed on
> > > simple (x86/PC) platforms.
> > 
> > But if the mapping request was rejected by devm_ioremap_resource() because
> > of an attempt to map RAM, why we would get to dma_map_resource() at all? 
> 
> dma_map_resource takes a phys_addr_t that could come from anywhere.

Right, but it's not different from, say, dma_map_page_attrs() that can get a
struct page from anywhere and there is no actual memory for that struct
page at all. Do you suggest add a check that that struct page is backed by
memory in dma_map_page_attrs() as well?

-- 
Sincerely yours,
Mike.
