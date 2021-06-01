Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9473339751E
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Jun 2021 16:09:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234166AbhFAOLF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 1 Jun 2021 10:11:05 -0400
Received: from mail.kernel.org ([198.145.29.99]:40808 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233964AbhFAOLE (ORCPT <rfc822;Linux-kernel@vger.kernel.org>);
        Tue, 1 Jun 2021 10:11:04 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 7AAF461028;
        Tue,  1 Jun 2021 14:09:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1622556562;
        bh=DA5W9FFrh5QdxOw0yHRORsO4k8KaaNKoll6ybuo+cuM=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=PAW/rATiWwcMP56G2mf1dhHJIbL29vMZCARRJrH52Go9r8PhehQ65m4ugM7E2+Cxv
         nJMdbzb3G6yGHx1LAjtD95SriS9mguQVwwuNZQsGDZ65gSvAYMk9bKG7TyjEI4bHny
         GLylEz4+pkTxsZWWeN/UewMq9hHGFwGIK4K91UPBMmxPqNJVVdSXKo8kkY+Ah/9SQw
         ubSoUhn0JxnuvdV9MQhrDgwssPSYTm+QteXzPzPKKRBUELmKFau2Ypfl8tZpoC9/21
         DAMbskNwlVhtrA1u3My1C3ZMhdpJ9PObR8pIVwshTF4QzfnnmMx/jKkN+BRXgSSn8q
         Q4sOVX1rZ15oA==
Received: by quaco.ghostprotocols.net (Postfix, from userid 1000)
        id 255F04011C; Tue,  1 Jun 2021 11:09:20 -0300 (-03)
Date:   Tue, 1 Jun 2021 11:09:20 -0300
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     Jiri Olsa <jolsa@redhat.com>
Cc:     Jin Yao <yao.jin@linux.intel.com>, jolsa@kernel.org,
        peterz@infradead.org, mingo@redhat.com,
        alexander.shishkin@linux.intel.com, Linux-kernel@vger.kernel.org,
        ak@linux.intel.com, kan.liang@intel.com, yao.jin@intel.com
Subject: Re: [PATCH v2 0/8] perf: Support perf-mem/perf-c2c for AlderLake
Message-ID: <YLY/kCSLPJ1lJ35A@kernel.org>
References: <20210527001610.10553-1-yao.jin@linux.intel.com>
 <YLVn/jh/8H5fZ/QJ@krava>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YLVn/jh/8H5fZ/QJ@krava>
X-Url:  http://acmel.wordpress.com
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Em Tue, Jun 01, 2021 at 12:49:34AM +0200, Jiri Olsa escreveu:
> On Thu, May 27, 2021 at 08:16:02AM +0800, Jin Yao wrote:
> > AlderLake uses a hybrid architecture utilizing Golden Cove cores
> > (core CPU) and Gracemont cores (atom CPU). This patchset supports
> > perf-mem and perf-c2c for AlderLake.
> > 
> > v2:
> > ---
> > - Use mem_loads_name__init to keep original behavior for non-hybrid platform.
> > - Move x86 specific perf_mem_events[] to arch/x86/util/mem-events.c.
> > - Move mem-store event to a new patch.
> > - Add a new patch to fix wrong verbose output for recording events
> > - Add a new patch to disable 'mem-loads-aux' group before reporting
> 
> Acked-by: Jiri Olsa <jolsa@redhat.com>

Thanks, applied.

- Arnaldo

 
> thanks,
> jirka
> 
> > 
> > Jin Yao (8):
> >   perf tools: Check mem-loads auxiliary event
> >   perf tools: Support pmu prefix for mem-load event
> >   perf tools: Support pmu prefix for mem-store event
> >   perf tools: Check if mem_events is supported for hybrid platform
> >   perf mem: Support record for hybrid platform
> >   perf mem: Fix wrong verbose output for recording events
> >   perf mem: Disable 'mem-loads-aux' group before reporting
> >   perf c2c: Support record for hybrid platform
> > 
> >  tools/perf/arch/arm64/util/mem-events.c   |   2 +-
> >  tools/perf/arch/powerpc/util/mem-events.c |   2 +-
> >  tools/perf/arch/x86/util/mem-events.c     |  54 ++++++++++--
> >  tools/perf/builtin-c2c.c                  |  40 +++++----
> >  tools/perf/builtin-mem.c                  |  51 ++++++-----
> >  tools/perf/builtin-report.c               |   2 +
> >  tools/perf/util/evlist.c                  |  25 ++++++
> >  tools/perf/util/evlist.h                  |   1 +
> >  tools/perf/util/mem-events.c              | 101 ++++++++++++++++++++--
> >  tools/perf/util/mem-events.h              |   4 +-
> >  10 files changed, 225 insertions(+), 57 deletions(-)
> > 
> > -- 
> > 2.17.1
> > 
> 

-- 

- Arnaldo
