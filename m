Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8144940A93B
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Sep 2021 10:31:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230082AbhINIcz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 14 Sep 2021 04:32:55 -0400
Received: from mail.kernel.org ([198.145.29.99]:37014 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229458AbhINIcy (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Sep 2021 04:32:54 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 59D4860EE0;
        Tue, 14 Sep 2021 08:31:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1631608297;
        bh=oX/5ZZdm4wVN44TRFscoqvKnha+6+V0peernKrQWcE4=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Ie7BWsEUv3r+l0ENRqwgNjhdGuC9pt94fhz0OuDHBqqnLw8nHJ/XdNbiDCkmZuKW2
         XJ4kGbGz2LWrEVYz5yVbCYxt4DYMs04PmldjuXQgYnj5F8v1xEJEc0pP4bsfI7Dagk
         WV+o8uIsv2Vujzx9hrjCANSGZVPc59sBKXwHcZJs5njm1qgriaxifGXLx7YalV1jwY
         Tugv6pIz6s5WBcdTd4ZaTC2Ds0c0CvSHSfFB3oQ1YO7jEWi3hriUJUe5YE0DXFTKpq
         IerDrBh0Zi39qu8OemUaq7/vHwc5l6gs3nSJtPRBXPZXkEPhxOoiGk0/8hJRcJVZzl
         A1ulA2DzhHvIQ==
Date:   Tue, 14 Sep 2021 09:31:32 +0100
From:   Will Deacon <will@kernel.org>
To:     Marco Elver <elver@google.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>, linux-mm@kvack.org,
        "Kirill A . Shutemov" <kirill.shutemov@linux.intel.com>,
        linux-kernel@vger.kernel.org, kasan-dev@googlegroups.com,
        kernel test robot <oliver.sang@intel.com>
Subject: Re: [PATCH] mm: fix data race in PagePoisoned()
Message-ID: <20210914083132.GA5891@willie-the-truck>
References: <20210913113542.2658064-1-elver@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210913113542.2658064-1-elver@google.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Sep 13, 2021 at 01:35:43PM +0200, Marco Elver wrote:
> PagePoisoned() accesses page->flags which can be updated concurrently:
> 
>   | BUG: KCSAN: data-race in next_uptodate_page / unlock_page
>   |
>   | write (marked) to 0xffffea00050f37c0 of 8 bytes by task 1872 on cpu 1:
>   |  instrument_atomic_write           include/linux/instrumented.h:87 [inline]
>   |  clear_bit_unlock_is_negative_byte include/asm-generic/bitops/instrumented-lock.h:74 [inline]
>   |  unlock_page+0x102/0x1b0           mm/filemap.c:1465
>   |  filemap_map_pages+0x6c6/0x890     mm/filemap.c:3057
>   |  ...
>   | read to 0xffffea00050f37c0 of 8 bytes by task 1873 on cpu 0:
>   |  PagePoisoned                   include/linux/page-flags.h:204 [inline]
>   |  PageReadahead                  include/linux/page-flags.h:382 [inline]
>   |  next_uptodate_page+0x456/0x830 mm/filemap.c:2975
>   |  ...
>   | CPU: 0 PID: 1873 Comm: systemd-udevd Not tainted 5.11.0-rc4-00001-gf9ce0be71d1f #1
> 
> To avoid the compiler tearing or otherwise optimizing the access, use
> READ_ONCE() to access flags.
> 
> Link: https://lore.kernel.org/all/20210826144157.GA26950@xsang-OptiPlex-9020/
> Reported-by: kernel test robot <oliver.sang@intel.com>
> Signed-off-by: Marco Elver <elver@google.com>
> Cc: Will Deacon <will@kernel.org>
> Cc: Kirill A. Shutemov <kirill.shutemov@linux.intel.com>
> ---
>  include/linux/page-flags.h | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/include/linux/page-flags.h b/include/linux/page-flags.h
> index a558d67ee86f..628ab237665e 100644
> --- a/include/linux/page-flags.h
> +++ b/include/linux/page-flags.h
> @@ -206,7 +206,7 @@ static __always_inline int PageCompound(struct page *page)
>  #define	PAGE_POISON_PATTERN	-1l
>  static inline int PagePoisoned(const struct page *page)
>  {
> -	return page->flags == PAGE_POISON_PATTERN;
> +	return READ_ONCE(page->flags) == PAGE_POISON_PATTERN;
>  }

Acked-by: Will Deacon <will@kernel.org>

Thanks for writing up the patch!

Will
