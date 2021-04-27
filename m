Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6763836C616
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Apr 2021 14:33:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235951AbhD0Mdk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 27 Apr 2021 08:33:40 -0400
Received: from foss.arm.com ([217.140.110.172]:52338 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S235410AbhD0Mdj (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Apr 2021 08:33:39 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id A544331B;
        Tue, 27 Apr 2021 05:32:56 -0700 (PDT)
Received: from [10.57.61.101] (unknown [10.57.61.101])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 809803F70D;
        Tue, 27 Apr 2021 05:32:55 -0700 (PDT)
Subject: Re: dma-api debugfs directory is not created since debugfs is not
 initialized
To:     Greg KH <gregkh@linuxfoundation.org>,
        Corentin Labbe <clabbe.montjoie@gmail.com>
Cc:     rafael@kernel.org, hch@lst.de, m.szyprowski@samsung.com,
        iommu@lists.linux-foundation.org, linux-kernel@vger.kernel.org
References: <YIf2w1navFNeYjMS@Red> <YIf35EzfSY7qavWw@kroah.com>
From:   Robin Murphy <robin.murphy@arm.com>
Message-ID: <22f268bb-9b96-1208-0292-68c9b50422a1@arm.com>
Date:   Tue, 27 Apr 2021 13:32:50 +0100
User-Agent: Mozilla/5.0 (Windows NT 10.0; rv:78.0) Gecko/20100101
 Thunderbird/78.10.0
MIME-Version: 1.0
In-Reply-To: <YIf35EzfSY7qavWw@kroah.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-GB
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2021-04-27 12:39, Greg KH wrote:
> On Tue, Apr 27, 2021 at 01:34:27PM +0200, Corentin Labbe wrote:
>> Hello
>>
>> I try to debug some DMA problem on next-20210427, and so I have enabled CONFIG_DMA_API_DEBUG=y.
>> But the dma-api directory does show up in debugfs, but lot of other directory exists in it.
> 
> Does it show up properly in 5.12?
> 
>> After debugging it seems due to commit 56348560d495 ("debugfs: do not attempt to create a new file before the filesystem is initalized")
>> Reverting the commit permit to "dma-api" debugfs to be found. (but seems not the right way to fix it).
> 
> We have had some odd start-up ordering issues that the above commit has
> caused to show.  Given that this commit is now in stable kernels, with
> no report of this issue so far, I'm worried that maybe this is a dma
> subsystem ordering issue?

Both debugfs_init() and dma_debug_init() do run at core_initcall level, 
and disassembling the vmlinux from my current working tree does indeed 
suggest that they somehow end up in the wrong relative order:

[...]
ffff80001160d0c8 <__initcall__kmod_debug__325_918_dma_debug_init1>:
ffff80001160d0c8:       feb0d528        .word   0xfeb0d528

[...]

ffff80001160d108 <__initcall__kmod_debugfs__357_848_debugfs_init1>:
ffff80001160d108:       fff4326c        .word   0xfff4326c
[...]


I always had the impression that initcall ordering tended to work out 
roughly alphabetical, such that entries from fs/* might come before 
kernel/*, but I guess it's at the whims of the linker in the end :/

Perhaps the easiest thing to do is split out dma_debug_fs_init() and run 
that at a later level? We do want the dma-debug infrastructure itself to 
be up as early as possible, but I think the debugfs view of its 
internals can happily wait until closer to the time that there's 
actually a userspace to be able to look at it.

Robin.
