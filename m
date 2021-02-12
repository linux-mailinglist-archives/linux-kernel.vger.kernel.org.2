Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 61627319E70
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Feb 2021 13:34:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231395AbhBLMaA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 12 Feb 2021 07:30:00 -0500
Received: from mail.kernel.org ([198.145.29.99]:53216 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231348AbhBLM3o (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 12 Feb 2021 07:29:44 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id C158364E2D;
        Fri, 12 Feb 2021 12:29:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1613132944;
        bh=L+DC0XO8BwIOcmCvki0MavTo3Ymk/I7Fmbv9AioCPVo=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=XfHH3pgDcPudqwJjWh9sQT/3zcQe0SpoXSUPsXbnd9znCHVcYrW/Sfjcxtbl41ahm
         NEqr4p7tUuBHSDBrl/L3WFYIGLsTaeHPGpPj32J7av4jAfrNed588e4InDLCgcryg2
         pNk6b7ktgFviFoRRNymnc58cJhbLHHypXjs5seAHJKcBQ2RxWITRyAjZvXXVP7SUJF
         zjhKIUcJsNDT5R40W7cKaS65Flf+T2T4H48c2/I9ff0WwYy/JYbCTUt/BgjdOCSSU2
         uzUN+0eKclLClsiz8DVAglvfBZ70bA0lJ2FAuOCg6azhaVBxNXyTRiYxUcrBDUVggW
         8JqPR5OFKufIg==
Received: by quaco.ghostprotocols.net (Postfix, from userid 1000)
        id 44B3140513; Fri, 12 Feb 2021 09:29:01 -0300 (-03)
Date:   Fri, 12 Feb 2021 09:29:01 -0300
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
Message-ID: <20210212122901.GB1398414@kernel.org>
References: <7708cca1-b8f6-c394-75f1-5f9681d625d0@codeweavers.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <7708cca1-b8f6-c394-75f1-5f9681d625d0@codeweavers.com>
X-Url:  http://acmel.wordpress.com
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Em Wed, Feb 10, 2021 at 02:17:49PM -0500, Nicholas Fraser escreveu:
> A non-existent build-id used to be treated as all-zero SHA-1 hash.
> Build-ids are now variable width. A non-existent build-id is an empty
> string and "perf buildid-list" pads this with spaces.
> 
> This fixes "perf-archive" to skip missing build-ids by skipping lines
> that start with a padding space rather than with zeroes.
> 
> Signed-off-by: Nicholas Fraser <nfraser@codeweavers.com>
> ---
>  tools/perf/perf-archive.sh | 3 +--
>  1 file changed, 1 insertion(+), 2 deletions(-)
> 
> diff --git a/tools/perf/perf-archive.sh b/tools/perf/perf-archive.sh
> index 0cfb3e2cefef..133f0eddbcc4 100644
> --- a/tools/perf/perf-archive.sh
> +++ b/tools/perf/perf-archive.sh
> @@ -20,9 +20,8 @@ else
>  fi
>  
>  BUILDIDS=$(mktemp /tmp/perf-archive-buildids.XXXXXX)
> -NOBUILDID=0000000000000000000000000000000000000000
>  
> -perf buildid-list -i $PERF_DATA --with-hits | grep -v "^$NOBUILDID " > $BUILDIDS
> +perf buildid-list -i $PERF_DATA --with-hits | grep -v "^ " > $BUILDIDS
>  if [ ! -s $BUILDIDS ] ; then
>  	echo "perf archive: no build-ids found"
>  	rm $BUILDIDS || true

What should we do when using older files? We have to support both cases.

- Arnaldo
