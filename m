Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9F8AA4440A4
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Nov 2021 12:32:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231804AbhKCLe4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 3 Nov 2021 07:34:56 -0400
Received: from mail.kernel.org ([198.145.29.99]:49332 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230112AbhKCLez (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 Nov 2021 07:34:55 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 6671B61058;
        Wed,  3 Nov 2021 11:32:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1635939138;
        bh=zuOcwWfFVIJNTKW1z5rMswsN1iUCKx0zr+HQsJST2yc=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=am/zcHLYGHvd2WIhHDtxYA67GZ9wIZjNRVW5E2ZyPg+J6k6LZEW93csBzEk1j309v
         4wOxApAf7ZHp2F3TRZC85iMc+7OIZHZJ0l2UkYMZ66o1G5Twl5wruDClSyxOb/+eSC
         Dciy+4HE9lL/9A/oy76wxJl3Gr6zDhhmTYo3lK5S5ConY1jk/PgKNymNraTFNa4n40
         Nl/melwXR/4mHMkXPdsxzzoYJgn9Xd2/V1xV+OGAT1g661BVOvF+C4y0/t7o3sdK8d
         L05fg7z6PuXy29huuK2LK+2D5mbS8T07ZD6KpNVeyjRdTFlosDLOnPhKAXym66yA1b
         BbAneJOnbAfpA==
Received: by quaco.ghostprotocols.net (Postfix, from userid 1000)
        id 71B97410A1; Wed,  3 Nov 2021 08:32:14 -0300 (-03)
Date:   Wed, 3 Nov 2021 08:32:14 -0300
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     Stephane Eranian <eranian@google.com>
Cc:     Jiri Olsa <jolsa@redhat.com>, Namhyung Kim <namhyung@kernel.org>,
        Ingo Molnar <mingo@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Andi Kleen <ak@linux.intel.com>,
        Ian Rogers <irogers@google.com>
Subject: Re: [PATCH v3] perf evsel: Fix missing exclude_{host,guest} setting
Message-ID: <YYJzPkcUz2pcuspX@kernel.org>
References: <20211029224929.379505-1-namhyung@kernel.org>
 <YYFGxwFMvTRN5KBI@krava>
 <CAM9d7cjPq7=HoPAi3Cd3crcNJO8hWu0cU8j4qOTqSMxd7M6BqQ@mail.gmail.com>
 <YYI5EwCjBojR+1QW@krava>
 <CABPqkBSHo3Gznor1e8M_Ue0XO8Z-HZt326q8N9kLWz4+jKkt-w@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CABPqkBSHo3Gznor1e8M_Ue0XO8Z-HZt326q8N9kLWz4+jKkt-w@mail.gmail.com>
X-Url:  http://acmel.wordpress.com
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Em Wed, Nov 03, 2021 at 12:44:12AM -0700, Stephane Eranian escreveu:
> On Wed, Nov 3, 2021 at 12:24 AM Jiri Olsa <jolsa@redhat.com> wrote:
> > On Tue, Nov 02, 2021 at 04:21:21PM -0700, Namhyung Kim wrote:
> > > On Tue, Nov 2, 2021 at 7:10 AM Jiri Olsa <jolsa@redhat.com> wrote:
> > > > we were discussing this with Arnaldo yesterday and he had an idea to use
> > > > evsel->pmu link to store this info instead of hash.. I first thought we
> > > > needed 'evsel' related data, but after I gave it some thought I think that
> > > > might actually work

> > > I don't get it.. do we have evsel->pmu already?  Or do you want to add it?
> > > Yeah, the filtering facility (attr.exclude_*) should be kept in a PMU data
> > > not in the evsel.  So I added a hashmap to find the pmu data from attr.type.
> > > How do I use evsel->pmu to store the info then?

> > evsel->pmu is not there yet (only evsel->pmu_name) so that
> > would need to be added.. we have evsel__find_pmu available

> > then the idea is to use evsel->pmu instead of the hasmap,
> > like add:

> >   struct pmu {
> >     ...
> >     bool missing_exclude_guest;
> >   };

yeah, or more generaly:

	struct pmu {
		...
		struct {
			bool exclude_guess;
		} missing_features;
	};

> > set it when the guest filtering fails and and check it
> > instead of the hashmap__find call

> > > > my argument was following usecase:

> > > >   cycles:G,instructions:G,pmu/bla1/:G,pmu/bla2/

> > > > that we would falsely clear pmu/bla1/:G if we used the 'evsel->pmu' data..
> > > > but then I realized it's detection if pmu support :G and so if the :G is
> > > > not there, none of the events should have it

> > > > thoughts?

> > > I don't think I'm following well... ;-p

> > > If the pmu doesn't support host/guest filtering, pmu/bla1/G
> > > may count something.  Not sure if it's better to error out.
> > > But the cycles:G and instructions:G should result in 0
> > > in case there's no VM running.

> > hm, I think if pmu doesn't support host/guest filtering then
> > I think 'pmu/bla1/G' should error, no? better no number than
> > bad number

> Yes, it should in my opinion.

Yeah, I thought about this yesterday (holiday here).

- Arnaldo
