Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9018E4334CD
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Oct 2021 13:37:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235355AbhJSLj3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 19 Oct 2021 07:39:29 -0400
Received: from mail.kernel.org ([198.145.29.99]:60036 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230097AbhJSLj2 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Oct 2021 07:39:28 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 25ED0610A1;
        Tue, 19 Oct 2021 11:37:13 +0000 (UTC)
Date:   Tue, 19 Oct 2021 12:37:10 +0100
From:   Catalin Marinas <catalin.marinas@arm.com>
To:     Mike Rapoport <rppt@kernel.org>
Cc:     Qian Cai <quic_qiancai@quicinc.com>, linux-mm@kvack.org,
        Andrew Morton <akpm@linux-foundation.org>,
        Mike Rapoport <rppt@linux.ibm.com>,
        Vladimir Zapolskiy <vladimir.zapolskiy@linaro.org>,
        linux-kernel@vger.kernel.org,
        Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: [PATCH] memblock: exclude NOMAP regions from kmemleak
Message-ID: <YW6t5tBe/IjSYWn3@arm.com>
References: <20211013054756.12177-1-rppt@kernel.org>
 <c30ff0a2-d196-c50d-22f0-bd50696b1205@quicinc.com>
 <YW5bjV128Qk1foIv@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <YW5bjV128Qk1foIv@kernel.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Oct 19, 2021 at 08:45:49AM +0300, Mike Rapoport wrote:
> On Mon, Oct 18, 2021 at 11:55:40PM -0400, Qian Cai wrote:
> > On 10/13/2021 1:47 AM, Mike Rapoport wrote:
> > > From: Mike Rapoport <rppt@linux.ibm.com>
> > > 
> > > Vladimir Zapolskiy reports:
> > > 
> > > commit a7259df76702 ("memblock: make memblock_find_in_range method private")
> > > invokes a kernel panic while running kmemleak on OF platforms with nomaped
> > > regions:
> > > 
> > >   Unable to handle kernel paging request at virtual address fff000021e00000
> > >   [...]
> > >     scan_block+0x64/0x170
> > >     scan_gray_list+0xe8/0x17c
> > >     kmemleak_scan+0x270/0x514
> > >     kmemleak_write+0x34c/0x4ac
> > > 
> > > Indeed, NOMAP regions don't have linear map entries so an attempt to scan
> > > these areas would fault.
> > > 
> > > Prevent such faults by excluding NOMAP regions from kmemleak.
> > > 
> > > Link: https://lore.kernel.org/all/8ade5174-b143-d621-8c8e-dc6a1898c6fb@linaro.org
> > > Fixes: a7259df76702 ("memblock: make memblock_find_in_range method private")
> > > Signed-off-by: Mike Rapoport <rppt@linux.ibm.com>
> > > Tested-by: Vladimir Zapolskiy <vladimir.zapolskiy@linaro.org>
> > 
> > Mike, reverting this commit on the top of today's linux-next fixed the early booting hang
> > on an arm64 server with kmemleak. Even with "earlycon", it could only print out those
> > lines.
> > 
> > EFI stub: Booting Linux Kernel...
> > EFI stub: EFI_RNG_PROTOCOL unavailable
> > EFI stub: ERROR: FIRMWARE BUG: kernel image not aligned on 128k boundary
> > EFI stub: ERROR: FIRMWARE BUG: Image BSS overlaps adjacent EFI memory region
> > EFI stub: Using DTB from configuration table
> > EFI stub: Exiting boot services…
> > 
> > I could help to confirm if it hangs right in the early boot somewhere if needed.
> 
> The kernel config and a log of working kernel would help to start with.

I don't think there's much in the log other than the EFI stub above.

> > start_kernel()
> >   setup_arch()
> >     paging_init()
> >       map_mem()
> >         memblock_mark_nomap(

Is this actual trace? It would be good to know where exactly it got
stuck.

> So we have kmemleak_free_part_phys() here.

I wonder whether the memblock_mark_nomap() here is too early for
kmemleak. We don't have the linear map created, though it shouldn't be
an issue as the kernel sections are mapped. Also I think
delete_object_part() in kmemleak.c would bail out early as there
shouldn't be any prior memblock_alloc for this range.

-- 
Catalin
