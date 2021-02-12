Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7768831A68C
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Feb 2021 22:10:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231959AbhBLVI2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 12 Feb 2021 16:08:28 -0500
Received: from mail.kernel.org ([198.145.29.99]:58630 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231830AbhBLVIS (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 12 Feb 2021 16:08:18 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id 6E0A764E05;
        Fri, 12 Feb 2021 21:07:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1613164057;
        bh=0Z6o3IjOByHGdRgIp6J7ZzM78Yts8YPv+8j0VQbytYg=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=YsAbrkQEU3mgUUY2bDcfB7ypftxBmU/K7S//Bf2Hp+zu6jewvY93Hlg4/d3BYpRLQ
         7jGTLNTYqpFWGjxKRPKaG+GUVtRNv63Pi+xlxa0Al/CuxUpdpHJoCIWWoq6HilzlxW
         wjW/xOuFP1n8BMsdZRc/1jh/tRFRV5nfRZ1lK0zOgQedwumHu16D4vnzfZuU82qoAm
         cFaK9hJBFG7gjLgd84JrGpphnWgCYpueamOY7riTI43ivBgCaRRgGhbb0E7ljOZZ2F
         EbSA7PH2LlH7EJ/oEVOm0ACNhCXOHfOOPYW07hQnFu6ngoDUFWYa9mIYbXnesIcAJj
         5qDzHfM7Ontzw==
Received: by quaco.ghostprotocols.net (Postfix, from userid 1000)
        id BD20F40513; Fri, 12 Feb 2021 18:07:34 -0300 (-03)
Date:   Fri, 12 Feb 2021 18:07:34 -0300
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     Nicholas Fraser <nfraser@codeweavers.com>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@redhat.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Ian Rogers <irogers@google.com>,
        "Frank Ch. Eigler" <fche@redhat.com>,
        Song Liu <songliubraving@fb.com>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Kim Phillips <kim.phillips@amd.com>,
        Tommi Rantala <tommi.t.rantala@nokia.com>,
        Remi Bernon <rbernon@codeweavers.com>,
        linux-kernel@vger.kernel.org,
        Ulrich Czekalla <uczekalla@codeweavers.com>,
        Huw Davies <huw@codeweavers.com>
Subject: Re: [PATCH 3/4] perf archive: Fix filtering of empty build-ids
Message-ID: <20210212210734.GK1398414@kernel.org>
References: <7708cca1-b8f6-c394-75f1-5f9681d625d0@codeweavers.com>
 <20210212122901.GB1398414@kernel.org>
 <8f50e586-ae58-ef4e-a594-e2248203a2a7@codeweavers.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <8f50e586-ae58-ef4e-a594-e2248203a2a7@codeweavers.com>
X-Url:  http://acmel.wordpress.com
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Em Fri, Feb 12, 2021 at 01:49:36PM -0500, Nicholas Fraser escreveu:
> The current version of "perf buildid-list" prints missing build-ids as
> blank even when loading perf.data files generated from older versions of
> perf. I've tested with a few older versions.
> 
> Since perf-archive is an external script that calls back into perf, it
> could in theory find a different older version that still returns zeroes.
> We could make it look for a matching perf, e.g. "$(dirname "$0")/perf".
> Unfortunately that won't work in general because at least on my system
> perf-archive is installed to a different path than perf.

It shouldn't try to find a "matching perf" as the userspace perf is not
in lockstep with the kernel perf subsystem :-)

If a current 'perf archive' is called on some perf.data file, it should
know that a zero-filled or a blank filled build-id means the same and
act accordingly.

- Arnaldo
  
> Nick
> 
> 
> On 2021-02-12 7:29 a.m., Arnaldo Carvalho de Melo wrote:
> > Em Wed, Feb 10, 2021 at 02:17:49PM -0500, Nicholas Fraser escreveu:
> >> A non-existent build-id used to be treated as all-zero SHA-1 hash.
> >> Build-ids are now variable width. A non-existent build-id is an empty
> >> string and "perf buildid-list" pads this with spaces.
> >>
> >> This fixes "perf-archive" to skip missing build-ids by skipping lines
> >> that start with a padding space rather than with zeroes.
> >>
> >> Signed-off-by: Nicholas Fraser <nfraser@codeweavers.com>
> >> ---
> >>  tools/perf/perf-archive.sh | 3 +--
> >>  1 file changed, 1 insertion(+), 2 deletions(-)
> >>
> >> diff --git a/tools/perf/perf-archive.sh b/tools/perf/perf-archive.sh
> >> index 0cfb3e2cefef..133f0eddbcc4 100644
> >> --- a/tools/perf/perf-archive.sh
> >> +++ b/tools/perf/perf-archive.sh
> >> @@ -20,9 +20,8 @@ else
> >>  fi
> >>  
> >>  BUILDIDS=$(mktemp /tmp/perf-archive-buildids.XXXXXX)
> >> -NOBUILDID=0000000000000000000000000000000000000000
> >>  
> >> -perf buildid-list -i $PERF_DATA --with-hits | grep -v "^$NOBUILDID " > $BUILDIDS
> >> +perf buildid-list -i $PERF_DATA --with-hits | grep -v "^ " > $BUILDIDS
> >>  if [ ! -s $BUILDIDS ] ; then
> >>  	echo "perf archive: no build-ids found"
> >>  	rm $BUILDIDS || true
> > 
> > What should we do when using older files? We have to support both cases.
> > 
> > - Arnaldo
> > 

-- 

- Arnaldo
