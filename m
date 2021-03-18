Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 881E2340597
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Mar 2021 13:33:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231168AbhCRMd1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 18 Mar 2021 08:33:27 -0400
Received: from mx2.suse.de ([195.135.220.15]:47776 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231229AbhCRMdG (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 Mar 2021 08:33:06 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 5CC81AD20;
        Thu, 18 Mar 2021 12:33:05 +0000 (UTC)
Subject: Re: [PATCH 1/3] mm/slub: fixing backtrace of objects because of
 redzone adjustment
To:     Maninder Singh <maninder1.s@samsung.com>, paulmck@kernel.org,
        linux@armlinux.org.uk, cl@linux.com, penberg@kernel.org,
        rientjes@google.com, iamjoonsoo.kim@lge.com,
        akpm@linux-foundation.org, 0x7f454c46@gmail.com,
        viro@zeniv.linux.org.uk
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, a.sahrawat@samsung.com,
        Vaneet Narang <v.narang@samsung.com>
References: <CGME20210316103723epcas5p1f750d5cfe029fa69aea8d88f0bd408f3@epcas5p1.samsung.com>
 <1615891032-29160-1-git-send-email-maninder1.s@samsung.com>
From:   Vlastimil Babka <vbabka@suse.cz>
Message-ID: <8277f785-7952-08a9-52b5-b45aaccc20c7@suse.cz>
Date:   Thu, 18 Mar 2021 13:33:04 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.0
MIME-Version: 1.0
In-Reply-To: <1615891032-29160-1-git-send-email-maninder1.s@samsung.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 3/16/21 11:37 AM, Maninder Singh wrote:
> fixing commit 8e7f37f2aaa5 ("mm: Add mem_dump_obj() to print source
> of memory block")
> 
> with current code, Backtrace of allocated object is coming wrong:
> / # cat /proc/meminfo
> [   14.969843]  slab kmalloc-64 start c8ab0140 data offset 64 pointer offset 0 size 64 allocated at 0x6b6b6b6b
> [   14.970635]     0x6b6b6b6b
> [   14.970794]     0x6b6b6b6b
> [   14.970932]     0x6b6b6b6b
> [   14.971077]     0x6b6b6b6b
> [   14.971202]     0x6b6b6b6b
> [   14.971317]     0x6b6b6b6b
> [   14.971423]     0x6b6b6b6b
> [   14.971635]     0x6b6b6b6b
> [   14.971740]     0x6b6b6b6b
> [   14.971871]     0x6b6b6b6b
> [   14.972229]     0x6b6b6b6b
> [   14.972363]     0x6b6b6b6b
> [   14.972505]     0xa56b6b6b
> [   14.972631]     0xbbbbbbbb
> [   14.972734]     0xc8ab0400
> [   14.972891]     meminfo_proc_show+0x40/0x4fc
> 
> And reason is red zone was not adjusted from object address.
> after adding fixup for redzone, backtrace is coming correct:
> / # cat /proc/meminfo
> [   14.870782]  slab kmalloc-64 start c8ab0140 data offset 64 pointer offset 128 size 64 allocated at meminfo_proc_show+0x40/0x4f4
> [   14.871817]     meminfo_proc_show+0x40/0x4f4
> [   14.872035]     seq_read_iter+0x18c/0x4c4
> [   14.872229]     proc_reg_read_iter+0x84/0xac
> [   14.872433]     generic_file_splice_read+0xe8/0x17c
> [   14.872621]     splice_direct_to_actor+0xb8/0x290
> [   14.872747]     do_splice_direct+0xa0/0xe0
> [   14.872896]     do_sendfile+0x2d0/0x438
> [   14.873044]     sys_sendfile64+0x12c/0x140
> [   14.873229]     ret_fast_syscall+0x0/0x58
> [   14.873372]     0xbe861de4
> 
> Signed-off-by: Vaneet Narang <v.narang@samsung.com>
> Signed-off-by: Maninder Singh <maninder1.s@samsung.com>

Acked-by: Vlastimil Babka <vbabka@suse.cz>

> ---
>  mm/slub.c | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/mm/slub.c b/mm/slub.c
> index 1912c4614248..9d13f0117ae6 100644
> --- a/mm/slub.c
> +++ b/mm/slub.c
> @@ -4052,6 +4052,7 @@ void kmem_obj_info(struct kmem_obj_info *kpp, void *object, struct page *page)
>  	    !(s->flags & SLAB_STORE_USER))
>  		return;
>  #ifdef CONFIG_SLUB_DEBUG
> +	objp = fixup_red_left(s, objp);
>  	trackp = get_track(s, objp, TRACK_ALLOC);
>  	kpp->kp_ret = (void *)trackp->addr;
>  #ifdef CONFIG_STACKTRACE
> 

