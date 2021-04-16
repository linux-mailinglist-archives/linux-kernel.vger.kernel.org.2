Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9ED97361BFC
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Apr 2021 11:00:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240638AbhDPImp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 16 Apr 2021 04:42:45 -0400
Received: from foss.arm.com ([217.140.110.172]:36070 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S239639AbhDPImo (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 16 Apr 2021 04:42:44 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 11A64106F;
        Fri, 16 Apr 2021 01:42:20 -0700 (PDT)
Received: from [192.168.1.179] (unknown [172.31.20.19])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 43FFA3FA45;
        Fri, 16 Apr 2021 01:42:19 -0700 (PDT)
Subject: Re: [PATCH] mm: ptdump: Fix build failure
To:     Christophe Leroy <christophe.leroy@csgroup.eu>,
        Andrew Morton <akpm@linux-foundation.org>
Cc:     linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
        linux-mm@kvack.org
References: <912b349e2bcaa88939904815ca0af945740c6bd4.1618478922.git.christophe.leroy@csgroup.eu>
From:   Steven Price <steven.price@arm.com>
Message-ID: <c6c50422-9566-8667-0ad6-627c51c9b7aa@arm.com>
Date:   Fri, 16 Apr 2021 09:42:14 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.7.1
MIME-Version: 1.0
In-Reply-To: <912b349e2bcaa88939904815ca0af945740c6bd4.1618478922.git.christophe.leroy@csgroup.eu>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-GB
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 15/04/2021 10:31, Christophe Leroy wrote:
> 	  CC      mm/ptdump.o
> 	In file included from <command-line>:
> 	mm/ptdump.c: In function 'ptdump_pte_entry':
> 	././include/linux/compiler_types.h:320:38: error: call to '__compiletime_assert_207' declared with attribute error: Unsupported access size for {READ,WRITE}_ONCE().
> 	  320 |  _compiletime_assert(condition, msg, __compiletime_assert_, __COUNTER__)
> 	      |                                      ^
> 	././include/linux/compiler_types.h:301:4: note: in definition of macro '__compiletime_assert'
> 	  301 |    prefix ## suffix();    \
> 	      |    ^~~~~~
> 	././include/linux/compiler_types.h:320:2: note: in expansion of macro '_compiletime_assert'
> 	  320 |  _compiletime_assert(condition, msg, __compiletime_assert_, __COUNTER__)
> 	      |  ^~~~~~~~~~~~~~~~~~~
> 	./include/asm-generic/rwonce.h:36:2: note: in expansion of macro 'compiletime_assert'
> 	   36 |  compiletime_assert(__native_word(t) || sizeof(t) == sizeof(long long), \
> 	      |  ^~~~~~~~~~~~~~~~~~
> 	./include/asm-generic/rwonce.h:49:2: note: in expansion of macro 'compiletime_assert_rwonce_type'
> 	   49 |  compiletime_assert_rwonce_type(x);    \
> 	      |  ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
> 	mm/ptdump.c:114:14: note: in expansion of macro 'READ_ONCE'
> 	  114 |  pte_t val = READ_ONCE(*pte);
> 	      |              ^~~~~~~~~
> 	make[2]: *** [mm/ptdump.o] Error 1
> 
> READ_ONCE() cannot be used for reading PTEs. Use ptep_get()
> instead. See commit 481e980a7c19 ("mm: Allow arches to provide ptep_get()")
> and commit c0e1c8c22beb ("powerpc/8xx: Provide ptep_get() with 16k pages")
> for details.

It was cargo-culted from the arm64/x86 implementations (where this 
happens to be safe).

> Fixes: 30d621f6723b ("mm: add generic ptdump")
> Cc: Steven Price <steven.price@arm.com>
> Signed-off-by: Christophe Leroy <christophe.leroy@csgroup.eu>

Reviewed-by: Steven Price <steven.price@arm.com>

Thanks,

Steve

> ---
>   mm/ptdump.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/mm/ptdump.c b/mm/ptdump.c
> index 4354c1422d57..da751448d0e4 100644
> --- a/mm/ptdump.c
> +++ b/mm/ptdump.c
> @@ -111,7 +111,7 @@ static int ptdump_pte_entry(pte_t *pte, unsigned long addr,
>   			    unsigned long next, struct mm_walk *walk)
>   {
>   	struct ptdump_state *st = walk->private;
> -	pte_t val = READ_ONCE(*pte);
> +	pte_t val = ptep_get(pte);
>   
>   	if (st->effective_prot)
>   		st->effective_prot(st, 4, pte_val(val));
> 

