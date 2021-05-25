Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 567A7390171
	for <lists+linux-kernel@lfdr.de>; Tue, 25 May 2021 14:59:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232952AbhEYNA2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 25 May 2021 09:00:28 -0400
Received: from mail.kernel.org ([198.145.29.99]:44262 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232720AbhEYNAZ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 May 2021 09:00:25 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id CAB5F61420;
        Tue, 25 May 2021 12:58:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1621947536;
        bh=IHLsay1yxDKFQojporc5Q7IlfrGGC3BXPTISSrdD2Wk=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=OWnr0fvvRu9qKRAmuHHruCmKWTH0QP0sCdMH45NwJpF51LgGDyK9Q22Zogoo3WvLc
         uwZjgwyFl/tbneWvz3wWg9lSk6tdU359E2zi4e0cJ/VWAbKRUI3T2TyD4y2Hb0Xu0U
         gantkPFGcOFAq/Z7EqxskvzKGEqpLoTDLeKzvhW0ASSHWYX5JlHLvWf5cavtmojyJL
         fCf9M2wtJcBLx5GYv6tROSRpHqekhn9B/TpTctw/IuV25e/MDLvM4Ry0itqgn81dHt
         3ihC7CqQsP/YtYEIkcY4xEWAhjLQLL9DTe3yVntc6TdVZ39Gn2Io0Xkq/PdbCYimmb
         d+jdKVGDhgV/w==
Received: by quaco.ghostprotocols.net (Postfix, from userid 1000)
        id 5F8344011C; Tue, 25 May 2021 09:58:53 -0300 (-03)
Date:   Tue, 25 May 2021 09:58:53 -0300
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     Adrian Hunter <adrian.hunter@intel.com>
Cc:     Jiri Olsa <jolsa@redhat.com>, Andi Kleen <ak@linux.intel.com>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 00/10] perf scripting python: Improve general scripting
 for Intel PT
Message-ID: <YKz0jWpWHmNSr+bS@kernel.org>
References: <20210525095112.1399-1-adrian.hunter@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210525095112.1399-1-adrian.hunter@intel.com>
X-Url:  http://acmel.wordpress.com
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Em Tue, May 25, 2021 at 12:51:02PM +0300, Adrian Hunter escreveu:
> Hi
> 
> These patches make it easier to customize scripting for Intel PT traces.
> 
> The first patch is a dependent fix.
> 
> Subsequent patches add more information to python scripting.
> 
> The final patch adds a branch trace to the intel-pt-events.py script
> which previously supported only power events and ptwrite.

Thanks, applied.

- Arnaldo

 
> 
> Adrian Hunter (10):
>       perf scripting python: Fix tuple_set_u64()
>       perf scripting python: Factor out set_sym_in_dict()
>       perf scripting python: Add 'addr_location' for 'addr'
>       perf script: Factor out perf_sample__sprintf_flags()
>       perf scripting python: Add sample flags
>       perf scripting python: Add IPC
>       perf scripting python: Add cpumode
>       perf scripting python: Add context switch
>       perf scripting python: Add auxtrace error
>       perf scripts python: intel-pt-events.py: Add branches to script
> 
>  tools/perf/builtin-script.c                        |  56 +++-
>  .../perf/scripts/python/bin/intel-pt-events-record |   4 +-
>  .../perf/scripts/python/bin/intel-pt-events-report |   4 +-
>  tools/perf/scripts/python/intel-pt-events.py       | 143 +++++++--
>  tools/perf/util/db-export.c                        |  12 +-
>  tools/perf/util/db-export.h                        |   2 +-
>  .../perf/util/scripting-engines/trace-event-perl.c |   3 +-
>  .../util/scripting-engines/trace-event-python.c    | 321 +++++++++++++++------
>  tools/perf/util/trace-event-scripting.c            |   3 +-
>  tools/perf/util/trace-event.h                      |   8 +-
>  10 files changed, 415 insertions(+), 141 deletions(-)
> 
> 
> Regards
> Adrian

-- 

- Arnaldo
