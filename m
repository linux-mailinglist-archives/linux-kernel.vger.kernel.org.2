Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0C542444A0F
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Nov 2021 22:03:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230395AbhKCVF7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 3 Nov 2021 17:05:59 -0400
Received: from mail.kernel.org ([198.145.29.99]:39424 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230253AbhKCVF5 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 Nov 2021 17:05:57 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 1604961053;
        Wed,  3 Nov 2021 21:03:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1635973400;
        bh=d8px2AtfrOiV2LtD9NN0uOgaogAqUK4i3BipGueAhqw=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=XI0ZCGYtiUEQQt77ffSVIwYk9OOH8yEpZBQvIGiJbIog8hts+dMWXj8db7mxSd8wL
         vpDGD4/x90e5Y2oS1OxXUbCCJ61X2fjNfEgFvYjp3JhTkQwWPfC+y5uv2sMJAs5pEu
         Up6NEkelo3AmeH7fF/RV16Iyoco9hmAG7MQyNEYHKHaHXyZkMphwls+Pw+2Ppbja/c
         Ro14m2XAfz7RUA9Hmf87SFpgYcbTVC6YeS4mcrjUWlB3e4vv1qTOuz5uNquqZ3UiRU
         ylb2hQgy01dhpvcVtc5YbXM2Tho9eYH7HNsOiqda16LxxjlO7DfVHLvLZ8d6hPUk+k
         1RDustetjD+oQ==
Received: by quaco.ghostprotocols.net (Postfix, from userid 1000)
        id E6E39410A1; Wed,  3 Nov 2021 18:03:17 -0300 (-03)
Date:   Wed, 3 Nov 2021 18:03:17 -0300
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     Stephane Eranian <eranian@google.com>
Cc:     Jiri Olsa <jolsa@redhat.com>, Namhyung Kim <namhyung@kernel.org>,
        Ingo Molnar <mingo@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Andi Kleen <ak@linux.intel.com>,
        Ian Rogers <irogers@google.com>
Subject: Re: [PATCH v3] perf evsel: Fix missing exclude_{host,guest} setting
Message-ID: <YYL5FaKQ1ZvGwd08@kernel.org>
References: <20211029224929.379505-1-namhyung@kernel.org>
 <YYFGxwFMvTRN5KBI@krava>
 <CAM9d7cjPq7=HoPAi3Cd3crcNJO8hWu0cU8j4qOTqSMxd7M6BqQ@mail.gmail.com>
 <YYI5EwCjBojR+1QW@krava>
 <CABPqkBSHo3Gznor1e8M_Ue0XO8Z-HZt326q8N9kLWz4+jKkt-w@mail.gmail.com>
 <YYJzPkcUz2pcuspX@kernel.org>
 <CABPqkBQkqehAvpfJk77WZpXezrVO6cAj=9ktKFgL=C_m84_Dgg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CABPqkBQkqehAvpfJk77WZpXezrVO6cAj=9ktKFgL=C_m84_Dgg@mail.gmail.com>
X-Url:  http://acmel.wordpress.com
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Em Wed, Nov 03, 2021 at 10:35:04AM -0700, Stephane Eranian escreveu:
> On Wed, Nov 3, 2021 at 4:32 AM Arnaldo Carvalho de Melo <acme@kernel.org> wrote:
> > Em Wed, Nov 03, 2021 at 12:44:12AM -0700, Stephane Eranian escreveu:
> > > On Wed, Nov 3, 2021 at 12:24 AM Jiri Olsa <jolsa@redhat.com> wrote:
> > > > > If the pmu doesn't support host/guest filtering, pmu/bla1/G
> > > > > may count something.  Not sure if it's better to error out.
> > > > > But the cycles:G and instructions:G should result in 0
> > > > > in case there's no VM running.

> > > > hm, I think if pmu doesn't support host/guest filtering then
> > > > I think 'pmu/bla1/G' should error, no? better no number than
> > > > bad number

> > > Yes, it should in my opinion.

> > Yeah, I thought about this yesterday (holiday here).

> Otherwise you create the illusion that you are monitoring in guest
> mode when you are not.

> The question is: how can the tool know which modifiers are supported
> per pmu model?

As things stand kernel-wise, we should just do capability querying, i.e.
if the user asks for a feature not available for a specific PMU, we
should refuse and provide a helpful error message to the user.

If the PMUs in the kernel had some kind of mask that stated what of the
'struct perf_event_attr' selectable features are supported, then we
would just be able to avoid bothering the kernel asking for unsupported
stuff.

Just for exclude_guest we don't even need to have
evsel->pmu->missing_features.exclude_guest, as this is a hard error, no
point in caching previous capability queries.

- Arnaldo
