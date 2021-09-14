Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0693F40ACF7
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Sep 2021 14:02:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232287AbhINMDb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 14 Sep 2021 08:03:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59578 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232252AbhINMD3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Sep 2021 08:03:29 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D8D69C061574
        for <linux-kernel@vger.kernel.org>; Tue, 14 Sep 2021 05:02:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=sMURhasWH7o24sIx6k+KJwjL13GOVwjz4KzyTqvqMaA=; b=AMH/RfTDsWf9TbGEll27BOuxfZ
        YBIkPLhTMvDz+/zcYlxvuzyxFdRP5VeN/JLIriAD/nD96kRbe5gsvlT9gYvU35XdBdsONLGGLcuLT
        YncfwElFeMzY9ID4XsZe8S50K5jzeW9NcGepi733QDc2E5Wo4tJbQNG+DlNoNkKUIlxsy4uigGPQ4
        SdsBYVh4fpWsnBxj9Yk+6QNWy1s2QnVtt9eP293P8lEBMFc05xwZZ+HupVSPgCOYcdo8SyNwwJKR+
        f7v3G8S9oV908W54XhpItz0yz/DnXqfRfgwtinVsONMVQovXtVbJBwlfeuAZFy5Zr6muLrRa+m4fK
        95gzQb5g==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by casper.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1mQ74f-00Ed2c-5h; Tue, 14 Sep 2021 11:58:30 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id C270730003A;
        Tue, 14 Sep 2021 13:58:03 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id A3FD52D1FEA0E; Tue, 14 Sep 2021 13:58:03 +0200 (CEST)
Date:   Tue, 14 Sep 2021 13:58:03 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Vincent Guittot <vincent.guittot@linaro.org>
Cc:     Yicong Yang <yangyicong@hisilicon.com>,
        Ingo Molnar <mingo@redhat.com>,
        Juri Lelli <juri.lelli@redhat.com>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Ben Segall <bsegall@google.com>, Mel Gorman <mgorman@suse.de>,
        Daniel Bristot de Oliveira <bristot@redhat.com>,
        21cnbao@gmail.com,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        "Song Bao Hua (Barry Song)" <song.bao.hua@hisilicon.com>,
        prime.zeng@huawei.com,
        "guodong.xu@linaro.org" <guodong.xu@linaro.org>
Subject: Re: [RFC] Perfomance varies according to sysctl_sched_migration_cost
Message-ID: <YUCOSyFITy/dHcJI@hirez.programming.kicks-ass.net>
References: <ef3b3e55-8be9-595f-6d54-886d13a7e2fd@hisilicon.com>
 <CAKfTPtDJip17rdZ0CMDwUztE7BGUF+J_O2Up=S5GLYrqtkA67A@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAKfTPtDJip17rdZ0CMDwUztE7BGUF+J_O2Up=S5GLYrqtkA67A@mail.gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Sep 14, 2021 at 11:04:03AM +0200, Vincent Guittot wrote:
> 
> I would say that it's a heuristic value that works for most of system
> but it should probably be tuned per platform. But also note that it's
> quite difficult to get a correct value
> 

Right; so back before CFS there was some boot time benchmarks that
measured something for each sched domain.

Conceptually that makes sense, the larger the domain, the larger the
cost, also, you get per platform etc..

In practise it had boot to boot variance and virt fail written all over
it, which is why Ingo ripped it out. I think someone once tried to bring
some of it back, but that was a long time ago.

I'm also not convinced boot time benchmarks are the best idea, because
the above reasons, but perhaps we can do something topology based, and
maybe using a few platform inputs.

And as with anything, some benchmarks will like it, others will not like
it. It's only worth the complexity if we can get an improvement across
the board.
