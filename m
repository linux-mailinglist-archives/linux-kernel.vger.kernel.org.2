Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 75C6F39012C
	for <lists+linux-kernel@lfdr.de>; Tue, 25 May 2021 14:43:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232721AbhEYMoc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 25 May 2021 08:44:32 -0400
Received: from mail.kernel.org ([198.145.29.99]:40866 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232633AbhEYMo2 (ORCPT <rfc822;Linux-kernel@vger.kernel.org>);
        Tue, 25 May 2021 08:44:28 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 3312A6141B;
        Tue, 25 May 2021 12:42:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1621946578;
        bh=4hFXdaa+czQrgsQ6iQYUi3PvmMbX8a59mxPryHgu15E=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=dN+IebLqwczjVpVfJuT8AcKUHHPgvVEuT4HGk76hnmdEwE3csn1UfeT0pO+6xjMRu
         PTC+86S4S8KbLXGF8E6PBaPCZ1/5lGm7RaN1vs6j1G5zGrjUvpILEzmOMBgxXOo8pa
         /YxjWM3HZjiwvbyeYOk7y0V/skccYbmADbRU8emAe09QayXforlyCcgTKv927JYj/g
         5G6xTlwYoXwTj1GsRK4p6WJfK4phyI4UloEFUL0i+VaqGGFpJpADw8bobfchL/cJKb
         DW1DbBdSEWqPdcneT4okGTgZi5017hRg0thhUJQIlzyKwCEHg4XYiYbnehLpYlkjHC
         AP4ek+PR4bwKQ==
Received: by quaco.ghostprotocols.net (Postfix, from userid 1000)
        id A81254011C; Tue, 25 May 2021 09:42:55 -0300 (-03)
Date:   Tue, 25 May 2021 09:42:55 -0300
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     "Jin, Yao" <yao.jin@linux.intel.com>
Cc:     Ian Rogers <irogers@google.com>, Jiri Olsa <jolsa@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        LKML <Linux-kernel@vger.kernel.org>,
        Andi Kleen <ak@linux.intel.com>,
        Kan Liang <kan.liang@intel.com>, "Jin, Yao" <yao.jin@intel.com>
Subject: Re: [PATCH 1/4] perf vendor events: Add core event list for Icelake
 Server
Message-ID: <YKzwzyM8YSsxRBJ8@kernel.org>
References: <20210510012438.6293-1-yao.jin@linux.intel.com>
 <20210510012438.6293-2-yao.jin@linux.intel.com>
 <CAP-5=fUPbc0T9283MxxPhqdu+zvxNKvJsY5R5CuyS2K4SPtiJg@mail.gmail.com>
 <YKgMz52O9mVjPH3K@kernel.org>
 <c0f27643-bebb-2912-56ed-f7abec7dbde3@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <c0f27643-bebb-2912-56ed-f7abec7dbde3@linux.intel.com>
X-Url:  http://acmel.wordpress.com
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Em Mon, May 24, 2021 at 09:08:12AM +0800, Jin, Yao escreveu:
> On 5/22/2021 3:41 AM, Arnaldo Carvalho de Melo wrote:
> > Em Thu, May 20, 2021 at 09:08:37AM -0700, Ian Rogers escreveu:
> > > Acked-by: Ian Rogers<irogers@google.com>
> > ⬢[acme@toolbox perf]$ am
> > Applying: perf vendor events: Add core event list for Icelake Server
> > error: corrupt patch at line 2771
> > Patch failed at 0001 perf vendor events: Add core event list for Icelake Server
> > hint: Use 'git am --show-current-patch=diff' to see the failed patch
> > When you have resolved this problem, run "git am --continue".
> > If you prefer to skip this patch, run "git am --skip" instead.
> > To restore the original branch and stop patching, run "git am --abort".
> > ⬢[acme@toolbox perf]$
> > ⬢[acme@toolbox perf]$ git diff
> > ⬢[acme@toolbox perf]$ git am --abort
> > ⬢[acme@toolbox perf]$ patch -p1 < ~/wb/1.patch
> > patching file tools/perf/pmu-events/arch/x86/icelakex/cache.json
> > patching file tools/perf/pmu-events/arch/x86/icelakex/floating-point.json
> > patching file tools/perf/pmu-events/arch/x86/icelakex/frontend.json
> > patching file tools/perf/pmu-events/arch/x86/icelakex/memory.json
> > patching file tools/perf/pmu-events/arch/x86/icelakex/other.json
> > patching file tools/perf/pmu-events/arch/x86/icelakex/pipeline.json
> > patch: **** malformed patch at line 1927:   less than MAX. The reset value to the counter is not clocked immediately so the overflow status bit will flip 'high (1)' and generate another PMI (if enabled) after which the reset value gets clocked into the counter. Therefore, software will get the interrupt, read the overflow status bit '1 for bit 34 while the counter value is less than MAX. Software should ignore this case.",
> > 
> > ⬢[acme@toolbox perf]$
> > 
> > Please check.
> > 
> > - Arnaldo
> 
> Could you pull the top 4 patches from "https://github.com/yaoj/icx-events.git"?
> 
> perf vendor events: Update event list for Icelake Client
> perf vendor events: Add metrics for Icelake Server
> perf vendor events: Add uncore event list for Icelake Server
> perf vendor events: Add core event list for Icelake Server
> 
> The patch is too big and it's possibly corrupted by mailing system.

Thanks, applied.

- Arnaldo
