Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2430E39C912
	for <lists+linux-kernel@lfdr.de>; Sat,  5 Jun 2021 16:36:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229989AbhFEOiF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 5 Jun 2021 10:38:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52194 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229931AbhFEOiF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 5 Jun 2021 10:38:05 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 15D8BC061766
        for <linux-kernel@vger.kernel.org>; Sat,  5 Jun 2021 07:36:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=N/7FSkaz5DLbvY+hTtfMTaGpJs4YbZXAkuRXDqcjNbk=; b=aSFGGhCGnVqzEzAsFI3zM89guq
        3IpZ5M4bEM5D4bU9mwWLENLgM+ZTQpZMC8idqAXu2lOpSgqkBgwVRMrxerXJ+4dqTqRs7BtyRFhAQ
        whup8KGeDYuEWOwYRe7+PcI11/Vc4Np/t6D9IcpsrcoD+xtDoZ5Fl7cr0mY5Ro7NRJmAToz58A5uc
        Cl1yY4k0JKO7uQaVHibXfuq//0n0QVJL0lY85wv1H3rjKuzecbZY2l5gYJyZCQalQKppLGIly0N5H
        bVS8volaV9NS6QTnAcKxqXbileQLN7YSexLXFJTKaGHHuCc8Ah+qhuERcVkC7JCarMiC3k/ATRa/o
        StNL96RA==;
Received: from willy by casper.infradead.org with local (Exim 4.94 #2 (Red Hat Linux))
        id 1lpXPA-00EA7q-5t; Sat, 05 Jun 2021 14:36:07 +0000
Date:   Sat, 5 Jun 2021 15:36:04 +0100
From:   Matthew Wilcox <willy@infradead.org>
To:     Liam Howlett <liam.howlett@oracle.com>
Cc:     "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>
Subject: Re: [PATCH] mm/nommu: unexport do_munmap()
Message-ID: <YLuL1FLms7tnJtlx@casper.infradead.org>
References: <20210604194002.648037-1-Liam.Howlett@Oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210604194002.648037-1-Liam.Howlett@Oracle.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jun 04, 2021 at 07:40:16PM +0000, Liam Howlett wrote:
> do_munmap() does not take the mmap_write_lock().  vm_munmap() should be
> used instead.

also, do_munmap was unexported for MMU builds back in 2012 by commit
17d1587f553d.

Reviewed-by: Matthew Wilcox (Oracle) <willy@infradead.org>

> Signed-off-by: Liam R. Howlett <Liam.Howlett@Oracle.com>
> ---
>  mm/nommu.c | 1 -
>  1 file changed, 1 deletion(-)
> 
> diff --git a/mm/nommu.c b/mm/nommu.c
> index 0997ca38c2bd..3a93d4054810 100644
> --- a/mm/nommu.c
> +++ b/mm/nommu.c
> @@ -1501,7 +1501,6 @@ int do_munmap(struct mm_struct *mm, unsigned long start, size_t len, struct list
>  	delete_vma(mm, vma);
>  	return 0;
>  }
> -EXPORT_SYMBOL(do_munmap);
>  
>  int vm_munmap(unsigned long addr, size_t len)
>  {
> -- 
> 2.30.2
> 
