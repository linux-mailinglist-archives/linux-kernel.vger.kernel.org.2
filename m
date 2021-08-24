Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 821853F6899
	for <lists+linux-kernel@lfdr.de>; Tue, 24 Aug 2021 20:00:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238859AbhHXSBX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 24 Aug 2021 14:01:23 -0400
Received: from mail.kernel.org ([198.145.29.99]:60168 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S234763AbhHXSBK (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Aug 2021 14:01:10 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 4F09E60F58;
        Tue, 24 Aug 2021 18:00:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1629828026;
        bh=Eu7nQp5l4IP0bkv+7K+YURGSimElr7Ae7H6BMKHldTY=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=h/tHLS3aRuDCojrTdn753UHoHlpe046xBUcBza3z7UvsORK8pXixZVC6NXl8iFpDm
         4cxYNBUz25+dCfd4d3enZKsnnF1Th2rtn2n4BBsGjRsSeTyF98r3Z45qA2Kp7jQmKC
         IcreHpW5LLr7hmsr4s6ribb4Sa5GPnETBvY72yrcUgdyPR/sSbgF0in+Mar07QLkmm
         S44q05YH/WwLzAqJBvapl1nmNc+eCDCe/aM7gyjsTOHXuLdXLv+VyG1mDxpqAiJrcS
         PqaF5fHIAQXEyJBUvQ1/3VnkRdlDYkGMf8YUDETIpV1DBNEer0j+s1RYK/FEG37Uok
         4c9nR8nX12aRw==
Received: by quaco.ghostprotocols.net (Postfix, from userid 1000)
        id DF1654007E; Tue, 24 Aug 2021 15:00:22 -0300 (-03)
Date:   Tue, 24 Aug 2021 15:00:22 -0300
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     Ian Rogers <irogers@google.com>
Cc:     "Bayduraev, Alexey V" <alexey.v.bayduraev@linux.intel.com>,
        Riccardo Mancini <rickyman7@gmail.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Jiri Olsa <jolsa@redhat.com>, linux-kernel@vger.kernel.org,
        linux-perf-users@vger.kernel.org
Subject: Re: [GSoC] Multi-threading in perf: Final Report
Message-ID: <YSUztlMX8u0P527q@kernel.org>
References: <3c4f8dd64d07373d876990ceb16e469b4029363f.camel@gmail.com>
 <b7a9f309-9765-2a64-026e-efa835989add@linux.intel.com>
 <CAP-5=fV1+WKKWVYVivDt1uE8P9koKre-=Boh0-P1vTD6uiw2=A@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAP-5=fV1+WKKWVYVivDt1uE8P9koKre-=Boh0-P1vTD6uiw2=A@mail.gmail.com>
X-Url:  http://acmel.wordpress.com
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Em Mon, Aug 23, 2021 at 01:47:51PM -0700, Ian Rogers escreveu:
> On Mon, Aug 23, 2021 at 4:40 AM Bayduraev, Alexey V
> <alexey.v.bayduraev@linux.intel.com> wrote:
> >
> > On 21.08.2021 12:41, Riccardo Mancini wrote:
> > > Hi,
> > >
> > > this is the final report of my project "Multi-threading in perf",
> > > developed as part of the Google Summer of Code with the Linux Foundation.
> > > https://summerofcode.withgoogle.com/projects/#4670070929752064
> > <SNIP>
> > >
> > > Review activity:
> > > PATCHSET Introduce threaded trace streaming for basic perf record operation
> > >   Link: https://lore.kernel.org/lkml/cover.1629186429.git.alexey.v.bayduraev@linux.intel.com/
> > >   Contribution: helped in fixing some bugs, performed extensive testing
> >
> > Hi Riccardo,
> >
> > Thank you very much for the deep review and extensive testing of
> > this patchset, it was very helpful and allowed us to improve
> > the quality of the feature used in our product.
> >
> > Good luck,
> > Alexey
> 
> Likewise, thank you Riccardo! It is always implied but not said often
> enough, thank you Arnaldo! I'm hoping the success of Riccardo's work
> will be an example for next year and we can also get more mentor
> volunteers.

Yeah, it was a great experience, now we need to actually do the tests
Riccardo asked us on big machines and get his and Alexey's work
processed :-)

- Arnaldo
