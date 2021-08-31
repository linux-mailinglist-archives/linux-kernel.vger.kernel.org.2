Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D9EB23FCD0D
	for <lists+linux-kernel@lfdr.de>; Tue, 31 Aug 2021 20:47:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239141AbhHaSrV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 31 Aug 2021 14:47:21 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:30512 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229483AbhHaSrU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 31 Aug 2021 14:47:20 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1630435585;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=KFTC6adULqk7VN0qCgAsbieqFmciNW3ydRZqflVPMts=;
        b=TJycxKv2WZY4KN1N0CMt/HpAULPZST2RKizbBWRUlRl8xs5RLUaaVV7lIik5uwMQxrEL8g
        Lhcjv4Ay8IJVoPAiSdCalaav5f3E14AHeKsgLokIOvDK1ykKKmZVVbycIMOF6cOcf9o5Ul
        5p/9ZyKWht0nvy3R/gxXDB55TRcGhgY=
Received: from mail-ej1-f71.google.com (mail-ej1-f71.google.com
 [209.85.218.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-412-t1iCnmPvMgC0ePYrCcc7eg-1; Tue, 31 Aug 2021 14:46:23 -0400
X-MC-Unique: t1iCnmPvMgC0ePYrCcc7eg-1
Received: by mail-ej1-f71.google.com with SMTP id o14-20020a1709062e8e00b005d37183e041so153281eji.21
        for <linux-kernel@vger.kernel.org>; Tue, 31 Aug 2021 11:46:23 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=KFTC6adULqk7VN0qCgAsbieqFmciNW3ydRZqflVPMts=;
        b=sG/akpukQeWeeB9dzvc4a7Ry9WF6JU8EVnu2NXv0pOuYM8vG5lGe3Yv7v+15Fpe/w9
         7FWdO1sBxW3dk8thIDJ8WC2rsEHruejFe6ivpY+jPrVnSg1ePT2OH56Wht0mLd7Rm5nk
         itLPJ2wme9l1zIa2eyphNBwkkZu8CEuCUVahRg4vIvHDY8d82poH7GAzsFDu430hR2op
         mvR+nGW5TXC6m4MwcoOmEkoOMLl5oxuEEmGOZNS6QUGlTfO9o3gq8WN/6X7lXnDvtklD
         MQEp/jpKreYs3K2aoK4gCHuA5m5U4krEK2pU6D6737zZYLUzeI3U6uMii5hh+Ye/Yh5k
         QBzA==
X-Gm-Message-State: AOAM532A/JODnYL4A1o9vKAtF3ghZOPviBiZnDNoKFCaAFg7YByg3PwJ
        ixqPQu16melJMELhoPwsdYfpUD2ToxPTxkXgMNQfK5ZnAdnCeaezKHdFlttHTN1bvlMhqnYmnlk
        Y4sodITOPO0pabpZnxO0dd4aF
X-Received: by 2002:a17:906:11cc:: with SMTP id o12mr30580123eja.277.1630435582542;
        Tue, 31 Aug 2021 11:46:22 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJxwQDAVi2QgXcyDuwQXWHY9pp9GrWfMeCiqqRl8dCtXdHiNQV3cBFcP9rp5G8PhwWs6QJjOvw==
X-Received: by 2002:a17:906:11cc:: with SMTP id o12mr30580105eja.277.1630435582389;
        Tue, 31 Aug 2021 11:46:22 -0700 (PDT)
Received: from krava ([2a00:102a:4005:bb4:e4bf:9f13:dbe6:2d14])
        by smtp.gmail.com with ESMTPSA id q11sm9869708edv.73.2021.08.31.11.46.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 31 Aug 2021 11:46:21 -0700 (PDT)
Date:   Tue, 31 Aug 2021 20:46:19 +0200
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
Subject: Re: [RFC PATCH] perf test: Workload test of metric and metricgroups
Message-ID: <YS52wU9r9U/x4lkb@krava>
References: <20210819055629.1059168-1-irogers@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210819055629.1059168-1-irogers@google.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Aug 18, 2021 at 10:56:29PM -0700, Ian Rogers wrote:
> Test every metric and metricgroup with perf bench as a workload.
> 
> Signed-off-by: Ian Rogers <irogers@google.com>
> ---
>  tools/perf/tests/shell/stat_all_metricgroups.sh | 12 ++++++++++++
>  tools/perf/tests/shell/stat_all_metrics.sh      | 16 ++++++++++++++++
>  2 files changed, 28 insertions(+)
>  create mode 100755 tools/perf/tests/shell/stat_all_metricgroups.sh
>  create mode 100755 tools/perf/tests/shell/stat_all_metrics.sh
> 
> diff --git a/tools/perf/tests/shell/stat_all_metricgroups.sh b/tools/perf/tests/shell/stat_all_metricgroups.sh
> new file mode 100755
> index 000000000000..f0b7bda17970
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
> +  perf stat -M "$m" perf bench internals synthesize
> +done
> +
> +exit 0
> diff --git a/tools/perf/tests/shell/stat_all_metrics.sh b/tools/perf/tests/shell/stat_all_metrics.sh
> new file mode 100755
> index 000000000000..767396e81121
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
> +  result=$(perf stat -M "$m" perf bench internals synthesize)

good test, but takes forever.. running 'true' should be enough for the test?

jirka

> +  if [[ "$result" =~ "$m" ]]; then
> +    echo "Metric not printed: $m"
> +    exit 1
> +  fi
> +done
> +
> +exit 0
> -- 
> 2.33.0.rc1.237.g0d66db33f3-goog
> 

