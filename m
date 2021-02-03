Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5654930E45D
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Feb 2021 21:56:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232552AbhBCUz5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 3 Feb 2021 15:55:57 -0500
Received: from mail.kernel.org ([198.145.29.99]:33138 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232531AbhBCUzq (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 Feb 2021 15:55:46 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id 298C864F5C;
        Wed,  3 Feb 2021 20:55:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1612385705;
        bh=V0GGg9QawpOsBMvqxTut1grASaVsw2B+tYwTDx+mCWw=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=H3marjWyRdmvK5E0wKnkOXGU3/tgcn9lFvPDeepLHF5JPz10nbdBz5sc7zlwdPHzI
         FFdv6JAkOEK3s5hI8q2l52icV5NaWI04Ps9FefbI5SsBL4aHuo0x/V8ebMHtBQmtQq
         mrG4CjRsL3y1EWBEZOS5QZXl9dtAPsqHR+aMMhOI9/TmTOntTS983EkAEctdKF38Hb
         5Tc/AKfJ9ervr5+QXDRSt8se1pEtdbw6nO+f6oWyGeukZdR0CWWybg94f2I4h0tNlJ
         PhbkHqlAAWSCjFFaaBVdb8GK4pv4j0k04wMrqUx9EhYo1L8kjuCcRGwRo+kWMear4z
         PZSuCLKdJLqAw==
Received: by quaco.ghostprotocols.net (Postfix, from userid 1000)
        id E6B0140513; Wed,  3 Feb 2021 17:55:02 -0300 (-03)
Date:   Wed, 3 Feb 2021 17:55:02 -0300
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     Namhyung Kim <namhyung@kernel.org>,
        Alexander Antonov <alexander.antonov@linux.intel.com>
Cc:     linux-kernel@vger.kernel.org, Jiri Olsa <jolsa@kernel.org>,
        Andi Kleen <ak@linux.intel.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Ian Rogers <irogers@google.com>,
        Ingo Molnar <mingo@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>
Subject: Re: [PATCH v4 0/5] perf stat: Introduce iostat mode to provide I/O
 performance metrics
Message-ID: <20210203205502.GN854763@kernel.org>
References: <20210203135830.38568-1-alexander.antonov@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210203135830.38568-1-alexander.antonov@linux.intel.com>
X-Url:  http://acmel.wordpress.com
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Em Wed, Feb 03, 2021 at 04:58:25PM +0300, Alexander Antonov escreveu:
> The previous version can be found at:
> v3: https://lkml.kernel.org/r/20210126080619.30275-1-alexander.antonov@linux.intel.com/
> Changes in this revision are:
> v3 -> v4:
> - Addressed comment from Namhyung Kim:
>    1. Removed NULL-termination of root ports list

Hi Namhyung,

	Are you ok with this patchkit now?

Thanks,

- Arnaldo
 
> The previous version can be found at:
> v2: https://lkml.kernel.org/r/20201223130320.3930-1-alexander.antonov@linux.intel.com
> 
> Changes in this revision are:
> v2 -> v3:
> - Addressed comments from Namhyung Kim:
>   1. Removed perf_device pointer from evsel structure. Use priv field instead
>   2. Renamed 'iiostat' to 'iostat'
>   3. Renamed 'show' mode to 'list' mode
>   4. Renamed iiostat_delete_root_ports() to iiostat_release() and
>      iostat_show_root_ports() to iostat_list()
> 
> The previous version can be found at:
> v1: https://lkml.kernel.org/r/20201210090340.14358-1-alexander.antonov@linux.intel.com
> 
> Changes in this revision are:
> v1 -> v2:
> - Addressed comment from Arnaldo Carvalho de Melo:
>   1. Using 'perf iiostat' subcommand instead of 'perf stat --iiostat':
>     - Added perf-iiostat.sh script to use short command
>     - Updated manual pages to get help for 'perf iiostat'
>     - Added 'perf-iiostat' to perf's gitignore file
> 
> Mode is intended to provide four I/O performance metrics in MB per each
> root port:
>  - Inbound Read:   I/O devices below root port read from the host memory
>  - Inbound Write:  I/O devices below root port write to the host memory
>  - Outbound Read:  CPU reads from I/O devices below root port
>  - Outbound Write: CPU writes to I/O devices below root port
> 
> Each metric requiries only one uncore event which increments at every 4B
> transfer in corresponding direction. The formulas to compute metrics
> are generic:
>     #EventCount * 4B / (1024 * 1024)
> 
> Note: iostat introduces new perf data aggregation mode - per PCIe root port
> hence -e and -M options are not supported.
> 
> Usage examples:
> 
> 1. List all PCIe root ports (example for 2-S platform):
>    $ perf iostat list
>    S0-uncore_iio_0<0000:00>
>    S1-uncore_iio_0<0000:80>
>    S0-uncore_iio_1<0000:17>
>    S1-uncore_iio_1<0000:85>
>    S0-uncore_iio_2<0000:3a>
>    S1-uncore_iio_2<0000:ae>
>    S0-uncore_iio_3<0000:5d>
>    S1-uncore_iio_3<0000:d7>
> 
> 2. Collect metrics for all PCIe root ports:
>    $ perf iostat -- dd if=/dev/zero of=/dev/nvme0n1 bs=1M oflag=direct
>    357708+0 records in
>    357707+0 records out
>    375083606016 bytes (375 GB, 349 GiB) copied, 215.974 s, 1.7 GB/s
> 
>     Performance counter stats for 'system wide':
> 
>       port             Inbound Read(MB)    Inbound Write(MB)    Outbound Read(MB)   Outbound Write(MB) 
>    0000:00                    1                    0                    2                    3 
>    0000:80                    0                    0                    0                    0 
>    0000:17               352552                   43                    0                   21 
>    0000:85                    0                    0                    0                    0 
>    0000:3a                    3                    0                    0                    0 
>    0000:ae                    0                    0                    0                    0 
>    0000:5d                    0                    0                    0                    0 
>    0000:d7                    0                    0                    0                    0
> 
> 3. Collect metrics for comma separated list of PCIe root ports:
>    $ perf iostat 0000:17,0:3a -- dd if=/dev/zero of=/dev/nvme0n1 bs=1M oflag=direct
>    357708+0 records in
>    357707+0 records out
>    375083606016 bytes (375 GB, 349 GiB) copied, 197.08 s, 1.9 GB/s
> 
>     Performance counter stats for 'system wide':
> 
>       port             Inbound Read(MB)    Inbound Write(MB)    Outbound Read(MB)   Outbound Write(MB) 
>    0000:17               358559                   44                    0                   22 
>    0000:3a                    3                    2                    0                    0 
> 
>         197.081983474 seconds time elapsed
> 
> 
> Alexander Antonov (5):
>   perf stat: Add AGGR_PCIE_PORT mode
>   perf stat: Basic support for iostat in perf
>   perf stat: Helper functions for PCIe root ports list in iostat mode
>   perf stat: Enable iostat mode for x86 platforms
>   perf: Update .gitignore file
> 
>  tools/perf/.gitignore                         |   1 +
>  tools/perf/Documentation/perf-iostat.txt      |  88 ++++
>  tools/perf/Makefile.perf                      |   5 +-
>  tools/perf/arch/x86/util/Build                |   1 +
>  tools/perf/arch/x86/util/iostat.c             | 469 ++++++++++++++++++
>  tools/perf/builtin-stat.c                     |  36 +-
>  tools/perf/command-list.txt                   |   1 +
>  tools/perf/perf-iostat.sh                     |  12 +
>  tools/perf/util/iostat.h                      |  32 ++
>  .../scripting-engines/trace-event-python.c    |   3 +-
>  tools/perf/util/stat-display.c                |  53 +-
>  tools/perf/util/stat-shadow.c                 |  11 +-
>  tools/perf/util/stat.c                        |   4 +-
>  tools/perf/util/stat.h                        |   2 +
>  14 files changed, 710 insertions(+), 8 deletions(-)
>  create mode 100644 tools/perf/Documentation/perf-iostat.txt
>  create mode 100644 tools/perf/arch/x86/util/iostat.c
>  create mode 100644 tools/perf/perf-iostat.sh
>  create mode 100644 tools/perf/util/iostat.h
> 
> 
> base-commit: b145b0eb2031a620ca010174240963e4d2c6ce26
> -- 
> 2.19.1
> 

-- 

- Arnaldo
