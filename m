Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9E0213F9544
	for <lists+linux-kernel@lfdr.de>; Fri, 27 Aug 2021 09:41:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244450AbhH0Hle (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 27 Aug 2021 03:41:34 -0400
Received: from verein.lst.de ([213.95.11.211]:33103 "EHLO verein.lst.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231345AbhH0Hld (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 27 Aug 2021 03:41:33 -0400
Received: by verein.lst.de (Postfix, from userid 2407)
        id 001846736F; Fri, 27 Aug 2021 09:40:41 +0200 (CEST)
Date:   Fri, 27 Aug 2021 09:40:41 +0200
From:   Christoph Hellwig <hch@lst.de>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Will Deacon <will@kernel.org>, Christoph Hellwig <hch@lst.de>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Android Kernel Team <kernel-team@android.com>
Subject: Re: [GIT PULL] arm64 fix for 5.14
Message-ID: <20210827074041.GA24309@lst.de>
References: <20210826131747.GE26318@willie-the-truck> <CAHk-=wi8Wxazuq+E4_V0GG4eda0rNpZi76AYWQe7xfPZAAexAQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAHk-=wi8Wxazuq+E4_V0GG4eda0rNpZi76AYWQe7xfPZAAexAQ@mail.gmail.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Aug 26, 2021 at 11:41:34AM -0700, Linus Torvalds wrote:
> "pfn_valid()" is more about whether you can do a "pfn_to_page()" lookup on it.
> 
> II get the feeling that the dma-mapping code should allow pages that
> are PageReserved() to be mapped - they aren't "ram" in the kernel
> sense.
> 
> Perhaps also make sure it's not the zero page (which is
> PageReserved(), but most definitely RAM).
> 
> In a PC world that would be (for example) the legacy PCI space at
> 0xa0000-0xfffff, but I could easily imagine other platforms having
> other situations.

So what would be the correct check for "this is not actually page backed
normal RAM"?
