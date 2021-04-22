Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 74F06367FD3
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Apr 2021 13:52:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236119AbhDVLwl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 22 Apr 2021 07:52:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58344 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230510AbhDVLwk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Apr 2021 07:52:40 -0400
Received: from desiato.infradead.org (desiato.infradead.org [IPv6:2001:8b0:10b:1:d65d:64ff:fe57:4e05])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 913E7C06174A
        for <linux-kernel@vger.kernel.org>; Thu, 22 Apr 2021 04:52:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=desiato.20200630; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=TTLq+a6lPOSqPm+zUeFMqc94vwjHRY0/Cq2Ry+KYykI=; b=ZRQxRQOfhtd/VaASjBcyybKUIH
        PTahfOJA4D+Onk227drNM3gPTNTt5xedYPp2DBKg//kEfqF2debhVjZm9mO8Snv6l/HI3dqP7ZP/7
        qLuHm4ZXlPNO5mp9WhEdiRCQHlGha9lPcxALmxEz6LSFYnr1eBbrIdctoDgFmxQMGAhNAjQX8Mmjf
        vm+i/QNKSxCCWYwR8zLhJICF2j5eFctRhUD9SXPMxYMZTCMNE+Js98JcC7as+DKSMXOKIXhKnQGkC
        AGe8L+H3O8GR8AO50mb1B2Wu5b2kabd25aTncU3QfctD+oAhlgoNqS2BD+29U1wsfNWMr+JilxWeR
        Cfd1Jmzw==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by desiato.infradead.org with esmtpsa (Exim 4.94 #2 (Red Hat Linux))
        id 1lZXsB-00GdEN-3f; Thu, 22 Apr 2021 11:51:55 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 3539F3001E2;
        Thu, 22 Apr 2021 13:51:54 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 160E02C1AB5F8; Thu, 22 Apr 2021 13:51:54 +0200 (CEST)
Date:   Thu, 22 Apr 2021 13:51:54 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Hui Su <suhui@zeku.com>
Cc:     mingo@redhat.com, juri.lelli@redhat.com,
        vincent.guittot@linaro.org, dietmar.eggemann@arm.com,
        rostedt@goodmis.org, bsegall@google.com, mgorman@suse.de,
        bristot@redhat.com, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] sched/fair.c: add helper func for util_avg and
 runnable_avg calc
Message-ID: <YIFjWrAZ6Fw4bFQd@hirez.programming.kicks-ass.net>
References: <20210422091416.19432-1-suhui@zeku.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210422091416.19432-1-suhui@zeku.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Apr 22, 2021 at 05:14:16PM +0800, Hui Su wrote:
> add helper func for util_avg and runnable_avg calc when entity
> enqueue and dequeue. No functional change.
> 
> without this change:
> size vmlinux
>    text	   data	    bss	    dec	    hex	filename
> 19889268	6632812	2429160	28951240	1b9c2c8	vmlinux
> size kernel/sched/fair.o
>    text	   data	    bss	    dec	    hex	filename
>   40044	   1569	     96	  41709	   a2ed	kernel/sched/fair.o
> ubuntu@zeku_server:~/workspace/linux-stable $
> 
> with this change:
> size vmlinux
>    text	   data	    bss	    dec	    hex	filename
> 19889268	6632812	2429160	28951240	1b9c2c8	vmlinux
> size kernel/sched/fair.o
>    text	   data	    bss	    dec	    hex	filename
>   40044	   1569	     96	  41709	   a2ed	kernel/sched/fair.o
> 
> Signed-off-by: Hui Su <suhui@zeku.com>
> ---
>  kernel/sched/fair.c | 48 +++++++++++++++++++++++++++++++++++++--------
>  1 file changed, 40 insertions(+), 8 deletions(-)

So you're increasing line-count and clutter for absolutely no benefit.

Why would we want that?
