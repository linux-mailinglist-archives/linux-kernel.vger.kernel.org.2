Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 44DBE3246EE
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Feb 2021 23:36:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235384AbhBXWfG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 24 Feb 2021 17:35:06 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46806 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235369AbhBXWfC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Feb 2021 17:35:02 -0500
Received: from mail-io1-xd2e.google.com (mail-io1-xd2e.google.com [IPv6:2607:f8b0:4864:20::d2e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 67536C06174A
        for <linux-kernel@vger.kernel.org>; Wed, 24 Feb 2021 14:34:22 -0800 (PST)
Received: by mail-io1-xd2e.google.com with SMTP id f20so3772626ioo.10
        for <linux-kernel@vger.kernel.org>; Wed, 24 Feb 2021 14:34:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=WSWBBcjYFi0hfo1Z1QPhxz025L1ipn8jdLorTz3xJUI=;
        b=jhpagXe+CnvkWw7sxotZ453wT+QEen7ETBWimDdvjTaLN8p/KMv7zHq4ABpLvDFg6w
         v9O7MS+TZAdVmeggtaQYMaxQEOlYD7H2PuIQ4IwIx4SHjMQx9f7j9bCKOzC6qCeZgvlp
         joa0+C2bJZMQvafQfGN0UkiXAVn2mOX53b7yZgqAM5LdpbukkBhqZKbHPaTRl1WN7dL0
         DsN9TdICYB3WP3fsADU7rm8mMcAalYM2+irXiDXqRnsk0qImWupz+UFkGZ3huNmZufmS
         WkZTzLjNChxcj/AxYpbA2lCzy62juitRdIRLp32s/OHRus0GLoGGLNco3vrzIRGundgf
         N+qQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=WSWBBcjYFi0hfo1Z1QPhxz025L1ipn8jdLorTz3xJUI=;
        b=k4afYzu7WtiLcm0RRij6WvvE/217QK2DP8aWL0iWra4mFRX+NyO2i9pyxR5GSg5U4q
         0O0XF4m0IOPcpwhX8XpJa1nMGn61xAHbZWYL8T6GbrO0ypq4fb89JiCs7UiDdjdAUqEd
         hm0+5ojhENyDCq8yVVD+DV2ePyVSkWifGqXa8szmJ24nfDA1fXAfe+BI7zUWvjoyOV4N
         TC4JTq0R0EiPbj0lNjrGv618oc2SacECGAJ+d24fOG5SYD0M+QGPqS0phRXUIKLd3/n6
         rVa3dXB5CuW9+b18wFzlwQalDFyq7IpmnF8CvjysS3kCc1/nSJvgvKV1HdsiNSYpfSa8
         5oGg==
X-Gm-Message-State: AOAM533UzrL4jx9ocQkzKSqTSTmtcUpY9ku3tg75ZPu/Qw9uPP1eiSZY
        PT9Zar47labp6m5qqiPHcXkmXA==
X-Google-Smtp-Source: ABdhPJw8Qo4fdGjdNPedsbAvcjrwb64jJnYucF2Vh2Hiknr/398zQsFsP7krs75NpPBSgIua6w+fNA==
X-Received: by 2002:a6b:4f0c:: with SMTP id d12mr60709iob.141.1614206061632;
        Wed, 24 Feb 2021 14:34:21 -0800 (PST)
Received: from google.com ([2620:15c:183:200:c037:ba21:bf5e:4d1f])
        by smtp.gmail.com with ESMTPSA id 128sm2722590iov.1.2021.02.24.14.34.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 24 Feb 2021 14:34:21 -0800 (PST)
Date:   Wed, 24 Feb 2021 15:34:16 -0700
From:   Yu Zhao <yuzhao@google.com>
To:     Matthew Wilcox <willy@infradead.org>
Cc:     Andrew Morton <akpm@linux-foundation.org>, vbabka@suse.cz,
        alex.shi@linux.alibaba.com, guro@fb.com, hannes@cmpxchg.org,
        hughd@google.com, linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        mhocko@kernel.org, vdavydov.dev@gmail.com
Subject: Re: [PATCH] mm: test page->flags directly in page_lru()
Message-ID: <YDbUaJ0j2YisyyuK@google.com>
References: <20210122220600.906146-11-yuzhao@google.com>
 <20210224084807.2179942-1-yuzhao@google.com>
 <20210224051558.79e31c60eea2c088f4a1b300@linux-foundation.org>
 <20210224215639.GT2858050@casper.infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <20210224215639.GT2858050@casper.infradead.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Feb 24, 2021 at 09:56:39PM +0000, Matthew Wilcox wrote:
> On Wed, Feb 24, 2021 at 05:15:58AM -0800, Andrew Morton wrote:
> > Here's what the preprocessor produces for an allmodconfig version of
> > PageActive():
> >=20
> > static inline __attribute__((__gnu_inline__)) __attribute__((__unused__=
)) __attribute__((no_instrument_function)) __attribute__((__always_inline__=
)) int PageActive(struct page *page)
> > {
> > 	return test_bit(PG_active, &({ do { if (__builtin_expect(!!(PagePoison=
ed(compound_head(page))), 0)) { dump_page(compound_head(page), "VM_BUG_ON_P=
AGE(" "PagePoisoned(compound_head(page))"")"); do { ({ asm volatile("%c0: n=
op\n\t" ".pushsection .discard.instr_begin\n\t" ".long %c0b - .\n\t" ".pops=
ection\n\t" : : "i" (373)); }); do { asm volatile("1:\t" ".byte 0x0f, 0x0b"=
 "\n" ".pushsection __bug_table,\"aw\"\n" "2:\t" ".long " "1b" " - 2b" "\t#=
 bug_entry::bug_addr\n" "\t" ".long " "%c0" " - 2b" "\t# bug_entry::file\n"=
 "\t.word %c1" "\t# bug_entry::line\n" "\t.word %c2" "\t# bug_entry::flags\=
n" "\t.org 2b+%c3\n" ".popsection" : : "i" ("./include/linux/page-flags.h")=
, "i" (338), "i" (0), "i" (sizeof(struct bug_entry))); } while (0); do { ({=
 asm volatile("%c0:\n\t" ".pushsection .discard.unreachable\n\t" ".long %c0=
b - .\n\t" ".popsection\n\t" : : "i" (374)); }); asm volatile(""); __builti=
n_unreachable(); } while (0); } while (0); } } while (0); compound_head(pag=
e); })->flags);
> >=20
> > }
> >=20
> > That's all to test a single bit!
> >=20
> > Four calls to compound_head().
>=20
> If only somebody were working on a patch series to get rid of
> all those calls to compound_head()!  Some reviews on
> https://lore.kernel.org/linux-mm/20210128070404.1922318-2-willy@infradead=
=2Eorg/
> would be nice.

I'm on board with the idea and have done some research in this
direction. We've found that the ideal *anon* page size for Chrome OS
is not 4KB or 2MB, but 32KB. I hope we could leverage the folio to
support flexible anon page size to reduce the number of page faults
(vs 4KB) or internal fragmentation (vs 2MB).

That being said, it seems to me this is a long term plan and right
now we need something smaller. So if you don't mind, I'll just go
ahead and remove compound_head() from Page{LRU,Active,Unevictable,
SwapBacked} first?

> So, I haven't done page_lru() yet in my folio tree.  What I would do is:
>=20
> diff --git a/include/linux/mm_inline.h b/include/linux/mm_inline.h
> index 355ea1ee32bd..3895cfe6502b 100644
> --- a/include/linux/mm_inline.h
> +++ b/include/linux/mm_inline.h
> @@ -63,22 +63,27 @@ static __always_inline void __clear_page_lru_flags(st=
ruct page *page)
>   * Returns the LRU list a page should be on, as an index
>   * into the array of LRU lists.
>   */
> -static __always_inline enum lru_list page_lru(struct page *page)
> +static __always_inline enum lru_list folio_lru(struct folio *folio)
>  {
>  	enum lru_list lru;
> =20
> -	VM_BUG_ON_PAGE(PageActive(page) && PageUnevictable(page), page);
> +	VM_BUG_ON_PAGE(FolioActive(folio) && FolioUnevictable(folio), folio);
> =20
> -	if (PageUnevictable(page))
> +	if (FolioUnevictable(folio))
>  		return LRU_UNEVICTABLE;
> =20
> -	lru =3D page_is_file_lru(page) ? LRU_INACTIVE_FILE : LRU_INACTIVE_ANON;
> -	if (PageActive(page))
> +	lru =3D page_is_file_lru(&folio->page) ? LRU_INACTIVE_FILE : LRU_INACTI=
VE_ANON;
> +	if (FolioActive(folio))
>  		lru +=3D LRU_ACTIVE;
> =20
>  	return lru;
>  }
> =20
> +static __always_inline enum lru_list page_lru(struct page *page)
> +{
> +	return folio_lru(page_folio(page));
> +}
> +
>  static __always_inline void add_page_to_lru_list(struct page *page,
>  				struct lruvec *lruvec)
>  {
>=20
> That would cause compound_head() to be called once instead of four times
> (assuming VM_BUG_ON is enabled).  It can be reduced down to zero times
> when the callers are converted from being page-based to being folio-based.
>=20
> There is a further problem with PageFoo() being a READ_ONCE()
> of page->flags, so the compiler can't CSE it.  I have ideas in that
> direction too; essentially ...
>=20
> 	unsigned long page_flags =3D PageFlags(page);
>=20
> 	if (PageFlagUnevictable(flags))
> ...
> 	if (PageFlagsActive(flags))
> ...
>=20
> and we can generate the PageFlagsFoo macros with the same machinery in
> page-flags.h that generates PageFoo and FolioFoo.  This strikes me as
> less critical than the folio work to remove all the unnecessary calls
> to compound_head().
>=20
> > 	movq	%rbx, %rbp	# page, _14
> > # ./include/linux/page-flags.h:184: 	unsigned long head =3D READ_ONCE(p=
age->compound_head);
> > 	call	__sanitizer_cov_trace_pc	#
>=20
> It's a bit unfair to complain about code generation with a
> sanitizer-enabled build ...
>=20
