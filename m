Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 90C1C3F91D9
	for <lists+linux-kernel@lfdr.de>; Fri, 27 Aug 2021 03:15:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243917AbhH0BKR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 26 Aug 2021 21:10:17 -0400
Received: from mail.kernel.org ([198.145.29.99]:57296 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S243811AbhH0BKO (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 Aug 2021 21:10:14 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 0429160698;
        Fri, 27 Aug 2021 01:09:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1630026566;
        bh=XwuUCQSEDzl5nlvr8LUNjMZUBVFQB2QvKB3zGRKthP8=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
        b=oiVgDzQEu/BViUr/MOnxQQSvPy+xqpouo1xJAxr5AlaxI5Qg9KGAFGljDa5h80qqG
         bCUnU/FFFFTgp4KCP+i9vGOMBlxzz4CpgF74yO6ic/vI9xyf4lVahbBwi+WmR7K6oh
         FIWQF9S1UZuG7jog4lqzrD6EtsWmkghYm3piAfwrMUNAD653vjsFs75TucfKBr0jst
         leEzIMgAT1JOccz5h7jGw7QpBYkkVVZ1izT3JHBo/k/QPqyekQkl9ayqRoyWV7cunr
         owvZXlaMP1SwQ5AObTuHN1VEs1o0rh2iyWh2A9ER75/rTM2OpqYXtdg6q+t2n+oeH/
         Bmqd60xkfrD5A==
Subject: Re: [arc:for-next 29/33] arch/arc/include/asm/page.h:52:30: error:
 'struct page' has no member named 'pte'; did you mean 'ptl'?
To:     kernel test robot <lkp@intel.com>
Cc:     kbuild-all@lists.01.org, linux-kernel@vger.kernel.org,
        linux-snps-arc@lists.infradead.org
References: <202108261644.ZyrrjSub-lkp@intel.com>
From:   Vineet Gupta <vgupta@kernel.org>
Message-ID: <07db0892-1c6a-6461-400b-c928e34d2f41@kernel.org>
Date:   Thu, 26 Aug 2021 18:09:25 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
MIME-Version: 1.0
In-Reply-To: <202108261644.ZyrrjSub-lkp@intel.com>
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 8/26/21 1:35 AM, kernel test robot wrote:
> tree:   https://git.kernel.org/pub/scm/linux/kernel/git/vgupta/arc.git for-next
> head:   c80ef1151c91db05e9ed03d7b61ada7af63ce59a
> commit: 4058fa6bf4da7f46a57cb33fe8f6b688052b3eb9 [29/33] ARC: mm: switch pgtable_t back to struct page *
> config: arc-allyesconfig (attached as .config)
> compiler: arceb-elf-gcc (GCC) 11.2.0
> reproduce (this is a W=1 build):
>          wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
>          chmod +x ~/bin/make.cross
>          # https://git.kernel.org/pub/scm/linux/kernel/git/vgupta/arc.git/commit/?id=4058fa6bf4da7f46a57cb33fe8f6b688052b3eb9
>          git remote add arc https://git.kernel.org/pub/scm/linux/kernel/git/vgupta/arc.git
>          git fetch --no-tags arc for-next
>          git checkout 4058fa6bf4da7f46a57cb33fe8f6b688052b3eb9
>          # save the attached .config to linux build tree
>          mkdir build_dir
>          COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-11.2.0 make.cross O=build_dir ARCH=arc SHELL=/bin/bash
>
> If you fix the issue, kindly add following tag as appropriate
> Reported-by: kernel test robot <lkp@intel.com>
>
> All errors (new ones prefixed by >>):
>
>     arch/arc/mm/tlb.c:392:6: warning: no previous prototype for 'create_tlb' [-Wmissing-prototypes]
>       392 | void create_tlb(struct vm_area_struct *vma, unsigned long vaddr, pte_t *ptep)
>           |      ^~~~~~~~~~
>     In file included from include/linux/mm_types_task.h:16,
>                      from include/linux/mm_types.h:5,
>                      from include/linux/buildid.h:5,
>                      from include/linux/module.h:14,
>                      from arch/arc/mm/tlb.c:9:
>     arch/arc/mm/tlb.c: In function 'pgtable_trans_huge_withdraw':
>>> arch/arc/include/asm/page.h:52:30: error: 'struct page' has no member named 'pte'; did you mean 'ptl'?
>        52 | #define pte_val(x)      ((x).pte)
>           |                              ^~~
>     arch/arc/mm/tlb.c:568:9: note: in expansion of macro 'pte_val'
>       568 |         pte_val(pgtable[0]) = 0;
>           |         ^~~~~~~
>>> arch/arc/include/asm/page.h:52:30: error: 'struct page' has no member named 'pte'; did you mean 'ptl'?
>        52 | #define pte_val(x)      ((x).pte)
>           |                              ^~~
>     arch/arc/mm/tlb.c:569:9: note: in expansion of macro 'pte_val'
>       569 |         pte_val(pgtable[1]) = 0;
>           |         ^~~~~~~
>     arch/arc/mm/tlb.c: At top level:
>     arch/arc/mm/tlb.c:756:6: warning: no previous prototype for 'do_tlb_overlap_fault' [-Wmissing-prototypes]
>       756 | void do_tlb_overlap_fault(unsigned long cause, unsigned long address,
>           |      ^~~~~~~~~~~~~~~~~~~~


Thx for the report. I've fixed this up by removing the now not-needed 
__HAVE_ARCH_PGTABLE_DEPOSIT and __HAVE_ARCH_PGTABLE_WITHDRAW from ARC code.

-Vineet

