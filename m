Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9861A422289
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Oct 2021 11:42:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233705AbhJEJoW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 5 Oct 2021 05:44:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33550 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232658AbhJEJoU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Oct 2021 05:44:20 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C66EFC061745
        for <linux-kernel@vger.kernel.org>; Tue,  5 Oct 2021 02:42:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=SROZdM74rJINda6efh3/x7QvGWrv4vfLmeneC/gxc0Q=; b=gnT1M/Cprqagurm0L8AhF6akt7
        5QYSfLNib7V0LsBfYtkr2RdPMGGCx7gqCeGKVm3ugJq3rCbb5PAfZymNnlNOzYerskU77bfUl9IjP
        64qHLybq5EoQLdKcpjoCUKJcvH7DxJopkrLTfUu/qY3FC9+mQ8oVTVpn8pIrKI/OMU+RgFeGwwZhR
        efZ/KROF2KscbOs18sBvwcL8MbwgxDtglkUftF0pQ/eVCudcjdSNhJZAEhiXBPBh7HnpooeO/vZam
        9tPhzwCk5xbTkWnQbcbGXRXBvNhvzdH97vDKREkW+PxmdyLSeV5PPiXPxYiuTURYFVsRfoXzpQtt6
        TDUB/YFA==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by casper.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1mXgwZ-000Bp5-G8; Tue, 05 Oct 2021 09:41:10 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 86FB33002DE;
        Tue,  5 Oct 2021 11:41:02 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 6F6B2202A012E; Tue,  5 Oct 2021 11:41:02 +0200 (CEST)
Date:   Tue, 5 Oct 2021 11:41:02 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Mel Gorman <mgorman@techsingularity.net>
Cc:     Vincent Guittot <vincent.guittot@linaro.org>,
        Mike Galbraith <efault@gmx.de>, Ingo Molnar <mingo@kernel.org>,
        Valentin Schneider <valentin.schneider@arm.com>,
        Aubrey Li <aubrey.li@linux.intel.com>,
        Barry Song <song.bao.hua@hisilicon.com>,
        Srikar Dronamraju <srikar@linux.vnet.ibm.com>,
        LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 2/2] sched/fair: Scale wakeup granularity relative to
 nr_running
Message-ID: <YVwdrh5pg0zSv2/b@hirez.programming.kicks-ass.net>
References: <20210920142614.4891-1-mgorman@techsingularity.net>
 <20210920142614.4891-3-mgorman@techsingularity.net>
 <22e7133d674b82853a5ee64d3f5fc6b35a8e18d6.camel@gmx.de>
 <20210921103621.GM3959@techsingularity.net>
 <ea2f9038f00d3b4c0008235079e1868145b47621.camel@gmx.de>
 <20210922132002.GX3959@techsingularity.net>
 <CAKfTPtCxhzz1XgNXM8jaQC2=tGHm0ap88HneUgWTpCSeWVZwsw@mail.gmail.com>
 <20210922150457.GA3959@techsingularity.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210922150457.GA3959@techsingularity.net>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Sep 22, 2021 at 04:04:57PM +0100, Mel Gorman wrote:
> On Wed, Sep 22, 2021 at 04:15:27PM +0200, Vincent Guittot wrote:

> The reason I used SCHED_TUNABLESCALING_NONE for the changelog is that
> the exact values depend on the number of CPUs so values are not even
> the same across the range of machines I'm using. sysctl_sched_latency,
> sysctl_sched_min_granularity sysctl_sched_wakeup_granularity are all
> scaled but the ratios remain constant.

It might make sense to reconsider the whole scaling thing FWIW. It used
to be that desktop systems had 'small' number of CPUs (<=8) and servers
had more.

But today it's not uncommon to have 32-64 CPUs in a desktop system. And
even LOG scaling gets us into stupid numbers for the latencies.
