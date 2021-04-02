Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D8E44352467
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Apr 2021 02:19:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236681AbhDBATH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 1 Apr 2021 20:19:07 -0400
Received: from mail.kernel.org ([198.145.29.99]:60432 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S236524AbhDBATF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Apr 2021 20:19:05 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 5CFB060FEF;
        Fri,  2 Apr 2021 00:19:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linux-foundation.org;
        s=korg; t=1617322743;
        bh=ZyIQIDMM+yZ8re7vGnAy7/S7akwUXVI7fx/YrYE5uy8=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=c5VVxnezo3XB7PTG4b1Z4ZZBmpGSmopyVWUnKZABUQjy8WgYgsUPSE9c0zpPrkcfX
         byeMgsCjfkFx7mHExP/1Thm1WmdBiFLvX2/L1n/vxRCc2K28klbM6e4Zk5uFNSXh7F
         +rgfW7UGQV7NF8iU3NYONZ2ofuU3GLcBoxpuZOI0=
Date:   Thu, 1 Apr 2021 17:19:02 -0700
From:   Andrew Morton <akpm@linux-foundation.org>
To:     Qiheng Lin <linqiheng@huawei.com>
Cc:     <linux-mm@kvack.org>, <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH -next] mm/vmalloc: Fix non-conforming function headers
Message-Id: <20210401171902.242f54c4b35f164f1d4eb028@linux-foundation.org>
In-Reply-To: <20210401132248.396947-1-linqiheng@huawei.com>
References: <20210401132248.396947-1-linqiheng@huawei.com>
X-Mailer: Sylpheed 3.5.1 (GTK+ 2.24.31; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 1 Apr 2021 21:22:48 +0800 Qiheng Lin <linqiheng@huawei.com> wrote:

> Fix the following W=1 kernel build warning(s):
>  mm/vmalloc.c:425: warning: expecting prototype for vunmap_range_noflush(). Prototype was for vunmap_range() instead
> 
> ...
>
> --- a/mm/vmalloc.c
> +++ b/mm/vmalloc.c
> @@ -413,7 +413,7 @@ void vunmap_range_noflush(unsigned long start, unsigned long end)
>  }
>  
>  /**
> - * vunmap_range_noflush - unmap kernel virtual addresses
> + * vunmap_range - unmap kernel virtual addresses
>   * @addr: start of the VM area to unmap
>   * @end: end of the VM area to unmap (non-inclusive)
>   *

Thanks.  Nick has just sent along a patch which fixed this.
