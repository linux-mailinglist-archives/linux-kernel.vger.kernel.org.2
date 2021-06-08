Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C10A139FCBF
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Jun 2021 18:45:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232555AbhFHQrZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 8 Jun 2021 12:47:25 -0400
Received: from mail.kernel.org ([198.145.29.99]:37074 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231278AbhFHQrX (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Jun 2021 12:47:23 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 89E956127A;
        Tue,  8 Jun 2021 16:45:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1623170730;
        bh=5+e3G0jIDFHNWhBPwTgnEov6WJW2KTJ2WUUQaajrIso=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=DH9rM21HpBpLvs5vxfMMXLPAHpNVYPLJQ51jeCsuy5SbZBAn0ifA7hJzmjZzzo1Sm
         AZ0NcnspjeDKTDLFvDskVzOmlnh1f5YqlaAkmMNRAHTHhr3qwCmAK2K08k2JiIKzq+
         alHfp++TTOKox7Ry+W/Y2VA19uHVCMsTDyx/asfndcHbyBHb73e5R5CffKLquObpbp
         zvIjbYomJarG0yrZpxhqqGX3wcxxmpbkeemBl+a+OysfUkK0EBlPRgxJZ/c6fBxRJA
         afhPnzVKw90VIqq9TI9j+BGMoeaL8k27ZGj2jr46wMQbnWNC2vXwAANDkta9F7ofNu
         GRZZnAI7M3jVw==
Received: by quaco.ghostprotocols.net (Postfix, from userid 1000)
        id D675440B1A; Tue,  8 Jun 2021 13:45:27 -0300 (-03)
Date:   Tue, 8 Jun 2021 13:45:27 -0300
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     Leo Yan <leo.yan@linaro.org>, Ingo Molnar <mingo@redhat.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@redhat.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>, x86@kernel.org,
        "H. Peter Anvin" <hpa@zytor.com>,
        Mathieu Poirier <mathieu.poirier@linaro.org>,
        Suzuki K Poulose <suzuki.poulose@arm.com>,
        Mike Leach <mike.leach@linaro.org>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Andi Kleen <ak@linux.intel.com>,
        linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org,
        coresight@lists.linaro.org, linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH v2 5/8] perf auxtrace: Change to use SMP memory barriers
Message-ID: <YL+epwdGJ1/tx8MF@kernel.org>
References: <20210602103007.184993-1-leo.yan@linaro.org>
 <20210602103007.184993-6-leo.yan@linaro.org>
 <YL47cyfNBx5OIRNB@hirez.programming.kicks-ass.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YL47cyfNBx5OIRNB@hirez.programming.kicks-ass.net>
X-Url:  http://acmel.wordpress.com
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Em Mon, Jun 07, 2021 at 05:29:55PM +0200, Peter Zijlstra escreveu:
> On Wed, Jun 02, 2021 at 06:30:04PM +0800, Leo Yan wrote:
> > The kernel and the userspace tool can access the AUX ring buffer head
> > and tail from different CPUs, thus SMP class of barriers are required
> > on SMP system.
> > 
> > This patch changes to use SMP barriers to replace mb() and rmb()
> > barriers.
> > 
> > Signed-off-by: Leo Yan <leo.yan@linaro.org>
> 
> Acked-by: Peter Zijlstra (Intel) <peterz@infradead.org>

Thanks, applied.

- Arnaldo

