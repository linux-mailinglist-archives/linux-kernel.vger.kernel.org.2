Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1F39D3BDE36
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Jul 2021 21:54:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229953AbhGFT5C (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 6 Jul 2021 15:57:02 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:29956 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229781AbhGFT5B (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Jul 2021 15:57:01 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1625601262;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=YL8es6eBSSAL5YL6xxHnmUAhFHieBRgt+54KoJ328m4=;
        b=KSeetV1p+myXRjPlo+0yPjmOsrXV3sYh+yjBAvm7kO6UPMdL7y/On9TDqbf6u9Ixlh7vkE
        xwb+JXXn0AWnkjQz3n1MYAVjtPp/ALXbZLzc9swsiuf52hW0pQzfKLLVQPIzWraKa6fcqP
        jfTnzc4/JpbUq4zbvciZMVv4wy9/sCg=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-123-K05D83rvNeas6CEuwVr9Sw-1; Tue, 06 Jul 2021 15:54:21 -0400
X-MC-Unique: K05D83rvNeas6CEuwVr9Sw-1
Received: by mail-wr1-f71.google.com with SMTP id a4-20020adffb840000b02901304c660e75so49337wrr.19
        for <Linux-kernel@vger.kernel.org>; Tue, 06 Jul 2021 12:54:20 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=YL8es6eBSSAL5YL6xxHnmUAhFHieBRgt+54KoJ328m4=;
        b=U/dd5LJOGK/gLP3WLbO4IocfPFCZ1tOjHroGE69NE8ByC2d/REYjgS3LxvbG5KA163
         efJeoVx82uXPtCExfYyoqtYhvbCSNUskSvJ6R6SCVd1wgcg58V2IhgUvzmXIpC+ElXt0
         6eek30S4gmewYJ6DAClz5ZOj/UWfajl04RFOQeQWwaHMsNufYiPmbUIAinPZEgQumKV9
         7Qn4VabEcHN0ZYYpiQpoiU+WiTXFpfIp4fqecnCvPrdblH7POvBT1eI2HIPLGFTQsGue
         kaYv7C7/Gj/Ce/hV6TUhrt07Zxd71Ym459ZqEm/9+bTEiTpTC4cc8s6bYlrHFJsWQzos
         490A==
X-Gm-Message-State: AOAM533bVxH9MoQtrF2ovZ2mzGaAp2AJ/sYAcePfc2XPpl6KpfVdbBDo
        i0kc94VB1MH9LT2egofxU59+lZo24ngsYbPj2CelDI4AoXXvoE/+ngn+MMRvdrzqqFQRXfj02L4
        siDtSYcHFH6XjD+mQ2pQO5mwR
X-Received: by 2002:a5d:67cd:: with SMTP id n13mr23630731wrw.201.1625601260136;
        Tue, 06 Jul 2021 12:54:20 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJzcJCL9xrgzjRZPhO2FfHVt4Xi2gG8wt2sGoMA+/zSdOabCVFELmdZzPb7QLKZboB60Uop78A==
X-Received: by 2002:a5d:67cd:: with SMTP id n13mr23630714wrw.201.1625601259947;
        Tue, 06 Jul 2021 12:54:19 -0700 (PDT)
Received: from krava ([185.153.78.55])
        by smtp.gmail.com with ESMTPSA id u9sm18541045wmq.41.2021.07.06.12.54.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 06 Jul 2021 12:54:19 -0700 (PDT)
Date:   Tue, 6 Jul 2021 21:54:15 +0200
From:   Jiri Olsa <jolsa@redhat.com>
To:     "Jin, Yao" <yao.jin@linux.intel.com>
Cc:     acme@kernel.org, jolsa@kernel.org, peterz@infradead.org,
        mingo@redhat.com, alexander.shishkin@linux.intel.com,
        Linux-kernel@vger.kernel.org, ak@linux.intel.com,
        kan.liang@intel.com, yao.jin@intel.com
Subject: Re: [PATCH v3] perf stat: Disable NMI watchdog message on hybrid
Message-ID: <YOS052YU7108zIjx@krava>
References: <20210610034557.29766-1-yao.jin@linux.intel.com>
 <d7d01f73-0253-fe4d-c98a-ae000e289e09@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <d7d01f73-0253-fe4d-c98a-ae000e289e09@linux.intel.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jul 06, 2021 at 10:19:47AM +0800, Jin, Yao wrote:
> Hi Jiri,
> 
> On 6/10/2021 11:45 AM, Jin Yao wrote:
> > If we run a single workload that only runs on big core, there is always a
> > ugly message about disabling the NMI watchdog because the atom is not
> > counted.
> > 
> > Before:
> > 
> >    # ./perf stat true
> > 
> >     Performance counter stats for 'true':
> > 
> >                  0.43 msec task-clock                #    0.396 CPUs utilized
> >                     0      context-switches          #    0.000 /sec
> >                     0      cpu-migrations            #    0.000 /sec
> >                    45      page-faults               #  103.918 K/sec
> >               639,634      cpu_core/cycles/          #    1.477 G/sec
> >         <not counted>      cpu_atom/cycles/                                              (0.00%)
> >               643,498      cpu_core/instructions/    #    1.486 G/sec
> >         <not counted>      cpu_atom/instructions/                                        (0.00%)
> >               123,715      cpu_core/branches/        #  285.694 M/sec
> >         <not counted>      cpu_atom/branches/                                            (0.00%)
> >                 4,094      cpu_core/branch-misses/   #    9.454 M/sec
> >         <not counted>      cpu_atom/branch-misses/                                       (0.00%)
> > 
> >           0.001092407 seconds time elapsed
> > 
> >           0.001144000 seconds user
> >           0.000000000 seconds sys
> > 
> >    Some events weren't counted. Try disabling the NMI watchdog:
> >            echo 0 > /proc/sys/kernel/nmi_watchdog
> >            perf stat ...
> >            echo 1 > /proc/sys/kernel/nmi_watchdog
> > 
> >    # ./perf stat -e '{cpu_atom/cycles/,msr/tsc/}' true
> > 
> >     Performance counter stats for 'true':
> > 
> >         <not counted>      cpu_atom/cycles/                                              (0.00%)
> >         <not counted>      msr/tsc/                                                      (0.00%)
> > 
> >           0.001904106 seconds time elapsed
> > 
> >           0.001947000 seconds user
> >           0.000000000 seconds sys
> > 
> >    Some events weren't counted. Try disabling the NMI watchdog:
> >            echo 0 > /proc/sys/kernel/nmi_watchdog
> >            perf stat ...
> >            echo 1 > /proc/sys/kernel/nmi_watchdog
> >    The events in group usually have to be from the same PMU. Try reorganizing the group.
> > 
> > Now we disable the NMI watchdog message on hybrid, otherwise there
> > are too many false positives.
> > 
> > After:
> > 
> >    # ./perf stat true
> > 
> >     Performance counter stats for 'true':
> > 
> >                  0.79 msec task-clock                #    0.419 CPUs utilized
> >                     0      context-switches          #    0.000 /sec
> >                     0      cpu-migrations            #    0.000 /sec
> >                    48      page-faults               #   60.889 K/sec
> >               777,692      cpu_core/cycles/          #  986.519 M/sec
> >         <not counted>      cpu_atom/cycles/                                              (0.00%)
> >               669,147      cpu_core/instructions/    #  848.828 M/sec
> >         <not counted>      cpu_atom/instructions/                                        (0.00%)
> >               128,635      cpu_core/branches/        #  163.176 M/sec
> >         <not counted>      cpu_atom/branches/                                            (0.00%)
> >                 4,089      cpu_core/branch-misses/   #    5.187 M/sec
> >         <not counted>      cpu_atom/branch-misses/                                       (0.00%)
> > 
> >           0.001880649 seconds time elapsed
> > 
> >           0.001935000 seconds user
> >           0.000000000 seconds sys
> > 
> >    # ./perf stat -e '{cpu_atom/cycles/,msr/tsc/}' true
> > 
> >     Performance counter stats for 'true':
> > 
> >         <not counted>      cpu_atom/cycles/                                              (0.00%)
> >         <not counted>      msr/tsc/                                                      (0.00%)
> > 
> >           0.000963319 seconds time elapsed
> > 
> >           0.000999000 seconds user
> >           0.000000000 seconds sys
> > 
> > Signed-off-by: Jin Yao <yao.jin@linux.intel.com>
> > ---
> > v3:
> >   - Use evlist__has_hybrid() to check there is at least one hybrid
> >     event in evlist.
> > 
> > v2:
> >   - If the group was mixed with hybrid event and non-hybrid event,
> >     the NMI watchdog message was still reported. V2 adds checking
> >     for hybrid event mixed group.

Acked-by: Jiri Olsa <jolsa@redhat.com>

thanks,
jirka

> > 
> >   tools/perf/util/stat-display.c | 9 ++++++---
> >   1 file changed, 6 insertions(+), 3 deletions(-)
> > 
> > diff --git a/tools/perf/util/stat-display.c b/tools/perf/util/stat-display.c
> > index b759dfd633b4..55ae0d1705a9 100644
> > --- a/tools/perf/util/stat-display.c
> > +++ b/tools/perf/util/stat-display.c
> > @@ -19,6 +19,7 @@
> >   #include "util.h"
> >   #include "iostat.h"
> >   #include "pmu-hybrid.h"
> > +#include "evlist-hybrid.h"
> >   #define CNTR_NOT_SUPPORTED	"<not supported>"
> >   #define CNTR_NOT_COUNTED	"<not counted>"
> > @@ -465,9 +466,11 @@ static void printout(struct perf_stat_config *config, struct aggr_cpu_id id, int
> >   			config->csv_sep);
> >   		if (counter->supported) {
> > -			config->print_free_counters_hint = 1;
> > -			if (is_mixed_hw_group(counter))
> > -				config->print_mixed_hw_group_error = 1;
> > +			if (!evlist__has_hybrid(counter->evlist)) {
> > +				config->print_free_counters_hint = 1;
> > +				if (is_mixed_hw_group(counter))
> > +					config->print_mixed_hw_group_error = 1;
> > +			}
> >   		}
> >   		fprintf(config->output, "%-*s%s",
> > 
> 
> Any comments for v3?
> 
> Thanks
> Jin Yao
> 
> 

