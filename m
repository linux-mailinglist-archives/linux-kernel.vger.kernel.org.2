Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2E03B3FBCB5
	for <lists+linux-kernel@lfdr.de>; Mon, 30 Aug 2021 20:54:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232336AbhH3Szk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 30 Aug 2021 14:55:40 -0400
Received: from mail.kernel.org ([198.145.29.99]:57832 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230455AbhH3Szj (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 Aug 2021 14:55:39 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 243F660F3A;
        Mon, 30 Aug 2021 18:54:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1630349685;
        bh=7HzKsqTjhf9cL7OnqXmeucrSOEnIfz78gL52j0Ig89k=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=hGpq/lPWxlUZvQsqUiBWK/3gUFY0sBUAJdnEVMyM6F5pdB74FE8+S7GRIvD5nEr9E
         j7LflIh+CKnI6pFy6b+l37l90GVEZWV79BnctKvW5nGjCsDTVuLa51o5cv55BptoUR
         PUCTV3XlFf2u2QA0209HK16CJnLf7blH/F1Cn+1A/LfgUaf0fp+6sOCFT95ZamaCxU
         RxRblNYeMc/AxAIIlCigAhXZ6DPx/By+psyygdTtEbVevjEnFeJIX4AHH8hJqBhYqq
         XSucJMe1GWGQb/ZTSQ+yJ+JtzAs0pu/U32hy6AYhKfqlTpEmsWQFy5AQqSw9BwBPx3
         W9y8BcuoBhQNA==
Received: by quaco.ghostprotocols.net (Postfix, from userid 1000)
        id DACCB4007E; Mon, 30 Aug 2021 15:54:42 -0300 (-03)
Date:   Mon, 30 Aug 2021 15:54:42 -0300
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     Ian Rogers <irogers@google.com>
Cc:     Namhyung Kim <namhyung@kernel.org>, Jiri Olsa <jolsa@redhat.com>,
        Ingo Molnar <mingo@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Andi Kleen <ak@linux.intel.com>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Stephane Eranian <eranian@google.com>
Subject: Re: [PATCH] perf record: Fix wrong comm in system-wide mode with
 delay
Message-ID: <YS0pcjdivueJcdwd@kernel.org>
References: <20210827233212.3121037-1-namhyung@kernel.org>
 <CAP-5=fWLUBzsaVNvHpJBMcZY+Ms3gE7OF6i3toOBaW-rYpVFeg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAP-5=fWLUBzsaVNvHpJBMcZY+Ms3gE7OF6i3toOBaW-rYpVFeg@mail.gmail.com>
X-Url:  http://acmel.wordpress.com
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Em Mon, Aug 30, 2021 at 10:33:16AM -0700, Ian Rogers escreveu:
> On Fri, Aug 27, 2021 at 4:32 PM Namhyung Kim <namhyung@kernel.org> wrote:
> > Stephane found that the name of the forked process in a system-wide
> > mode is wrong when --delay option is used.  For example,
> >
> >   # perf record -a --delay=1000  noploop 3
> >
> > The noploop process will run a busy loop for 3 second.  And on an idle
> > machine it should show up at the top in the perf report.  It works
> > well without the --delay option.  But if I add the option, it showed
> > 'perf' not 'noploop'.
> >
> >   # perf report -s comm -q | head -3
> >       52.94%  perf
> >       16.65%  swapper
> >       12.04%  chrome
> >
> > It turned out that the dummy event didn't work at all and it missed
> > COMM and MMAP events for the noploop process (and others too).  We
> > should enable the dummy event immediately in system-wide mode, as the
> > enable-on-exec would work only for task events.
> >
> > With this change,
> >
> >   # perf report -s comm -q | head -3
> >       52.75%  noploop
> >       17.03%  swapper
> >       12.83%  chrome
> >
> > Cc: Adrian Hunter <adrian.hunter@intel.com>
> > Reported-by: Stephane Eranian <eranian@google.com>
> > Signed-off-by: Namhyung Kim <namhyung@kernel.org>
> 
> Acked-by: Ian Rogers <irogers@google.com>

Thanks, applied.

- Arnaldo

