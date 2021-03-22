Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 219AB343ADC
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Mar 2021 08:46:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229870AbhCVHpn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 22 Mar 2021 03:45:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46438 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229786AbhCVHpQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 Mar 2021 03:45:16 -0400
Received: from desiato.infradead.org (desiato.infradead.org [IPv6:2001:8b0:10b:1:d65d:64ff:fe57:4e05])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7A0F4C061574
        for <linux-kernel@vger.kernel.org>; Mon, 22 Mar 2021 00:45:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=desiato.20200630; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=a4V0ZQVQps4nQLfsOVFZP2e8Pz9X+P/+CA8XJe4x7Yo=; b=c/uasegkc7omW3rWyYnu0TKByD
        JRmNtabOpMxwDKVYsIve3iMq8RF8WSfDzM0JZ+di7njstLLmb4VQ0ihxGIQ28BOdAk8c9/xyo8gW3
        OeOd/b7pVIMNucscoPis58wW+RrqdHzmmc+z1qDS2909IOnsS39XvmvRM8XhR8Ip/iiutLssVMCcS
        HM915rD9cOxWkH63U/1Dbv2pLQTY4YAfEZ98DNEiedS4AyNDS3LyWy5cgPy11MV7j8XJGmqL1Gub2
        DKcbhydT2P3JIcLfHvpaYEDDqbY3hrgnz93+ncnYCKvWByB9Cz+hBafP3s8htDNZlNSsXoAJAL6Tc
        UCTtQ90g==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by desiato.infradead.org with esmtpsa (Exim 4.94 #2 (Red Hat Linux))
        id 1lOFFR-00B6Fz-83; Mon, 22 Mar 2021 07:45:13 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 5744A301A32;
        Mon, 22 Mar 2021 08:45:12 +0100 (CET)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 3B0512CF553EB; Mon, 22 Mar 2021 08:45:12 +0100 (CET)
Date:   Mon, 22 Mar 2021 08:45:12 +0100
From:   Peter Zijlstra <peterz@infradead.org>
To:     Shakeel Butt <shakeelb@google.com>
Cc:     Johannes Weiner <hannes@cmpxchg.org>,
        Ingo Molnar <mingo@redhat.com>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] psi: reduce calls to sched_clock() in psi
Message-ID: <YFhLCPzKlE2uk46k@hirez.programming.kicks-ass.net>
References: <20210321205156.4186483-1-shakeelb@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210321205156.4186483-1-shakeelb@google.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Mar 21, 2021 at 01:51:56PM -0700, Shakeel Butt wrote:
> We noticed that the cost of psi increases with the increase in the
> levels of the cgroups. Particularly the cost of cpu_clock() sticks out
> as the kernel calls it multiple times as it traverses up the cgroup
> tree. This patch reduces the calls to cpu_clock().
> 
> Performed perf bench on Intel Broadwell with 3 levels of cgroup.
> 
> Before the patch:
> 
> $ perf bench sched all
>  # Running sched/messaging benchmark...
>  # 20 sender and receiver processes per group
>  # 10 groups == 400 processes run
> 
>      Total time: 0.747 [sec]
> 
>  # Running sched/pipe benchmark...
>  # Executed 1000000 pipe operations between two processes
> 
>      Total time: 3.516 [sec]
> 
>        3.516689 usecs/op
>          284358 ops/sec
> 
> After the patch:
> 
> $ perf bench sched all
>  # Running sched/messaging benchmark...
>  # 20 sender and receiver processes per group
>  # 10 groups == 400 processes run
> 
>      Total time: 0.640 [sec]
> 
>  # Running sched/pipe benchmark...
>  # Executed 1000000 pipe operations between two processes
> 
>      Total time: 3.329 [sec]
> 
>        3.329820 usecs/op
>          300316 ops/sec
> 
> Signed-off-by: Shakeel Butt <shakeelb@google.com>

Thanks!
