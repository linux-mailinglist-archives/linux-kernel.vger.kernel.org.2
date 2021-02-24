Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4AA44324026
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Feb 2021 16:26:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237933AbhBXOk4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 24 Feb 2021 09:40:56 -0500
Received: from mail.kernel.org ([198.145.29.99]:36902 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S236923AbhBXNa6 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Feb 2021 08:30:58 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id 2869264E85;
        Wed, 24 Feb 2021 13:15:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linux-foundation.org;
        s=korg; t=1614172559;
        bh=MZoh8i4FgPUPMIftsj6XZDX//bWUL5QPp5IVpWULgdA=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=bVFJ2Q16YVDRyU5flsYGNgR5rXrLBHDRcm9LwQ20mDaympotbb5EQzmSxhgJSLh0Z
         7WucUq3QtIU5xxPkE58xgPOYWKlMfTCLaqdQzqQuoNUOqHmw3zwKfOHpCY7okhZ5SE
         qeZ0wfjJUADNpCodH/wu8NmiBpHZySsKbzA44TVE=
Date:   Wed, 24 Feb 2021 05:15:58 -0800
From:   Andrew Morton <akpm@linux-foundation.org>
To:     Yu Zhao <yuzhao@google.com>
Cc:     vbabka@suse.cz, alex.shi@linux.alibaba.com, guro@fb.com,
        hannes@cmpxchg.org, hughd@google.com, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, mhocko@kernel.org, vdavydov.dev@gmail.com,
        willy@infradead.org
Subject: Re: [PATCH] mm: test page->flags directly in page_lru()
Message-Id: <20210224051558.79e31c60eea2c088f4a1b300@linux-foundation.org>
In-Reply-To: <20210224084807.2179942-1-yuzhao@google.com>
References: <20210122220600.906146-11-yuzhao@google.com>
        <20210224084807.2179942-1-yuzhao@google.com>
X-Mailer: Sylpheed 3.5.1 (GTK+ 2.24.31; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 24 Feb 2021 01:48:07 -0700 Yu Zhao <yuzhao@google.com> wrote:

> Currently page_lru() uses Page{Active,Unevictable} to determine which
> lru list a page belongs to. Page{Active,Unevictable} contain
> compound_head() and therefore page_lru() essentially tests
> PG_{active,unevictable} against compound_head(page)->flags. Once an
> lru list is determined, page->lru, rather than
> compound_head(page)->lru, will be added to or deleted from it.
> 
> Though not bug, having compound_head() in page_lru() increases the
> size of vmlinux by O(KB) because page_lru() is inlined many places.
> And removing compound_head() entirely from Page{Active,Unevictable}
> may not be the best option (for the moment) either because there
> may be other cases that need compound_head(). This patch makes
> page_lru() and __clear_page_lru_flags(), which are used immediately
> before and after operations on page->lru, test
> PG_{active,unevictable} directly against page->flags instead.

Oh geeze.

> --- a/include/linux/mm_inline.h
> +++ b/include/linux/mm_inline.h
> @@ -46,14 +46,12 @@ static __always_inline void __clear_page_lru_flags(struct page *page)
>  {
>  	VM_BUG_ON_PAGE(!PageLRU(page), page);
>  
> -	__ClearPageLRU(page);
> -
>  	/* this shouldn't happen, so leave the flags to bad_page() */
> -	if (PageActive(page) && PageUnevictable(page))
> +	if ((page->flags & (BIT(PG_active) | BIT(PG_unevictable))) ==
> +	    (BIT(PG_active) | BIT(PG_unevictable)))
>  		return;

This isn't very nice.  At the very least we should have (documented!)
helper functions for this:

/* comment goes here */
static inline bool RawPageActive(struct page *page)
{
	...
}



However.

Here's what the preprocessor produces for an allmodconfig version of
PageActive():

static inline __attribute__((__gnu_inline__)) __attribute__((__unused__)) __attribute__((no_instrument_function)) __attribute__((__always_inline__)) int PageActive(struct page *page)
{
	return test_bit(PG_active, &({ do { if (__builtin_expect(!!(PagePoisoned(compound_head(page))), 0)) { dump_page(compound_head(page), "VM_BUG_ON_PAGE(" "PagePoisoned(compound_head(page))"")"); do { ({ asm volatile("%c0: nop\n\t" ".pushsection .discard.instr_begin\n\t" ".long %c0b - .\n\t" ".popsection\n\t" : : "i" (373)); }); do { asm volatile("1:\t" ".byte 0x0f, 0x0b" "\n" ".pushsection __bug_table,\"aw\"\n" "2:\t" ".long " "1b" " - 2b" "\t# bug_entry::bug_addr\n" "\t" ".long " "%c0" " - 2b" "\t# bug_entry::file\n" "\t.word %c1" "\t# bug_entry::line\n" "\t.word %c2" "\t# bug_entry::flags\n" "\t.org 2b+%c3\n" ".popsection" : : "i" ("./include/linux/page-flags.h"), "i" (338), "i" (0), "i" (sizeof(struct bug_entry))); } while (0); do { ({ asm volatile("%c0:\n\t" ".pushsection .discard.unreachable\n\t" ".long %c0b - .\n\t" ".popsection\n\t" : : "i" (374)); }); asm volatile(""); __builtin_unreachable(); } while (0); } while (0); } } while (0); compound_head(page); })->flags);

}

That's all to test a single bit!

Four calls to compound_head().

Compiling this:

int wibble(struct page *page)
{
	return PageActive(page);
}


to the below assembly output (allmodconfig build) and it appears that
the compiler did not CSE these calls.  Perhaps it would be beneficial
to give it a bit of help.


This is all nuts.  How much of this inlining is really justifiable?  Do
we know we wouldn't get a better kernel if we did

	mv mm-inline.h mm-not-inline-any-more.c

?

Methinks that mm-inline.c needs some serious work...



	.type	wibble, @function
wibble:
1:	call	__fentry__
	.section __mcount_loc, "a",@progbits
	.quad 1b
	.previous
	pushq	%r12	#
	pushq	%rbp	#
	pushq	%rbx	#
# mm/swap.c:1156: {
	movq	%rdi, %rbx	# page, page
	movq	%rbx, %rbp	# page, _14
# ./include/linux/page-flags.h:184: 	unsigned long head = READ_ONCE(page->compound_head);
	call	__sanitizer_cov_trace_pc	#
	movq	8(%rbx), %r12	# page_2(D)->D.14210.D.14188.compound_head, _8
# ./include/linux/page-flags.h:186: 	if (unlikely(head & 1))
	testb	$1, %r12b	#, _8
	je	.L2945	#,
# ./include/linux/page-flags.h:187: 		return (struct page *) (head - 1);
	call	__sanitizer_cov_trace_pc	#
	leaq	-1(%r12), %rbp	#, _14
	jmp	.L2945	#
.L2945:
	call	__sanitizer_cov_trace_pc	#
# ./include/linux/page-flags.h:338: PAGEFLAG(Active, active, PF_HEAD) __CLEARPAGEFLAG(Active, active, PF_HEAD)
	cmpq	$-1, 0(%rbp)	#, MEM[(long unsigned int *)_15]
	jne	.L2946	#,
# ./include/linux/page-flags.h:184: 	unsigned long head = READ_ONCE(page->compound_head);
	call	__sanitizer_cov_trace_pc	#
	movq	8(%rbx), %rbp	#, _16
# ./include/linux/page-flags.h:186: 	if (unlikely(head & 1))
	testb	$1, %bpl	#, _16
	je	.L2947	#,
# ./include/linux/page-flags.h:187: 		return (struct page *) (head - 1);
	leaq	-1(%rbp), %rbx	#, page
	call	__sanitizer_cov_trace_pc	#
.L2947:
# ./include/linux/page-flags.h:338: PAGEFLAG(Active, active, PF_HEAD) __CLEARPAGEFLAG(Active, active, PF_HEAD)
	call	__sanitizer_cov_trace_pc	#
	movq	$.LC20, %rsi	#,
	movq	%rbx, %rdi	# page,
	call	dump_page	#
#APP
# 338 "./include/linux/page-flags.h" 1
	373: nop	#
	.pushsection .discard.instr_begin
	.long 373b - .	#
	.popsection
	
# 0 "" 2
# 338 "./include/linux/page-flags.h" 1
	1:	.byte 0x0f, 0x0b
.pushsection __bug_table,"aw"
2:	.long 1b - 2b	# bug_entry::bug_addr
	.long .LC3 - 2b	# bug_entry::file	#
	.word 338	# bug_entry::line	#
	.word 0	# bug_entry::flags	#
	.org 2b+12	#
.popsection
# 0 "" 2
# 338 "./include/linux/page-flags.h" 1
	374:	#
	.pushsection .discard.unreachable
	.long 374b - .	#
	.popsection
	
# 0 "" 2
#NO_APP
.L2946:
# ./include/linux/page-flags.h:184: 	unsigned long head = READ_ONCE(page->compound_head);
	call	__sanitizer_cov_trace_pc	#
	movq	8(%rbx), %rbp	#, _28
# ./include/linux/page-flags.h:186: 	if (unlikely(head & 1))
	testb	$1, %bpl	#, _28
	je	.L2948	#,
# ./include/linux/page-flags.h:187: 		return (struct page *) (head - 1);
	leaq	-1(%rbp), %rbx	#, page
	call	__sanitizer_cov_trace_pc	#
.L2948:
# ./arch/x86/include/asm/bitops.h:207: 		(addr[nr >> _BITOPS_LONG_SHIFT])) != 0;
	call	__sanitizer_cov_trace_pc	#
	movq	(%rbx), %rax	# MEM[(const long unsigned int *)_35], _24
# mm/swap.c:1158: }
	popq	%rbx	#
	popq	%rbp	#
# ./arch/x86/include/asm/bitops.h:207: 		(addr[nr >> _BITOPS_LONG_SHIFT])) != 0;
	shrq	$5, %rax	#, tmp107
# ./include/linux/page-flags.h:338: PAGEFLAG(Active, active, PF_HEAD) __CLEARPAGEFLAG(Active, active, PF_HEAD)
	andl	$1, %eax	#, tmp106
# mm/swap.c:1158: }
	popq	%r12	#
	ret

