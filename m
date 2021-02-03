Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id ACFCD30DABB
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Feb 2021 14:13:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231330AbhBCNKl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 3 Feb 2021 08:10:41 -0500
Received: from mail.kernel.org ([198.145.29.99]:54134 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229567AbhBCNKi (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 Feb 2021 08:10:38 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id BDF1A64F95;
        Wed,  3 Feb 2021 13:09:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1612357798;
        bh=LVaVyGwKB0zFRhNt7Enx1UWfsKDDaJ29bO2ok7yaRLo=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=AfyW8f2//akC84jB8VRV2RgNeJf2VT//ait1Um/1pUt6K7ju+sYqYkFI/JYPf6VMF
         EFsRZyxPclLGAfznEGGTjmZQW1FmKauEDXd9S6oSwWUKZ/AB9Z6bUr+Y6O7rL0b9I/
         QmrBg4Imb1MOOZFU/pK6yALEb1NdZ1gCmu35/+TcwbR/BcNWMqxdnIGAjeuHvRd4xK
         Y2xOj4QluQ2HKCBYaMjoJfJr37ojLSU5CkJ9WRgmkhJOJKaN3xC1WAfmMMkEbBoucl
         nAZQn9z/0umvAwRHopOx9SlUfEKZ6Uy/3bXuJDXD9+tSS7ingoCezdSr84qGJOiE/j
         8vGUVJJPYvWrQ==
Received: by quaco.ghostprotocols.net (Postfix, from userid 1000)
        id 4C75A40513; Wed,  3 Feb 2021 10:09:53 -0300 (-03)
Date:   Wed, 3 Feb 2021 10:09:53 -0300
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     Jiri Olsa <jolsa@redhat.com>
Cc:     Namhyung Kim <namhyung@kernel.org>, Ingo Molnar <mingo@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        LKML <linux-kernel@vger.kernel.org>,
        Stephane Eranian <eranian@google.com>,
        Andi Kleen <ak@linux.intel.com>,
        Ian Rogers <irogers@google.com>
Subject: Re: [PATCHSET v3 0/3] perf tools: Minor improvements in event
 synthesis
Message-ID: <20210203130953.GA854763@kernel.org>
References: <20210202090118.2008551-1-namhyung@kernel.org>
 <YBlIJzIZ1nEesWS9@krava>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YBlIJzIZ1nEesWS9@krava>
X-Url:  http://acmel.wordpress.com
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Em Tue, Feb 02, 2021 at 01:40:07PM +0100, Jiri Olsa escreveu:
> On Tue, Feb 02, 2021 at 06:01:15PM +0900, Namhyung Kim wrote:
> > Hello,
> > 
> > This is to optimize the event synthesis during perf record.
> > 
> > Changes in v3:
> >  * remove unnecessary pid check
> >  * update change log in patch #2
> 
> Acked-by: Jiri Olsa <jolsa@redhat.com>

Thanks, applied.

- Arnaldo

 
> thanks,
> jirka
> 
> > 
> > The first patch is to reduce memory usage when many threads are used.
> > The second is to avoid unncessary syscalls for kernel threads.  And
> > the last one is to reduce the number of threads to iterate when new
> > threads are being created at the same time.
> > 
> > Unfortunately there's no dramatic improvement here but I can see ~5%
> > gain in the 'perf bench internals synthesize' on a big machine.
> > (The numbers are not stable though)
> > 
> > 
> > Before:
> >   # perf bench internals synthesize --mt -M1 -I 100
> >   # Running 'internals/synthesize' benchmark:
> >   Computing performance of multi threaded perf event synthesis by
> >   synthesizing events on CPU 0:
> >     Number of synthesis threads: 1
> >       Average synthesis took: 68831.480 usec (+- 101.450 usec)
> >       Average num. events: 9982.000 (+- 0.000)
> >       Average time per event 6.896 usec
> > 
> > 
> > After:
> >   # perf bench internals synthesize --mt -M1 -I 100
> >   # Running 'internals/synthesize' benchmark:
> >   Computing performance of multi threaded perf event synthesis by
> >   synthesizing events on CPU 0:
> >     Number of synthesis threads: 1
> >       Average synthesis took: 65036.370 usec (+- 158.121 usec)
> >       Average num. events: 9982.000 (+- 0.000)
> >       Average time per event 6.515 usec
> > 
> > 
> > Thanks,
> > Namhyung
> > 
> > 
> > Namhyung Kim (3):
> >   perf tools: Use /proc/<PID>/task/<TID>/status for synthesis
> >   perf tools: Skip MMAP record synthesis for kernel threads
> >   perf tools: Use scandir() to iterate threads
> > 
> >  tools/perf/util/synthetic-events.c | 83 +++++++++++++++++++-----------
> >  1 file changed, 53 insertions(+), 30 deletions(-)
> > 
> > -- 
> > 2.30.0.365.g02bc693789-goog
> > 
> 

-- 

- Arnaldo
