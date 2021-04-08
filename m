Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 527AF358094
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Apr 2021 12:27:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230521AbhDHK1Z (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 8 Apr 2021 06:27:25 -0400
Received: from mx2.suse.de ([195.135.220.15]:37272 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230383AbhDHK1Y (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Apr 2021 06:27:24 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id DD145AF0C;
        Thu,  8 Apr 2021 10:27:11 +0000 (UTC)
Subject: Re: [PATCH v2] mm: page_poison: print page info when corruption is
 caught
To:     Sergei Trofimovich <slyfox@gentoo.org>,
        Andrew Morton <akpm@linux-foundation.org>
Cc:     linux-kernel@vger.kernel.org, linux-mm@kvack.org
References: <YG46walP8KBD1yG2@sf> <20210407230800.1086854-1-slyfox@gentoo.org>
From:   Vlastimil Babka <vbabka@suse.cz>
Message-ID: <b244fb4b-1fc2-1c24-1b02-a14508413097@suse.cz>
Date:   Thu, 8 Apr 2021 12:27:11 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.1
MIME-Version: 1.0
In-Reply-To: <20210407230800.1086854-1-slyfox@gentoo.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 4/8/21 1:08 AM, Sergei Trofimovich wrote:
> When page_poison detects page corruption it's useful to see who
> freed a page recently to have a guess where write-after-free
> corruption happens.
> 
> After this change corruption report has extra page data.
> Example report from real corruption (includes only page_pwner part):
> 
>     pagealloc: memory corruption
>     e00000014cd61d10: 11 00 00 00 00 00 00 00 30 1d d2 ff ff 0f 00 60  ........0......`
>     e00000014cd61d20: b0 1d d2 ff ff 0f 00 60 90 fe 1c 00 08 00 00 20  .......`.......
>     ...
>     CPU: 1 PID: 220402 Comm: cc1plus Not tainted 5.12.0-rc5-00107-g9720c6f59ecf #245
>     Hardware name: hp server rx3600, BIOS 04.03 04/08/2008
>     ...
>     Call Trace:
>      [<a000000100015210>] show_stack+0x90/0xc0
>      [<a000000101163390>] dump_stack+0x150/0x1c0
>      [<a0000001003f1e90>] __kernel_unpoison_pages+0x410/0x440
>      [<a0000001003c2460>] get_page_from_freelist+0x1460/0x2ca0
>      [<a0000001003c6be0>] __alloc_pages_nodemask+0x3c0/0x660
>      [<a0000001003ed690>] alloc_pages_vma+0xb0/0x500
>      [<a00000010037deb0>] __handle_mm_fault+0x1230/0x1fe0
>      [<a00000010037ef70>] handle_mm_fault+0x310/0x4e0
>      [<a00000010005dc70>] ia64_do_page_fault+0x1f0/0xb80
>      [<a00000010000ca00>] ia64_leave_kernel+0x0/0x270
>     page_owner tracks the page as freed
>     page allocated via order 0, migratetype Movable,
>       gfp_mask 0x100dca(GFP_HIGHUSER_MOVABLE|__GFP_ZERO), pid 37, ts 8173444098740
>      __reset_page_owner+0x40/0x200
>      free_pcp_prepare+0x4d0/0x600
>      free_unref_page+0x20/0x1c0
>      __put_page+0x110/0x1a0
>      migrate_pages+0x16d0/0x1dc0
>      compact_zone+0xfc0/0x1aa0
>      proactive_compact_node+0xd0/0x1e0
>      kcompactd+0x550/0x600
>      kthread+0x2c0/0x2e0
>      call_payload+0x50/0x80
> 
> Here we can see that page was freed by page migration but something
> managed to write to it afterwards.
> 
> CC: Vlastimil Babka <vbabka@suse.cz>
> CC: Andrew Morton <akpm@linux-foundation.org>
> CC: linux-mm@kvack.org
> Signed-off-by: Sergei Trofimovich <slyfox@gentoo.org>

Acked-by: Vlastimil Babka <vbabka@suse.cz>

> ---
> Change since v1: use more generic 'dump_page()' suggested by Vlastimil
> Should supersede existing mm-page_poison-print-page-owner-info-when-corruption-is-caught.patch
> 
>  mm/page_poison.c | 6 ++++--
>  1 file changed, 4 insertions(+), 2 deletions(-)
> 
> diff --git a/mm/page_poison.c b/mm/page_poison.c
> index 65cdf844c8ad..df03126f3b2b 100644
> --- a/mm/page_poison.c
> +++ b/mm/page_poison.c
> @@ -2,6 +2,7 @@
>  #include <linux/kernel.h>
>  #include <linux/string.h>
>  #include <linux/mm.h>
> +#include <linux/mmdebug.h>
>  #include <linux/highmem.h>
>  #include <linux/page_ext.h>
>  #include <linux/poison.h>
> @@ -45,7 +46,7 @@ static bool single_bit_flip(unsigned char a, unsigned char b)
>  	return error && !(error & (error - 1));
>  }
>  
> -static void check_poison_mem(unsigned char *mem, size_t bytes)
> +static void check_poison_mem(struct page *page, unsigned char *mem, size_t bytes)
>  {
>  	static DEFINE_RATELIMIT_STATE(ratelimit, 5 * HZ, 10);
>  	unsigned char *start;
> @@ -70,6 +71,7 @@ static void check_poison_mem(unsigned char *mem, size_t bytes)
>  	print_hex_dump(KERN_ERR, "", DUMP_PREFIX_ADDRESS, 16, 1, start,
>  			end - start + 1, 1);
>  	dump_stack();
> +	dump_page(page, "pagealloc: corrupted page details");
>  }
>  
>  static void unpoison_page(struct page *page)
> @@ -82,7 +84,7 @@ static void unpoison_page(struct page *page)
>  	 * that is freed to buddy. Thus no extra check is done to
>  	 * see if a page was poisoned.
>  	 */
> -	check_poison_mem(addr, PAGE_SIZE);
> +	check_poison_mem(page, addr, PAGE_SIZE);
>  	kunmap_atomic(addr);
>  }
>  
> 

