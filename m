Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8BFDF32C007
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Mar 2021 01:00:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1386411AbhCCSPQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 3 Mar 2021 13:15:16 -0500
Received: from mail.kernel.org ([198.145.29.99]:46638 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1449483AbhCCPo1 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 Mar 2021 10:44:27 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id 87A8464EE1;
        Wed,  3 Mar 2021 15:43:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1614786226;
        bh=fLc+rGNxeBnRxKYpqd3Pu34myb92BGwuWnL/wt/inZ4=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=l+ZEdq7xSYJvc5KhtnvVyz82YrBFeUgB7B7xxA/LgwcAIlmvxq/bQ1c6eZggwQ3e+
         tnTxzUizjxeVnJWrp45SIqn0F9q4v8ekw9tPgNwMbnCfkYC5Xpe/nkuxmj6FecjHRl
         WtECJxN7ate3XmouYrBLJ44T4xYhf9Xb6IgriIDfLSMV3tskLn8gBegHu310OdZYZr
         FR57uOPL9lFPhqe9AyxBdTP4sFWdQlG2pqrH/x4c8G0OtPSNr9JgaVgJaG0vI5RMQM
         eMfCerHCLxKT2g936ISV87kcU/3k/fUn8s1IvI2odYCQl3SJWCqZi8y5wEIlED2Z6q
         0h/aC946M0RLQ==
Received: by quaco.ghostprotocols.net (Postfix, from userid 1000)
        id 4405440CD9; Wed,  3 Mar 2021 12:43:44 -0300 (-03)
Date:   Wed, 3 Mar 2021 12:43:44 -0300
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     Jiri Olsa <jolsa@redhat.com>
Cc:     Namhyung Kim <namhyung@kernel.org>, Ingo Molnar <mingo@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        LKML <linux-kernel@vger.kernel.org>,
        Stephane Eranian <eranian@google.com>,
        Andi Kleen <ak@linux.intel.com>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Ian Rogers <irogers@google.com>, Leo Yan <leo.yan@linaro.org>
Subject: Re: [PATCH 04/11] perf test: Fix cpu and thread map leaks in
 sw_clock_freq test
Message-ID: <YD+usJnMpLl47Eth@kernel.org>
References: <20210301140409.184570-1-namhyung@kernel.org>
 <20210301140409.184570-5-namhyung@kernel.org>
 <YD0jR7ENbD7u01Zq@krava>
 <CAM9d7cgNpEzaPYin=PUw9+WCecbUCQaNXAsMFOXnLBHcK8xotw@mail.gmail.com>
 <YD43iUvSodTurUfG@krava>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YD43iUvSodTurUfG@krava>
X-Url:  http://acmel.wordpress.com
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Em Tue, Mar 02, 2021 at 02:03:05PM +0100, Jiri Olsa escreveu:
> On Tue, Mar 02, 2021 at 10:50:15AM +0900, Namhyung Kim wrote:
> 
> SNIP
> 
> > > >               err = -ENOMEM;
> > > >               pr_debug("Not enough memory to create thread/cpu maps\n");
> > > > -             goto out_free_maps;
> > > > +             goto out_delete_evlist;
> > > >       }
> > > >
> > > >       perf_evlist__set_maps(&evlist->core, cpus, threads);
> > > >
> > > > -     cpus    = NULL;
> > > > -     threads = NULL;
> > >
> > > hum, so IIUC we added these and the other you remove in your patches long time ago,
> > > because there was no refcounting at that time, right?
> > 
> > It seems my original patch just set the maps directly.
> > 
> >   bc96b361cbf9 perf tests: Add a test case for checking sw clock event frequency
> > 
> > And after that Adrian changed it to use the set_maps() helper.
> > 
> >   c5e6bd2ed3e8 perf tests: Fix software clock events test setting maps
> 
> ok, and after that there's this one:
>   a55e56637613 perf evlist: Reference count the cpu and thread maps at set_maps()
> 
> forcing the get calls when storing cpus and threads
> 
> for the patchset
> 
> Acked-by: Jiri Olsa <jolsa@redhat.com>

Thanks, applied.

- Arnaldo

 
> thanks,
> jirka
> 
> > 
> > It seems we already had the refcounting at the moment.  And then the libperf
> > renaming happened later.
> > 
> > Thanks,
> > Namhyung
> > 
> 

-- 

- Arnaldo
