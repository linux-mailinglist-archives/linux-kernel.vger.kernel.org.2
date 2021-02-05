Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A0C863116BF
	for <lists+linux-kernel@lfdr.de>; Sat,  6 Feb 2021 00:19:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231735AbhBEXL3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 5 Feb 2021 18:11:29 -0500
Received: from mail.kernel.org ([198.145.29.99]:42294 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232698AbhBEOdU (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 5 Feb 2021 09:33:20 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id 43C4764E35;
        Fri,  5 Feb 2021 15:26:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1612538812;
        bh=fehTE/q4VZgMziF3SZloJ0EUWPxvv7VnVZUbg40Huac=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=bPUCK4dpE1aJrlX6TSgRpkP3VXWgQw7/iQMfYLNFFYV+VmNSkURqHaEiRsuyQKMjB
         kPCvGR250J8lawkPBXnDT/uQ3nFhNutFFaeC5IHXyXiX+8JVNY7n2EmxcfpjqLv+i5
         M/szWu/geiHyhCSuNgTH15yoVspDZj3iutZs26PvJHo8LKvtvG6IQCD0+VL4m88eO4
         9KwWgiYtjVqpThZGI1FXUDYNMx9fSoHrNt7hG3mgKJN8ozx5gJI6nDA5mQ5vQOqt8E
         PHCU3+//S+9O+WvQ1LbAK9JXlaUiZpPL3zYYc3DT06chCg2xcyC0nTEuRk9gZTkK2K
         qnNpWfzkAH+iA==
Received: by quaco.ghostprotocols.net (Postfix, from userid 1000)
        id C20B040513; Fri,  5 Feb 2021 12:26:48 -0300 (-03)
Date:   Fri, 5 Feb 2021 12:26:48 -0300
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     "Liang, Kan" <kan.liang@linux.intel.com>
Cc:     Namhyung Kim <namhyung@kernel.org>, Ingo Molnar <mingo@kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Stephane Eranian <eranian@google.com>,
        Jiri Olsa <jolsa@redhat.com>, Andi Kleen <ak@linux.intel.com>,
        Yao Jin <yao.jin@linux.intel.com>, maddy@linux.vnet.ibm.com
Subject: Re: [PATCH 2/9] perf tools: Support the auxiliary event
Message-ID: <20210205152648.GC920417@kernel.org>
References: <1612296553-21962-1-git-send-email-kan.liang@linux.intel.com>
 <1612296553-21962-3-git-send-email-kan.liang@linux.intel.com>
 <CAM9d7cjDYALhR-xd2n2vaL5cPBiMz8RukziQqsfqqYwqBc87yA@mail.gmail.com>
 <33221095-5ef6-bec8-136e-34dc14ae7adb@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <33221095-5ef6-bec8-136e-34dc14ae7adb@linux.intel.com>
X-Url:  http://acmel.wordpress.com
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Em Fri, Feb 05, 2021 at 09:13:34AM -0500, Liang, Kan escreveu:
> 
> 
> On 2/5/2021 5:52 AM, Namhyung Kim wrote:
> > On Wed, Feb 3, 2021 at 5:14 AM <kan.liang@linux.intel.com> wrote:
> > > 
> > > From: Kan Liang <kan.liang@linux.intel.com>
> > > 
> > > On the Intel Sapphire Rapids server, an auxiliary event has to be
> > > enabled simultaneously with the load latency event to retrieve complete
> > > Memory Info.
> > > 
> > > Add X86 specific perf_mem_events__name() to handle the auxiliary event.
> > > - Users are only interested in the samples of the mem-loads event.
> > >    Sample read the auxiliary event.
> > > - The auxiliary event must be in front of the load latency event in a
> > >    group. Assume the second event to sample if the auxiliary event is the
> > >    leader.
> > > - Add a weak is_mem_loads_aux_event() to check the auxiliary event for
> > >    X86. For other ARCHs, it always return false.
> > > 
> > > Parse the unique event name, mem-loads-aux, for the auxiliary event.
> > > 
> > > Signed-off-by: Kan Liang <kan.liang@linux.intel.com>
> > > ---
> > >   tools/perf/arch/x86/util/Build        |  1 +
> > >   tools/perf/arch/x86/util/mem-events.c | 44 +++++++++++++++++++++++++++++++++++
> > >   tools/perf/util/evsel.c               |  3 +++
> > >   tools/perf/util/mem-events.c          |  5 ++++
> > >   tools/perf/util/mem-events.h          |  2 ++
> > >   tools/perf/util/parse-events.l        |  1 +
> > >   tools/perf/util/record.c              |  5 +++-
> > >   7 files changed, 60 insertions(+), 1 deletion(-)
> > >   create mode 100644 tools/perf/arch/x86/util/mem-events.c
> > > 
> > > diff --git a/tools/perf/arch/x86/util/Build b/tools/perf/arch/x86/util/Build
> > > index 347c39b..d73f548 100644
> > > --- a/tools/perf/arch/x86/util/Build
> > > +++ b/tools/perf/arch/x86/util/Build
> > > @@ -6,6 +6,7 @@ perf-y += perf_regs.o
> > >   perf-y += topdown.o
> > >   perf-y += machine.o
> > >   perf-y += event.o
> > > +perf-y += mem-events.o
> > > 
> > >   perf-$(CONFIG_DWARF) += dwarf-regs.o
> > >   perf-$(CONFIG_BPF_PROLOGUE) += dwarf-regs.o
> > > diff --git a/tools/perf/arch/x86/util/mem-events.c b/tools/perf/arch/x86/util/mem-events.c
> > > new file mode 100644
> > > index 0000000..11b8469
> > > --- /dev/null
> > > +++ b/tools/perf/arch/x86/util/mem-events.c
> > > @@ -0,0 +1,44 @@
> > > +// SPDX-License-Identifier: GPL-2.0
> > > +#include "util/pmu.h"
> > > +#include "map_symbol.h"
> > > +#include "mem-events.h"
> > > +
> > > +static char mem_loads_name[100];
> > > +static bool mem_loads_name__init;
> > > +
> > > +#define MEM_LOADS_AUX          0x8203
> > > +#define MEM_LOADS_AUX_NAME     "{cpu/mem-loads-aux/,cpu/mem-loads,ldlat=%u/pp}:S"
> > > +
> > > +bool is_mem_loads_aux_event(struct evsel *leader)
> > > +{
> > > +       if (!pmu_have_event("cpu", "mem-loads-aux"))
> > > +               return false;
> > > +
> > > +       return leader->core.attr.config == MEM_LOADS_AUX;
> > > +}
> > > +
> > > +char *perf_mem_events__name(int i)
> > > +{
> > > +       struct perf_mem_event *e = perf_mem_events__ptr(i);
> > > +
> > > +       if (!e)
> > > +               return NULL;
> > > +
> > > +       if (i == PERF_MEM_EVENTS__LOAD) {
> > > +               if (mem_loads_name__init)
> > > +                       return mem_loads_name;
> > > +
> > > +               mem_loads_name__init = true;
> > > +
> > > +               if (pmu_have_event("cpu", "mem-loads-aux")) {
> > > +                       scnprintf(mem_loads_name, sizeof(MEM_LOADS_AUX_NAME),
> > > +                                 MEM_LOADS_AUX_NAME, perf_mem_events__loads_ldlat);
> > 
> > It changes "%u" to an actual latency value, right?
> > What if the value takes 3 or more digits?
> > I'm not sure scnprintf() will handle it properly.
> > 
> 
> Yes, you are right. We should use the sizeof(mem_loads_name) as below.
> I will submit a patch to fix it.
> 
> diff --git a/tools/perf/arch/x86/util/mem-events.c
> b/tools/perf/arch/x86/util/mem-events.c
> index 11b8469..588110f 100644
> --- a/tools/perf/arch/x86/util/mem-events.c
> +++ b/tools/perf/arch/x86/util/mem-events.c
> @@ -31,7 +31,7 @@ char *perf_mem_events__name(int i)
>  		mem_loads_name__init = true;
> 
>  		if (pmu_have_event("cpu", "mem-loads-aux")) {
> -			scnprintf(mem_loads_name, sizeof(MEM_LOADS_AUX_NAME),
> +			scnprintf(mem_loads_name, sizeof(mem_loads_name),
>  				  MEM_LOADS_AUX_NAME, perf_mem_events__loads_ldlat);
>  		} else {
>  			scnprintf(mem_loads_name, sizeof(mem_loads_name),

I'll fold this in the relevant cset.

- Arnaldo
