Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 36A7D4421E0
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Nov 2021 21:46:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231138AbhKAUtY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 1 Nov 2021 16:49:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57278 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229896AbhKAUtX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Nov 2021 16:49:23 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A9975C061714
        for <linux-kernel@vger.kernel.org>; Mon,  1 Nov 2021 13:46:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=ryZuy65dlIe4cvCN4a2FYofG6Kwun01n04uoix87XZ0=; b=HnN7OHfFI7zr8D01JpCXHxZKGP
        7M5+QmccwelXqHNuzrv3e93vvEYZLAp54na89ZXpM8v0aQB7eb5S3R21ZqAqZiSOpKygoILyHlQ1X
        TcdIOWmJoHzY+kCtoAHChAg65yIS5mgwtfp4flTcaIoybA5yXrYKxGsMUDMde1olCLU++OcW4HL/6
        x/YpvavbJm3h3JXzbusgP4mHr9Jp/d4Nr8jMt6GxKX1VSGvCC1SKn3DI0Yv5kkcbyrrTVJPKBH79z
        daxWwGDIiVJPWpP/28Rnx2wS8ZoFXPsRZOOoF6ShRLd3IRvjYByIh7i1ydyt/XS9rZ1ot2+gSxTbN
        IvlFbHlA==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1mhe9Y-0040Vl-G5; Mon, 01 Nov 2021 20:43:57 +0000
Date:   Mon, 1 Nov 2021 20:43:36 +0000
From:   Matthew Wilcox <willy@infradead.org>
To:     Yang Shi <shy828301@gmail.com>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        naresh.kamboju@linaro.org, kirill.shutemov@linux.intel.com,
        naoya.horiguchi@nec.com, akpm@linux-foundation.org,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] mm: page-flags: fix build failure due to missing
 parameter for HasHWPoisoned flag
Message-ID: <YYBRePv3w9cfCpHC@casper.infradead.org>
References: <20211101194336.305546-1-shy828301@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211101194336.305546-1-shy828301@gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Should probbaly cc Linus, and also note that Stephen noticed & fixed
this problem already.
https://lore.kernel.org/lkml/20211101174846.2b1097d7@canb.auug.org.au/

I didn't know about it at the time I sent the pull request because it
hadn't been merged at that point.

On Mon, Nov 01, 2021 at 12:43:36PM -0700, Yang Shi wrote:
> The below build failure when !CONFIG_MEMORY_FAILURE was reported for
> v5.16 merge window:
> In file included from include/linux/mmzone.h:22,
>                  from include/linux/gfp.h:6,
>                  from include/linux/slab.h:15,
>                  from include/linux/crypto.h:20,
>                  from arch/x86/kernel/asm-offsets.c:9:
> include/linux/page-flags.h:806:29: error: macro "PAGEFLAG_FALSE"
> requires 2 arguments, but only 1 given
>   806 | PAGEFLAG_FALSE(HasHWPoisoned)
>       |                             ^
> include/linux/page-flags.h:411: note: macro "PAGEFLAG_FALSE" defined here
>   411 | #define PAGEFLAG_FALSE(uname, lname) TESTPAGEFLAG_FALSE(uname, lname)   \
>       |
> include/linux/page-flags.h:807:39: error: macro "TESTSCFLAG_FALSE"
> requires 2 arguments, but only 1 given
>   807 |         TESTSCFLAG_FALSE(HasHWPoisoned)
>       |                                       ^
> include/linux/page-flags.h:414: note: macro "TESTSCFLAG_FALSE" defined here
>   414 | #define TESTSCFLAG_FALSE(uname, lname)
>          \
>       |
> include/linux/page-flags.h:806:1: error: unknown type name 'PAGEFLAG_FALSE'
>   806 | PAGEFLAG_FALSE(HasHWPoisoned)
>       | ^~~~~~~~~~~~~~
> include/linux/page-flags.h:807:25: error: expected ';' before 'static'
>   807 |         TESTSCFLAG_FALSE(HasHWPoisoned)
>       |                         ^
>       |                         ;
> ......
>   815 | static inline bool is_page_hwpoison(struct page *page)
>       | ~~~~~~
> make[2]: *** [scripts/Makefile.build:121: arch/x86/kernel/asm-offsets.s] Error 1
> 
> The commit d389a4a81155 ("mm: Add folio flag manipulation functions")
> changed the definition of PAGEFLAG macros, this caused the build failure
> for HasHWPoisoned flag.  The new flag was introduced by commit
> eac96c3efdb5 ("mm: filemap: check if THP has hwpoisoned subpage for PMD
> page fault") in v5.15-rc7.  But the folio series pull request was
> prepared before v5.15, so this new flag was missed.
> 
> Reported-by: Linux Kernel Functional Testing <lkft@linaro.org>
> Cc: Naresh Kamboju <naresh.kamboju@linaro.org>
> Cc: Matthew Wilcox <willy@infradead.org>
> Cc: Kirill A. Shutemov <kirill.shutemov@linux.intel.com>
> Cc: Naoya Horiguchi <naoya.horiguchi@nec.com>
> Signed-off-by: Yang Shi <shy828301@gmail.com>
> ---
>  include/linux/page-flags.h | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/include/linux/page-flags.h b/include/linux/page-flags.h
> index d8623d6e1141..981341a3c3c4 100644
> --- a/include/linux/page-flags.h
> +++ b/include/linux/page-flags.h
> @@ -803,8 +803,8 @@ PAGEFLAG_FALSE(DoubleMap, double_map)
>  PAGEFLAG(HasHWPoisoned, has_hwpoisoned, PF_SECOND)
>  	TESTSCFLAG(HasHWPoisoned, has_hwpoisoned, PF_SECOND)
>  #else
> -PAGEFLAG_FALSE(HasHWPoisoned)
> -	TESTSCFLAG_FALSE(HasHWPoisoned)
> +PAGEFLAG_FALSE(HasHWPoisoned, has_hwpoisoned)
> +	TESTSCFLAG_FALSE(HasHWPoisoned, has_hwpoisoned)
>  #endif
>  
>  /*
> -- 
> 2.26.2
> 
> 
