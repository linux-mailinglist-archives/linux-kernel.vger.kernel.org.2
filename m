Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 19FA6360553
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Apr 2021 11:12:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231536AbhDOJMY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 15 Apr 2021 05:12:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52976 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231143AbhDOJMX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Apr 2021 05:12:23 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D3925C061574
        for <linux-kernel@vger.kernel.org>; Thu, 15 Apr 2021 02:12:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=4D66rvNXayldPIaenxD3qS5PoTu3GvzifCOGXTuJfzs=; b=mdr/IwTeGEbp53xL+7G6uVNsUS
        5PN4eyKAfE+sZvemytDLLqiV+i3HrGs5JPbQMhL/xIWCq/7ejo833yaWtDvfQvM5DPYSKp1s0yU/Y
        se80xd2qwaL/8cUIfzgOVKRrs/6FZVmseaA30AGtOzsKcs21geZc1RZ+pfrpZwBvnR6XJliNmonEc
        lFblWnWK9UtyOfmxfinr92ASCQKMXXQEtTThPm2x57viVKqbUMsFHF8Dvx4c/E8AfQ03c7ByGGCk8
        d0wPgc18WVO5fs6F2oe0FSzwQp1dm5PNhSsqwYgnJmQNgr7ffq0xOW8CuLBlJyp4Q8AEtdSr6YBxQ
        TWImjKrw==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by casper.infradead.org with esmtpsa (Exim 4.94 #2 (Red Hat Linux))
        id 1lWy2L-008LLY-6b; Thu, 15 Apr 2021 09:11:47 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 37B93300209;
        Thu, 15 Apr 2021 11:11:44 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 19CC22022421A; Thu, 15 Apr 2021 11:11:44 +0200 (CEST)
Date:   Thu, 15 Apr 2021 11:11:44 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Marco Elver <elver@google.com>
Cc:     kbuild-all@lists.01.org, kernel test robot <lkp@intel.com>,
        linux-kernel@vger.kernel.org
Subject: Re: [peterz-queue:perf/core 18/22] kernel/events/core.c:6418:22:
 sparse: sparse: incorrect type in assignment (different address spaces)
Message-ID: <YHgDUEX7ogOkb60O@hirez.programming.kicks-ass.net>
References: <202104142209.hLOfOONR-lkp@intel.com>
 <YHb9Mi1IwY5qtJxp@elver.google.com>
 <YHf92aCeN65rANQY@hirez.programming.kicks-ass.net>
 <YHgBTRciZNDUkfId@elver.google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YHgBTRciZNDUkfId@elver.google.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Apr 15, 2021 at 11:03:09AM +0200, Marco Elver wrote:
> On Thu, Apr 15, 2021 at 10:48AM +0200, Peter Zijlstra wrote:

> > I've ended up with the below delta, does that work for you?
> 
> Thanks, that works for me. Do note that I explicitly chose u64 for
> sig_addr/pending_addr because data->addr is u64. There might be a new
> warning about the u64 to unsigned long assignment on 32 bit arches.

My local i386-defconfig build seemed happy now. Mostly I think you're
allowed to silently truncate between base integer types. We'll see..
maybe some other compiler.

> Perhaps it needs something ugly like this:
> 
> 	info.si_addr = (void __user *)(unsigned long)event->pending_addr;
> 
> if pending_addr wants to be u64. Or just
> 
> 	event->pending_addr = (unsigned long)data->addr;
> 
> if data->addr being u64 on 32 bit arches is simply overkill.

Yeah it is. It's u64 for data layout purposes, the perf buffer works in
u64 chunks.
