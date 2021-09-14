Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4AB7840ABEE
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Sep 2021 12:43:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231938AbhINKoe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 14 Sep 2021 06:44:34 -0400
Received: from mga18.intel.com ([134.134.136.126]:50765 "EHLO mga18.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231945AbhINKoY (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Sep 2021 06:44:24 -0400
X-IronPort-AV: E=McAfee;i="6200,9189,10106"; a="209049820"
X-IronPort-AV: E=Sophos;i="5.85,292,1624345200"; 
   d="scan'208";a="209049820"
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Sep 2021 03:43:06 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.85,292,1624345200"; 
   d="scan'208";a="528733499"
Received: from black.fi.intel.com ([10.237.72.28])
  by fmsmga004.fm.intel.com with ESMTP; 14 Sep 2021 03:43:04 -0700
Received: by black.fi.intel.com (Postfix, from userid 1000)
        id 948D9FF; Tue, 14 Sep 2021 13:43:08 +0300 (EEST)
Date:   Tue, 14 Sep 2021 13:43:08 +0300
From:   "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>
To:     Marco Elver <elver@google.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>, linux-mm@kvack.org,
        Will Deacon <will@kernel.org>, linux-kernel@vger.kernel.org,
        kasan-dev@googlegroups.com,
        kernel test robot <oliver.sang@intel.com>
Subject: Re: [PATCH] mm: fix data race in PagePoisoned()
Message-ID: <20210914104308.hi55o2f4jfxpmswg@black.fi.intel.com>
References: <20210913113542.2658064-1-elver@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210913113542.2658064-1-elver@google.com>
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

Acked-by: Kirill A. Shutemov <kirill.shutemov@linux.intel.com>

-- 
 Kirill A. Shutemov
