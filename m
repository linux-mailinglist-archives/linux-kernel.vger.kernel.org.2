Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1B20132A659
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Mar 2021 17:43:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1384156AbhCBOib (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 2 Mar 2021 09:38:31 -0500
Received: from mail.kernel.org ([198.145.29.99]:52086 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1343536AbhCBMpQ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 Mar 2021 07:45:16 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id D4ACF600CD;
        Tue,  2 Mar 2021 12:41:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1614688897;
        bh=UOWZrg2vDTrD6maFoTWw1BUFsnOlTTSPj4bpY03tycE=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=J7nV8RnwbTcFLGJpKEUIazZk0YzSHmP25FhtijoGmvQy2AxBD+VFFtGwTYkiAyEZ0
         1dJ4dOaA0k+PGAh/7NKDovXWkoRtZ3NSyNGF2rxGkX8nezArsa/DLIWHS9B6UmkKu7
         RNFRRkYDAbmocZ/8OqnkQ3TxzeUFoqpVA9SVvMAEUqS2F+/TOlq2mMRR+bRon+vzGp
         Hr2x8kWXurn1cRT/SEKh39p0tsQiGPZdUuZ6gXqBZ9rw0322s+Hu1hHb6w61Oa19yL
         1iHcSDT2xS2LVltj+AioJn7IjYlz5L5jLVWMCfuqmPX95Mkwmjl5qVTbYZWiorZzei
         Qxihp8jiDp9FA==
Received: by quaco.ghostprotocols.net (Postfix, from userid 1000)
        id 628ED40CD9; Tue,  2 Mar 2021 09:41:34 -0300 (-03)
Date:   Tue, 2 Mar 2021 09:41:34 -0300
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     Jiri Olsa <jolsa@redhat.com>
Cc:     Nicholas Fraser <nfraser@codeweavers.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Ian Rogers <irogers@google.com>, linux-kernel@vger.kernel.org,
        Ulrich Czekalla <uczekalla@codeweavers.com>,
        Huw Davies <huw@codeweavers.com>
Subject: Re: [PATCH] perf buildid-cache: Add test for PE executable
Message-ID: <YD4yfh6rzKgoQZEy@kernel.org>
References: <790bfe67-2155-a426-7130-ae7c45cb055b@codeweavers.com>
 <YDgJ+JTiOsGX288R@krava>
 <YDmImAQ1Lloa2d5y@kernel.org>
 <YDocHWwa6wCyFG1c@krava>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YDocHWwa6wCyFG1c@krava>
X-Url:  http://acmel.wordpress.com
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Em Sat, Feb 27, 2021 at 11:17:01AM +0100, Jiri Olsa escreveu:
> On Fri, Feb 26, 2021 at 08:47:36PM -0300, Arnaldo Carvalho de Melo wrote:
> > Em Thu, Feb 25, 2021 at 09:35:04PM +0100, Jiri Olsa escreveu:
> > > On Wed, Feb 24, 2021 at 02:59:16PM -0500, Nicholas Fraser wrote:
> > > > From 9fd0b3889f00ad13662879767d833309d8a035b6 Mon Sep 17 00:00:00 2001
> > > > From: Nicholas Fraser <nfraser@codeweavers.com>
> > > > Date: Thu, 18 Feb 2021 13:24:03 -0500
> > > > Subject: [PATCH] perf buildid-cache: Add test for PE executable
> > > > 
> > > > This builds on the previous changes to tests/shell/buildid.sh, adding
> > > > tests for a PE file. It adds it to the build-id cache manually and, if
> > > > Wine is available, runs it under "perf record" and verifies that it was
> > > > added automatically.
> > > > 
> > > > If wine is not installed, only warnings are printed; the test can still
> > > > exit 0.
> > > > 
> > > > Signed-off-by: Nicholas Fraser <nfraser@codeweavers.com>
> > > 
> > > works nicely now, thanks
> > > 
> > > Acked-by: Jiri Olsa <jolsa@redhat.com>
> > 
> > Thanks for checking it, but if you did a review, i.e. if you looked at
> > the code, made suggestions, the submitter acted upon those changes, you
> > looked again, etc, shouldn't this be a more appropriate:
> > 
> > Reviewed-by: Jiri Olsa <jolsa@redhat.com>
> > 
> > ?
> > 
> > I think we need to make these tags reflect more what really happened,
> > i.e. if you just glanced over and thought, quickly, that it seems
> > okayish, then Acked-by is what we should use, but if you gone thru the
> > trouble of actually _looking hard_ at it, sometimes multiple times, then
> > we should really use Reviewed-by and not take that lightly.
> 
> ah right, I slipped to using ack regardles the effort ;-)
> I'll try to kick myself to use reviewed where appropriate
> 
> for this one:
> 
> Reviewed-by: Jiri Olsa <jolsa@redhat.com>

Thanks, applied to perf/core.

- Arnaldo

