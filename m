Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 04A23319E6D
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Feb 2021 13:34:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231310AbhBLM3L (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 12 Feb 2021 07:29:11 -0500
Received: from mail.kernel.org ([198.145.29.99]:53100 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231308AbhBLM2o (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 12 Feb 2021 07:28:44 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id DA1BA64E13;
        Fri, 12 Feb 2021 12:28:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1613132884;
        bh=otNESWfTyHzfwNCsH4dozTLhMQlkVxrd2u6a5KuoCDM=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=JXc8U8w3xsqCgRu0zqbTmz0s/pFKePvJdpY/mBse32jlDCz95Vq5mGcji6z1NULJc
         AINqUI8W5ug+c75hNHE+AcI55mncehvf+XUPhVLfikewx/AJ7Vi6TNFzxolmq1NPpf
         F9JBfwNBWaxLoU8lT1T91xqzyYQa0hzmmoAGDP5J3NoD5x8o1ARbesMKseNaRBm+zo
         Y4baIuTIifA4SnDUqFe1cTJzklpCYzFQPrACbQH//ddqTN0mCbLNwUSyG9OMybhpA2
         33wA8UVWCrtivBeUCvRPi7FwE9GPyzA5X0jlydIwo5kaNoA/KFaaA70FX7GHflK5jV
         45dDxvRX+8rvw==
Received: by quaco.ghostprotocols.net (Postfix, from userid 1000)
        id 055D140513; Fri, 12 Feb 2021 09:28:01 -0300 (-03)
Date:   Fri, 12 Feb 2021 09:28:00 -0300
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
Subject: Re: [PATCH 2/4] perf report: Load PE files from debug cache only
Message-ID: <20210212122800.GA1398414@kernel.org>
References: <e58e1237-94ab-e1c9-a7b9-473531906954@codeweavers.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <e58e1237-94ab-e1c9-a7b9-473531906954@codeweavers.com>
X-Url:  http://acmel.wordpress.com
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Em Wed, Feb 10, 2021 at 02:17:38PM -0500, Nicholas Fraser escreveu:
> dso__load_bfd_symbols() attempts to load a DSO at its original path,
> then closes it and loads the file in the debug cache. This is incorrect.
> It should ignore the original file and work with only the debug cache.
> The original file may have changed or may not even exist, for example if
> the debug cache has been transferred to another machine via "perf
> archive".
> 
> This fix makes it only load the file in the debug cache.

Well this improves your current use case and only affects PE files, so I
am applying, but consider a slightly different workflow:

 1. perf record ./foo.exe
 2. perf report     # works, finds the file in the ~/.debug cache, as stored
                    # by 'perf record'
 3. rm -rf ~/.debug # I need more space
 4. perf report     # Fails, as it looks only in the ~/.debug cache, that
                    # was nuked


So at 4 it should look at the original pathname, and hope for the best.

All this is moot if we have something like a build-id in PE files,
where we can look in any order since we'll verify the unique ID to see
if it is the one we need, right?

- Arnaldo
 
> Signed-off-by: Nicholas Fraser <nfraser@codeweavers.com>
> ---
>  tools/perf/util/symbol.c | 8 +-------
>  1 file changed, 1 insertion(+), 7 deletions(-)
> 
> diff --git a/tools/perf/util/symbol.c b/tools/perf/util/symbol.c
> index 64a039cbba1b..aa9ae875b995 100644
> --- a/tools/perf/util/symbol.c
> +++ b/tools/perf/util/symbol.c
> @@ -1569,7 +1569,7 @@ int dso__load_bfd_symbols(struct dso *dso, const char *debugfile)
>  	u_int i;
>  	u64 start, len;
>  
> -	abfd = bfd_openr(dso->long_name, NULL);
> +	abfd = bfd_openr(debugfile, NULL);
>  	if (!abfd)
>  		return -1;
>  
> @@ -1586,12 +1586,6 @@ int dso__load_bfd_symbols(struct dso *dso, const char *debugfile)
>  	if (section)
>  		dso->text_offset = section->vma - section->filepos;
>  
> -	bfd_close(abfd);
> -
> -	abfd = bfd_openr(debugfile, NULL);
> -	if (!abfd)
> -		return -1;
> -
>  	if (!bfd_check_format(abfd, bfd_object)) {
>  		pr_debug2("%s: cannot read %s bfd file.\n", __func__,
>  			  debugfile);
> -- 
> 2.30.0
> 

-- 

- Arnaldo
