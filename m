Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 33696362142
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Apr 2021 15:42:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243006AbhDPNlm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 16 Apr 2021 09:41:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60838 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233606AbhDPNll (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 16 Apr 2021 09:41:41 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 17FA8C061574
        for <linux-kernel@vger.kernel.org>; Fri, 16 Apr 2021 06:41:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=R6QwyoIHLujEky6poAogx4uw5mzz6A2pMKg7WGcrQRo=; b=uqCVr2k6T9SY+UIUGXhafWZQey
        mJJXfZ4s5qyQMYJquAoUcAT2kpHmyiFXQRLBymEgc5RynJcG5N43vUs2HXG/jqQoL+sOWoV1QqNsF
        yU6wjugP5+r5DUAH/LbjZkC4ULfszxxhrwCkvVCrIsYm0DKUL/01W4qATs2m98I4xwn/wZzMyaQx7
        NW6pNKHTIyQ9AJFgsjxnvDAuSmntqO9ohOYXikaJmaAcnUXKuem+opA68j6kj5Y3oFbQgABX9Tyrd
        s3pWn+L9TyttXkJzwyTV4oc4Cwh8OtRi2pFsrGzhojwAFZQS8ZZcH4opog2VEmOENkg8is7WV3dFj
        TpjFnVuA==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by casper.infradead.org with esmtpsa (Exim 4.94 #2 (Red Hat Linux))
        id 1lXOh8-00A0RE-HL; Fri, 16 Apr 2021 13:39:55 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 87A32300212;
        Fri, 16 Apr 2021 15:39:35 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 53D962BE84B4D; Fri, 16 Apr 2021 15:39:35 +0200 (CEST)
Date:   Fri, 16 Apr 2021 15:39:35 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Namhyung Kim <namhyung@kernel.org>
Cc:     Ingo Molnar <mingo@kernel.org>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Jiri Olsa <jolsa@redhat.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        LKML <linux-kernel@vger.kernel.org>,
        Stephane Eranian <eranian@google.com>,
        Andi Kleen <ak@linux.intel.com>,
        Ian Rogers <irogers@google.com>,
        Song Liu <songliubraving@fb.com>, Tejun Heo <tj@kernel.org>,
        kernel test robot <lkp@intel.com>,
        Thomas Gleixner <tglx@linutronix.de>
Subject: Re: [PATCH v3 1/2] perf/core: Share an event with multiple cgroups
Message-ID: <YHmTl4bcjx6UA9Ko@hirez.programming.kicks-ass.net>
References: <20210413155337.644993-1-namhyung@kernel.org>
 <20210413155337.644993-2-namhyung@kernel.org>
 <YHhS6kjeA8AvcFgz@hirez.programming.kicks-ass.net>
 <CAM9d7chrHYNOB4ShJ=34WwXOUY-grXhkiW_wursywTH1FbZdvA@mail.gmail.com>
 <YHlYT+tHrkNyMFuh@hirez.programming.kicks-ass.net>
 <YHlY+qd2hF00OrFw@hirez.programming.kicks-ass.net>
 <YHlmq2q4nNSqJBw6@hirez.programming.kicks-ass.net>
 <CAM9d7cgjkZuHL=-38DTu8ieMNhLN86Ccg_UUZLb-ZF95Jv6=cw@mail.gmail.com>
 <YHl8IpC/tJSrlg7l@hirez.programming.kicks-ass.net>
 <CAM9d7chmLNTVrnKk3AEmLucR6Zi6Vd1ZESt9xNi2Q-vxudt32Q@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAM9d7chmLNTVrnKk3AEmLucR6Zi6Vd1ZESt9xNi2Q-vxudt32Q@mail.gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Apr 16, 2021 at 09:19:08PM +0900, Namhyung Kim wrote:
> > Are you actually using mmap() to read? I had a proposal for FORMAT_GROUP
> > like thing for mmap(), but I never implemented that (didn't get the
> > enthousiatic response I thought it would). But yeah, there's nowhere
> > near enough space in there for PERCPU.
> 
> Recently there's a patch to do it with rdpmc which needs to mmap first.
> 
> https://lore.kernel.org/lkml/20210414155412.3697605-1-robh@kernel.org/

Yeah, I'm not sure about that, I've not looked at it recently. The thing
is though; for RDPMC to work, you *NEED* to be on the same CPU as the
counter.

The typical RDPMC use-case is self monitoring.
