Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 731EB36D87A
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Apr 2021 15:45:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238934AbhD1Npu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 28 Apr 2021 09:45:50 -0400
Received: from mail.kernel.org ([198.145.29.99]:34324 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229891AbhD1Nps (ORCPT <rfc822;Linux-kernel@vger.kernel.org>);
        Wed, 28 Apr 2021 09:45:48 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 0070561433;
        Wed, 28 Apr 2021 13:45:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1619617503;
        bh=Hs3ZClUqB3asF54S3IbgfS608uzXZ368c3MxWozNzGk=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=J8pEbMJsZAkEw7E5jJPSSr7qzUoWso5BsReOctFTjuSQcrpLPilEGp2RJQxyjnksb
         LE9cmxRzCiFlcrmzQVVHiUvFJZwPKyq+xd+g/QyLULPZfn5C16CAkOr6dT/i7G7GAj
         NgqKybEuCpj4IK2dbs576tgOoe97pvaiS9BAMtP3rGeTqrhcUVhf+RZOmDNIBCfaKl
         Beu7XV+mK+houofC6vKdK139GouAuy3NnqCCAiP4CD82mFJt/SBok9/tmD6zX0hVWA
         zDb45W48pYKacR82JUYRkaoI9ORgJgTTeU/4hnxw+shkVCZZ4sc9RS5lV67ysL88Wo
         nJG/b6lDRzCDQ==
Received: by quaco.ghostprotocols.net (Postfix, from userid 1000)
        id BFE4440647; Wed, 28 Apr 2021 10:44:58 -0300 (-03)
Date:   Wed, 28 Apr 2021 10:44:58 -0300
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     Jiri Olsa <jolsa@redhat.com>
Cc:     "Jin, Yao" <yao.jin@linux.intel.com>, jolsa@kernel.org,
        peterz@infradead.org, mingo@redhat.com,
        alexander.shishkin@linux.intel.com, Linux-kernel@vger.kernel.org,
        ak@linux.intel.com, kan.liang@intel.com, yao.jin@intel.com
Subject: Re: [PATCH v6 00/26] perf tool: AlderLake hybrid support series 1
Message-ID: <YIlm2k6ok3Gey3FU@kernel.org>
References: <20210427070139.25256-1-yao.jin@linux.intel.com>
 <YIgIiZVxOWdYTwef@krava>
 <d5309468-d6d6-ab8d-2f06-22b4f6e98917@linux.intel.com>
 <YIkOn9ZaTv87Kmjw@krava>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YIkOn9ZaTv87Kmjw@krava>
X-Url:  http://acmel.wordpress.com
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Em Wed, Apr 28, 2021 at 09:28:31AM +0200, Jiri Olsa escreveu:
> On Wed, Apr 28, 2021 at 09:57:40AM +0800, Jin, Yao wrote:
> 
> SNIP
> 
> > > >           1.003959036 seconds time elapsed
> > > > 
> > > > Note that, since the whole patchset for AlderLake hybrid support is very
> > > > large (40+ patches). For simplicity, it's splitted into several patch
> > > > series.
> > > > 
> > > > The patch series 1 only supports the basic functionality. The advanced
> > > > supports for perf-c2c/perf-mem/topdown/metrics/topology header and others
> > > > will be added in follow-up patch series.
> > > > 
> > > > The perf tool codes can also be found at:
> > > > https://github.com/yaoj/perf.git
> > > 
> > > hi,
> > > did you update the branch for v6? I think I can't see
> > > the new update there
> > > 
> > > thanks,
> > > jirka
> > > 
> > 
> > I just pushed the latest updates to https://github.com/yaoj/perf.git. Sorry it's getting late.
> > 
> > Actually it's Arnaldo's tmp.perf/core branch. Arnaldo has applied the patch
> > series on tmp.perf/core and with an update on "[PATCH v6 01/26] tools
> > headers uapi: Update tools's copy of
> >  linux/perf_event.h".
> 
> np, I used Arnaldo's branch for review
> 
> > 
> > If there are more comments which need to be addressed, we will start from tmp.perf/core for v7.
> > 
> > Thanks
> > Jin Yao
> > 
> > > > 
> > > > Note that, this patch series is based on tmp.perf/core branch.
> > > > 
> > > > v6:
> > > > ---
> > > > - Rebase to tmp.perf/core branch.
> > > > 
> > > > - A minor update in v6 patch series.
> > > > 
> > > >    In '[PATCH v6 18/26] perf tests: Add hybrid cases for 'Parse event
> > > >    definition strings' test', we add a test case for cache events with
> > > >    pmu prefix.
> > > > 
> > > >    No other updates.
> 
> I can't test the functionality, but apart from that all seems fine
> and non-hybrid stuff keeps working ;-)
> 
> Reviewed-by: Jiri Olsa <jolsa@kernel.org>

Thanks, added it to the series.

- Arnaldo
