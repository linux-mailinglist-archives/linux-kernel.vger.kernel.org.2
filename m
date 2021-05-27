Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6B19A392B11
	for <lists+linux-kernel@lfdr.de>; Thu, 27 May 2021 11:46:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235818AbhE0Jr4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 27 May 2021 05:47:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40076 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235675AbhE0Jrx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 May 2021 05:47:53 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F1C43C061574;
        Thu, 27 May 2021 02:46:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=n7pbimY5RhMCrIFl8a7lT/d6/Mh0XzzXYzygTqnwBzg=; b=t6OC6OuDTPgxV6GBKtZHindnvr
        By7STzKnKW9CXowUsfozY4Lu+VizxQo20GobPOoc8WO1t825WDf8Lpx2dKNdsfFvbYta0pSyQoEmq
        VvWyeHkBznOmqGNxI2jPSdJiAqeV2z9e/sLwmpHRZhRoX+qf89egUvt79XWvhzf39tvBSGhrzAOIh
        GT6tgUyh1jWaCArH98jfw3yYZ7mu8uG3s5ztkrRpuKCQWkR0cAxnuLlgsVYYADS7DgfggDZIfYGZy
        /GIamZEPxr5y85A17zLJb2OVyrigmo6bTCKOoC5u2BDTf3i5bGckvWa/nhf+AEV7UVXSpcCDUArS3
        9HbbWS/g==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by casper.infradead.org with esmtpsa (Exim 4.94 #2 (Red Hat Linux))
        id 1lmCZv-005OsO-Mx; Thu, 27 May 2021 09:45:32 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id DC610300202;
        Thu, 27 May 2021 11:45:21 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id C2D79200AA2D1; Thu, 27 May 2021 11:45:21 +0200 (CEST)
Date:   Thu, 27 May 2021 11:45:21 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Adrian Hunter <adrian.hunter@intel.com>
Cc:     Leo Yan <leo.yan@linaro.org>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Ingo Molnar <mingo@redhat.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Andi Kleen <ak@linux.intel.com>,
        linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v1 1/2] perf auxtrace: Change to use SMP memory barriers
Message-ID: <YK9qMWMRWIMfzcPh@hirez.programming.kicks-ass.net>
References: <20210519140319.1673043-1-leo.yan@linaro.org>
 <d1fc3dd3-e79a-4e93-1083-6b08e0cabe59@intel.com>
 <YK9UFl7Grv/mwmVc@hirez.programming.kicks-ass.net>
 <3c7dcd5d-fddd-5d3b-81ac-cb7b615b0338@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3c7dcd5d-fddd-5d3b-81ac-cb7b615b0338@intel.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, May 27, 2021 at 11:25:40AM +0300, Adrian Hunter wrote:
> On 27/05/21 11:11 am, Peter Zijlstra wrote:
> > On Thu, May 27, 2021 at 10:54:56AM +0300, Adrian Hunter wrote:
> >> On 19/05/21 5:03 pm, Leo Yan wrote:
> >>> The AUX ring buffer's head and tail can be accessed from multiple CPUs
> >>> on SMP system, so changes to use SMP memory barriers to replace the
> >>> uniprocessor barriers.
> >>
> >> I don't think user space should attempt to be SMP-aware.
> > 
> > Uhh, what? It pretty much has to. Since userspace cannot assume UP, it
> > must assume SMP.
> 
> Yeah that is what I meant, but consequently we generally shouldn't be
> using functions called smp_<anything>

Of course we should; they're the SMP class of barriers.

> > So ACK on the patch, it's sane and an optimization for both x86 and ARM.
> > Just the Changelog needs work.
> 
> If all we want is a compiler barrier, then shouldn't that be what we use?
> i.e. barrier()

No, we want the SMP barriers, smp_rmb() happens to be a compiler barrier
on x86, but it will be dmb(ishld) on Aarrgh64 for example.

