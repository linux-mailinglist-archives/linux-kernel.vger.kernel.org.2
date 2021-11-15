Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6FB7E450942
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Nov 2021 17:07:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236566AbhKOQKt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 15 Nov 2021 11:10:49 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50442 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236749AbhKOQKf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 Nov 2021 11:10:35 -0500
Received: from desiato.infradead.org (desiato.infradead.org [IPv6:2001:8b0:10b:1:d65d:64ff:fe57:4e05])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3EE7BC061207
        for <linux-kernel@vger.kernel.org>; Mon, 15 Nov 2021 08:07:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=desiato.20200630; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=tRJIRldO8x/OJrUM+kyqbd8xhprA3vn8Q93WyN4i5SY=; b=Ln61dQV53OSRSsvTbsgX7lckHZ
        CIZXi8xyY8JxoGVL6WS9VBmUDLgn37Hy0qtia29YDyF7EgL9WsKA00PyuPfjQzwIo5hdZ5NVV7/HP
        Ae3Mp4W6oduQ+un82zgdP7PQ35+/fHg53zZ2ocYxQcTa3+rqp8PUCr035yUjYsqKEHV7Dr6QGizy1
        scrW3lhNrntOGNTOVaF8p5bxgEhPjpLBzrAf2ARkavL9aeyCmiyqOHGkZz3mqkIfDU0kgZXcVXH6G
        Ja/xWjIfjMhDm4Q6z5a2RwpqjzDL47hwnmebLQYLAK5mmmxbGuANHVpKMaFBJGf81LH2dVK9KoZWD
        AgQo6fzA==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by desiato.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1mmeVs-00GARK-Q4; Mon, 15 Nov 2021 16:07:21 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 6B04F300347;
        Mon, 15 Nov 2021 17:07:20 +0100 (CET)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 526FE20BE2E8A; Mon, 15 Nov 2021 17:07:20 +0100 (CET)
Date:   Mon, 15 Nov 2021 17:07:20 +0100
From:   Peter Zijlstra <peterz@infradead.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        the arch/x86 maintainers <x86@kernel.org>
Subject: Re: [GIT pull] timers/urgent for v5.16-rc1
Message-ID: <YZKFuE0gpdlTiBOv@hirez.programming.kicks-ass.net>
References: <163689642456.3249160.13397023971040961440.tglx@xen13>
 <163689642744.3249160.6971106813056927807.tglx@xen13>
 <CAHk-=wjQxHwdC61ore062Hc5PAF2o6CJnDG_NsQe+e599RovJw@mail.gmail.com>
 <YZKCBqmb1gfKvFcR@hirez.programming.kicks-ass.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YZKCBqmb1gfKvFcR@hirez.programming.kicks-ass.net>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Nov 15, 2021 at 04:51:34PM +0100, Peter Zijlstra wrote:
> diff --git a/kernel/time/posix-cpu-timers.c b/kernel/time/posix-cpu-timers.c
> index 96b4e7810426..3352759e6916 100644
> --- a/kernel/time/posix-cpu-timers.c
> +++ b/kernel/time/posix-cpu-timers.c
> @@ -1167,8 +1167,6 @@ void clear_posix_cputimers_work(struct task_struct *p)
>  	 * A copied work entry from the old task is not meaningful, clear it.
>  	 * N.B. init_task_work will not do this.
>  	 */
> -	memset(&p->posix_cputimers_work.work, 0,
> -	       sizeof(p->posix_cputimers_work.work));

Also, clearly that comments needs to go..

>  	init_task_work(&p->posix_cputimers_work.work,
>  		       posix_cpu_timers_work);
>  	p->posix_cputimers_work.scheduled = false;
