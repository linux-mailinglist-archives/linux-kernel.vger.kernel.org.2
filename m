Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D138F41495D
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Sep 2021 14:45:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235996AbhIVMrO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 22 Sep 2021 08:47:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60356 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235227AbhIVMrN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Sep 2021 08:47:13 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7262AC061574
        for <linux-kernel@vger.kernel.org>; Wed, 22 Sep 2021 05:45:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=pVHABphFhruviXq8IYSbGzg6BVth9xqrd/+O0O4i6xk=; b=mcmcKEtUpcHRhLT3y50IhTYTrw
        TppQ9rj1eJ8ReDWH28Eq6Tly5fjepGOfkJ903gJW8xBgk0ATQv8GpbRy7loW4qCA8X6Qyh/g8qp3n
        na4+04Vt2zb2U2KZAgK7mMaz2mBWfSPfFDdOIkU7sd6LXn92J8rvmE3qz/wqtzFsMuG1GsGKdFNP1
        sa5OFUIs/EABJlqwvCeFqhU4OFYM6T87TaeljjnLS5eHbAMW2r7w/kD3URxGaQYIGUa3Q7GIZjqsi
        QgGfBG0EViW7guAAXbMthgenEbVVXvBFkJz2iNmn0eBH9BVtF3lifnQ+Ob5aQ+HcabbtX3mGEjHMh
        RpAh0LDQ==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=worktop.programming.kicks-ass.net)
        by casper.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1mT1bV-004moD-Tf; Wed, 22 Sep 2021 12:44:21 +0000
Received: by worktop.programming.kicks-ass.net (Postfix, from userid 1000)
        id A54E59816EA; Wed, 22 Sep 2021 14:44:00 +0200 (CEST)
Date:   Wed, 22 Sep 2021 14:44:00 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     kernel test robot <oliver.sang@intel.com>
Cc:     Mel Gorman <mgorman@techsingularity.net>,
        LKML <linux-kernel@vger.kernel.org>, x86@kernel.org,
        lkp@lists.01.org, lkp@intel.com, ying.huang@intel.com,
        feng.tang@intel.com, zhengjun.xing@linux.intel.com,
        aubrey.li@linux.intel.com, yu.c.chen@intel.com
Subject: Re: [sched/fair]  56498cfb04:  netperf.Throughput_tps -5.4%
 regression
Message-ID: <20210922124400.GQ4323@worktop.programming.kicks-ass.net>
References: <20210912153447.GG25450@xsang-OptiPlex-9020>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210912153447.GG25450@xsang-OptiPlex-9020>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Sep 12, 2021 at 11:34:47PM +0800, kernel test robot wrote:
> 
> 
> Greeting,
> 
> FYI, we noticed a -5.4% regression of netperf.Throughput_tps due to commit:
> 
> 
> commit: 56498cfb045d7147cdcba33795d19429afcd1d00 ("sched/fair: Avoid a second scan of target in select_idle_cpu")
> https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master

Mel, was this in line with your own benchmarks?
