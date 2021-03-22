Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E48E73445EB
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Mar 2021 14:37:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230385AbhCVNgd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 22 Mar 2021 09:36:33 -0400
Received: from mx2.suse.de ([195.135.220.15]:54228 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230237AbhCVNgU (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 Mar 2021 09:36:20 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1616420179; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=Er/Zcqg/XdYcpF2E8Um0ObszDPeK8KxGe7TwgPDl5Yg=;
        b=Yd2CgRzKJqWmqxzHp04u750tekZEzryADU8q2+jkvNRRlKknnJSNnHS/j//o6HLXF9klDz
        5cwa88f4DLIE89oZGiR3qT2cYgkbloZnK0A+EPFVemuUpMSiqQhoPAsxNaGvJdfMdSX8kW
        GDh8AD0U/7gqUEu/98iT3ZNBHsaG85o=
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 74A47AE5C;
        Mon, 22 Mar 2021 13:36:19 +0000 (UTC)
Date:   Mon, 22 Mar 2021 14:36:18 +0100
From:   Michal Hocko <mhocko@suse.com>
To:     David Hildenbrand <david@redhat.com>
Cc:     linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        Andrew Morton <akpm@linux-foundation.org>,
        Hillf Danton <hdanton@sina.com>,
        Matthew Wilcox <willy@infradead.org>,
        Oleksiy Avramchenko <oleksiy.avramchenko@sonymobile.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Minchan Kim <minchan@kernel.org>,
        huang ying <huang.ying.caritas@gmail.com>
Subject: Re: [PATCH RFC 3/3] mm/vmalloc: remove vwrite()
Message-ID: <YFidUnjPlSk7+j2t@dhcp22.suse.cz>
References: <20210319143452.25948-1-david@redhat.com>
 <20210319143452.25948-4-david@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210319143452.25948-4-david@redhat.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri 19-03-21 15:34:52, David Hildenbrand wrote:
> The last user (/dev/kmem) is gone. Let's drop it.
> 
> Cc: Andrew Morton <akpm@linux-foundation.org>
> Cc: Hillf Danton <hdanton@sina.com>
> Cc: Michal Hocko <mhocko@suse.com>
> Cc: Matthew Wilcox <willy@infradead.org>
> Cc: Oleksiy Avramchenko <oleksiy.avramchenko@sonymobile.com>
> Cc: Steven Rostedt <rostedt@goodmis.org>
> Cc: Minchan Kim <minchan@kernel.org>
> Cc: huang ying <huang.ying.caritas@gmail.com>
> Signed-off-by: David Hildenbrand <david@redhat.com>

Acked-by: Michal Hocko <mhocko@suse.com>

> ---
>  include/linux/vmalloc.h |   1 -
>  mm/vmalloc.c            | 111 ----------------------------------------
>  2 files changed, 112 deletions(-)
> 
> diff --git a/include/linux/vmalloc.h b/include/linux/vmalloc.h
> index 390af680e916..9c1b17c7dd95 100644
> --- a/include/linux/vmalloc.h
> +++ b/include/linux/vmalloc.h
> @@ -200,7 +200,6 @@ static inline void set_vm_flush_reset_perms(void *addr)
>  
>  /* for /proc/kcore */
>  extern long vread(char *buf, char *addr, unsigned long count);
> -extern long vwrite(char *buf, char *addr, unsigned long count);
>  
>  /*
>   *	Internals.  Dont't use..
> diff --git a/mm/vmalloc.c b/mm/vmalloc.c
> index ccb405b82581..07a39881f9d6 100644
> --- a/mm/vmalloc.c
> +++ b/mm/vmalloc.c
> @@ -2820,43 +2820,6 @@ static int aligned_vread(char *buf, char *addr, unsigned long count)
>  	return copied;
>  }
>  
> -static int aligned_vwrite(char *buf, char *addr, unsigned long count)
> -{
> -	struct page *p;
> -	int copied = 0;
> -
> -	while (count) {
> -		unsigned long offset, length;
> -
> -		offset = offset_in_page(addr);
> -		length = PAGE_SIZE - offset;
> -		if (length > count)
> -			length = count;
> -		p = vmalloc_to_page(addr);
> -		/*
> -		 * To do safe access to this _mapped_ area, we need
> -		 * lock. But adding lock here means that we need to add
> -		 * overhead of vmalloc()/vfree() calles for this _debug_
> -		 * interface, rarely used. Instead of that, we'll use
> -		 * kmap() and get small overhead in this access function.
> -		 */
> -		if (p) {
> -			/*
> -			 * we can expect USER0 is not used (see vread/vwrite's
> -			 * function description)
> -			 */
> -			void *map = kmap_atomic(p);
> -			memcpy(map + offset, buf, length);
> -			kunmap_atomic(map);
> -		}
> -		addr += length;
> -		buf += length;
> -		copied += length;
> -		count -= length;
> -	}
> -	return copied;
> -}
> -
>  /**
>   * vread() - read vmalloc area in a safe way.
>   * @buf:     buffer for reading data
> @@ -2936,80 +2899,6 @@ long vread(char *buf, char *addr, unsigned long count)
>  	return buflen;
>  }
>  
> -/**
> - * vwrite() - write vmalloc area in a safe way.
> - * @buf:      buffer for source data
> - * @addr:     vm address.
> - * @count:    number of bytes to be read.
> - *
> - * This function checks that addr is a valid vmalloc'ed area, and
> - * copy data from a buffer to the given addr. If specified range of
> - * [addr...addr+count) includes some valid address, data is copied from
> - * proper area of @buf. If there are memory holes, no copy to hole.
> - * IOREMAP area is treated as memory hole and no copy is done.
> - *
> - * If [addr...addr+count) doesn't includes any intersects with alive
> - * vm_struct area, returns 0. @buf should be kernel's buffer.
> - *
> - * Note: In usual ops, vwrite() is never necessary because the caller
> - * should know vmalloc() area is valid and can use memcpy().
> - * This is for routines which have to access vmalloc area without
> - * any information, as /dev/kmem.
> - *
> - * Return: number of bytes for which addr and buf should be
> - * increased (same number as @count) or %0 if [addr...addr+count)
> - * doesn't include any intersection with valid vmalloc area
> - */
> -long vwrite(char *buf, char *addr, unsigned long count)
> -{
> -	struct vmap_area *va;
> -	struct vm_struct *vm;
> -	char *vaddr;
> -	unsigned long n, buflen;
> -	int copied = 0;
> -
> -	/* Don't allow overflow */
> -	if ((unsigned long) addr + count < count)
> -		count = -(unsigned long) addr;
> -	buflen = count;
> -
> -	spin_lock(&vmap_area_lock);
> -	list_for_each_entry(va, &vmap_area_list, list) {
> -		if (!count)
> -			break;
> -
> -		if (!va->vm)
> -			continue;
> -
> -		vm = va->vm;
> -		vaddr = (char *) vm->addr;
> -		if (addr >= vaddr + get_vm_area_size(vm))
> -			continue;
> -		while (addr < vaddr) {
> -			if (count == 0)
> -				goto finished;
> -			buf++;
> -			addr++;
> -			count--;
> -		}
> -		n = vaddr + get_vm_area_size(vm) - addr;
> -		if (n > count)
> -			n = count;
> -		if (!(vm->flags & VM_IOREMAP)) {
> -			aligned_vwrite(buf, addr, n);
> -			copied++;
> -		}
> -		buf += n;
> -		addr += n;
> -		count -= n;
> -	}
> -finished:
> -	spin_unlock(&vmap_area_lock);
> -	if (!copied)
> -		return 0;
> -	return buflen;
> -}
> -
>  /**
>   * remap_vmalloc_range_partial - map vmalloc pages to userspace
>   * @vma:		vma to cover
> -- 
> 2.29.2

-- 
Michal Hocko
SUSE Labs
