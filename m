Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 55AF143D189
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Oct 2021 21:18:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240681AbhJ0TVH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 27 Oct 2021 15:21:07 -0400
Received: from mail.kernel.org ([198.145.29.99]:41740 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232939AbhJ0TVF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Oct 2021 15:21:05 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 0DCC060EB4;
        Wed, 27 Oct 2021 19:18:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1635362320;
        bh=QZyxF5mCab0/tbZ83TzsuU8/T++E3MImjOcnMo5e86Y=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=S2m0/nLXMhJxjgwtJKTp4Lh2V4ciAM3p276V3A4nM06gC4pgLvpZ7+tRSr4k7ALMb
         0d6ZXRE0TJhcrZ1tdFtBmqnPP4twJWyP4JAN3tlU+HrZoTzmWZouHv/aLZahb0QkW5
         hhuF4Hd89GlchOJUGvpuDcG9ECZJhlIKo7byd0XZPX+piJfgoSlBMi5dFvxGTz8kd9
         7M/2Frxay0HASye+Hq4IWYNMpb4SA2ZFPjavVSr9fx+jsTlVPbyo4VD7hyKAbqURgR
         kxsPimCHoiP19YxiFVRafWhHHPj9Ud5i0CRhVmQ0Gn2lBu4JUfdU0j08guH4EpD4KD
         VSjPaw0sJ73Ew==
Received: by quaco.ghostprotocols.net (Postfix, from userid 1000)
        id 718FE410A1; Wed, 27 Oct 2021 16:18:37 -0300 (-03)
Date:   Wed, 27 Oct 2021 16:18:37 -0300
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     Adrian Hunter <adrian.hunter@intel.com>
Cc:     Jiri Olsa <jolsa@redhat.com>, Andi Kleen <ak@linux.intel.com>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH V3 0/6] perf dlfilter: Add dlfilter-show-cycles
Message-ID: <YXmmDci4+9P6NCoG@kernel.org>
References: <20211027080334.365596-1-adrian.hunter@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211027080334.365596-1-adrian.hunter@intel.com>
X-Url:  http://acmel.wordpress.com
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Em Wed, Oct 27, 2021 at 11:03:28AM +0300, Adrian Hunter escreveu:
> Hi
> 
> The issue with V1 was that the IPC information used to accumulate cycle
> counts has a lower granularity because it is output only when the cycle
> count correlates to the IP of the event i.e. only when the IPC is exactly
> correct.
> 
> To enable more frequent updates to the cycle count, itrace option 'A' is
> added, which specifies that IPC information can be approximate.
> 
> In addition there are some new miscellaneous patches.

Ok, replacing v2 with this one.
 
> 
> Changes in V3:
> 
>     perf intel-pt: Support itrace A option to approximate IPC
>       Expanded explanation of the loss of accuracy of IPC with 'A' option.
> 
>     Added Reviewed-by: Andi Kleen <ak@linux.intel.com>
> 
> 
> Changes in V2:
> 
>     perf dlfilter: Add dlfilter-show-cycles
>       Separate counts for branches, instructions or other events.
> 
>     New patches:
>       perf auxtrace: Add missing Z option to ITRACE_HELP
>       perf auxtrace: Add itrace A option to approximate IPC
>       perf intel-pt: Support itrace A option to approximate IPC
>       perf auxtrace: Add itrace d+o option to direct debug log to stdout
>       perf intel-pt: Support itrace d+o option to direct debug log to stdout
> 
> 
> Adrian Hunter (6):
>       perf auxtrace: Add missing Z option to ITRACE_HELP
>       perf auxtrace: Add itrace A option to approximate IPC
>       perf intel-pt: Support itrace A option to approximate IPC
>       perf dlfilter: Add dlfilter-show-cycles
>       perf auxtrace: Add itrace d+o option to direct debug log to stdout
>       perf intel-pt: Support itrace d+o option to direct debug log to stdout
> 
>  tools/perf/Documentation/itrace.txt                |   2 +
>  tools/perf/Documentation/perf-intel-pt.txt         |  28 ++++
>  tools/perf/Makefile.perf                           |   2 +-
>  tools/perf/dlfilters/dlfilter-show-cycles.c        | 144 +++++++++++++++++++++
>  tools/perf/util/auxtrace.c                         |   3 +
>  tools/perf/util/auxtrace.h                         |   6 +
>  .../perf/util/intel-pt-decoder/intel-pt-decoder.c  |   1 +
>  .../perf/util/intel-pt-decoder/intel-pt-decoder.h  |   1 +
>  tools/perf/util/intel-pt-decoder/intel-pt-log.c    |   8 +-
>  tools/perf/util/intel-pt.c                         |  21 ++-
>  10 files changed, 205 insertions(+), 11 deletions(-)
>  create mode 100644 tools/perf/dlfilters/dlfilter-show-cycles.c
> 
> 
> Regards
> Adrian

-- 

- Arnaldo
