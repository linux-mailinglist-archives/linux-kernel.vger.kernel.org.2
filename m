Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2C3D532A673
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Mar 2021 17:44:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1384569AbhCBPFR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 2 Mar 2021 10:05:17 -0500
Received: from mail.kernel.org ([198.145.29.99]:51894 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1444817AbhCBMlX (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 Mar 2021 07:41:23 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id DB4D164F3D;
        Tue,  2 Mar 2021 12:37:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1614688679;
        bh=ADZ2jdxKJpZKmEsffxkfdnOtiK/vKyMke5pLJCQ0aPc=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=rh5KMPB/jyIkIY6DosMSMjNUhFz50DedT42J7nkTNoMlylQGS0VswhJtBHXvzql40
         8EzzROCnBT8XoJOzRkJUoDl9CvSK5KklLngJRpHjuIxxJYOQOa6MuN6obJ9E+mFwxw
         za3y9nxfhxnwbYjXHwxDnnzwSkGmg1q8SbGxV3b99+F/pfMv9DOKJbv/FikiXoiNO1
         oFLR4YwrAU08akhhTK5XGtiLSypgx7ldpmBQ9vTuOKTygRe9oztTjysP2fhvG47xOX
         PiD9vBt81VDTA/6U6esayvoCPmoNPsw1LWJ1C48J/g/MNkvMdFxCooOvRNAdhNFzVt
         NPEeT83rhgnFA==
Received: by quaco.ghostprotocols.net (Postfix, from userid 1000)
        id 7177D40CD9; Tue,  2 Mar 2021 09:37:56 -0300 (-03)
Date:   Tue, 2 Mar 2021 09:37:56 -0300
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     Ian Rogers <irogers@google.com>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@redhat.com>,
        Namhyung Kim <namhyung@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v2] perf docs: Add man pages to see also
Message-ID: <YD4xpMC6jNCNPsPY@kernel.org>
References: <20201120063037.3166069-1-irogers@google.com>
 <CAP-5=fWStOGveisGTXejQ7ZxgBKu1Mgw4MF+k-ZXVvM4hMdQaQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAP-5=fWStOGveisGTXejQ7ZxgBKu1Mgw4MF+k-ZXVvM4hMdQaQ@mail.gmail.com>
X-Url:  http://acmel.wordpress.com
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Em Mon, Feb 22, 2021 at 10:01:12AM -0800, Ian Rogers escreveu:
> On Thu, Nov 19, 2020 at 10:30 PM Ian Rogers <irogers@google.com> wrote:
> >
> > Add all other man pages to the "see also" list except for
> > perf-script-perl and perf-script-python that are linked to from
> > perf-script.
> >
> > v2. Fix accidentally listing perf-top twice.
> >
> > Signed-off-by: Ian Rogers <irogers@google.com>
> 
> Ping. I think this might have gotten lost.

Thanks, applied.

- Arnaldo

 
> Thanks,
> Ian
> 
> > ---
> >  tools/perf/Documentation/perf.txt | 12 ++++++++++++
> >  1 file changed, 12 insertions(+)
> >
> > diff --git a/tools/perf/Documentation/perf.txt b/tools/perf/Documentation/perf.txt
> > index c130a3c46a90..9c330cdfa973 100644
> > --- a/tools/perf/Documentation/perf.txt
> > +++ b/tools/perf/Documentation/perf.txt
> > @@ -76,3 +76,15 @@ SEE ALSO
> >  linkperf:perf-stat[1], linkperf:perf-top[1],
> >  linkperf:perf-record[1], linkperf:perf-report[1],
> >  linkperf:perf-list[1]
> > +
> > +linkperf:perf-annotate[1],linkperf:perf-archive[1],
> > +linkperf:perf-bench[1], linkperf:perf-buildid-cache[1],
> > +linkperf:perf-buildid-list[1], linkperf:perf-c2c[1],
> > +linkperf:perf-config[1], linkperf:perf-data[1], linkperf:perf-diff[1],
> > +linkperf:perf-evlist[1], linkperf:perf-ftrace[1],
> > +linkperf:perf-help[1], linkperf:perf-inject[1],
> > +linkperf:perf-intel-pt[1], linkperf:perf-kallsyms[1],
> > +linkperf:perf-kmem[1], linkperf:perf-kvm[1], linkperf:perf-lock[1],
> > +linkperf:perf-mem[1], linkperf:perf-probe[1], linkperf:perf-sched[1],
> > +linkperf:perf-script[1], linkperf:perf-test[1],
> > +linkperf:perf-trace[1], linkperf:perf-version[1]
> > --
> > 2.29.2.454.gaff20da3a2-goog
> >

-- 

- Arnaldo
