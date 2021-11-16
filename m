Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BB2CC453291
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Nov 2021 14:06:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234774AbhKPNJL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 16 Nov 2021 08:09:11 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48862 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233903AbhKPNJK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Nov 2021 08:09:10 -0500
Received: from desiato.infradead.org (desiato.infradead.org [IPv6:2001:8b0:10b:1:d65d:64ff:fe57:4e05])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 49D70C061746
        for <linux-kernel@vger.kernel.org>; Tue, 16 Nov 2021 05:06:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=desiato.20200630; h=In-Reply-To:Content-Transfer-Encoding:
        Content-Type:MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:
        Sender:Reply-To:Content-ID:Content-Description;
        bh=7uVlOpOUji2SJ9Y9UfBEabt7H34qj7/TbmpjVFHhAv0=; b=W1Yz2ia9MSdCqGV1MyKN0SfkV1
        XfdZAh822C38w5hcgcQ9F93YRHjAtIDe7vS8fxTrBBhJqUEnbPimibIYrzqHP5aSK0Cs34rNq6qn/
        4SXZhJHCo8+kfvMA3BwKiljv/5iAuP4F794CifsRqfp2M+nnf0MghKoe4Op1UbOvJA+wJzJu6Bn4O
        Kc4fhyXcN8Gw2TW1qL+qbi5DsnKYaw0g6jZNc6GykETQEQuNxTie2Y6XjdLovor3jVa2xPXvKdlVB
        SzJ12jvkPMojW+pUXXqcBBxS0BE6FDR1Aw6g2dQEg30jyUNkCzY4kS8pxpI03Y5yxPJ+8tSuVNs0t
        AvnS13tw==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by desiato.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1mmy9t-00GJmo-Qw; Tue, 16 Nov 2021 13:05:58 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id E69E33001FD;
        Tue, 16 Nov 2021 14:05:56 +0100 (CET)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 779F02C3690A6; Tue, 16 Nov 2021 14:05:56 +0100 (CET)
Date:   Tue, 16 Nov 2021 14:05:56 +0100
From:   Peter Zijlstra <peterz@infradead.org>
To:     Yinan Liu <yinan@linux.alibaba.com>
Cc:     rostedt@goodmis.org, mark-pk.tsai@mediatek.com, mingo@redhat.com,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 1/2] scripts: ftrace - move the sort-processing in
 ftrace_init to compile time
Message-ID: <YZOstJy9mbZvHMUi@hirez.programming.kicks-ass.net>
References: <20210911135043.16014-1-yinan@linux.alibaba.com>
 <20211116024942.60644-1-yinan@linux.alibaba.com>
 <20211116024942.60644-2-yinan@linux.alibaba.com>
 <20211116080730.GV174703@worktop.programming.kicks-ass.net>
 <edb15f83-ddf9-ae48-6d1e-6ef7802e6f50@linux.alibaba.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <edb15f83-ddf9-ae48-6d1e-6ef7802e6f50@linux.alibaba.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Nov 16, 2021 at 08:42:28PM +0800, Yinan Liu wrote:
> 
> 
> 在 2021/11/16 下午4:07, Peter Zijlstra 写道:
> 
> > /me hands a bucket of {} your way.
> 
> --- a/kernel/trace/ftrace.c
> +++ b/kernel/trace/ftrace.c
> @@ -6406,8 +6406,10 @@ static int ftrace_process_locs(struct module *mod,
>         if (!count)
>                 return 0;
> 
> -       sort(start, count, sizeof(*start),
> -            ftrace_cmp_ips, NULL);
> +       if (mod) {
> +               sort(start, count, sizeof(*start),
> +                    ftrace_cmp_ips, NULL);
> +       }
> 
> hi，peter
> 
> you mean like this? I hope I'm not mistaken.

Exactly.

> 
> > Also, can't sorttable be ran on modules ?
> 
> The .ko file will be relocated after insmod or modprobe.
> And the mcount redirection in .ko is based on ".text",
> ".init.text", ".ref.text", ".sched.text", ".spinlock.text",
> ".irqentry .text", ".softirqentry.text", ".kprobes.text", ".cpuidle.text",
> ".text.unlikely". These sections‘ loading
> position are not in definite order.
> 
> So sorting this part at compile time doesn't make much sense.

Bah.. I thought the sections would retain relative position at least,
but alas. if that isn't done you're quite right that sorting seems
pointless.

