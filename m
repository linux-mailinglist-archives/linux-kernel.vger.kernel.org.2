Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 972393973CD
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Jun 2021 15:06:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233904AbhFANH5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 1 Jun 2021 09:07:57 -0400
Received: from mail.kernel.org ([198.145.29.99]:39824 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233064AbhFANH4 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Jun 2021 09:07:56 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id DDF9860233;
        Tue,  1 Jun 2021 13:06:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1622552775;
        bh=4xRwXmuVtxkf59vg6MQ7DuHfHb4DjP2d4tmgPEoKbb4=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=iKfhf68IQnU7z6ThowHafzPAmy/mjgPC+63A/sK/ZcBLaF/pLZuTpOOL/W7DHhxoj
         V1cCegL0pZhANPKSmTKIkKhfoKv3So5u3JSgWKs9zzaH2pGPl0Mf/K0o8E++evvj2D
         zG5Y2Y5hTHZRSqjaX+lZejH0JRG4DwBFlCvxGoAoWbXNEEgD0533wHmAenfg49r150
         DqgxPCrOqcu2XxV460aHCzKrNr8DbJ8QDp1G0anrILiRujFJIoJrHwym/Fy1DQJEKk
         JU/vuyPKE1OSrawbIx7GjXMKu9WNeIm5kViDlcPxLZz9kdyr5sc4v7J3n9asV4JkgO
         6uZvZF7ldROog==
Received: by quaco.ghostprotocols.net (Postfix, from userid 1000)
        id 029CC4011C; Tue,  1 Jun 2021 10:06:11 -0300 (-03)
Date:   Tue, 1 Jun 2021 10:06:11 -0300
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     Adrian Hunter <adrian.hunter@intel.com>
Cc:     Jiri Olsa <jolsa@redhat.com>, Andi Kleen <ak@linux.intel.com>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 00/13] perf scripting python: Add insn, srcline and
 srccode
Message-ID: <YLYww32pSoB8sW1d@kernel.org>
References: <20210530192308.7382-1-adrian.hunter@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210530192308.7382-1-adrian.hunter@intel.com>
X-Url:  http://acmel.wordpress.com
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Em Sun, May 30, 2021 at 10:22:55PM +0300, Adrian Hunter escreveu:
> Hi
> 
> Here are some patches to add insn, srcline and srccode to python scripting.
> In addition, it is made possible for a script to set itrace options.
> 
> The first 2 patches are minor tidy-ups.  The next 3 are additions to
> scripting_context. The next 5 add new methods that python scripts can call.
> 
> Then there is a patch to the perf scripting python documentation.
> 
> And finally 2 patches add to the intel-pt-events.py script as an example.

Thanks, applied.

- Arnaldo

 
> 
> Adrian Hunter (13):
>       perf scripting python: Remove unnecessary 'static'
>       perf scripting python: Simplify perf-trace-context module functions
>       perf scripting: Add scripting_context__update()
>       perf scripting: Add perf_session to scripting_context
>       perf scripting python: Assign perf_script_context
>       perf script: Factor out script_fetch_insn()
>       perf scripting python: Add perf_sample_insn()
>       perf auxtrace: Factor out itrace_do_parse_synth_opts()
>       perf scripting python: Add perf_set_itrace_options()
>       perf scripting python: Add perf_sample_srcline() and perf_sample_srccode()
>       perf scripting python: Update documentation for srcline etc
>       perf scripting python: exported-sql-viewer.py: Factor out libxed.py
>       perf scripting python: intel-pt-events.py: Add --insn-trace and --src-trace
> 
>  tools/perf/Documentation/perf-intel-pt.txt         |   6 +-
>  tools/perf/Documentation/perf-script-python.txt    |  46 +++++-
>  tools/perf/builtin-script.c                        |  12 +-
>  .../perf/scripts/python/Perf-Trace-Util/Context.c  | 168 +++++++++++++++++---
>  tools/perf/scripts/python/exported-sql-viewer.py   |  89 +----------
>  tools/perf/scripts/python/intel-pt-events.py       | 176 ++++++++++++++++++---
>  tools/perf/scripts/python/libxed.py                | 107 +++++++++++++
>  tools/perf/util/auxtrace.c                         |  10 +-
>  tools/perf/util/auxtrace.h                         |  10 ++
>  .../perf/util/scripting-engines/trace-event-perl.c |  11 +-
>  .../util/scripting-engines/trace-event-python.c    |  37 ++++-
>  tools/perf/util/trace-event-scripting.c            |  27 +++-
>  tools/perf/util/trace-event.h                      |  20 ++-
>  13 files changed, 568 insertions(+), 151 deletions(-)
>  create mode 100644 tools/perf/scripts/python/libxed.py
> 
> 
> Regards
> Adrian

-- 

- Arnaldo
