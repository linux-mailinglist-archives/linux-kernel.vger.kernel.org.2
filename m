Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 71E5C377B60
	for <lists+linux-kernel@lfdr.de>; Mon, 10 May 2021 07:08:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230074AbhEJFJo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 10 May 2021 01:09:44 -0400
Received: from mail.kernel.org ([198.145.29.99]:33094 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229958AbhEJFJk (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 May 2021 01:09:40 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 494FF61432;
        Mon, 10 May 2021 05:08:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linux-foundation.org;
        s=korg; t=1620623315;
        bh=4J6MTW8s/x4YXb+wRdoYSsxhvgYN6Y+/LU8YxgkjqtE=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=b4MVlq5fdsrsun5cQiFvyh4aV6wCWngXpNB4TL7x8pN+jqf0CcP0ymD14Kqjnf968
         d8xUyvzIf8fFy1bdADyvLa4IWpD9znEfhjnDh6DIIlwNKtnv6p9zJ3p/HgO4auc/le
         luwFE2Ksc5A+PZh7z+D+9g5Q36q+71sB51IiIQGQ=
Date:   Sun, 9 May 2021 22:08:34 -0700
From:   Andrew Morton <akpm@linux-foundation.org>
To:     Gonzalo Matias Juarez Tello <gmjuareztello@gmail.com>
Cc:     linux-mm@kvack.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] mm/mmap.c: logic of find_vma_intersection repeated in
 __do_munmap
Message-Id: <20210509220834.d8b46dabea050d162df8cdf7@linux-foundation.org>
In-Reply-To: <20210409162129.18313-1-gmjuareztello@gmail.com>
References: <20210409162129.18313-1-gmjuareztello@gmail.com>
X-Mailer: Sylpheed 3.5.1 (GTK+ 2.24.31; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri,  9 Apr 2021 13:21:26 -0300 Gonzalo Matias Juarez Tello <gmjuareztello@gmail.com> wrote:

> Logic of find_vma_intersection() (which is an inline fc) is
> repeated in __do_munmap().
> Besides, prev is assigned a value before checking vma->vm_start >= end
> which might end up on a return statement making that assignment useless.
> 
> Calling find_vma_intersection() checks that condition and returns NULL if
> no vma is found, hence only the !vma check is needed in __do_munmap().
> 
> ...
>
> --- a/mm/mmap.c
> +++ b/mm/mmap.c
> @@ -2822,16 +2822,11 @@ int __do_munmap(struct mm_struct *mm, unsigned long start, size_t len,
>  	 */
>  	arch_unmap(mm, start, end);
>  
> -	/* Find the first overlapping VMA */
> -	vma = find_vma(mm, start);
> +	/* Find the first overlapping VMA where start < vma->vm_end */
> +	vma = find_vma_intersection(mm, start, end);
>  	if (!vma)
>  		return 0;
>  	prev = vma->vm_prev;
> -	/* we have  start < vma->vm_end  */
> -
> -	/* if it doesn't overlap, we have nothing.. */
> -	if (vma->vm_start >= end)
> -		return 0;
>  
>  	/*
>  	 * If we need to split any vma, do it now to save pain later.

Looks good to me, thanks.
