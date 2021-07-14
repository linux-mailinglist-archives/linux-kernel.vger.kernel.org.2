Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 64E4E3C7FC8
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Jul 2021 10:09:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238418AbhGNIM3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 14 Jul 2021 04:12:29 -0400
Received: from mga06.intel.com ([134.134.136.31]:51698 "EHLO mga06.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S238378AbhGNIM3 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Jul 2021 04:12:29 -0400
X-IronPort-AV: E=McAfee;i="6200,9189,10044"; a="271418213"
X-IronPort-AV: E=Sophos;i="5.84,238,1620716400"; 
   d="scan'208";a="271418213"
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Jul 2021 01:09:36 -0700
X-IronPort-AV: E=Sophos;i="5.84,238,1620716400"; 
   d="scan'208";a="428015671"
Received: from iweiny-desk2.sc.intel.com (HELO localhost) ([10.3.52.147])
  by fmsmga007-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Jul 2021 01:09:36 -0700
Date:   Wed, 14 Jul 2021 01:09:35 -0700
From:   Ira Weiny <ira.weiny@intel.com>
To:     Christoph Hellwig <hch@lst.de>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org
Subject: Re: [PATCH 1/2] mm: call flush_dcache_page in memcpy_to_page and
 memzero_page
Message-ID: <20210714080935.GK3169279@iweiny-DESK2.sc.intel.com>
References: <20210713055231.137602-1-hch@lst.de>
 <20210713055231.137602-2-hch@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210713055231.137602-2-hch@lst.de>
User-Agent: Mutt/1.11.1 (2018-12-01)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jul 13, 2021 at 07:52:30AM +0200, Christoph Hellwig wrote:
> memcpy_to_page and memzero_page can write to arbitrary pages, which could
> be in the page cache or in high memory, so  call flush_kernel_dcache_pages
> to flush the dcache.
> 
> Fixes: bb90d4bc7b6a ("mm/highmem: Lift memcpy_[to|from]_page to core")
> Fixes: 28961998f858 ("iov_iter: lift memzero_page() to highmem.h")
> Signed-off-by: Christoph Hellwig <hch@lst.de>

Reviewed-by: Ira Weiny <ira.weiny@intel.com>

> ---
>  include/linux/highmem.h | 2 ++
>  1 file changed, 2 insertions(+)
> 
> diff --git a/include/linux/highmem.h b/include/linux/highmem.h
> index 8c6e8e996c87..8e7e50a53a12 100644
> --- a/include/linux/highmem.h
> +++ b/include/linux/highmem.h
> @@ -318,6 +318,7 @@ static inline void memcpy_to_page(struct page *page, size_t offset,
>  
>  	VM_BUG_ON(offset + len > PAGE_SIZE);
>  	memcpy(to + offset, from, len);
> +	flush_dcache_page(page);
>  	kunmap_local(to);
>  }
>  
> @@ -325,6 +326,7 @@ static inline void memzero_page(struct page *page, size_t offset, size_t len)
>  {
>  	char *addr = kmap_atomic(page);
>  	memset(addr + offset, 0, len);
> +	flush_dcache_page(page);
>  	kunmap_atomic(addr);
>  }
>  
> -- 
> 2.30.2
> 
