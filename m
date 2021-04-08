Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5B1FB358A0E
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Apr 2021 18:47:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232424AbhDHQrz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 8 Apr 2021 12:47:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54534 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231875AbhDHQrw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Apr 2021 12:47:52 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 99BB0C061760
        for <linux-kernel@vger.kernel.org>; Thu,  8 Apr 2021 09:47:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=Awc4a78ImGMMFwFmf26yWmXz0dBMHirnR/SXr30ta84=; b=YyE1lRdFv5CDQU4JTapuTPChsj
        X8hRySfEu27zEExT9Xj8nyLb1YQzPq5p/cQxNLFzAdwsadMpu+beUP5N2xxS9FfvTSJVy6mWyMdrq
        lFhzNchrdSucAueKe4+ERGQ5kDq0iOMNwgCrYo68FEyDnOKVX6mAkWnBcp96Ma6V1cz5W1KsKbzwJ
        g+og6JqG9hY0DN13nqdIloLG00PY+hS4Go5Vg0nl6jWPKMBM7d5DJs8O6SZ0MnhICPY+jFIyKLHlu
        F7vctNQwJu05Wf48GG9VkZrGl1WpnrkHCX9stUW51F++DEjF0MdBsR2xvIcmqGseLBufKZndGgydb
        aZo3yJZg==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by casper.infradead.org with esmtpsa (Exim 4.94 #2 (Red Hat Linux))
        id 1lUXna-00GXc4-S9; Thu, 08 Apr 2021 16:46:43 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 431A93001C3;
        Thu,  8 Apr 2021 18:46:30 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id D63F12BD0DAEE; Thu,  8 Apr 2021 16:19:52 +0200 (CEST)
Date:   Thu, 8 Apr 2021 16:19:52 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     kan.liang@linux.intel.com
Cc:     mingo@kernel.org, linux-kernel@vger.kernel.org, acme@kernel.org,
        tglx@linutronix.de, bp@alien8.de, namhyung@kernel.org,
        jolsa@redhat.com, ak@linux.intel.com, yao.jin@linux.intel.com,
        alexander.shishkin@linux.intel.com, adrian.hunter@intel.com,
        ricardo.neri-calderon@linux.intel.com
Subject: Re: [PATCH V5 04/25] perf/x86/intel: Hybrid PMU support for perf
 capabilities
Message-ID: <YG8RCCN7iszBlJu9@hirez.programming.kicks-ass.net>
References: <1617635467-181510-1-git-send-email-kan.liang@linux.intel.com>
 <1617635467-181510-5-git-send-email-kan.liang@linux.intel.com>
 <YG8H6Fac/p6PpcAu@hirez.programming.kicks-ass.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YG8H6Fac/p6PpcAu@hirez.programming.kicks-ass.net>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Apr 08, 2021 at 03:40:56PM +0200, Peter Zijlstra wrote:
> On Mon, Apr 05, 2021 at 08:10:46AM -0700, kan.liang@linux.intel.com wrote:
> > +static inline bool intel_pmu_has_cap(struct perf_event *event, int idx)
> > +{
> > +	union perf_capabilities *intel_cap;
> > +
> > +	intel_cap = is_hybrid() ? &hybrid_pmu(event->pmu)->intel_cap :
> > +				  &x86_pmu.intel_cap;
> 
> This isn't:
> 
> 	intel_cap = &hybrid_pmu(event->pmu)->intel_cap;

Ah no, its because you want a pointer and GCC is being silly about that.

I have something for that, hold on ;-)
