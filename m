Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3F029305A87
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Jan 2021 13:00:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237233AbhA0L7n (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 27 Jan 2021 06:59:43 -0500
Received: from mx2.suse.de ([195.135.220.15]:33416 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S237239AbhA0Ly0 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Jan 2021 06:54:26 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 684A9ACBA;
        Wed, 27 Jan 2021 11:53:44 +0000 (UTC)
Date:   Wed, 27 Jan 2021 12:53:41 +0100
From:   Oscar Salvador <osalvador@suse.de>
To:     David Hildenbrand <david@redhat.com>
Cc:     linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        linux-fbdev@vger.kernel.org, dri-devel@lists.freedesktop.org,
        Andrew Morton <akpm@linux-foundation.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>,
        Mike Rapoport <rppt@kernel.org>,
        Michal Hocko <mhocko@kernel.org>,
        Wei Yang <richard.weiyang@linux.alibaba.com>,
        "Gustavo A. R. Silva" <gustavoars@kernel.org>,
        Sam Ravnborg <sam@ravnborg.org>
Subject: Re: [PATCH v1 1/2] video: fbdev: acornfb: remove free_unused_pages()
Message-ID: <20210127115341.GB28728@linux>
References: <20210126182113.19892-1-david@redhat.com>
 <20210126182113.19892-2-david@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210126182113.19892-2-david@redhat.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jan 26, 2021 at 07:21:12PM +0100, David Hildenbrand wrote:
> This function is never used and it is one of the last remaining user of
> __free_reserved_page(). Let's just drop it.
> 
> Cc: Andrew Morton <akpm@linux-foundation.org>
> Cc: Thomas Gleixner <tglx@linutronix.de>
> Cc: "Peter Zijlstra (Intel)" <peterz@infradead.org>
> Cc: Mike Rapoport <rppt@kernel.org>
> Cc: Oscar Salvador <osalvador@suse.de>
> Cc: Michal Hocko <mhocko@kernel.org>
> Cc: Wei Yang <richard.weiyang@linux.alibaba.com>
> Cc: "Gustavo A. R. Silva" <gustavoars@kernel.org>
> Cc: Sam Ravnborg <sam@ravnborg.org>
> Signed-off-by: David Hildenbrand <david@redhat.com>

Reviewed-by: Oscar Salvador <osalvador@suse.de>

> ---
>  drivers/video/fbdev/acornfb.c | 34 ----------------------------------
>  1 file changed, 34 deletions(-)
> 
> diff --git a/drivers/video/fbdev/acornfb.c b/drivers/video/fbdev/acornfb.c
> index bcc92aecf666..1b72edc01cfb 100644
> --- a/drivers/video/fbdev/acornfb.c
> +++ b/drivers/video/fbdev/acornfb.c
> @@ -921,40 +921,6 @@ static int acornfb_detect_monitortype(void)
>  	return 4;
>  }
>  
> -/*
> - * This enables the unused memory to be freed on older Acorn machines.
> - * We are freeing memory on behalf of the architecture initialisation
> - * code here.
> - */
> -static inline void
> -free_unused_pages(unsigned int virtual_start, unsigned int virtual_end)
> -{
> -	int mb_freed = 0;
> -
> -	/*
> -	 * Align addresses
> -	 */
> -	virtual_start = PAGE_ALIGN(virtual_start);
> -	virtual_end = PAGE_ALIGN(virtual_end);
> -
> -	while (virtual_start < virtual_end) {
> -		struct page *page;
> -
> -		/*
> -		 * Clear page reserved bit,
> -		 * set count to 1, and free
> -		 * the page.
> -		 */
> -		page = virt_to_page(virtual_start);
> -		__free_reserved_page(page);
> -
> -		virtual_start += PAGE_SIZE;
> -		mb_freed += PAGE_SIZE / 1024;
> -	}
> -
> -	printk("acornfb: freed %dK memory\n", mb_freed);
> -}
> -
>  static int acornfb_probe(struct platform_device *dev)
>  {
>  	unsigned long size;
> -- 
> 2.29.2
> 

-- 
Oscar Salvador
SUSE L3
