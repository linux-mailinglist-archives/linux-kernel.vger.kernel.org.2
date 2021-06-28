Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 375573B6609
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Jun 2021 17:47:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236102AbhF1Pta (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 28 Jun 2021 11:49:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52848 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236468AbhF1PtV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Jun 2021 11:49:21 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4CA67C07022D
        for <linux-kernel@vger.kernel.org>; Mon, 28 Jun 2021 08:17:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=UCh6iBPEHja/qgpskO076dXtlVpWQGRfETtCClODLVM=; b=KhMq2skMcLoT0pZ6RSLrk2YnT4
        08mYoUEg7SCbX/wfnfg+oa4pp81I00dbMmwqWfX1b5KWKyCeLvSwQqRZzRrE6/2tW0JJYDYjvL8U0
        Qjsmv+XE3iZz6+xHjkga+5/veHTMxC3fTc+BSHHkRi8RxHSZkQ+JmNxxZ4vlfbl5EsncCdchB31In
        aS5NR8SnFekEqOYUVoQyaTt+D2pQ5PyD8dKiBQ0pLVRWy9Gdy1UD4WYZ8slisp1gQzCJt3GdZg7yA
        df/S+HnBPlCGVlUJknXG7V+AKT7zEx0wcQfBS3lj9nU7ta98QCVxSSgw1bxjxckNhfGIlmqeElwiU
        aIVBZoqA==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by casper.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1lxsvt-0038AI-T6; Mon, 28 Jun 2021 15:12:47 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 87A8130022B;
        Mon, 28 Jun 2021 17:12:17 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 466192041E874; Mon, 28 Jun 2021 17:12:17 +0200 (CEST)
Date:   Mon, 28 Jun 2021 17:12:17 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Huaixin Chang <changhuaixin@linux.alibaba.com>
Cc:     luca.abeni@santannapisa.it, anderson@cs.unc.edu, baruah@wustl.edu,
        bsegall@google.com, dietmar.eggemann@arm.com,
        dtcccc@linux.alibaba.com, juri.lelli@redhat.com,
        khlebnikov@yandex-team.ru, linux-kernel@vger.kernel.org,
        mgorman@suse.de, mingo@redhat.com, odin@uged.al, odin@ugedal.com,
        pauld@redhead.com, pjt@google.com, rostedt@goodmis.org,
        shanpeic@linux.alibaba.com, tj@kernel.org,
        tommaso.cucinotta@santannapisa.it, vincent.guittot@linaro.org,
        xiyou.wangcong@gmail.com
Subject: Re: [PATCH v6 2/3] sched/fair: Add cfs bandwidth burst statistics
Message-ID: <YNnm0bUfCmB54FYW@hirez.programming.kicks-ass.net>
References: <20210621092800.23714-1-changhuaixin@linux.alibaba.com>
 <20210621092800.23714-3-changhuaixin@linux.alibaba.com>
 <YNnkDnJtliEInwTY@hirez.programming.kicks-ass.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YNnkDnJtliEInwTY@hirez.programming.kicks-ass.net>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jun 28, 2021 at 05:00:30PM +0200, Peter Zijlstra wrote:
> I was hoping we could get away with something simpler, like maybe:
> 
> 	u64 old_runtim = cfs_b->runtime;
> 
> 	cfs_b->runtime += cfs_b->quota
> 	cfs_b->runtime = min(cfs_b->runtime, cfs_b->quota + cfs_b->burst);
> 
> 	if (cfs_b->runtime - old_runtime > cfs_b->quota)
> 		cfs_b->nr_bursts++;
> 
> Would that be good enough?

Bah,, of course not ... :-/ At best we can detect == quota, which might
be a good enough indicator of burst.
