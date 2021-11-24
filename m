Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 764DB45C831
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Nov 2021 16:03:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232606AbhKXPGT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 24 Nov 2021 10:06:19 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56012 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229752AbhKXPGO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Nov 2021 10:06:14 -0500
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1AE7BC061574
        for <linux-kernel@vger.kernel.org>; Wed, 24 Nov 2021 07:03:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=03LLWyAO4lnrCLJafThU9/xIfFpuVX7jwQvEdzaWdVU=; b=ApdOlzhUZ55WAGuQNSaEuNBD+8
        0aKYH7iiasR8q4WJySwYyajGkB0l/Dr2fmet0zgBRy5kiN3TIWskHVVmegGrC2JqLsPrmWglzmVFw
        XczeGie/xkJnNpgFIZwyTcguQnH3ike4HKyhInTmkkp+HO1LIl8gFmlNW+xs1kzet+jMVncPLe/RY
        ZHHUIKvFYZJt9DVO3KVSBULnGmNcr5pTAf1P8/dJIx57x3u9FCvvh+Y123J3utrNgqCBEkXSpaPP+
        fk2w8dy6CJ+c4l1CRi6nZ3Bk3V35pTXjYc9vYgvpn7UFXlIUkt9QEWxoemaGTtVqUR0j0rtpEdTlh
        7FgEcVhA==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by casper.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1mptnD-002F4G-Cf; Wed, 24 Nov 2021 15:02:40 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id C374B30008D;
        Wed, 24 Nov 2021 16:02:38 +0100 (CET)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 8606F203C25B1; Wed, 24 Nov 2021 16:02:38 +0100 (CET)
Date:   Wed, 24 Nov 2021 16:02:38 +0100
From:   Peter Zijlstra <peterz@infradead.org>
To:     Barry Song <21cnbao@gmail.com>
Cc:     Ingo Molnar <mingo@redhat.com>, Juri Lelli <juri.lelli@redhat.com>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Ben Segall <bsegall@google.com>, Mel Gorman <mgorman@suse.de>,
        Daniel Bristot de Oliveira <bristot@redhat.com>,
        Barry Song <song.bao.hua@hisilicon.com>
Subject: Re: [PATCH v2] sched/fair: Remove the cost of a redundant
 cpumask_next_wrap in select_idle_cpu
Message-ID: <YZ5UDuCII/KHUb9h@hirez.programming.kicks-ass.net>
References: <20211124091546.5072-1-21cnbao@gmail.com>
 <YZ4eWHarf7QDONLB@hirez.programming.kicks-ass.net>
 <CAGsJ_4xpqvhBW0G5UfCjRD8BfR4m4EUv4B_cxoOtYTO5+iRsCQ@mail.gmail.com>
 <CAGsJ_4yHToqZZ9R59jd0391mE0tAzxDFSvhSV24gx9c5JNvO4w@mail.gmail.com>
 <CAGsJ_4zpN98_J2aRHyqz4XvSzP+0ngVu2k=ufn9JQNMwe7zZjw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAGsJ_4zpN98_J2aRHyqz4XvSzP+0ngVu2k=ufn9JQNMwe7zZjw@mail.gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Nov 25, 2021 at 01:02:00AM +1300, Barry Song wrote:
> On Thu, Nov 25, 2021 at 12:57 AM Barry Song <21cnbao@gmail.com> wrote:

> > Let me make it clearer. if nr=5, the original code will  loop 5 times,
> > but in the 5th loop, it returns directly, so  __select_idle_cpu is
> > only done 4 times.
> >
> > if nr=1, the original code will  loop 1 time, but in the 1st loop,
> > it returns directly, so  __select_idle_cpu is  done 0 times.
> 
> this is also why in the first version of patch, i did this:
>                 span_avg = sd->span_weight * avg_idle;
>                 if (span_avg > 4*avg_cost)
> -                       nr = div_u64(span_avg, avg_cost);
> +                       nr = div_u64(span_avg, avg_cost) - 1;
>                 else
> -                       nr = 4;
> +                       nr = 3;
> 
> because we are actually scanning 3 times or div_u64(span_avg, avg_cost) - 1
> times but not 4 times or div_u64(span_avg, avg_cost) times.

It still is confusing, because > 4*span -> nr = avg/span, very much
implies we want to bottom out at 4.

> this is not confusing at all. the only thing which is confusing is the original
> code.

But yes, it seems a whole lot of confusion stacked together. Let make it
sane and say that we do 'nr' iterations, because clearly that was the
intent :-)
