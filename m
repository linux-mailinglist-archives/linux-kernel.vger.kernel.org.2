Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7FA893E982C
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Aug 2021 21:01:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231272AbhHKTBc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 11 Aug 2021 15:01:32 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:24465 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229802AbhHKTBb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Aug 2021 15:01:31 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1628708467;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=1unfFbOZLAIxVPI4mcVVIhRUq595frKfj6cy+G8EMzQ=;
        b=e1EKokdjI+1SzPw49xufjqUKYHCPSrNezYtSFfvKUtoGyW6+IfuULL273MZr2/dYoHKHcE
        4njbdkYTzzmKhXLArJNMHYB1ytVk2JyAtccklpakZU49vV4hvA6z3auWWF3bZWXryfmND0
        fU9l07ARbbQJICecAj2OJJPdpDKdzhA=
Received: from mail-ej1-f72.google.com (mail-ej1-f72.google.com
 [209.85.218.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-262-HYAChlFAPLSSRI4pB7-snQ-1; Wed, 11 Aug 2021 15:01:03 -0400
X-MC-Unique: HYAChlFAPLSSRI4pB7-snQ-1
Received: by mail-ej1-f72.google.com with SMTP id j10-20020a17090686cab02905b86933b59dso537925ejy.18
        for <Linux-kernel@vger.kernel.org>; Wed, 11 Aug 2021 12:01:03 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=1unfFbOZLAIxVPI4mcVVIhRUq595frKfj6cy+G8EMzQ=;
        b=MkeUImNuvcbgtwOiiWOM48mmRDRB0Aj2/14qsCjggbL470pvVxvijIrIqUpDU7ZyY2
         UOE90L9+ZKAGPmNUETli0jCrg6gZXd/PySszwjNXL7iWDKYPpUPoXYfQVDT4eSRIfHAP
         vLaMZ9Mu0NPL/lvEzjkcJah6rjWM1XsqkWri2MULhexuKajfHbo6UbOK9E9FC3CG+Wmq
         0Z96GsNBYBksxyVIJcC/22QKZ0oKr0fQb6QcYZiaYJO7Yc3rNpyoxgSSMMFxwMXr4Wq/
         qaaaP8NyH4rd1M+J4RPVVXs5PG9feOA/gk21Q4lIm6DuwFAkR9XTzRn/fPErJMZgunZ1
         wqEg==
X-Gm-Message-State: AOAM531Tned+xqGbQoz8ohX5qNuT2di85DT4AKLEFobNgT6Ey4sLgu/K
        HRDS7f/yXRUp3sjx4ahVF4xYXEywV3suoPBbzfDjtwDFFpQz08qRD5BWWpLtRGV0KdekQOomNne
        u0O6ECJYkchoTA2gFhx7aAKcD
X-Received: by 2002:a17:906:3c45:: with SMTP id i5mr3231ejg.336.1628708462476;
        Wed, 11 Aug 2021 12:01:02 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJxT3yECiOK8DRTNO1gNIEUJRuEfepqRl4VoWaBoHMA6ltlbpth3eFKdBD6qCLeLTooj+HJrYg==
X-Received: by 2002:a17:906:3c45:: with SMTP id i5mr3195ejg.336.1628708462158;
        Wed, 11 Aug 2021 12:01:02 -0700 (PDT)
Received: from krava ([83.240.61.5])
        by smtp.gmail.com with ESMTPSA id b3sm94293ejb.7.2021.08.11.12.01.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 11 Aug 2021 12:01:01 -0700 (PDT)
Date:   Wed, 11 Aug 2021 21:01:00 +0200
From:   Jiri Olsa <jolsa@redhat.com>
To:     Jin Yao <yao.jin@linux.intel.com>
Cc:     acme@kernel.org, jolsa@kernel.org, peterz@infradead.org,
        mingo@redhat.com, alexander.shishkin@linux.intel.com,
        Linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org,
        ak@linux.intel.com, kan.liang@intel.com, yao.jin@intel.com
Subject: Re: [PATCH v4 0/3] perf tool: Enable cpu list for hybrid
Message-ID: <YRQebER3uDUkJogC@krava>
References: <20210723063433.7318-1-yao.jin@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210723063433.7318-1-yao.jin@linux.intel.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jul 23, 2021 at 02:34:30PM +0800, Jin Yao wrote:
> The perf-record and perf-stat have supported the option '-C/--cpus'
> to count or collect only on the list of CPUs provided. This option
> needs to be supported for hybrid as well.
> 
> v4:
> ---
> Rename evlist__use_cpu_list to evlist__fix_hybrid_cpus
> Add comments to evlist__fix_hybrid_cpus.

Acked-by: Jiri Olsa <jolsa@redhat.com>

thanks,
jirka

> 
> v3:
> ---
> Rebase to latest perf/core branch.
> 
> v2:
> ---
> Automatically map to hybrid pmu.
> 
> For example,
> 
> If cpu0-7 are 'cpu_core' and cpu9-11 are 'cpu_atom',
> 
>   # perf stat -e cycles -C0,11 -- sleep 1
>   WARNING: use 0 in 'cpu_core' for 'cycles', skip other cpus in list.
>   WARNING: use 11 in 'cpu_atom' for 'cycles', skip other cpus in list.
> 
>    Performance counter stats for 'CPU(s) 0,11':
> 
>            1,914,704      cpu_core/cycles/
>            2,036,983      cpu_atom/cycles/
> 
>          1.005815641 seconds time elapsed
> 
> It automatically selects cpu0 for cpu_core/cycles/, selects cpu11 for
> cpu_atom/cycles/, also with some warnings output.
> 
> Jin Yao (3):
>   libperf: Add perf_cpu_map__default_new()
>   perf tools: Create hybrid flag in target
>   perf tools: Enable on a list of CPUs for hybrid
> 
>  tools/lib/perf/cpumap.c              |  5 ++
>  tools/lib/perf/include/perf/cpumap.h |  1 +
>  tools/perf/builtin-record.c          |  7 +++
>  tools/perf/builtin-stat.c            |  6 +++
>  tools/perf/util/evlist-hybrid.c      | 73 ++++++++++++++++++++++++++++
>  tools/perf/util/evlist-hybrid.h      |  1 +
>  tools/perf/util/evlist.c             |  3 +-
>  tools/perf/util/pmu.c                | 35 +++++++++++++
>  tools/perf/util/pmu.h                |  4 ++
>  tools/perf/util/target.h             |  1 +
>  10 files changed, 135 insertions(+), 1 deletion(-)
> 
> -- 
> 2.17.1
> 

