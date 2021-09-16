Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1767240D3CB
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Sep 2021 09:30:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234817AbhIPHbm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 16 Sep 2021 03:31:42 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:20936 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S234765AbhIPHbl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Sep 2021 03:31:41 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1631777420;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=257yrPQS6KeYQm5bEFKU+lS9FYHPgLAN8rTbuc9lmLw=;
        b=WVAa48lu8UkOwHYJA7/o+QgiJWq5ImFe4YIfR4Gq5VZD9UuH9PFQ4EqGMOozfOqzC00b/5
        aYc6afE8Fck8CXEhB6f0cNJeLFCWlWxQpiMCtzfLaTz3+cFvKg6L5i0fjjf4sNZoNSBvta
        lCPfVICdzNqf8UOsfZ6cJORaNYXUfN0=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-575-pn8bfEwAN42L8fYGAxl0uA-1; Thu, 16 Sep 2021 03:30:18 -0400
X-MC-Unique: pn8bfEwAN42L8fYGAxl0uA-1
Received: by mail-wm1-f71.google.com with SMTP id w25-20020a1cf6190000b0290252505ddd56so2763238wmc.3
        for <linux-kernel@vger.kernel.org>; Thu, 16 Sep 2021 00:30:18 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=257yrPQS6KeYQm5bEFKU+lS9FYHPgLAN8rTbuc9lmLw=;
        b=Sg01rKtslWWRBxGgwAbdk2Tc+ICwH1x6PWVniaYYErYJGB9CLhtjz+9gnW7J2BSnC8
         zI6nvAVO8XHqqPopv8PEFN6Jzd+9U28gsbaYMW8QbJ1Oc02o9+LYxFoR2zhxdCG7r+6o
         S3whh+l/gNPq3rIuAWAFnhOzV5puULEoHjUdntd6gDCfuHnzzND4n7+88uTOHNeQuYao
         7HVSgWKxrcAusS1fwh6EDbsSVeEHYD4pomDcKcaUSTGl3Mb9ixoUSX0fyxt0jKgNzvl9
         dI51ZYI3OnYqMBCNXN8o26orsb5I2+DgbZZL1rZfKzPGciyzVXSIB42jEz/33pmT5gYQ
         DEcg==
X-Gm-Message-State: AOAM531rvLwoSsiwqCPUyekCmZrL7Yn6i5XvblpBVcCY6z6Nb+HTqDpv
        hvdGgcRz6gHmhjf9f0HL+vKLkUYrgsYRritc5Yc8CbUjL+ULBo4flyvoaQg7tHapVMjKvkC83vu
        PfsTGwtXM0d9G0F02Vjvfzqab
X-Received: by 2002:a1c:3bd7:: with SMTP id i206mr8431269wma.115.1631777417676;
        Thu, 16 Sep 2021 00:30:17 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJx/Q8RcskLaagNg4DGjNaPXj2RP+aICamk0pnhLgNm8IgTBGSH/sRpY2GxquQ5RQpePwlcc5A==
X-Received: by 2002:a1c:3bd7:: with SMTP id i206mr8431246wma.115.1631777417340;
        Thu, 16 Sep 2021 00:30:17 -0700 (PDT)
Received: from krava (nat-pool-brq-u.redhat.com. [213.175.37.12])
        by smtp.gmail.com with ESMTPSA id d2sm2371591wrc.32.2021.09.16.00.30.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 16 Sep 2021 00:30:17 -0700 (PDT)
Date:   Thu, 16 Sep 2021 09:30:15 +0200
From:   Jiri Olsa <jolsa@redhat.com>
To:     Ian Rogers <irogers@google.com>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Jin Yao <yao.jin@linux.intel.com>,
        linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org,
        eranian@google.com
Subject: Re: [PATCH v2] perf test: Workload test of metric and metricgroups
Message-ID: <YULyhx+ZxjEIOMsi@krava>
References: <20210916060525.1890638-1-irogers@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210916060525.1890638-1-irogers@google.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Sep 15, 2021 at 11:05:25PM -0700, Ian Rogers wrote:
> Test every metric and metricgroup with 'true' as a workload.
> 
> Signed-off-by: Ian Rogers <irogers@google.com>

Acked-by: Jiri Olsa <jolsa@redhat.com>

thanks,
jirka

> ---
>  tools/perf/tests/shell/stat_all_metricgroups.sh | 12 ++++++++++++
>  tools/perf/tests/shell/stat_all_metrics.sh      | 16 ++++++++++++++++
>  2 files changed, 28 insertions(+)
>  create mode 100755 tools/perf/tests/shell/stat_all_metricgroups.sh
>  create mode 100755 tools/perf/tests/shell/stat_all_metrics.sh
> 
> diff --git a/tools/perf/tests/shell/stat_all_metricgroups.sh b/tools/perf/tests/shell/stat_all_metricgroups.sh
> new file mode 100755
> index 000000000000..de24d374ce24
> --- /dev/null
> +++ b/tools/perf/tests/shell/stat_all_metricgroups.sh
> @@ -0,0 +1,12 @@
> +#!/bin/sh
> +# perf all metricgroups test
> +# SPDX-License-Identifier: GPL-2.0
> +
> +set -e
> +
> +for m in $(perf list --raw-dump metricgroups); do
> +  echo "Testing $m"
> +  perf stat -M "$m" true
> +done
> +
> +exit 0
> diff --git a/tools/perf/tests/shell/stat_all_metrics.sh b/tools/perf/tests/shell/stat_all_metrics.sh
> new file mode 100755
> index 000000000000..81b19ba27e68
> --- /dev/null
> +++ b/tools/perf/tests/shell/stat_all_metrics.sh
> @@ -0,0 +1,16 @@
> +#!/bin/sh
> +# perf all metrics test
> +# SPDX-License-Identifier: GPL-2.0
> +
> +set -e
> +
> +for m in `perf list --raw-dump metrics`; do
> +  echo "Testing $m"
> +  result=$(perf stat -M "$m" true)
> +  if [[ "$result" =~ "$m" ]]; then
> +    echo "Metric not printed: $m"
> +    exit 1
> +  fi
> +done
> +
> +exit 0
> -- 
> 2.33.0.309.g3052b89438-goog
> 

