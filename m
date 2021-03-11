Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 52FFA337291
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Mar 2021 13:30:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232893AbhCKM3a (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 11 Mar 2021 07:29:30 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33532 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232827AbhCKM3P (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 11 Mar 2021 07:29:15 -0500
Received: from desiato.infradead.org (desiato.infradead.org [IPv6:2001:8b0:10b:1:d65d:64ff:fe57:4e05])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4F553C061574
        for <linux-kernel@vger.kernel.org>; Thu, 11 Mar 2021 04:29:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=desiato.20200630; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=nftliI7lxqJjvNeNTPypOl0r+ezAx4vf2rO72Qoh/2k=; b=EdfPUOanR9K4evUAAiDAlF3gwE
        bidSLFjC1z7SK9gHG9pxm92TihzdGXQdI0mnWU4T+96N/Jaukxl1BLXQvyMvKbyidRPJ/W1i6tjxQ
        caQQL27yBjIwFcdfA8ON6jW4k72JkzFLXbKpjSNEg3XXWIGe901/EP8aqtxFbFud5gtGO/eFf1PVQ
        5s5qRBT/VkxJf6KY7pKRSYLcp0KHmObUPr5Ls6GdDAyxxwlQ+VjZUXWWNqywMZOkAkXc9MRUsUp1w
        yj02DWJR+bRaVBiqu1WJHZFtRh8rPrP1HF62MsG5eRRhBf0hz6eC+c6nakHK3gpOHpwGBvRLa3EVC
        GHMNcw/A==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by desiato.infradead.org with esmtpsa (Exim 4.94 #2 (Red Hat Linux))
        id 1lKKRB-0095hP-FZ; Thu, 11 Mar 2021 12:29:09 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id D4D813011F0;
        Thu, 11 Mar 2021 13:29:08 +0100 (CET)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id B9E2529D00066; Thu, 11 Mar 2021 13:29:08 +0100 (CET)
Date:   Thu, 11 Mar 2021 13:29:08 +0100
From:   Peter Zijlstra <peterz@infradead.org>
To:     Namhyung Kim <namhyung@kernel.org>
Cc:     Arnaldo Carvalho de Melo <acme@kernel.org>,
        Jiri Olsa <jolsa@redhat.com>, Ingo Molnar <mingo@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        LKML <linux-kernel@vger.kernel.org>,
        Stephane Eranian <eranian@google.com>,
        Andi Kleen <ak@linux.intel.com>,
        Ian Rogers <irogers@google.com>,
        David Rientjes <rientjes@google.com>,
        Namhyung Kim <namhyung@google.com>
Subject: Re: [PATCH 1/2] perf core: Add a kmem_cache for struct perf_event
Message-ID: <YEoNFA5gI0jp/zlF@hirez.programming.kicks-ass.net>
References: <20210311115413.444407-1-namhyung@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210311115413.444407-1-namhyung@kernel.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Mar 11, 2021 at 08:54:12PM +0900, Namhyung Kim wrote:
> From: Namhyung Kim <namhyung@google.com>
> 
> The kernel can allocate a lot of struct perf_event when profiling. For
> example, 256 cpu x 8 events x 20 cgroups = 40K instances of the struct
> would be allocated on a large system.
> 
> The size of struct perf_event in my setup is 1152 byte. As it's
> allocated by kmalloc, the actual allocation size would be rounded up
> to 2K.
> 
> Then there's 896 byte (~43%) of waste per instance resulting in total
> ~35MB with 40K instances. We can create a dedicated kmem_cache to
> avoid such a big unnecessary memory consumption.
> 
> With this change, I can see below (note this machine has 112 cpus).
> 
>   # grep perf_event /proc/slabinfo
>   perf_event    224    784   1152    7    2 : tunables   24   12    8 : slabdata    112    112      0
> 
> The sixth column is pages-per-slab which is 2, and the fifth column is
> obj-per-slab which is 7.  Thus actually it can use 1152 x 7 = 8064
> byte in the 8K, and wasted memory is (8192 - 8064) / 7 = ~18 byte per
> instance.
> 
> Signed-off-by: Namhyung Kim <namhyung@kernel.org>

Thanks for both!
