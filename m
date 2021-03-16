Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2AC1C33DB2C
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Mar 2021 18:45:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238679AbhCPRon (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 16 Mar 2021 13:44:43 -0400
Received: from mail.kernel.org ([198.145.29.99]:38792 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231978AbhCPRob (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Mar 2021 13:44:31 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 768546511D;
        Tue, 16 Mar 2021 17:44:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1615916671;
        bh=70urjVlzuIkBAAt6z/A7aEgLJGDaoFtxXpjtZaip/+I=;
        h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
        b=RfJlUe04rO0XegYU6UvIVXzCZTbC5LlaWuudIWIYH50c1pgyq4U5a3vutog1RttNx
         uRcmoqxQeEjCc2raxL4arPFYnhaSQqS/lwLLDrf74yhqjbCg0kDjLqUuL9rCMlHj6S
         Y6LO5SAQfiSR+ThRrKq4A78hZQHl1VEaWZT+K3Ag0Hc9YgLGIm81CAz8vVl/VhTBM2
         pxczDjGsHE95fM072hLdrb30mEB+jKxKuA8phptAv2uHTw+ISLr7RDtZXfTD4euFvn
         kwnvgkuk/T9wPBKgQCg/L9hNhAW351k4tEtDnjKsCMFkkZ8cwqQYq+DJWSoPDM+RkQ
         WYkPtLQfpoN9Q==
Received: by paulmck-ThinkPad-P72.home (Postfix, from userid 1000)
        id 42827352262D; Tue, 16 Mar 2021 10:44:31 -0700 (PDT)
Date:   Tue, 16 Mar 2021 10:44:31 -0700
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     Maninder Singh <maninder1.s@samsung.com>
Cc:     linux@armlinux.org.uk, cl@linux.com, penberg@kernel.org,
        rientjes@google.com, iamjoonsoo.kim@lge.com,
        akpm@linux-foundation.org, vbabka@suse.cz, 0x7f454c46@gmail.com,
        viro@zeniv.linux.org.uk, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        a.sahrawat@samsung.com, Vaneet Narang <v.narang@samsung.com>
Subject: Re: [PATCH 1/3] mm/slub: fixing backtrace of objects because of
 redzone adjustment
Message-ID: <20210316174431.GX2696@paulmck-ThinkPad-P72>
Reply-To: paulmck@kernel.org
References: <CGME20210316103723epcas5p1f750d5cfe029fa69aea8d88f0bd408f3@epcas5p1.samsung.com>
 <1615891032-29160-1-git-send-email-maninder1.s@samsung.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1615891032-29160-1-git-send-email-maninder1.s@samsung.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Mar 16, 2021 at 04:07:10PM +0530, Maninder Singh wrote:
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

Good catch, thank you!  For the series:

Acked-by: Paul E. McKenney <paulmck@kernel.org>

On the other hand, if you would like me to take these, we need to get
a maintainer ack.

							Thanx, Paul

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
> -- 
> 2.17.1
> 
