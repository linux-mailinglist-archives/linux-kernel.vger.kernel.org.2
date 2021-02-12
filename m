Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A2109319E7A
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Feb 2021 13:38:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230311AbhBLMfI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 12 Feb 2021 07:35:08 -0500
Received: from mail.kernel.org ([198.145.29.99]:53878 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229965AbhBLMfE (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 12 Feb 2021 07:35:04 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id 7ED6C6024A;
        Fri, 12 Feb 2021 12:34:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1613133263;
        bh=30Ryb5NwLiOdhh3x8OJtvw+nFA5R/PlajuHrbKYvioY=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=JcDVyRL8/RbrC1Bn25ibtuKPpMM2idJ/cfOkE/p8OmivlXFq8tk9t4ePbW2k10vPq
         kF7z5bpXFZMTSJckY3qB2J8Xm32oFWSzSFrS6u0t5RaV2jqyjAGwwKP9vRhaVklqcZ
         3zv4gjUwDgD7ABoLg6hLKwiRcpBsxZZSHvEXxyiBK/YghDC5A4gqFwgphlNGsPV96F
         vdIZFryF0QGP+oNOrX/jx4lXy2MCsWFfCgUqEcu8e6cI0D5k3z/fW8F85HNq/KM/UP
         IJuEfAJdVhc8QNQJkAD2bHwmkhhOgc4UbdWvBQDH8Tdd+aXbMrVhajpyT3vhBL/qEd
         iLM6EdzM955Xw==
Received: by quaco.ghostprotocols.net (Postfix, from userid 1000)
        id 6D68940513; Fri, 12 Feb 2021 09:34:21 -0300 (-03)
Date:   Fri, 12 Feb 2021 09:34:21 -0300
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
Subject: Re: [PATCH 4/4] perf report: Fix return value when loading PE DSO
Message-ID: <20210212123421.GC1398414@kernel.org>
References: <1671b43b-09c3-1911-dbf8-7f030242fbf7@codeweavers.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1671b43b-09c3-1911-dbf8-7f030242fbf7@codeweavers.com>
X-Url:  http://acmel.wordpress.com
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Em Wed, Feb 10, 2021 at 02:18:02PM -0500, Nicholas Fraser escreveu:
> The first time dso__load() was called on a PE file it always returned -1
> error. This caused the first call to map__find_symbol() to always fail
> on a PE file so the first sample from each PE file always had symbol
> <unknown>. Subsequent samples succeed however because the DSO is already
> loaded.
> 
> This fixes dso__load() to return 0 when successfully loading a DSO with
> libbfd.

You forgot to add this:

Fixes: eac9a4342e5447ca ("perf symbols: Try reading the symbol table with libbfd")

This helps, for instance, the stable@kernel.org guys, since their
scripts will scrape this and find that it should also go to whatever
stable releases are based on:

  $ git tag --contains eac9a4342e5447ca | grep ^v[45].* | grep -v -- -rc
  v5.10
  $

Applied and added the Fixes tag,

- Arnaldo
 
> Signed-off-by: Nicholas Fraser <nfraser@codeweavers.com>
> ---
>  tools/perf/util/symbol.c | 4 +++-
>  1 file changed, 3 insertions(+), 1 deletion(-)
> 
> diff --git a/tools/perf/util/symbol.c b/tools/perf/util/symbol.c
> index aa9ae875b995..492c873713cc 100644
> --- a/tools/perf/util/symbol.c
> +++ b/tools/perf/util/symbol.c
> @@ -1861,8 +1861,10 @@ int dso__load(struct dso *dso, struct map *map)
>  		if (nsexit)
>  			nsinfo__mountns_enter(dso->nsinfo, &nsc);
>  
> -		if (bfdrc == 0)
> +		if (bfdrc == 0) {
> +			ret = 0;
>  			break;
> +		}
>  
>  		if (!is_reg || sirc < 0)
>  			continue;
> -- 
> 2.30.0
> 

-- 

- Arnaldo
