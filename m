Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7555536C631
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Apr 2021 14:41:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236139AbhD0MmB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 27 Apr 2021 08:42:01 -0400
Received: from mail.kernel.org ([198.145.29.99]:55624 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S235410AbhD0MmA (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Apr 2021 08:42:00 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 457B861059;
        Tue, 27 Apr 2021 12:41:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1619527277;
        bh=P+oLcg/KgUKwLIvYmcCRqckymcvWUs4EWrMcpfr89qA=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Si+4HW3ASVsCkRRhUXpnUKiBsIwvgH3s6gMg4zAZtzXEBMAmchfr006GslZOmi5ne
         zmyRrYlPnFg9Gj9jQ+zSQi0qCfjzk2AUWbN6rWwfgbhACVw4/Ibky3v05fZ2wOybUi
         aCGmRnJQGAhbBdGCJVlGikWmDcmXUoCL4vLwa3EQ=
Date:   Tue, 27 Apr 2021 14:41:15 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Robin Murphy <robin.murphy@arm.com>
Cc:     Corentin Labbe <clabbe.montjoie@gmail.com>, rafael@kernel.org,
        hch@lst.de, m.szyprowski@samsung.com,
        iommu@lists.linux-foundation.org, linux-kernel@vger.kernel.org
Subject: Re: dma-api debugfs directory is not created since debugfs is not
 initialized
Message-ID: <YIgGa6yF/adg8OSN@kroah.com>
References: <YIf2w1navFNeYjMS@Red>
 <YIf35EzfSY7qavWw@kroah.com>
 <22f268bb-9b96-1208-0292-68c9b50422a1@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <22f268bb-9b96-1208-0292-68c9b50422a1@arm.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Apr 27, 2021 at 01:32:50PM +0100, Robin Murphy wrote:
> On 2021-04-27 12:39, Greg KH wrote:
> > On Tue, Apr 27, 2021 at 01:34:27PM +0200, Corentin Labbe wrote:
> > > Hello
> > > 
> > > I try to debug some DMA problem on next-20210427, and so I have enabled CONFIG_DMA_API_DEBUG=y.
> > > But the dma-api directory does show up in debugfs, but lot of other directory exists in it.
> > 
> > Does it show up properly in 5.12?
> > 
> > > After debugging it seems due to commit 56348560d495 ("debugfs: do not attempt to create a new file before the filesystem is initalized")
> > > Reverting the commit permit to "dma-api" debugfs to be found. (but seems not the right way to fix it).
> > 
> > We have had some odd start-up ordering issues that the above commit has
> > caused to show.  Given that this commit is now in stable kernels, with
> > no report of this issue so far, I'm worried that maybe this is a dma
> > subsystem ordering issue?
> 
> Both debugfs_init() and dma_debug_init() do run at core_initcall level, and
> disassembling the vmlinux from my current working tree does indeed suggest
> that they somehow end up in the wrong relative order:
> 
> [...]
> ffff80001160d0c8 <__initcall__kmod_debug__325_918_dma_debug_init1>:
> ffff80001160d0c8:       feb0d528        .word   0xfeb0d528
> 
> [...]
> 
> ffff80001160d108 <__initcall__kmod_debugfs__357_848_debugfs_init1>:
> ffff80001160d108:       fff4326c        .word   0xfff4326c
> [...]
> 
> 
> I always had the impression that initcall ordering tended to work out
> roughly alphabetical, such that entries from fs/* might come before
> kernel/*, but I guess it's at the whims of the linker in the end :/

init call ordering happens from link ordering.

> Perhaps the easiest thing to do is split out dma_debug_fs_init() and run
> that at a later level? We do want the dma-debug infrastructure itself to be
> up as early as possible, but I think the debugfs view of its internals can
> happily wait until closer to the time that there's actually a userspace to
> be able to look at it.

That seems like a better idea here, there's no need for "special
treatment" of debugfs.

thanks,

greg k-h
