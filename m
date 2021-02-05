Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A44CC3109B4
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Feb 2021 12:00:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231961AbhBEK7Q (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 5 Feb 2021 05:59:16 -0500
Received: from mail-qv1-f43.google.com ([209.85.219.43]:38363 "EHLO
        mail-qv1-f43.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230494AbhBEKx3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 5 Feb 2021 05:53:29 -0500
Received: by mail-qv1-f43.google.com with SMTP id n14so3191314qvg.5
        for <linux-kernel@vger.kernel.org>; Fri, 05 Feb 2021 02:53:08 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=geGLw7VW2QE1+h+Ii4EgXAX5QNeEQoMw9jvD4Omy1G4=;
        b=DRcDdptobe8oca+i2U5/6Roig80uaOMTaRxmKh5ZmpOwI1rEx6R/mwcCk96StJpByw
         ypnTYVEdWfhX6R71LmPmKDyXKLg4MkghqBWBTOPaWa48qJWuV+cRbp4zgzxd0+Ik5L7g
         tEEjo4EcpPEneSMcboa3yTSmMEiJig6zuySLI4vLILL0BPST4YJee6in5Zv5CJacFk3Y
         tsCpufB5oxUEl1si9mCdv/y6pWcYn2GSj0tqjHjAaas+5O+V28naM1ag1d/5J8OH7wuL
         lacus46TB2DfRyNkyUfzUlyWPXoWXWHBNgGlEScKg3AfwyBVX43xHck48S1zjk0Bdceo
         OpMA==
X-Gm-Message-State: AOAM53010e1RhrL3yIiE94IPYogIgmLsDbB4HeMhzgoyFO5xlG1dKmMu
        XAIp9CQr5SAsx4rHU4lpzfQor89qqP54ylv9fV4Li840
X-Google-Smtp-Source: ABdhPJylLAyoXMDXjrODrIi/W6orO0cp/QZE73QPVT18mq87e+W4cT2z6j54IuxrVq8Guw/gnTS1Z9h1KDUmb1KGEgI=
X-Received: by 2002:ad4:5047:: with SMTP id m7mr3617529qvq.26.1612522363084;
 Fri, 05 Feb 2021 02:52:43 -0800 (PST)
MIME-Version: 1.0
References: <1612296553-21962-1-git-send-email-kan.liang@linux.intel.com> <1612296553-21962-3-git-send-email-kan.liang@linux.intel.com>
In-Reply-To: <1612296553-21962-3-git-send-email-kan.liang@linux.intel.com>
From:   Namhyung Kim <namhyung@kernel.org>
Date:   Fri, 5 Feb 2021 19:52:31 +0900
Message-ID: <CAM9d7cjDYALhR-xd2n2vaL5cPBiMz8RukziQqsfqqYwqBc87yA@mail.gmail.com>
Subject: Re: [PATCH 2/9] perf tools: Support the auxiliary event
To:     Kan Liang <kan.liang@linux.intel.com>
Cc:     Arnaldo Carvalho de Melo <acme@kernel.org>,
        Ingo Molnar <mingo@kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Stephane Eranian <eranian@google.com>,
        Jiri Olsa <jolsa@redhat.com>, Andi Kleen <ak@linux.intel.com>,
        Yao Jin <yao.jin@linux.intel.com>, maddy@linux.vnet.ibm.com
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Feb 3, 2021 at 5:14 AM <kan.liang@linux.intel.com> wrote:
>
> From: Kan Liang <kan.liang@linux.intel.com>
>
> On the Intel Sapphire Rapids server, an auxiliary event has to be
> enabled simultaneously with the load latency event to retrieve complete
> Memory Info.
>
> Add X86 specific perf_mem_events__name() to handle the auxiliary event.
> - Users are only interested in the samples of the mem-loads event.
>   Sample read the auxiliary event.
> - The auxiliary event must be in front of the load latency event in a
>   group. Assume the second event to sample if the auxiliary event is the
>   leader.
> - Add a weak is_mem_loads_aux_event() to check the auxiliary event for
>   X86. For other ARCHs, it always return false.
>
> Parse the unique event name, mem-loads-aux, for the auxiliary event.
>
> Signed-off-by: Kan Liang <kan.liang@linux.intel.com>
> ---
>  tools/perf/arch/x86/util/Build        |  1 +
>  tools/perf/arch/x86/util/mem-events.c | 44 +++++++++++++++++++++++++++++++++++
>  tools/perf/util/evsel.c               |  3 +++
>  tools/perf/util/mem-events.c          |  5 ++++
>  tools/perf/util/mem-events.h          |  2 ++
>  tools/perf/util/parse-events.l        |  1 +
>  tools/perf/util/record.c              |  5 +++-
>  7 files changed, 60 insertions(+), 1 deletion(-)
>  create mode 100644 tools/perf/arch/x86/util/mem-events.c
>
> diff --git a/tools/perf/arch/x86/util/Build b/tools/perf/arch/x86/util/Build
> index 347c39b..d73f548 100644
> --- a/tools/perf/arch/x86/util/Build
> +++ b/tools/perf/arch/x86/util/Build
> @@ -6,6 +6,7 @@ perf-y += perf_regs.o
>  perf-y += topdown.o
>  perf-y += machine.o
>  perf-y += event.o
> +perf-y += mem-events.o
>
>  perf-$(CONFIG_DWARF) += dwarf-regs.o
>  perf-$(CONFIG_BPF_PROLOGUE) += dwarf-regs.o
> diff --git a/tools/perf/arch/x86/util/mem-events.c b/tools/perf/arch/x86/util/mem-events.c
> new file mode 100644
> index 0000000..11b8469
> --- /dev/null
> +++ b/tools/perf/arch/x86/util/mem-events.c
> @@ -0,0 +1,44 @@
> +// SPDX-License-Identifier: GPL-2.0
> +#include "util/pmu.h"
> +#include "map_symbol.h"
> +#include "mem-events.h"
> +
> +static char mem_loads_name[100];
> +static bool mem_loads_name__init;
> +
> +#define MEM_LOADS_AUX          0x8203
> +#define MEM_LOADS_AUX_NAME     "{cpu/mem-loads-aux/,cpu/mem-loads,ldlat=%u/pp}:S"
> +
> +bool is_mem_loads_aux_event(struct evsel *leader)
> +{
> +       if (!pmu_have_event("cpu", "mem-loads-aux"))
> +               return false;
> +
> +       return leader->core.attr.config == MEM_LOADS_AUX;
> +}
> +
> +char *perf_mem_events__name(int i)
> +{
> +       struct perf_mem_event *e = perf_mem_events__ptr(i);
> +
> +       if (!e)
> +               return NULL;
> +
> +       if (i == PERF_MEM_EVENTS__LOAD) {
> +               if (mem_loads_name__init)
> +                       return mem_loads_name;
> +
> +               mem_loads_name__init = true;
> +
> +               if (pmu_have_event("cpu", "mem-loads-aux")) {
> +                       scnprintf(mem_loads_name, sizeof(MEM_LOADS_AUX_NAME),
> +                                 MEM_LOADS_AUX_NAME, perf_mem_events__loads_ldlat);

It changes "%u" to an actual latency value, right?
What if the value takes 3 or more digits?
I'm not sure scnprintf() will handle it properly.

Thanks,
Namhyung


> +               } else {
> +                       scnprintf(mem_loads_name, sizeof(mem_loads_name),
> +                                 e->name, perf_mem_events__loads_ldlat);
> +               }
> +               return mem_loads_name;
> +       }
> +
> +       return (char *)e->name;
> +}
