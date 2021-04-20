Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 07DA73655BE
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Apr 2021 11:49:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231453AbhDTJte (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 20 Apr 2021 05:49:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45744 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231246AbhDTJtd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Apr 2021 05:49:33 -0400
Received: from desiato.infradead.org (desiato.infradead.org [IPv6:2001:8b0:10b:1:d65d:64ff:fe57:4e05])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D9695C06174A
        for <linux-kernel@vger.kernel.org>; Tue, 20 Apr 2021 02:49:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=desiato.20200630; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=c/4ebdPoDkXsRQNBUYWS70TUfZuUFjko8Cp0we1f+BM=; b=BulSmpljSK+FX7V38AZr3XoNb6
        CylJg8sIm/YyS9UMI9z82G6/ycIVoB1vQmu5dk/kLGkmceZn4UpjRT4zo4gdKSX7M6WwQW9MmG8Ft
        ZQTHBEI7RT5iiEFnu3nJHmGBSppCeMcXBjWd7Ls3VLLAR0dy/ElHWx8nrM0D+kJKXY6IwID4zHaho
        rEEOxgoEOyBlY/w5FwZCtypV53bhyWVj+teXoScwmnrdlbh1RwRbZTmMJBk9CvUIZOXdyJ7isAEsh
        W8EQZX3vlPg/nHJIJ6wrviZvJHVOpMOt6U2PZBIyDhLUHxxnV4WoFcioPLYE0w7yBYcwMKRrhafmv
        /NV1+A5g==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by desiato.infradead.org with esmtpsa (Exim 4.94 #2 (Red Hat Linux))
        id 1lYmzx-00BoJe-4j; Tue, 20 Apr 2021 09:48:49 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 58725300130;
        Tue, 20 Apr 2021 11:48:48 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 3E6EE2C48E3A3; Tue, 20 Apr 2021 11:48:48 +0200 (CEST)
Date:   Tue, 20 Apr 2021 11:48:48 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Stephane Eranian <eranian@google.com>
Cc:     Namhyung Kim <namhyung@kernel.org>, Ingo Molnar <mingo@kernel.org>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Jiri Olsa <jolsa@redhat.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        LKML <linux-kernel@vger.kernel.org>,
        Andi Kleen <ak@linux.intel.com>,
        Ian Rogers <irogers@google.com>,
        Song Liu <songliubraving@fb.com>, Tejun Heo <tj@kernel.org>,
        kernel test robot <lkp@intel.com>,
        Thomas Gleixner <tglx@linutronix.de>
Subject: Re: [PATCH v3 1/2] perf/core: Share an event with multiple cgroups
Message-ID: <YH6jgMWpFXy+pFVP@hirez.programming.kicks-ass.net>
References: <20210413155337.644993-1-namhyung@kernel.org>
 <20210413155337.644993-2-namhyung@kernel.org>
 <YHhS6kjeA8AvcFgz@hirez.programming.kicks-ass.net>
 <CABPqkBTncWfeFWY=kYXTAr3gRjpyFVL-YJN4K1YOPpHO35PHBw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CABPqkBTncWfeFWY=kYXTAr3gRjpyFVL-YJN4K1YOPpHO35PHBw@mail.gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Apr 20, 2021 at 01:34:40AM -0700, Stephane Eranian wrote:
> The sampling approach will certainly incur more overhead and be at
> risk of losing the ability to
> reconstruct the total counter per-cgroup, unless  you set the period
> for SW_CGROUP_SWITCHES to
> 1. But then, you run the risk of losing samples if the buffer is full
> or sampling is throtlled.
> In some scenarios, we believe the number of context switches between
> cgroup could be quite high (>> 1000/s).
> And on top you would have to add the processing of the samples to
> extract the counts per cgroup. That would require
> a synthesis on cgroup on perf record and some post-processing on perf
> report. We are interested in using the data live
> to make some policy decisions, so a counting approach with perf stat
> will always be best.

Can you please configure your MUA to sanely (re)flow text? The above
random line-breaks are *so* painful to read.
