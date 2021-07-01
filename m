Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7675C3B9352
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Jul 2021 16:26:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233827AbhGAO3O (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 1 Jul 2021 10:29:14 -0400
Received: from mail.kernel.org ([198.145.29.99]:37444 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232618AbhGAO3N (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Jul 2021 10:29:13 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 2EA0661409;
        Thu,  1 Jul 2021 14:26:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1625149603;
        bh=qKgx3HCbAl2O2yMXpHyqALqNcKKjqeW9rIOXBgMJ7IA=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=nh/mDDRFcF/2ERPfAlGxzAAnpIBLl32hGqC3dePCwwzv5eOHW8+0nuXCG48gb4nJn
         CLmQhwPJBB/i/DP+szXSrfae7rPfNcYuJzoEDEo2RRZNsRPEG0mxvVCiFuw1ZB4/ao
         8OCw18ZCRtR0YLg4AWLAlQmdaQY+CdZ6lqSFcAw/bhBK4alxUqc9MlGvC0GzFJx52H
         J2HEOe7L7dxk6Y3dCahKAnpM6a7a1edx90snCUEeAkpEF41ju1T5msGbLcENZceDVT
         rKaNoeMe5ppMZcrAZgsLgOBEpstpmDv8l+4N/NKYncwH+HziAeLsTToKryIeTJnRK5
         6H75vfxhc/nmw==
Received: by quaco.ghostprotocols.net (Postfix, from userid 1000)
        id C5D2840B1A; Thu,  1 Jul 2021 11:26:39 -0300 (-03)
Date:   Thu, 1 Jul 2021 11:26:39 -0300
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     "Bayduraev, Alexey V" <alexey.v.bayduraev@linux.intel.com>
Cc:     Jiri Olsa <jolsa@redhat.com>, Namhyung Kim <namhyung@kernel.org>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Andi Kleen <ak@linux.intel.com>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Alexander Antonov <alexander.antonov@linux.intel.com>,
        Alexei Budankov <abudankov@huawei.com>,
        Riccardo Mancini <rickyman7@gmail.com>
Subject: Re: [PATCH v8 10/22] perf record: Introduce --threads=<spec> command
 line option
Message-ID: <YN3Qn5mO5cPffPZa@kernel.org>
References: <cover.1625065643.git.alexey.v.bayduraev@linux.intel.com>
 <e0069b09cb53d9149ba651474ce65faf6a001303.1625065643.git.alexey.v.bayduraev@linux.intel.com>
 <YNyprxe/0EiImxpF@kernel.org>
 <e2aca481-2623-10fb-850b-88ec7870d9cf@linux.intel.com>
 <00e9de2e-3963-1507-9eb0-40d419bf9a49@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <00e9de2e-3963-1507-9eb0-40d419bf9a49@linux.intel.com>
X-Url:  http://acmel.wordpress.com
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Em Thu, Jul 01, 2021 at 02:50:40PM +0300, Bayduraev, Alexey V escreveu:
> On 30.06.2021 21:54, Bayduraev, Alexey V wrote:
> > On 30.06.2021 20:28, Arnaldo Carvalho de Melo wrote:
> >> I thought you would start with plain:

> >>   -j N

> >> And start one thread per CPU in 'perf record' existing CPU affinity
> >> mask, then go on introducing more sophisticated modes.

> > As I remember the first prototype [1] and 
> > [2] https://lore.kernel.org/lkml/20180913125450.21342-1-jolsa@kernel.org/

> > introduces: 

> > --thread=mode|number_of_threads

> > where mode defines cpu masks (cpu/numa/socket/etc)

> > Then somewhere while discussing this patchset it was decided, for unification,
> > that --thread should only define CPU/affinity masks or their aliases.
> > I think Alexei or Jiri could clarify this more.

> >> Have you done this way because its how VTune has evolved over the years
> >> and now expects from 'perf record'?

> > VTune uses only --thread=cpu or no threading.

> However we would like to have such sophisticated cpu/affinity masks to
> tune perf-record for different workloads.

I don't have, a priori, anything against the modes you propose, as you
have a justification for them, its just how we should introduce that.

I.e. first doing the simple case of '-j NCPUS' and then doing what you
need, so that we get more granular patches.

Not adding too much complexity per patch pays off when/if we find bugs
and need to bisect.

> For example, some HPC workloads prefer "numa" mask or most of telecom
> workloads disallow to use cpus where their non-preemtable
> communication threads work.

- Arnaldo
