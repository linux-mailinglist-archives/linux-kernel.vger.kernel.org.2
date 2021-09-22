Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3CB674146C6
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Sep 2021 12:41:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235319AbhIVKmO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 22 Sep 2021 06:42:14 -0400
Received: from smtp-out2.suse.de ([195.135.220.29]:37972 "EHLO
        smtp-out2.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235310AbhIVKll (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Sep 2021 06:41:41 -0400
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id 6A3FC201E0;
        Wed, 22 Sep 2021 10:40:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1632307210; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=4ouO2eiBz7AarOubtUS2HbX5UCqDKCApeMp/QJiTLvY=;
        b=3NMEjBkMvtW+A2X7Xc7hHTQD/hluqwZwy4jjOPlg20LPPsNteIS2Kq7m6QZzHet7gmEO/w
        uFEvDnxAbN7rEbFKJ4X8T0WpT4uQ4tY/Al07oqF8lpwJ5V5diHeHLfDdMk8d+bizIDuqlF
        NS990yzPuDBxCvBAFe1ru8Z0JZxtS2E=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1632307210;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=4ouO2eiBz7AarOubtUS2HbX5UCqDKCApeMp/QJiTLvY=;
        b=4LgCBbV7tZaZYbDqVSHM92uCu2gu2SmcsFEMjOkGtu/RC2hIujoghoWSPbj2dn+a2uok7S
        Hoj9AvFbLC1gA7CQ==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 4B89613D69;
        Wed, 22 Sep 2021 10:40:10 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id 7SFsEQoIS2FFXQAAMHmgww
        (envelope-from <vbabka@suse.cz>); Wed, 22 Sep 2021 10:40:10 +0000
Message-ID: <f16867ee-9a79-c7ff-5e30-4fedf2bdb209@suse.cz>
Date:   Wed, 22 Sep 2021 12:40:09 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.1.1
Subject: Re: [PATCH 1/3] mm/smaps: Fix shmem pte hole swap calculation
Content-Language: en-US
To:     Peter Xu <peterx@redhat.com>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Hugh Dickins <hughd@google.com>,
        Andrea Arcangeli <aarcange@redhat.com>,
        Matthew Wilcox <willy@infradead.org>
References: <20210917164756.8586-1-peterx@redhat.com>
 <20210917164756.8586-2-peterx@redhat.com>
From:   Vlastimil Babka <vbabka@suse.cz>
In-Reply-To: <20210917164756.8586-2-peterx@redhat.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 9/17/21 18:47, Peter Xu wrote:
> The shmem swap calculation on the privately writable mappings are using wrong
> parameters as spotted by Vlastimil.  Fix them.  That's introduced in commit
> 48131e03ca4e, when rework shmem_swap_usage to shmem_partial_swap_usage.
> 
> Test program:
> 
> ==================
> 
> void main(void)
> {
>     char *buffer, *p;
>     int i, fd;
> 
>     fd = memfd_create("test", 0);
>     assert(fd > 0);
> 
>     /* isize==2M*3, fill in pages, swap them out */
>     ftruncate(fd, SIZE_2M * 3);
>     buffer = mmap(NULL, SIZE_2M * 3, PROT_READ | PROT_WRITE, MAP_SHARED, fd, 0);
>     assert(buffer);
>     for (i = 0, p = buffer; i < SIZE_2M * 3 / 4096; i++) {
>         *p = 1;
>         p += 4096;
>     }
>     madvise(buffer, SIZE_2M * 3, MADV_PAGEOUT);
>     munmap(buffer, SIZE_2M * 3);
> 
>     /*
>      * Remap with private+writtable mappings on partial of the inode (<= 2M*3),
>      * while the size must also be >= 2M*2 to make sure there's a none pmd so
>      * smaps_pte_hole will be triggered.
>      */
>     buffer = mmap(NULL, SIZE_2M * 2, PROT_READ | PROT_WRITE, MAP_PRIVATE, fd, 0);
>     printf("pid=%d, buffer=%p\n", getpid(), buffer);
> 
>     /* Check /proc/$PID/smap_rollup, should see 4MB swap */
>     sleep(1000000);
> }
> ==================
> 
> Before the patch, smaps_rollup shows <4MB swap and the number will be random
> depending on the alignment of the buffer of mmap() allocated.  After this
> patch, it'll show 4MB.
> 
> Fixes: 48131e03ca4e ("mm, proc: reduce cost of /proc/pid/smaps for unpopulated shmem mappings")

Thanks, too bad I didn't spot it when sending that patch :)

> Reported-by: Vlastimil Babka <vbabka@suse.cz>
> Signed-off-by: Peter Xu <peterx@redhat.com>

Reviewed-by: Vlastimil Babka <vbabka@suse.cz>

> ---
>  fs/proc/task_mmu.c | 6 ++++--
>  1 file changed, 4 insertions(+), 2 deletions(-)
> 
> diff --git a/fs/proc/task_mmu.c b/fs/proc/task_mmu.c
> index cf25be3e0321..2197f669e17b 100644
> --- a/fs/proc/task_mmu.c
> +++ b/fs/proc/task_mmu.c
> @@ -478,9 +478,11 @@ static int smaps_pte_hole(unsigned long addr, unsigned long end,
>  			  __always_unused int depth, struct mm_walk *walk)
>  {
>  	struct mem_size_stats *mss = walk->private;
> +	struct vm_area_struct *vma = walk->vma;
>  
> -	mss->swap += shmem_partial_swap_usage(
> -			walk->vma->vm_file->f_mapping, addr, end);
> +	mss->swap += shmem_partial_swap_usage(walk->vma->vm_file->f_mapping,
> +					      linear_page_index(vma, addr),
> +					      linear_page_index(vma, end));
>  
>  	return 0;
>  }
> 

