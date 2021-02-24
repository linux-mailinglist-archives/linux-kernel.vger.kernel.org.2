Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A2D063244D2
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Feb 2021 21:01:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235211AbhBXT7u (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 24 Feb 2021 14:59:50 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40566 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234908AbhBXT57 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Feb 2021 14:57:59 -0500
Received: from mail-io1-xd2f.google.com (mail-io1-xd2f.google.com [IPv6:2607:f8b0:4864:20::d2f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A5E05C061226
        for <linux-kernel@vger.kernel.org>; Wed, 24 Feb 2021 11:57:35 -0800 (PST)
Received: by mail-io1-xd2f.google.com with SMTP id i8so3333169iog.7
        for <linux-kernel@vger.kernel.org>; Wed, 24 Feb 2021 11:57:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=cj7xDSZ4OTBDVNHg9eGtF0yROH2tLiemgjZrH2v3a8A=;
        b=KSb/YQBNQQlfZra6JphLhn/QFG01xyt5irxBKdXEWBhIpTfweqCiZ5mt8D2I9j4zk8
         /Yx5h3tx2UpBnI2bUm/TAHZntsa5oJhwotG1hLumo+wzyDYV9kYw+a3SLNdsjknlNNvz
         2pGLY6SN0fESLjsPeJSkdLF/JjN5uZiL7IouBxEWPn2t6F33k2KKP8fI/Ccjnvxkg6KI
         FbiQ4rKrm6rJTZT1z3+oudOVOcBpFUaHfdXUq5ktR5zTRISMoRBDPlFVNfnjgvXsZAgg
         /jMwGTvTTv51w1w6f9uew0g+5cRy5jlaHExtMk77cGUzH5VqkR8Kg0VeOrds6/Zed8hi
         edAQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=cj7xDSZ4OTBDVNHg9eGtF0yROH2tLiemgjZrH2v3a8A=;
        b=Yi/tetV0b35YFaJDm5hCu8TxiK+mlWvWG8B9XMj8xY3OFKjYKKvqM+njRxd7zOwsD2
         Kmba9Jo5r0kq/i02/T6DAPfP50kmNhNKC7eM9wDSv8Wcn+bY1SbQ2hfgcY6SItT/Z4ts
         6PzeAVco9gSd7Wb5AkkqJgJrZcYRuhaiRTkHZYcpiZ4bcbAnoctDZ+LfXgNAtG0XuBNn
         fW3AztnF3uAe28Myz1sRLMK5ajMQx+sciQ9IMm+bcAUMJocUDR/79NebyEy44AwEMxt5
         ecbD6NlfV4TWfDjUL2kPirab6Bqc6f5rTNeJ3OlS6MBsPNQ9FLZB7oAODpAdtiI9gcLi
         ZI6A==
X-Gm-Message-State: AOAM533nuYiplydlR4bjSRu2e2VwUtIN1b0LvfAVeg2/bUuDTR9/MGn/
        nywxa69eX/u8S43oOuE6Jf6LlQ==
X-Google-Smtp-Source: ABdhPJyi7lqcgiHzW2kZ8FF2RxD1OfTb46EGL8vRBVPC9YK99Y83oswhhe8cwDrBDhtUa6wo7KK5RA==
X-Received: by 2002:a02:6589:: with SMTP id u131mr34640893jab.21.1614196654877;
        Wed, 24 Feb 2021 11:57:34 -0800 (PST)
Received: from google.com ([2620:15c:183:200:c037:ba21:bf5e:4d1f])
        by smtp.gmail.com with ESMTPSA id c7sm2006439ild.65.2021.02.24.11.57.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 24 Feb 2021 11:57:34 -0800 (PST)
Date:   Wed, 24 Feb 2021 12:57:29 -0700
From:   Yu Zhao <yuzhao@google.com>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     vbabka@suse.cz, alex.shi@linux.alibaba.com, guro@fb.com,
        hannes@cmpxchg.org, hughd@google.com, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, mhocko@kernel.org, vdavydov.dev@gmail.com,
        willy@infradead.org
Subject: Re: [PATCH] mm: test page->flags directly in page_lru()
Message-ID: <YDavqVVajik8Z+SR@google.com>
References: <20210122220600.906146-11-yuzhao@google.com>
 <20210224084807.2179942-1-yuzhao@google.com>
 <20210224051558.79e31c60eea2c088f4a1b300@linux-foundation.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210224051558.79e31c60eea2c088f4a1b300@linux-foundation.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Feb 24, 2021 at 05:15:58AM -0800, Andrew Morton wrote:
> On Wed, 24 Feb 2021 01:48:07 -0700 Yu Zhao <yuzhao@google.com> wrote:
> 
> > Currently page_lru() uses Page{Active,Unevictable} to determine which
> > lru list a page belongs to. Page{Active,Unevictable} contain
> > compound_head() and therefore page_lru() essentially tests
> > PG_{active,unevictable} against compound_head(page)->flags. Once an
> > lru list is determined, page->lru, rather than
> > compound_head(page)->lru, will be added to or deleted from it.
> > 
> > Though not bug, having compound_head() in page_lru() increases the
> > size of vmlinux by O(KB) because page_lru() is inlined many places.
> > And removing compound_head() entirely from Page{Active,Unevictable}
> > may not be the best option (for the moment) either because there
> > may be other cases that need compound_head(). This patch makes
> > page_lru() and __clear_page_lru_flags(), which are used immediately
> > before and after operations on page->lru, test
> > PG_{active,unevictable} directly against page->flags instead.
> 
> Oh geeze.
> 
> > --- a/include/linux/mm_inline.h
> > +++ b/include/linux/mm_inline.h
> > @@ -46,14 +46,12 @@ static __always_inline void __clear_page_lru_flags(struct page *page)
> >  {
> >  	VM_BUG_ON_PAGE(!PageLRU(page), page);
> >  
> > -	__ClearPageLRU(page);
> > -
> >  	/* this shouldn't happen, so leave the flags to bad_page() */
> > -	if (PageActive(page) && PageUnevictable(page))
> > +	if ((page->flags & (BIT(PG_active) | BIT(PG_unevictable))) ==
> > +	    (BIT(PG_active) | BIT(PG_unevictable)))
> >  		return;
> 
> This isn't very nice.  At the very least we should have (documented!)
> helper functions for this:

You are right. Now when I look at this, I s/dislike/hate/ it.

> /* comment goes here */
> static inline bool RawPageActive(struct page *page)
> {
> 	...
> }
> 
> 
> 
> However.
> 
> Here's what the preprocessor produces for an allmodconfig version of
> PageActive():
> 
> static inline __attribute__((__gnu_inline__)) __attribute__((__unused__)) __attribute__((no_instrument_function)) __attribute__((__always_inline__)) int PageActive(struct page *page)
> {
> 	return test_bit(PG_active, &({ do { if (__builtin_expect(!!(PagePoisoned(compound_head(page))), 0)) { dump_page(compound_head(page), "VM_BUG_ON_PAGE(" "PagePoisoned(compound_head(page))"")"); do { ({ asm volatile("%c0: nop\n\t" ".pushsection .discard.instr_begin\n\t" ".long %c0b - .\n\t" ".popsection\n\t" : : "i" (373)); }); do { asm volatile("1:\t" ".byte 0x0f, 0x0b" "\n" ".pushsection __bug_table,\"aw\"\n" "2:\t" ".long " "1b" " - 2b" "\t# bug_entry::bug_addr\n" "\t" ".long " "%c0" " - 2b" "\t# bug_entry::file\n" "\t.word %c1" "\t# bug_entry::line\n" "\t.word %c2" "\t# bug_entry::flags\n" "\t.org 2b+%c3\n" ".popsection" : : "i" ("./include/linux/page-flags.h"), "i" (338), "i" (0), "i" (sizeof(struct bug_entry))); } while (0); do { ({ asm volatile("%c0:\n\t" ".pushsection .discard.unreachable\n\t" ".long %c0b - .\n\t" ".popsection\n\t" : : "i" (374)); }); asm volatile(""); __builtin_unreachable(); } while (0); } while (0); } } while (0); compound_head(page); })->flags);
> 
> }
> 
> That's all to test a single bit!

I hear you. Let me spend a couple of days and focus on PG_{lru,active,
unevictable,swapbacked} first. They are mostly used with lru-related
operations and therefore can be switched to a compound_head()-free
policy easily. My estimate is we could save ~8KB by doing so :)

Weaning off compound_head() completely is a larger commitment neither
I or Alex are willing to make at the moment -- I did suggest this to
him last night when I asked him to help test build with GCC, which is
their default compiler (we've switched to Clang).

Another good point he has raised is they did see a slowdown on ARM64
after compound_head() was first introduced. My point is there may be
measurable performance benefit too if we could get rid of those
excessive calls to compound_head(). And I'd be happy to work with
somebody if they are interested in doing this.

Fair?

> Four calls to compound_head().
> 
> Compiling this:
> 
> int wibble(struct page *page)
> {
> 	return PageActive(page);
> }
> 
> 
> to the below assembly output (allmodconfig build) and it appears that
> the compiler did not CSE these calls.  Perhaps it would be beneficial
> to give it a bit of help.

Another interesting thing I've noticed is the following change from
patch 10 also makes vmlinux a couple of hundreds bytes larger with
my GCC 4.9.x.

-unsigned long lruvec_lru_size(struct lruvec *lruvec, enum lru_list lru, int zone_idx)
+static unsigned long lruvec_lru_size(struct lruvec *lruvec, enum lru_list lru,
+				     int zone_idx)

> This is all nuts.  How much of this inlining is really justifiable?  Do
> we know we wouldn't get a better kernel if we did
> 
> 	mv mm-inline.h mm-not-inline-any-more.c
> 
> ?
> 
> Methinks that mm-inline.c needs some serious work...

Agreed. I'll send another series of patches on top of the lru cleanup
series this week.

> 	.type	wibble, @function
> wibble:
> 1:	call	__fentry__
> 	.section __mcount_loc, "a",@progbits
> 	.quad 1b
> 	.previous
> 	pushq	%r12	#
> 	pushq	%rbp	#
> 	pushq	%rbx	#
> # mm/swap.c:1156: {
> 	movq	%rdi, %rbx	# page, page
> 	movq	%rbx, %rbp	# page, _14
> # ./include/linux/page-flags.h:184: 	unsigned long head = READ_ONCE(page->compound_head);
> 	call	__sanitizer_cov_trace_pc	#
> 	movq	8(%rbx), %r12	# page_2(D)->D.14210.D.14188.compound_head, _8
> # ./include/linux/page-flags.h:186: 	if (unlikely(head & 1))
> 	testb	$1, %r12b	#, _8
> 	je	.L2945	#,
> # ./include/linux/page-flags.h:187: 		return (struct page *) (head - 1);
> 	call	__sanitizer_cov_trace_pc	#
> 	leaq	-1(%r12), %rbp	#, _14
> 	jmp	.L2945	#
> .L2945:
> 	call	__sanitizer_cov_trace_pc	#
> # ./include/linux/page-flags.h:338: PAGEFLAG(Active, active, PF_HEAD) __CLEARPAGEFLAG(Active, active, PF_HEAD)
> 	cmpq	$-1, 0(%rbp)	#, MEM[(long unsigned int *)_15]
> 	jne	.L2946	#,
> # ./include/linux/page-flags.h:184: 	unsigned long head = READ_ONCE(page->compound_head);
> 	call	__sanitizer_cov_trace_pc	#
> 	movq	8(%rbx), %rbp	#, _16
> # ./include/linux/page-flags.h:186: 	if (unlikely(head & 1))
> 	testb	$1, %bpl	#, _16
> 	je	.L2947	#,
> # ./include/linux/page-flags.h:187: 		return (struct page *) (head - 1);
> 	leaq	-1(%rbp), %rbx	#, page
> 	call	__sanitizer_cov_trace_pc	#
> .L2947:
> # ./include/linux/page-flags.h:338: PAGEFLAG(Active, active, PF_HEAD) __CLEARPAGEFLAG(Active, active, PF_HEAD)
> 	call	__sanitizer_cov_trace_pc	#
> 	movq	$.LC20, %rsi	#,
> 	movq	%rbx, %rdi	# page,
> 	call	dump_page	#
> #APP
> # 338 "./include/linux/page-flags.h" 1
> 	373: nop	#
> 	.pushsection .discard.instr_begin
> 	.long 373b - .	#
> 	.popsection
> 	
> # 0 "" 2
> # 338 "./include/linux/page-flags.h" 1
> 	1:	.byte 0x0f, 0x0b
> .pushsection __bug_table,"aw"
> 2:	.long 1b - 2b	# bug_entry::bug_addr
> 	.long .LC3 - 2b	# bug_entry::file	#
> 	.word 338	# bug_entry::line	#
> 	.word 0	# bug_entry::flags	#
> 	.org 2b+12	#
> .popsection
> # 0 "" 2
> # 338 "./include/linux/page-flags.h" 1
> 	374:	#
> 	.pushsection .discard.unreachable
> 	.long 374b - .	#
> 	.popsection
> 	
> # 0 "" 2
> #NO_APP
> .L2946:
> # ./include/linux/page-flags.h:184: 	unsigned long head = READ_ONCE(page->compound_head);
> 	call	__sanitizer_cov_trace_pc	#
> 	movq	8(%rbx), %rbp	#, _28
> # ./include/linux/page-flags.h:186: 	if (unlikely(head & 1))
> 	testb	$1, %bpl	#, _28
> 	je	.L2948	#,
> # ./include/linux/page-flags.h:187: 		return (struct page *) (head - 1);
> 	leaq	-1(%rbp), %rbx	#, page
> 	call	__sanitizer_cov_trace_pc	#
> .L2948:
> # ./arch/x86/include/asm/bitops.h:207: 		(addr[nr >> _BITOPS_LONG_SHIFT])) != 0;
> 	call	__sanitizer_cov_trace_pc	#
> 	movq	(%rbx), %rax	# MEM[(const long unsigned int *)_35], _24
> # mm/swap.c:1158: }
> 	popq	%rbx	#
> 	popq	%rbp	#
> # ./arch/x86/include/asm/bitops.h:207: 		(addr[nr >> _BITOPS_LONG_SHIFT])) != 0;
> 	shrq	$5, %rax	#, tmp107
> # ./include/linux/page-flags.h:338: PAGEFLAG(Active, active, PF_HEAD) __CLEARPAGEFLAG(Active, active, PF_HEAD)
> 	andl	$1, %eax	#, tmp106
> # mm/swap.c:1158: }
> 	popq	%r12	#
> 	ret
> 
