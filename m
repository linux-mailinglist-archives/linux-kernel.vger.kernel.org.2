Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 65BEF340881
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Mar 2021 16:13:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231669AbhCRPNH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 18 Mar 2021 11:13:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35736 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231273AbhCRPMu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 Mar 2021 11:12:50 -0400
Received: from mail-pf1-x435.google.com (mail-pf1-x435.google.com [IPv6:2607:f8b0:4864:20::435])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 41F23C06174A
        for <linux-kernel@vger.kernel.org>; Thu, 18 Mar 2021 08:12:50 -0700 (PDT)
Received: by mail-pf1-x435.google.com with SMTP id j25so3694378pfe.2
        for <linux-kernel@vger.kernel.org>; Thu, 18 Mar 2021 08:12:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=xQxB+0+KloH55JGcYtoM8guCUgiuva8xBf49F8LhTaA=;
        b=OSJRPfAdq+kam1GWPxJTNYTinxpOEpGtmQ3JbLORGlJ/4wTHz8b0YsEeECcx+W2KC0
         7+Ijv5LsOWjrg2oKChrYCruPaBjq9VH/Sl5pv/q1nP1Zg1SSR/+MRkXDxvwGpyogz65g
         usmNO8q7yBJwzEFukK6xVeUy6zIV1WlL79RdZZXbijBCJSIT7SDPpna7GVSrE4Nu41rT
         9QNvvEorKCOFjMxaKq5vMp3OHlylMhrcWrmTAHQewmQ5e+UlUdOH2K0RiMQr3ZsrzvNS
         sxjgOsPTE3rkuKoxPPBy35kZqqwz8MYBFRC8yfDVBIjObou8FvAmBHo5j6gTg0uVtizc
         +pLw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=xQxB+0+KloH55JGcYtoM8guCUgiuva8xBf49F8LhTaA=;
        b=Xit06lDyk9ArHqMFUm91FhIxTFfiyXkKvCbo0sk3fQA3bwITA5vQlbWgQWVOOwr7ED
         Qki28QVdynJ024ccsD5lbtbEXQoVHZqR3TbgusYxaL+sI1XVQZI5FKh0avwPceTBrrn3
         M2k/gVHrEnQNdiNIwBFgP9YTpoWoLzuk2LY2wBbqhtUcfYpXQR076JzO7ciqPWm7OERr
         oy6aZjd/DDFS0gwkz37Ct26zJMB0si6ZTufQzp8sgqflWOUXK87P3I0X/VQnSFElPImD
         pvJyavgXL05GWOE8g5Qc5b9OCT0/QQ6adYpgzym5qKXJMIhj5caA0UxNoRjD+MOKhG3r
         SZNw==
X-Gm-Message-State: AOAM531yz2dg/V8H/b3ixoNET2zb/AcfgqPI5KFeiVLoPG8F96OB3M/T
        roYubP6ZFs8mVhkFxBz4rRnrKPEPAnze4A==
X-Google-Smtp-Source: ABdhPJyMnrrEXS9yrTcYT88WJMuFc1vpRCpS8gdK2rSqNNmTt+Xh0vCr+KvY08X33OnGtYYNhxCnIw==
X-Received: by 2002:a63:ee4e:: with SMTP id n14mr7436023pgk.422.1616080369731;
        Thu, 18 Mar 2021 08:12:49 -0700 (PDT)
Received: from mail.google.com ([141.164.41.4])
        by smtp.gmail.com with ESMTPSA id s76sm2912197pfc.110.2021.03.18.08.12.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 18 Mar 2021 08:12:49 -0700 (PDT)
Date:   Thu, 18 Mar 2021 23:12:40 +0800
From:   Changbin Du <changbin.du@gmail.com>
To:     Jiri Olsa <jolsa@redhat.com>
Cc:     Changbin Du <changbin.du@gmail.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Namhyung Kim <namhyung@kernel.org>,
        linux-kernel@vger.kernel.org
Subject: Re: [RESEND PATCH v2] perf stat: improve readability of shadow stats
Message-ID: <20210318151240.ms4ic6xfa4xx7t2u@mail.google.com>
References: <20210315143047.3867-1-changbin.du@gmail.com>
 <YFC4ZTOhm61QWDgh@krava>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YFC4ZTOhm61QWDgh@krava>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Mar 16, 2021 at 02:53:41PM +0100, Jiri Olsa wrote:
> On Mon, Mar 15, 2021 at 10:30:47PM +0800, Changbin Du wrote:
> 
> SNIP
> 
> > diff --git a/tools/perf/util/stat-shadow.c b/tools/perf/util/stat-shadow.c
> > index 6ccf21a72f06..3f800e71126f 100644
> > --- a/tools/perf/util/stat-shadow.c
> > +++ b/tools/perf/util/stat-shadow.c
> > @@ -9,6 +9,7 @@
> >  #include "expr.h"
> >  #include "metricgroup.h"
> >  #include "cgroup.h"
> > +#include "units.h"
> >  #include <linux/zalloc.h>
> >  
> >  /*
> > @@ -1270,18 +1271,15 @@ void perf_stat__print_shadow_stats(struct perf_stat_config *config,
> >  		generic_metric(config, evsel->metric_expr, evsel->metric_events, NULL,
> >  				evsel->name, evsel->metric_name, NULL, 1, cpu, out, st);
> >  	} else if (runtime_stat_n(st, STAT_NSECS, cpu, &rsd) != 0) {
> > -		char unit = 'M';
> > -		char unit_buf[10];
> > +		char unit = ' ';
> > +		char unit_buf[10] = "/sec";
> >  
> >  		total = runtime_stat_avg(st, STAT_NSECS, cpu, &rsd);
> > -
> >  		if (total)
> > -			ratio = 1000.0 * avg / total;
> > -		if (ratio < 0.001) {
> > -			ratio *= 1000;
> > -			unit = 'K';
> > -		}
> > -		snprintf(unit_buf, sizeof(unit_buf), "%c/sec", unit);
> > +			ratio = convert_unit_double(1000000000.0 * avg / total, &unit);
> > +
> > +		if (unit != ' ')
> > +			snprintf(unit_buf, sizeof(unit_buf), "%c/sec", unit);
> >  		print_metric(config, ctxp, NULL, "%8.3f", unit_buf, ratio);
> 
> hum, does this still change the metric unit in the csv output? 'perf -a -x,'
>
The unit is changed in csv format, too. See below.

before:
$ sudo ./perf stat -a -x, -- sleep 1
8037.85,msec,cpu-clock,8037851596,100.00,7.999,CPUs utilized
714,,context-switches,8037838466,100.00,0.089,K/sec
11,,cpu-migrations,8037832590,100.00,0.001,K/sec
71,,page-faults,8037824974,100.00,0.009,K/sec
84033551,,cycles,8037750471,100.00,0.010,GHz
22563553,,instructions,8037733879,100.00,0.27,insn per cycle
4685736,,branches,8037708301,100.00,0.583,M/sec
356327,,branch-misses,8037667950,100.00,7.60,of all branches

after:
$ sudo ./perf stat -a -x, -- sleep 1
8026.19,msec,cpu-clock,8026194365,100.00,7.983,CPUs utilized
621,,context-switches,8026178186,100.00,77.372,/sec
16,,cpu-migrations,8026172135,100.00,1.993,/sec
73,,page-faults,8026142626,100.00,9.095,/sec
92645028,,cycles,8026066285,100.00,0.012,GHz
56268285,,instructions,8026048894,100.00,0.61,insn per cycle
10979859,,branches,8026022127,100.00,1.368,M/sec
441719,,branch-misses,8025981169,100.00,4.02,of all branches

But is this a real problem?

> jirka
> 
> >  	} else if (perf_stat_evsel__is(evsel, SMI_NUM)) {
> >  		print_smi_cost(config, cpu, out, st, &rsd);
> > diff --git a/tools/perf/util/units.c b/tools/perf/util/units.c
> > index a46762aec4c9..32c39cfe209b 100644
> > --- a/tools/perf/util/units.c
> > +++ b/tools/perf/util/units.c
> 
> SNIP
> 

-- 
Cheers,
Changbin Du
