Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C74E538C8EB
	for <lists+linux-kernel@lfdr.de>; Fri, 21 May 2021 16:06:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236558AbhEUOHe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 21 May 2021 10:07:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36542 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232170AbhEUOHc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 May 2021 10:07:32 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 06E72C061574
        for <linux-kernel@vger.kernel.org>; Fri, 21 May 2021 07:06:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=PhExRqklmWNSYFA2NeQrWGtVr2foNSqvGdEdZMWTZOA=; b=M7PpjtsImOdcUp+qdQAftJFJOd
        wX7zwtnH9sgoMdTcQKyphoWa76Q/3FJCpCW6OPOwF+FMAA4Ni+qax4qxFiK1ZcIiEhGOJl91UgdLe
        +pExS2Rv1uU9zL6ANoP9dPUe5OdOk9X+EEiHxNiUPADI7q2fcz26KQSTudALNkacVTSmihAVTdX+I
        7Z3vjP3jeDdYZNHluYcG1Ty83RBuM1V7KDmPhxfqeGlqoCQDOjutCpGTC6HrCp77ISztFQJty+6uD
        NT98tHGWoudkOw1GSQRJLPmeRbJwBOtpQwteNRnEbBV9dfevimEEZfE8xCjCt6FWsxLrPtstCUphp
        CL3aR5Cg==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by casper.infradead.org with esmtpsa (Exim 4.94 #2 (Red Hat Linux))
        id 1lk5i8-00H0p6-2y; Fri, 21 May 2021 14:01:37 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id B2E743001D0;
        Fri, 21 May 2021 16:01:07 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id A1BAA30D63CA1; Fri, 21 May 2021 16:01:07 +0200 (CEST)
Date:   Fri, 21 May 2021 16:01:07 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Huaixin Chang <changhuaixin@linux.alibaba.com>
Cc:     bsegall@google.com, dietmar.eggemann@arm.com,
        dtcccc@linux.alibaba.com, juri.lelli@redhat.com,
        khlebnikov@yandex-team.ru, linux-kernel@vger.kernel.org,
        mgorman@suse.de, mingo@redhat.com, odin@uged.al, odin@ugedal.com,
        pauld@redhead.com, pjt@google.com, rostedt@goodmis.org,
        shanpeic@linux.alibaba.com, tj@kernel.org,
        vincent.guittot@linaro.org, xiyou.wangcong@gmail.com
Subject: Re: [PATCH v5 2/3] sched/fair: Add cfs bandwidth burst statistics
Message-ID: <YKe9I5YfgRWvYmFn@hirez.programming.kicks-ass.net>
References: <20210520123419.8039-1-changhuaixin@linux.alibaba.com>
 <20210520123419.8039-3-changhuaixin@linux.alibaba.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210520123419.8039-3-changhuaixin@linux.alibaba.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, May 20, 2021 at 08:34:18PM +0800, Huaixin Chang wrote:
> When using cfs_b and meeting with some throttled periods, users shall
> use burst buffer to allow bursty workloads. Apart from configuring some
> burst buffer and watch whether throttled periods disappears, some
> statistics on burst buffer using are also helpful. Thus expose the
> following statistics into cpu.stat file:
> 

Helpful how.. the above is a bunch of words without any actual
justification for any of this.
