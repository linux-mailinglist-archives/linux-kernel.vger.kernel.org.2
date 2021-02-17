Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E10EC31DF07
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Feb 2021 19:21:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234799AbhBQSUS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 17 Feb 2021 13:20:18 -0500
Received: from mail.kernel.org ([198.145.29.99]:55244 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S234802AbhBQSUL (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 Feb 2021 13:20:11 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id 1D04764DFF;
        Wed, 17 Feb 2021 18:19:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1613585971;
        bh=YI0feRKi0HADFgtGGKnsDY6OxjSAOTUzUGmBggQklsc=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=C60iXVbl2YEKNoduSi3hgGlTi2lHPLugweknDDwSsMunPnScI3ieeDHFWD2UP4T0J
         Qb6RyiXPZDngHoaV4+UhGVaK4N9lSPW07SvgLg38o3ZSxD1RWI/emvWY1G5qH7gsg3
         07q/awsMe6OTV6IPaOPGru8bNLXIs8nPl7nkue/lp1aQLRsl4Vi1+jcEnvGmVTHYR+
         ZgVYNUUgF8AZskA+FC0z71mLdF7X5yft73wGH1w+JkQ+u9SjQGBqwk147q4zjURLZ9
         FnpSTSye0xnnpupEZRk/Bd8r4mEgD0Uy/SW/163p6Ac0k1F7DeUhqekXYLlzUIBSza
         ChQws5eNO62NA==
Received: by quaco.ghostprotocols.net (Postfix, from userid 1000)
        id D254B40CD9; Wed, 17 Feb 2021 15:19:28 -0300 (-03)
Date:   Wed, 17 Feb 2021 15:19:28 -0300
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     Nicholas Fraser <nfraser@codeweavers.com>
Cc:     Jiri Olsa <jolsa@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
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
Subject: Re: [PATCH 1/4] perf buildid-cache: Don't skip 16-byte build-ids
Message-ID: <YC1eMMw39DIkyqtE@kernel.org>
References: <597788e4-661d-633f-857c-3de700115d02@codeweavers.com>
 <YCqF3ENDLNLXoa2j@krava>
 <7f5bc880-7724-643b-5344-c27c4de572ae@codeweavers.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <7f5bc880-7724-643b-5344-c27c4de572ae@codeweavers.com>
X-Url:  http://acmel.wordpress.com
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Em Tue, Feb 16, 2021 at 11:35:06AM -0500, Nicholas Fraser escreveu:
> No problem, I've added a call to "perf buildid-cache -l" in check() to make
> sure the added IDs are reported. The MD5 test fails without the previous
> patch to allow 16-byte build-ids.
> 
> Do you also want PE files tested by this test script? This would make the
> script depend on a number of things:
> 
> - We'd need to change "readelf" to something that can read the build-id of
>   PE files;
> 
> - We'd need MinGW installed to build them on the fly the same as the ELF
>   test cases, although we could use tests/pe-file.exe instead which is
>   already included;
> 
> - We'd need Wine to actually run it under perf record, which I'm sure you
>   don't want to depend on;

We can check if wine is installed, if not, just emit a warning. I, for
one, will install wine for this purpose.
 
> - We'd need to detect whether perf was built with libbfd support. Easily
>   done by calling perf version --build-options but by this point the test
>   case is getting pretty out of hand for what it's supposed to test.

Nope, at least a group of people need to be checking if this new code
doesn't regress, and fix it if it does.
 
> I'll send patches for this test without PE support. It still tests 16-byte
> build-ids because it tests an MD5 ELF file. Let me know if you also want me
> to add PE support to this script. We can make it optionally perform PE
> tests if all of the necessary tools are installed but it would take some
> pretty large changes to the script.
> 
> Nick
> 
> 
> On 2021-02-15 9:31 a.m., Jiri Olsa wrote:
> > On Wed, Feb 10, 2021 at 02:17:25PM -0500, Nicholas Fraser wrote:
> >> lsdir_bid_tail_filter() ignored any build-id that wasn't exactly 20
> >> bytes. This worked only for SHA-1 build-ids. The build-id for a PE file
> >> is always a 16-byte GUID and ELF files can also have MD5 or UUID
> >> build-ids.
> >>
> >> This fix changes the filter to allow build-ids between 16 and 20 bytes.
> > 
> > hi,
> > there's tests/shell/buildid.sh test for this, please add
> > testcase for this.. looks like perf buildid-cacle -l will
> > end up calling this function
> > 
> > thanks,
> > jirka
> > 
> >>
> >> Signed-off-by: Nicholas Fraser <nfraser@codeweavers.com>
> >> ---
> >>  tools/perf/util/build-id.c | 5 +++--
> >>  tools/perf/util/build-id.h | 4 +++-
> >>  2 files changed, 6 insertions(+), 3 deletions(-)
> >>
> >> diff --git a/tools/perf/util/build-id.c b/tools/perf/util/build-id.c
> >> index 02df36b30ac5..e32e8f2ff3bd 100644
> >> --- a/tools/perf/util/build-id.c
> >> +++ b/tools/perf/util/build-id.c
> >> @@ -448,7 +448,8 @@ static bool lsdir_bid_tail_filter(const char *name __maybe_unused,
> >>  	int i = 0;
> >>  	while (isxdigit(d->d_name[i]) && i < SBUILD_ID_SIZE - 3)
> >>  		i++;
> >> -	return (i == SBUILD_ID_SIZE - 3) && (d->d_name[i] == '\0');
> >> +	return (i >= SBUILD_ID_MIN_SIZE - 3) && (i <= SBUILD_ID_SIZE - 3) &&
> >> +		(d->d_name[i] == '\0');
> >>  }
> >>  
> >>  struct strlist *build_id_cache__list_all(bool validonly)
> >> @@ -490,7 +491,7 @@ struct strlist *build_id_cache__list_all(bool validonly)
> >>  		}
> >>  		strlist__for_each_entry(nd2, linklist) {
> >>  			if (snprintf(sbuild_id, SBUILD_ID_SIZE, "%s%s",
> >> -				     nd->s, nd2->s) != SBUILD_ID_SIZE - 1)
> >> +				     nd->s, nd2->s) > SBUILD_ID_SIZE - 1)
> >>  				goto err_out;
> >>  			if (validonly && !build_id_cache__valid_id(sbuild_id))
> >>  				continue;
> >> diff --git a/tools/perf/util/build-id.h b/tools/perf/util/build-id.h
> >> index 02613f4b2c29..c19617151670 100644
> >> --- a/tools/perf/util/build-id.h
> >> +++ b/tools/perf/util/build-id.h
> >> @@ -2,8 +2,10 @@
> >>  #ifndef PERF_BUILD_ID_H_
> >>  #define PERF_BUILD_ID_H_ 1
> >>  
> >> -#define BUILD_ID_SIZE	20
> >> +#define BUILD_ID_SIZE	20 /* SHA-1 length in bytes */
> >> +#define BUILD_ID_MIN_SIZE	16 /* MD5/UUID/GUID length in bytes */
> >>  #define SBUILD_ID_SIZE	(BUILD_ID_SIZE * 2 + 1)
> >> +#define SBUILD_ID_MIN_SIZE	(BUILD_ID_MIN_SIZE * 2 + 1)
> >>  
> >>  #include "machine.h"
> >>  #include "tool.h"
> >> -- 
> >> 2.30.0
> >>
> > 

-- 

- Arnaldo
