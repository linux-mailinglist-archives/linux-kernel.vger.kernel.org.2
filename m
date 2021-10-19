Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C1712432D62
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Oct 2021 07:46:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233395AbhJSFsJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 19 Oct 2021 01:48:09 -0400
Received: from mail.kernel.org ([198.145.29.99]:36502 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229527AbhJSFsI (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Oct 2021 01:48:08 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id D89D36108E;
        Tue, 19 Oct 2021 05:45:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1634622356;
        bh=4tFcqwTRXqGKGRhpNjefcElR0f+rUUFI3ptNbOGbzQ8=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=WoCIneDVFecJl23oybkx9yUnJvdgy+f+amkOJAvBqJpz2zuSyoCxeqbT7ng87zswj
         qO9bagM7SZL6TsJfld6lr8ZrjSld5n5OvUIsy1QbL+9fdwqmQD98DFpVw/omy6UbVN
         jJpBs7vRcIB+OAMTzjITkRGXLzQwCJTl/YxkFW+1kqCGfh7IMiexscmHgoDk0ImT9P
         eScU6czzxnj+cFS7CSY8Xt9xuAstWDw4a1UxS9Bslrx+wBxE2u91nwaEem7f1LTzDa
         BnxUdjZYnJWDsx+324qsKQmw8K9QiL4mKU8XmqFAMtb8/TAP9IGLjQkaq1Jhube4qk
         uuY6NxPizwwVA==
Date:   Tue, 19 Oct 2021 08:45:49 +0300
From:   Mike Rapoport <rppt@kernel.org>
To:     Qian Cai <quic_qiancai@quicinc.com>
Cc:     linux-mm@kvack.org, Andrew Morton <akpm@linux-foundation.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Mike Rapoport <rppt@linux.ibm.com>,
        Vladimir Zapolskiy <vladimir.zapolskiy@linaro.org>,
        linux-kernel@vger.kernel.org,
        Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: [PATCH] memblock: exclude NOMAP regions from kmemleak
Message-ID: <YW5bjV128Qk1foIv@kernel.org>
References: <20211013054756.12177-1-rppt@kernel.org>
 <c30ff0a2-d196-c50d-22f0-bd50696b1205@quicinc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <c30ff0a2-d196-c50d-22f0-bd50696b1205@quicinc.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Qian,

On Mon, Oct 18, 2021 at 11:55:40PM -0400, Qian Cai wrote:
> 
> 
> On 10/13/2021 1:47 AM, Mike Rapoport wrote:
> > From: Mike Rapoport <rppt@linux.ibm.com>
> > 
> > Vladimir Zapolskiy reports:
> > 
> > commit a7259df76702 ("memblock: make memblock_find_in_range method private")
> > invokes a kernel panic while running kmemleak on OF platforms with nomaped
> > regions:
> > 
> >   Unable to handle kernel paging request at virtual address fff000021e00000
> >   [...]
> >     scan_block+0x64/0x170
> >     scan_gray_list+0xe8/0x17c
> >     kmemleak_scan+0x270/0x514
> >     kmemleak_write+0x34c/0x4ac
> > 
> > Indeed, NOMAP regions don't have linear map entries so an attempt to scan
> > these areas would fault.
> > 
> > Prevent such faults by excluding NOMAP regions from kmemleak.
> > 
> > Link: https://lore.kernel.org/all/8ade5174-b143-d621-8c8e-dc6a1898c6fb@linaro.org
> > Fixes: a7259df76702 ("memblock: make memblock_find_in_range method private")
> > Signed-off-by: Mike Rapoport <rppt@linux.ibm.com>
> > Tested-by: Vladimir Zapolskiy <vladimir.zapolskiy@linaro.org>
> 
> Mike, reverting this commit on the top of today's linux-next fixed the early booting hang
> on an arm64 server with kmemleak. Even with "earlycon", it could only print out those
> lines.
> 
> EFI stub: Booting Linux Kernel...
> EFI stub: EFI_RNG_PROTOCOL unavailable
> EFI stub: ERROR: FIRMWARE BUG: kernel image not aligned on 128k boundary
> EFI stub: ERROR: FIRMWARE BUG: Image BSS overlaps adjacent EFI memory region
> EFI stub: Using DTB from configuration table
> EFI stub: Exiting boot services…
> 
> I could help to confirm if it hangs right in the early boot somewhere if needed.

The kernel config and a log of working kernel would help to start with.
 
> start_kernel()
>   setup_arch()
>     paging_init()
>       map_mem()
>         memblock_mark_nomap(

So we have kmemleak_free_part_phys() here.

Catalin, any ideas?

> 
> > ---
> >  mm/memblock.c | 7 ++++++-
> >  1 file changed, 6 insertions(+), 1 deletion(-)
> > 
> > diff --git a/mm/memblock.c b/mm/memblock.c
> > index 184dcd2e5d99..5c3503c98b2f 100644
> > --- a/mm/memblock.c
> > +++ b/mm/memblock.c
> > @@ -936,7 +936,12 @@ int __init_memblock memblock_mark_mirror(phys_addr_t base, phys_addr_t size)
> >   */
> >  int __init_memblock memblock_mark_nomap(phys_addr_t base, phys_addr_t size)
> >  {
> > -	return memblock_setclr_flag(base, size, 1, MEMBLOCK_NOMAP);
> > +	int ret = memblock_setclr_flag(base, size, 1, MEMBLOCK_NOMAP);
> > +
> > +	if (!ret)
> > +		kmemleak_free_part_phys(base, size);
> > +
> > +	return ret;
> >  }
> >  
> >  /**
> > 
> > base-commit: 64570fbc14f8d7cb3fe3995f20e26bc25ce4b2cc
> > 

-- 
Sincerely yours,
Mike.
